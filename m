Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C5IgyyIt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hwX8Jlfz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMc7T-0007uc-OV; Thu, 29 Oct 2026 22:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMc7Q-0007uT-I7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:13:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMc7O-0003iG-Do
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:13:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKpJC2586573
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HXQwEtgGVyQ0yCT92ZfShFQNHzRZQDg/JT9wP+F7WaU=; b=C5IgyyIt2NwHr2eN
 zI53cqWlonAOK7ff2keXtCF1ujseqlnzk1JLJvVQcbDAiug4tYhfZw8HjLepFf9z
 Nq4pRmCNwzhDb3qJtK7OA0MT9xto9ZUb1RQ7vWquqJqvXNRQTyAnEPPyTK+AF6YX
 luxi7Ql8ntuXaxBieM7/IwoN+S241UclAFj9QvadyxYZn923VViysFpvtCUaok2V
 InFfiZFsfE8oj/tLuPcbyzUiOnEHlspxkO05gJZf/gy7wzUi3WFqHIlfkrr7qYQj
 B/ZTZxQzjBlv7kz86gvoPty5uWwpvkAHgcMkyi3UCfZpftVPOx3f0IV3L1CvvNWN
 qbflZw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme750r1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:13:19 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4c467e19391so382951b6e.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793326398; cv=none;
 d=google.com; s=arc-20260327;
 b=gn8WCENdiiDHWVTGdvGEB29xeHXp4zxOF/3p80d+aazJFGoU/zQOsLVtWcwOVmdaOe
 zZ0FKq+iZ+hAI9uz187vdNgCEwdga6WFihOMHPV/kLBMXjSkf/WqIfjUxwQuVhbZP7Ez
 /imV71JxR7nvmPq5iSb7T+TrAgtoMoHG5fRhbmxOviaIVNnvCRdftJz7bZG1wiF8fes1
 nN3uUsmOT7H+I/lvrSJxQU2GtJ+fDZ6J9jDSxdsSripQO3yj8csPZuzbmj+JpdMAh/pI
 jOz/X9VCohSmbd/HPWN2mBPjj9vfeuB/2N8CLWY7pzJ1yfihpOfWFgtapQqjmmXxMFlV
 i8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HXQwEtgGVyQ0yCT92ZfShFQNHzRZQDg/JT9wP+F7WaU=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=i0746VfnHmGMGFvD8JcwtfmFCB8chTg2YQ7RalWxyBkxSVXxxgml8cdL+J7h9T5yqx
 Em8QDXuemkZsz2JLgxEWdKOrs4PScfiTvKX18YvVV//Nv8Xsd1djrq+wtNotpxC0QxYU
 7TQXLaHHoLrcADIpU6Lcc6DhZfU56CjFzC1f95OmZbJXlAi2eiFOPJrchQyz8zdOXySn
 VF7Tb+ehxfmpGGJQJStxVdZyS/100sBMfW+udXIfGraAC0dMo4mv5fcPDA0g8OqyctJE
 K0q7D70jaGjkTOOGXU18q0Cd/kXAqYBVKch13ow7J5IkFE4CvsWzWK96y+3YHanX9UpQ
 1dGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793326398; x=1793931198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HXQwEtgGVyQ0yCT92ZfShFQNHzRZQDg/JT9wP+F7WaU=;
 b=hwX8JlfzdAcjXHEHLKC3XlP/PRe23ceXy0RkbNBVppHHHvc8OENeXRwG61CD9S8W7D
 zhkaONRItNKCfStajsRiqrBr3or4jbkcCBxBrREwxKS15Ly6sa7PFzRIWriwX0ljnpDP
 76v96zLm5A7W5FiDuJbw3qjtfXE9WAKv/Q1kPxDsL6aUs1FOM19f8QOjLRyYf/drpjOx
 F78MlahlksGre943iKIzbO+bCvlFQWSIKpVL92H1WvCDf4jCFL1oaNGptO/ul7bBaK/+
 JNT3GG8GW9wa5YMPGvsPSifkTg/CxfCKRxbWbUKOdXPsrEQCy9k4iQO/T6t7TQbCMCRo
 K5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793326398; x=1793931198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HXQwEtgGVyQ0yCT92ZfShFQNHzRZQDg/JT9wP+F7WaU=;
 b=lZlwXyncWRYTH+eAXh1HaQAmUYzs2odlAkPNFcDQhzyc0yjjNWf+5tI6f8cVMknUfR
 S67QV592mhbZeKvZ0h/BbiaBx6MtYUR+NKxwx6iTjnLdmZXP0UGzorXN5OmcsHrI29jv
 Wh3fCjANJoU9nwYvWgTM9Z9UXkEP1CIhqksEY//jkkXUXdsCYSWRHKYMkMUj7eUO59ap
 NspLMISaqwpTUbk9qVSrXx0s9i+cl4rTNVpPQAvYKI9wc8aGoWtie2ho2z0uTe5nO0q1
 OVC9VUb+pqFjqjTD58DP38MTISD49bX8Ght6kyio2nJHEgM7Ofv5sfocqzSwxxdCpck5
 kM3w==
