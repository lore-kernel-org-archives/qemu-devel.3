Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94595CD8C89
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHrp-00062X-BP; Sun, 07 Jun 2026 14:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wWHrn-00061s-3w; Sun, 07 Jun 2026 14:04:59 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wWHrj-0005So-CU; Sun, 07 Jun 2026 14:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1780855485; x=1781114685;
 bh=o8U+nQcYTwe/Fc9RiHwoK5MmLtMGx2l9HSUtqx3mrl8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=N/av0I5jBlLHTJxmUNQgpJd5oNfspGJimX7Pff+HoQhKmRhOO763ltlNt4sCTutC4
 jANxgEdenSKHAewWEIMYFZetwzWcGTLdN8JnCHtsBv8F1FrjLEr6ws4REOxnXhqmj1
 DdcUsmPFB3YLUcBPhSvYaIs97eCBPI9DTxxwaIXlq/6qcXxbZ9k33rS091LGA8PBXd
 yWO7LFi+h2OIoec7hBkeMgWWD+YdaOo0N+JKpfXmsIcH4b3hCPOw7SNpRedk16KxTa
 S8Iw+2Imv4iZlFqrgfJ2b46hSUmiRPd+u6EujO/kdXPU8iWwjZ0sp6L5PlRUtKQXID
 VfxloJNGI3qFQ==
Date: Sun, 07 Jun 2026 18:04:42 +0000
To: Zenghui Yu <zenghui.yu@linux.dev>
From: "Jason L. Wright'" <wrigjl@proton.me>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PULL 17/21] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
Message-ID: <aiWyrX0aVvBk2olT@Jasons-MacBook-Pro.local>
In-Reply-To: <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 340d8c54e488e99cdb46e35e7a8794cbae9128f8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.16; envelope-from=wrigjl@proton.me;
 helo=mail-4316.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 07, 2026 at 06:42:30PM +0800, Zenghui Yu wrote:
> + Alexander and qemu-arm (for HVF/arm),
>=20
> On 5/29/26 7:47 PM, Peter Maydell wrote:
> > From: Jason Wright <wrigjl@proton.me>
> >
> > Add an .accessfn to the RNDR and RNDRRS system registers that traps
> > reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
> > Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
> > the CPU advertises the feature. The pseudocode in DDI0487 revision M.b
> > shows the trap firing from EL0, EL1, EL2, and EL3, so there is no
> > check of arm_current_el().
> >
> > When FEAT_RNG_TRAP is implemented without FEAT_RNG, an RNDR/RNDRRS read
> > with SCR_EL3.TRNDR=3D0 should UNDEF rather than succeed; handle that ca=
se
> > in access_rndr(). Register the rndr_reginfo CP reg entries whenever eit=
her
> > FEAT_RNG or FEAT_RNG_TRAP is implemented, so the accessfn fires even on=
 a
> > FEAT_RNG_TRAP-only CPU.
> >
> > When SCR_EL3.TRNDR is set, ID_AA64ISAR0_EL1.RNDR reads as 1 regardless
> > of whether FEAT_RNG is implemented; give ID_AA64ISAR0_EL1 a readfn so i=
t
> > reports this at runtime, as we already do for ID_AA64PFR0_EL1.
> >
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Jason Wright <wrigjl@proton.me>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/cpu-features.h |  5 ++++
> >  target/arm/helper.c       | 58 +++++++++++++++++++++++++++++++++++----
> >  2 files changed, 58 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > index 4e8d844fea..38a695ded7 100644
> > --- a/target/arm/cpu-features.h
> > +++ b/target/arm/cpu-features.h
> > @@ -908,6 +908,11 @@ static inline bool isar_feature_aa64_rndr(const AR=
MISARegisters *id)
> >      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RNDR) !=3D 0;
> >  }
> >
> > +static inline bool isar_feature_aa64_rng_trap(const ARMISARegisters *i=
d)
> > +{
> > +    return FIELD_EX64_IDREG(id, ID_AA64PFR1, RNDR_TRAP) !=3D 0;
> > +}
> > +
> >  static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *=
id)
> >  {
> >      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TLB) =3D=3D 2;
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 34487eeaa3..9dd8fdfa41 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -790,6 +790,9 @@ static void scr_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
> >          if (cpu_isar_feature(aa64_fpmr, cpu)) {
> >              valid_mask |=3D SCR_ENFPM;
> >          }
> > +        if (cpu_isar_feature(aa64_rng_trap, cpu)) {
> > +            valid_mask |=3D SCR_TRNDR;
> > +        }
> >      } else {
> >          valid_mask &=3D ~(SCR_RW | SCR_ST);
> >          if (cpu_isar_feature(aa32_ras, cpu)) {
> > @@ -5170,6 +5173,21 @@ static uint64_t id_aa64pfr0_read(CPUARMState *en=
v, const ARMCPRegInfo *ri)
> >      }
> >      return pfr0;
> >  }
> > +
> > +static uint64_t id_aa64isar0_read(CPUARMState *env, const ARMCPRegInfo=
 *ri)
