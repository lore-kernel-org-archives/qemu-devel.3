Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B71CC56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7s-0005rX-70; Fri, 20 Feb 2026 10:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS26-00087w-10; Fri, 20 Feb 2026 10:03:07 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS24-0002Il-9k; Fri, 20 Feb 2026 10:03:05 -0500
DKIM-Signature: a=rsa-sha256; bh=KygNMSHDJRpYUUZFihrvfUizAP5Rz6A+N42Aif3Z9Ac=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599775; v=1;
 b=nIRhPDRvDp5/0vDm2bbF6/J/6L+Yf180sFdNVFbw+hFk5KlWZmv3fz7ViG1KJHPe4mEDGLmw
 LJap8lnkv2csIKiqOcUUIU1lufxtj504/Jeb0Y8KuOYtyPfn00bpIgFBTzYsa/1PmAA5ddal7dR
 UXgGj0liQkVifF71H6Z8rjZS+qQq10AcUzjWMeBjJxo7tZm3aBFW3hnATsY+HPj6K8Cg5JPvBGi
 gDif9ZVGDggXW8APknX2BH82mVpH6Qt6CBc0orvGq7r717u0syW/lt4s9ve05CFHB484QAfUBVB
 OiRCyuTA5UcD2aGycjw7fSN9g+Qyb+2B5m+TEp2/0Q03A==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 5E38725016;
 Fri, 20 Feb 2026 15:02:55 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Thu, 27 Apr 2023 19:39:11 +0200
Subject: [PATCH qemu 01/11] [ot] target/riscv: rename ibex hart as lowrisc-ibex
Message-ID: <177159976712.8279.7732381632410882915-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

Follow vendor-device syntax used with other RISCV cores

Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>
---
 hw/riscv/opentitan.c   | 2 +-
 target/riscv/cpu-qom.h | 2 +-
 target/riscv/cpu.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 309125e854..19cb35b351 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -119,7 +119,7 @@ static void opentitan_machine_class_init(ObjectClass *oc,=
 const void *data)
     mc->desc =3D "RISC-V Board compatible with OpenTitan";
     mc->init =3D opentitan_machine_init;
     mc->max_cpus =3D 1;
-    mc->default_cpu_type =3D TYPE_RISCV_CPU_IBEX;
+    mc->default_cpu_type =3D TYPE_RISCV_CPU_LOWRISC_IBEX;
     mc->default_ram_id =3D "riscv.lowrisc.ibex.ram";
     mc->default_ram_size =3D ibex_memmap[IBEX_DEV_RAM].size;
 }
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 30dcdcfaae..3a6394fd11 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,7 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
-#define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
+#define TYPE_RISCV_CPU_LOWRISC_IBEX     RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..24a4c2fd3f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3043,7 +3043,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .misa_mxl_max =3D MXL_RV32,
     ),
=20
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_LOWRISC_IBEX, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max =3D MXL_RV32,
         .misa_ext =3D RVI | RVM | RVC | RVU,
         .priv_spec =3D PRIV_VERSION_1_12_0,
--=20
2.49.1


