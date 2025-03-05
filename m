Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1BAC282EC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 21:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpwID-00046r-Pd; Wed, 05 Mar 2025 16:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpwIA-00046g-35
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:28:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpwI7-0006sz-DD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:28:37 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525LGboj020148
 for <qemu-devel@nongnu.org>; Wed, 5 Mar 2025 21:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9qyAz1fNpN2z09sopnOCDQQ8N0+kEROoryVqiSHUBnM=; b=R9tpgAz3VJNZMu5e
 StSiE2K+RXD90HfntEM08E4wCpG+mOF56OzLfvUKs+r1gNQWH5s7BC6P6j5JNDSo
 cgG2VgEMNQOtLoEhYZBSwYq/70JUuhTN9AgPwROvUHJrXBQMk5Eg2x9dHPfiGUyz
 tX4MLfhNKppGGESXzmFQ12BP2bjGkTmu33p/Kxlh1jbu9vvSjrJPR4hAB36GBfaY
 oSvLJ5h2uUV1eaQzztfmzYYWyocrOV99jNtLFq7z6uCg4QU5fpqMrIJuAtKA8Ydi
 SJSqwf0d2a4Zpa9VeJ403R/kTkKaiXd/fCI/cDSfkU4NBqiNXJ+04RhtkRVOOYYe
 +uQnDA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 456xcug0pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 21:28:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e8f4367446so420716d6.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 13:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210110; x=1741814910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qyAz1fNpN2z09sopnOCDQQ8N0+kEROoryVqiSHUBnM=;
 b=g6whNT1FAv9kYoRg/zkzlHcDxEuoNL8koJpWPy9zmwWS3lfD2sbugLPrIrs80+/LYh
 wUOadQHM+yUC9HqXA4ykopYqXSNtyqug91OmkwQ7g8OTuQHuTIFZG1TSoLdkKHcariiV
 UefOnXuDK8kj0XIzEhnBOwlUm08PoeIO+EG1QLJO2LAbX9LFL4+28EU1eliUDBuVLhfU
 kASmHtKnfV0Rn4FViotgePYY2VdlpIFXEl5TrfqeI32WHfoNK1XjlRnKwnj6Tf4N+5qz
 Rtg1WQmj71sIP6Ku9THa8zxDrCx5WAX6slaGRUicCUPyxbftf8sJLCfRQ45mo+gPpNUH
 CUuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVbL+j+6oN4OzeuTaWPcfc5yvagHrslEsIgyXgopiMKOWOhRqmlVi+hBpc4nhG2Nh2TMJZQQ6LuN+9@nongnu.org
X-Gm-Message-State: AOJu0YzK/Ue9CZaqhO+/f1U96A/IohO8gsCx6xP5AlCiXT7Lo8JQEDW/
 N9AW1flH5LEBotBKPKEs84gPfH4M6Edqzm8pTZNWGs5XJ/HFfNCJdi0U0mA3lyaVZ8RRxWK+rg8
 87Kfd8xnvcuAUnXzjWDRNb41pmDFEG5YHSgIZGV8eaCfkWZbEkWPcJQ==
X-Gm-Gg: ASbGncsqw4t4+r7tr3mRhFMmmbsfyv0ZJLwRL+PCwmBZ1kW4HbgAG5bJNw+shWumNM9
 vGpGIjoF0Ta+74ItXlw5SLetykxSZQRjeM2cLJAzLL1yiJtwh9BTkREBegAks36ank9kp0fE9pM
 3tlKQHK5rm6CGTgvEdZdR2KwxlVbfq0jtOybovlRtYpQ3uTEGskhaa2wV7dihjE2htiPODttrBj
 pykkSOdQjCa3wYqjPZACFRqsF0fsVGmSzt3CpffKo+VFSYmawkr4WZSj272GR/EO/LXnlunZ51m
 xZDGKT9SgNuwdYz2zFv+9r8qtp9HN4JryN/OFO0Vu/5xgnaIHTE1SYI7imcwmLiQ53Ch85jsmQ=
 =
X-Received: by 2002:a05:6214:234d:b0:6e8:f2ec:4932 with SMTP id
 6a1803df08f44-6e8f2ec4a28mr30558296d6.28.1741210110379; 
 Wed, 05 Mar 2025 13:28:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvKcYd20fHgZI5b1E3Lh8LBRP4LB4QI1fmIsECIZf20c6OiuyCA01mmxRYUBTGAaRJVLgHaQ==
X-Received: by 2002:a05:6214:234d:b0:6e8:f2ec:4932 with SMTP id
 6a1803df08f44-6e8f2ec4a28mr30557976d6.28.1741210110056; 
 Wed, 05 Mar 2025 13:28:30 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f39b4eb4sm3773646d6.110.2025.03.05.13.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 13:28:29 -0800 (PST)
