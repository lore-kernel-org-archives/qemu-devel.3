Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45021C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCXD-0003O8-QQ; Wed, 12 Aug 2026 13:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCXB-0003MT-4O; Wed, 12 Aug 2026 13:14:33 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCX9-0008LU-1D; Wed, 12 Aug 2026 13:14:32 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 2F5FAEC01EE;
 Wed, 12 Aug 2026 13:14:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 13:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786554869; x=1786641269; bh=xr4yRELDwWvCMjQYqFl8E8sNetRn3yD5
 UtuvfZE2jK0=; b=OCZtdTNhoNuJYK6e2LXBD4kPi7swvyONfocfs6GIxygdrjQR
 Quvn1fX3d3/oDfbyg7iYGD1BelF8oAeUC5TFPy+I400FeaZs33v9ZAMzkMfCuPS4
 a6oXl3BLrDlicGGicuFQrOPmAh6GmSis1scwtiiAf/uQH0y0NOodG4OxyKp9xamL
 B7bhLrKtRhismMvtt81mmcYol/zeAorCEd8fJ5TuAwUpWBLqqwEqCGTuw9lb8mpM
 JKUDQvoBP3Ahl/EBMrvVCwLimOKH1ZsNG+DeC7irFV0EMiW/oWklq825gIvJ5gSs
 UDQiC39adcIuZc4U+/0fCo2teZM4JHCWz2ETIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786554869; x=
 1786641269; bh=xr4yRELDwWvCMjQYqFl8E8sNetRn3yD5UtuvfZE2jK0=; b=I
 BbtRiRVp2M/gJKdvRXsFH5spReNNOXbvnGeJ2adC/qK5n9tCfEvQYPqLbu73Knwe
 RkBs0zt9DmN49GybBMK8MDQtyQOMgVT5Qbcvi868YsBwvmZws/q6yB4Yn7w4vpSy
 yuzitTDhyEnrMndy40isJcyAHPYBj7t/32YuYovUojeHLkGfmM0N/H0gRBAAa3NB
 PwlL9Q1EyQkL3F+3cl5h2J/xWEhgBr9f3ZM8aG0/6Xqm4e50IW0p8h5F4SR/yANY
 RWKrzEDpSL+Kny+LqoJEvdOX9GHvIHG6tGMt4EAIPenwA04pa60qQodnrqUOrlDf
 HCJWALketBUfk5auMfpGA==
X-ME-Sender: <xms:9Kl8arTRD1mRd1k2Z090QgZj2jpyLVujbnVTfjWP1c3_2egi8FZXcA>
 <xme:9Kl8auQrtRHiWoFFW7rdhoia6IoiXDkD3a_qOCwd5WptiRR8IQMmeHlR1mBNQHQny
 YyKcH-LfpnGq3lXxa5xJ8qTVexj-zC6da_NCskmnnGpJ2DQCVcVSmE>
X-ME-Received: <xmr:9Kl8ag5F2LL9B-_SKlAbw1SwHLoq76IWyIVTMaBoEzx7B9cEpWswwiHkT0zZt9RZgy-Fkg>
X-ME-Proxy-Cause: dmFkZTF48MaEr0QtEhMo0s7A1t+Xozm7xm9len1GLccLsheCWu0ixN3yDW+MlPXvr923tW
 PjXB837P8RjLoIMj8zp13r06YNvZqz+O/f8OWkfD45mx16oAEDs5jalus8dN5h1ZT9Y/pV
 p7BQq1sYpfysnbvX2ITP+zpH1Kyguf3ecnYGNZzIjZ5yNL8bxhXeqg+jFkP+SgF48EOR18
 Bb5TEtiBLOQ8UoqKvhLvRQmmbF+jw3C9DxlVM/ifxZeVS2tYsWGGKqo3C7+F68tcwhgHuc
 n49z/Y8kQzGVzWddF7njkkPW9nZblhoV3a+UdWLdK9RLUKk1DhSdqu7SzrbnOILTaR2xOO
 j7a5bWey/va1EtSPf4JaA3HMjpTZGWVsQMWMIwN+Eq4/OiaR1Gc067L5ZbgXDrXImIui6C
 vtgXwyf4g6PuwRApqpFcTiE+p3DbNhUAS8mAspM1QvIitLp82Zi7hwGtndAUW1iDfHj9qV
 /N3FO23dJVT4mYlu6UeE4C9O1J3/WDQUw1MlMdSjrhX7H/Z2polA2paJSbMP7/c1D5kZ2G
 KqrmMBxXQWaNeOkGDCUx42WlR1/5CMFpe0WKvvEZA0xJFqix7tsgLGP7aDNfZ5h1SZ7v6q
 F2IeekM/Zku73dW08ZaT1WifOnFs2rb8n+htXxHAsuQ8XicRBVqZiD3HWMFQ
X-ME-Proxy: <xmx:9Kl8aq1UBEXyu-XfcM5st-icKhItsng_mgh80uAYZu6-vVh4lYDOqw>
 <xmx:9Kl8arDDoLJhSuwd6pDHa40jwR791nYXm8Vw3-xbgT0H6nU_1tPrCw>
 <xmx:9Kl8alOz9Hs7lce4e0CPUBWqQa-yxiblxS-e4BCbdHaBfHqmEiF-Sw>
 <xmx:9Kl8agZHlDM9uJj87sTeIH9sruaMTHC7Ps86LBvKf1ZImyP-LIUj2Q>
 <xmx:9al8amiJD1lPDtzBzVjyy_1SBBrsxWmrfVarT_BvxG2zVP3TyKQjRfY6>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:14:28 -0400 (EDT)
Message-ID: <7f7bf135ace747e35d00d42d156eb6584322cd13.camel@alistair23.me>
Subject: Re: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in
 linux-user mode
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: Thu, 13 Aug 2026 03:14:27 +1000
In-Reply-To: <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
References: <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
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

On Tue, 2026-08-11 at 09:14 +0800, wangyang wrote:
> In user-only builds check_zicbo_envcfg() skipped the envcfg check
> entirely (#if !defined(CONFIG_USER_ONLY)), so cbo.inval/cbo.flush/
> cbo.zero retired unconditionally in linux-user even though the
> machine-level envcfg fields are never initialized.=C2=A0 Give the
> user-mode build a senvcfg-based gate, and initialize SENVCFG_CBZE at
> reset when ext_zicboz is enabled so cbo.zero stays usable while
> cbo.inval/cbo.flush remain illegal, matching the user-mode view of a
> typical firmware/kernel setup.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4107
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>

Thanks!

When sending multiple patches please include a cover letter. It makes
it a lot easier to work with the patches in QEMU tooling.

I'm travelling at the moment and having some troubles applying these.
Do you mind resending them with a cover letter

Alistair

> ---
> =C2=A02 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563bf..45b7610aa4f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1061,6 +1061,14 @@ static void riscv_cpu_reset_hold(Object *obj,
> ResetType type)
> =C2=A0#else
> =C2=A0=C2=A0=C2=A0=C2=A0 env->priv =3D PRV_U;
> =C2=A0=C2=A0=C2=A0=C2=A0 env->senvcfg =3D 0;
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Match the user-mode view of a typical firmwar=
e/kernel setup
> where
> +=C2=A0=C2=A0=C2=A0=C2=A0 * cbo.zero is enabled for user mode; the CBCFE/=
CBIE bits stay
> zero,
> +=C2=A0=C2=A0=C2=A0=C2=A0 * so the cache-management operations remain ill=
egal in user
> mode.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (riscv_cpu_cfg(env)->ext_zicboz) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->senvcfg |=3D SENVCFG_CBZ=
E;
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 env->menvcfg =3D 0;
> =C2=A0#endif /* !CONFIG_USER_ONLY */
> =C2=A0
> diff --git a/target/riscv/tcg/op_helper.c
> b/target/riscv/tcg/op_helper.c
> index ba3c7da375a..b9d0deacdfb 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -146,7 +146,16 @@ target_ulong helper_csrrw_i128(CPURISCVState
> *env, int csr,
> =C2=A0static void check_zicbo_envcfg(CPURISCVState *env, target_ulong
> envbits,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t ra)
> =C2=A0{
> -#ifndef CONFIG_USER_ONLY
> +#if defined(CONFIG_USER_ONLY)
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * linux-user: the machine-level envcfg fields a=
re not part of
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0 * user-mode environment; only the user-mode vie=
w of the
> enabling
> +=C2=A0=C2=A0=C2=A0=C2=A0 * bits (senvcfg, as initialized for the guest) =
applies.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (!get_field(env->senvcfg, envbits)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_raise_exception(env, RI=
SCV_EXCP_ILLEGAL_INST, ra);
> +=C2=A0=C2=A0=C2=A0 }
> +#else
> =C2=A0=C2=A0=C2=A0=C2=A0 if ((env->priv < PRV_M) && !get_field(env->menvc=
fg, envbits)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_raise_exception(en=
v, RISCV_EXCP_ILLEGAL_INST, ra);
> =C2=A0=C2=A0=C2=A0=C2=A0 }

