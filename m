Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCx1-0001rG-Nd; Wed, 12 Aug 2026 13:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCwv-0001pr-0E; Wed, 12 Aug 2026 13:41:09 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCwt-000783-7V; Wed, 12 Aug 2026 13:41:08 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 09084EC0183;
 Wed, 12 Aug 2026 13:41:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 13:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786556466; x=1786642866; bh=HnjkEGzHPRofK9YidEXdNrW4DhlwaW9J
 Zp0VgrxxnLc=; b=AOR0T47R/ZD2IiqrOdA5MVco7KcExAXofiYnPLCWCNcf3y/f
 Z1fFFWzvQfHlwY+B3bev4mfbrt6kb7cz4lQE5sP5I36BmyB3+y+auU4bFW3Q5oz/
 D02WprtXg2f3NcQgeIDdEOXnV9boq/tjfSRzUoWuWKKI3C4RJkZ0hmlYnw+hlsuU
 fqVxmjRbct2OVkurrpjjSBG4Furkraf1T1dF92yHXzn5QAWgVQfsbpHLVYWZv5Ya
 hOhGx3tCW86wuXmICgCp9F85QL7NQlLtxCcZOti97sJ9C75pQ8+9/nnwh+qBhZnn
 vStHSYBCRP0KjrL1c9FZ3YPR2lXE+Ey3uj+x5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786556466; x=
 1786642866; bh=HnjkEGzHPRofK9YidEXdNrW4DhlwaW9JZp0VgrxxnLc=; b=Y
 0GVMbN0uUsQWxlnGpND4+KiKCx9CZMGULeXz91gFejsa69IZcUY2F+32EyvBQ2W3
 ZpG+grxrNLgr1rcRbE4OWsQcOfL6CCgZsc8F7k4N74KNp6McSIuiDlmY85B88RPf
 Fof4YY/iuMV0JAU2JI4p3iKxvJ982PD4zeb3WkEiF4kkeBJzEnIEdJXugIcT446R
 OUGmhrif9Mk/Ku1P8MSa4p8j2KpFOOpqQ3ssK0TW1BXklQc0luNE8YSd3aYqmxXi
 T+FcbaihM9BnFuZ2KXR+rvvGKgfGGP0q25X8ix9RKun8vvDE4QVkKHYui4xiX0VE
 7YVZecGY0r27u4kjucqKw==
X-ME-Sender: <xms:MbB8aokk_AW4m_k9LIvTEwulxjmJfICzDToDWziUq0TyQ4czXSxq0w>
 <xme:MbB8aq6l78FqLZqakQnhQpa1HGUY4VmNdrzXBCuvBUldB4fZUg0IqBOec_mumrRD-
 axwPhkKCmMCVe9cp9yWcwwffiCTlz__X84sRRGKR7HObTufFwpBkdc>
X-ME-Received: <xmr:MbB8ahS3ad4VeV2DC6HEJXLW8tV2ClBjo6U0cVWYljTW9-jZ9uwSTfzcgG_RD4rmAukp-Q>
X-ME-Proxy-Cause: dmFkZTEmIH4Os54QA0LNXvEUeh2YEXI8xJmddtnaUWyjfjEsPrJD0cVuJiaxGMx8EXv+FA
 TOVQtBNMWqiQiZgHmk3xg+y3SEtpyEXw4q7o80aoklyTdNMNl+Be5F6x4qWmVe+pZSTyAK
 pR7VV1+74h0fKsYIRdt3mZ89UrmEl3yI4HMYv0tTLNnKC+vTZti5TiLeGYZpi8PxiRI0Zr
 58cLnkguPV704O9VQZARutPnUM/gw5+pq3xVBjN7+Jlt2HeUagoo2kNwDi2kp9IOzUe956
 FkTNPDHPBEjO5SryfcZ4o/VwssbYgUm2PS9uF7mSM2M4eVqb945MUfzyZaIlyDjiSxbAOU
 VnRNXTPzNV1hHYGOgx4T1m09mQm5G7MGLhR36jzJ0owbs7CuWgyuIjxRo1OF3ibNNU5nVs
 76Vv5bi474dQQ7S0lrH6NSKhJPZw1OKnpVOvIPFuTv+YSTd9amsYB2sKFtSL0SZRmifpWj
 hzKy0Wc1WRUg6mx2MFtzF0xayOWGnJnScltmcy0fSsLWuK6php+nfq4hRmVMcP9JhWrEcm
 oqy+BTMl+h7gw4xspb/z27QwLqdUGnMHRBuRK+CHAr8Bqgm+kxnYneaXRix0iEOo1ntVG4
 DzGOQbjVACpv3kggfDPnYtdEd6aFpZOjqMV/40W1zPKq0CyyAoc+jNC1gsag
X-ME-Proxy: <xmx:MbB8agxj8aQwd_0HsfYscfERIcDRsOB3_kaUzWljiW_STR6W80SR8g>
 <xmx:MbB8ahpdlGQhMCbUEqOm9-hU7ye4MV-vTevbwym6zqhtb7uv2eoMrw>
 <xmx:MbB8ar0QO0HpqnJPESc-2M-aWChgZp_3gBBDKzUXZVRbQ7-q5_pGtA>
 <xmx:MbB8apyw5rTyObtD8e5IfuTOz4DtLDtKuIHwKA6h_lD32LlE0dcyWA>
 <xmx:MrB8apV8XwWrapMoVZq4ZUzqdeu_Nn8Sc7dPSidkkkWV0gxHJH2yHjkc>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:41:05 -0400 (EDT)
