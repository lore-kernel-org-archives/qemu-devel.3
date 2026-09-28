Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC61C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB87E-0001Nq-9u; Mon, 28 Sep 2026 05:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB87B-0001GZ-W7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:57:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB87A-0000Av-98
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:57:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MAMu1446126
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h7N7G2SdGrMBV3pKGE38NQ8nw8Twr6yY+uh7h25yhVY=; b=NEPO7InwxEzI65Sb
 CEWHV7Mb4Qw4VhRKafytDo5QGOro74BA/K3L9y0EE5lPOkV+9EwnNGMJf9aG8L/L
 1a2FXIfAw2pR+Mcdms3r1rgaFhJaOEAfFMevfG4EvTYSd9cDuEIgt7evSgUCbc8i
 /zzklY1sUv+bvJqWlAmvVgG1g4iIh0SOS6ahmeX37AkQnLb3rRldq+JFjTQlPYj+
 /f9Jg2tBL3WbuRT6gpDQZ7BVDqk/6u20p6x43DCrF+RYdwhcsyobbHh9zTLoQgVM
 LGjFWGtSq88ac0ipOSRri1yRgpJi0TRFblTqeImt+85+hNmuc/ip/Ufy4BHqtWyJ
 5ZbSSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkr5bp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:57:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936708f129aso562873285a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589458; x=1791194258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h7N7G2SdGrMBV3pKGE38NQ8nw8Twr6yY+uh7h25yhVY=;
 b=YTMV6yLAHsq1cV+q9+ZewfkUwQVYsI2VsYDiIIyvkH3J9ZdIPxagjwacS2C3MER/FB
 UHxZxoVLuqMOK9SPJvp5rUG11Vy4XEt1ut1fn9P7/JBJxjO4fzNJlfPF6PY4JIIaZZkt
 /04PWeYcJhZsQLqn7fMyTD221Qp8r+wc0KH0MMBtmEdT23CF46/hrhzuNHwQUFKKCQac
 zAJQuNnAQKNb1NYxQhQfW4a6G0UuvsWcjVStZruyLM4aeQYir8InObvgp1rcUoEcHCr/
 W3vwHXaMxVY+uC0+bILvLkoH0lRw1Nlp3hCv3S97N81h39cWG4mpx1S+c0gxa9ENd56R
 X/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589458; x=1791194258;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h7N7G2SdGrMBV3pKGE38NQ8nw8Twr6yY+uh7h25yhVY=;
 b=XF12L5/FE2eysGgZRYwshtP2DM+keDTYy0bMK7zMN7jyyBlPNTgyCx0ibTiHAy4HRj
 7odLYbKKblfa3j+a151gLFdYu6BbIrPvKHG8+1XjyAEZuwO6zdsHqThFTgDj3JR42ag6
 C/41scUTTvOWFEdvJtcFKh07H+FtHEwSeByCDk9Hb8HkGucQDhXhE0qrCcRHdifi7xNV
 /WCIB7iJtZG17LThx1SqGb2r6ONoY4wzTzpWRkRityHTcxmRcJ1WtktYX7KQc2NBWsOy
 A2/tPkiiv2N0cftrML2sF5oB9QWJnSldoFlTlymO+vgHT2wZL4J4BKPftkt6o3EojPRr
 GDSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0d5kzVEPR4dCRS3dvwaDZZvr/EoH1zEFU6PNlDKMG6fRlnK8Ct71ueqEsGSgruKkVBbM6yScOttge@nongnu.org
X-Gm-Message-State: AFuF++kMaCI06fYfDtD7/6ijRXJ8LH8jSSFMo4R4+6kz5RP3dYSkMFpO
 GEOnag53QUqxBgNOVmVVp67S+HN5N8CQon/FPcohT0pHtKeag/T/qD4sLEekh9IwddUoK7sgF10
 jq1m2IaLEMYezWiSXEQyJze7OkK6L+Sp2VfXdEwT3CG5m36WsYJSEH+KkHg==
