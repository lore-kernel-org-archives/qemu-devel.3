Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2712D1CDAC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 23:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQwN5-0006RB-1P; Wed, 03 Dec 2025 18:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwMz-0006OO-4L
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:34:49 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwMv-0007Zq-6y
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:34:48 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3Ma48s1374648
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 23:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oIEr+uc//1XVjsuaE+MhOMkp
 B10mTzYji/WUjDueJ+U=; b=Zk+TlMqkjkF2hpGwQFNVMj8nZ5+js8MgiDMT3HxB
 3m9s7NodUkdr/YZonSALpCoSRSiHz85QXXMTNlzoFsFBOqvsF0fg8c2OzycrxacJ
 P+gJJdk40tKtrTQCtx+9htOhGoLmmRi+mjprE5TUoSYESVjrR5TPc/dDyhZsQlI1
 hlTgtiDuKA9K2G8EmSo//fRcH/2efk63ONKgiBIiN1UZiPP9BQGKvQhgOC8kL3UG
 K4G/OOn1UNMiAv3D4gFF8UCpPd53JqA6/UpfXZDAGf95WVxgkqNjrped24hsNs2l
 P1CpSbKL7XURzyN3NK47hn/Odx4QknNXHb/MxV2+hL4dwg==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0ba22w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:34:41 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6421389c362so401656d50.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 15:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764804879; x=1765409679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oIEr+uc//1XVjsuaE+MhOMkpB10mTzYji/WUjDueJ+U=;
 b=QE90QRhmtGWLliZwdIpyuk0+BWx1a5gmvUit5l2XFhGljbw5PRqrt8OnUPVODmJ9XW
 YIh/qpoJMXaJxmrFJu43w/qFH3O1X0gCULFV8hNXYz5WVcvhsOMg1rIDbrvV0oF4lxW7
 E04piPdVjKg1GWdMJ9mObLiI+Xi9ObR7+M2Ny/080b+15CE8DZHXsXWiqwFlzQajeeHg
 KgZr6CGTFj9T7GTbyQrMsfIVprZOAFwGdiFoFibMeWvbx2TaB99edEvOxMHdeVX7DmLj
 uuG71i53+98e1hgdDxRy2qRlwLpjvXRcL2BjvQxGk35JcIMlTweNRQ2yUh+Zw7ncccym
 dQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764804879; x=1765409679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIEr+uc//1XVjsuaE+MhOMkpB10mTzYji/WUjDueJ+U=;
 b=DPUBvMOOPL+IjoFQzg3Hc3L4rf7+dwfSakg3++qlG+5gKsMNYw2+Ournssud2u0IAi
 Y7ppY9r2hHXD/Yc06qdTk76a9cwc0sUqYXaD+ps+6olGvzWOQE0B5NoZvOtM8a0zH7+q
 vwKReFw/o5MdfT6KXUMJhQMdAtNYnszGCVhNL3PGQVhjS293aptRMIMeGPMcEkDm1yHR
 tpo9JKTCyNI1lgWOqaSPKZKYRYpwCygic+iKvxQ7JYY6dFvu5T2cdylam3jHWRqLhx0C
 G0f+Ew3u493de+yO5YYMlbu71cIJhULI3elXsCTXxJAIwpKXf92wL8qull1EmkaIvUyC
 AtNQ==
X-Gm-Message-State: AOJu0YyzaYjaTc8P+8HhJvuLIrOXUxF8oNalHdcjxszhFj2IGL8N30wU
 f5OIuknX23Q847VIwsTARBkYedESICxljOQ63awsDJnVmZ11B4Hp+Ki35DXJX6bkJTnVwae4QaQ
 wauKdz3VEZA6YDfsvwIByxgDIJ7Fo2WChcTdnKpmDH9zqoCyjSoFSHwmtkjxmW85HPd57FMJCPb
 jx6sXYt1ZpgZim4gsurw5XDXL5nT0Xx5x8
X-Gm-Gg: ASbGncvY1xEsQ2MD0H8LslqEudB/uCRDNUAbA0byclDRarbTf2kJR15xUboHjslgLte
 BuPt0gE+3FZopWwx/CGdExAU7mJdXuALHOe1cqitNHyJtaSUsgqXqqJ6hM88oHCVKzUUqzNqP8A
 ZqjqYGn0mSYmi5Y97z58CPQQNwQJw4UaPyLnje6ssJaAWRSHynR5wuPie7NKECJxV/+Aqerc4RW
 JKfCnfu7uLkMq5Uh7C0JbzS7hQ=
X-Received: by 2002:a05:690e:d81:b0:63f:a18d:e151 with SMTP id
 956f58d0204a3-6443d909d31mr972954d50.35.1764804879448; 
 Wed, 03 Dec 2025 15:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd05vlVQ89zVwnMSiT3JcT9g+NYmmcsuee+l8Wm2zct/c4iU8Q1KGWnRZndGk9a/CQ3OvNB66EhopMJ0RvF9U=
