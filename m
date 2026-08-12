Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEB4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9mH-0001I4-Ni; Wed, 12 Aug 2026 10:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu9m6-00015l-W2; Wed, 12 Aug 2026 10:17:48 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu9m2-0005cN-0g; Wed, 12 Aug 2026 10:17:45 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4E02B1400129;
 Wed, 12 Aug 2026 10:17:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 12 Aug 2026 10:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786544259; x=1786630659; bh=BHbDuhBI0rNUlNQ34rA2597RhmS6rKl8
 Bbi7L61/Xgw=; b=crItQ2zQdVxso+k218c3tECKU/zSDqsCsBE4sDc9kZmRpXAg
 rTJtTN0loQPRWePsS5WpPnbdq9cUor8JG+KngcsklDweAC9ej19iRE1M2Cr94Het
 eb22VwulDEn+0sYUSk4Pt/8nPpS43DHV2NNSlZlSgVeQ1i1Iqu7lSH1rzu5F49Zy
 UdtQFlR2G0woHpdPqcDKGJbc1N+AmQFmtVIXMnyks9Az6kmXE1J9zpVoyfaB1o/U
 eoYTq1kjSfsiKBS9+c1yhaEIyBZgUzjKaQ8H7fv6hibWcMHDnpF7zFdb+cOzxMgC
 3krw7ZVYXu3DFZQYSC1hAVtjKvOOF+tUniFcIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786544259; x=
 1786630659; bh=BHbDuhBI0rNUlNQ34rA2597RhmS6rKl8Bbi7L61/Xgw=; b=N
 p8XO2MauqQqYuXF5tOUzapSxm7CyeJC3Xh3yjFpsR8TAb8ciyu2++7k/4wXXBcTp
 RgdvFtOb/moVUzKyLwQV9nVoi7M2vxTyrV1o82IGWrfYv0vz4o3HgmVebhHbkkJe
 +3wNBxusBK6j8m7GMQt1G9laWR9jcPjKJZISoapN1ZuEAVX2dgIgtjPFH1FtNfM7
 AVYyu65qE4oQ7aC5qdweTRN9K2cjQn+2pBNKTjR/Sx6/dULE3cG2MHrcf0t0VqeB
 F9z+UNy91X9yK/AKwrZeGEqultQdUitJZFBy4nwAjaA9LOu3/bPDqPxi2bXsn/TM
 QumlAmmcIDb/25xsnBeFQ==
X-ME-Sender: <xms:g4B8aqHunBwyEN7GplXLUEG9cftIgXaZtjZXMMmZW4qglu-tGNaSvg>
 <xme:g4B8agT2LtUqjsmRUhoctNNl5NkPGH0g0lpzdwW15hLVOJH1mHfXIW5QJqNRqu6Bb
 ZVqSWIKux5eP0Bwbj84SNPdvw-LBWoWf6Ip71objTfQ9m0afQC459o>
X-ME-Received: <xmr:g4B8aoaHNrvKMxTT5Nyf_gEjOb6m1NFfjPuy35PP1wovFGCFYEeZ6w5T_YMUBAROs9U3Mg>
X-ME-Proxy-Cause: dmFkZTGeQovrfaj3HhfP/EkzWDbpNgWLVrfjyAwVEkzsPGVkLNqHzf0ACGpy+JCwI5bysl
 uvmdVmkFoa6xMUHSn8bDZAiomMvSlUr62iRYKPkWPMWvezhhnjartIy0uIFKfFsJJnyjpY
 6RcLVYsJQssR4u/HUgYfQtmFIyrKEchE0pkPX3RQgLDsRLwjOLX8W1e5VC8ur4mc04+XQl
 HyQiRcsZN/pi7yioALD53GiO6au9UboJkpSoP1mgXw3682mXyV8Vlhchh/6CPy22yDo0CK
 sslr7evbFxOG1e9NuLsDPFjW3BhI4e3xxfhTmtGFhiCB7pTawyJiKyI6QdvZq3vXgt9HmU
 tVGEybXuJWqLyMatnR6xGy/BRlzFR9kR+DZEtBPUMbzLwYXUnQrKtgnz2VIZO2hnZT3sJm
 k+t8xvUkgm9Qd3KR2EIwX1cQIpDe6O0t1EC2hR/AF+VywqPL5tGV7zIBpX574uImyQC5np
 /Y/42OgE9SEocHueawFJkYn+ejdPECk9x6dJZ8pCfSFf8+MKpq37ndiG7yQkeSnqn3eR8C
 RGe74nQFV+kIWmwx/vuHe5FnZ6L4jJFEIGvmvNyz/dkzv4HQzL/PS4I79MNMEye4MVp+ZK
 o/NZ+k8oo7hqAe4DTj7wOojMh4JDF1KCwbxMJIldbLc2uUPoVGCO9HugrXnw
