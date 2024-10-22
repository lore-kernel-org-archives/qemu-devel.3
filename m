Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092EDCDD0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LCq-0000nA-KO; Tue, 22 Oct 2024 16:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t3LCo-0000jx-5u; Tue, 22 Oct 2024 16:10:14 -0400
Received: from smtp6-g21.free.fr ([2a01:e0c:1:1599::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t3LCk-0005JW-Jf; Tue, 22 Oct 2024 16:10:13 -0400
Received: from zimbra83-e15.priv.proxad.net (unknown [172.20.243.252])
 by smtp6-g21.free.fr (Postfix) with ESMTP id B8CE87804FD;
 Tue, 22 Oct 2024 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1729627807;
 bh=/3iYGqdg3gAHkLCv/GvRia1pbMngF0geI2plVtgtyzc=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=i2R/QGexcZNI71244eILzQ9hWY2hX9vKkc5jp7XkrxxnCFmQE8810bVjmgI32h73d
 hWIk/biXjuOP/nbxUNUiKj1FwoouInh3ZEWRTOl/eYguNEuGPRfiW+WkcwFTAqrQv5
 CTivjOoAxGYbtv0H2vRt5Jx72Iybydn1xww+KiF0xJkEIfPotqlfYOdJ+2kfN9mbme
 A7VADZR8wboHLrXuYyIliV/QxOa3SlvCMYjDXjsc1hBNakwLmyl06Qbn6SL+RMc4wg
 20/eL+3hHWCWgk3wy2zCH9EqABzvYrEdpVcDOmBl8SVsXm/YUpIghSj/aqCRlkhRG1
 lpZ7kAc04d/vg==
Date: Tue, 22 Oct 2024 22:10:07 +0200 (CEST)
From: castet.matthieu@free.fr
To: castet matthieu <castet.matthieu@free.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 "open list:ARM cores" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Message-ID: <229573109.377326698.1729627807614.JavaMail.root@zimbra83-e15.priv.proxad.net>
In-Reply-To: <20241022200310.175432-2-castet.matthieu@free.fr>
Subject: Re: [PATCH 1/1] target/arm: Add cortex-m0+ support
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_377326697_69394490.1729627807613"
X-Originating-IP: [2a01:cb00:13da:d200:7cf5:aa34:e526:681b]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: castet.matthieu@free.fr
Received-SPF: pass client-ip=2a01:e0c:1:1599::15;
 envelope-from=castet.matthieu@free.fr; helo=smtp6-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------=_Part_377326697_69394490.1729627807613
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,=20


Please ignore this mail,=20
I was doing some test and didn't realise real email was added.=20



I will resend the real one.=20


Thanks.=20

----- Mail original -----

De: "Matthieu Castet" <castet.matthieu@free.fr>=20
=C3=80: "castet matthieu" <castet.matthieu@free.fr>=20
Cc: "Peter Maydell" <peter.maydell@linaro.org>, "open list:ARM cores" <qemu=
-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>=
=20
Envoy=C3=A9: Mardi 22 Octobre 2024 22:03:10=20
Objet: [PATCH 1/1] target/arm: Add cortex-m0+ support=20

Signed-off-by: Matthieu Castet<castet.matthieu@free.fr>=20
---=20
hw/intc/armv7m_nvic.c | 38 +++++++++++++++++++++++++++++++++-----=20
target/arm/cpu.c | 4 ++--=20
target/arm/ptw.c | 23 +++++++++++++++++++----=20
target/arm/tcg/cpu-v7m.c | 21 ++++++++++++++++++++-=20
4 files changed, 74 insertions(+), 12 deletions(-)=20

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c=20
index 98f3cf59bc..ed084e9db3 100644=20
--- a/hw/intc/armv7m_nvic.c=20
+++ b/hw/intc/armv7m_nvic.c=20
@@ -1386,7 +1386,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t off=
set, MemTxAttrs attrs)=20
}=20
return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);=20
}=20
- case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */=20
+ case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */=20
case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */=20
case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */=20
case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */=20
@@ -1876,6 +1876,14 @@ static void nvic_writel(NVICState *s, uint32_t offse=
t, uint32_t value,=20
return;=20
}=20