X-Received: by 2002:a05:690e:d81:b0:63f:a18d:e151 with SMTP id
 956f58d0204a3-6443d909d31mr972931d50.35.1764804878933; Wed, 03 Dec 2025
 15:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-2-ltaylorsimpson@gmail.com>
In-Reply-To: <20251114230013.158098-2-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 17:34:26 -0600
X-Gm-Features: AWmQ_bl9dJ_EzSDbm2DK76j9ju20SYHFyw400xL0nRSlDxdGGH-fihKolEQDVgM
Message-ID: <CAEqNhNYWct6c9V1fbHfd9y4OuA68ne4P2hJTPiFpf12FzBMaTQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Hexagon (target/hexagon) Remove gen_log_reg_write
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000e82ca2064514a717"
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=6930c911 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=S25X5_Vwpc312vOpBhkA:9 a=QEXdDO2ut3YA:10 a=xUQTeEI1AAAA:8
 a=YdTJNS3KMcMpdLE9gUMA:9 a=cj0BF4Z9l-ad4Aca:21 a=lqcHg5cX4UMA:10
 a=Epx66wHExT0cjJnnR-oj:22 a=n63FNrGa8kYyhQnjR337:22
X-Proofpoint-ORIG-GUID: MJZtF6KqxZINXkjP-OSSHDxe8GTbzXhO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE4NyBTYWx0ZWRfX3VdWY3x6ab1V
 f/ZzqwJyMBtEVHR/0gsQrnGg5r5wCOePmdTRB+iMUzMkxiu+rlwaL90BruopDWpnNNLgrmuMYeM
 JwWvpohRbg442zmWusBK+UvJ8Xrqdjzpw+qQyR9cwTAbXIrWRMg0CC0iVQtW8GCpC+gaUsahxHG
 RtsTNlMeOdNOwSkklOb6dXNlm4I4vA/EWLpEddObmLOgU7TzOu0RD89kjYi4a3nmGZBckrRt4pS
 F+dlz5dvbM9xHC41maHS2fBopzWIS6gFD1kpj6XvqfHJQtsh+YEs8hkflJz4Aed2aL2+NhS8RgN
 lcG+5W+iz26NylbR0KcBQiWcRvU29Ky/S+EyGTnMIghaxGqqf5uyGaSyruoqKT5NdRYkX81+EZ1
 yrEzIP/t+c0l4LgQR8GX5rvfyhrZVw==
