Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BD606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mA0P3SjM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DLVDlBn1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJx0C-0000iM-OT; Thu, 22 Oct 2026 13:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJx09-0000fB-Bn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:54:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJx07-0004kS-MA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:54:53 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MEFCuX3048063
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U9cIlg/kuvejPKkOUohaAEGtRAZiKH0kfKhHaydnU5M=; b=mA0P3SjMQIkVkvRC
 i0/Z48+yt7AUWKvtIBpogLgLKiIvcmCf7uP8DXCP/KufB3XqTT57TwrxsjSKUN7A
 8UdHoNyXUxjF1FdmDW2mKvybbE3sqDVaIWhFxM9uwADDcvZ+KEY1wF88hB+FKSgw
 t+ebk7AorGQD2frkncpW5kFZf/joi+J25xKW7nGlaHBTAqkPlLmc2sqwyYJ5absh
 GT1wT+LMflvDUre9xdWaQWFi2JVI+77X58GmdKWw9GKCkqA432fK3mzMQMWmnb+N
 DYiYdLyFs4RnrZsBKlylDih+cwb39hS81NlJWQew6Op8nuQcYTQS0qkki6uiE4g1
 bwVKIw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bw2wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:54:50 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4cbf700ddccso169187b6e.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691689; cv=none;
 d=google.com; s=arc-20260327;
 b=UksYhx6sim92eKPBpjAk8rWmjpVVdaJvhCzBS5BjuoHlFrM+ru1+YpHcsF4HK5kjHY
 LaFvngOuDo6ec3XjR4Kt6FWyrc26jryV+fO6is/2VllP3AUdX+VvdeuoG3EeSmYtZNAV
 /Yp0XxZ/OKmk662/4SCVwDmlKWvOVw1NIdRdbGzK2OLI56HppAphp+qJqDTNi7RiQLap
 KEiFXOtNkDLzyMi99V0PwGSOZ7m5x3N3nCY6vzLMj5de0stXFiwf6GUhEJS1mEJVR4z5
 /ZquvURJy+MNl2H0F4O1ek6zt4ENN5FUx6p7m6MGpSs17U77BQBPEC6krngGfpizMSAq
 yRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U9cIlg/kuvejPKkOUohaAEGtRAZiKH0kfKhHaydnU5M=;
 fh=91Qh0CwNy7hz/SABiv0vN2wob3TmMO2eFI2qsEc3U8o=;
 b=ZPczkbyIAq7N/q483JSpdhRRxLQyrn/ZVNoOWJjh+rK54GINsJp+oHkpSUx0WSvz3N
 dg4GxiXv+xGFUqPopHT8yN2TAz2PrCS00rLtXldN3EUyhFTdUwRGpuWsGv9wXsrzMnyr
 mAcnMarO+DHU2ev5vPPHH964NrroBbQgAiEtEDi2/dK5ejRtfpxaZioeiRFJF6hySZsn
 bMXLWFpqtjpQlVr7om0WSQuiHI9jCG0a07ya0w4XH6wCiceZoGXJgA18qJuCmktwg1bH
 JXaNxEul81CcDaEr2PJCYDfL67sWRCglhVFBKh+jgL39fohkJ//LuMWrXCZEqHY9IHzI
 PVSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792691689; x=1793296489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U9cIlg/kuvejPKkOUohaAEGtRAZiKH0kfKhHaydnU5M=;
 b=DLVDlBn159eNfn/4ylmD7hM63mHSAC2YP9l3vWfAwOPh+wDAsGI3oe0klFUAobG9GH
 whOTix1qXOcIsTvNOPYoypa3pZkhJb3qbXV4CdaunFHFwATGNx3KMJ60cK7MSKTwTGrQ
 n66nx7BQqnZCKhzN9RPYf7nnRCaPUDmaU0Z6gY6i6iPSbsU6YMI9BZ9BYWaTYMnNhrtA
 6c1KGYRix4in2U0t/cQC+N/nrCfp4zJa+vtFoZ9BhczlvTRD45VoaHZChSlwZAw3Itcb
 l0ZlaEsLMb/G1HrVSoz3zYZ3C+gLnZ1j6cdHtbwNkR3am1ZwIHcRvGEDXIE4O+0OCjp0
 F54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792691689; x=1793296489;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U9cIlg/kuvejPKkOUohaAEGtRAZiKH0kfKhHaydnU5M=;
 b=Nr6B7oSpsv1fp/MXsll9bRGPYcx4dI4ZRbNL6h7wb5o1xK5qEX3215IGGQjpLtWTH7
 1rMQOAAl6z/S3x5jFcZjKXxesiGMLlurb58HLRU8/IVk71wyV++T/bQYunKUh5+dyBWZ
 d/D/zWTY6X+r/4Ak7F/q+7r94ajyTNbecW+yhkXh+dNOgszoVJ8qYrpIw7iplug31t7p
 NlAbMXqSe8meU/MuJJeVIIl0MaGV6mrBFiELjD+/LB2PLsJktnt8uUfaYXmX4inyKXv5
 Gzb2Ibz/rizu1TWnujyeIoX1AKgUiZXSZkxt04okcMmSt2xT5vySCZa1bSHsp0Ouv0x4
 wXsg==