+ if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {=20
+ if (offset !=3D 0xd9c)=20
+ goto bad_offset;=20
+=20
+ /* do not support size less than 256 */=20
+ value &=3D ~0xe0;=20
+ }=20
+=20
if (value & (1 << 4)) {=20
/* VALID bit means use the region number specified in this=20
* value and also update MPU_RNR.REGION with that value.=20
@@ -1900,12 +1908,13 @@ static void nvic_writel(NVICState *s, uint32_t offs=
et, uint32_t value,=20
tlb_flush(CPU(cpu));=20
break;=20
}=20
- case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */=20
- case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */=20
- case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */=20
- case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */=20
+ case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */=20
+ case 0xda8: /* MPU_RASR_A1 (v6M/v7M), MPU_RLAR_A1 (v8M) */=20
+ case 0xdb0: /* MPU_RASR_A2 (v6M/v7M), MPU_RLAR_A2 (v8M) */=20
+ case 0xdb8: /* MPU_RASR_A3 (v6M/v7M), MPU_RLAR_A3 (v8M) */=20
{=20
int region =3D cpu->env.pmsav7.rnr[attrs.secure];=20
+ int rsize;=20

if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {=20
/* PMSAv8M handling of the aliases is different from v7M:=20
@@ -1926,6 +1935,25 @@ static void nvic_writel(NVICState *s, uint32_t offse=
t, uint32_t value,=20
return;=20
}=20

+ rsize =3D extract32(value, 1, 5);=20
+ if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {=20
+ if (offset !=3D 0xda0)=20
+ goto bad_offset;=20
+ /* for armv6-m rsize >=3D 7 (min 256) */=20
+ if (rsize < 7) {=20
+ qemu_log_mask(LOG_GUEST_ERROR,=20
+ "MPU region size too small %d\n", rsize);=20
+ return;=20
+ }=20
+ }=20
+=20
+ /* for armv7-m rsize >=3D 4 (min 32) */=20
+ if (rsize < 4) {=20
+ qemu_log_mask(LOG_GUEST_ERROR,=20
+ "MPU region size too small %d\n", rsize);=20
+ return;=20
+ }=20
+=20
if (region >=3D cpu->pmsav7_dregion) {=20
return;=20
}=20
diff --git a/target/arm/cpu.c b/target/arm/cpu.c=20
index 1320fd8c8f..875e3aab69 100644=20
--- a/target/arm/cpu.c=20
+++ b/target/arm/cpu.c=20
@@ -508,7 +508,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType t=
ype)=20
sizeof(*env->pmsav8.rlar[M_REG_S])=20
* cpu->pmsav7_dregion);=20
}=20
- } else if (arm_feature(env, ARM_FEATURE_V7)) {=20
+ } else if (arm_feature(env, ARM_FEATURE_M)) {=20
memset(env->pmsav7.drbar, 0,=20
sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);=20
memset(env->pmsav7.drsr, 0,=20
@@ -2454,7 +2454,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error=
 **errp)=20
}=20

