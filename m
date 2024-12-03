Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9CEE74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZVb-0006RV-80; Tue, 03 Dec 2024 15:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tIZVU-0006Q9-Tz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:28:29 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tIZVT-0001eS-2w
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:28:28 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3E5ptu020064
 for <qemu-devel@nongnu.org>; Tue, 3 Dec 2024 20:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4nq07f50q8vTray9O2DDg3hEek1STsIsOr959p/US28=; b=XkeAC2vs6sLJrHoD
 KqRkqCX64JRIMrNHyFCVbZtMMEXB3Xk9djAj065QZ4arhNeVNshxZnu56R1OXJb9
 2ZNZETtQqFfGl5FrgyW2XWEVHcikHXkoo/cQFtZlwlVfR0OIQqzq+NSZSmr7yGmD
 VSor3B7Ikzc9v9GATm32MSSGDpQNJ+U+q3vvFzwdZRB+qAA3zUcRyaAlTPpVtrT+
 KUHKjv0V9pmrDGHiTdWn5h7ZfGjbK9AKMRvPwl6S94swxLJQxhnxi6EFxazKWEDp
 4KXQS7PDlU/Ml8QUKq+1L5ICWqVZsuFHpXveSJpsUS9tcFhEZkPQkkrvwQY5Xxrb
 yIpBwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3ex90tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 20:28:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b68b264f71so725738285a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733257703; x=1733862503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4nq07f50q8vTray9O2DDg3hEek1STsIsOr959p/US28=;
 b=UlbU4LMk/RyL1oDP2bbJRGjOvMRTVXYz4cjKZec7dLibiru7J4kRdGw3ytUdylRbfb
 eDVnkeJ9VHx+w/GQHojyptKVy3P5/z4EABsBoklUQOta4wsN7g33X0JCQMXmZKCx+yoY
 sh+dLdJuR8Hq6wlfqL6TQMwvueH2Rqx8Q5wxKnVVm0Dog13eqpcEr8xkcWm1mNUbzr8J
 LVDl51QJ5gLC56RvgJPI9/wI/YdbuV9XSM1SrDAkJPYj0EibmO/a/3l0GeAs7FiPoywS
 RFLq7UFAy1lBuXr+T+ueLYRi0QDIxMczqOR0j+Ew5sMvR0aSgG3qh8mvKXlBSETxxVu9
 ltQA==
X-Gm-Message-State: AOJu0Yxu3INEo0HbH6IplgH5ojGbG2963o6FvYT9GPY47gz33SMRkl1l
 TRN5uHMgQYqQo9ecUU8dda0FvaAHYv6v3Sic1xM8EDaSz7MEF3HAhU31J5uu3u4XDMKdzGYSiv8
 aJST/25+/uTCb/EY37PcGyJzdh58JZAY6/c9SrtjebkLblyI2tOJLcA==
X-Gm-Gg: ASbGncv2hoGK4UjRSdSXFEP7juEwgNj954fWG8YCXKZt/trGx/yGVoqZ5Mpo3kCGmnX
 wHc5Zd7b7L6uDY0h4ONlhrK76wqaTr3DnmcimH6vxoMIlh/+wbL73AC4Jjrfmtfa80uKaRVpoMz
 XQex5rULzdA13K8uoN+XoRLbcb1+WkpZiYsRloezjiWMdlYG2kGqiAnI+l/W76VIEfaX2iBXUdQ
 Tma7kyqq3JrnTCqDf63zV4dTjrZfSD73QVbVzcwpTWzN3KH+nXRLSLWim0GsnvPyDybWQbE0kEH
 ay/GsSGdvEbSBJmSsxnh9DEHdlOpGoaE
X-Received: by 2002:a05:620a:2685:b0:7a4:d685:caa9 with SMTP id
 af79cd13be357-7b6abb9fe45mr232353885a.48.1733257703605; 
 Tue, 03 Dec 2024 12:28:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhUuiWU9qS9C1CdOFMaZeZWGM77Cr1yN9nHLCIEkno64Rd+/lgYOZHIJKnKJzGxN9xpbJ1pQ==
X-Received: by 2002:a05:620a:2685:b0:7a4:d685:caa9 with SMTP id
 af79cd13be357-7b6abb9fe45mr232349485a.48.1733257703165; 
 Tue, 03 Dec 2024 12:28:23 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b684946dadsm541120085a.60.2024.12.03.12.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 12:28:22 -0800 (PST)
Message-ID: <2ee450df-b06c-420a-9e52-44b781423c6f@oss.qualcomm.com>
Date: Tue, 3 Dec 2024 14:28:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 36/43] target/hexagon: Add temporary vector storage
To: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com,
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-37-anjo@rev.ng>
 <eaf906e2-3973-466b-8a2e-f7749e844968@linaro.org>
 <gcp5xcypulziy2ixslvsiekwidedztxydvypyc6faz2ssbzx2i@ibcmjqjzgxwp>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <gcp5xcypulziy2ixslvsiekwidedztxydvypyc6faz2ssbzx2i@ibcmjqjzgxwp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N_extQEE55JJAyIL9tSx3kMODumM06Wg
X-Proofpoint-GUID: N_extQEE55JJAyIL9tSx3kMODumM06Wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 12/3/2024 12:56 PM, Anton Johansson via wrote:
> On 22/11/24, Richard Henderson wrote:
>> On 11/20/24 19:49, Anton Johansson wrote:
>>> Temporary vectors in helper-to-tcg generated code are allocated from an
>>> array of bytes in CPUArchState, specified with --temp-vector-block.
>>>
>>> This commits adds such a block of memory to CPUArchState, if
>>> CONFIG_HELPER_TO_TCG is set.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    target/hexagon/cpu.h | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>>> index 7be4b5769e..fa6ac83e01 100644
>>> --- a/target/hexagon/cpu.h
>>> +++ b/target/hexagon/cpu.h
>>> @@ -97,6 +97,10 @@ typedef struct CPUArchState {
>>>        MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>>        MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>> +#ifdef CONFIG_HELPER_TO_TCG
>>> +    uint8_t tmp_vmem[4096] QEMU_ALIGNED(16);
>>> +#endif
>>> +
>>>        MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>>        MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>> Wow.  Do you really require 4k in temp storage?
> No, 4k is overkill used during testing.  But consider that Hexagon uses
> 128- and 256-byte vectors in some cases so if the emitted code uses say
> 5 temporaries in its computation we end up at 1280 bytes as an upper
> bound.

Per-packet there should be a maximum of one temporary.  But per-TB it's 
unbound.  Could we/should we have some guidance to put the brakes on 
translation early if we encounter ~N temp references?

But maybe that's not needed since the temp space can be reused within a 
TB among packets.

>
> Two ideas here, we can:
>
>    1. Allow users to specify an upper bound on vector memory, and abort
>       translation of helpers that surpass this, and;
>
>    2. Emit maximum number of bytes used for vector temporaries to a
>       macro.
>
> //Anton
>

