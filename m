Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB498CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkTN-0000Sh-Jv; Tue, 13 Oct 2026 17:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkTA-0000Rf-LE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:55:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkT8-0005Pv-UX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:55:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DJa4Eo1999279
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pWJv7dJFgzc7mBvxINDO2MOkLhzy1ibVPTtisRrQV74=; b=gsNmBCuMxfJCjFL4
 4+AolqF5VhefOZYEyo7PDhWwDcWMgLRAOSrsoYItEs+Y5VitsUbMN0j0XsTT/XiB
 j38u+3LUvEZ9VjxmScdj7zVjKG2nsezNEhUROnXiiIMJWWeGXS5L/4Yjmdu0Owvf
 DYTHyl0PrHjJwekS8DjIOwPIzXC/GNuBfZZevvjrUfibJAHsGDUgdQfKIEWl44AZ
 gE0uVIWsk5BQz/PRbNAlOaa3nZOheVxnCIW+WM9yNgXmAvcfXoc7e9ybtkjxlMqU
 sRmwjeAkQ6NSJKFHnzXbL12siEjpwoeKqzeBwur2Z5fPkRMophcKqElblQ8NA+/k
 1PL9eQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f62c1hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:55:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso7758325eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791928531; x=1792533331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pWJv7dJFgzc7mBvxINDO2MOkLhzy1ibVPTtisRrQV74=;
 b=kkxXtB7V6oX8+bCEw6ilb1JZx3FAF/FMAUunt/kaMz41bjMf4M4sFzq5YaazsKWHvO
 xVvuwETh9vJfHVjXSr8RLZgGaDEXF8uw9XA7Yg5wDww9XtawjsOyxlxeWx7tOlMGoGsx
 1zb7jQYauobRKBc5fwh4iWv3GrIdNDK3aY40cq5h5gFpXTbmzpJkDlVvp1E9/Q6VWdhl
 DWRBYHW+pFSB38QgHy6W7/dczk9eQKJThtZ3ydEX3oD98T0hpWmj4gB/ApyyFr/NQp0B
 oxwowEtuvokfXijMKpgH2SdMRht4nSwKnKuWz/aviL7GGohsQhGecMje+lhs/mYnTUv9
 N3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928531; x=1792533331;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pWJv7dJFgzc7mBvxINDO2MOkLhzy1ibVPTtisRrQV74=;
 b=w0KN1PN1WZZKKso+Bfcb0b5i4ZUigvEoEzxdLHeE1AdDSSHDDcTu1FFJ/oiki5UDZ3
 CnzQpEfY4zKRFSKkkytSbKjdG7SE5C7OGZVBOeOpUtU7mqYcQyI7xMLfhBQTo5p4NFOf
 kugHf3tuK5gyZ35GS/Zo+iwR/cYMyf8m03YXn2R2IupMFfiyzWTTI33fCh0PDu0Q4hyy
 N4Su0rtzl+V+owdeh0B14GePZVxLo5Gkda/ljF2fCmJFIoXoDcRxsApFaoztoyyC8gao
 srnwY9HLNs0w4fADmejDFZ39s7MCqrSic/lqXC3pUigl78AVkC51o0ljXMZYL60Lx4+a
 7qUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJqP3tRgQfpji6uBdqMUSud3RQ3kh/padNRlkj+/dCAvqBZCfZF77A+XHSrBPYQTZ57kUHwXzGouWe@nongnu.org
X-Gm-Message-State: AFq9FYKw2GrgWfVrZd+YXV2/kI8uJSg3yBFJBJHUHtko+Qrh9NwDPlJf
 uruH1n+NDbUHQ9inbdm0Q6Akk/9XvkB5Cr2YhW4U51Sy8hNO7payTerhDVWgEUULYNceWV6DBpg
 suCPFOuye7q/3ddSXXnjgc1BRKqOEeCD1DzEgXIu+vBkLvv94ycWMUJe+1w==
X-Gm-Gg: AYBFou2BeEDwR6MH9GSjQTSNQAr8PuHYlcKecEnDa1nbRZLLnCMKBazOgHmHvqWYjtc
 eqCNLvEPIOiNp1nxL1wNmxPzK36TIbeJ8sINVwXHKslncb+v3ohFmG4jFXHlnM36pau9fj9MZ5j
 eUW2I6jSGGkRRBefO0wl8cM8eeVzBzysJppcvnvoR4n3Y4UBMiVPpBIyduRWNm23i5hY5lUwCPL
 GiSQWk5+ePeHCAfeptZ6Bm6pMUv/I297ImLNzsTe4s7ysR8U4yb2suGRyTH3XArjo0oMfAAXmPi
 aO29LKpemTcnCRrOC0jnxPxIxyxJWLjV0BKAtU3FD9SIJKVBk8syUgDDSNlEbey/acTvTv6lSnn
 IVfQsGQ6hDzCMVGO4a+8vx7panDarcKlbobTDR90RMNEt29YxPe0AX1ghV8+GmUktm+6VQw==