if (arm_feature(env, ARM_FEATURE_PMSA) &&=20
- arm_feature(env, ARM_FEATURE_V7)) {=20
+ arm_feature(env, ARM_FEATURE_M)) {=20
uint32_t nr =3D cpu->pmsav7_dregion;=20

if (nr > 0xff) {=20
diff --git a/target/arm/ptw.c b/target/arm/ptw.c=20
index dd40268397..fa771907e3 100644=20
--- a/target/arm/ptw.c=20
+++ b/target/arm/ptw.c=20
@@ -2383,6 +2383,13 @@ static bool pmsav7_use_background_region(ARMCPU *cpu=
, ARMMMUIdx mmu_idx,=20
return regime_sctlr(env, mmu_idx) & SCTLR_BR;=20
}=20

+/* armv6m PMSAv6 is mostly compatible with PMSAv7,=20
+ * main difference :=20
+ * - min region size is 256 instead of 32=20
+ * - TEX can be only 0 (Tex not used by qemu)=20
+ * - no alias register=20
+ * - HardFault instead of MemManage=20
+ */=20
static bool get_phys_addr_pmsav7(CPUARMState *env,=20
S1Translate *ptw,=20
uint32_t address,=20
@@ -2423,11 +2430,19 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,=
=20
continue;=20
}=20

- if (!rsize) {=20
+ /* Issue warning for invalid values=20
+ * for armv7-m rsize >=3D 4 (min 32)=20
+ * for armv6-m rsize >=3D 7 (min 256)=20
+ */=20
+ if (!rsize ||=20
+ (arm_feature(env, ARM_FEATURE_M) && (=20
+ rsize < 7 ||=20
+ (rsize < 4 && !arm_feature(env, ARM_FEATURE_V7))))) {=20
qemu_log_mask(LOG_GUEST_ERROR,=20
- "DRSR[%d]: Rsize field cannot be 0\n", n);=20
+ "DRSR[%d]: Rsize field cannot be %d\n", n, rsize);=20
continue;=20
}=20
+=20
rsize++;=20
rmask =3D (1ull << rsize) - 1;=20

@@ -3515,8 +3530,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1T=
ranslate *ptw,=20
/* PMSAv8 */=20
ret =3D get_phys_addr_pmsav8(env, ptw, address, access_type,=20
result, fi);=20
- } else if (arm_feature(env, ARM_FEATURE_V7)) {=20
- /* PMSAv7 */=20
+ } else if (arm_feature(env, ARM_FEATURE_V7) || arm_feature(env, ARM_FEATU=
RE_M)) {=20
+ /* PMSAv7 or PMSAv6 */=20
ret =3D get_phys_addr_pmsav7(env, ptw, address, access_type,=20
result, fi);=20
} else {=20
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c=20
index 58e54578d6..01bc5d4375 100644=20
--- a/target/arm/tcg/cpu-v7m.c=20
+++ b/target/arm/tcg/cpu-v7m.c=20
@@ -76,6 +76,20 @@ static void cortex_m0_initfn(Object *obj)=20
cpu->isar.id_isar6 =3D 0x00000000;=20
}=20

+static void cortex_m0p_initfn(Object *obj)=20
+{=20
+ ARMCPU *cpu =3D ARM_CPU(obj);=20
+=20
+ /* cortex-m0p is a cortex-m0 with=20
+ * vtor and mpu extension=20
+ */=20
+ cortex_m0_initfn(obj);=20
+=20
+ cpu->midr =3D 0x410cc601;=20
+ cpu->pmsav7_dregion =3D 8;=20
+}=20
+=20
+=20
static void cortex_m3_initfn(Object *obj)=20
{=20
ARMCPU *cpu =3D ARM_CPU(obj);=20
@@ -111,6 +125,7 @@ static void cortex_m4_initfn(Object *obj)=20
set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);=20
cpu->midr =3D 0x410fc240; /* r0p0 */=20
cpu->pmsav7_dregion =3D 8;=20
+ /* VFPv4-SP */=20
cpu->isar.mvfr0 =3D 0x10110021;=20
cpu->isar.mvfr1 =3D 0x11000011;=20
cpu->isar.mvfr2 =3D 0x00000000;=20
@@ -141,6 +156,7 @@ static void cortex_m7_initfn(Object *obj)=20
set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);=20
cpu->midr =3D 0x411fc272; /* r1p2 */=20
cpu->pmsav7_dregion =3D 8;=20
+ /* VFPv5 DP */=20
cpu->isar.mvfr0 =3D 0x10110221;=20
cpu->isar.mvfr1 =3D 0x12000011;=20
cpu->isar.mvfr2 =3D 0x00000040;=20
@@ -173,6 +189,7 @@ static void cortex_m33_initfn(Object *obj)=20
cpu->midr =3D 0x410fd213; /* r0p3 */=20
cpu->pmsav7_dregion =3D 16;=20
cpu->sau_sregion =3D 8;=20
+ /* VFPv5 DP */=20
cpu->isar.mvfr0 =3D 0x10110021;=20
cpu->isar.mvfr1 =3D 0x11000011;=20
cpu->isar.mvfr2 =3D 0x00000040;=20
@@ -209,7 +226,7 @@ static void cortex_m55_initfn(Object *obj)=20
cpu->revidr =3D 0;=20
cpu->pmsav7_dregion =3D 16;=20
cpu->sau_sregion =3D 8;=20
- /* These are the MVFR* values for the FPU + full MVE configuration */=20
+ /* These are the MVFR* values for the FPv5-D16-M + full MVE configuration=
 */=20