X-ME-Proxy: <xmx:g4B8aj3OI-lowCzhMRFWtAPQgcVbNbmHVJuXyFEtuJmNFe1hfUAJnQ>
 <xmx:g4B8ajqazD4W9BJNTrnPAcl5q6oS10Cz-MluFP0lEOd9i6RJF48qhA>
 <xmx:g4B8aqOt8YDBvnut4rVa_EsxRh1HW80roM-VcQphS4yblvOMAM3j4w>
 <xmx:g4B8akqZ0eiOKWVH7QLlhHtnx4oRlHp7ECdomiQCV7MYuDUmEMeWiQ>
 <xmx:g4B8agZ94Ty1gh7Qrb8E8-VDO2HALMgvUNE58Ba1LLTCOHGutM4Jtw95>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:17:37 -0400 (EDT)
Message-ID: <7e49c67dc378ed8e2f2419f5fe94f71adf697d94.camel@alistair23.me>
Subject: Re: [PATCH v2] target/riscv: do not count ECALL in minstret
From: Alistair <alistair@alistair23.me>
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: Thu, 13 Aug 2026 00:17:37 +1000
In-Reply-To: <20260730032122.2564190-1-fritchleybohrer@gmail.com>
References: <20260730032122.2564190-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=alistair@alistair23.me; helo=fhigh-a8-smtp.messagingengine.com
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

