Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3AECC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGn5C-00062v-3B; Tue, 13 Oct 2026 20:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGn59-00062b-Uo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:42:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGn58-0003K3-2Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:42:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHur5s1125206
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rz4AJ44EvDSSQXvQDoGEL1/vYZ4iSUJ+niu92w/CzK8=; b=WyQcK3XtOirxE52C
 DBdzj0yGUKkfAv6cZlHfa4Q6BsLiJ6W9+A2zPv/id2z0HhHgOcreom8zafRddkle
 U9HxzQWpi88+tY2Ra9xS8x/3neW/lR8Oa79Um0UWE58fauEocoP96xy7g9LPO+p1
 DPukSjTyAvZZrQMwMNA4s5/6EEgJ44Cj/mfrNRiXwidOMzFYPmSAz6RCU6ejytLz
 SiNxkckjkW8vb9OgYgv6YN0KdsVqLCkXP4ACyzC3UhNOQBTkWb3xaFkeAu8ayKIw
 g7YaR7BhbAUAXg0SbcUB7S31Q0h0PP6MVG/MboS54oQiGU9NtbxcNH3OfpM4jk/s
 Ebebhg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sg81emv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:42:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso5372642eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791938575; x=1792543375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rz4AJ44EvDSSQXvQDoGEL1/vYZ4iSUJ+niu92w/CzK8=;
 b=AIyPsyl6dv5y80ehnmdp/vJT8lfKCJAR/XQkWD1D7nUK0Jg2fBt5NDywVVKbSCH+Hb
 PSGPyYif8KOcmvQOHnD3Chg7bM7PCWcrlG6IPwxGl9woE1YZRdNKVxahEDe+ghPm8gZh
 36AbSuUk5sCyj58AykFl0jyLHV7e2AdUObvB0MWT5O4CCXWfbEvUdO7fD7Z7SgPUNzgc
 z1Jn3lG6XbNEX/SvQRKnx5TAoteOb5jKJnZgGUgfBS387dN4JLpbpXinlxtqgi+2QtLo
 Ox+PiDUIwrNs3I8Ohu4IXyCQGVzWp0licOLIee50SsJI5JcW/CbKHXLHtoJRMrjtp0lz
 hw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791938575; x=1792543375;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rz4AJ44EvDSSQXvQDoGEL1/vYZ4iSUJ+niu92w/CzK8=;
 b=uAicralbYpFczKWyaAB3HFNfKdTsbGh4AxtAouTmhwAa8/pWx2D6qYAqJJSM4AzQ0o
 XHMMcJQT3SM6IuH3A200nzpy3Bs7K6iGzH5y+vWvJQkwKLetrjtfM840moAWLqBMtayn
 b1KBTBOxDXre1oVmc4Hb09lgI8pIzdLwVwS6KUvilj8J4lto3W4IsbzyHLH7ZjgGiXLh
 JgMjNK50v5oz4GHwW5g1zFZYdsWDIpWmvbpEXoEVfq1+H4zB9p6139fPUsQnkgkT8HpK
 HCnouqsD2dvXWigref7x1PEWucDBR8JMCf37K6uHqVpqrMa8ckbNcMZJArb2LxDZelKq
 bEIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxF01c3WCDJTAOi0EWPWu8Qt8vxPClt3CPxo+E7/R7eAI/54NxDfKfUXGl2qgyN4TmojH8eBSdB73mr@nongnu.org
X-Gm-Message-State: AFq9FYKan3Gaws3BUD36hCXs4Nib52mJQ3A42IyDNHcDCCjgmM+nPQr/
 aRDsMZ60uzyznqsBeaV+jcXzUD34DcYM5sh9Bk9ndrV24N/r6uTW79FnUv+k2QQIwH8u2yFTZLj
 GIDzMseBCcQaYfJjiE2KwQWoRmwAhngkxEaxLHKlmta+tbak+npgM3ujDKQ==