cpu->isar.mvfr0 =3D 0x10110221;=20
cpu->isar.mvfr1 =3D 0x12100211;=20
cpu->isar.mvfr2 =3D 0x00000040;=20
@@ -267,6 +284,8 @@ static void arm_v7m_class_init(ObjectClass *oc, void *d=
ata)=20
static const ARMCPUInfo arm_v7m_cpus[] =3D {=20
{ .name =3D "cortex-m0", .initfn =3D cortex_m0_initfn,=20
.class_init =3D arm_v7m_class_init },=20
+ { .name =3D "cortex-m0p", .initfn =3D cortex_m0p_initfn,=20
+ .class_init =3D arm_v7m_class_init },=20
{ .name =3D "cortex-m3", .initfn =3D cortex_m3_initfn,=20
.class_init =3D arm_v7m_class_init },=20
{ .name =3D "cortex-m4", .initfn =3D cortex_m4_initfn,=20
--=20
2.39.5=20



------=_Part_377326697_69394490.1729627807613
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'><div>Hello,</div><div><br></div><div>Please ignore th=
is mail,</div><div>I was doing some test and didn't realise real email was =
added.<br></div><div><br></div><div>I will resend the real one.</div><div><=
br></div><div>Thanks.<br></div><br><hr id=3D"zwchr"><div style=3D"color:#00=
0;font-weight:normal;font-style:normal;text-decoration:none;font-family:Hel=
vetica,Arial,sans-serif;font-size:12pt;"><b>De: </b>"Matthieu Castet" &lt;c=
astet.matthieu@free.fr&gt;<br><b>=C3=80: </b>"castet matthieu" &lt;castet.m=
atthieu@free.fr&gt;<br><b>Cc: </b>"Peter Maydell" &lt;peter.maydell@linaro.=
org&gt;, "open list:ARM cores" &lt;qemu-arm@nongnu.org&gt;, "open list:All =
patches CC here" &lt;qemu-devel@nongnu.org&gt;<br><b>Envoy=C3=A9: </b>Mardi=
 22 Octobre 2024 22:03:10<br><b>Objet: </b>[PATCH 1/1] target/arm: Add cort=
ex-m0+ support<br><br>Signed-off-by: Matthieu Castet&lt;castet.matthieu@fre=
e.fr&gt;<br>---<br>&nbsp;hw/intc/armv7m_nvic.c &nbsp; &nbsp;| 38 ++++++++++=
+++++++++++++++++++++++-----<br>&nbsp;target/arm/cpu.c &nbsp; &nbsp; &nbsp;=
 &nbsp; | &nbsp;4 ++--<br>&nbsp;target/arm/ptw.c &nbsp; &nbsp; &nbsp; &nbsp=
; | 23 +++++++++++++++++++----<br>&nbsp;target/arm/tcg/cpu-v7m.c | 21 +++++=
+++++++++++++++-<br>&nbsp;4 files changed, 74 insertions(+), 12 deletions(-=
)<br><br>diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c<br>inde=
x 98f3cf59bc..ed084e9db3 100644<br>--- a/hw/intc/armv7m_nvic.c<br>+++ b/hw/=
intc/armv7m_nvic.c<br>@@ -1386,7 +1386,7 @@ static uint32_t nvic_readl(NVIC=
State *s, uint32_t offset, MemTxAttrs attrs)<br>&nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp; }<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; return (cpu-&gt;env.pmsav7.dr=
bar[region] &amp; ~0x1f) | (region &amp; 0xf);<br>&nbsp;&nbsp; &nbsp; }<br>=
- &nbsp; &nbsp;case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */<br>+ &nbsp;=
 &nbsp;case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */<br>&nbsp;&nbsp;=
 &nbsp; case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */<br>&nbsp;&nb=