X-Received: by 2002:a05:701b:454b:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-16a5dcf59b8mr17982718c88.15.1791928530561; 
 Tue, 13 Oct 2026 14:55:30 -0700 (PDT)
X-Received: by 2002:a05:701b:454b:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-16a5dcf59b8mr17982684c88.15.1791928529912; 
 Tue, 13 Oct 2026 14:55:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a6021e49sm42052378c88.20.2026.10.13.14.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:55:29 -0700 (PDT)
Message-ID: <c788ccde-7e96-48f1-8bd8-74e773db5e85@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:55:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/hexagon: add MiniVM, lock tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009192541.4163758-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acea8d3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=zh3yzbqNYqj4k7z0ADEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX/Dh+pT8e4UxP
 1K18vemxyGguFFLgOLxfwyA+MXltT/CU6XZY74ibU5xgf45DkPKFNw5bA6G9B85Yj+g1fKrLDOi
 wPngegXiwViH0CP2tkDMQ9RePp81U5k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX0O0l/RIGwSrC
 IxKMkQa6UQFxhs4mF38/OO/XRMoHW0i1xLQZoy0gZSUga20cVBJQN9MDp+tkKnlIWxnS2+BHigy
 JJ0+3IKeknAOqYkPVSQB9ILMQvPYjT7Skj5XVnQLNM52dXfJC9+hWyDO6aC+ZqCKXLuYlIQELuV
 i+jj/rMppKydQ87td0vuh7H8sAtn6CxQH+WPS+Y7rQfqtImQqd7D55DqaOZFHHen+ftVYk/vzVJ
 uKCW+2v/u/bp9GQJgm+F659+L7z0IvRTfL3Uz1dUuf6CvkRHocdXdkFyUYwA5uzyOBV5mpb7iIL
 WloF0fD8bW6usI+pji0woAQdLZ44N+6JDBFmFVkTiKxQeN1ECuKucwAsOnAlrXx9kLvugncvXdm
 BbRjRXLfz8OE13qW3EhiDFgPwmoF2TDdI1rmNfNwNNUw8rl46ENmbwGTfqRJXmV97rV8YrSdQKI
 nZEv+w4lm1VLkBPgnvw==
X-Proofpoint-GUID: UmwxG15AlYtW_JiY0Lr03cUeHyywvIvt
X-Proofpoint-ORIG-GUID: UmwxG15AlYtW_JiY0Lr03cUeHyywvIvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/9/2026 12:25 PM, Brian Cain wrote:
> Add the lock_verify test case to verify the k0/tlblock behavior, add the
> minivm tests to cover start() and more.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/meson.build      |  1 +
>  tests/functional/hexagon/test_minivm.py   | 43 +++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  3 ++
>  3 files changed, 47 insertions(+)
>  create mode 100755 tests/functional/hexagon/test_minivm.py
> 
> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
> index 44053e64676..e182bc98a06 100644
> --- a/tests/functional/hexagon/meson.build
> +++ b/tests/functional/hexagon/meson.build
> @@ -3,6 +3,7 @@
>  tests_hexagon_system_thorough = [
>    'arch_tests',
>    'systests',
> +  'minivm',
>  ]
>  
>  test_hexagon_timeouts = {
> diff --git a/tests/functional/hexagon/test_minivm.py b/tests/functional/hexagon/test_minivm.py
> new file mode 100755
> index 00000000000..a70edbcc987
> --- /dev/null
> +++ b/tests/functional/hexagon/test_minivm.py
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset, skipBigDataTest
> +
> +class MiniVMTest(QemuSystemTest):
> +    '''
> +    minivm is a Hexagon hypervisor that implements the Hexagon VM
> +    specification.  These test cases boot minivm and then load test cases
> +    to the address specified by MiniVMTest.GUEST_ENTRY and
> +    execute a minvm-guest program to exercise minivm virtualization
> +    features.
> +    '''
> +    timeout = 180
> +    GUEST_ENTRY = 0xc0000000
> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
> +    ASSET_TARBALL = \
> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
> +        'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
> +
> +    @skipBigDataTest()
> +    def test_minivm(self):
> +        self.set_machine('sim')
> +        self.archive_extract(self.ASSET_TARBALL)
> +        rootfs_path = self.scratch_file('hexagon-unknown-linux-musl-rootfs')
> +        kernel_path = f'{rootfs_path}/boot/minivm'
> +
> +        for test_case in ('test_mmu', 'test_interrupts', 'test_processors'):
> +            with self.subTest(test_case=test_case):
> +                vm = self.get_vm(name=test_case)
> +                vm.add_args('-kernel', kernel_path, '-device',
> +                            f'loader,addr={hex(self.GUEST_ENTRY)},'
> +                            f'file={rootfs_path}/boot/{test_case}')
> +                vm.launch()
> +                vm.wait()
> +                self.assertEqual(vm.exitcode(), 0)
> +

In case we decide to extend that with many other sub testcases, it could
be useful to define real sub tests. Just a suggestion though, it's not
necessary for the only 3 tests we have at the moment.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

