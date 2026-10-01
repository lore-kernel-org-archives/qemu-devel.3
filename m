Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D45ACA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP82-0006sb-5S; Thu, 01 Oct 2026 18:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP81-0006sN-0E
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:19:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP7z-0003tG-Fn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:19:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FseRN3354450
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HFvGmnt5SCeZssKpq6H/jbcIxZvAUaQzXDmLgnbhSfw=; b=ocy2LImOzLXk/93D
 jlkT8tjecHWM5ayoXWeuv1Cjk/FTFmO24DrRB9+OqAdmUd1NDyYEenWTBMhPrXDH
 LHwQMnIhE2bGGXbXtwpZt5J2E782pCsfn/YcRSyE89s9qEmbwPOgucREcN7kUE2F
 US8Yuh25xY/CXQXKrdNbI9eQjht2Gp+BxYWq3icgNP+s1oAqaZXixsigCMpOpiQu
 Sn8wM65XFI7Unx46bPnVvia0Xyld6b8dUVN/S6zhBR2GJNhngpPFir42oEmEOLDG
 yNeVD5UgyJpQ6JX3LyyjpUC1rtpr2uPuQcoD7/7sWtz/JJ+/9vTla1P1r9d3CX9Y
 ekF/4A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nv9j1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:19:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3282d5302ffso1856865eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790893181; x=1791497981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFvGmnt5SCeZssKpq6H/jbcIxZvAUaQzXDmLgnbhSfw=;
 b=WyMajxw8hzC949UqYSUSJgWZn2dW3C+oCsyZuYVUV2eGbGPUkYoj0pioqNkKGphPvp
 0GbOqtqiLoftSxyNYYF7HsrYzia3i2AMHvP2abiIcbsA1ukWUwE+nlG31MOhNh9rI9ZD
 PE+tmtARS5HuXv/+m3tB99aj9RKApdXPFUnu9s/HxiMpF8OKjyB99wSQHP6+LuaPOQMx
 6baQdR54EJJJwefiDjmyVYsmbwYmi048RWZbpECV+hfbvOKUoKWxfsVZedvWVm0OK+AQ
 BJrupewqWD+Tbq//JpEUarPHoJtOJoaZpFq4koSH6+6bOwfJs4RNUnhzdqvBj6MKnK7X
 nTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790893181; x=1791497981;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFvGmnt5SCeZssKpq6H/jbcIxZvAUaQzXDmLgnbhSfw=;
 b=dZMTCpx6Ml/9PlXKtiKLU3BES2JvGdK4GTSrxf4bigXj6Y25PViMA0sygi1zJzvVof
 a4MbCAhQJTjoasr1JXYpOkBlWQvBgXSqwYLL89VM6O7vTVLuDAptN/ezIzTrutBJI2QH
 Aa5g+AhFZX+5Ck1GSOoQ8kZ/Iosl3CzffnFl5DRG13/BQgB8r5Gew+GwPlotOQP/JiHd
 Ua8qRdPgPQqBbp2uX5dAE3inDXW9gLu/t940S1QjOQODft5Oc6oejk58PVyPSAB3BUKp
 YyYQ6sFiUlQ5aSPkuqXvz0scFDmToaZ8JCrLBqqSILXvW8rpgC7yFCy7Y3HwKUynk2BV
 +Nfg==
X-Gm-Message-State: AFuF++ltHGc53IMD4XJRegUlcz8PykjkE90tU2tpXJB4So+PYOuRhK7F
 zTiyZBI3A1XsCtID6MKNwUoDrS5QnsyWJ0jaJDgU2a6kxHAVMdywG/+9BGlUFn2vJk6/vBnFwVs
 Oob9C70PDAQHvxudzm4aavF0190babQ9D7N1rLvz8FdyqiKla1oq9Y38tOA==
