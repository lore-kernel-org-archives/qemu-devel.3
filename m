Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF1CC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppqI-000175-UT; Wed, 05 Mar 2025 09:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tppq5-0000yH-OJ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:35:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tppq3-00088l-8I
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:35:13 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525AsZSw025365
 for <qemu-devel@nongnu.org>; Wed, 5 Mar 2025 14:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uOwe38oSSTMNopjp3mbuua1J8mGfnnOcpjMOrZywjt0=; b=FxkFgY99ozdJd2IY
 dazeKjZ/vjHseH0/2AgmNzBYCKyEgsP1IoFyYfNlWBt26P0Bm/gvP18Bz7UUwjxv
 lNs74GyG8C0bYirvzLDv3YdMk2kUdANPc4PuaNqa364VZx1fw/4N6fJfIbjkzoaB
 9C6qNjPqIhPwzWgM+yUB/wb3WOReWJctmUKD219Be3tSAeFJFiSqHQ43EB5NSmd/
 z51Yxz7lYjNbF8n3AfsgsH3P1RXsBhhoVVAK4oCRPEXV0DnID8rOvxafXeNAHDE2
 MHSbHzUEEhJzyPTI9exCPkYGzBcrWtqaaOakeM/kSzBmhubK0xNl/WLIKE3L2wKq
 Oq31PQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p935jwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 14:35:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-474fc025985so51769691cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 06:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741185306; x=1741790106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOwe38oSSTMNopjp3mbuua1J8mGfnnOcpjMOrZywjt0=;
 b=sy38kyzqaD4zJENlwP3hJpbxydAGxFx1T5EYXHe/1ENKFzfvK2Iow75tAE75X7ZBzC
 9rXAEAzZGK71ph0z3XnR5LYCmiIDJF8L9S9961mZe15QUhyGuEM7WNXB+YWlAryb7LnE
 R/nKocD1FETgZl1ALA82umKAlEGwzKzvJQZqQ8gy3xTXih+2rNXi1fW2IaOtdr+hSFRS
 QIRrYoRFT5On4VCJsNAEwNIo0Kgne9i3wOsW5uubhb6y8LAprVGEz0Sucr0BwHuebp48
 KrjIBsabwH7I3TFt4Qnh0+cTSaU9aqzxrwjfu0fDB8EDah3NcsaksfoH6cd2W2eLo/pw
 tHKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVPpZHhJrR8Kqht53uRUJ7uRp8dvphK80iKAej+s5IFR3M0n4S0XYM/SjpKScCzb6qzGMkCxdsP9gK@nongnu.org
X-Gm-Message-State: AOJu0YwGCvFKe8bw4QttYyw6LHX7YaQPYyWg1OJ17urXcOTATZiEHF05
 uqSxszdN2a7xw/bVjYDp/FTT5bXiygTCtntHZZGYA5kE6tAsep/Tc6UCGaEZENBC2eHsbaltsvp
 XHk02fHqoCrM/iPVNvhAAfsKkmfIQIGrqlMT8LkRqoj12zcICj15Ygw==
X-Gm-Gg: ASbGncvjGpiB/hIOMULzFxEn0jTHnVmuQKPgqRZ7Y51Xiyu4oqEyGpsJ29Xhnmo+KPp
 uo+OQ5T2X9BkitQAW19buXCqcbeocOvk8vFhi930ywqnWGx/ZakvzQAY+yBuc1CTWwUtojLaV2N
 KMvLO/zqMjyKaEfDGah6hKyiTBzn/61DtVzQcPQ1TS+1hzl6Pwb8zv3ahZ/B1CRR8EI46pk6Zmn
 ic75TmauAXwSwf7tDG+Maq7WJmoC6FZqJRY6ugykVDarptAZCRfGLU10kPV6xBPu8pLQLq3iWVD
 sT1RmtFIaO+vsXUvf110/LFOMVTgR0ypgWH81u+w0p3fxUwjvdHwNLZwqesWj8wqQUYM7e6z6Dw
 88epYzonbCalP+pOQ
