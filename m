Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4069E9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSWz-0002OR-IU; Tue, 17 Feb 2026 16:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWy-0002Kw-OR
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:52 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWx-0002Gh-1h
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:52 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f04f1348cso3112210b6e.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363370; x=1771968170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zy5cfhZ/akH/6W5+lBFLkHvl4mJHVVUNe60+y4TZDh0=;
 b=IwHKfcBDlr9oPH4khoO3Ij3z4PHL2/0DrN8tuac+HvREhhjVLeAOPylixMjpugfoWJ
 QkZnko4a3YGFK5Wx761QX+piTHHFIpbVYwusjNmiDr7Ug9hd+cTImcddHhGWIYts0Z6l
 IFQ6Opp5Nmgwau4IBF43r2LkczCgUDX49lUCUfE2Fo3Sy3SDDYpukow8+IlEc1jUHZDo
 gSi7PDm4Cc5CE1+nAwskWIp/1YcHRo8/odXy9ZTCEmSL+OMF/JLA9Q2ZbDO8ZVSrw+oD
 QdKURqV0F1IdnJo3T6Ej4clLnYUk2x6CeOgVCDhX9AV8Gftagefar3pGAmo2/xCIb89Z
 6gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363370; x=1771968170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zy5cfhZ/akH/6W5+lBFLkHvl4mJHVVUNe60+y4TZDh0=;
 b=GkLwoI0j19k8ffUPjLxpYMxcfiW+1h8OYP2+JInHVaM7qBlOk9vmNOa8j7nEAJjLdQ
 KJXq7yMb2FdS1sT3j3IwYg6DlC8mG0gv9R8Z3AEQm2CBNqpiawVMFNFywiHgVVmfreUH
 17WjhsXVz+sI+/+wbZppSCOsg24CLp/fO+VvqOfxyjM4dTESmNZU37CtzymhakVmJ3Lc
 id1hGdfbfbUCASLhEyHksvzg41qgv3ioBApi3sa6p7sIpMD7qdsiWZ63UVV5lLtSYgYZ
 SkCd/9zzhoWxMHcrAfZ8tlriUqaZ9WY6xAD5PupmsptNS8+DGme0SKre62FuN06auXhS
 pj2A==
X-Gm-Message-State: AOJu0Yx7tC7rzqWXn4kacydGIN9tXsedEDbZR5P3zkQPbEuyge6L0tIW
 m5XbhA3u/LLbqAY+WToXPvxEr1xwsH9TU0Nr529qU2byjZDYdJ76UV5hf9vOmQ==
X-Gm-Gg: AZuq6aL9qFsBxpKL6M7s1f5Etx03IgRuGMwR0EyrGEE/QiZ2dLULyEZno9kcNOraeK9
 jNyhVylr4HkUFjSFGZJ4rrv8LtGB/ec6FeOhplXWiHBLIdKnozgPjkXp6SDTchJIrbDmba1zaYC
 j3OEfkeifjViCLHSWUq819KwLkjCiCOrjqQiruxlik65/mO89Bf2qLTrrUJdB10K0Hy/uXKIcF1
 +ni5oakYcAPBf7tGHa10oh7o3ylopzzClVSe43FF6/ESi8gqaTtgns6d6nBUuSytDJSRhTGdSWL
 rKSzTd0vHfw0MAj+sNcvfJ9xdR0dSKQsA3QETXUOJzhfGnfoqueAfxWOoVO0C/biyki+bVykFXX
 G/yE4tm/7tIQjwz99veCmEQVKKMrr1xXjGaUX7iYj5JUSlK2E4baNGKOTfE8xS8fNBMVOvrgdV9
 Tpdn1ztJfpWf6rY4ABh8xh2+rRwPf2PeDIxrHEXqJWhQaHwXQYzZnT+gJkikAn6BLUmhUCURBMo
 rWoaMpiQYtKCU6F
X-Received: by 2002:a05:6808:514b:b0:45e:f443:dc3d with SMTP id
 5614622812f47-463b3f0647cmr6921029b6e.13.1771363369589; 
 Tue, 17 Feb 2026 13:22:49 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:48 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 1/8] Hexagon (target/hexagon) Properly handle Hexagon CPU
 version
Date: Tue, 17 Feb 2026 14:22:38 -0700
Message-ID: <20260217212245.95321-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the following CPU versions that were previously missing
    v5
    v55
    v60
    v61
    v62
    v65

Create a CPUHexagonDef struct to represent the definition of a core
    Currently contains an enum with the known Hexagon CPU versions
Add a field to HexagonCPUClass to note the Hexagon definition

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/cpu-qom.h | 27 +++++++++++++++++++++++
 target/hexagon/cpu.h     |  2 ++
 target/hexagon/cpu.c     | 46 ++++++++++++++++++++++++----------------
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
index 0b149bd5fe..6e1bb04070 100644
--- a/target/hexagon/cpu-qom.h
+++ b/target/hexagon/cpu-qom.h
@@ -11,11 +11,38 @@
 
 #include "hw/core/cpu.h"
 
