Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A50AC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt2y-0004Zf-Uk; Tue, 11 Aug 2026 16:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt2s-0004Va-Sw; Tue, 11 Aug 2026 16:26:03 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt2r-0004Ye-9r; Tue, 11 Aug 2026 16:25:58 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 79BCAEC0092;
 Tue, 11 Aug 2026 16:25:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479955; x=1786566355; bh=ZR7CL/81V9WMPmRiZ9xT1WhGuUtT8KL4
 gxC6SL5ZoCI=; b=Z7xkXv9YIahClFajDySOTYZ43hkDiK2vCOgTJ+wJ6ddcN5FY
 8Tf9oLLAmJd+Li4cSFAhBJ/CQ36ypHceKy5kEzsvu8FKSJNUNq+v1j5zEHXkQn6H
 jN2MzA+7QsMoJK21l/v6DgZpjnANNvib78Pgk/uezTGfXzvmhBbbEHzxFgzjhEzc
 AaAR6fOqR2P40E5VzFWUDEzDM6QItmv8TibkAQ6J/5CSF7znHLgKCk2j2SQSVMwd
 0bdALD89IzT5AOEtNLIYR1MpAuL3Va4Zl5Ym41CbBQt54ObFaz34hoSk9//L/wg+
 aIWz/89z3o2kdUdk1QIYiNGcEyW1ZnXKTk2zHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479955; x=
 1786566355; bh=ZR7CL/81V9WMPmRiZ9xT1WhGuUtT8KL4gxC6SL5ZoCI=; b=j
 wttEwqklAyLTu0G4cevkQLo51dYdU5dorKut1oUYCCvMimTvN413Q+bwE8jFqZw2
 zT7+WWSTksnAwnyqlPNckSs0bD+wqWmP6XzX6TDoqK0A3lR50ro0P8UO49CwrE95
 5Ts5YDWpSsSHV7iIfpQZpD3w6liVS9XKuBS+nsWUOC6V2kHYTt0ALm/UTfOcMBkp
 Cov57bkYlcseVcujvb1W9mFstIEl/A7gnQcj1I+GyNsBRuy7dExTge3Aa9eF+azW
 pxLL3pQWdJ9+lvPzMj5goeDZb60qDH2X7woSylIwMstqg7N+4dirxGMZ3uDZOhwu
 ZDr0t4pyAOnrpBulUFpkg==
X-ME-Sender: <xms:U4V7aqTOfdq-bI00WXN71lc_4eDei6kMUhYyQbGzdBGLD7LHdKeG8g>
 <xme:U4V7akE_AGTeFKRC2VhSOpRTxZpMBpO5CaHIx0pksVgC4GZvHgqEHgNkWxG_3UI06
 OmtOLs89aFB4l-Yqvr7aSESURYOUqnpwFyrufzU5d1v514YWKf9C5Q>
X-ME-Received: <xmr:U4V7am8HcFbhjE8--X_M_-v_LR2TydDLrk8qwQqKiMcshlfvdcONZB0wPWL5bZT-ir3g3w>
X-ME-Proxy-Cause: dmFkZTEzuZDt8G4XekGq4/IBOyKjAcJozJbLLkc9d8HuEbAjm2Sf2YWLsqE9MhtWyHYYd/
 Rx4zNxy1rKU0svkjz+zKPbYDTWifJTzIjE7radHXkapSmS4TpOXSsgL/Z9SGsGekN6tgYD
 wptUsXbxbKK9uLt0LBDdVc3JwYVuQ199ohnfux5uFpucZKv6qmOFGO8lXEMSQYEsCo+6sR
 5lgr3QfSaEKyTvoNcI+IgT9isSUFR8vHR2Wn1JyuugGvzrFqKhytpvtgtqfnnoH4klQ9G3
 9CoBDa2P/pcal22XRt56EF6XZry9RLG0YDraKRN2OWGxHVso5ATaybo02HyhMX4gAZSHUO
 w5DCQHZ4dxEp1+Vezft1ATqmXeeVz0lT5wEgrdEyOP5Ruj7dIVGJmqeMZ4tDBMfUwcFkyZ
 wS20KCeWF16jgRDE4B00xP+5jMlqMj5xBirTPk7sGSdvmaI2x+kUhwap8h2uQJS3R7ncxL
 Zst/QbOd6kiT9TG9/f98H2siIL/Xm0h/TKw2EhUot/a1zsj5V5gdw7v+RrWqX216mtDnZv
 aRf1rrqk7OZ4E3XyqgoQLzYvqecDOwWdihZn2MP1XTv6VSP1zIN0rwlinvd0v5yuVuxogM
 DB4Ze1av7L3zoNbypnMd+KHmgU3Iz+ecs9hw8ccZvwqRePgLmN/HNlKkpXwQ