X-Gm-Message-State: AFq9FYKw3G1UtLuDN5XTgDWJ+ay1CQ5ErqwPclI1VPDN3Y0zJ16qVvRO
 pqxToYWzAVAVVv/aP67sAyksZr/E7+Cq3fFqUibRDxFM6lGZ25paX60PPHUaechV2jMQBtE7xV+
 q99VSqfxOl5qSjY6KWMu+mEU7Q/ZRcvGlsO1TSQ9qkwUeuHbojX5rdeOpcqqTZyTXBjooRa+XbC
 XMZOWy18/7vgwmNoD73yJrHnbepnP62niu
X-Gm-Gg: AYBFou1zjfKACQYKMw9p4FOFRt35/qNyBblCaEu5hzvJq9TSlLCfzdu9nhYklYUUvtI
 UoW0TldNSzlV/2fKlLh3ShxVSzb2lX24yB9dqd5zTYKv44vU/g0OT1M9/3q3YlV1YDkBkqGoCjm
 Me2wmBwSKth/Pbbh4DTqme5mt4bLspYdDaT6S3PvFBhbEOZPQ0Kbwc6Z+lXoxldh8WHyOVTvuqy
 0ZKKVq/sO1E7iT2P6I=
X-Received: by 2002:a05:6808:3203:b0:4f7:d324:bc5b with SMTP id
 5614622812f47-5535ce1309dmr3859417b6e.57.1792691689523; 
 Thu, 22 Oct 2026 10:54:49 -0700 (PDT)
X-Received: by 2002:a05:6808:3203:b0:4f7:d324:bc5b with SMTP id
 5614622812f47-5535ce1309dmr3859398b6e.57.1792691688993; Thu, 22 Oct 2026
 10:54:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
 <20261021224421.3786109-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261021224421.3786109-10-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:54:37 -0500
X-Gm-Features: AclHuK-QTtz9WlHEMSev-RETq_rJRDQxX2OzXpqRuiPCc1ntqv1-prZTLEbN2k8
Message-ID: <CAJ+KCYNk2FyUj=L=Z=PUt+YtOYQ3VHFP+P4Uo=SOZDHxGK6nsw@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] target/hexagon: implement control flow integrity
 (CFI)
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: poQMrO-tUYKpa1WB3nK1GRAwKUXWEV_0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MSBTYWx0ZWRfXwFhBohwcx8mg
 mAVYWqRP0ivksnXA/sTdk3tZhcMlOyz+N2xOxMqZ7StWbFyn8xPpkAGSYfX38iDmghc1eQoLYTg
 Itlx4BuoiyCZ/vTmzb43mjStIMGwi6c=
X-Authority-Analysis: v=2.4 cv=F4fC5ahN c=1 sm=1 tr=0 ts=6ada4dea cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=JlNeibrqCL0j9A3I6vEA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: poQMrO-tUYKpa1WB3nK1GRAwKUXWEV_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MSBTYWx0ZWRfX4NIiKTw2Q8so
 tfcXSgHDRO4oezK+awnAKyN7fohvQF8uXnDQ9mwKQ1R/pO0otHn9zAljGFrM47T86K23hAJ4Bb1
 ubo7LIwgKuOvGkvOUZBKOZ7GBBfBSZw5SAEZ0UnX74ANFUJWQGfnLjSdy8nprz8gi0wsN2s0Zub
 iHRnf8ZX1UgB3x9mTPQ+mtR4n3UyV0z2Xr/isuiQlQUw0sI+EUfafvxwvgcNgVrUzACGw2rM10d
 I6OefT4rfeSLQyj3B1cK4yD3PbA3qKLuQSfFLkzI7/muPmDY4wtq08D4W1brO7hz0aPcYsl0HRn
 p3HJ+7VoAiT2Ux/aQYIcO5rbSdVGbJu2lZqu2Y5pAlZ7lKm8EE51pg6Bn2wMjNV64yRTAGqQa9a
 6lfsVVAjplSJWSqIgK+XeWaJ5f4eSJuroPZaLSs8+YC0YKn7mFJxbMxXXNrwfoCOYOI4Vfqm02i
 J2c7A+LYPpfbC3yLbAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 5:44=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Implement v83 restricted indirect-control-flow instructions and validate
> their targets.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h                       |  3 ++
>  target/hexagon/cpu_bits.h                  |  1 +
>  target/hexagon/gen_tcg.h                   | 62 +++++++++++++++++++++-
>  target/hexagon/gen_tcg_sys.h               |  6 +++
>  target/hexagon/macros.h                    | 12 +++++
>  target/hexagon/translate.h                 |  3 ++
>  target/hexagon/attribs_def.h.inc           |  1 +
>  target/hexagon/reg_fields_def.h.inc        |  1 +
>  linux-user/hexagon/cpu_loop.c              |  9 ++++
>  linux-user/hexagon/signal.c                |  8 +++
>  target/hexagon/cpu.c                       |  6 +++
>  target/hexagon/genptr.c                    | 36 +++++++++++++
>  target/hexagon/hex_interrupts.c            |  3 ++
>  target/hexagon/hexswi.c                    | 11 ++++
>  target/hexagon/machine.c                   |  3 +-
>  target/hexagon/translate.c                 | 59 ++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc          | 20 +++++++
>  target/hexagon/imported/alu.idef           |  3 ++
>  target/hexagon/imported/branch.idef        | 38 +++++++++++++
>  target/hexagon/imported/encode_pp.def      | 18 ++++++-
>  target/hexagon/imported/encode_subinsn.def |  1 +
>  target/hexagon/imported/ldst.idef          |  2 +
>  target/hexagon/imported/subinsns.idef      |  2 +
>  target/hexagon/imported/system.idef        |  2 +-
>  24 files changed, 306 insertions(+), 4 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