X-Gm-Gg: AYBFou0zTfeTPFMx0+vqj4tTOZ8neGvzbl+w/gEhu8tFXEz8cIiySXZxov4+AADNtfs
 fdMptY5i2y1fYxbvhnpCO+VgYVNU6dPoISWa+TqCudpPjkvg4TsNrS+RQEx3mEQ0Ca5IMEM5XZT
 NZOP9RGeePiWKsoktOqFejBruV0CkK305f35cd285RwlyAlazC4CL55+HgFLc9CaWJD5fjfx+KR
 g7wdQQDBQLdBaCXMpVuXu+UvFj7mdzZZMRiTkSE5rgpKX9o77sN8PMQwdD5YaJx6ev9bR/LZG99
 MaL3C/JRd8hYrz/kJI64CDYAUkbw1bm0cDW7uWeBVgUrjlqA77xu1t8i5mU1HmVlKgdHbEas136
 6pT5wn9bjBPaWmQoD+1UmT7EnRoR2JSTOTSAfVUFMx6bUxRulU8F4uRlQgZmdtdSiWqZmqg==
X-Received: by 2002:a05:7301:1603:b0:351:1e89:66ab with SMTP id
 5a478bee46e88-3537e03cdcamr19629361eec.7.1791938574366; 
 Tue, 13 Oct 2026 17:42:54 -0700 (PDT)
X-Received: by 2002:a05:7301:1603:b0:351:1e89:66ab with SMTP id
 5a478bee46e88-3537e03cdcamr19629332eec.7.1791938573636; 
 Tue, 13 Oct 2026 17:42:53 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm48465035eec.26.2026.10.13.17.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 17:42:53 -0700 (PDT)
Message-ID: <606fbcd9-9e34-4344-93a7-3590e392da64@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 17:42:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/hexagon: add MiniVM, lock tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-7-brian.cain@oss.qualcomm.com>
 <c788ccde-7e96-48f1-8bd8-74e773db5e85@oss.qualcomm.com>
 <c4909309-faaf-4b22-8554-92f8757d132c@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c4909309-faaf-4b22-8554-92f8757d132c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pWhpyGreYWd7KEXOzmvZ8_v0O7r7muXm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMSBTYWx0ZWRfXwwsrZ5qSBslv
 IIAQexnuzBcqUBrM9vNhWyRMhCCLbgLmdpzAh/OZUm3b8loXIxSdhGONG4VJlH1u5CMuduKEkcB
 08+NyqiZkN3UXRGEn6YL4s3cw3fhRAY=
X-Proofpoint-ORIG-GUID: pWhpyGreYWd7KEXOzmvZ8_v0O7r7muXm
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6aced00f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=9GabHVxce4OOJEnDWn0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMSBTYWx0ZWRfX5M7i9cmA6A/H
 a4MEiUYkDiiF7BAetK57CrW+8vmWhaThmHNIUzkigvccjBtoEbQ8s3rRXb0IEvp1vHEvftQkCzI
 wRkq1HYqlm/eL0qhFDfmJkWqGJwEHA47LlUkOKkCy6Au30mOSEL6EiVdPg0WUfWN89V6HE0oAQE
 7VQDQLlm2Y6ur51RKqetjiaUCVyWWtcvoQltqfUtGnuUso03XDMZkmiAuG+XFzVGydOqj+n8/ML
 mJvFVMVPLzQ9hbRXwnSsYInBG06+O21cRHGNqHaAVG7DKQ/jiB6OZPbe0sbxHTwBqqk1KRaTsYK
 a8xH3BDWtAi3+0HauGQXS7hV0guoNCVpu7DdYL3zjRO/AFG/bDKj06RZhZR2Ajp9+jQgzOjZuq4
 4O5o9nLkLl4SXY613E2DbHTuvOk/ox3QFNMhsc77eyfzLsUZtH08RPUp6viFRTfe94YzIgBeAM4
 Jvde5LSJtjx36Wrd4ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/13/2026 5:24 PM, Brian Cain wrote:
> 
> On 10/13/2026 4:55 PM, Pierrick Bouvier wrote:
>> On 10/9/2026 12:25 PM, Brian Cain wrote:
>>> Add the lock_verify test case to verify the k0/tlblock behavior, add the
>>> minivm tests to cover start() and more.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   tests/functional/hexagon/meson.build      |  1 +
>>>   tests/functional/hexagon/test_minivm.py   | 43 +++++++++++++++++++++++
>>>   tests/functional/hexagon/test_systests.py |  3 ++
>>>   3 files changed, 47 insertions(+)
>>>   create mode 100755 tests/functional/hexagon/test_minivm.py
>>>
>>> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/
>>> hexagon/meson.build
>>> index 44053e64676..e182bc98a06 100644
>>> --- a/tests/functional/hexagon/meson.build
>>> +++ b/tests/functional/hexagon/meson.build
>>> @@ -3,6 +3,7 @@
>>>   tests_hexagon_system_thorough = [
>>>     'arch_tests',
>>>     'systests',
>>> +  'minivm',
>>>   ]
>>>     test_hexagon_timeouts = {
>>> diff --git a/tests/functional/hexagon/test_minivm.py b/tests/
>>> functional/hexagon/test_minivm.py
>>> new file mode 100755
>>> index 00000000000..a70edbcc987
>>> --- /dev/null
>>> +++ b/tests/functional/hexagon/test_minivm.py
>>> @@ -0,0 +1,43 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights
>>> Reserved.
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +from qemu_test import QemuSystemTest, Asset, skipBigDataTest
>>> +
>>> +class MiniVMTest(QemuSystemTest):
>>> +    '''
>>> +    minivm is a Hexagon hypervisor that implements the Hexagon VM
>>> +    specification.  These test cases boot minivm and then load test
>>> cases
>>> +    to the address specified by MiniVMTest.GUEST_ENTRY and
>>> +    execute a minvm-guest program to exercise minivm virtualization
>>> +    features.
>>> +    '''
>>> +    timeout = 180
>>> +    GUEST_ENTRY = 0xc0000000
>>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>>> +    ASSET_TARBALL = \
>>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>>> +       
>>> 'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
>>> +
>>> +    @skipBigDataTest()
>>> +    def test_minivm(self):
>>> +        self.set_machine('sim')
>>> +        self.archive_extract(self.ASSET_TARBALL)
>>> +        rootfs_path = self.scratch_file('hexagon-unknown-linux-musl-
>>> rootfs')
>>> +        kernel_path = f'{rootfs_path}/boot/minivm'
>>> +
>>> +        for test_case in ('test_mmu', 'test_interrupts',
>>> 'test_processors'):
>>> +            with self.subTest(test_case=test_case):
>>> +                vm = self.get_vm(name=test_case)
>>> +                vm.add_args('-kernel', kernel_path, '-device',
>>> +                            f'loader,addr={hex(self.GUEST_ENTRY)},'
>>> +                            f'file={rootfs_path}/boot/{test_case}')
>>> +                vm.launch()
>>> +                vm.wait()
>>> +                self.assertEqual(vm.exitcode(), 0)
>>> +
>> In case we decide to extend that with many other sub testcases, it could
>> be useful to define real sub tests. Just a suggestion though, it's not
>> necessary for the only 3 tests we have at the moment.
> 
> OBTW confession time - the subTest() was merely hackery because the
> tarball includes a large-ish filesystem.  It was a sparse file before
> archive+compression but effectively now it's dense.  I just did this to
> avoid the time spent extracting for each test.  The extraction time
> dominates the test duration.
> 
> So maybe there's a better approach to consider w/o subTest()?
>

After checking it's indeed a bit slow.
Would that be possible to reduce test_mmu (culprit, 2.5GB) image size to
something under 100MB?

Beyond time, it would save disk space also.

Regards,
Pierrick

