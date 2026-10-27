Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6C606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sard79wd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf6i-0002nW-0l; Tue, 27 Oct 2026 07:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6g-0002n4-Mm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:12:42 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6f-0002pr-16
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:12:42 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-170135e43c7so58786c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099560; x=1793704360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36oteUhTJFTk0IqSSkD4FAEx6M4KXp6MopAQITFyFSI=;
 b=Sard79wdQa6JK0Ovn6E7ZrYPJ3/wD8uT5Dc5va2fsMqzYPAk6DXG4RZ2+B0aztcuXS
 ZhdkdaZd0vKs7xaAbJiFBN3PV6kGtoDxmhT6ni9sfjE4f230/Fb05IV+LDHYtVZnIDjp
 ppRSUds1nj2hm06Vrk9aJS7HHWyD3lLXXyyn0p0Fpno07GLnKNqbP23lC2eAIxD0HpoS
 R68aM9fesPICoLDZWRJegUUZl1bl4OxH2IAui+HIq+wR6iWgRgTTxmZsOfAAozOG1uqb
 x+GizBa6Ik1Ay7ciLaTHG5HuQm0AYM4EKrNrjGGf97lKe3wVpDx4oIZGc4dNoItp5bjI
 VxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099560; x=1793704360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=36oteUhTJFTk0IqSSkD4FAEx6M4KXp6MopAQITFyFSI=;
 b=NtDdp26aKRaE/Y7TKxarqIZaTajq37+ShQz+OjxRs4umVN597E8UCAfsp1S5LjLHea
 CMsgaxpCFP+qZi+zHdOLyJAebqejgVELkj8Nv7MyPGw+VCLxtPKQMnzfvr7CKhFwYQCl
 036yiI5WmJ9ixgxQpfzH0iZ+bCsQDujmDqH2QfMkkH3QdAooP2nCqdIHh0WdZOlbnh5D
 Of6R1MQUvTfE2XeLh+nqKgBKlvuZp2i4K58ILJ9C8NX4XouamOqHF76GAkDnD6PP91Wr
 Ut7UsVQssJpzZib58+pCF0g2eOjo2XxUvjoZzR0Qj6idxVmkm/AVyL/3X1CWCFBHw1cv
 CXJQ==
X-Gm-Message-State: AFq9FYK3FMIAftCAJAdt8yPercjqyEYjSpqWQ0rAD4AxEaYzf5KVYZPC
 XeB1uwdCM0kmoVQb9EtT7unTkE+D1OEFTmlmSCmPIobeVi+y0Y2a6NIASdJh1Kb2
X-Gm-Gg: AYBFou3Tb13T4V/fyN8z7nXR1+ofU2kpnw15z24Mr/B1p9hvQOcGMo6sFtF4zybdTG3
 OBxFETO4k4rP23nuwVrHffgROW3tc1kYg7WQHywo4AMZpavgVAh2njEmwQQuIQD6Ogaf+PoiwzN
 H1+RIxnIDBA4x36WRhFt345X9W1qVssvabR/q9a65f/nE6X6AMdYrD1uR96I3csomt+Kz5MWGC6
 ui08Yf90l00PTzLb1ZpO2yApCfXog1k9fCfGHp/K9DFLV1eg1xLmgrOD9OjnGUsDljFCS2SnTu5
 cTgDj6SfVBzoYni4Ji2dYPq8C+yKc2P7CwaUY34p7bgMl1BQYQIQD4dcDok0/pdOIn2dLxw4tKx
 YKj26LJ0fjWIzQCdYwzG3m0cC04pB8vNSEXKsHZ2rEHA7jB7oF6CLEJ8HE4lBSx5CIjo/KrZRo6
 PiYnGiUEMMPATOvG+QK5XO1jmlQjShScbOGf1wb0qw6vEILWfUb4Giwkq98B366n0fGwqYe1eZa
 ujX/4n0/Dwm9WF7uLORHcCR3ff1X5jv78CtAPRG0TVe65vM043pgrsOqfVxAa9YzltwcTPAEM8C
 Otvn4edjB21b
X-Received: by 2002:a05:701b:464d:b0:18a:d7db:f76 with SMTP id
 a92af1059eb24-1993fe81371mr12765255c88.36.1793099559585; 
 Tue, 27 Oct 2026 04:12:39 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:12:38 -0700 (PDT)
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
Subject: [PATCH v4 02/17] hw/arm/virt: move virt TypeInfo into its type_init
Date: Tue, 27 Oct 2026 19:12:00 +0800
Message-ID: <20261027111216.392-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The base virt type and each versioned type are file-scope
constants, so .name has to be a constant expression. Move
them into the type init functions so a later commit can
compute the name: "virt" for a single-target binary, and
"<target_base_name>-virt" for a multi-target binary.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/virt.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d56197dace..ba55d7c90f3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -127,15 +127,15 @@ static void arm_virt_compat_default_set(MachineClass *mc)
             mc->alias = "virt"; \
         } \
     } \
-    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
-    { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
-        .parent = TYPE_VIRT_MACHINE, \
-        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .is_available = target_base_arm, \
-    }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
+        const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+        { \
+            .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+            .parent = TYPE_VIRT_MACHINE, \
+            .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+            .is_available = target_base_arm, \
+        }; \
         MACHINE_VER_DELETION(__VA_ARGS__); \
         type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
@@ -4419,24 +4419,23 @@ static void virt_instance_finalize(Object *obj)
     g_ptr_array_free(vms->smmuv3_devices, TRUE);
 }
 
-static const TypeInfo virt_machine_info = {
-    .name          = TYPE_VIRT_MACHINE,
-    .parent        = TYPE_MACHINE,
-    .abstract      = true,
-    .instance_size = sizeof(VirtMachineState),
-    .class_size    = sizeof(VirtMachineClass),
-    .class_init    = virt_machine_class_init,
-    .instance_init = virt_instance_init,
-    .instance_finalize = virt_instance_finalize,
-    .interfaces = (const InterfaceInfo[]) {
-         { TYPE_HOTPLUG_HANDLER },
-         { }
-    },
-    .is_available = target_base_arm,
-};
-
 static void machvirt_machine_init(void)
 {
+    const TypeInfo virt_machine_info = {
+        .name          = TYPE_VIRT_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .abstract      = true,
+        .instance_size = sizeof(VirtMachineState),
+        .class_size    = sizeof(VirtMachineClass),
+        .class_init    = virt_machine_class_init,
+        .instance_init = virt_instance_init,
+        .instance_finalize = virt_instance_finalize,
+        .interfaces = (const InterfaceInfo[]) {
+             { TYPE_HOTPLUG_HANDLER },
+             { }
+        },
+        .is_available = target_base_arm,
+    };
     type_register_static(&virt_machine_info);
 }
 type_init(machvirt_machine_init);
-- 
2.52.0.windows.1