X-Gm-Gg: AYBFou18bMo6Mcav3Y1ncXVQU5KW7I0hojO0JlsRtv9MohSRHNeDtVm1tDPpAl1OuA5
 FjZntcXEKsnkeLGqFWO6cWiAi/ETsmJm4+CPeoOFkI9U4AF6t2vGmXNi09xJDMYnS3btBgIID5F
 9ip9ckkzGbSyrKNTnByVB3LOPv/ES4sDp9DvAc4cfx9xjCYkI3dDPsUS1IRKSUfLQX5ihky/QCZ
 UvEUSOF5uc9uPG2ruzwpcaIabOzPKcu1QrU6CcKWkWG37Q2OgwjqDi4porOPmT3LUfgDNdl9ZB5
 rhrrMYcxmQ+CgpPjIAiVZx04vpQATdANDqSGPYO9c7wQ88xDARmW0JiLceRtDU80zLYovVubsWB
 zVYt6e+ERzhKIm3nVB+a9+h/YubL+rhR8ZuAxUTcJWjQ8vE66p5gT4uy8u7kXFK8gn9Lq1A==
X-Received: by 2002:a05:7022:ec84:b0:13c:e1e2:fc86 with SMTP id
 a92af1059eb24-14dd07fcb2bmr5319486c88.4.1790893181182; 
 Thu, 01 Oct 2026 15:19:41 -0700 (PDT)
X-Received: by 2002:a05:7022:ec84:b0:13c:e1e2:fc86 with SMTP id
 a92af1059eb24-14dd07fcb2bmr5319446c88.4.1790893180603; 
 Thu, 01 Oct 2026 15:19:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f067301b5sm1188439eec.1.2026.10.01.15.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:19:40 -0700 (PDT)
Message-ID: <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:19:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
To: luoyonggang@gmail.com, Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abedc7e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=69wJf7TsAAAA:8 a=vGv579m0_KbvUMclyD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OSBTYWx0ZWRfX5WiJPOMtm8vk
 dqKF7qgXXjY885K0xqp5x6ZYMvP4B3pcFM8Dur+KEFiRftzEw2P6Gs2VCMbjbR+lEXB0pl+5s8h
 uD4+dnYMzffjBqicdENm20AXv+qsk9c=
X-Proofpoint-ORIG-GUID: sZiE6l1r0dBz2Z4nUki23ahmEFnrBvq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OSBTYWx0ZWRfX9iC0n8RmAxSF
 X1wEK6q1hZvsxWFe461tZzI4K0fUUZAgvI/qhvpm7CCw5tUSJDEoFolPNwF1SV2yBV6xJeY0iW9
 AMulhuwclTQrNADtc569GOhP3dlRrU+kU73mX3dcakjpYxG2k60AEhJVlEntmwtKqPNQe5cGVNX
 F4mS+wgmtt5LzTBGmLlRBAZ4jHvdQ2Um554/HTX0qf9dKlkldhqVTcSa3GtvQjJ3ArC/ByvoCbt
 h+mTwJL7iKtXowJg22FabWqcyEx4yIrqW5Xq7D6B/AsR1pyb4tG4iU2YuPysTsmm5PK3O1bYmE2
 3+6O6QIadCmgA+kdaVkjWzZak0Bor/8kS5zz1wDL1yaQzFN1uXd/KN8kfoSUOLXw5VDo7oQdn/J
 y0uYmlETaQLrtcfY1hI73jigysYOoShwFEym2yV3llwLhONZ7IY/Mj4qEc2FHCmly3YJvtUFASW
 1TJCRQ9R6D2geJ7pIkg==
X-Proofpoint-GUID: sZiE6l1r0dBz2Z4nUki23ahmEFnrBvq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> On Thu, Oct 1, 2026 at 11:55 PM Anton Johansson via qemu development
> <qemu-devel@nongnu.org> wrote:
>>
>> Moves initialization of satp and mxl fields to a class initialization
>> function that checks target_riscv64().
>>
>> Note: I'm aware the current iteration of this patch is rather hacky, I
>> don't like the introduction of runtime_misa_mxl_max, but I'm keeping
>> this in to get the series out there and collect feedback.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>  target/riscv/cpu.h |  1 +
>>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++-------------------
>>  2 files changed, 59 insertions(+), 32 deletions(-)
>>
> 
> This patch is how I handle these, just for reference, not a review.

Yonggang approach looks cleaner, I would favor this one.

Regards,
Pierrick