X-Gm-Message-State: AFq9FYLPSUn+OaP8S4enSGO1hQi+/FvGvR8j4a14U5SRsWt9nfuBKuqH
 0zFDKBAwC7Q591oHOuM2SsSZzuWyw956/T2fbmII8ktWY4ZRTxSwfEkSbS2qWR0qRgnnEafqgX/
 jaHeI6oGSogF3w2yHgatGcKeOOkegvcihXicWQauGChx8L5fJ2BcA+FDWTKRxwraKL0THycPi1p
 dWffWkxUApCfEkLi5ytx+FHuDAE0q6qTbJ
X-Gm-Gg: AYBFou3hsDhRrXYXTvJiRuugzopxOI691Vdg1HEEyKi0gqL+6wVSCyu8KIVlQapKvQr
 +tD2xAwNto0APmof6vRQNvBuAsOKTGFkSmfz6zFOTBoMkKX3okncP+VAeFPmflKxMO6GL7MlxZ1
 xAVm3RzFH7gvtLAaEUScTnMoYcRjNcV+vhbTw53K8vS6zBbHMd+rCIAsrdC1q0G2UylY0+1HdTO
 y/9H3qKhXegBlMw3rM=
X-Received: by 2002:a05:6808:16a6:b0:4bc:336d:7494 with SMTP id
 5614622812f47-5640dcbc82bmr755055b6e.30.1793326398398; 
 Thu, 29 Oct 2026 19:13:18 -0700 (PDT)
X-Received: by 2002:a05:6808:16a6:b0:4bc:336d:7494 with SMTP id
 5614622812f47-5640dcbc82bmr755037b6e.30.1793326397803; Thu, 29 Oct 2026
 19:13:17 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 21:13:07 -0500
X-Gm-Features: AclHuK-TVT2_ELAhHfCULNV83AtrJskuX-_4JIkCbVGNReoJOJUqwY2gpMlakxI
Message-ID: <CAJ+KCYPch=0-urSvviceDv=34a-f3W7CMY3RQyF+DuFH4S=qMQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] target/hexagon: implement mxclracc
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: QHUxaZA7FjK2-oye01GUphVeVvbkgd3h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwOCBTYWx0ZWRfXy4aWSI0CNKpA
 vy5IjQeR1LG6ylbVHoyZpkk5CvdP5ANNGT3Inbx4GVOI7zZLfzPnavqUhqX+is/nE1A3H/fcPWP
 z0kkWSN5X8ooCQdgMPxZ0VDfMrTu+SAo7PJ8qZAygILG9Q69ZdMzk4oQJcTHpk+z9KrmNMsRk8H
 +hz2cyEiNMY8D5yOMylQ4yZUyXIEfG1mIn55LtlX6z6aQo3rybhQjHbvmrFUtWkc7tCiMEobXdv
 mPQfI8wm2sY8auE5OAV3eI71F4Hpycq1LiN/T9rgCNFM4em1GAzndbRUq8TJhO6l3Nm7z9oBHmm
 VSygqpzQRFl1Qg8124KyP3wyaJijzNMZejJ9Nk4FxDBw5JQmlUv57uXGIk9uf96I0G/NzJzdp3h
 PkzG4LYinn5cbYzBq7Xrf1jB3zxVy8tF87TwfBA10v1vvRqA+SdxGTvbm4ty3BRnpKmJCLre/Or
 FC8i++syJoZyV31biqg==
X-Proofpoint-ORIG-GUID: QHUxaZA7FjK2-oye01GUphVeVvbkgd3h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwOCBTYWx0ZWRfX0Aov8J6uLbVI
 He0UHwZDn8ZRkZTHy8fQoHirFYvk0x+b1yNR6Kc3CAV+isjIilAJvyCzBsnqFqhtKctzfp4C0JS
 bLUOvBA0h0+dQTcTWP2dO3SjmBY28QM=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae3fd3f cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=r2J4ug_ZKYP1EJ14--gA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300008
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 6:03=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Implement an HMX accumulator clear instruction - mxclracc.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hmx.h | 13 +++++++++++++
>  target/hexagon/helper.h      |  2 ++
>  target/hexagon/genptr.c      |  1 +
>  target/hexagon/op_helper.c   | 10 ++++++++++
>  target/hexagon/translate.c   |  3 ++-
>  target/hexagon/hex_common.py |  2 ++
>  target/hexagon/meson.build   | 13 +++++++------
>  7 files changed, 37 insertions(+), 7 deletions(-)
>  create mode 100644 target/hexagon/gen_tcg_hmx.h
>
> diff --git a/target/hexagon/gen_tcg_hmx.h b/target/hexagon/gen_tcg_hmx.h
> new file mode 100644
> index 00000000000..d53d855af51
> --- /dev/null
> +++ b/target/hexagon/gen_tcg_hmx.h
> @@ -0,0 +1,13 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_GEN_TCG_HMX_H
> +#define HEXAGON_GEN_TCG_HMX_H
> +
> +#define fGEN_TCG_M8_mxclracc(SHORTCODE) \
> +    gen_helper_mxclracc(tcg_env)
> +
> +#endif
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 8c49e798093..70453bae61f 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -31,6 +31,8 @@ DEF_HELPER_FLAGS_4(vacsh_pred, TCG_CALL_NO_RWG_SE, s32,=
 env, s64, s64, s64)
>  DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
>  DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
>
> +DEF_HELPER_1(mxclracc, void, env)
> +

The helper is only used in builds with idef-parser disabled. Since
idef-parser is enabled by default, mxclracc gets an empty
implementation in the default build.

