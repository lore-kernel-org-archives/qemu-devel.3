Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8F0C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuC51-0004nj-7x; Wed, 12 Aug 2026 12:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC4z-0004nP-4d; Wed, 12 Aug 2026 12:45:25 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC4h-0007dp-8S; Wed, 12 Aug 2026 12:45:11 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A525B14000F3;
 Wed, 12 Aug 2026 12:45:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 12:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786553104; x=1786639504; bh=YnwMMC6hTYEh4JU09+QoRitqXuYNG2Z0
 blKLrhUT8Q8=; b=Kp8IDQehvDo/7K+WTybsEs06wK4bRzss6habMaHkeUonja4g
 bYW95Dl9+TtwkFjvS+P5GPLdhJgKe2+hckB6PzsGi5NaS9VEiuo7UAg7g0RZAPV4
 Od86twua2Qr5KtrWi2JBGsKAo50luKIMJNR2ANmDjn8v+pws5OW12H6/PO+qD35F
 hgDdout28FoE/vmwpW+Br9tDM0xAGVKx3N0AN9OwU9WmNH9S8zXh2CeXG2e4j7pS
 d7fVObTI6Tt4mSIJMkdOkmBEGFttqZL089+B2GJBzJBo2EmrxFy96JZUgzasOMlP
 nckMiI9unRj4z7V8tqT0Rm5LwTIpV6gWn3+faQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786553104; x=
 1786639504; bh=YnwMMC6hTYEh4JU09+QoRitqXuYNG2Z0blKLrhUT8Q8=; b=m
 Gfhs7/0uKcIVo1tOyS1rJMOhrovLSC9LshJAuQcohGgyU6DgzSHpbrtVo7rl0HNw
 4vv+2Bd0qvA8OQI43WsiUm0IJ4I+tdHMCCMyNJI24pxmACawJOlZQD44+IW4pTbv
 HJa82QEGVdenF8O6Ek5DJNjJmqCUl6nEnnFBMyxpIlaUZFvu+45PKKAlUvTeXUd+
 UL0KxWB6NHBqTGb200tTU3Z9yY8DCK2KpGyAJozCFGUA3BkKyA6cCU6qgcUZFBgj
 0Nhgb1nb1xSPy/6GVE5fKPjI4ZElv/fCx+2wp7IsJbMIEdNKHb/ND/5vgq1O6I4s
 U125f/En99dbuvcDt40Ow==
X-ME-Sender: <xms:EKN8ak_7FqmwJt6OhYLXmOgJaQt7QV8uaKAr18tQhn2ll6Q3d3Eewg>
 <xme:EKN8auMkB1mTErCCGexoVxGyDXghI74_RH5hG8loLUGnj0NYFOYkRskFYJicaZCwu
 rCw7JZ0cLfNP2LEdX5uftRc09rrya3rf2eSEwUekvVfs_W_ufCl9y8>
X-ME-Received: <xmr:EKN8aqFjiGNUU94n-7oXqt8a0bBxbksIIvCBEY7n4k_ASd6L5ZnYnZWXiQki1sHmiIdx2g>
X-ME-Proxy-Cause: dmFkZTEpZlKt9LLslbpY4viMGc+OBio+UBDT/BZi7wcWy0grcRDu6UkaDD3E8ph81x7BwS
 65Q0rprAtS6RYbaFuBKn056dlkH3s+il7F+nwLF8y+Cr7YhnKgRxgDXhLaFtym12DXN1dl
 u+Stx/tlR3a9FLwje/tBgA4LRSGTqpWVX2jg6sLw4pflHNXVAo21qMiXK+zlwt9xRgUAsi
 1B7DRLUC2ZRdNWFzyRhQDUMIciKZr06rWvlnxLK2NSVSI++Hh4oP5UK2Ie6fhgC9EPDPQv
 9dKJQQ3aaGN2sZpUQdRXEYQRZrAvx6LKnG7s7PPU93Iwcd/n5wSHdwUb7tFh8pmsbzC7tt
 jiRYMqPGqSs2bzydTSy2xcVxJyNw0GdXelOafja1vSWW8v5LUw3k+L6ozh3WCfWokne+fi
 Hb7XB11mE8fcEoQpTgJbOdcJa5lbTCicf/S0vgKQpJZgUZGlrdvXVQ86IpztKuq3HzL6ST
 VfohqelnHknFcghfB1RnV1sQF8NMeWjYi+DAB7BHT/rqFCV+EjaCSQD4fOOnhjVGvVwnGx
 TQZkl8jPe+kLI8dM1l2aQSS+h9G/a7E1UT8r2n1XOEKVSlshoemHcKHJd0k3/lgaT58249
 EHFpmuPeCT7iJgGpcsKiVAERv4j1MUByiVlUBCaLtU85iUzCo8mJo+2TkwyA
X-ME-Proxy: <xmx:EKN8akRr_WRvvz-DWq6Rs084NlZcslCtIWY9-JrfLpuuhjM-5DuysQ>
 <xmx:EKN8avsLL9_C_CIxvufOqKac5IyjljbZMOGImhJ2j9SGCvxgi-InNw>
 <xmx:EKN8akLdoPgq2sAQTd6Hll_TiHhDI27vZdSguEnXkOE17fTNJz2bog>
 <xmx:EKN8asnb4uAxEqut3t5MS3UAcu5ZZp3sOOaUphKXCXbSTaRiFJkYXQ>
 <xmx:EKN8ar8i17_DHdt2qr3GpWy7z9-3zSdK4sQweb_iUnZqeqUgRhyDdxjZ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:45:04 -0400 (EDT)
Message-ID: <0180cf74e912a29d1eda72e3fa2760646554c795.camel@alistair23.me>
Subject: Re: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in
 linux-user mode
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: Thu, 13 Aug 2026 02:45:03 +1000
In-Reply-To: <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
References: <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=alistair@alistair23.me; helo=fhigh-a2-smtp.messagingengine.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