X-Gm-Gg: AYBFou1qRkv7kf+Xlel1NFhhQx5yR3y7MzNefPoiwYVGjhme+rDAMa06GbOoymrWfNY
 0lBdFqnwkI1TQmJt8ROsLd8bBj7C7DgxDs0lSGZhwcznOcNjKIhF6C8ONn8Cj/yH9+3G37UNUR5
 wE766wHcqo6IJSW+ubgjRa+y59i+gxKakQ1P04GH7GAeZKtJrdjVXnX6GJdR4pvYKdKSFoeVYIW
 Dee5XYh/wRH2u17C3r53pcaZ7WJ+iFbxTy0tev+UONZEX5icM74TKd0BecI3yI8ESndDOexki5O
 SIgy0Ym5BHWjE0XCxbJoWx2+L18KMslGlf6aRMJY6BR+08n0lXZF13ylODxAMme85qaFAEYXCNl
 k0XdXq7JCS4bwWY4dJT7W9g1BoEZJD7cguQ==
X-Received: by 2002:a05:620a:488c:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93c43c6067cmr2051363685a.16.1790589458171; 
 Mon, 28 Sep 2026 02:57:38 -0700 (PDT)
X-Received: by 2002:a05:620a:488c:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93c43c6067cmr2051361685a.16.1790589457694; 
 Mon, 28 Sep 2026 02:57:37 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee915f3dsm217835305e9.1.2026.09.28.02.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:57:37 -0700 (PDT)
Message-ID: <8fb2a8db-2054-42c6-9b1a-c77b04673af8@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 088/101] tcg: Generic expansion of tcg_gen_ld_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-89-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-89-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX8OhHeNzh5odc
 q1tJz+gMazrX+kH8CZkAcyq+YQkJ7EAGhBbZiVsWdyzO1QH1Pn99Zb9lHGm7EQSZkwQvd73/28j
 qe+AcKbtruDJ5wy3c1edC/K0i1ZBUzasPPXKzQp6SJdOZ/fmKmLHlZtqSJhmnExDluN6tV4PgSO
 PP5w+wjn357IEYKJQWHBT4oK7MRtP5mBmYLoYmOsCZlARf3mq26zkWB8k8yJU8qSxUydtwtWiG8
 tQXQsb6RWj5y9gFxAoGKAtCilPNmPvaZtaR/B5PSRGttzgXMBHLKvTBIdW+qgXyvlfZK3Ntt/SZ
 7RCsfSyk7FAJHwrxTKhCyVV6s43g+T0q+vwCO2ij40dCGIILFZZmwcT2T5RLwp2Q7X9N8AnsuiY
 lcHc6Kwk6xBI6Z1GIx4/qlenoFJfcrLsi8d9Nw46S4qya+pkBtVIxyaebQI33g4hF5UA9sdoxff
 KKRzf564T1oGPFGEZYw==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba3a12 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0hhrMJXmr9e5IoH61XoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HkkY_Y0AFlbptbAOMCZ7yfemL3d8OAWu
X-Proofpoint-ORIG-GUID: HkkY_Y0AFlbptbAOMCZ7yfemL3d8OAWu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX68C7ixDUVPRK
 tvYDE4vIpxYwjDbGWen7KD6ibB3OC6AccwDzbLrVJ025rWOpJgNtXVIWjCw7gBXRW+w4eTeRa/a
 lX9RxJ48TxVATKnnVkB6bQusZr7hbDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   tcg/tcg-internal.h           |  6 ++++--
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 19 +++++++++----------
>   4 files changed, 14 insertions(+), 14 deletions(-)


> diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
> index d6ea11d8fcd..bfd34905ee7 100644
> --- a/tcg/tcg-internal.h
> +++ b/tcg/tcg-internal.h
> @@ -191,13 +191,15 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
>   #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
>       QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
>   
> -#define TCGV  TCGTemp *
> -#define TINT  int64_t
> +#define TCGV      TCGTemp *
> +#define TINT      int64_t

Squash in [PATCH v5 009/101] tcg: Generic expansion of tcg_gen_mov_*.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


