Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E140CA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGq3J-000760-OS; Tue, 13 Oct 2026 23:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGq3I-00075r-Ci
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:53:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGq3F-0002so-8N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:53:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DJWCCO442750
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CfLI2ucZQp4tOjfAHdZmOaoFc/JNWav2kL+pui0KCjQ=; b=Uw7gzoOr6+DrHgIw
 YATBZr/al07MHrNeTGtRMRGAWyIGlVGdK4Aa9tX5AW/T65c0mV5yR95Myqt+CFWr
 PKxsl8hk5ZCGi3gUdrzspQaRfsxlAjNkgd+dn87BSmRL9Wn6DHKVZPCGJpyCx3PM
 NKvmBOti2w7CdZjNy5fm1v+KtmlIx9bENTtq20JXttYJz3zP3oaYenFu5jHJ/iBp
 tWeeQgKQthy7TG2BgxV1WrLGYbZ6hBGRbA6FYOHovEhsEJ3F0uarNw0A+yw8huS7
 6+7q9Fee5iX6DyCTpAuEBZijpnv9lwWiLmOig4ovt/smF3GZZSIFmvuXu02oTq1+
 imYOBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71kdc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:53:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so840458685a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791949991; x=1792554791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CfLI2ucZQp4tOjfAHdZmOaoFc/JNWav2kL+pui0KCjQ=;
 b=ALKSNxrm3fQp0K47xHv3l3QOF70MOIE/CI9BfHwiKptTAHkRy9rWjV+GVbWJGI9N7c
 hPOz3MubkVecLJEr0Iy8ZAmmb9CsELVPWnpA64vPgEz/rJOMQL/H/IH2LG9B2XyW6FxF
 HbO7P2DO3HM0Gdts28dcv/5Yi5YzKqNwhg2vJLMvR7LBW/YiuTf6qJB6Q0Ce+M2M+zpz
 cHe7lTQXmo99fDNEpsuElxTW7q16hrJYrmDsYcoB5gKykvjfaZa+ZMRmpgXNq3+H9ztW
 ruUrYoAxNcjUrnQr5Xl8UNVjMZ77/34jvIE03jeBUu9c6hhXbvb6Y6YSdEZCteL69OGZ
 Xxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949991; x=1792554791;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CfLI2ucZQp4tOjfAHdZmOaoFc/JNWav2kL+pui0KCjQ=;
 b=thr7grnROKOI02aR9bIsxIuFSlJ4kiRsRynt4XPY0UJqzaLgGqCp5D2rUC0pfZz1nb
 qz1IEQ1yxmYRod8BcHD4K4+DEXLvNYOPvI/T8Zn8beBwhiLbqhXgWD1Ts7rwNP5ShArE
 bkAtAQ/KmjesK1on6FeFjtVKCxNbWeRWZpJouaQcQ3cCmCqjauqVg9Ab43BTaEIUhYbo
 2OA8nawaJLjNKHIakBNAxjq3lp2uXAA/fOe46hfH6JZ+qkE69u5j4Q/ENU1D3SreE+SJ
 vypcJty3Crbr9l08B7wup0E4lnQNoJM0OHSk+dih9zpiT2Pnd8ump+PtfTqee+P4Vmdk
 M+qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxANFRnNYRQ3690V1QTJ5h6vKzFQ1CydsY2JVd7T1nlYjvKGDSh7caJpp/PICAXn8VktvqHrCKJzQ8s@nongnu.org
X-Gm-Message-State: AFq9FYKfmZG+mylg6BihylQsdrCzyG6rlHj+i0y/IKFbe82tFEWtpay7
 O8EbBfmaZigZz+2SIJSypJjmxePS9xz4hE4pZ0k2RmMjqi69yDrDD3mvk0o+qz6t5PBCb6qIs4T
 T7i2wytoMwUs29r+kqdqu9BJGqnIYVF4WRYYd73axHOhDJnAaF+1cRd6hTg==
