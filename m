Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD736C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqa4-0006aY-92; Sun, 27 Sep 2026 11:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqa2-0006aQ-Sw
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:14:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqZy-0007qg-M7
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:14:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1i6Os019103
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +MG/6zq+cpXJg/zoxzkL1MHl6smZf90Qz/s9q3xtaRE=; b=Hg2Ot2508fZwo8kb
 7IV4AlAAT0XqZptiBHZrDDNYi6ctdeur80uVVsrJ6FbOzNgmOELmy9vmoPFFFvqG
 H0htN4AyAZUr2yk/YeZUGGe8xA3uz9mNymyVtXuSRJ1xnT84An1AJl3Kee3EA0VV
 b2K4tPdcb7OP601Y+NL+0nVVBBoVbwsg0m2rdObOeOEwWWly7LXkfReZZOntooee
 JN7BTZMRKBVZTk+m4qprWJE/JgtbZvKoXvi8XKv8jymxGiDjvNjruoltKpqUClG2
 hlbcX0YH7qsxNm8qPXgRHkxMPM3vI4h+ySXpHWvAp3kLhWbeVd89FKv23jb/2Q9S
 7mF8BQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77ju23y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:14:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91235881828so45216876d6.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522049; x=1791126849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+MG/6zq+cpXJg/zoxzkL1MHl6smZf90Qz/s9q3xtaRE=;
 b=ei3UD2SrBsCyQlSzHuSIL55mJToSeRuT5ijPYZ/CXt6RobLnWZIEH5WlD4Yz2jrvrd
 0FVJB4C0BrYZY4Vnjzlc3qYwJ7vBnJtpFb47Epw4Yd+K5gJE2t5mARARWMWdHAaldf2a
 wD90zqMwZUjkv1ftOEnVp/ljsgBB6ls1vFwgKgfmJ8jRqsdCogGED+Kep1id+CYTK7fW
 uygSK89oVKhdjKEMS/vu1pXHJhocXA8qv+esr5cqPoVZORwPLZFI7Kh8FGHahcUXM9Ez
 SAHY5EO0Id5+LmIm/AYGIY6KfOf0yDuZgxzDyND/ECWt/d+Pif1M2JG8cAaPfcZMvZai
 MzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522049; x=1791126849;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+MG/6zq+cpXJg/zoxzkL1MHl6smZf90Qz/s9q3xtaRE=;
 b=gUe87behPntHjx5VtVNdNLMKaSiFrpowIhczs5g6rNmIX98Z+CmkzXC1Cip8WiWqr5
 zmv+1HzL6I6jcZEaks25+NP4C2+20pXZI0mZVP0nBAw0+YyBdxGpB0m+YFgk3QgpiHni
 GeIl1gKGpKQVjr0DkJIobT6eNs85TsPtLtZbkUciUtUT38ajyIq/N5jUeBMxE4bbSkCl
 ym4djKImErmIOlbKlb3xWCVQNaRCJDIpTNEbvgjA6wEG4QqbIJ9dpyBv9WxU7uUAZ/1S
 wATjWcp7p3GflZ0a6oUv7krDh5J73LnGV2O7pyvq/yiNejV+oCsxGdXWYeLfwZFiMtKu
 qlFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx0F4Hp33uwxSSsbuFlFsjVbMI0s4jYvxZ4U102cMCcNFiE2Nvg391hrQkUFwrLx+7RfsRp81BievT@nongnu.org
X-Gm-Message-State: AFuF++lcn+yEFFIDOXMudDb4Mx4KSPQyhMatLyOtGdKyA0rqZsZmG11z
 XnD4HXHPDpGeGVNBMRWEcUN8QaPe0NHEp6jU3PTphSbkbhsEIJIOGv9zuC6JkVhpP/xJtKU1GgI
 GgDY4KHM9O1EVJ+2puotQXCJqzcm5vuxoWuYwy/ezwmyafWjcYDa7sviqOw==
