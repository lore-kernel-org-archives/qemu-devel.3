Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66288C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsPb-0003FP-0F; Tue, 11 Aug 2026 15:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsPa-0003FE-2M
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:45:22 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsPY-0006wK-FZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:45:21 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E364F1400173;
 Tue, 11 Aug 2026 15:45:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 11 Aug 2026 15:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1786477519;
 x=1786563919; bh=Z4MmbZ+B71Qf5bmPSR3XLgEDAkagdDepzhKLyhTm3Rg=; b=
 kAQAe0NMUKW+bzxDZl/1dngz0MdotuwaGMWgoqOqMr0otyHzlFrXiuulG/J5xEu2
 nzlgcN8m5vHXmf3DWcdmy8xnTy+bbXUwLvPHyMKvTJSjNHtvCA1sYog1XDWxN3pR
 H74j2++Vo5zNnDQSEk5tPApxVaS8f/D7lmie91b+amOjCv8qZUJsw1IjY4aRiGyd
 wGXWCT+gAObwxGKMeqaADFbjvz8xOMjtLpk8PHsvDOrrqg2M1hjZS7YRGxQobQnr
 b82bLXEqb4e7zO0BbwFX8BFZt7eQxXilg3JJsK5n4XzcNVRMWqsDH/8ENcLI3020
 mcOd+64aHmxOcWGQmmSE0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786477519; x=1786563919; bh=Z
 4MmbZ+B71Qf5bmPSR3XLgEDAkagdDepzhKLyhTm3Rg=; b=i2w2IChWWuQ3Ovvd/
 +X/kP6F67G6LM6ec3rz5Q2+6Mpyz2fA9z8SZNumYTxGrG4s0VqOr9WVU677sGcDE
 cbdpBp2c9cMhCiR6q1fbXr+xG1GRPWF5rGdbKwEQKVzUDTxp5xWnNoT8X0OZIR9H
 dq8eO7O6udpGDShMS+D4K6JsaviYuxivk2O75OYgqeenI77A/Kpa2sJxeFp/iFVf
 N6FgBJCjgrnMuNgs0jKMdLBuB2CNh4XGQ3Km1i36Z1hfwUNaKbndN5eRX0D1tpj5
 Xgh8s3pLeCKg+lSzq3MdP2dqMGz/ThTCYyDLfB05AZWEnU5fdGLdulTBeVoSwvuK
 bLsAw==
X-ME-Sender: <xms:z3t7aq42tv81LvGn8pQSosoTY8APw-3ToDUyluUYcDFqTW3RefoIQg>
 <xme:z3t7agOJyKNemnnQvenRNg1e5WiNscw9nkq_-1CJl7hd1BlRk7V2wKWUsjLpJ_j75
 hCTqZgohZNsSUoA45gjHyye6Mj9-4c_s7aKraryVqnYxpNolUkK8Q>
X-ME-Received: <xmr:z3t7asMRPt-SZvdJ8i32aY8g9WGXinjGdqQuvyPCbs2WbE_LpCRlu62Ud9RU1Pf25nVuoA>
X-ME-Proxy-Cause: dmFkZTGzx8pjxsTSPVs8RxGvp9RPZKn5dtNsHHoLfq1fGrcmrEahLD2ZZNR6SlGaw76Azb
 ZLaRSycxvcDZ29gaIaX6qjLvlmMabQ+5WoIo9qOzpiceZJ5yaS0vGTeiQrZ+OJC/ex8GDG
 8lh58DZ/kAWZYT42ByJSjRTJ6Ix/FnJO7oEa1lihJEn9rxK9dmuEKLpC4jMLC0oRB387bd
 YsnWMLa/p7eckLUioXyvYwgibSUKIKBa9Tg9pJu9A6/NBQKCS0B8aL7+bu8/r76z9K+yiY
 QWHoayEwXiJR3YDqZY2TJp2oziNXxrwoJwBkUOd5o0OVSTM9UGHEgoMr8vQfPtnbBWURl6
 zTuBIjT3obdF8lWjbNjxq7j62RLc70klzchZYnjfYmIAGpRzRl0qnMqlP3H3Si3ouOKZ0s
 r/e2BQfCmzzUtX2CP0es4Alp9dqfkajEgG7WaL8fZLcj/4OaJA1iAsa40uutl+Pkt78a/J
 x+X59+cdoWBQGyGPprA9x0GNI2TeMDZbBi92GJwvoLjA3nAhNuObB/4DntNzCB9W8V/CHL
 ZkIEPMhXAtNomiWj6EaZF4tp/PjnXVFF9wMCIsRAXKdFWrI+VakGhIxYY1dBwm45+D70EZ
 ey02a3NPrVdydPYpuFtKrP6LXdeLsNIqN6esCrvUW6u/Yj88vzPKeixRKsqA
