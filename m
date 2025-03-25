Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2447FC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 03:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twuiw-0008CZ-UK; Mon, 24 Mar 2025 23:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1twuio-0008Bj-CA
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 23:13:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1twuik-0001Sb-1Z
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 23:12:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OIjKOn030755
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 03:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n/fmoKRO2wa2rYwTqKTIx8JVIbaYZrnCKRv2xQEDKes=; b=IzEa2Ewt1zqtZ5eC
 ZnQ7BRIz+IzLZC/ujv5eeQ2zbUjCicEJSBSon5r32Tz1Xq9DmfO5BLelTfWUBr8f
 b/Cki0wETTZDQ04ER3vru+Yy00MGbttY1fxkpWIKsK6uhwqvzMGUpTZeLHjBNswZ
 NLYNdzq8JO2lRrSxh5jToTqRfxDmektg5GGmL9SszlJoj/JidSABMv9tkXv6EFMf
 HCj8k26aNcjfEckOJu3V5Hp2CVir/L0AIt3EhL1TQvLRlvSoxSeY/UiUzpFfxvP5
 4Q7skRCruttPhVgL5ENs8fwHPBGX+GOLmU/RcVYT9P05x0huDP9QrZ9vVdH1EQOz
 FTZlFA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmt068r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 03:12:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2242f3fd213so80018235ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 20:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742872369; x=1743477169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/fmoKRO2wa2rYwTqKTIx8JVIbaYZrnCKRv2xQEDKes=;
 b=d1SndxFZIBnkQjENXfMw6Sgx7f8Ro0tSRmVoSON5om2oeU3qsEHqtXo319CYsg3poF
 aJTZafFdeBdzMFY1NORXKzf6JXmoNi1W6iGCxNEyoKwfyOw1pMn8i1GttimvzdszPPPP
 CradM0Ns+dZOXyBesj22zWX0RJMtwHz33IN2/xA3FnyYnsLTx0Kwq28rylqnDe9c58dG
 CKPX+2gXxEm4ep92fkMUPCIN0LCjOTsDr+uZ4GtnSb8UGlcqq0qYW0ZrWPx6O5LVXwpA
 zRzvdBA06v2rs+oeCc492zl6jMrQ1kT5ZHIy/s1q+MmN/Tcu24TSBVrqktmbwLXwnJ+Z
 IAYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMyw5Hb9lyELgyOR45n8So5c4YHz88bk09VHrCcpoX6lhRqPESlXbp21hWPWetzREuXc5nH9KjqPqZ@nongnu.org
X-Gm-Message-State: AOJu0Yzb2h+YV2C2TxIPO5Y0yAvw5QTlrrrfrAfDg1k8Bb5dQZB3aO6H
 k0K4MVr2WtZoTd/rcTczrcHQ+D7AI1JcwX7CMhek9tfwQd+z3lox5ODV/DOf77eNd2pjrgYdGiz
 kwKDVwhfvQMNpIabHc/c/TLtzyeoA2ujRiY/z6Ngiur9IZuyKwylFLQ==
X-Gm-Gg: ASbGnctklGzPoLQ+sihZajheP1oQyO5m7Bt5Cl/9OQx9bEHbYSNWfPkGPGKvHECshxp
 qxgFYwQdgNvFa2mbWe26eAixNugZ79MtAF25EWxsuedmFlBdVRe9qqAcew30H9CY6H3Cuh8udmC
 2GDuXaKbVgUKRX7ZYLNZYeg+Mf3X/OA1bJ1FNe90UKWt2cCEWP7agQ0q2nGsX7lTpoWQBUcQGOu
 ctz6UUlvQIowflDEQXAEacig5VK9Py3aH0WenODZpd2pE7Tlexb9+wYw/48QRk9izCjfDFqdxNL
 zH/Hjtf0rfGGF0JGRO2DQWL7R0Z/ZaV1qpxeB3GzNEMtswqeO4efYrgNDpM2wf37oK9tc/hKMRn
 tGO6klITuF8jZbgmW
X-Received: by 2002:a05:6a00:84c:b0:736:621d:fd32 with SMTP id
 d2e1a72fcca58-73905a23312mr22071549b3a.22.1742872369218; 
 Mon, 24 Mar 2025 20:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIUDeKcBdTCaZiqBRmTOdTUPknJjLkEvDsbQ7sKXSgMyAQ8rGvwdeuGjBXNqsi7tARagUO7A==
X-Received: by 2002:a05:6a00:84c:b0:736:621d:fd32 with SMTP id
 d2e1a72fcca58-73905a23312mr22071511b3a.22.1742872368619; 
 Mon, 24 Mar 2025 20:12:48 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739060085b5sm8891425b3a.73.2025.03.24.20.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 20:12:48 -0700 (PDT)
Message-ID: <e02be58e-9459-4799-8725-c7831169c89a@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 22:12:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
To: ltaylorsimpson@gmail.com, 'Anton Johansson' <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20250312194547.7364-1-anjo@rev.ng>
 <20250312194547.7364-3-anjo@rev.ng>
 <001501db9d28$affce200$0ff6a600$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <001501db9d28$affce200$0ff6a600$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v0o0L9R52viAxPJd7zxQBBpG48InyHnC
X-Proofpoint-ORIG-GUID: v0o0L9R52viAxPJd7zxQBBpG48InyHnC
X-Authority-Analysis: v=2.4 cv=aqGyCTZV c=1 sm=1 tr=0 ts=67e21f32 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=7w2_MBhos4imgj-Oe9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=980 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 3/24/2025 8:53 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Anton Johansson <anjo@rev.ng>
>> Sent: Wednesday, March 12, 2025 2:46 PM
>> To: qemu-devel@nongnu.org
>> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; brian.cain@oss.qualcomm.com;
>> philmd@linaro.org
>> Subject: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
>>
>> The indent command is not available on a default mac osx setup with xcode
>> cli tools installed.  While it does make idef-parser generated code nicer
> to
>> debug, it's not crucial and can be dropped.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   target/hexagon/meson.build | 21 ++-------------------
>>   1 file changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>> index abcf00ca1f..246dc7b241 100644
>> --- a/target/hexagon/meson.build
>> +++ b/target/hexagon/meson.build
>> @@ -323,30 +323,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in
>> target_dirs
>>           command: [idef_parser, '@INPUT@', '@OUTPUT0@', '@OUTPUT1@',
>> '@OUTPUT2@']
>>       )
>>
>> -    indent = find_program('indent', required: false)
>> -    if indent.found()
>> -        idef_generated_tcg_c = custom_target(
>> -            'indent',
>> -            input: idef_generated_tcg[0],
>> -            output: 'idef-generated-emitter.indented.c',
>> -            command: [indent, '-linux', '@INPUT@', '-o', '@OUTPUT@']
>> -        )
>> -    else
>> -        idef_generated_tcg_c = custom_target(
>> -            'copy',
>> -            input: idef_generated_tcg[0],
>> -            output: 'idef-generated-emitter.indented.c',
>> -            command: ['cp', '@INPUT@', '@OUTPUT@']
>> -        )
>> -    endif
>> -
> I prefer to have the indented version present.
>
> Is the above check/fallback not sufficient on MacOS?  It works on a Linux
> system where indent is not present.


Aside: could using "clang-format" be another approach?  I suppose it's 
just exchanging one dependency for another, but maybe xcode comes w/this 
tool?  Then again, maybe it would be an inconvenient dependency on linux 
systems?



> Thanks,
> Taylor
>
>