X-Gm-Gg: AYBFou3TUtdE1QJJr/3j6/QKuIZTMhg8EY/dWhW0Mv/L9QUAKZDYpQKww+ED0TF9Iuh
 e1KgUBFVOosdqLcYVLRQ7/5i6prInegsqSyzwwED/5hJCLCN0A/J3/ePpJiyNqv/RoikgOW0Skh
 xXCC7dNpqueEuxAOUtAr3JHA6YsbqvPE9XIqVfxdcrfD6D7tNb7dkwY2SZoc4ZBZJOTKn66uRsg
 BRFKl9Npd1/sr3SihhH3M+uuEbH1nmaH3/C98Yr4fTIZ2oQxI3LGx77VLexIoUooeYI6ekxYasz
 vic4iC9Vm4UmAuHVsR1DVZd3cY4/bgH46jWAkXp/53NNXrhLDjAlI9D4izanrlm1wox7ZY1STc6
 2FV9KkYlq4aQOvLYPvAGZKhKFqVVM5ONV0A==
X-Received: by 2002:a05:620a:439e:b0:93c:6092:ac66 with SMTP id
 af79cd13be357-93c6092af0dmr694436385a.24.1790522049339; 
 Sun, 27 Sep 2026 08:14:09 -0700 (PDT)
X-Received: by 2002:a05:620a:439e:b0:93c:6092:ac66 with SMTP id
 af79cd13be357-93c6092af0dmr694432485a.24.1790522048932; 
 Sun, 27 Sep 2026 08:14:08 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349fa1sm30434434f8f.8.2026.09.27.08.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:14:08 -0700 (PDT)
Message-ID: <e6d8c507-76e5-4297-bf00-552b8eebdd00@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 101/101] tcg: Annontate functions in tcg-op-common.h
 with QEMU_*_NONNULL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-102-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-102-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MCBTYWx0ZWRfXzcijQ2TdNgRP
 ABrLqD7sS/1bd14N38p0MhLWtxIFzoD2/sCRstLO4sPTEGUlQTJcQ/fLhsH9gILjZxhZvhJGSOZ
 ji+2UZIKSBpAgL+rmstP1yhlPNenHQo=
X-Proofpoint-GUID: Nv9sowNVm6yNlSkLUDbXuD7lIoTYX_yn
X-Proofpoint-ORIG-GUID: Nv9sowNVm6yNlSkLUDbXuD7lIoTYX_yn
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab932c2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EvnmfKsluGz6jfEFULoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MCBTYWx0ZWRfX28WJJp4o7OHd
 ckAEKB3oGF5cz+ImjwgHwtlZCeUgu1A7OuDw0tofTmJQG+z3vLz0BjL4SsL5HXTe18qhUjksoVu
 l/e15KlCsuFebD27yY3DFeY9nnn2B7nFeSCOj1hhYg0SRhWDTsiDDYajc/4O7WUFSW2I1ohUAFl
 niOHjsKFRyXA0PyE963ov6jX6vGxLtPRgQTJNDQ3JMLG1bTLLGtMitlcLO1f4CMnFEvPQZS7PZ8
 jtnpXsFgm2oJsOodLRnjmauyUwAKFODYGtqSv93tUtr4EMeG1zrF2UHLXXRmywirJMfG//xJWYc
 RuJHCW190n2URZhCyClpfBhJ3i8dR0GkfvDYpSUKNbr6guyafCqXDyVxDkzt21NNBJvU8eKz1VD
 NRX189/3o7c5viTKMW7iTXDk1wOu7z4Gw+vCSimHuQ3HqIgS3Xasb5RY1EQ0DM/SMGbTWJgoFDF
 igM/FWf0XDMaY9d5wIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270060
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 188 +++++++++++++++++++-----------------
>   1 file changed, 99 insertions(+), 89 deletions(-)


>   /* 128 bit ops */
>   
> -void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
> -void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
> -void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
> +QEMU_ARG_NONNULL void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
> +QEMU_ARG_NONNULL void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
> +QEMU_ARG_NONNULL void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
>   
> +QEMU_ARG_NONNULL
>   void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
> +QEMU_ARG_NONNULL
>   void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
>   
> +QEMU_ARG_NONNULL
>   void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                        TCGv_i128, TCGArg, MemOp, TCGType);
> +QEMU_ARG_NONNULL
>   void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                           TCGv_i128, TCGArg, MemOp, TCGType);

Could we unify style and prepend the QEMU_ARG_NONNULL attribute always
in its own line? That'd reduce churn and keep declarations at our
coding style line limit.