X-ME-Proxy: <xmx:z3t7ao9huiNilvddaTyGithWa1gPQMgy-gYIeoHKudLL3TvA1pTWPQ>
 <xmx:z3t7ag76HtCKWL-iIw8YSg2IbCaX2Z-0ajsyTACXYLgl19wzqq4G1w>
 <xmx:z3t7av1Um0Kz5v_54OQgwrCdBNf6gBwf6ek4Nwm_h_3JB48my9VehQ>
 <xmx:z3t7anD7gJPWT05ENs2hK8p4UecUhSZuqG8ujlwwvZSdU0Uracshqw>
 <xmx:z3t7au8w6ePJdFb8uJKg_Dhr9zNtn8khrlqYM8OTTIaWrU3RKMW1Pav4>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:45:19 -0400 (EDT)
Message-ID: <43605116ec3c61075c686d519f669fb6e0b7424a.camel@alistair23.me>
Subject: Re: [PATCH v2 14/16] tcg/riscv64: Implement revbit8
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 12 Aug 2026 05:45:19 +1000
In-Reply-To: <20260811045605.1246543-15-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
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

On Mon, 2026-08-10 at 21:56 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0tcg/riscv64/tcg-target.c.inc | 17 ++++++++++++++++-
> =C2=A01 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-
> target.c.inc
> index 687146e0b0..8fd32644fe 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -246,6 +246,9 @@ typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 OPC_XNOR=C2=A0=C2=A0 =3D 0x40004033,
> =C2=A0=C2=A0=C2=A0=C2=A0 OPC_ZEXT_H =3D 0x0800403b,
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /* Zbkb: Bit Manipulation for Cryptography */
> +=C2=A0=C2=A0=C2=A0 OPC_BREV8=C2=A0 =3D 0x68705013,
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Zicond: integer conditional operations */
> =C2=A0=C2=A0=C2=A0=C2=A0 OPC_CZERO_EQZ =3D 0x0e005033,
> =C2=A0=C2=A0=C2=A0=C2=A0 OPC_CZERO_NEZ =3D 0x0e007033,
> @@ -2469,8 +2472,20 @@ static const TCGOutOpUnary outop_bswap64 =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .out_rr =3D tgen_bswap64,
> =C2=A0};
> =C2=A0
> +static TCGConstraintSetIndex cset_revbit8(TCGType type, unsigned
> flags)
> +{
> +=C2=A0=C2=A0=C2=A0 return cpuinfo & CPUINFO_ZBKB ? C_O1_I1(r, r) :
> C_NotImplemented;
> +}
> +
> +static void tgen_revbit8(TCGContext *s, TCGType type, TCGReg a0,
> TCGReg a1)
> +{
> +=C2=A0=C2=A0=C2=A0 tcg_out_opc_imm(s, OPC_BREV8, a0, a1, 0);
> +}
> +
> =C2=A0static const TCGOutOpUnary outop_revbit8 =3D {
> -=C2=A0=C2=A0=C2=A0 .base.static_constraint =3D C_NotImplemented,
> +=C2=A0=C2=A0=C2=A0 .base.static_constraint =3D C_Dynamic,
> +=C2=A0=C2=A0=C2=A0 .base.dynamic_constraint =3D cset_revbit8,
> +=C2=A0=C2=A0=C2=A0 .out_rr =3D tgen_revbit8,
> =C2=A0};
> =C2=A0
> =C2=A0static const TCGOutOpBswap outop_revbit32 =3D {