X-Gm-Gg: AYBFou07ssnZR6ENqo4Wg3y7m5SLZL+raqHR8Y50l/LUPnQEXzasEY5Ma5ALs5byYfi
 TPZpTtFdrTnuZYEzdy1yutlxtcWgoE3gN9oKoUUFfdBDkWOAqdJFOoQ3Cesmbv3v8xGryP4PUG1
 zjSK08Fyu6yxzQcDBSL6GWvNpU1ioXL/2hitjx4K28J+aNUESdG3p+jLF/BkzGHIb7p9mDrgyjE
 IKQmIXA2Vr/k6ZB5sLcqDCHxM9e6xhI+rR0K0x3EDiwozC+TsCYLBUlqnkr46dkQBSCrr0jf6xW
 ll/iL3YP/AhMcEUl7+rkg+gtlBUDKCpwcqTf25t+TBvqzEeYVYHP63nzF/hyt4of8PMfN/jN20v
 GFbW1CQiNSiLXehXAypg241OHtODZxMK7L5k0CtdCltcb12H5ZyaH2JcDFLKyf34EyVwYRDxxC+
 ZNnDg=
X-Received: by 2002:a05:620a:4489:b0:93c:5c60:c3a6 with SMTP id
 af79cd13be357-93ebd2a6dbamr2411204385a.66.1791949990770; 
 Tue, 13 Oct 2026 20:53:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4489:b0:93c:5c60:c3a6 with SMTP id
 af79cd13be357-93ebd2a6dbamr2411202785a.66.1791949990245; 
 Tue, 13 Oct 2026 20:53:10 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5042696sm405194985a.26.2026.10.13.20.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 20:53:09 -0700 (PDT)
Message-ID: <2a4aa0ac-bb1d-4196-9e53-f1c79b309a95@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 22:53:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/hexagon: add MiniVM, lock tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-7-brian.cain@oss.qualcomm.com>
 <c788ccde-7e96-48f1-8bd8-74e773db5e85@oss.qualcomm.com>
 <c4909309-faaf-4b22-8554-92f8757d132c@oss.qualcomm.com>
 <606fbcd9-9e34-4344-93a7-3590e392da64@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <606fbcd9-9e34-4344-93a7-3590e392da64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6acefca7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=f9SgpVA45t80_lO34RkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: uQ7IX_xNVQyyvTrFwD88WBAd4dyMvNga
