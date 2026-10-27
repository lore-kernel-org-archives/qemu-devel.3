Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ce7wnE5E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kN4HX3Jd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLYov-0001R5-MT; Tue, 27 Oct 2026 00:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLYor-0001Ql-Or
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:29:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLYop-0005d4-VH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:29:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F9GO322716
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pwkh0pBSXdBMeJMAABSXYhtFOPbmBBSjbu8SNQX+TfA=; b=ce7wnE5E5sZdEbmp
 ZVAqWQBEUla6f6mEQDbR80KqVgNGGz2LsjWsUFhaBlM2ZepqsrvS8roBQdvMpzZW
 dTsHof0NZ87q4dAYJUeP/0ZI7oSR+2ppWjYvcjP1PGj8iJdmi6R/2EheSXWxwWFx
 rE6X2YiTOCqrMD/Wt0cbq9vsNJJhTN0N3hNdrUWqjS6+MLEV+/k3iFaaTPrzQHPK
 YxumvxTa0aCLI2tEXYVaFgj/CO2OFBYlJfIOZR0LsYBx9SN5tTTtJlVwOIsGm6+p
 kpyCCL/8z+TvNNV7P9bs3CJuHRyHrqWkM4diPtMhNqdIJFoE5EjYnjP9VC7MMCba
 e5depQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm9v9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:29:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so717625985a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793075388; x=1793680188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pwkh0pBSXdBMeJMAABSXYhtFOPbmBBSjbu8SNQX+TfA=;
 b=kN4HX3Jd5OKEcW3Gct2Z5S+ZVkuPcOiU3Ja/SjvDnyhl0tf9SnhlNU1BOXVhFRMbHf
 lSiSUHh3+5HPTZUOqKv+pUxXydoXYkeZGBusomjh/VoV0gLpH8CrITmX3n2jamRK8bWq
 Q1h5Q4ScGde5h8PTQxFV/QiiH2blNWsDCInv5hFIZ4aIBT8qP92ETo7cA8FmXDP3yl5B
 H3eTubQrGm+OXgDmsssGsm0hmD/EI9DyjMzlruoBuyvhrZkH9hDybI07ZLw/Tlb1bvd2
 5gkSYRzHMhsLY9rM7wGgI+0024OQKZPOWWWFtGdgi+QC7lq6bcbTqeLPA6RG5qQQoIXb
 vz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793075388; x=1793680188;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pwkh0pBSXdBMeJMAABSXYhtFOPbmBBSjbu8SNQX+TfA=;
 b=Uq+hu4j4ZdUze2/C2lVBUp+0rMCdbAoIl6cJ06FAFqyTC0C8Pmgi0o1JexZilRRJIm
 drmyUv6IVNmlx5unaanWOcDWulk6TgwvsUuT3iFVlryLmWjU0WipPUrNFLISCt3meoZy
 S+Efqtxx994Sxmyl3kr6vSXkIEImZ/ZQmw4fikR8oefGudrrulHtKItJci4vHP0b3JRM
 WKqULYazdImuMhJ419PsExczn2oS7iY6qvjRLo+FtCfzlNlV1TZUVjOiqf72WyUPoPbl
 kpJy6S3IpxELr8TJrJ7puc/EET9SUdoKG0XQLpx03vkWk8bBaQFvmvGxRKGr8/uu0RmH
 ViAg==
X-Forwarded-Encrypted: i=1;
 AKwUvByLos4gVtqFr91bTsTDJMdI/5I7e5wyisSYgCb8N+t95PRR9G7vxQNfK33EcAJy8+uV/TKV6TnpxmzD@nongnu.org
X-Gm-Message-State: AFq9FYKHyvwyv3erXLzFsILNzaFqGHY0o0TQFv2ptlxuCaVIa9zfe6ji
 ILI9ljeeecKzs+LDo6J20uu0YP7kAtvlj5f2yOH5DTm+cwpwq9Sph43wJbfvaVU03bG2xUIZ4JB
 UGEvy6sqk3qNHNMA2HgAUqC1msfJ7yKKoUlgsbfklVS4cvg3lTXzv2oH/pg==
X-Gm-Gg: AYBFou1vdc1g3O1ImkbxHc2C7bz9gja+yX3mq7tVZvEirBZFDAVwAKfmWAJ69qRqMgf
 WrWThQpHQdGl0Akc7d065FHHSEBPQsxSzu9xVcNnBGf2mZXHduMhO/xgCttwLzMXWFbhaJi0T0E
 gE6N0EAgITqxjIzj5dzbANIn4YBXhsnX7WdPQDhxyett9EJgkgVu1cgxq7M4QNKKViAt95bAsXF
 iqIYna8IyNPOdVGdBbicvkZvHqfE9CHP5voWn0yqI4Ga+QUuObqoGCMr79iIMSjQiAEz+CCxX6/
 Jb5ziZTv0KLGuL2Wyufjb3ofBn5bLoiITE230ErHknwWtMuHjRrH8g66ieP0896Poq6xfd8YrD8
 tm0nqBactSx2i0/cMREws1xmqHTR2keirbA==
X-Received: by 2002:a05:620a:6f05:b0:93c:c162:125b with SMTP id
 af79cd13be357-940ef931614mr1332551185a.39.1793075387703; 
 Mon, 26 Oct 2026 21:29:47 -0700 (PDT)
