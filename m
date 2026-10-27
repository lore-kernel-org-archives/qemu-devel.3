Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF0606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AB9UqtYw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf85-00054K-Or; Tue, 27 Oct 2026 07:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7w-0004sG-8s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:14:00 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7u-00032W-Es
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:59 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-14394530ec6so4803298c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099637; x=1793704437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=djEK958qEcoYyAeCCSgCGspP+2+OhtrDxoakzVKTZlg=;
 b=AB9UqtYwzanmPuP8UDq0OvACSOU4K9gTa9KkIknT+fOTVxAV2kHeshkHcDr/VD2nIz
 eIjXQjvnR1JQeilJ45x0UUZfxpPyrTU5k8ZlT5EzeVs/MFQJNinMilyTiEQ390amTjQI
 ieQZ+6YfDT96+9omU3WY6mR26dsH+zQy1goyGQDyAWbyVetMupc4zxIxY0xt/y2LxuCO
 kh7TsghnYxGf6QG4yDHqsCbixDRx+UV7H5Jw5H1Uprn4I8vo5/sM8nUrleec0r9qkXM/
 lMJOtWVyySfQuh9bTIYreHHyTlfIUJuxTOeoUlCJO9eShVE/Z092aryKibsZpqQaXiOw
 wYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099637; x=1793704437;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=djEK958qEcoYyAeCCSgCGspP+2+OhtrDxoakzVKTZlg=;
 b=lMs8C5e6X/36ZRaX6F9lYWLxQrcDxDMkpy9bILocl0Q+ZvPs7UL/NGILqBPV7mBXoG
 K4G90oQoKkRM7qbgfGptajvuSg4P8tWSDIG4miXOzLPfeZVhUWmdmkU6dNpYk+lX05tB
 xevd/HSXTH+Sf2aSboi17f5g+V81pGG38IFusqtR7q/X4Xvo51luRuFgcx9G6OaC0POA
 HhBpfQhk7E+XrnybLds3ZGHQKj79SGygEcPgITBFca+6P0vUONFcqJA/q/gqtOtBUuPi
 VHdmA8JK25ugbt3qmdQKeUDHYV8qktywCLs4Xcx+Ockr8i90Qk0mj5PlDcVgJwwEmdhb
 yqgg==
X-Gm-Message-State: AFq9FYIy9Tt6FykjB7YKgHdD9Nrih4tMM21QHpEXbEAD5LvR/vFJodaS
 QK0sUYmCbREwppO+e88YZNfFKJN+iwhyCWg3cfCc6p161p6QU40EjcTLQ8YlpQQR
X-Gm-Gg: AYBFou2q7odTdisVYRo6JsEiL32oDISbnVfEJ4wGyH254LkeUk0uHiuh7LqQAALCQeT
 ubRTpdLEC/veg0X1QzPfuwVcj0CpoiEVeFUnjZLlLKT4n2l9oMXvBlbmuKbE0PPg9Mw3eAyG/09
 l73addqAe2bPcE/kKZDGEcX3DAOas1Gl93DK19clyRZPVewIOXmfpJFD+tRzuGJ13srw+g32iBM
 o3St7bggV10/n7/uVHs6IS88V3X/gLp/X3agiD1LSk8Ibc4ejlHYzZNoFR/OF9GxAYkyJuqCM1V
 Z3PrnaEinpK8DaN0JC7I37KPi16UINXZnRZ45AjJimOERyzrg5RFwFA57TrqRRJkgd2La9nTeDK
 5g0Ia6YOaUEK6tHbSQavGtsCY8nMlJRJ20q1dTEdILpEpfZAzNndsT0NAU/DFCnragWmkWKqq1W
 ErPrOi4WrCjuavGMelufG4u49HdpLf4dQoPw82LCOc9LTtP1V15hAUvDe3ofqvZV1UKvpRE3rvk
 bGXxvm/trg0fd2nTPFxKeaxp4gSxCmEBn9O1maPTqjqxMcQsDHdixm8pev4Q/lFTjL2Ewsisg2M
 cfMsTJjuc6yPFP6W5s2nQmvUesJMYO9TvbklnLZBO6HoHKT1s0TKICyajYHlKw==
X-Received: by 2002:a05:701b:4549:20b0:144:fdf0:9d91 with SMTP id
 a92af1059eb24-1993552f1d4mr13031780c88.24.1793099636801; 
 Tue, 27 Oct 2026 04:13:56 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:56 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 14/17] hw/m68k/virt: use unique QOM name
Date: Tue, 27 Oct 2026 19:12:12 +0800
Message-ID: <20261027111216.392-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the parent and versioned QOM types to m68k-virt when
target_heterogeneous() is true, and to virt otherwise. Keep the
-M / help / migration name as virt-* via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/m68k/virt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 4564dd650d9..2fd0ada4df8 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
@@ -322,10 +323,14 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "m68k_virt.ram";
 }
 
+#define TYPE_M68K_VIRT_MACHINE \
+    (target_heterogeneous() ? MACHINE_TYPE_NAME("m68k-virt") : \
+                              MACHINE_TYPE_NAME("virt"))
+
 static void virt_machine_register_types(void)
 {
     const TypeInfo virt_machine_info = {
-        .name         = MACHINE_TYPE_NAME("virt"),
+        .name         = TYPE_M68K_VIRT_MACHINE,
         .parent       = TYPE_MACHINE,
         .abstract     = true,
         .class_init   = virt_machine_class_init,
@@ -345,21 +350,24 @@ type_init(virt_machine_register_types)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-        const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+        const TypeInfo virt_machine_info = \
         { \
-            .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
-            .parent = MACHINE_TYPE_NAME("virt"), \
+            .name = target_heterogeneous() ? \
+                    MACHINE_VER_TYPE_NAME("m68k-virt", __VA_ARGS__) : \
+                    MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+            .parent = TYPE_M68K_VIRT_MACHINE, \
             .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
             .is_available = target_m68k, \
         }; \
         MACHINE_VER_DELETION(__VA_ARGS__); \
-        type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
+        type_register_static(&virt_machine_info); \
     } \
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
-- 
2.52.0.windows.1