X-Proofpoint-GUID: MJZtF6KqxZINXkjP-OSSHDxe8GTbzXhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030187
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000e82ca2064514a717
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:00=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> The gen_log_reg_write function is a memnant of the original Hexagon
> target design.  With the addition of gen_analyze_funcs.py and the
> ability to short-circuit a packet commit, this function can be
> removed.
>
> Note that the implementation of gen_log_reg_write contains a check
> of the register mutability mask.  This is only needed for control
> registers, so we move it to gen_write_ctrl_reg.
>
> We do need the gen_log_reg_write_pair function, but the name is
> now misleading, so we change the name go gen_write_reg_pair.
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>  target/hexagon/gen_tcg.h                    |  7 +--
>  target/hexagon/genptr.h                     |  1 -
>  target/hexagon/genptr.c                     | 64 ++++++++-------------
>  target/hexagon/idef-parser/parser-helpers.c |  2 +-
>  target/hexagon/README                       | 10 ++--
>  target/hexagon/gen_tcg_funcs.py             |  1 -
>  target/hexagon/hex_common.py                | 14 ++---
>  7 files changed, 40 insertions(+), 59 deletions(-)
>
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 8a3b801287..10123336b1 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -509,10 +509,9 @@
>  /* sub-instruction version (no RxV, so handle it manually) */
>  #define fGEN_TCG_SS2_allocframe(SHORTCODE) \
>      do { \
> -        TCGv r29 =3D tcg_temp_new(); \
> +        TCGv r29 =3D get_result_gpr(ctx, HEX_REG_SP); \
>          tcg_gen_mov_tl(r29, hex_gpr[HEX_REG_SP]); \
>          gen_allocframe(ctx, r29, uiV); \
> -        gen_log_reg_write(ctx, HEX_REG_SP, r29); \
>      } while (0)
>
>  /*
> @@ -528,7 +527,7 @@
>      do { \
>          TCGv_i64 r31_30 =3D tcg_temp_new_i64(); \
>          gen_deallocframe(ctx, r31_30, hex_gpr[HEX_REG_FP]); \
> -        gen_log_reg_write_pair(ctx, HEX_REG_FP, r31_30); \
> +        gen_write_reg_pair(ctx, HEX_REG_FP, r31_30); \
>      } while (0)
>
>  /*
> @@ -546,7 +545,7 @@
>      do { \
>          TCGv_i64 RddV =3D get_result_gpr_pair(ctx, HEX_REG_FP); \
>          gen_return(ctx, RddV, hex_gpr[HEX_REG_FP]); \
> -        gen_log_reg_write_pair(ctx, HEX_REG_FP, RddV); \
> +        gen_write_reg_pair(ctx, HEX_REG_FP, RddV); \
>      } while (0)
>
>  /*
> diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
> index a4b43c2910..d932255042 100644
> --- a/target/hexagon/genptr.h
> +++ b/target/hexagon/genptr.h
> @@ -37,7 +37,6 @@ TCGv gen_read_reg(TCGv result, int num);
>  TCGv gen_read_preg(TCGv pred, uint8_t num);
>  TCGv get_result_gpr(DisasContext *ctx, int rnum);
>  TCGv get_result_pred(DisasContext *ctx, int pnum);
> -void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val);
>  void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val);
>  void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);
>  void gen_set_usr_fieldi(DisasContext *ctx, int field, int x);
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index cecaece4ae..e58021ed6c 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -94,25 +94,17 @@ static TCGv_i64 get_result_gpr_pair(DisasContext *ctx=
,
> int rnum)
>      return result;
>  }
>
> -void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val)
> -{
> -    const target_ulong reg_mask =3D reg_immut_masks[rnum];
> -
> -    gen_masked_reg_write(val, hex_gpr[rnum], reg_mask);
> -    tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val);
> -}
> -
> -static void gen_log_reg_write_pair(DisasContext *ctx, int rnum, TCGv_i64
> val)
> +static void gen_write_reg_pair(DisasContext *ctx, int rnum, TCGv_i64 val=
)
>  {
>      TCGv val32 =3D tcg_temp_new();
>
>      /* Low word */
>      tcg_gen_extrl_i64_i32(val32, val);
> -    gen_log_reg_write(ctx, rnum, val32);
> +    tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val32);
>
>      /* High word */
>      tcg_gen_extrh_i64_i32(val32, val);
> -    gen_log_reg_write(ctx, rnum + 1, val32);
> +    tcg_gen_mov_tl(get_result_gpr(ctx, rnum + 1), val32);
>  }
>
>  TCGv get_result_pred(DisasContext *ctx, int pnum)
> @@ -240,7 +232,9 @@ static inline void gen_write_ctrl_reg(DisasContext
> *ctx, int reg_num,
>      if (reg_num =3D=3D HEX_REG_P3_0_ALIASED) {
>          gen_write_p3_0(ctx, val);
>      } else {
> -        gen_log_reg_write(ctx, reg_num, val);
> +        const target_ulong reg_mask =3D reg_immut_masks[reg_num];
> +        gen_masked_reg_write(val, hex_gpr[reg_num], reg_mask);
> +        tcg_gen_mov_tl(get_result_gpr(ctx, reg_num), val);
>          if (reg_num =3D=3D HEX_REG_QEMU_PKT_CNT) {
>              ctx->num_packets =3D 0;
>          }
> @@ -256,23 +250,15 @@ static inline void gen_write_ctrl_reg(DisasContext
> *ctx, int reg_num,
>  static inline void gen_write_ctrl_reg_pair(DisasContext *ctx, int reg_nu=
m,
>                                             TCGv_i64 val)
>  {
> -    if (reg_num =3D=3D HEX_REG_P3_0_ALIASED) {
> -        TCGv result =3D get_result_gpr(ctx, reg_num + 1);
> -        TCGv val32 =3D tcg_temp_new();
> -        tcg_gen_extrl_i64_i32(val32, val);
> -        gen_write_p3_0(ctx, val32);
> -        tcg_gen_extrh_i64_i32(val32, val);
> -        tcg_gen_mov_tl(result, val32);
> -    } else {
> -        gen_log_reg_write_pair(ctx, reg_num, val);
> -        if (reg_num =3D=3D HEX_REG_QEMU_PKT_CNT) {
> -            ctx->num_packets =3D 0;
> -            ctx->num_insns =3D 0;
> -        }
> -        if (reg_num =3D=3D HEX_REG_QEMU_HVX_CNT) {
> -            ctx->num_hvx_insns =3D 0;
> -        }
> -    }
> +    TCGv val32 =3D tcg_temp_new();
> +
> +    /* Low word */
> +    tcg_gen_extrl_i64_i32(val32, val);
> +    gen_write_ctrl_reg(ctx, reg_num, val32);
> +
> +    /* High word */
> +    tcg_gen_extrh_i64_i32(val32, val);
> +    gen_write_ctrl_reg(ctx, reg_num + 1, val32);
>  }
>
>  TCGv gen_get_byte(TCGv result, int N, TCGv src, bool sign)
> @@ -541,8 +527,8 @@ static inline void gen_loop0r(DisasContext *ctx, TCGv
> RsV, int riV)
>  {
>      fIMMEXT(riV);
>      fPCALIGN(riV);
> -    gen_log_reg_write(ctx, HEX_REG_LC0, RsV);
> -    gen_log_reg_write(ctx, HEX_REG_SA0, tcg_constant_tl(ctx->pkt->pc +
> riV));
> +    tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV=
);
>      gen_set_usr_fieldi(ctx, USR_LPCFG, 0);
>  }
>
> @@ -555,8 +541,8 @@ static inline void gen_loop1r(DisasContext *ctx, TCGv
> RsV, int riV)
>  {
>      fIMMEXT(riV);
>      fPCALIGN(riV);
> -    gen_log_reg_write(ctx, HEX_REG_LC1, RsV);
> -    gen_log_reg_write(ctx, HEX_REG_SA1, tcg_constant_tl(ctx->pkt->pc +
> riV));
> +    tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);
> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt->pc + riV=
);
>  }
>
>  static void gen_loop1i(DisasContext *ctx, int count, int riV)
> @@ -568,8 +554,8 @@ static void gen_ploopNsr(DisasContext *ctx, int N,
> TCGv RsV, int riV)
>  {
>      fIMMEXT(riV);
>      fPCALIGN(riV);
> -    gen_log_reg_write(ctx, HEX_REG_LC0, RsV);
> -    gen_log_reg_write(ctx, HEX_REG_SA0, tcg_constant_tl(ctx->pkt->pc +
> riV));
> +    tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV=
);
>      gen_set_usr_fieldi(ctx, USR_LPCFG, N);
>      gen_log_pred_write(ctx, 3, tcg_constant_tl(0));
>  }
> @@ -773,25 +759,23 @@ static void gen_framecheck(TCGv EA, int framesize)
>
>  static void gen_allocframe(DisasContext *ctx, TCGv r29, int framesize)
>  {
> -    TCGv r30 =3D tcg_temp_new();
> +    TCGv r30 =3D get_result_gpr(ctx, HEX_REG_FP);
>      TCGv_i64 frame;
>      tcg_gen_addi_tl(r30, r29, -8);
>      frame =3D gen_frame_scramble();
>      gen_store8(tcg_env, r30, frame, ctx->insn->slot);
> -    gen_log_reg_write(ctx, HEX_REG_FP, r30);
>      gen_framecheck(r30, framesize);
>      tcg_gen_subi_tl(r29, r30, framesize);
>  }
>
>  static void gen_deallocframe(DisasContext *ctx, TCGv_i64 r31_30, TCGv r3=
0)
>  {
> -    TCGv r29 =3D tcg_temp_new();
> +    TCGv r29 =3D get_result_gpr(ctx, HEX_REG_SP);
>      TCGv_i64 frame =3D tcg_temp_new_i64();
>      gen_load_frame(ctx, frame, r30);
>      gen_frame_unscramble(frame);
>      tcg_gen_mov_i64(r31_30, frame);
>      tcg_gen_addi_tl(r29, r30, 8);
> -    gen_log_reg_write(ctx, HEX_REG_SP, r29);
>  }
>  #endif
>
> @@ -833,7 +817,7 @@ static void gen_cond_return_subinsn(DisasContext *ctx=
,
> TCGCond cond, TCGv pred)
>  {
>      TCGv_i64 RddV =3D get_result_gpr_pair(ctx, HEX_REG_FP);
>      gen_cond_return(ctx, RddV, hex_gpr[HEX_REG_FP], pred, cond);
> -    gen_log_reg_write_pair(ctx, HEX_REG_FP, RddV);
> +    gen_write_reg_pair(ctx, HEX_REG_FP, RddV);
>  }
>
>  static void gen_endloop0(DisasContext *ctx)
> diff --git a/target/hexagon/idef-parser/parser-helpers.c
> b/target/hexagon/idef-parser/parser-helpers.c
> index 1dc52b4e02..f5802ceadb 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -1315,7 +1315,7 @@ void gen_write_reg(Context *c, YYLTYPE *locp,
> HexValue *reg, HexValue *value)
>      value_m =3D rvalue_materialize(c, locp, &value_m);
>      OUT(c,
>          locp,
> -        "gen_log_reg_write(ctx, ", &reg->reg.id, ", ",
> +        "tcg_gen_mov_tl(get_result_gpr(ctx, ", &reg->reg.id, "), ",
>          &value_m, ");\n");
>  }
>
> diff --git a/target/hexagon/README b/target/hexagon/README
> index ca617e3364..1938c91af8 100644
> --- a/target/hexagon/README
> +++ b/target/hexagon/README
> @@ -80,12 +80,14 @@ tcg_funcs_generated.c.inc
>                      Insn *insn,
>                      Packet *pkt)
>      {
> -        TCGv RdV =3D tcg_temp_new();
> +        Insn *insn G_GNUC_UNUSED =3D ctx->insn;
>          const int RdN =3D insn->regno[0];
> -        TCGv RsV =3D hex_gpr[insn->regno[1]];
> -        TCGv RtV =3D hex_gpr[insn->regno[2]];
> +        TCGv RdV =3D get_result_gpr(ctx, RdN);
> +        const int RsN =3D insn->regno[1];
> +        TCGv RsV =3D hex_gpr[RsN];
> +        const int RtN =3D insn->regno[2];
> +        TCGv RtV =3D hex_gpr[RtN];
>          gen_helper_A2_add(RdV, tcg_env, RsV, RtV);
> -        gen_log_reg_write(ctx, RdN, RdV);
>      }
>
>  helper_funcs_generated.c.inc
> diff --git a/target/hexagon/gen_tcg_funcs.py
> b/target/hexagon/gen_tcg_funcs.py
> index c2ba91ddc0..bd241afde1 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -35,7 +35,6 @@
>  ##        TCGv RsV =3D hex_gpr[insn->regno[1]];
>  ##        TCGv RtV =3D hex_gpr[insn->regno[2]];
>  ##        <GEN>
> -##        gen_log_reg_write(ctx, RdN, RdV);
>  ##    }
>  ##
>  ##       where <GEN> depends on hex_common.skip_qemu_helper(tag)
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 6803908718..093def9386 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -452,9 +452,8 @@ def decl_tcg(self, f, tag, regno):
>              TCGv {self.reg_tcg()} =3D get_result_gpr(ctx, {self.reg_num}=
);
>          """))
>      def log_write(self, f, tag):
> -        f.write(code_fmt(f"""\
> -            gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
> -        """))
> +        ## No write needed
> +        return
>      def analyze_write(self, f, tag, regno):
>          predicated =3D "true" if is_predicated(tag) else "false"
>          f.write(code_fmt(f"""\
> @@ -496,9 +495,8 @@ def decl_tcg(self, f, tag, regno):
>                  tcg_gen_mov_tl({self.reg_tcg()}, hex_gpr[{self.reg_num}]=
);
>              """))
>      def log_write(self, f, tag):
> -        f.write(code_fmt(f"""\
> -            gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
> -        """))
> +        ## No write needed
> +        return
>      def analyze_read(self, f, regno):
>          f.write(code_fmt(f"""\
>              ctx_log_reg_read(ctx, {self.reg_num});
> @@ -630,7 +628,7 @@ def decl_tcg(self, f, tag, regno):
>          """))
>      def log_write(self, f, tag):
>          f.write(code_fmt(f"""\
> -            gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()}=
);
> +            gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
>      def analyze_write(self, f, tag, regno):
>          predicated =3D "true" if is_predicated(tag) else "false"
> @@ -664,7 +662,7 @@ def decl_tcg(self, f, tag, regno):
>          """))
>      def log_write(self, f, tag):
>          f.write(code_fmt(f"""\
> -            gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()}=
);
> +            gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
>      def analyze_read(self, f, regno):
>          f.write(code_fmt(f"""\
> --
> 2.43.0
>
>

--000000000000e82ca2064514a717
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14,=
 2025 at 5:00=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpso=
n@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">The gen_log_reg_write function is a me=
mnant of the original Hexagon<br>
target design.=C2=A0 With the addition of gen_analyze_funcs.py and the<br>
ability to short-circuit a packet commit, this function can be<br>
removed.<br>
<br>
Note that the implementation of gen_log_reg_write contains a check<br>
of the register mutability mask.=C2=A0 This is only needed for control<br>
registers, so we move it to gen_write_ctrl_reg.<br>
<br>
We do need the gen_log_reg_write_pair function, but the name is<br>
now misleading, so we change the name go gen_write_reg_pair.<br>
<br>
Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
---<br></blockquote><div><br></div><div>Reviewed-by: Brian Cain &lt;<a href=
=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +--<br>
=C2=A0target/hexagon/genptr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 64 ++++++++-------------<br>
=C2=A0target/hexagon/idef-parser/parser-helpers.c |=C2=A0 2 +-<br>
=C2=A0target/hexagon/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++--<br>
=C2=A0target/hexagon/gen_tcg_funcs.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 14 ++---<br>
=C2=A07 files changed, 40 insertions(+), 59 deletions(-)<br>
<br>
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h<br>
index 8a3b801287..10123336b1 100644<br>
--- a/target/hexagon/gen_tcg.h<br>
+++ b/target/hexagon/gen_tcg.h<br>
@@ -509,10 +509,9 @@<br>
=C2=A0/* sub-instruction version (no RxV, so handle it manually) */<br>
=C2=A0#define fGEN_TCG_SS2_allocframe(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv r29 =3D tcg_temp_new(); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv r29 =3D get_result_gpr(ctx, HEX_REG_SP); =
\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(r29, hex_gpr[HEX_REG_SP]);=
 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_allocframe(ctx, r29, uiV); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_SP, r29); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0/*<br>
@@ -528,7 +527,7 @@<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 r31_30 =3D tcg_temp_new_i64(); \=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_deallocframe(ctx, r31_30, hex_gpr[HEX=
_REG_FP]); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write_pair(ctx, HEX_REG_FP, r31_30=
); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_write_reg_pair(ctx, HEX_REG_FP, r31_30); \=
<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0/*<br>
@@ -546,7 +545,7 @@<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 RddV =3D get_result_gpr_pair(ctx=
, HEX_REG_FP); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_return(ctx, RddV, hex_gpr[HEX_REG_FP]=
); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write_pair(ctx, HEX_REG_FP, RddV);=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_write_reg_pair(ctx, HEX_REG_FP, RddV); \<b=
r>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0/*<br>
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h<br>
index a4b43c2910..d932255042 100644<br>
--- a/target/hexagon/genptr.h<br>
+++ b/target/hexagon/genptr.h<br>
@@ -37,7 +37,6 @@ TCGv gen_read_reg(TCGv result, int num);<br>
=C2=A0TCGv gen_read_preg(TCGv pred, uint8_t num);<br>
=C2=A0TCGv get_result_gpr(DisasContext *ctx, int rnum);<br>
=C2=A0TCGv get_result_pred(DisasContext *ctx, int pnum);<br>
-void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val);<br>
=C2=A0void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val);<br>
=C2=A0void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);<br>
=C2=A0void gen_set_usr_fieldi(DisasContext *ctx, int field, int x);<br>
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c<br>
index cecaece4ae..e58021ed6c 100644<br>
--- a/target/hexagon/genptr.c<br>
+++ b/target/hexagon/genptr.c<br>
@@ -94,25 +94,17 @@ static TCGv_i64 get_result_gpr_pair(DisasContext *ctx, =
int rnum)<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
<br>
-void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val)<br>
-{<br>
-=C2=A0 =C2=A0 const target_ulong reg_mask =3D reg_immut_masks[rnum];<br>
-<br>
-=C2=A0 =C2=A0 gen_masked_reg_write(val, hex_gpr[rnum], reg_mask);<br>
-=C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val);<br>
-}<br>
-<br>
-static void gen_log_reg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 v=
al)<br>
+static void gen_write_reg_pair(DisasContext *ctx, int rnum, TCGv_i64 val)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv val32 =3D tcg_temp_new();<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Low word */<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_extrl_i64_i32(val32, val);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, rnum, val32);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val32);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* High word */<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_extrh_i64_i32(val32, val);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, rnum + 1, val32);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, rnum + 1), val32);<br>
=C2=A0}<br>
<br>
=C2=A0TCGv get_result_pred(DisasContext *ctx, int pnum)<br>
@@ -240,7 +232,9 @@ static inline void gen_write_ctrl_reg(DisasContext *ctx=
, int reg_num,<br>
=C2=A0 =C2=A0 =C2=A0if (reg_num =3D=3D HEX_REG_P3_0_ALIASED) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_write_p3_0(ctx, val);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write(ctx, reg_num, val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const target_ulong reg_mask =3D reg_immut_mask=
s[reg_num];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_masked_reg_write(val, hex_gpr[reg_num], re=
g_mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, reg_num), v=
al);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (reg_num =3D=3D HEX_REG_QEMU_PKT_CNT) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;num_packets =3D 0;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -256,23 +250,15 @@ static inline void gen_write_ctrl_reg(DisasContext *c=
tx, int reg_num,<br>
=C2=A0static inline void gen_write_ctrl_reg_pair(DisasContext *ctx, int reg=
_num,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 TCGv_i64 val)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (reg_num =3D=3D HEX_REG_P3_0_ALIASED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv result =3D get_result_gpr(ctx, reg_num + =
1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv val32 =3D tcg_temp_new();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_extrl_i64_i32(val32, val);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_write_p3_0(ctx, val32);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_extrh_i64_i32(val32, val);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(result, val32);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write_pair(ctx, reg_num, val);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num =3D=3D HEX_REG_QEMU_PKT_CNT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;num_packets =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;num_insns =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num =3D=3D HEX_REG_QEMU_HVX_CNT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;num_hvx_insns =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 TCGv val32 =3D tcg_temp_new();<br>
+<br>
+=C2=A0 =C2=A0 /* Low word */<br>
+=C2=A0 =C2=A0 tcg_gen_extrl_i64_i32(val32, val);<br>
+=C2=A0 =C2=A0 gen_write_ctrl_reg(ctx, reg_num, val32);<br>
+<br>
+=C2=A0 =C2=A0 /* High word */<br>
+=C2=A0 =C2=A0 tcg_gen_extrh_i64_i32(val32, val);<br>
+=C2=A0 =C2=A0 gen_write_ctrl_reg(ctx, reg_num + 1, val32);<br>
=C2=A0}<br>
<br>
=C2=A0TCGv gen_get_byte(TCGv result, int N, TCGv src, bool sign)<br>
@@ -541,8 +527,8 @@ static inline void gen_loop0r(DisasContext *ctx, TCGv R=
sV, int riV)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0fIMMEXT(riV);<br>
=C2=A0 =C2=A0 =C2=A0fPCALIGN(riV);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_LC0, RsV);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_SA0, tcg_constant_tl(ctx-&gt;=
pkt-&gt;pc + riV));<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&gt;pk=
t-&gt;pc + riV);<br>
=C2=A0 =C2=A0 =C2=A0gen_set_usr_fieldi(ctx, USR_LPCFG, 0);<br>
=C2=A0}<br>
<br>
@@ -555,8 +541,8 @@ static inline void gen_loop1r(DisasContext *ctx, TCGv R=
sV, int riV)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0fIMMEXT(riV);<br>
=C2=A0 =C2=A0 =C2=A0fPCALIGN(riV);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_LC1, RsV);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_SA1, tcg_constant_tl(ctx-&gt;=
pkt-&gt;pc + riV));<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx-&gt;pk=
t-&gt;pc + riV);<br>
=C2=A0}<br>
<br>
=C2=A0static void gen_loop1i(DisasContext *ctx, int count, int riV)<br>
@@ -568,8 +554,8 @@ static void gen_ploopNsr(DisasContext *ctx, int N, TCGv=
 RsV, int riV)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0fIMMEXT(riV);<br>
=C2=A0 =C2=A0 =C2=A0fPCALIGN(riV);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_LC0, RsV);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_SA0, tcg_constant_tl(ctx-&gt;=
pkt-&gt;pc + riV));<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&gt;pk=
t-&gt;pc + riV);<br>
=C2=A0 =C2=A0 =C2=A0gen_set_usr_fieldi(ctx, USR_LPCFG, N);<br>
=C2=A0 =C2=A0 =C2=A0gen_log_pred_write(ctx, 3, tcg_constant_tl(0));<br>
=C2=A0}<br>
@@ -773,25 +759,23 @@ static void gen_framecheck(TCGv EA, int framesize)<br=
>
<br>
=C2=A0static void gen_allocframe(DisasContext *ctx, TCGv r29, int framesize=
)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TCGv r30 =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 TCGv r30 =3D get_result_gpr(ctx, HEX_REG_FP);<br>
=C2=A0 =C2=A0 =C2=A0TCGv_i64 frame;<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(r30, r29, -8);<br>
=C2=A0 =C2=A0 =C2=A0frame =3D gen_frame_scramble();<br>
=C2=A0 =C2=A0 =C2=A0gen_store8(tcg_env, r30, frame, ctx-&gt;insn-&gt;slot);=
<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_FP, r30);<br>
=C2=A0 =C2=A0 =C2=A0gen_framecheck(r30, framesize);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_subi_tl(r29, r30, framesize);<br>
=C2=A0}<br>
<br>
=C2=A0static void gen_deallocframe(DisasContext *ctx, TCGv_i64 r31_30, TCGv=
 r30)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TCGv r29 =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 TCGv r29 =3D get_result_gpr(ctx, HEX_REG_SP);<br>
=C2=A0 =C2=A0 =C2=A0TCGv_i64 frame =3D tcg_temp_new_i64();<br>
=C2=A0 =C2=A0 =C2=A0gen_load_frame(ctx, frame, r30);<br>
=C2=A0 =C2=A0 =C2=A0gen_frame_unscramble(frame);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i64(r31_30, frame);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(r29, r30, 8);<br>
-=C2=A0 =C2=A0 gen_log_reg_write(ctx, HEX_REG_SP, r29);<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
@@ -833,7 +817,7 @@ static void gen_cond_return_subinsn(DisasContext *ctx, =
TCGCond cond, TCGv pred)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv_i64 RddV =3D get_result_gpr_pair(ctx, HEX_REG_FP);=
<br>
=C2=A0 =C2=A0 =C2=A0gen_cond_return(ctx, RddV, hex_gpr[HEX_REG_FP], pred, c=
ond);<br>
-=C2=A0 =C2=A0 gen_log_reg_write_pair(ctx, HEX_REG_FP, RddV);<br>
+=C2=A0 =C2=A0 gen_write_reg_pair(ctx, HEX_REG_FP, RddV);<br>
=C2=A0}<br>
<br>
=C2=A0static void gen_endloop0(DisasContext *ctx)<br>
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/i=
def-parser/parser-helpers.c<br>
index 1dc52b4e02..f5802ceadb 100644<br>
--- a/target/hexagon/idef-parser/parser-helpers.c<br>
+++ b/target/hexagon/idef-parser/parser-helpers.c<br>
@@ -1315,7 +1315,7 @@ void gen_write_reg(Context *c, YYLTYPE *locp, HexValu=
e *reg, HexValue *value)<br>
=C2=A0 =C2=A0 =C2=A0value_m =3D rvalue_materialize(c, locp, &amp;value_m);<=
br>
=C2=A0 =C2=A0 =C2=A0OUT(c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0locp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;gen_log_reg_write(ctx, &quot;, &amp;reg-=
&gt;<a href=3D"http://reg.id" rel=3D"noreferrer" target=3D"_blank">reg.id</=
a>, &quot;, &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tcg_gen_mov_tl(get_result_gpr(ctx, &quot=
;, &amp;reg-&gt;<a href=3D"http://reg.id" rel=3D"noreferrer" target=3D"_bla=
nk">reg.id</a>, &quot;), &quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;value_m, &quot;);\n&quot;);<br>
=C2=A0}<br>
<br>
diff --git a/target/hexagon/README b/target/hexagon/README<br>
index ca617e3364..1938c91af8 100644<br>
--- a/target/hexagon/README<br>
+++ b/target/hexagon/README<br>
@@ -80,12 +80,14 @@ tcg_funcs_generated.c.inc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Insn *insn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Packet *pkt)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RdV =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *insn G_GNUC_UNUSED =3D ctx-&gt;insn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int RdN =3D insn-&gt;regno[0];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RsV =3D hex_gpr[insn-&gt;regno[1]];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RtV =3D hex_gpr[insn-&gt;regno[2]];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RdV =3D get_result_gpr(ctx, RdN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int RsN =3D insn-&gt;regno[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RsV =3D hex_gpr[RsN];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int RtN =3D insn-&gt;regno[2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RtV =3D hex_gpr[RtN];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_A2_add(RdV, tcg_env, RsV, RtV)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write(ctx, RdN, RdV);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0helper_funcs_generated.c.inc<br>
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs=
.py<br>
index c2ba91ddc0..bd241afde1 100755<br>
--- a/target/hexagon/gen_tcg_funcs.py<br>
+++ b/target/hexagon/gen_tcg_funcs.py<br>
@@ -35,7 +35,6 @@<br>
=C2=A0##=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RsV =3D hex_gpr[insn-&gt;regno[1]]=
;<br>
=C2=A0##=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv RtV =3D hex_gpr[insn-&gt;regno[2]]=
;<br>
=C2=A0##=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;GEN&gt;<br>
-##=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write(ctx, RdN, RdV);<br>
=C2=A0##=C2=A0 =C2=A0 }<br>
=C2=A0##<br>
=C2=A0##=C2=A0 =C2=A0 =C2=A0 =C2=A0where &lt;GEN&gt; depends on hex_common.=
skip_qemu_helper(tag)<br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index 6803908718..093def9386 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -452,9 +452,8 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv {self.reg_tcg()} =3D g=
et_result_gpr(ctx, {self.reg_num});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write(ctx, {self.reg=
_num}, {self.reg_tcg()});<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ## No write needed<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
=C2=A0 =C2=A0 =C2=A0def analyze_write(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0predicated =3D &quot;true&quot; if is_pre=
dicated(tag) else &quot;false&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -496,9 +495,8 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_t=
l({self.reg_tcg()}, hex_gpr[{self.reg_num}]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write(ctx, {self.reg=
_num}, {self.reg_tcg()});<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ## No write needed<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
=C2=A0 =C2=A0 =C2=A0def analyze_read(self, f, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx_log_reg_read(ctx, {self=
.reg_num});<br>
@@ -630,7 +628,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write_pair(ctx, {sel=
f.reg_num}, {self.reg_tcg()});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_write_reg_pair(ctx, {self.re=
g_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def analyze_write(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0predicated =3D &quot;true&quot; if is_pre=
dicated(tag) else &quot;false&quot;<br>
@@ -664,7 +662,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_reg_write_pair(ctx, {sel=
f.reg_num}, {self.reg_tcg()});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_write_reg_pair(ctx, {self.re=
g_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def analyze_read(self, f, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000e82ca2064514a717--