Message-ID: <4f5842775eddb0abab6d2439ba5ea03fb1053961.camel@alistair23.me>
Subject: Re: [PATCH v2] target/riscv: allow menvcfg/henvcfg LPE and SSE bits
 on RV32
From: Alistair <alistair@alistair23.me>
To: A-Shehab <ahshehab24@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, 	alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, 	chao.liu@processmission.com,
 debug@rivosinc.com
Date: Thu, 13 Aug 2026 03:41:04 +1000
In-Reply-To: <20260726080537.13913-1-ahshehab24@gmail.com>
References: <20260726080537.13913-1-ahshehab24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=alistair@alistair23.me; helo=fout-a1-smtp.messagingengine.com
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

On Sun, 2026-07-26 at 11:05 +0300, A-Shehab wrote:
> The Zicfilp landing-pad enable (LPE, bit 2) and Zicfiss shadow-stack
> enable (SSE, bit 3) controls live in the low 32 bits of menvcfg and
> henvcfg, and the CFI specification defines them for both RV32 and
> RV64.
>=20
> QEMU only adds MENVCFG_LPE/MENVCFG_SSE (and the henvcfg equivalents)
> to
> the writable mask inside the "riscv_cpu_mxl(env) =3D=3D MXL_RV64" block,
> so
> on RV32 these bits are silently dropped and the features cannot be
> enabled. This is inconsistent with write_senvcfg(), which already
> handles SENVCFG_LPE/SENVCFG_SSE regardless of MXLEN.
>=20
> Hoist the LPE/SSE mask handling out of the RV64-only block in
> write_menvcfg() and write_henvcfg() so the bits become writable on
> RV32
> as well. The upper-half writers (write_menvcfgh/write_henvcfgh) are
> unaffected because these bits reside in the low 32 bits.
>=20
> Reproducible on qemu-system-riscv32 -cpu
> rv32,zicfilp=3Dtrue,zicfiss=3Dtrue:
> an M-mode write of menvcfg.{LPE,SSE} reads back as zero, while the
> same
> program on rv64 keeps the bits set.
>=20
> Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling
> controls for zicfilp")
> Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling
> controls for zicfiss")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4045
> Signed-off-by: A-Shehab <ahshehab24@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2: Rebase on current master; the file moved from target/riscv/csr.c
> to
> =C2=A0=C2=A0=C2=A0 target/riscv/tcg/csr.c (noted by Daniel Henrique Barbo=
za). No
> =C2=A0=C2=A0=C2=A0 functional change.
>=20
> v1:
> https://lore.kernel.org/qemu-devel/20260719111749.23777-1-ahshehab24@gmai=
l.com/
>=20
> =C2=A0target/riscv/tcg/csr.c | 45 +++++++++++++++++++++++++--------------=
-
> --
> =C2=A01 file changed, 27 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..0182e4c408 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3216,6 +3216,19 @@ static RISCVException
> write_menvcfg(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MENVCFG_CBZE;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool stce_changed =3D false;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfis=
s) reside in the
> low
> +=C2=A0=C2=A0=C2=A0=C2=A0 * 32 bits and are defined for both RV32 and RV6=
4, so they must
> be
> +=C2=A0=C2=A0=C2=A0=C2=A0 * writable regardless of MXLEN.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (cfg->ext_zicfilp) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D MENVCFG_LPE;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 if (cfg->ext_zicfiss) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D MENVCFG_SSE;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (cfg->ext_svpb=
mt ? MENVCFG_PBMTE : 0) |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> @@ -3223,14 +3236,6 @@ static RISCVException
> write_menvcfg(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cfg.ext=
_zicfilp) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
|=3D MENVCFG_LPE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cfg.ext=
_zicfiss) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
|=3D MENVCFG_SSE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Update PMM field only=
 if the value is valid according to
> Zjpm v1.0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cf=
g.ext_smnpm &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
get_field(val, MENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {
> @@ -3378,20 +3383,24 @@ static RISCVException
> write_henvcfg(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * henvcfg.LPE (Zicfilp) and henvcfg.SSE (Zicfis=
s) reside in the
> low
> +=C2=A0=C2=A0=C2=A0=C2=A0 * 32 bits and are defined for both RV32 and RV6=
4, so they must
> be
> +=C2=A0=C2=A0=C2=A0=C2=A0 * writable regardless of MXLEN.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (cfg->ext_zicfilp) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D HENVCFG_LPE;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* H can light up SSE for VS only if HS had it from m=
envcfg */
> +=C2=A0=C2=A0=C2=A0 if (cfg->ext_zicfiss && get_field(env->menvcfg, MENVC=
FG_SSE)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D HENVCFG_SSE;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D env->menvcfg &=
 (HENVCFG_PBMTE | HENVCFG_STCE |
> HENVCFG_ADUE |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HENVCFG_DTE);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cfg.ext=
_zicfilp) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
|=3D HENVCFG_LPE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* H can light up SSE for VS =
only if HS had it from menvcfg
> */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cfg.ext=
_zicfiss &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_f=
ield(env->menvcfg, MENVCFG_SSE)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
|=3D HENVCFG_SSE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Update PMM field only=
 if the value is valid according to
> Zjpm v1.0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cf=
g.ext_ssnpm &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
get_field(val, HENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {

