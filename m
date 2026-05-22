Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA533CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVvt-0005X0-AO; Fri, 22 May 2026 15:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQVvn-0005Vy-OD
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:53:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQVvj-0002N4-Og
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:53:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIOhvG4007127
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 19:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XsKWDZKjrg6cr2YH335Fc0/solFwDzGQG9OdROQFfPA=; b=CmGAY95PzR0GK+91
 btp9YHAl6uWz99XKLmVMjJNz2pU2sOhEUMiYq6GIZZ/RLFH4X7OJYmDUlIA046RY
 GewBZF9BJbyIH/+fUoX36Uef5gY82XwuDvV+Iu9Eh3WMr6lFEHQaiugiQujaGuYr
 tlTmAGdvRtbldfC24LojyjxJVXrGZzKmkuG8YBuysBwfWd2I5PZ/f2GIGO3zHjSL
 3jSztEMKkid8IXqXUVjQyqVSlaRjyPdVI0JjySuEIhqKfu/tL2+TuYjub/uiY7rD
 txrY1qyrFCniEUVjQTbQCeaEyMTJZaKVCZKmac/3BVssutEyUuaQBLxBZksjRwXt
 rH2++A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eavd988rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 19:53:08 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-57525c1ed46so6024313e0c.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779479588; x=1780084388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsKWDZKjrg6cr2YH335Fc0/solFwDzGQG9OdROQFfPA=;
 b=NubiGTQchRNUB1+8yj68gm5a3eTuSkNkYLXrGJD8Ap8tCsuatc7TEpieYnOT9ggnbI
 hBEY1891VC5Ru1gNf3RD0tn5jDW21rzZNgndlXKZUuNhc4EFnojIvoo+n4Hb+wa/vKS3
 oGkhynVBW3ljW2wjRixzLprMS5lPpgjTBXyMpHP974069S9e32lDWU7KAPRxezHwMd8H
 n2SFNmdqwIkzCAfwNpZudQWu0BzGGABSR4sVEwPpMh/9msEGoyJEpBbyblc9wa3xXM+Y
 9/eOKuL75MysZeWStcKP1wmzA7ukZ1pnCDIThu5meP8lG4ifPgdiULNsEs0BMpOMHywr
 pzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479588; x=1780084388;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsKWDZKjrg6cr2YH335Fc0/solFwDzGQG9OdROQFfPA=;
 b=JE4IEIKWxdc0W0LikZW6EAGooufX1yhuQQ69gJhofZTZUoRtk5VkuJ11y7fNxby1O/
 LhhJs0KQ+xkiyDQUuN3VH+v1egMQxoNy0CcJUz4H+79WIEC/wlmD6v9XJhpOrsPq8lJF
 oQfOedAQnCQb7M2pgDUDobxoSrnr15fhTr6ODDvZVysOGMVUi3J0bq3iONUWzNjeZ55L
 QWLm7ciuOLhRK+Vieimp/NFk9fasAN9G6Fh2wsgmShDdlYdK3i3P1LcYnOksfXlwfZiW
 XRjZrg3um+KG3bH2TYTz+s5EICQIa62L5u/5JBeRWGmWOzmEOFaO1qNuVF0WVMl3k4Vt
 lWjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KEQQhM6gWLiIdnSgX1dM7FH5TFX6XSolLBjtPMSvEm8Sxrcl0B1am8fiN4YSWCTChg8lx5XgYAaHX@nongnu.org
X-Gm-Message-State: AOJu0YzpqWWEMlwXcUdcgIF4jeM6xptB5wuj8kyaq/cGitVTaaAUpKrw
 n2qqwzlCPxtzbphYQYkt9VmgoUJPYQeHlPTnUuQ6i4sCDrJ6V9XwCdhWFAemVsSmAQhwOIq66I5
 ZWSsVeTP7DUjI/qoLUUVBa9CJSHboDUCDzGqbapOXZVM+m/Xvp2TN4TtVdA==
X-Gm-Gg: Acq92OHemGKxXCCvpOtszeF/Yprz8yCAjsSn5rWaCsLPfhX01DqIyoEmWOizECTrXH5
 B+RjkLFyySCSTFkbYZYGvEtcao6fu/yuP2XMUBIQYyupfpygWoHtSgHzVy75FYmitzo2l8tUEgq
 4S+Jy0EjmoLhrwgIkgsaO+Vxlo2K5NfsukCANogdJtkvfl155AhNMYLGcLHVO030X4Y5O7924bc
 RWIGMIwUjFyVUPFDht8llivWn/yN7SwPmwp4CMEB76vLDk5ewgWB7dLnfIa/dE8dp8OkJVzlu6a
 y2cE+Aee5aYcDA/An+Ra1beTw7TctnTEEccvJDm0N9OuxRPTCN4A/YiF1Apk3bHiXqpSBgTeYXr
 IIZ9F454o82Iat7+H84QJrmEZ9AjvwnevndvJVi+XvxAFiI1mKYmzuAkLLQsBeHhtkXAdQw==
X-Received: by 2002:a05:6122:f8b:b0:56d:3b69:87d2 with SMTP id
 71dfb90a1353d-58662ea14aemr3264094e0c.11.1779479587890; 
 Fri, 22 May 2026 12:53:07 -0700 (PDT)
X-Received: by 2002:a05:6122:f8b:b0:56d:3b69:87d2 with SMTP id
 71dfb90a1353d-58662ea14aemr3264085e0c.11.1779479587346; 
 Fri, 22 May 2026 12:53:07 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f915c4f1sm3509640e0c.17.2026.05.22.12.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 12:53:06 -0700 (PDT)
Message-ID: <80be3a4c-8bc4-49bd-94e1-7e418ec98ef0@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:53:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20260522033145.17850-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522033145.17850-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE5OCBTYWx0ZWRfX7jABK2FFpUb+
 sL7cyga2HbIsV9cZoO3GLCDVSY9bXfIdsXdUNTMC8FLATUkKFDBYvQ4AH3MuppWVCurQn2bTX1y
 4uwLn1ag/wfaO2iPTSQrMsWqPd2DZTHydvWKowQunhuCp9K7/u7mPmNhNlbsG1E4kXOfbNDzgNp
 4ixd8LPtYG4Ji0bRQTm2LYZaXpNwM+V6lJNxV8oQW6FqtHXt+15J1UYHsQNCUh0ObdR8NSh7OMQ
 Aq2T25s9/Aj0JDUWGzar7MEj7oIUkAG+XRECERhKoSztD2+24HpJKloOzZqi5QDIJeXVZKMpXos
 cjLOLgKqBmzdY5kOD+as6ut2cOUhRREvl498nEv/3/6aTF2zCnqCCriE/Yl/oxC32KULVi2WpTm
 nBa1dFZVwKhgHcYR6ZRmRX9COCWYlDZk9CJaMFOvbZ+xXm63xoLWxDHrwRE6/O5/aAS1tMo8QjM
 xIS/5jT+OfLNuRZrvfg==
X-Proofpoint-GUID: PlpYIY_Q8WQGKmwayBQZPCtu9mCOMCn8
X-Proofpoint-ORIG-GUID: PlpYIY_Q8WQGKmwayBQZPCtu9mCOMCn8
X-Authority-Analysis: v=2.4 cv=F+dnsKhN c=1 sm=1 tr=0 ts=6a10b425 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=QeKMtAd8cT00_o-szVAA:9
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220198
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/22/2026 12:31 AM, Zephyr Li wrote:
> The RISC-V privileged specification requires SFENCE.W.INVAL and
> SFENCE.INVAL.IR to raise an illegal instruction exception when executed
> in U-mode. Check the current privilege mode during translation and reject these
> instructions in U-mode, so they are reported as illegal instructions.
> 
> Add a helper to reject these instructions in U-mode during translation.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3493
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
> index a06c3b214f..4614c1489c 100644
> --- a/target/riscv/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/insn_trans/trans_svinval.c.inc
> @@ -22,11 +22,19 @@
>       }                                      \
>   } while (0)
>   
> +/* Test if priv level is M or S. */
> +#define REQUIRE_PRIV_MS(ctx) do {          \
> +    if (ctx->priv == PRV_U) {              \
> +        return false;                      \
> +    }                                      \
> +} while (0)
> +
>   static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       /* Do the same as sfence.vma currently */
>       REQUIRE_EXT(ctx, RVS);
> +    REQUIRE_PRIV_MS(ctx);
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
>       gen_helper_tlb_flush(tcg_env);
> @@ -39,6 +47,7 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +    REQUIRE_PRIV_MS(ctx);
>       /* Do nothing currently */
>       return true;
>   }
> @@ -47,6 +56,7 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +    REQUIRE_PRIV_MS(ctx);
>       /* Do nothing currently */
>       return true;
>   }
> @@ -56,6 +66,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hinval_vvma *a)
>       REQUIRE_SVINVAL(ctx);
>       /* Do the same as hfence.vvma currently */
>       REQUIRE_EXT(ctx, RVH);
> +    REQUIRE_PRIV_MS(ctx);
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
>       gen_helper_hyp_tlb_flush(tcg_env);
> @@ -69,6 +80,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hinval_gvma *a)
>       REQUIRE_SVINVAL(ctx);
>       /* Do the same as hfence.gvma currently */
>       REQUIRE_EXT(ctx, RVH);
> +    REQUIRE_PRIV_MS(ctx);
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
>       gen_helper_hyp_gvma_tlb_flush(tcg_env);


