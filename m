Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6988BC5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFCp-0007XI-KD; Sat, 15 Aug 2026 10:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFCj-0007Vw-MI
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:17:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFCh-0008Cf-GA
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:17:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDNI5H644599
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j7RTnlPiCZfcff3KeS13JBPfCHpfMRulvXLKPENkrnc=; b=LDFot6q5G8WMA/41
 SJeiamqO7NLHACr8S/IsiWMH/ftq50JctwHrjy1wDcR6JaMY8ycKKToZsk2PuvM1
 NkkGg0ZSJYSz3u7mCaGSHIa/UVzfOPl22FoahRu6/FRl35rWi2bBuNJpiWgwck97
 V2nQfL7zr5PvnM7hvEQxQ5ps/xr2rT2/caHHsisaYhgvMUmBUgCX5ckH2AYeDvQz
 Hp0aglSmQUzxjUxRO0bFS/CKafK0qfv57ADXvI+uufRrpwnmYYETXJfEwsg4KPPT
 7mFOXbyg0motKI9p2lxF+hKNfvHi5dvWIspJGDRfmZHt4BlThxQvZt+3CPXFfx9I
 1ZcCyw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfs2yk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:17:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso36555221cf.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786803458; x=1787408258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j7RTnlPiCZfcff3KeS13JBPfCHpfMRulvXLKPENkrnc=;
 b=S2pZagrraQLmI97T6BeCstVra03MiwaELpwMo2iHeqShaWDENEpRxMrBkmMImoXEpd
 6yg2gdd5IFEdipMuE/SBsmurjbyhNoXBultTUcdWgbGCZKUGtemAxAgh49vfCWfwHTPm
 TTb2FK7rEDBU7snBojfmDGxho+WR6Ytby2NphR1XT2kWTWoAM7M/12b3oqmgwDK57DpX
 B4qkLs5E198+UDvJ1womv0oPD6/cFe6wMU7ZzFirvRJToTCOjswVOWrF5TftxkhKcD7R
 vK2UkQ0wS4K/fV2nuDGv1VL0bisFoGpGM8+TZyhqDa9deXGESvYhUIZylHi31/w00lnD
 GgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786803458; x=1787408258;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j7RTnlPiCZfcff3KeS13JBPfCHpfMRulvXLKPENkrnc=;
 b=j6oZrbvhZqa4bH1cdIOOCogBboBf18Ltuj1M2RXnjyIOCN93+HEhmgH7y56NfpOMeG
 /awzZytx5nQAWexdS8pUq/ic8sD4q6BqO5kqh9QLErLbf4VhmCSWk7cN/1hQKuIMLYT0
 hTKZzNAxmTqura6PwQVs7pKP5pRWnbEdC9WWYFlBgoHPVZxuHlrQy6FlmGN48gbqln82
 ySnxUzJIXz7o7BvE7VvT0VApxAg82T3PPIbPm9/g22YnyGQXA6ntZrjQT/3MJD5i4C1t
 VQYA9JgTfJd2IQWRXIm0KNs3v3GSt01c7Ll0yWm9LCL7RBtfnckQqgIgxpNbAZXr610J
 9cuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOh/Sy8f67A00v+TxEUW/IkdjW24qCum+AuCrsqYKs1TIXu/JVMGuZNR5ZEl/c1a7FAMyXyY94XllW@nongnu.org
X-Gm-Message-State: AOJu0Yzt1XZcNT43BL7ooTAk2yyG4RXOQvo/4zmiV0FYLf86c8LBWncp
 BzDad7f00KLlJTkWaF1hv3u5b2xl9EYejBUGsBlnrZSExpuMAnuQDwtMsWaXcHJYzxj6Iwa42b1
 rxqrwil0pfy6EzN3mtUpfy/MAHOuHKDRiaJ4bYHrkWbUuCFONpuJofQVw/Q==
X-Gm-Gg: AR+sD12DHMnLATspjP9/MAaokscK/a5JT8i++QxmwPpJ/d7usxWxYA6k/WX4Aanw3k0
 GVkf8brUZoYCWwychWsgHsLC0/sH6g7r196X+oDBq8Sh/Ybv535UH8ha4K6OJfob0+LYME59NQ/
 DHt8K0xRqEh6rnGBBvO1omJ+QWByg9uABpjY2sfO4tAFzB7CTNFT0NmlsSwFpoM2/bCg6ryQ50d
 T+5ioKfQwUwtzlYeO0B1+XOnJssSToIv1rwWcA3kkQY5bI/r78ahNFVaf2BfD1g1PptUCiEI9Op
 Grb7zkY2iKYjaDG4yiQRh1ZcBGCR7toqPj8F280M3IoFWo4NhK5hItQulidXcWLfaEYEpaZBD7P
 jhZ5NbUP0HkB1CoNxk16tA2+dXKIjE+ojymA=
X-Received: by 2002:a05:622a:58cf:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52d854c2d90mr157444161cf.25.1786803458226; 
 Sat, 15 Aug 2026 07:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:58cf:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52d854c2d90mr157443421cf.25.1786803457761; 
 Sat, 15 Aug 2026 07:17:37 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20051esm18535218f8f.7.2026.08.15.07.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:17:37 -0700 (PDT)
Message-ID: <9aa5c297-3fd6-49c2-8954-c075342db288@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/26] hw/sd: sdhci: Accept version 4 enable without UHS-I
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-9-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723151853.2143177-9-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX5mtc7nSWoDAS
 P+AxF3o4T+55MIdRh3wZWiOraokhlfzRD4kyl2M8NAx8L5Tsjr7WsKps1GIuxt7nmetT5QjWnR+
 6VY/aP2LsZ8WslUNR4Qaxf15nWrLIdQ=
X-Proofpoint-ORIG-GUID: O-pPLmtmtwqa3AwTBUKnztbjX1FC3W0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX/yeyGAfcUqDz
 HcRC+PuKgJyDRBIdlyn1P1FNGQ3v+nS7mzulaGgkCq347uAcl1fvjZFTBGCavn84vsd/l4/a7PZ
 mdUVq8hpsWe4RRCJspnsseK53j3BhC9CwJswRgwcSIyf2Sjyg5o6LvdBjP38GfpG+ZsvRyvYeVJ
 xXFJMSQIQjkryKx+hT6+uJCxhgN1BvJd5jG9ymGRHP67vBwNJxH/nqhfaCjr6eAFGrerMvB8VNB
 m0b63Z33DssiZWF8pwwETDn7oTZy7eay1pWz07VqXJFoGztVI/iV6lpYhbhgwGZ+SmOITrPyIbL
 gohh2foyeQTOpn4/2yWFmJ06hhTMzD69APFYOgAsb6AhCu/NO951jZzed05zg6hyK/1uld/YuRJ
 Jqk1d6XcXQ4VP3Fz0/0TKexckBeSwN0Fnb2wkCEpX9RPfJ6+szzSPxwZ+AdmI6SIxbVmALIdd/F
 W1lDnpuN+7J55Xmrg+Q==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a807503 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: O-pPLmtmtwqa3AwTBUKnztbjX1FC3W0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 23/7/26 17:18, Bin Meng wrote:
> Host Control 2 writes have been conditional on modeled UHS-I support
> since commit 0034ebe6ee31. Host Version 4 Enable does not control UHS
> signaling, so controllers without modeled UHS-I cannot enter version
> 4 mode.
> 
> Retain Host Version 4 Enable independently of UHS-I while continuing
> to reject UHS-specific fields and keeping voltage changes UHS-gated.
> 
> Fixes: 0034ebe6ee31 ("sdhci: implement UHS-I voltage switch")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

