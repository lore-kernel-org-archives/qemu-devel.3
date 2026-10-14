Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85F3CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2eJ-0007H7-PL; Wed, 14 Oct 2026 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2eD-0007GN-Hb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:20:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2eB-0004Rz-G9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:20:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJfG3642820
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZRlVrLvXYVKyABglb+yQjh4xo39wgbhXa4QG6/xR0iI=; b=OsGPodH/oSuq6xtp
 uv3JcpyXP6/55MKy+wlimcLxV2min6TUZsCGCjizz5lHrUjtfceAGyQcZL87LVcH
 3oAJFHzTA1DGL1Va4fQ97BCVSAk/3yjYn8nVxI+acT2cVtMkLx7bCCuaib1c1Jgk
 Dv0zYorrLXSQH2XamgBzyzPM8JTEAj85fFDh93oQsckmRqXA01ahlhzO+F1F3X3K
 Oxu0xKebBZC1F3AjU43PqHxaDFxpjXwXqkn/U/7Vy+FtNPIYHNtaURUnwP8Pv2aE
 Sle8lj3YmbssSxOZ1mi9ARhZK4mgo6ySZIMsR9KDIPvdBnerMEeojM/YfRy0xK8t
 bCJHfQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470aq1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:20:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so5113470eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791998409; x=1792603209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZRlVrLvXYVKyABglb+yQjh4xo39wgbhXa4QG6/xR0iI=;
 b=K2/wq1P/erpY8nqAa+u2bIsf6MWoN92hYNxIYbXNCfOqdHuG9MEtP+0IPIlvsGMbcp
 wM38w5fX6T/wwFQ61GrB+VTnqTeYOPT5eOWtAIDs5M9LM6tPhJhT+H5nGzHbzh1gZ/vm
 hKKImTb3Br7pnN6jSEJVhINgPbXBYTFUxZp3fExZ+vRy7PYkOitWDFVizAp4hOEqOGnQ
 AmR3J0IwebQNrnR7DRHpdqG+Dvbf7Kixb1/a50QeR+UpGBcFLDa4WTlWp34YgWeZ4Pon
 E2OaB7xxnmVvW8QXHg0YpKziyOGDP++kdsrUgyDjSuKOCOKDla0XkdsMfE1ZriW1kzGr
 TZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998409; x=1792603209;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZRlVrLvXYVKyABglb+yQjh4xo39wgbhXa4QG6/xR0iI=;
 b=DWPsjEFXroP/yT/U3Ll9AZeKl0i9pKZQV6UG9+gzyztZgvQAHnv70C4Mev90UNCpYS
 2DWYSQP3/rt5EA0aSwdkLvv3IrXp1weVaHjV6qM5wg0vQdUGuPZBjDrYDZ5bwvZCqGL7
 WdjmEzfXsPPqv2B0Ug40Kikc+BrYA/wIoXVaJsafXjFwu/jh99CH3wKyQA+gIra8H6VE
 sgre/c3TiVyTnNb00d2w9UMiu7+Q3PFeqwkHAbVvDjblyNzq4xYqDnluAWo7n9dZ1mEi
 YQfzjP+Vv50/Tyt1t55Xwg0yjsKxscUOxkdMyc4/qMliEM3x8a8zbxEB5GU4OQc2k8Rj
 cdIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfd61kew6+uAjUIu9axZjuE6J1bNHSKlVr4FL48f7vQM3Z8en8ZNBFxK9YfUqqCRGOgHLUJgZXcjEj@nongnu.org
X-Gm-Message-State: AFq9FYJg2Q6f9GDgk8f1W1sPJyYUDoHBbSJV+j9jkuBca+SdGOch7f9S
 DEJnV4XU+R0H7niVtmYPWIfZU87AIYCF0stuR3/lRbGacqkM+UbLRo36RqTdKONtydupLkqYXZh
 qIzKkOU6Hxxkc3yE7EqEAnegc+NO2XERa0ScEa8uMsFC+YX48npOHNTtbig==
X-Gm-Gg: AYBFou1Rig7rpEgNcMdN5Kyuk8k6R2F+SjCHIcJ/2lUZEj3Ftx4Uo4nUWTRHGH2UATI
 erpCeKqE2ent+XtHrydEOInJTtsYYZ2q8xZmm5G9jFBOtU3mPMgF9reQbIBH03k8fftF7prT/ue
 7KuDskdYtUtiSQPbdwPlz98z5JjruCTpmzAuzNWYkwyn57fbC7H9O6sblZ3rfrL5fwa0eH7DO7M
 +6ynbkzORJdKk3qt+AOxdu6QECaw/5SbPhoNIBEydtPK38WtRuru6Fyz9bFw/e+YzN8z8wKsOZR
 0kpDOiZ6neW4hPN3apcxpJ4NEpOuS1c270dvMZtErHfK9tqgCta/Rs83e95P8rxk7R9dUl0399z
 XOhFolmZCIDsBPuyTQUlgaGd+d9oLHZORdPw/h2BKrxT2xa2ncMO2+wnmNIwEwyd2MB4luQ==
