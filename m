Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B99C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXuv-0000OD-4u; Mon, 10 Aug 2026 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXur-0000Nr-0J
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:52:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXuo-0001Hs-N8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:52:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXPhN2088661
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IhN2RYJvT2hb+a4cEsxVc/KxxorkUirNZFL6xVUW6do=; b=iujJnIs2ECmVIFuz
 fUZc/6kXKc/DdiRQWfcfNUXIWouoHMLrnv/NU9qIpgs9m7H8aaZwBAPU/egroucK
 1b1btu+9gn0zr29ELFbq65U61EVGBTvtGLvxGgG8u7tHwKdHokH84DyvG/o9V9rt
 86GcpUeKW+XEkyc6Zzqb+FQy8OpTOWLu6DTpIibMcKIGuo45LRWSk2+WxM/6gzdG
 HBoLBLGvqnWd1vALPhySW1LVAqr08o8OkPb7diNzxOiQaNW+w8885GxeR6IejRUW
 sVZL2SO5VxgnB2pFA6l1AYPZ+tWw0vYf3ltu7sgtm5LBUncv3fHF+qdfvX8quuwM
 Yne7Kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk798pw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:52:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283df62d68so29302141cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786398731; x=1787003531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhN2RYJvT2hb+a4cEsxVc/KxxorkUirNZFL6xVUW6do=;
 b=B1z4ae7bw1TNe7CqveyWof9de8gI5HRJHC5iQ3t8mZyMZd9Nn/oSRP4M6NAkoGwkRr
 RtW+nkRZVn0aw43r/IQzO4/ltoXBs19BH9/yL72vrNwB68vh8YQ07srE+k0QFpVX0IhQ
 u6sXWwOhOrCPNgu/v+2RGJLfAtrnLVxijalxEP4+e+M15arXpK1muwGndMmxxqxAY/Zq
 7qk0zODgL8fqecjvcopQa4mx2EjO4qtS7XHXf7+XX+Ds4Z2wA1JTvjmcDjg0fus9Nngi
 rOqxBMlWgu98HnXWQbVW4R/Ve09BqvPfyFtNp8O7wJSA81qIqVJ5lD1r3Jp8EevpbXiD
 dt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786398731; x=1787003531;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhN2RYJvT2hb+a4cEsxVc/KxxorkUirNZFL6xVUW6do=;
 b=lfhrtrNdKTx805PIZhR2h3LJg7wRAmqBZYjHM4ntc+vtLYMH6hTE6IHGCHVqrtCc3K
 DbvplH8PRYAHLQUdcaNjq2tdRmFHHFsByq4ebd6XELvGZjgX19M1kTRLc9B1PqY8jzFj
 Qpoe2NwN4rrFMSkFImDeysH20qr152WBBJCttsELCRF1a/IJx0tNP6OUX7Y7EKsXnW9q
 QWFthm606NMa+1fhM7ZKCUAyuWDEGExFoEIac8D162lwsa1mSDHxk9fhbJtgkFo9xDrN
 OBGpZnd3nvjGOnt5URTpdASReEqnCNu53t/hr/ZpfXiNwxfFHPwcITEwhUd/+dE6hS2z
 iHbA==
X-Gm-Message-State: AOJu0Yy0RAwfPa4U+rJ4uEJZhR59tfQd+gbaa2mWmDuEtWdqqW1pL8RB
 4hvNXPY1X/FD4LqGg/WvQQ/o2fL4XRL9z48aNSKU/mmUAeC8EdaLkhw/kTDBjk5CkjcPKbLKsNF
 7mMfc6Z+UEvCwAE+CO3mYD+hxjZhqJDiVBs6x+R5aTLeAQ7D0POunUZ6pAA==
X-Gm-Gg: AR+sD13kjGjhukG6QWhuq72W+RMk1SHyiyumA/Xb/YkHzUYDEAkJdNNxt6EObipvdsV
 EG/FAsN9kn/anxAx4GQDEu7uExp899iD2rgH0xlSqE4kZ9gd5XT2DVxNiixKEaLA6VbMrY26sYB
 NzWWqtwKFYLTwgJCoafKcAdVuBZM1m/h+Gop/jsHt2LyTGQcurhwMwkG2tst3vIhvJcBog0stk7
 PNder5c/Wc0FkgCA+ktUu8LB8QDdEq1iAbKJXjieUGFSDtQ8jwFyHwbu6zMOx0Ko6jyzJUBQDMP
 WGXKCxy+9GlZB9JEIffQZd5c/4J3LXtbRQufQ1oR8ZTQr23bvWkfYIR51G3dcd48/7D4A9ckobD
 TdqN7zhthkThfPuZ2F+QTBZy825prXLmtBgvbR/PX
X-Received: by 2002:a05:622a:5d0:b0:51c:a7e:4cc2 with SMTP id
 d75a77b69052e-52d4bc37c6fmr61500931cf.20.1786398730801; 
 Mon, 10 Aug 2026 14:52:10 -0700 (PDT)
X-Received: by 2002:a05:622a:5d0:b0:51c:a7e:4cc2 with SMTP id
 d75a77b69052e-52d4bc37c6fmr61500541cf.20.1786398730394; 
 Mon, 10 Aug 2026 14:52:10 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499740c4a87sm17602135e9.5.2026.08.10.14.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:52:09 -0700 (PDT)
Message-ID: <bf39eed4-9bc0-42ab-a41b-0b77432448f5@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 23:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
 <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
 <CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com>
 <b6f8c765-4e17-4aa1-990c-5518224971ef@oss.qualcomm.com>
 <CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7a480b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7S9aToGgRvpnMBL0WZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: YKjUusvXwTkpLgBN_VxfR5MIJNsTRkC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NSBTYWx0ZWRfX85Clxho88X9x
 QgVI+eyQU1FaFxVGKfqU/ao33HILrAZ9rhazkAyecxOrYzdkjFRGipMH7fRMugwuVm8fHsKZHlP
 VtybvqRxHEjf0XoAB4jKsy+u0/vyZTx0k1peYbhbiHcbStputvMfNrAT6ZWsM4RV8JDxaBYh975
 CC+QLw7sescTkTXNtB2miegqSYTZWEYzXG/JLlHsXYcq6f/vVrjnGu7Gx0CK82aGjAazA/4uIC6
 9Jcfc+/e6kILYsRsF19SBXEayuBZfCpdfES55iyfD1aaB3PF8XHJAWRM379MBWCx0MjhFalPWDt
 9AOloUtE7HVeWlAvd3CxJWiGjNTJq5hCRR3LkYCVDt/P1VN/fYqzTH81eWq4GZFTB1RTE7MYvSv
 GgnZYVMicdnWn9MJiV9i2WLcm20JuDSS7azeCMmhew0M4F0oDSwPR+C7trKfKfbBtjMFWN2KqSL
 S2ANbmIblG+XCXDYOkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NSBTYWx0ZWRfX21YTxfgzTEt5
 5h0cUvNGrQeyOdDtzshIIxEJkdaMjL8KXDApl9APdbdcthhCoD57Mhf9sTPvmyoBSi2ePBgQhnZ
 kaMRZL0szjQH3IGds4+54ThhE4+iN60=
X-Proofpoint-GUID: YKjUusvXwTkpLgBN_VxfR5MIJNsTRkC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100185
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Taylor,

On 10/8/26 23:32, Taylor Simpson wrote:
> On Mon, Aug 10, 2026 at 3:12 PM Brian Cain <brian.cain@oss.qualcomm.com>
> wrote:


>>> Seems like this change also depends on some kind of mutex around
>>> regstr[] so that we know it's not being used concurrently by multiple
>>> threads.  Translation is single-threaded but if we gained another caller
>>> we wouldn't remember to come back and remediate this.
>>>
>>> I suppose we could take an input buffer/length.  Or maybe we just add
>>> another static _regnames[] array to solve the lifetime/race problems?
>>>
>>>
>> How about putting a regstr field in the Insn struct (and pass Insn* to
>> these two functions)?
>>
>>
>> A character array?  Sure: seems like that should work.
>>
>> But if we have a static array for the others why not leverage that here
>> too?  We can statically fill these values, right?
>>
> 
> These are for cases where there is some sort of error and the reg number is
> larger than NUM_SREGS/TOTAL_PER_THREAD_REGS.  So, we wouldn't know how to
> size these without looking at the number of bits in the encoding of each
> instruction that has one of these.  However, that could change over time if
> the architecture adds new instructions.
> 
> The regno field in the Insn struct is a uint8_t, so we could create static
> arrays with 256 entries and
> 
> We could revert back to returning "???".  Alternatively, S<unknown> or
> C<unknown> would be more readable.

Hexagon frontend already relies a lot on generators, why not also
generate a static array?

