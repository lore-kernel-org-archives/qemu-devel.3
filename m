Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4455606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JjGZzBtd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JcBBqJeM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJHlo-00078T-AC; Tue, 20 Oct 2026 17:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJHln-00078J-Bg
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 17:53:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJHll-0006fX-5C
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 17:53:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKu43f2442330
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MlhJOPlKDX+pgJbCBoTNcRSuFOkr+QIzzFvmh/X/K70=; b=JjGZzBtdb4ZlMCUp
 AhG4hV4ThKNCFgzQWQv1s9l3M3nlf44ASnTNHj3LDJMT3TNwmTCSGnyc5LChCmyE
 wZ/VTl6Px5sk3ktiTHItnOnQZWqd/trXkv6FN32SGuOMhdOPIsZriJN4BMX9Jc6C
 rX7jX/FXWSB3+A5iZ2lDw648Feyj3T9IfzA++eXV61QfiM1vvpyeWtyTDNCJmTKW
 MU9Vvkz+QtMmCxEc5LEPhadsOHrdt3h0ubDTUu+O8IXYXPugZjcxb6E+9q7mco4N
 3hdmnGdU7JXqpDG+lOmZkS4U6tR3gEDaMYqrQ7RlpmKtShWQCbMDr8X1qVJRM2cO
 HrASpw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hrsdu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:53:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so131538eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792533189; x=1793137989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MlhJOPlKDX+pgJbCBoTNcRSuFOkr+QIzzFvmh/X/K70=;
 b=JcBBqJeMNzWSJaXyR6/RBPZu/sIbbmkpCBr7hB+PVxf2cB5x1iXCmrRnSKWxOJ7zys
 sPiaCOX2Lz2PkO8R8CxC3KhnAzI0pvHl21ZcdrydiFEm/oSHSQJkQIx4ZulxGUdRpYbL
 xJouG/fO4PoIs5UTGN8aY6M/jcHYfIVCmt8NxuCfT8wH/PAy9xyV4jyR4iFpay5maUhX
 ELw6pEnSVmAPWl15tFLmdE7Hzyzl3+OWrntbiyOkqEYFhlBOpvlY5nOVqv0xzNPxaM3r
 cp/QHirznI40S4UxPBfPSs2TyDkx5gINntBa7UGBUjbbtvxlaG4co8QXEKKkJo+zC5h3
 o3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792533189; x=1793137989;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MlhJOPlKDX+pgJbCBoTNcRSuFOkr+QIzzFvmh/X/K70=;
 b=m9OsHMtenkcOk3/SjNOmm+hCvAJWLUrhDaLSWdeNsjsmzCHQOgPiJE2BON0UXZzcCn
 TkTFn6dR88Mv8x78l2XLr/w6plNYu7J6uRPvyZvJwEmg24cNqdZPN/8ZLYsyg51zBAOQ
 theBEqnjfL3DXM4jN910DMm0EIGGt4qAjAXm5UsAiXiLhFStXnz8lNV6BsR4vs8uGuu+
 oemEX6FrEa/wcFAW/mTw84gNt29nMl4nQidQgTYMMI0bloygHJWISk+8HJqCAjKu0D4I
 eFrAxBat8EDAjSFOjTQAI+d4mM39OBoWaVfl4qLiRshlN6BUsZrjiuAI3129IS6RmN9V
 xsUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy250mAw5QcVB5lnQBMoAWS/mX5rWLU15IbN/Id10feSCepk4Bf5yWn/mXQ2isE4NXFZmJyWNptYNrb@nongnu.org
X-Gm-Message-State: AFq9FYKq5nw5+is2LIf5hmJ0+PTGQjM8FA+mpg3/7ozTwx9neSiq2CBu
 IrjoPf4nXxA/Ujg/B5QaXzFz2aAQnHr6rgJvySGQtozsLcUeA1En/9cj1rpxwrhIAAIBu6m7SUK
 ZrbknNcG30fA66iobtBv6fYPyI3x3cpAR8m5v/a3RnXYBes8W8yVCQyy+bQ==
X-Gm-Gg: AYBFou3lE+ut9HEAF7up2G1wsWxGkMNJv/irDrP7zjok+fbPodP7fanQhWV/rgL5wx1
 Mi2qRIAqw2poRkMCY3JliUJK1CfOy/h4e/o1dkvR3lI7T1wSMn7CKU/G6fylXYU2DgsoG95O+kQ
 xJSCftrBfkTvKD//TQ2tqDwWEILk9OcR0JIH5iL4H6RNEkB7ei1cll8ZZDfZLU/6+8x00B4Ut8k
 XhwZY+ZQzq7dogql2jrF9akp/1d/918MHXrr/u/fqheOvJQsafGb+o8LzuBrVrF4hztCAuTopiN
 ereBu7in8zUhXIaA02l41tKbOpGmRlIIjYaJ8ofyMM3Ygv+tPcBW7SZl9I+yIdaPVcb+dQH1rBD
 TLVJIJ2+PAnobOnN30J81gZRpJEVkvS6iGfVbJdmDLRWa6ylCjk/79n6gwf0Poy3ZWPB8NA==
X-Received: by 2002:a05:7301:1a06:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-3674d84cc20mr643030eec.9.1792533189177; 
 Tue, 20 Oct 2026 14:53:09 -0700 (PDT)
X-Received: by 2002:a05:7301:1a06:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-3674d84cc20mr643002eec.9.1792533188512; 
 Tue, 20 Oct 2026 14:53:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367416a1fb9sm1184272eec.20.2026.10.20.14.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 14:53:08 -0700 (PDT)
Message-ID: <5c409160-98fe-4d39-b220-5f19172b8546@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 14:53:07 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hexagon: only flush the softtlb when SSR.ASID
 changes
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
 <20261020022955.3662627-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261020022955.3662627-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad7e2c6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YTL69cp5G8jef_d7KpcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NyBTYWx0ZWRfX5FJITu3S4Bt5
 UBBalceeOkoFL5sXGUFCuh4fkx469m6AyoAucdGd2YQX3y0WzU3Tr/mCY9ODwICByyUbtrIjzQE
 QVsKzisHREyol4nLSsctJX/P9x7EGlM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NyBTYWx0ZWRfX+t0AXepnzDQG
 cN+/7Sllk7heT1OlUuooGuHHGgXpbLkHpdCmnVpnaYPmJ07a8LEr76Hj8DRd7sgoEaZaCHAj2CC
 8c1P63284Pw3+gcUh2ClcypfGTTjQeEetTTNcNcLcbJ/tWKQuyQJMrGkKANXIRcu9Afwhxcbe4Y
 4m0ZYQGard5fWPgFNkKwRyHrL5ybH22T0HgqSAdNGI22+mlkPLzAdShBuwXRvjGqub9pIcHP7Bk
 l3xfsL1Yd6twYWSd0vXOFBhNNggGcVH9UR0IesPMf8sZgb66959/1xoqpWEyFFcL/3Jm8xK8m+P
 7jCrltbf+6eog1Fzuyuw5kOIsnItZG8umfz3wpdMCLy1grFEGK60WEbpzJeC8phhaBsctfAKEYO
 6mkRopykx7Arex1ldaWKxAAb5VbgvLjrL0OskdvRv+vZVKm9/RsnDj/Rds0nus3P93LNi4jiPj0
 Nclg9pfsbBY6S5PtE+g==
X-Proofpoint-GUID: VR226T4Mrw8ZQ8_dgMjFaEPmYzun9eVl
X-Proofpoint-ORIG-GUID: VR226T4Mrw8ZQ8_dgMjFaEPmYzun9eVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 7:29 PM, Brian Cain wrote:
> hexagon_modify_ssr() flushed the softtlb on any change to SSR.EX, UM, GM,
> or ASID, but only ASID affects translation.  EX/UM/GM just pick the mode,
> which is already captured in mmu_idx.
> 
> EX toggles on every exception entry/rte, so the flush created a feedback
> loop where a TLB miss wiped the softtlb and guaranteed the next accesses
> missed too.
> 
> Rename hex_mmu_mode_change() to hex_mmu_asid_change() to match what now
> triggers it, and narrow it to this thread's mmu indices: the ASID lives in
> the thread's private SSR, so other CPUs are unaffected.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_mmu.h    |  2 +-
>  target/hexagon/cpu_helper.c | 17 +++--------------
>  target/hexagon/hex_mmu.c    |  7 ++++---
>  3 files changed, 8 insertions(+), 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

