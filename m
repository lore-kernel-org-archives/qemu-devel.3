Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDC0F46C66
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oHH-0002UR-Pk; Mon, 06 Apr 2026 14:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w9oHG-0002UG-C4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:02:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w9oHE-0007YD-TZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:02:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636DuXvY2420645
 for <qemu-devel@nongnu.org>; Mon, 6 Apr 2026 18:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hgIM9T3uC7Cv9IjOlY0NJn7QAK9yIyx7nFIePjs2i6I=; b=Ch/0Z+KassPqb430
 EDU6zNvtI3HU9tVlO4UtkaD3VdXdTz9FobUR8zDT+xPQrRuerYZGrt7ULgbJ8YC9
 tQW+ql9lEgnF67TZSRIJ9t/2ouD2Oi9B6TLwm00GV2EELhDbnSl9haPjCO0DCsKf
 vGmNIczAIz+plzcSqFFrn4+2JJwzyAR+aIlr0scmybmbaOZKnkbrE9Z9MqSyNVRe
 hln7Qmn8NK4BsooqMSawCnNNltDuZcV7+fMPSTwB+BPR5zv6LrGxsfXnqBjrppu+
 13Zlh52X1cXjJX134y3N3duXYf4HHEus9VcTDuFl2NbUKeYLZB6lufP1P0Urulz/
 yIB2MA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dce5jru1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 18:02:18 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-471618e2082so1051281b6e.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775498538; cv=none;
 d=google.com; s=arc-20240605;
 b=c9vjEzKg9MbZek9q8HNH+RYzC12keVXGkWb/HyJ0VqGVMOIKBMljJZGMNSE/mGZGOK
 UUedfMoh0V4yT/u3CzyWhoOUtApmSyfGZ9MYbA1KSfHX5bA4Zx+hH9aI+2NQkoSHFSEm
 rSY6+QBkWLziq2fzPv8RdYHuzcLG+0bsiW4ZWVBJZ2W2Sk6mDlbyGEuijfj036XgxtnM
 16x6KZG/emr/b18v+E2Rjx4vwd3Nz0SnWkmaE+xlU+zTfQGYYjyVhRbu7UAmQsr9ErTA
 nAXn8Y/99CmWYRBCEMD3ToumjL6nBV9pQRAbfAZmKQhol2ahHcK5IxgkVo/B1vMvaixw
 dHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hgIM9T3uC7Cv9IjOlY0NJn7QAK9yIyx7nFIePjs2i6I=;
 fh=o3W5rBryHd5xcK8vQ98UvCxdM431zpyrnojV2RHAKf0=;
 b=eGekaTyL3C5TFav1Zi08qUkfm9EDSxU0rYDO186HQKO4wTfwqZNaJLCegD4QUL7CTd
 pf9whVGAIrQELymX5RN/ylmY3fbtUD+0VehTE8BroZmtSWXciWgP92LmAYnlSi5SaFcU
 v9dFnotAZ1KSguHTqZ0oAgIwzpDqIiCJvG5QeCpF9jyi7RaMlcHOmSfcMoARjAHn9AMM
 serqLhsC2qW3m4ZMFJcru31ItRkY/81lkpc7ZCoCqZv2a3dPiqJvL0G7iGvXBrEU2Rj+
 pDMaDt1hGsKnUtkfd3VO4rQwFHOiePGu9JI+OzbdQzPen2p8+N2U4GlrgkbpSjHIfc+y
 Guiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775498538; x=1776103338; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgIM9T3uC7Cv9IjOlY0NJn7QAK9yIyx7nFIePjs2i6I=;
 b=LicplMiEocQ4eG42mb9yUItPenP58tAE+8/4cfF+sgj696Qzuk93Sc5DwhTftuurcM
 guy4saB/5IjfpjqAnCNRw8uMrfrJbnN6874ak7h8OvQopgp1CFxkJuCfNMkm8pJmmzPN
 o92LS7r/ucFlJqsMBn599b574tt7mWOe8A0Lk3VoNO1ZW95VTSujIGuA7n+qGw5Tw7VY
 Y1zFDOJrJq5XGCKVsoADxR5b+hw9LYL4nss3FaLWBlkvHZ+8xH9//V2OP4U0IVW08rdE
 fXJRQ2bxPFC8g+1nMEcJrZJ+VOqXdFp1/yoTv5d0500pUK99YlY6I5HCmxDyq++eHzzA
 NhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775498538; x=1776103338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hgIM9T3uC7Cv9IjOlY0NJn7QAK9yIyx7nFIePjs2i6I=;
 b=NOXYEJz2dPzMQWOEsH3Tgk+4MeTr5M3xQoDNkB68AhXtkNs4aIHXhoHGtlEwRM8Obi
 SpQpyOkgSoyiNtiegVVriP9nvA3f9LBJ05L1PWhA+SmOPR0tFQeF/hcnOtDF0HoM5np2
 Xe+7RIOB3Pdr2gj7/080P/QXrFoH144MGFjGXTBo7JLfkYRjnw4trwX7Crsz4FYuWINd
 Aa9TUQx8Oier2aP9VhXXlP/ZGKcpwQk7maq0+FnqTzMhNnHEdx6eOOtWGIuZWo2hUcHL
 QsMutK8VXys8XWOqJ0u4DKgKr2PSDtQDn2pYj+4r+TPgC2pL5YwBX4uKL9u36QGrM41U
 57DQ==
