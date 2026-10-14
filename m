Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F07CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr8x-0002td-SC; Wed, 14 Oct 2026 01:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGr8t-0002tJ-5E
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:03:08 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGr8r-0000MY-7S
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:03:06 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id D56B4EC020D
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:03:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 01:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791954182;
 x=1792040582; bh=ramrmE0wX5YrgD9eRxThw8Fq5q1rrYfZFqTJDTUCttE=; b=
 Y1g7y+M730dDcf3yDs5R0ECktRNH85TjlLTaZUcwnx4ms9+caM45HYw05OAtPM0A
 hRU/Zvx5Xv4yg2N6BDbVTsEtZQg39Ju9ysTtoG9VHHKuHAbIIqWHh6VW3qWWDfP/
 BDRv/5sMeJ7wtSX0yUntIyQ6Xm0QNv+fMn5sR5O4hOrEBmBj8gldYXBBRjCg7ZqS
 QKmv4TLMUAQ9w/jmrvF823ueXEVlTHL0T9m886wQ+//Spco4orZz1wSYeNQdYLKm
 1bvEbXl5Swu47vPr877rx+PaaYu5c6kQKPoYkMk3CHzoQUuBAPmBoyQ+PyD+UV53
 PykDIg9z8Y8pNt6gqkwtEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791954182; x=1792040582; bh=r
 amrmE0wX5YrgD9eRxThw8Fq5q1rrYfZFqTJDTUCttE=; b=MaohxY1zo/nlPtG+k
 RLf5Z9Yv77AVdli2sJ1PV0AuPjoTX4K4dgkNuTX6K4oXr5RlOfali8l4b8l1JcK1
 g7g2xahJ6/V70QW8i/wkZyLJ7vSDV6yPJ1NwtUk+tAo8oUNx42O3ikM/iBCFqAoO
 wi9+IEualBipLxXOsP4hizf/yiC95PxxqjFK5FnAQNZlm6xOKx1mdCMn9gMcmFnB
 YmLGLJvHt4eAVaLquY0rU+L0uxgqhuxg51HnGJCg3nal/3nmJh8s3LwXaljLHcIo
 jA8bm/3NcRCAEp5Qv4XP+FtQAohIzGJDn6/dyQ2w+GsLxsvCKuZvJ2sNcQYGu7eB
 4OzTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791954182; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:eyQ8KnsifYmBhvvWjJxpwvGZUM90t/aMYQU7WgpC9MgobDu
 XHsHQOfgR7kTzwVqn+lOBPan1LqKcZiAGQE5KsbvGUmDJTDycEK52ekLFR5hIUkw
 KkyQAN7HMAjTdHOOCOj1IutZqXMTjeznlGuUjYAM8RBzblMrwXJUKDYQGg4hMtuV
 QlB11PaCA5DC2N+Y7x520RbiSEGcVtHnmDNnPjOJvNyoSBPfx5SMeSh3qNbUMZL3
 734xuUPMRm2yTXbdrCCY+ARkANon0x9SgLZcR+eWJMbx8W6U2fj0GxQhe6+l02sk
 uZVsIbVhnMMq0QeDkiF4iyTqE20Sw/nHsSbOUdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:pPTS9qdI4P8QVw/3xCkBtim/11ldQihRDYV3O/kgYv4=:ramrmE0wX5YrgD9eRxThw8Fq5q1rrYfZFqTJDTUCttE=;
X-ME-Sender: <xms:BA3Pash27iom073t-LNuoYw-QcvR4-AHKkQ-khDJRAkxhmblB6z_dw>
 <xme:BA3Pai-Mep4xHW0hJFOkd32Sui2eErmIMOlaUBQnmYPhcfEr8AJJCGSf6ApBOLUFq
 B9f_AZZsuuV_d1KHeJ02IMKFCFcbI4MVIk05Yt6bt_x0luHlTPMfyk>