X-Received: by 2002:a05:620a:6f05:b0:93c:c162:125b with SMTP id
 af79cd13be357-940ef931614mr1332549185a.39.1793075387276; 
 Mon, 26 Oct 2026 21:29:47 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bac37sm255294635e9.6.2026.10.26.21.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 21:29:46 -0700 (PDT)
Message-ID: <64a45237-3f0b-4eeb-b2d4-cc1c90024526@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 05:29:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
 <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
 <9ee17c2e-5f47-40be-8741-cda9390c1e04@oss.qualcomm.com>
 <66ae1e1c-edba-450d-9fb1-9ad8cf710dd0@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <66ae1e1c-edba-450d-9fb1-9ad8cf710dd0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxNyBTYWx0ZWRfX/dhpZh0SYADD
 7E3Pm9MHssqHc4cpAU7sYxPUhwpa3hGfrvMjzjZwr4tq0YI+XESGVYXTMKUWiMc1OpOA84ZjreH
 HtiR4OYvSvdqHNfzxB00SkkmWeVKziw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxNyBTYWx0ZWRfXwblx2vvkKXTM
 dLEHNkvznLW3SQDzeuch9gBak9IrlsDLHjIesJW0L0jyay8Pv8iWAiRy/9wB4yY8zgJMwtbiSTC
 JnpgZ9hVNh+dgewW3hjlYuzaH1849YpZcM1GB4lPEqB/9o4V9kMqxJwm2MiYBbBdKMqeGCQHLGZ
 CfSOp6ffYF6TwA3PYr8EwQBjVMBxJ2AN8T8n1aNkOrWhBIR89SMmMdoPfTD7fE3SVx7NbfN+FZ+
 hE9Nmn/y5Z10aet4fmAYUJ4KZLTISDMzrwyO6E40F09Mj4d9AVJO/30eOhrQWoeU6OoR7JimaMY
 jaQKUAcAVdy+N3zoc0gOP1w+4R++5DTfNjmC4OiQX6hZeS0w67wsumq1HjZtkpMIPdG0G7IG7Ht
 YzI7iZTy35EshkV8SN47sdPht4r8lo46Ne8QYqBMR7w1PfkdnPgYgwzXKc5KqX/6h9817oEa4LG
 2tC0bjsJeIERPszi9vg==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae028bc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=eGUulr5lkOI5qTkqquoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: SHUj4pbghnvNKBtp0du334sLSMbUz1c4
X-Proofpoint-GUID: SHUj4pbghnvNKBtp0du334sLSMbUz1c4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270017
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26 17:22, Brian Cain wrote:
> 
> On 10/19/2026 8:51 AM, Brian Cain wrote:
>>
>> On 10/19/2026 8:47 AM, Philippe Mathieu-Daudé wrote:
>>> On 19/10/26 07:52, Brian Cain wrote:
>>>> Download the firmware and run it on the corresponding DSP machine.
>>>>
>>>> The images are third-party binaries, so the tests run only when 
>>>> untrusted
>>>> code is allowed.
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>   tests/functional/hexagon/meson.build          |  2 +
>>>>   .../hexagon/test_qcom_dsp_firmware.py         | 89 +++++++++++++++ 
>>>> ++++
>>>>   2 files changed, 91 insertions(+)
>>>>   create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py
>>>
>>>
>>>> diff --git a/tests/functional/hexagon/test_qcom_dsp_firmware.py b/ 
>>>> tests/functional/hexagon/test_qcom_dsp_firmware.py
>>>> new file mode 100755
>>>> index 00000000000..86a0628d9f3
>>>> --- /dev/null
>>>> +++ b/tests/functional/hexagon/test_qcom_dsp_firmware.py
>>>> @@ -0,0 +1,89 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Boot the production DSP firmware on the Qualcomm DSP machines
>>>> +#
>>>> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +from qemu_test import QemuSystemTest, Asset, skipUntrustedTest
>>>> +from qemu_test import wait_for_console_pattern
>>>> +
>>>> +
>>>> +class QcomDspFirmwareTest(QemuSystemTest):
>>>> +    """Base class: the firmware is the ELF that -kernel starts 
>>>> running."""
>>>> +
>>>> +    REPO = 'https://gitlab.com/kernel-firmware/linux-firmware/-/ 
>>>> raw/' \
>>>> +           'd947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom'
>>>
>>> 404: Page not found
>>
>>
>> Huh.  Maybe I picked a funny commit and somehow the asset cache fooled 
>> me?  Will take a closer look.
> 
> Disregard: all is well.  A "wget" of one of these assets works for me. 
> If I paste the URL into chrome, it downloads the asset.
> 
> But if I browse to https://gitlab.com/kernel-firmware/linux-firmware/-/ 
> raw/d947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom I do get a 404.  I 
> think this is the expected behavior, though. That "raw" mode for the URL 
> expects a path to a file object that git could serve up.
> 
> If you browse to https://gitlab.com/kernel-firmware/linux-firmware/-/ 
> tree/d947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom you can see the 
> directory listing that you might have expected.

Oops sorry, I indeed checked a wrong URL 🤦🏼‍♂️

> If you apply these 
> changes to master I would expect `check-functional` will download and 
> run them (w/the untrusted code bit set).
> 
> The sha in the URL is inconvenient and unclear so in v2 I will switch to 
> a recent tag instead.
> 
> 
>>
>>
>> -Brian
> 


