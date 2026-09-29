Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E6ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXCy-0004mc-DM; Tue, 29 Sep 2026 08:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXCw-0004mC-Fa
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:45:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXCu-0006wj-2Y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:45:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCELKw525120
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lxoRY1jaIaeAMHcXTTqFrctxcTiTIvo4dXEdj9X9cRI=; b=BR4FejVp9GNXmuaN
 6gDpNXlfbxMmBwsQa9coz0Jr+OUPpjKWgm3YcF0XnqD5Jtepy5LexQmJdywJvLzZ
 PNLvBtbO+nbsnr8Zzk319Iy3nJyleQ2t+6hQeN5p90PwCu+wwFCNLywce/KOZyPA
 bbFyjeLv+l8i6Vk0SnYwmxWocY6M91IcNY4iF6yORYNt7BNjMMF5cJuYoCtUJlXf
 P2Vcj6JZZ0enRKfR9GJR6vkmcwmHKLZ6xempEndUWePXP/bNRz6ssAbNkQVg5UgE
 np5zu07lQbLQhFHDg9Ym+u4v9IoN2pojApE7BZvRH1wJELRmNP238p4PqU7rCc2R
 VHekBA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4u2gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:45:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so1026000485a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790685913; x=1791290713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lxoRY1jaIaeAMHcXTTqFrctxcTiTIvo4dXEdj9X9cRI=;
 b=Sf/vFpn33iEbygvQFjwXgZL8vtVr8mdZ37VVKH/MBaTe5034IoTeiS2E071e1sbd/j
 xGALFlFPZcVkHQT9nWGZ1mSb2pPYmeF8wyrlIWKMW0sLrtMIxhCo2HHdLaZylmwkdZCk
 P29/PAjh6sO7R67X8i+y+OOjTwAaXI175ZoyNioeIWR+gEC/63pH3nruJHpuYTox1rtW
 MNBnf3lcom1wHY2fVbQpEtf+ur579Qx36XyQolIVocME4cZayxicJpXinxsht0Zeca6H
 lEXildZuD+R1XykuUhX5As0h5/wnglKe2fKVdD26dqzYl/U5+TmYGNyVpyumEIrDxzLF
 mGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685913; x=1791290713;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lxoRY1jaIaeAMHcXTTqFrctxcTiTIvo4dXEdj9X9cRI=;
 b=eZt8RqiGPlaNjez/BFVcmyD4Thgd4NUraPaqxDAl0091DTmyKwfanAtWDTxoWmtoUS
 OF2l0pmQUEpUHKxeErlliwr65ikzTuQFSAPmfvQPWkfMR+BKdORO0G1hoTNNwC3KwKK9
 7TxMqJAeIgvQQAmCMI/nNLBv2wFOFlj3ErryX7WXc4nsk1NyLl+nG1KZzhkFYcBXe2iy
 tKg66RYEYZaa9oYC7jF70DiePQc1+ldrLSgqEe+W6seiLCzNczwiAIhcLTyoLyrSRVAj
 7S4I6oB4/0c0ZYamvU3aBuztaHI+r7QB+EvnWx84yaodlBCX0GVwbloPW/371ZS4IaZx
 jtvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL+104+ZsNA+Thnio8dhWsfNmkXaprTi87twE0+Fd9jBfHke1xDPEmgIzIBYY55nbYnJr/QxgV4He2@nongnu.org
X-Gm-Message-State: AFuF++n0emO+pOvZ6mAzMuMGhhW00mBBcFafYlS5ucIW9vHd3/E0GTYo
 FNIMrnw7Bq196uvFFymFPO6+ydGCEPjewLVSSjtNYraAw+QuNU1fmQ8HLXDmNZAWIjs7X07eSGQ
 kMnCmrs3ExRxzj3S4xHN12OMDoU2CjyVQlezMMFzoxrtUAOzgHqKlItFElQ0XUM6E6w==
X-Gm-Gg: AYBFou0P0UVQAdHqKWCvXcXPtyCTjTGuMT6PXGaUGDU6TdX2+E6EGFjkyix3nUqSDVw
 IOrd+hKOpfeivPf62iVNXfS5nXcxcj0VI/8IQJGdtULmPnXxr+Zq3M4LSs9o5uTQq2vEVoREUD/
 lalAw1kX1yJrSP4s3v+p6VsvOD3pd7SF88a8ZP5GukwVbj9KKwcIo65C1dplOmL4XvTO7UfDhqj
 STisr1XrK6LhYx3KYoJAPsXoyoTY4/49ZASzWTkS+5BMA6HcjIkwnj3Z8PWw5lc++clTVy7i3J3
 RIOEtztgi/aXIJLYceOUcwjw46nxrdqw1crJ1pwzMcmgv6bfSNMPDypBznma3uH+46+4NQ/pKK5
 YExlyBR1+RtZnjwQ4ACsSgHBuF6AcTL7dug==