> > +{
> > +    ARMCPU *cpu =3D env_archcpu(env);
> > +    uint64_t isar0 =3D GET_IDREG(&cpu->isar, ID_AA64ISAR0);
> > +
> > +    /*
> > +     * When FEAT_RNG_TRAP is active (SCR_EL3.TRNDR set), ID_AA64ISAR0_=
EL1.RNDR
> > +     * reads as 1 regardless of whether FEAT_RNG is implemented.
> > +     */
> > +    if (env->cp15.scr_el3 & SCR_TRNDR) {
> > +        isar0 =3D FIELD_DP64(isar0, ID_AA64ISAR0, RNDR, 1);
> > +    }
> > +    return isar0;
> > +}
> >  #endif
> >
> >  /*
> > @@ -5304,6 +5322,22 @@ static const ARMCPRegInfo pauth_reginfo[] =3D {
> >        .fieldoffset =3D offsetof(CPUARMState, keys.apib.hi) },
> >  };
> >
> > +static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> > +                                  bool isread)
> > +{
> > +    if (env->cp15.scr_el3 & SCR_TRNDR) {
> > +        return CP_ACCESS_TRAP_EL3;
> > +    }
> > +    /*
> > +     * Note that FEAT_RNG_TRAP may be implemented without FEAT_RNG.
> > +     * In that case, if the trap is not enabled, the read undefs.
> > +     */
> > +    if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
> > +        return CP_ACCESS_UNDEFINED;
> > +    }
> > +    return CP_ACCESS_OK;
> > +}
> > +
> >  static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
> >  {
> >      Error *err =3D NULL;
> > @@ -5335,11 +5369,11 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
> >      { .name =3D "RNDR", .state =3D ARM_CP_STATE_AA64,
> >        .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
> >        .opc0 =3D 3, .opc1 =3D 3, .crn =3D 2, .crm =3D 4, .opc2 =3D 0,
> > -      .access =3D PL0_R, .readfn =3D rndr_readfn },
> > +      .access =3D PL0_R, .accessfn =3D access_rndr, .readfn =3D rndr_r=
eadfn },
> >      { .name =3D "RNDRRS", .state =3D ARM_CP_STATE_AA64,
> >        .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
> >        .opc0 =3D 3, .opc1 =3D 3, .crn =3D 2, .crm =3D 4, .opc2 =3D 1,
> > -      .access =3D PL0_R, .readfn =3D rndr_readfn },
> > +      .access =3D PL0_R, .accessfn =3D access_rndr, .readfn =3D rndr_r=
eadfn },
> >  };
> >
> >  static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
> > @@ -6522,11 +6556,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >                .access =3D PL1_R, .type =3D ARM_CP_CONST,
> >                .accessfn =3D access_tid3,
> >                .resetvalue =3D 0 },
> > +            /*
> > +             * ID_AA64ISAR0_EL1 is not a plain ARM_CP_CONST in system
> > +             * emulation because the RNDR field depends on SCR_EL3.TRN=
DR
> > +             * at read time when FEAT_RNG_TRAP is implemented.
> > +             */
> >              { .name =3D "ID_AA64ISAR0_EL1", .state =3D ARM_CP_STATE_AA=
64,
> >                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 0,
> > -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> > +              .access =3D PL1_R,
> > +#ifdef CONFIG_USER_ONLY
> > +              .type =3D ARM_CP_CONST,
> > +              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR0)
> > +#else
> > +              .type =3D ARM_CP_NO_RAW,
> >                .accessfn =3D access_tid3,
> > -              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR0)},
> > +              .readfn =3D id_aa64isar0_read,
> > +              .writefn =3D arm_cp_write_ignore
> > +#endif
> > +            },
>=20
> A new assert() was triggered when booting guest on M1 since this change:
>=20
> Assertion failed: (!(ri->type & ARM_CP_NO_RAW)), function hvf_arch_init_v=
cpu, file hvf.c, line 1442.
>=20
> Thanks,
> Zenghui
>=20
Thanks for the report and the bisect, Zenghui. I can reproduce on M1 with:

qemu-system-aarch64 -M virt,accel=3Dhvf -cpu host \
                      -nographic -display none -bios /dev/null

ID_AA64PFR0_EL1 has the same NO_RAW + readfn shape that the FEAT_RNG_TRAP
change gave ID_AA64ISAR0_EL1, and HVF already accommodates it by listing
the cpreg in the SYNC_NO_RAW_REGS block in target/arm/hvf/sysreg.c.inc
(so the assert loop skips it) and pushing QEMU's value to the vCPU at
init time. Mirroring that pattern for ID_AA64ISAR0_EL1 clears the assert
without disturbing the readfn semantics that the spec requires if a
FEAT_RNG_TRAP-only CPU eventually appears.

I'll send a fix-up as [PATCH] target/arm/hvf shortly.