Message-ID: <56cb3bf4-a4db-4650-805c-5fe10f826218@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 15:28:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/38] docs/system: Add hexagon CPU emulation
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-3-brian.cain@oss.qualcomm.com>
 <01aa01db8e05$d5abd330$81037990$@gmail.com>
 <bf301657-eea6-4f3d-b64f-6a36c5375ec7@oss.qualcomm.com>
 <01c401db8e14$7f4c5280$7de4f780$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <01c401db8e14$7f4c5280$7de4f780$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4ZKNQzaynqbs1QCVPMMf7ty0WeDk1NkE
X-Proofpoint-GUID: 4ZKNQzaynqbs1QCVPMMf7ty0WeDk1NkE
X-Authority-Analysis: v=2.4 cv=eeXHf6EH c=1 sm=1 tr=0 ts=67c8c1ff cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=ID6ng7r3AAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=fPRcDVh2kyP5hMCYVD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=AkheI1RvQwOzcTXhi5f4:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_09,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 3/5/2025 3:21 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Wednesday, March 5, 2025 2:13 PM
>> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@linaro.org;
>> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
>> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
>> <bcain@quicinc.com>
>> Subject: Re: [PATCH 02/38] docs/system: Add hexagon CPU emulation
>>
>>
>> On 3/5/2025 1:36 PM, ltaylorsimpson@gmail.com wrote:
>>>> -----Original Message-----
>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> Sent: Friday, February 28, 2025 11:26 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>>>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
>>>> anjo@rev.ng; quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>>>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>>>> Subject: [PATCH 02/38] docs/system: Add hexagon CPU emulation
>>>>
>>>> From: Brian Cain <bcain@quicinc.com>
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    docs/system/hexagon/emulation.rst | 16 ++++++++++++++++
>>>>    docs/system/target-hexagon.rst    |  1 +
>>>>    2 files changed, 17 insertions(+)
>>>>    create mode 100644 docs/system/hexagon/emulation.rst
>>> Add to MAINTAINERS?
>>
>> I will fix this.
>>
>>
>>>> diff --git a/docs/system/hexagon/emulation.rst
>>>> b/docs/system/hexagon/emulation.rst
>>>> new file mode 100644
>>>> index 0000000000..03a6092a12
>>>> --- /dev/null
>>>> +++ b/docs/system/hexagon/emulation.rst
>>>> @@ -0,0 +1,16 @@
>>>> +.. _Hexagon Emulation:
>>>> +
>>>> +Hexagon CPU architecture support
>>>> +================================
>>>> +
>>>> +QEMU's TCG emulation includes support for v65, v66, v67, v68, v69,
>>>> +v71,
>>>> v73.
>>>> +It also has support for the following architecture extensions:
>>>> +
>>>> +- HVX (Hexagon Vector eXtensions)
>>>> +
>>>> +For information on the specifics of the HVX extension, please refer
>>>> +to the `Qualcomm Hexagon V69 HVX Programmer's Reference Manual
>>>> +<https://docs.qualcomm.com/bundle/publicresource/80-N2040-
>>>>
>> 49_REV_AA_Qualcomm_Hexagon_V69_HVX_ProgrammerS_Reference_Ma
>>>> nual.pdf>`_.
>>> The target/hexagon/README file gives a link to the v73 version of the HVX
>> PRM.  These should be consistent.
>>
>>
>> The V79 PRM is newer -- I can update this to point to V79 and delete the one
>> from the README, would that be acceptable?
> Is v79 a typo?  I vote for pointing to the latest version that QEMU supports.
>
> The README also has a link to the v73 scalar core document.


No, v79 was made public ~November 2024.  The PRM and corresponding HVX 
PRM are now available, so we can update the reference to that one.


Oh, but "latest version that QEMU supports" -- yes of course that makes 
the most sense, I wasn't thinking.  v79 is not yet supported by QEMU, so 
we'll stick with V73 references for now.


But let me double check that the content in the v73 PRMs is as expected 
- that could have been a reason I would've used V69 here instead.


>>
>>> It would also be good to mention the README file in one of the files in docs
>> as well as mentioning these files in the README.  Or is there a standard way
>> the community handles this sort of thing?
>>
>>
>> docs/system/hexagon/ is intended for public consumption by users (for
>> example, at https://www.qemu.org/docs/master/ IIUC).  IMO the README
>> reference (whose audience is QEMU developers) is not suitable there.
>> However, I could make a reference from docs/devel/hexagon-sys.rst to the
>> target/hexagon/README - sound good?
> Agreed.  The README is for QEMU developers.
>
>>
>>> Otherwise
>>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>>