+typedef enum {
+    HEX_VER_NONE = 0x00,
+    HEX_VER_V5 = 0x04,
+    HEX_VER_V55 = 0x05,
+    HEX_VER_V60 = 0x60,
+    HEX_VER_V61 = 0x61,
+    HEX_VER_V62 = 0x62,
+    HEX_VER_V65 = 0x65,
+    HEX_VER_V66 = 0x66,
+    HEX_VER_V67 = 0x67,
+    HEX_VER_V68 = 0x68,
+    HEX_VER_V69 = 0x69,
+    HEX_VER_V71 = 0x71,
+    HEX_VER_V73 = 0x73,
+    HEX_VER_ANY = 0xff,
+} HexagonVersion;
+
+typedef struct {
+    HexagonVersion hex_version;
+} HexagonCPUDef;
+
 #define TYPE_HEXAGON_CPU "hexagon-cpu"
 
 #define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
 #define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
 
+#define TYPE_HEXAGON_CPU_V5 HEXAGON_CPU_TYPE_NAME("v5")
+#define TYPE_HEXAGON_CPU_V55 HEXAGON_CPU_TYPE_NAME("v55")
+#define TYPE_HEXAGON_CPU_V60 HEXAGON_CPU_TYPE_NAME("v60")
+#define TYPE_HEXAGON_CPU_V61 HEXAGON_CPU_TYPE_NAME("v61")
+#define TYPE_HEXAGON_CPU_V62 HEXAGON_CPU_TYPE_NAME("v62")
+#define TYPE_HEXAGON_CPU_V65 HEXAGON_CPU_TYPE_NAME("v65")
 #define TYPE_HEXAGON_CPU_V66 HEXAGON_CPU_TYPE_NAME("v66")
 #define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
 #define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 85afd59277..f99647dfb6 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -117,6 +117,8 @@ typedef struct HexagonCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+
+    const HexagonCPUDef *hex_def;
 } HexagonCPUClass;
 
 struct ArchCPU {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 58a22ee41f..949d509a15 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -27,13 +27,6 @@
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
 
-static void hexagon_v66_cpu_init(Object *obj) { }
-static void hexagon_v67_cpu_init(Object *obj) { }
-static void hexagon_v68_cpu_init(Object *obj) { }
-static void hexagon_v69_cpu_init(Object *obj) { }
-static void hexagon_v71_cpu_init(Object *obj) { }
-static void hexagon_v73_cpu_init(Object *obj) { }
-
 static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -377,11 +370,21 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
     cc->tcg_ops = &hexagon_tcg_ops;
 }
 
-#define DEFINE_CPU(type_name, initfn)      \
-    {                                      \
-        .name = type_name,                 \
-        .parent = TYPE_HEXAGON_CPU,        \
-        .instance_init = initfn            \
+static void hexagon_cpu_class_base_init(ObjectClass *c, const void *data)
+{
+    HexagonCPUClass *mcc = HEXAGON_CPU_CLASS(c);
+    /* Make sure all CPU models define a HexagonCPUDef */
+    g_assert(!object_class_is_abstract(c) && data != NULL);
+    mcc->hex_def = data;
+}
+
+#define DEFINE_CPU(type_name, version)         \
+    {                                          \
+        .name = type_name,                     \
+        .parent = TYPE_HEXAGON_CPU,            \
+        .class_data = &(const HexagonCPUDef) { \
+            .hex_version = version,            \
+        }                                      \
     }
 
 static const TypeInfo hexagon_cpu_type_infos[] = {
@@ -394,13 +397,20 @@ static const TypeInfo hexagon_cpu_type_infos[] = {
         .abstract = true,
         .class_size = sizeof(HexagonCPUClass),
         .class_init = hexagon_cpu_class_init,
+        .class_base_init = hexagon_cpu_class_base_init,
     },
-    DEFINE_CPU(TYPE_HEXAGON_CPU_V66,              hexagon_v66_cpu_init),
-    DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              hexagon_v67_cpu_init),
-    DEFINE_CPU(TYPE_HEXAGON_CPU_V68,              hexagon_v68_cpu_init),
-    DEFINE_CPU(TYPE_HEXAGON_CPU_V69,              hexagon_v69_cpu_init),
-    DEFINE_CPU(TYPE_HEXAGON_CPU_V71,              hexagon_v71_cpu_init),
-    DEFINE_CPU(TYPE_HEXAGON_CPU_V73,              hexagon_v73_cpu_init),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V5,               HEX_VER_V5),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V55,              HEX_VER_V55),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V60,              HEX_VER_V60),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V61,              HEX_VER_V61),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V62,              HEX_VER_V62),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V65,              HEX_VER_V65),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V66,              HEX_VER_V66),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              HEX_VER_V67),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V68,              HEX_VER_V68),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V69,              HEX_VER_V69),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V71,              HEX_VER_V71),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V73,              HEX_VER_V73),
 };
 
 DEFINE_TYPES(hexagon_cpu_type_infos)
-- 
2.43.0


