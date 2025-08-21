Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA227CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5y5-00042w-2i; Thu, 21 Aug 2025 10:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up5y2-00042f-Jf
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up5xz-0003ga-OG
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755785312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wAcwWKw7bP9cJDhAXpsPbnx3+NtqP8uWQX30LeuG7MM=;
 b=RIKTiDbfgKm6+awH8C82IMRu5jzh0zsRwr9ak96gfXl7GimYbjRHpsFSorEAQlJyehM1K0
 djA3wmTnjaO9x+IE4FJ5Vi/U2XVUgobRkMIWIm2nu8nDJxex70NaarjElB+I+Dnd7RNqDf
 TztnC1WCHD+uhEIpGqQe82jcWRQ8p10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-PREBWmyGMr-jz_ItJSA6EQ-1; Thu,
 21 Aug 2025 10:08:28 -0400
X-MC-Unique: PREBWmyGMr-jz_ItJSA6EQ-1
X-Mimecast-MFC-AGG-ID: PREBWmyGMr-jz_ItJSA6EQ_1755785306
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C07901800366; Thu, 21 Aug 2025 14:08:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A32B03001453; Thu, 21 Aug 2025 14:08:22 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:08:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
Message-ID: <20250821140816.GA6393@fedora>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OjBHyQl0zu9DxEAw"
Content-Disposition: inline
In-Reply-To: <20250820122516.949766-2-adityag@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--OjBHyQl0zu9DxEAw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 05:55:17PM +0530, Aditya Gupta wrote:
> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
> with --without-default-devices:
>=20
>     $ ./configure --without-default-devices
>     $ make
>=20
>     [281/283] Linking target qemu-system-ppc64
>     FAILED: qemu-system-ppc64
>     cc -m64 @qemu-system-ppc64.rsp
>     /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in=
 function `helper_load_sprd':
>     .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference t=
o `pnv_chip_find_core'
>     /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in=
 function `helper_store_sprd':
>     .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference t=
o `pnv_chip_find_core'
>     collect2: error: ld returned 1 exit status
>     ...

QEMU v10.1.0-rc4 is scheduled to become the final release (QEMU v10.1.0)
on Tuesday, August 26th. My view is that there is no need to delay the
release for this issue, because it affects few users and
--without-default-devices implies they are already customizing the
build. They can use a workaround the issue by enabling POWERNV or wait
for QEMU v10.1.1 (-stable tree) for the fix.

I have added it as a known issue to the QEMU 10.1 changelog:
https://wiki.qemu.org/ChangeLog/10.1#Known_issues

If anyone disagrees, please let me know.

Thanks,
Stefan