X-Received: by 2002:ac8:7d56:0:b0:475:aef:3f9b with SMTP id
 d75a77b69052e-4750b4e6a53mr48873661cf.47.1741185306472; 
 Wed, 05 Mar 2025 06:35:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFADJaSXmjgW5GNws/uRvpNUuy42kNbdiORId47uVKtdlw5i+zU4kn6rpyn4yZMjQwprQZqFw==
X-Received: by 2002:ac8:7d56:0:b0:475:aef:3f9b with SMTP id
 d75a77b69052e-4750b4e6a53mr48872951cf.47.1741185305903; 
 Wed, 05 Mar 2025 06:35:05 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-475083eabcdsm15466771cf.13.2025.03.05.06.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 06:35:05 -0800 (PST)
Message-ID: <ed9c45e4-1c9f-406b-b5f6-ea6ab19de651@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 08:35:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] tests/functional: Add a hexagon minivm test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
 <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
 <3e35f453-926b-4eb6-a5ce-72f89c4f8375@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <3e35f453-926b-4eb6-a5ce-72f89c4f8375@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Me2Wu4/f c=1 sm=1 tr=0 ts=67c8611b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ch3z_QLeA-ZhuCZCqtAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VwgtDDtBohQFrFZwbJErMwZaXtjMcYjN
X-Proofpoint-ORIG-GUID: VwgtDDtBohQFrFZwbJErMwZaXtjMcYjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/5/2025 2:05 AM, Thomas Huth wrote:
> On 04/03/2025 16.46, Philippe Mathieu-Daudé wrote:
>> Hi Brian,
>>
>> On 1/3/25 18:20, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>
>> A bit opaque...
>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   MAINTAINERS                             |  1 +
>>>   tests/functional/meson.build            |  8 +++++
>>>   tests/functional/test_hexagon_minivm.py | 42 
>>> +++++++++++++++++++++++++
>>>   3 files changed, 51 insertions(+)
>>>   create mode 100755 tests/functional/test_hexagon_minivm.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index deeb7878c8..48a5e7c005 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -247,6 +247,7 @@ F: gdb-xml/hexagon*.xml
>>>   F: docs/system/target-hexagon.rst
>>>   F: docs/devel/hexagon-sys.rst
>>>   F: docs/devel/hexagon-l2vic.rst
>>> +F: tests/functional/test_hexagon_minivm.py
>>>   T: git https://github.com/quic/qemu.git hex-next
>>>   Hexagon idef-parser
>>> diff --git a/tests/functional/meson.build 
>>> b/tests/functional/meson.build
>>> index 111d8bab26..78b42e58f9 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -135,6 +135,14 @@ tests_i386_system_quick = [
>>>     'migration',
>>>   ]
>>> +test_timeouts += {
>>> +  'hexagon_minivm': 180,
>>> +}
>>> +
>>> +tests_hexagon_system_quick = [
>>> +  'hexagon_minivm',
>>> +]
>>> +
>>>   tests_i386_system_thorough = [
>>>     'i386_tuxrun',
>>>   ]
>>> diff --git a/tests/functional/test_hexagon_minivm.py 
>>> b/tests/functional/ test_hexagon_minivm.py
>>> new file mode 100755
>>> index 0000000000..2ba92bcce3
>>> --- /dev/null
>>> +++ b/tests/functional/test_hexagon_minivm.py
>>> @@ -0,0 +1,42 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All 
>>> Rights Reserved.
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import os
>>> +from glob import glob
>>> +from qemu_test import QemuSystemTest, Asset
>>> +from qemu_test import wait_for_console_pattern
>>> +
>>> +class MiniVMTest(QemuSystemTest):
>>> +
>>> +    timeout = 180
>>> +    GUEST_ENTRY = 0xc0000000
>>> +
>>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>>> +    ASSET_TARBALL = \
>>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>>> + 'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
>
> Tests that download assets should go into the "thorough" category, not 
> into the quick one, so please replace tests_hexagon_system_quick with 
> tests_hexagon_system_thorough in the meson.build file.
>
> (yes, I know, it's a little bit confusing that tests that finish 
> quickly should still go into the thorough category instead ... but we 
> needed a way to distinguish the tests that download assets and the 
> ones that can run without downloads, see also the description in 
> docs/devel/testing/functional.rst)


Thanks -- I'll fix this.


>
>  Thomas
>

