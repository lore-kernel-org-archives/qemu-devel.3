Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D6C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvLr-0002cR-45; Thu, 23 Jul 2026 11:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wmvLp-0002bJ-6E; Thu, 23 Jul 2026 11:28:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wmvLn-0001He-Jo; Thu, 23 Jul 2026 11:28:44 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A680405A8;
 Thu, 23 Jul 2026 15:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BF31F000E9;
 Thu, 23 Jul 2026 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784820519;
 bh=8J2VtFuanlmT+0KiEhTTK81ms5yWcapz2URDeulnam0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DMQGjpu4dMUrqa09OemZgKVbo1vIdTKMrQqRpCSUPADtajcc0nUS2vrsionjIbInO
 2nD4bU5hv1DkA0GlwAjFcGz43dnMuzsDZtbH0EyjgFOpqwiVSyZCNm5XUf4Y6EdBh6
 KcvJ8+VOKwXATOd0UpYjJ25MGJ2gCUzhMgxsr1GnPgiUE4LSh+2EvLlEpzJ5jVQ3yy
 lTWuZQqi/yeLRaJ6q/wn+bh3URQpL8j79D0cS0egyJ4+iUwVbyveWBzPpjiDbP+l+Q
 lii9WreDQDbHdZvcK9p4d+e6dVVdvXgpZnlUmvviqaJ3iwAk+QYZiwywRtMSzGhdRu
 R2g0UUnbFrChA==
Date: Thu, 23 Jul 2026 16:28:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 16/26] hw/rtc: Add PolarFire SoC RTC model
Message-ID: <20260723-seducing-plunging-ef7d4c60d917@spud>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-17-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JIaAHBSMXyRPCB2F"
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-17-bin.meng@processmission.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--JIaAHBSMXyRPCB2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:18:43PM +0800, Bin Meng wrote:
> The PolarFire SoC exposes an RTC with binary and calendar modes,
> programmable prescaling, alarms, and wakeup and match interrupts.
>=20
> Add a standalone device model with explicit MMIO handling for time,
> commands, alarms, interrupt state, reset, and migration. Add its
> Kconfig and Meson entries and list it under the PolarFire SoC
> maintainer section.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> +
> +#define RTC_REG(offset) ((offset) / sizeof(uint32_t))
> +
> +static uint64_t mchp_pfsoc_rtc_get_count(MchpPfSoCRtcState *s)
> +{
> +    if (!s->running) {
> +        return s->frozen_count;
> +    }
> +
> +    return s->tick_offset +
> +           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> +}

Just to be sure, this is done to match the hardware's behaviour of
resetting the count when the device is power cycled?

> +
> +static void mchp_pfsoc_rtc_set_count(MchpPfSoCRtcState *s, uint64_t coun=
t)
> +{
> +    if (s->running) {
> +        s->tick_offset =3D (int64_t)count -
> +            qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> +    } else {
> +        s->frozen_count =3D count;
> +    }
> +}

--JIaAHBSMXyRPCB2F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamIzIAAKCRB4tDGHoIJi
0rpnAQCWz6gNYKeDn9Qpwv3bhQTrNVhKkJWv+5Y6qEVLBzdeuQEAkp1IlcA4biDw
Ut0omIfms8oOjo9DOtRVmMaGalfsTAg=
=3MB0
-----END PGP SIGNATURE-----

--JIaAHBSMXyRPCB2F--