>=20
> This is since target/ppc/misc_helper.c references PowerNV specific
> 'pnv_chip_find_core' call.
>=20
> Split the PowerNV specific SPRD code out of the generic PowerPC code, by
> moving the SPRD code to pnv.c
>=20
> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
> Cc: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: C=E9dric Le Goater <clg@redhat.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
> Note that while moving the code, the 'target_ulong' type for sprc has been
> modified to 'uint64_t'.
>=20
> Based on the discussion happened on [1].
> Requires patch 1 and patch 2 of [1] to be applied, to fix the build.
>=20
> [1]: https://lore.kernel.org/qemu-devel/20250526112346.48744-1-philmd@lin=
aro.org/
> ---
> ---
>  hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
>  target/ppc/cpu.h         |  4 ++
>  target/ppc/misc_helper.c | 59 +++------------------------
>  3 files changed, 96 insertions(+), 53 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d84c9067edb3..9c74f46091a7 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -21,6 +21,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/datadir.h"
> +#include "qemu/log.h"
>  #include "qemu/units.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> @@ -1794,12 +1795,83 @@ static void pnv_chip_power9_pec_realize(PnvChip *=
chip, Error **errp)
>      }
>  }
> =20
> +static uint64_t pnv_handle_sprd_load(CPUPPCState *env)
> +{
> +    PowerPCCPU *cpu =3D env_archcpu(env);
> +    PnvCore *pc =3D pnv_cpu_state(cpu)->pnv_core;
> +    uint64_t sprc =3D env->spr[SPR_POWER_SPRC];
> +
> +    if (pc->big_core) {
> +        pc =3D pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1=
);
> +    }
> +
> +    switch (sprc & 0x3e0) {
> +    case 0: /* SCRATCH0-3 */
> +    case 1: /* SCRATCH4-7 */
> +        return pc->scratch[(sprc >> 3) & 0x7];
> +
> +    case 0x1e0: /* core thread state */
> +        if (env->excp_model =3D=3D POWERPC_EXCP_POWER9) {
> +            /*
> +             * Only implement for POWER9 because skiboot uses it to check
> +             * big-core mode. Other bits are unimplemented so we would
> +             * prefer to get unimplemented message on POWER10 if it were
> +             * used anywhere.
> +             */
> +            if (pc->big_core) {
> +                return PPC_BIT(63);
> +            } else {
> +                return 0;
> +            }
> +        }
> +        /* fallthru */
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> +                                  TARGET_FMT_lx"\n", sprc);
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static void pnv_handle_sprd_store(CPUPPCState *env, uint64_t val)
> +{
> +    PowerPCCPU *cpu =3D env_archcpu(env);
> +    uint64_t sprc =3D env->spr[SPR_POWER_SPRC];
> +    PnvCore *pc =3D pnv_cpu_state(cpu)->pnv_core;
> +    int nr;
> +
> +    if (pc->big_core) {
> +        pc =3D pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1=
);
> +    }
> +
> +    switch (sprc & 0x3e0) {
> +    case 0: /* SCRATCH0-3 */
> +    case 1: /* SCRATCH4-7 */
> +        /*
> +         * Log stores to SCRATCH, because some firmware uses these for
> +         * debugging and logging, but they would normally be read by the=
 BMC,
> +         * which is not implemented in QEMU yet. This gives a way to get=
 at the
> +         * information. Could also dump these upon checkstop.
> +         */
> +        nr =3D (sprc >> 3) & 0x7;
> +        pc->scratch[nr] =3D val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
> +                                  TARGET_FMT_lx"\n", sprc);
> +        break;
> +    }
> +}
> +
>  static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
>      Pnv9Chip *chip9 =3D PNV9_CHIP(dev);
>      PnvChip *chip =3D PNV_CHIP(dev);
>      Pnv9Psi *psi9 =3D &chip9->psi;
> +    PowerPCCPU *cpu;
> +    PowerPCCPUClass *cpu_class;
>      Error *local_err =3D NULL;
>      int i;
> =20
> @@ -1827,6 +1899,12 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
>          return;
>      }
> =20
> +    /* Set handlers for Special registers, such as SPRD */
> +    cpu =3D chip->cores[0]->threads[0];
> +    cpu_class =3D POWERPC_CPU_GET_CLASS(cpu);
> +    cpu_class->load_sprd =3D pnv_handle_sprd_load;
> +    cpu_class->store_sprd =3D pnv_handle_sprd_store;
> +
>      /* XIVE interrupt controller (POWER9) */
>      object_property_set_int(OBJECT(&chip9->xive), "ic-bar",
>                              PNV9_XIVE_IC_BASE(chip), &error_fatal);
> @@ -2078,6 +2156,8 @@ static void pnv_chip_power10_realize(DeviceState *d=
ev, Error **errp)
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
>      PnvChip *chip =3D PNV_CHIP(dev);
>      Pnv10Chip *chip10 =3D PNV10_CHIP(dev);
> +    PowerPCCPU *cpu;
> +    PowerPCCPUClass *cpu_class;
>      Error *local_err =3D NULL;
>      int i;
> =20
> @@ -2105,6 +2185,12 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
> =20
> +    /* Set handlers for Special registers, such as SPRD */
> +    cpu =3D chip->cores[0]->threads[0];
> +    cpu_class =3D POWERPC_CPU_GET_CLASS(cpu);
> +    cpu_class->load_sprd =3D pnv_handle_sprd_load;
> +    cpu_class->store_sprd =3D pnv_handle_sprd_store;
> +
>      /* XIVE2 interrupt controller (POWER10) */
>      object_property_set_int(OBJECT(&chip10->xive), "ic-bar",
>                              PNV10_XIVE2_IC_BASE(chip), &error_fatal);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6b90543811f0..0e26e4343de7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1522,6 +1522,10 @@ struct PowerPCCPUClass {
>      void (*init_proc)(CPUPPCState *env);
>      int  (*check_pow)(CPUPPCState *env);
>      int  (*check_attn)(CPUPPCState *env);
> +
> +    /* Handlers to be set by the machine initialising the chips */
> +    uint64_t (*load_sprd)(CPUPPCState *env);
> +    void (*store_sprd)(CPUPPCState *env, uint64_t val);
>  };
> =20
>  static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index e7d94625185c..0e625cbb704d 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -328,69 +328,22 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>       * accessed by powernv machines.
>       */
>      PowerPCCPU *cpu =3D env_archcpu(env);
> -    PnvCore *pc =3D pnv_cpu_state(cpu)->pnv_core;
> -    target_ulong sprc =3D env->spr[SPR_POWER_SPRC];
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> -    if (pc->big_core) {
> -        pc =3D pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1=
);
> +    if (pcc->load_sprd) {
> +        return pcc->load_sprd(env);
>      }
> =20
> -    switch (sprc & 0x3e0) {
> -    case 0: /* SCRATCH0-3 */
> -    case 1: /* SCRATCH4-7 */
> -        return pc->scratch[(sprc >> 3) & 0x7];
> -
> -    case 0x1e0: /* core thread state */
> -        if (env->excp_model =3D=3D POWERPC_EXCP_POWER9) {
> -            /*
> -             * Only implement for POWER9 because skiboot uses it to check
> -             * big-core mode. Other bits are unimplemented so we would
> -             * prefer to get unimplemented message on POWER10 if it were
> -             * used anywhere.
> -             */
> -            if (pc->big_core) {
> -                return PPC_BIT(63);
> -            } else {
> -                return 0;
> -            }
> -        }
> -        /* fallthru */
> -
> -    default:
> -        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> -                                  TARGET_FMT_lx"\n", sprc);
> -        break;
> -    }
>      return 0;
>  }
> =20
>  void helper_store_sprd(CPUPPCState *env, target_ulong val)
>  {
> -    target_ulong sprc =3D env->spr[SPR_POWER_SPRC];
>      PowerPCCPU *cpu =3D env_archcpu(env);
> -    PnvCore *pc =3D pnv_cpu_state(cpu)->pnv_core;
> -    int nr;
> -
> -    if (pc->big_core) {
> -        pc =3D pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1=
);
> -    }
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> -    switch (sprc & 0x3e0) {
> -    case 0: /* SCRATCH0-3 */
> -    case 1: /* SCRATCH4-7 */
> -        /*
> -         * Log stores to SCRATCH, because some firmware uses these for
> -         * debugging and logging, but they would normally be read by the=
 BMC,
> -         * which is not implemented in QEMU yet. This gives a way to get=
 at the
> -         * information. Could also dump these upon checkstop.
> -         */
> -        nr =3D (sprc >> 3) & 0x7;
> -        pc->scratch[nr] =3D val;
> -        break;
> -    default:
> -        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
> -                                  TARGET_FMT_lx"\n", sprc);
> -        break;
> +    if (pcc->store_sprd) {
> +        return pcc->store_sprd(env, val);
>      }
>  }
> =20
> --=20
> 2.50.1
>=20
>=20

--OjBHyQl0zu9DxEAw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAminKFAACgkQnKSrs4Gr
c8j1Owf/eGrzK1eAAsw3aivlDF/hXdEb5hqU+szJ+fk5bhQgJfCkOBfzFb96vz3T
byqa7UlC5HcmmaPv1PLcGDtFhJbyp5mAa1HybGh+uHp4/TehU/gJa2yIPo9z76k6
NPBDvBp3Q35dHkb7jfuBr7R4sPITUrj3vGtd/Mdmps5JqxynE+2hywKjVr9WSOjp
vBd4JR/JhFnCPPGmA1Hm7Iru5LKUvEr31OQQzCrjq9Qwg01BB7vp2Y04+agCSdDn
9AcgTuUotpmubjZg+euUpNldR8qVzihDrfnSgANvhHsmKM8AseQ3vQyAYYYcLx4t
XxoGdqk7Nt5BpXdnPnyFbbm0GxqkkQ==
=jLYV
-----END PGP SIGNATURE-----

--OjBHyQl0zu9DxEAw--