X-Received: by 2002:a05:620a:90d3:20b0:93c:6fa0:9813 with SMTP id
 af79cd13be357-93c6fa098famr1008190985a.43.1790685913118; 
 Tue, 29 Sep 2026 05:45:13 -0700 (PDT)
X-Received: by 2002:a05:620a:90d3:20b0:93c:6fa0:9813 with SMTP id
 af79cd13be357-93c6fa098famr1008182885a.43.1790685912421; 
 Tue, 29 Sep 2026 05:45:12 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508bb41sm3878843f8f.28.2026.09.29.05.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:45:11 -0700 (PDT)
Message-ID: <8fd00af1-330e-4685-8512-70a484df523f@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 010/101] tcg: Generic expansion of tcg_gen_movi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-11-richard.henderson@linaro.org>
 <5f762124-6163-433d-b8df-90ad0ae76353@oss.qualcomm.com>
 <aa750bd3-39b0-4409-9fe2-802098b356f4@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aa750bd3-39b0-4409-9fe2-802098b356f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX+11adO+b/XGL
 6Q0Pylj1FdDWJzgRNbvczetF0PNublaPiXTMSSJHkohcj9U+5bqoeSObBn6ZAF9SeqO1mdOYuAd
 mVdh8J/0i1l8NN/sVbt4jBPN25Y3SdY=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abbb2da cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=P4sLqBGiQzvhYaW60CwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfXxteTpmBniDsv
 RbZzX1o1GCKXCFTRnODVMaXxXAHSRx3ondu/ZE4AKALqQEPa+b1Ey40p/73SBHpHg0xXeID6hds
 ejaHyJphl0gLz89mGojS2jRtwwj5XDBdgk6aukL4dhf/diOJMXqh0IkKqGu0nix1CQZff4xK14+
 YY+zDtheZCe/kDl3+vWx0M9/gPunKJ06+36+qlqPh36dl14RW/unXddk4O4ewp6XfN3+5Ym5LuZ
 N59NstAnPRs62FDl1bTTO/WI8hGwOw712aRokPNPOeUBdd2szEh7sVU+Po1VToLCc8ibx2GPmM/
 9u9unoCu11ayqs52E+UqNt9DsVWz3a/4PJ6IX1Fbsj0ga/YS05MzNaPa0O2A6fAijYTwOCQL21t
 7zUUPnQ4/P7MTj+H3pIgE4Vutcu1R/PTTirfSnD0uuh13uh8AytMAYPPHhAzFQt5ctLX9KDP3G1
 Hzw020Hvf50ndpwtvCw==
X-Proofpoint-GUID: XCLP8gzPDFJ46P1oPkxXn-FPRG54m8Fu
X-Proofpoint-ORIG-GUID: XCLP8gzPDFJ46P1oPkxXn-FPRG54m8Fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290050
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

On 27/9/26 19:57, Richard Henderson wrote:

[*]

> On 9/27/26 08:31, Philippe Mathieu-Daudé wrote:
>> On 27/9/26 10:58, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/tcg/tcg-op-common.h  |  2 --
>>>   include/tcg/tcg-op-def.h.inc |  1 +
>>>   tcg/tcg-op.c                 | 15 +++++----------
>>>   3 files changed, 6 insertions(+), 12 deletions(-)
>>
>>
>>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>>> index 77ed34fcb8f..b2fa509cd1f 100644
>>> --- a/tcg/tcg-op.c
>>> +++ b/tcg/tcg-op.c
>>> @@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, 
>>> TCGTemp *src)
>>>       }
>>>   }
>>> +void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
>>
>> Maybe this commit (the first converting opcode with an integer arg)
>> could have a description explaining / reminding now all args are
>> passed as int64_t.
> Where would you place such a comment that would be useful?
> I can't see how or where.
In the commit description? [*]. Smth in the lines of "We've dropped
32-bit host support; now all integer are passed as 64-bit arguments."

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