sp; &nbsp; case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */<br>&nbsp;=
&nbsp; &nbsp; case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */<br>@@ =
-1876,6 +1876,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, =
uint32_t value,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;<=
br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; }<br>&nbsp;<br>+ &nbsp; &nbsp; &nbsp; =
&nbsp;if (!arm_feature(&amp;s-&gt;cpu-&gt;env, ARM_FEATURE_V7)) {<br>+ &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (offset !=3D 0xd9c)<b=
r>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;goto bad_offset;<br>+<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;/* do not support size less than 256 */<br>+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;value &amp;=3D ~0xe0;<br>+ &nbs=
p; &nbsp; &nbsp; &nbsp;}<br>+<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; if (valu=
e &amp; (1 &lt;&lt; 4)) {<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; /* VALID bit means use the region number specified in this<br>&nbsp;&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* value and also update MPU_RNR.=
REGION with that value.<br>@@ -1900,12 +1908,13 @@ static void nvic_writel(=
NVICState *s, uint32_t offset, uint32_t value,<br>&nbsp;&nbsp; &nbsp; &nbsp=
; &nbsp; tlb_flush(CPU(cpu));<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; break;<b=
r>&nbsp;&nbsp; &nbsp; }<br>- &nbsp; &nbsp;case 0xda0: /* MPU_RASR (v7M), MP=
U_RLAR (v8M) */<br>- &nbsp; &nbsp;case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLA=
R_A1 (v8M) */<br>- &nbsp; &nbsp;case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_=
A2 (v8M) */<br>- &nbsp; &nbsp;case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3=
 (v8M) */<br>+ &nbsp; &nbsp;case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8=
M) */<br>+ &nbsp; &nbsp;case 0xda8: /* MPU_RASR_A1 (v6M/v7M), MPU_RLAR_A1 (=
v8M) */<br>+ &nbsp; &nbsp;case 0xdb0: /* MPU_RASR_A2 (v6M/v7M), MPU_RLAR_A2=
 (v8M) */<br>+ &nbsp; &nbsp;case 0xdb8: /* MPU_RASR_A3 (v6M/v7M), MPU_RLAR_=
A3 (v8M) */<br>&nbsp;&nbsp; &nbsp; {<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; i=
nt region =3D cpu-&gt;env.pmsav7.rnr[attrs.secure];<br>+ &nbsp; &nbsp; &nbs=
p; &nbsp;int rsize;<br>&nbsp;<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; if (arm_=
feature(&amp;cpu-&gt;env, ARM_FEATURE_V8)) {<br>&nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; /* PMSAv8M handling of the aliases is different from v=
7M:<br>@@ -1926,6 +1935,25 @@ static void nvic_writel(NVICState *s, uint32_=
t offset, uint32_t value,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; return;<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; }<br>&nbsp;<br>+ &nbsp; &nbs=
p; &nbsp; &nbsp;rsize =3D extract32(value, 1, 5);<br>+ &nbsp; &nbsp; &nbsp;=
 &nbsp;if (!arm_feature(&amp;s-&gt;cpu-&gt;env, ARM_FEATURE_V7)) {<br>+ &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (offset !=3D 0xda0)<br>+ &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto bad_offset;<br>+ &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* for armv6-m rsize &gt;=3D 7 (min 256) =
*/<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (rsize &lt; 7) {<br>+ &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qemu_log_mask(LOG_GUE=
ST_ERROR,<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;"MPU region size too small %d\n", rsize);<br>+ &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>+ &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;}<br>+ &nbsp; &nbsp; &nbsp; &nbsp;}<br>+<br>+ =
&nbsp; &nbsp; &nbsp; &nbsp;/* for armv7-m rsize &gt;=3D 4 (min 32) */<br>+ =
&nbsp; &nbsp; &nbsp; &nbsp;if (rsize &lt; 4) {<br>+ &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR,<br>+ &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"MPU region size too small =
%d\n", rsize);<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>+ &=
nbsp; &nbsp; &nbsp; &nbsp;}<br>+<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; if (r=
egion &gt;=3D cpu-&gt;pmsav7_dregion) {<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; return;<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; }<br>diff --gi=
t a/target/arm/cpu.c b/target/arm/cpu.c<br>index 1320fd8c8f..875e3aab69 100=
644<br>--- a/target/arm/cpu.c<br>+++ b/target/arm/cpu.c<br>@@ -508,7 +508,7=
 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)<br>&nbsp;&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;sizeof(*env-&gt;pmsav8.rlar[M_REG_S])<br>&nbsp;&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;* cpu-&gt;pmsav7_dregion);<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; }<br>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;} else if (arm_feature(env, ARM_FEATURE_V7)) {<br>+ &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;} else if (arm_feature(env, ARM_FEATURE_M)) {<br>&nbs=
p;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memset(env-&gt;pm=
sav7.drbar, 0,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;sizeof(*env-&gt;pmsav7.drbar) * cpu-&gt;pms=
av7_dregion);<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; memset(env-&gt;pmsav7.drsr, 0,<br>@@ -2454,7 +2454,7 @@ static void arm=
_cpu_realizefn(DeviceState *dev, Error **errp)<br>&nbsp;&nbsp; &nbsp; }<br>=
&nbsp;<br>&nbsp;&nbsp; &nbsp; if (arm_feature(env, ARM_FEATURE_PMSA) &amp;&=
amp;<br>- &nbsp; &nbsp; &nbsp; &nbsp;arm_feature(env, ARM_FEATURE_V7)) {<br=
>+ &nbsp; &nbsp; &nbsp; &nbsp;arm_feature(env, ARM_FEATURE_M)) {<br>&nbsp;&=
nbsp; &nbsp; &nbsp; &nbsp; uint32_t nr =3D cpu-&gt;pmsav7_dregion;<br>&nbsp=
;<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; if (nr &gt; 0xff) {<br>diff --git a/=
target/arm/ptw.c b/target/arm/ptw.c<br>index dd40268397..fa771907e3 100644<=
br>--- a/target/arm/ptw.c<br>+++ b/target/arm/ptw.c<br>@@ -2383,6 +2383,13 =
@@ static bool pmsav7_use_background_region(ARMCPU *cpu, ARMMMUIdx mmu_idx,=
<br>&nbsp;&nbsp; &nbsp; return regime_sctlr(env, mmu_idx) &amp; SCTLR_BR;<b=
r>&nbsp;}<br>&nbsp;<br>+/* armv6m PMSAv6 is mostly compatible with PMSAv7,<=
br>+ * main difference :<br>+ * - min region size is 256 instead of 32<br>+=
 * - TEX can be only 0 (Tex not used by qemu)<br>+ * - no alias register<br=
>+ * - HardFault instead of MemManage<br>+ */<br>&nbsp;static bool get_phys=
_addr_pmsav7(CPUARMState *env,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;S1Translate *ptw,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;uint32_t address,<br>@@ -2423,11 +2430,19 @@ static bool get_phys_addr_p=
msav7(CPUARMState *env,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; continue;<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
}<br>&nbsp;<br>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!rsize) {<br>=
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Issue warning for invalid val=
ues<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * for armv7-m rsize &gt;=
=3D 4 (min 32)<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * for armv6-m=
 rsize &gt;=3D 7 (min 256)<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *=
/<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!rsize ||<br>+ &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(arm_feature(env, ARM_FEATUR=
E_M) &amp;&amp; (<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; rsize &lt; 7 ||<br>+ &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (rsize &lt; 4 &amp;&amp; !a=
rm_feature(env, ARM_FEATURE_V7))))) {<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; qemu_log_mask(LOG_GUEST_ERROR,<br>- &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;"DRSR[%d]: Rsize field cannot be 0\n", n);<br>+ &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;"DRSR[%d]: Rsize field cannot be %d\n", n, rsize);<br>&=
nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>&=
nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>+<br>&nbsp;&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rsize++;<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; rmask =3D (1ull &lt;&lt; rsize) - 1;<br>&nbsp;<br>@@ -3515,8=
 +3530,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *=
ptw,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* PMSAv8 */<br>&nb=
sp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D get_phys_addr_pmsav8(e=
nv, ptw, address, access_type,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;result, fi);<br>- &nbsp; &nbsp; &nbsp; &nbsp;}=
 else if (arm_feature(env, ARM_FEATURE_V7)) {<br>- &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;/* PMSAv7 */<br>+ &nbsp; &nbsp; &nbsp; &nbsp;} else if (ar=
m_feature(env, ARM_FEATURE_V7) || arm_feature(env, ARM_FEATURE_M)) {<br>+ &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* PMSAv7 or PMSAv6 */<br>&nbsp;&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D get_phys_addr_pmsav7(env, pt=
w, address, access_type,<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;result, fi);<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; } =
else {<br>diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c<=
br>index 58e54578d6..01bc5d4375 100644<br>--- a/target/arm/tcg/cpu-v7m.c<br=
>+++ b/target/arm/tcg/cpu-v7m.c<br>@@ -76,6 +76,20 @@ static void cortex_m0=
_initfn(Object *obj)<br>&nbsp;&nbsp; &nbsp; cpu-&gt;isar.id_isar6 =3D 0x000=
00000;<br>&nbsp;}<br>&nbsp;<br>+static void cortex_m0p_initfn(Object *obj)<=
br>+{<br>+ &nbsp; &nbsp;ARMCPU *cpu =3D ARM_CPU(obj);<br>+<br>+ &nbsp; &nbs=
p;/* cortex-m0p is a cortex-m0 with<br>+ &nbsp; &nbsp; * vtor and mpu exten=
sion<br>+ &nbsp; &nbsp; */<br>+ &nbsp; &nbsp;cortex_m0_initfn(obj);<br>+<br=
>+ &nbsp; &nbsp;cpu-&gt;midr =3D 0x410cc601;<br>+ &nbsp; &nbsp;cpu-&gt;pmsa=
v7_dregion =3D 8;<br>+}<br>+<br>+<br>&nbsp;static void cortex_m3_initfn(Obj=
ect *obj)<br>&nbsp;{<br>&nbsp;&nbsp; &nbsp; ARMCPU *cpu =3D ARM_CPU(obj);<b=
r>@@ -111,6 +125,7 @@ static void cortex_m4_initfn(Object *obj)<br>&nbsp;&n=
bsp; &nbsp; set_feature(&amp;cpu-&gt;env, ARM_FEATURE_THUMB_DSP);<br>&nbsp;=
&nbsp; &nbsp; cpu-&gt;midr =3D 0x410fc240; /* r0p0 */<br>&nbsp;&nbsp; &nbsp=
; cpu-&gt;pmsav7_dregion =3D 8;<br>+ &nbsp; &nbsp;/* VFPv4-SP */<br>&nbsp;&=
nbsp; &nbsp; cpu-&gt;isar.mvfr0 =3D 0x10110021;<br>&nbsp;&nbsp; &nbsp; cpu-=
&gt;isar.mvfr1 =3D 0x11000011;<br>&nbsp;&nbsp; &nbsp; cpu-&gt;isar.mvfr2 =
=3D 0x00000000;<br>@@ -141,6 +156,7 @@ static void cortex_m7_initfn(Object =
*obj)<br>&nbsp;&nbsp; &nbsp; set_feature(&amp;cpu-&gt;env, ARM_FEATURE_THUM=
B_DSP);<br>&nbsp;&nbsp; &nbsp; cpu-&gt;midr =3D 0x411fc272; /* r1p2 */<br>&=
nbsp;&nbsp; &nbsp; cpu-&gt;pmsav7_dregion =3D 8;<br>+ &nbsp; &nbsp;/* VFPv5=
 DP */<br>&nbsp;&nbsp; &nbsp; cpu-&gt;isar.mvfr0 =3D 0x10110221;<br>&nbsp;&=
nbsp; &nbsp; cpu-&gt;isar.mvfr1 =3D 0x12000011;<br>&nbsp;&nbsp; &nbsp; cpu-=
&gt;isar.mvfr2 =3D 0x00000040;<br>@@ -173,6 +189,7 @@ static void cortex_m3=
3_initfn(Object *obj)<br>&nbsp;&nbsp; &nbsp; cpu-&gt;midr =3D 0x410fd213; /=
* r0p3 */<br>&nbsp;&nbsp; &nbsp; cpu-&gt;pmsav7_dregion =3D 16;<br>&nbsp;&n=
bsp; &nbsp; cpu-&gt;sau_sregion =3D 8;<br>+ &nbsp; &nbsp;/* VFPv5 DP */<br>=
&nbsp;&nbsp; &nbsp; cpu-&gt;isar.mvfr0 =3D 0x10110021;<br>&nbsp;&nbsp; &nbs=
p; cpu-&gt;isar.mvfr1 =3D 0x11000011;<br>&nbsp;&nbsp; &nbsp; cpu-&gt;isar.m=
vfr2 =3D 0x00000040;<br>@@ -209,7 +226,7 @@ static void cortex_m55_initfn(O=
bject *obj)<br>&nbsp;&nbsp; &nbsp; cpu-&gt;revidr =3D 0;<br>&nbsp;&nbsp; &n=
bsp; cpu-&gt;pmsav7_dregion =3D 16;<br>&nbsp;&nbsp; &nbsp; cpu-&gt;sau_sreg=
ion =3D 8;<br>- &nbsp; &nbsp;/* These are the MVFR* values for the FPU + fu=
ll MVE configuration */<br>+ &nbsp; &nbsp;/* These are the MVFR* values for=
 the FPv5-D16-M + full MVE configuration */<br>&nbsp;&nbsp; &nbsp; cpu-&gt;=
isar.mvfr0 =3D 0x10110221;<br>&nbsp;&nbsp; &nbsp; cpu-&gt;isar.mvfr1 =3D 0x=
12100211;<br>&nbsp;&nbsp; &nbsp; cpu-&gt;isar.mvfr2 =3D 0x00000040;<br>@@ -=
267,6 +284,8 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)=
<br>&nbsp;static const ARMCPUInfo arm_v7m_cpus[] =3D {<br>&nbsp;&nbsp; &nbs=
p; { .name =3D "cortex-m0", &nbsp; .initfn =3D cortex_m0_initfn,<br>&nbsp;&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;.class_init =3D arm_v7m_class_init },<br>+ &nbs=
p; &nbsp;{ .name =3D "cortex-m0p", &nbsp;.initfn =3D cortex_m0p_initfn,<br>=
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; .class_init =3D arm_v7m_class_init },<br>&nbsp;&nb=
sp; &nbsp; { .name =3D "cortex-m3", &nbsp; .initfn =3D cortex_m3_initfn,<br=
>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.class_init =3D arm_v7m_class_init },<b=
r>&nbsp;&nbsp; &nbsp; { .name =3D "cortex-m4", &nbsp; .initfn =3D cortex_m4=
_initfn,<br>-- <br>2.39.5<br><br></div><br></div></body></html>
------=_Part_377326697_69394490.1729627807613--