X-Proofpoint-ORIG-GUID: uQ7IX_xNVQyyvTrFwD88WBAd4dyMvNga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNSBTYWx0ZWRfXy+VqHGStbJYz
 dvAeQXkXCGXKuviQOFlwIKD6KN5PE5ZeV7bJ3v65pMVg5V7v05Mx2xmRm4aIi7bxg0y5F3lSp8j
 odbMIVFh2gd22dOeuo0GwzdCshlnKexv/G7NKGwNNvP7fJUySjZmOd6y52r/dt2AVHeldKEk+z2
 Oytx0OfqimMyBuHhAxLhG0Dx04gbm8K0C3I8YKZqL2Ha0H9rFNYPvySY4W/VahpWpBm6glIHEZa
 1cosTvuzx/gywfxFbK7NmjmAJrRz5ntpkzu8xyb1szX5h/xx+A3iwOvAdfYgg+pVWtG55B5qXDr
 Q57aWa4+4CTDDGg1JXweysw4f7WIL6OHt+c8BOUkHnA+5bw8vJhGNrf0yWkWzy/hFlWb4qrOuzZ
 NDsezAGXW+YOLB///30SYOW1xyKcPYYKXNSb0HNOc0ExRJwPrUUziz2BL+CsNDBvm0PM70Wk3Bx
 jEIZo/O5UD4XhNZ9bLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNSBTYWx0ZWRfXwRlenxVD7KzV
 lGYE2HwX2H8aMhQbl3mGyuoM22sPZriXUjEK+uuY4JK8dExpYhWDGi26woAH0XqRRfi4/mGVjOx
 cbgHeHApXwz+24FULz72F+ZehdR/19s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140015
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/13/2026 7:42 PM, Pierrick Bouvier wrote:
> On 10/13/2026 5:24 PM, Brian Cain wrote:
>> On 10/13/2026 4:55 PM, Pierrick Bouvier wrote:
>>> On 10/9/2026 12:25 PM, Brian Cain wrote:
>>>> Add the lock_verify test case to verify the k0/tlblock behavior, add the
>>>> minivm tests to cover start() and more.
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    tests/functional/hexagon/meson.build      |  1 +
>>>>    tests/functional/hexagon/test_minivm.py   | 43 +++++++++++++++++++++++
>>>>    tests/functional/hexagon/test_systests.py |  3 ++
>>>>    3 files changed, 47 insertions(+)
>>>>    create mode 100755 tests/functional/hexagon/test_minivm.py
>>>>
>>>> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/
>>>> hexagon/meson.build
>>>> index 44053e64676..e182bc98a06 100644
>>>> --- a/tests/functional/hexagon/meson.build
>>>> +++ b/tests/functional/hexagon/meson.build
>>>> @@ -3,6 +3,7 @@
>>>>    tests_hexagon_system_thorough = [
>>>>      'arch_tests',
>>>>      'systests',
>>>> +  'minivm',
>>>>    ]
>>>>      test_hexagon_timeouts = {
>>>> diff --git a/tests/functional/hexagon/test_minivm.py b/tests/
>>>> functional/hexagon/test_minivm.py
>>>> new file mode 100755
>>>> index 00000000000..a70edbcc987
>>>> --- /dev/null
>>>> +++ b/tests/functional/hexagon/test_minivm.py
>>>> @@ -0,0 +1,43 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights
>>>> Reserved.
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +from qemu_test import QemuSystemTest, Asset, skipBigDataTest
>>>> +
>>>> +class MiniVMTest(QemuSystemTest):
>>>> +    '''
>>>> +    minivm is a Hexagon hypervisor that implements the Hexagon VM
>>>> +    specification.  These test cases boot minivm and then load test
>>>> cases
>>>> +    to the address specified by MiniVMTest.GUEST_ENTRY and
>>>> +    execute a minvm-guest program to exercise minivm virtualization
>>>> +    features.
>>>> +    '''
>>>> +    timeout = 180
>>>> +    GUEST_ENTRY = 0xc0000000
>>>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>>>> +    ASSET_TARBALL = \
>>>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>>>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>>>> +
>>>> 'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
>>>> +
>>>> +    @skipBigDataTest()
>>>> +    def test_minivm(self):
>>>> +        self.set_machine('sim')
>>>> +        self.archive_extract(self.ASSET_TARBALL)
>>>> +        rootfs_path = self.scratch_file('hexagon-unknown-linux-musl-
>>>> rootfs')
>>>> +        kernel_path = f'{rootfs_path}/boot/minivm'
>>>> +
>>>> +        for test_case in ('test_mmu', 'test_interrupts',
>>>> 'test_processors'):
>>>> +            with self.subTest(test_case=test_case):
>>>> +                vm = self.get_vm(name=test_case)
>>>> +                vm.add_args('-kernel', kernel_path, '-device',
>>>> +                            f'loader,addr={hex(self.GUEST_ENTRY)},'
>>>> +                            f'file={rootfs_path}/boot/{test_case}')
>>>> +                vm.launch()
>>>> +                vm.wait()
>>>> +                self.assertEqual(vm.exitcode(), 0)
>>>> +
>>> In case we decide to extend that with many other sub testcases, it could
>>> be useful to define real sub tests. Just a suggestion though, it's not
>>> necessary for the only 3 tests we have at the moment.
>> OBTW confession time - the subTest() was merely hackery because the
>> tarball includes a large-ish filesystem.  It was a sparse file before
>> archive+compression but effectively now it's dense.  I just did this to
>> avoid the time spent extracting for each test.  The extraction time
>> dominates the test duration.
>>
>> So maybe there's a better approach to consider w/o subTest()?
>>
> After checking it's indeed a bit slow.
> Would that be possible to reduce test_mmu (culprit, 2.5GB) image size to
> something under 100MB?
>
> Beyond time, it would save disk space also.


Ok - I'll see about that.


>
> Regards,
> Pierrick