X-Gm-Message-State: AOJu0Yw8/GwoyN+ugOkg5Y2taXMumXF93OHYFAz9bryMGy2qkBQ4q0Y3
 2wjscoJrzHm/9alBQ3Fbaw20D6g+rzVYm1SmMaAgCMa4b5RsRU5rNreXJsCaIqQIZGrBa9Hc7Uo
 FQpz5Wp8w7zsl3+4jG7+7yQiVimcB1zfUfsGarlzTcw8adBdEyhC8eGS1jEhkKirY5ttunKftP8
 uHiQsq1nA2qXbR62F22o1GeF295WdX+n1B
X-Gm-Gg: AeBDieuk6rCMtmwUV7kFnrs36dYTHNPUcYEXC9WQGodyLXrmAfDD39rs36zz/h1vvkU
 yxJlG2aiKZzUWM74MXoHn6oOvnAIUpOXa4P0Oxq1D82RWMbPWNZrmUlWEWl9HneHG1z78E8SEFz
 eYlDdFvp6uVACFGmZpEyMbSsNEctUvZX0jbtXAQ18niWuI0kIBrd6RrGqbGY+ywXoATKYeHziGb
 Wjjx60A
X-Received: by 2002:a05:6808:c147:b0:467:819:dc61 with SMTP id
 5614622812f47-46ef5bfc425mr7405713b6e.23.1775498538132; 
 Mon, 06 Apr 2026 11:02:18 -0700 (PDT)
X-Received: by 2002:a05:6808:c147:b0:467:819:dc61 with SMTP id
 5614622812f47-46ef5bfc425mr7405655b6e.23.1775498537509; Mon, 06 Apr 2026
 11:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <051a28b0-a67e-4da4-a13f-ed88a69bd629@linaro.org>
In-Reply-To: <051a28b0-a67e-4da4-a13f-ed88a69bd629@linaro.org>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 15:02:05 -0300
X-Gm-Features: AQROBzDUkSnRJzNLYj9FTUsD6mxpRMoH6YgJTYPxMOOuQHX5O_4Xh-V6hp_1Nak
Message-ID: <CABrGZ+EggQ7+m3aDTx_b+wRRcwW5LzWbM=EBrW1q3Q6kOGxDUQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=R9AO2NRX c=1 sm=1 tr=0 ts=69d3f52a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8 a=jvqndH0Pf1sxCXTLGR8A:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 897Le3Hw3Cs3gIK_35wkN_JpFFtAx6kl
X-Proofpoint-GUID: 897Le3Hw3Cs3gIK_35wkN_JpFFtAx6kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3NyBTYWx0ZWRfX1xFsbth2a+7V
 IZYJhT8WuFJGLV/DdLuGjXCwal3SNdyIhGF+F8k/UpScOVAblJlVAagu48baG4bBQ6Vq62oHl2K
 a0pJvGuFlw6EwHg0btHNujvFjapifzQF7xPBFN6i+DB/xP4HAGDYiJKc2yBD+/bN04DtnBe0w+4
 t3ERszd2Idsrl4lAB897vXJU4Mi9mIf/MoRThDPw8InL5bUKqR2qHMvjTqCkSronvmXEKqDwGju
 791woOFkv+l+Yk9AFLjnjBSupbSLXv52nEClyGjvzrNZgT2KJ/r/fhXqkctHvys4+06LzMaFTkT
 8XNCK69Gnn6RSv/6FcFmmMXV0IMJUWjR0PnbGEyn/BuHvOQ2o322bfnV1EZPAhcZmn0b8beLCJq
 VVHXIykjvTU0uuGFwfdFtmwin7OGoBGow23uIHM6/3vqtRUBGeh2zwFop+7x/d8jt8PwxqhZFay
 XoOgvNzTlrAPgrkdf9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060177
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Apr 3, 2026 at 6:47=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/2/26 20:47, Matheus Tavares Bernardino wrote:
> > +++ b/target/hexagon/mmvec/hvx_ieee_fp.c
> > @@ -0,0 +1,69 @@
> > +/*
> > + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + *  SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hvx_ieee_fp.h"
> > +
> > +#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
> > +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> > +                           float_status *fp_status) { \
> > +        float##a1t f1 =3D make_float##a1t(a1); \
> > +        float##a2t f2 =3D make_float##a2t(a2); \
> > +        return (op); \
> > +    }
> > +
> > +#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
> > +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> > +                           uint##a3t##_t a3, float_status *fp_status) =
{ \
> > +        float##a1t f1 =3D make_float##a1t(a1); \
> > +        float##a2t f2 =3D make_float##a2t(a2); \
> > +        float##a3t f3 =3D make_float##a3t(a3); \
> > +        return (op); \
> > +    }
>
> Why are you using uint32_t and make_float instead of declaring with float=
32 in the first
> place?

The helper functions receive raw bit values from the HVX vector
registers via the generated TCG code. The idea behind using
uint32_t/uint16_t in the signatures is to make the raw-bits interface
explicit, since make_float* is essentially a no-op cast. But I can
change to float32 if that's preferable.