X-Received: by 2002:a05:7301:140b:b0:352:4f11:8118 with SMTP id
 5a478bee46e88-3537e08c6camr22880371eec.40.1791998409054; 
 Wed, 14 Oct 2026 10:20:09 -0700 (PDT)
X-Received: by 2002:a05:7301:140b:b0:352:4f11:8118 with SMTP id
 5a478bee46e88-3537e08c6camr22880207eec.40.1791998406355; 
 Wed, 14 Oct 2026 10:20:06 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm53206251eec.13.2026.10.14.10.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:20:05 -0700 (PDT)
Message-ID: <64126dd3-2fb3-489c-8248-c25d5661c47f@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:20:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/functional/hexagon: add MiniVM, lock tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
 <20261014165837.2916482-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014165837.2916482-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfX4eUjfBSpqfWx
 4OGXPPsTrd4HQ0OpAZg5LtynpBsqzeaSmNNvZOQwGroFqmXYfi9ou4+vVHV3bPdyB/tuIn2R21t
 qr70y+M6cYvAvXFcqSSto/If4DqxqfciCyN0iCps6k6lpyDA2JEuuyxiRBWYL7ZlK+LNOzwDq3v
 960Sl9qtDEbJTFVvasw9+MamjpJmfxzUTCEsHnoyO5xKfIhvYu2W9WnNDY9mruss+EN5KFgyLAS
 yDLVMVcvecR2qn2BAo3NBEQhAUfkISafu7oCAZ3FLiCDT8KorFXCidkvJM1yQXLEjHMcD9KZrkw
 /H1SSDmzT2dqHCsj5x0O3oh+I9wap0kMmZPAbGEsmsfYmqNWu5ZnEGBrO9RoO/Je0Dixsfaylvn
 9yRqDfm/W9bHhXG3CobxvACZgpQrHIFGhZvGKE9/YuE8ym4dc1J98Qo28eGixKl1NTH/e5YP3CX
 mTUB9cgAq/K34c4jT8Q==
X-Proofpoint-GUID: RD71rNobibQ04gz_S1-ZXAfBQsHgqrUb
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfb9ca cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=duJEyJhO88ytUESx_wwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: RD71rNobibQ04gz_S1-ZXAfBQsHgqrUb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfX65aRJB9p3Ufm
 iaONaiSUPbeEhlFFRjiaqmCzUzkgqnYw5LyXgQiLmN/ck49Qyr0Po7y8JS4Ph+ib2VFzZ6/nLw6
 Wp5zzGZoUvD7BbjlErBQ5/PHKs/r1J0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140069
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

On 10/14/2026 9:58 AM, Brian Cain wrote:
> Add the lock_verify test case to verify the k0/tlblock behavior, add the
> minivm tests to cover start() and more.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/meson.build      |  1 +
>  tests/functional/hexagon/test_minivm.py   | 48 +++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  3 ++
>  3 files changed, 52 insertions(+)
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
> index 00000000000..115f3cf3710
> --- /dev/null
> +++ b/tests/functional/hexagon/test_minivm.py
> @@ -0,0 +1,48 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset
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
> +    ASSET_TARBALL = Asset(
> +        'https://github.com/qualcomm/qemu-hexagon-testing/releases/'
> +        'download/v0.2.21/hexagon_minivm.tar.gz',
> +        '5980740c5fa505f55cacd1646088831202df4ccbf9e2ddc34b690673574169ba')
> +
> +    def run_minivm_test(self, test_case):
> +        self.set_machine('sim')
> +        self.archive_extract(self.ASSET_TARBALL)
> +        rootfs_path = self.scratch_file('hexagon-unknown-linux-musl-rootfs')
> +        kernel_path = f'{rootfs_path}/boot/minivm'
> +
> +        vm = self.get_vm(name=test_case)
> +        vm.add_args('-kernel', kernel_path, '-device',
> +                    f'loader,addr={hex(self.GUEST_ENTRY)},'
> +                    f'file={rootfs_path}/boot/{test_case}')
> +        vm.launch()
> +        vm.wait()
> +        self.assertEqual(vm.exitcode(), 0)
> +
> +    def test_mmu(self):
> +        self.run_minivm_test('test_mmu')
> +
> +    def test_interrupts(self):
> +        self.run_minivm_test('test_interrupts')
> +
> +    def test_processors(self):
> +        self.run_minivm_test('test_processors')
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
> index 20c58f84f67..0489db0af91 100755
> --- a/tests/functional/hexagon/test_systests.py
> +++ b/tests/functional/hexagon/test_systests.py
> @@ -108,5 +108,8 @@ def test_hvx_multi(self):
>      def test_standalone_vec(self):
>          self.run_exit_zero("standalone_vec")
>  
> +    def test_lock_verify(self):
> +        self.run_exit_zero("lock_verify")
> +
>  if __name__ == "__main__":
>      QemuSystemTest.main()

Looks good now, that's a great size reduction indeed!

Regards,
Pierrick