X-ME-Proxy: <xmx:U4V7auLbhkLSGl1504p6-0oiKr663LF3JUQojdCIN67dxnEFdjjrzA>
 <xmx:U4V7apazzmGU0XeXGTasnE3m3hlSUE4act0-b9xi5FeD9w2-MFIoDg>
 <xmx:U4V7aoK-beXFXT0CugoI0GhGWWlugD-L3WchnjuwW3_gAZ7GWUF7xA>
 <xmx:U4V7avBkHA_n75tZwNuFsB_pz9jlKWl94Kii65uYP8t5ONbTL2tXHg>
 <xmx:U4V7akkiqn0ARHEnlVrDbTLgYqWzxAqx_V4xDz6k4--QvMwbui3AqdKj>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:25:55 -0400 (EDT)
Message-ID: <b4f68ccdc477b27c73947700f3ab24b1e758e61f.camel@alistair23.me>
Subject: Re: [PATCH 34/56] disas/riscv: Tidy rv_comp_data terminators
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:25:54 +1000
In-Reply-To: <20260809223545.730664-35-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=alistair@alistair23.me; helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> Use { } instead of two zeros.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 46 +++++++++++++++++++++++-----------------------
> =C2=A01 file changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 9904b4db03..bb4779614b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1072,123 +1072,123 @@ static const rvc_constraint rvcc_true[] =3D {
> rvc_end };
> =C2=A0static const rv_comp_data rvcp_jal[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_j, rvcc_j },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_jal_ra, rvcc_jal_ra },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_jalr[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_ret, rvcc_ret },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_jr, rvcc_jr },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_jalr_ra, rvcc_jalr_ra },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_beq[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_beqz, rvcc_beqz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_bne[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bnez, rvcc_bnez },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_blt[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bltz, rvcc_bltz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bgtz, rvcc_bgtz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_bge[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_blez, rvcc_blez },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bgez, rvcc_bgez },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_addi[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_nop, rvcc_nop },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_mv, rvcc_mv },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_sltiu[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_seqz, rvcc_seqz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_xori[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_not, rvcc_not },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_sub[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_neg, rvcc_neg },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_slt[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_sltz, rvcc_sltz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_sgtz, rvcc_sgtz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_sltu[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_snez, rvcc_snez },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_addiw[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_sext_w, rvcc_sext_w },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_subw[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_negw, rvcc_negw },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnj_s[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fmv_s, rvcc_fmv_s },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjn_s[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fneg_s, rvcc_fneg_s },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjx_s[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fabs_s, rvcc_fabs_s },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnj_d[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fmv_d, rvcc_fmv_d },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjn_d[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fneg_d, rvcc_fneg_d },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjx_d[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fabs_d, rvcc_fabs_d },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnj_q[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fmv_q, rvcc_fmv_q },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjn_q[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fneg_q, rvcc_fneg_q },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjx_q[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_fabs_q, rvcc_fabs_q },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0/* Convert compressed insns into normal insns via pseudo expansion.
> */