On Thu, 2026-07-30 at 11:21 +0800, Zephyr Li wrote:
> With icount enabled, helper_raise_exception() leaves ECALL in
> icount_get_raw() because it exits without restoring the current TB
> state. This makes minstret count an instruction that does not retire.
>=20
> Adjust only the fixed minstret baseline so that mcycle accounting
> remains unchanged.
>=20
> Add an RV64 softmmu regression test for the issue.
>=20
> Fixes: 4fe8ae09062d ("target/riscv: Combine mhpmcounter and
> mhpmcounterh")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4087
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> Reviewed-by: Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v2:
> - Add the Fixes tag suggested by Daniel.
>=20
> ---
> =C2=A0target/riscv/tcg/op_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++
> =C2=A0target/riscv/tcg/pmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 44 =
+++++++++++++-----
> =C2=A0target/riscv/tcg/pmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0tests/tcg/riscv64/Makefile.softmmu-target |=C2=A0 4 ++
> =C2=A0tests/tcg/riscv64/test-minstret-ecall.S=C2=A0=C2=A0 | 55
> +++++++++++++++++++++++
> =C2=A05 files changed, 98 insertions(+), 12 deletions(-)
> =C2=A0create mode 100644 tests/tcg/riscv64/test-minstret-ecall.S
>=20
> diff --git a/target/riscv/tcg/op_helper.c
> b/target/riscv/tcg/op_helper.c
> index ba3c7da375..acdccd1a97 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -21,6 +21,9 @@
> =C2=A0#include "qemu/osdep.h"
> =C2=A0#include "cpu.h"
> =C2=A0#include "target/riscv/tcg/csr.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "pmu.h"
> +#endif
> =C2=A0#include "internals.h"
> =C2=A0#include "exec/cputlb.h"
> =C2=A0#include "accel/tcg/cpu-ldst.h"
> @@ -47,6 +50,9 @@ G_NORETURN void riscv_raise_exception(CPURISCVState
> *env,
> =C2=A0
> =C2=A0void helper_raise_exception(CPURISCVState *env, uint32_t exception)
> =C2=A0{
> +#ifndef CONFIG_USER_ONLY
> +=C2=A0=C2=A0=C2=A0 riscv_pmu_decr_instret(env);
> +#endif
> =C2=A0=C2=A0=C2=A0=C2=A0 riscv_raise_exception(env, exception, 0);
> =C2=A0}
> =C2=A0
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 38ad2737e1..1a4658319b 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -49,6 +49,21 @@ static bool riscv_pmu_counter_enabled(RISCVCPU
> *cpu, uint32_t ctr_idx)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> +static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t
> cfg)
> +{
> +=C2=A0=C2=A0=C2=A0 bool virt_on =3D env->virt_enabled;
> +
> +=C2=A0=C2=A0=C2=A0 return (env->priv =3D=3D PRV_M && (cfg & MHPMEVENT_BI=
T_MINH)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =
=3D=3D PRV_S && virt_on &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cfg =
& MHPMEVENT_BIT_VSINH)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =
=3D=3D PRV_U && virt_on &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cfg =
& MHPMEVENT_BIT_VUINH)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =
=3D=3D PRV_S && !virt_on &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cfg =
& MHPMEVENT_BIT_SINH)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =
=3D=3D PRV_U && !virt_on &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cfg =
& MHPMEVENT_BIT_UINH));
> +}
> +
> =C2=A0/*
> =C2=A0 * Information needed to update counters:
> =C2=A0 *=C2=A0 new_priv, new_virt: To correctly save starting snapshot fo=
r the
> newly
> @@ -147,12 +162,27 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState
> *env,
> =C2=A0=C2=A0=C2=A0=C2=A0 riscv_pmu_icount_update_priv(env, newpriv, new_v=
irt);
> =C2=A0}
> =C2=A0
> +void riscv_pmu_decr_instret(CPURISCVState *env)
> +{
> +=C2=A0=C2=A0=C2=A0 if (!icount_enabled() ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mcountinhibit & COUNTER=
EN_IR) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_pmu_counter_filtered(en=
v, env->minstretcfg)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * minstret is derived from icount, which includ=
es the current
> +=C2=A0=C2=A0=C2=A0=C2=A0 * instruction.=C2=A0 Move the baseline forward =
to exclude an
> instruction
> +=C2=A0=C2=A0=C2=A0=C2=A0 * that raises an exception and therefore does n=
ot retire.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 env->pmu_ctrs[2].mhpmcounter_prev++;
> +}
> +
> =C2=A0int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx
> event_idx)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ctr_idx;
> =C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env =3D &cpu->env;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t max_val =3D UINT64_MAX;
> -=C2=A0=C2=A0=C2=A0 bool virt_on =3D env->virt_enabled;
> =C2=A0=C2=A0=C2=A0=C2=A0 PMUCTRState *counter;
> =C2=A0=C2=A0=C2=A0=C2=A0 gpointer value;
> =C2=A0
> @@ -170,17 +200,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum
> riscv_pmu_event_idx event_idx)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* Privilege mode filtering */
> -=C2=A0=C2=A0=C2=A0 if ((env->priv =3D=3D PRV_M &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mhpmevent_val[ctr_idx] =
& MHPMEVENT_BIT_MINH)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =3D=3D PRV_S && vi=
rt_on &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mhpmevent_val[ctr_idx] =
& MHPMEVENT_BIT_VSINH)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =3D=3D PRV_U && vi=
rt_on &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mhpmevent_val[ctr_idx] =
& MHPMEVENT_BIT_VUINH)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =3D=3D PRV_S && !v=
irt_on &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mhpmevent_val[ctr_idx] =
& MHPMEVENT_BIT_SINH)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->priv =3D=3D PRV_U && !v=
irt_on &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mhpmevent_val[ctr_idx] =
& MHPMEVENT_BIT_UINH))) {
> +=C2=A0=C2=A0=C2=A0 if (riscv_pmu_counter_filtered(env, env-
> >mhpmevent_val[ctr_idx])) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index b4f1e469a2..2429c01b77 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -36,6 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env,
> uint64_t value,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint32_t ctr_idx);
> =C2=A0void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
> privilege_mode_t newpriv,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool new_virt);
> +void riscv_pmu_decr_instret(CPURISCVState *env);
> =C2=A0RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong
> *val,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool upper_half, =
uint32_t
> ctr_idx);
> =C2=A0
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target
> b/tests/tcg/riscv64/Makefile.softmmu-target
> index 82be8a2c91..42038ce3b4 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -24,6 +24,10 @@ EXTRA_RUNS +=3D run-test-mepc-masking
> =C2=A0run-test-mepc-masking: test-mepc-masking
> =C2=A0	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
> =C2=A0
> +EXTRA_RUNS +=3D run-test-minstret-ecall
> +run-test-minstret-ecall: test-minstret-ecall
> +	$(call run-test, $<, $(QEMU) -icount shift=3D1 $(QEMU_OPTS)$<)
> +
> =C2=A0EXTRA_RUNS +=3D run-plugin-doubletrap
> =C2=A0run-plugin-doubletrap: doubletrap
> =C2=A0	$(call run-test, $<, \
> diff --git a/tests/tcg/riscv64/test-minstret-ecall.S
> b/tests/tcg/riscv64/test-minstret-ecall.S
> new file mode 100644
> index 0000000000..ab268f7f22
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-minstret-ecall.S
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +
> +	.text
> +	.global	_start
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	/*
> +	 * The first CSR read retires after obtaining s0.=C2=A0 The ecall
> does not
> +	 * retire, so the trap handler must observe a difference of
> one.
> +	 */
> +	csrr	s0, minstret
> +	ecall
> +	sub	t0, s1, s0
> +	li	t1, 1
> +	bne	t0, t1, fail
> +
> +	li	a0, 0
> +	j	_exit
> +
> +trap:
> +	csrr	s1, minstret
> +	csrr	t0, mcause
> +	li	t1, 11		/* Environment call from M-mode */
> +	bne	t0, t1, fail
> +
> +	csrr	t0, mepc
> +	addi	t0, t0, 4
> +	csrw	mepc, t0
> +	mret
> +
> +fail:
> +	li	a0, 1
> +
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16