X-ME-Received: <xmr:BA3ParpnOnuy-KkNEHvyYj0WPFLFQdM6pUotxkh19Ov3hsIbMAR0so-mjAhBZ75RPrh7LBtN5bV6R_GQWEw_sMBYg6c>
X-ME-Proxy-Cause: dmFkZTGiyl18L2gn+i3b6NiNLTLPqqxJZNF917ATqxCguWi34pE/LGjtMUOiYABKVb8VYD
 k4XvJzdjALV3bjzVc2NLuw0WVPUfpGcFBFhlJP4yClOgOVLIA3gpT51E/l1oVRxzNKPpAq
 lMO6XghAdvt7/XMhzn7UjMIaSfOCX/y6ViE43K/gKpBWc47AL1ylfaC+NASRB1N1J8Z2iV
 e+BPnJWVvWVf9POU/kdpL4wxq+Pv/r2xnUZGyiv15yeOFaz/vDP7FpBXW15eU/inGAOSlO
 uVLlvXYThs+vhG+4zus/OmyktscVctJB5OW2ibB6ZGjBnyuYrL4tyikoNjESUubk7CXGUu
 r91x5OYr92pqx/IhR4GKJYdeMzD6OFjP6cHO8Au7Lh9Z6mdCZyx2lPrXl4HFAC7R5ah2Ji
 VfmsYSZ9+LSPHJlapjQWohBB6VFGEt4UY4+RisXiYZKDGhkm2/L2edGzsEE2VH6vVgARmr
 pq6Zn+5cRXAh7tF9+0hIr/xgKuQLew5S5epXM8eJxadt/xc6U7diZ0BG84FZ7omfy1PrOy
 356M2O+UWYHEWNJ/sXxtvJyvYh+fT0F+nHK/6j+R8/HpjCJKXISEB6hUhuFgGuBTIBwee/
 69GE/bfN7rNd/yUj+ceFVaPjrBPy5nAHTf62X4PXhB5wSLaQdaOL6lqMpfxA
X-ME-Proxy: <xmx:BA3Pap8xH3rWXe1mzCzsFJ58IIP3FuFOOS_Kux_GWXLNiPulInlaFw>
 <xmx:BA3PanWtBYIA3M-YtDxbXg3enpQht2Y2GN5upSTx-3V1EVwVZDIKUQ>
 <xmx:BA3PanDw74VA5PZ0xsAAt64562ql2qNL9_TXXR9mWqr29Xe6Yjv2ew>
 <xmx:BA3PagwI7JSj3BTZWflR2zzLTLtb3I2BQgRm6jGJJanyS13VKWPtRw>
 <xmx:Bg3Pajg0t2co09jRedC9jEU8cb6F6S4Zkgl0FThSz_L09Kz8Toz0aoLp>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 01:02:59 -0400 (EDT)
Message-ID: <1c4324d14ca40b058aa0ad7c2ed0fcb782319bef.camel@alistair23.me>
Subject: Re: [PATCH v2 1/5] target/riscv: gate RV64-only Xmips instructions
 on XLEN
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Date: Wed, 14 Oct 2026 15:02:57 +1000
In-Reply-To: <219f8e34b2c59848b214874f4f8a0df9481a557c.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
References: <cover.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
 <219f8e34b2c59848b214874f4f8a0df9481a557c.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Fri, 2026-09-04 at 09:26 +0800, wangyang wrote:
> The ccmov, pref, lwp, and swp encodings are classified as RV64-only
> in xmips.decode, but their translators only check the corresponding
> extension property. With the property enabled, RV32 can therefore
> retire these encodings. Apply the same XLEN check already used by the
> ldp and sdp translators.

Where does it say ccmov is RV64 only?

Alistair

>=20
> Tested with the 12-case RV32/RV64 linux-user witness and control
> matrix on a clean patched QEMU build.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4404
>=20
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---
> =C2=A0target/riscv/tcg/insn_trans/trans_xmips.c.inc | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_xmips.c.inc
> b/target/riscv/tcg/insn_trans/trans_xmips.c.inc
> index 1b9993a9b0..37c8933221 100644
> --- a/target/riscv/tcg/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xmips.c.inc
> @@ -31,6 +31,7 @@
> =C2=A0static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_XMIPSCMOV(ctx);
> +=C2=A0=C2=A0=C2=A0 REQUIRE_64_OR_128BIT(ctx);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv zero, source1, source2, source3;
> =C2=A0=C2=A0=C2=A0=C2=A0 zero =3D tcg_constant_tl(0);
> @@ -74,6 +75,7 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp
> *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 MemOp memop =3D MO_SL | ctx->mo_endianness;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_XMIPSLSP(ctx);
> +=C2=A0=C2=A0=C2=A0 REQUIRE_64_OR_128BIT(ctx);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv dest0 =3D dest_gpr(ctx, a->rd);
> @@ -119,6 +121,7 @@ static bool trans_swp(DisasContext *ctx, arg_swp
> *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 MemOp memop =3D MO_SL | ctx->mo_endianness;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_XMIPSLSP(ctx);
> +=C2=A0=C2=A0=C2=A0 REQUIRE_64_OR_128BIT(ctx);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> @@ -138,6 +138,7 @@ static bool trans_pref(DisasContext *ctx,
> arg_pref *a)
> =C2=A0static bool trans_pref(DisasContext *ctx, arg_pref *a)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_XMIPSCBOP(ctx);
> +=C2=A0=C2=A0=C2=A0 REQUIRE_64_OR_128BIT(ctx);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Nop */
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;

