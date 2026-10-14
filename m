Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E3CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvW6-0002xd-Au; Wed, 14 Oct 2026 05:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvW5-0002x3-BZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:21 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvW2-0001pU-2w
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:20 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-14fc585291cso255042c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970997; x=1792575797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AH8J4hMMZQ6UXsbUYLfgpG0PUEdWn62zq00iQ5goS44=;
 b=AQGFEbwe1Kef1kh4zeqxXsssZBwWEx+yw7Uj9wOK6hc4QJPLG9KDcg5x2w8gwq6uHt
 BHWQ8/Trug8zRC2q+VoxQGRa2J1D4yUO9IUBGhNTFGWYMskzYmC2xu0zQhrss4LiqlRy
 LSusVy1MAKO4O31EgFlms0hGiXCpwLQ94OQQd1vbRz9YkBvD5jWe0pGMuzNHAu1nvHKe
 l8ND2335RGWHsqSjo6y0/fXo5PgIbrU1s3qAJZGWMsysxiQFELSt8UKPvo9+oczPLBp2
 773tMIQbg8w+NqkmvNgWX0ldxmWWWNUOfe0LD5IXyPZAqSO8K7Pf7492ISMEGxNeEa2t
 JXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970997; x=1792575797;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AH8J4hMMZQ6UXsbUYLfgpG0PUEdWn62zq00iQ5goS44=;
 b=HpjMwUmPn7w+PHI4efFCx8hM9neq1jOFSZsaLDR2jxe7hTGG57mMEi9Or78KX1dkug
 1eeTKT18qQZEzfRSAUWzmex08GDUaGyXXXXo3g4ZxdF/Ubn476SMAB9s0TRxttn/kgpr
 3MDi6da8uhy1JBc0VuavYYLzKizszQrHvGgG7Qi4tr7xGo1PMOnt7Wf9Zlog3CTJhEnx
 YKPC8Wavn3hP/0LzHHyZRJEiiwhcxArpaRvH4XZCGvq0+PTFLVYN49yFk4uzQW+GgweD
 3bE9vrlRgoW/8jsapuxOMZ0S8nBJEtqUweLI6rZETJJOERw/f9rJGipyO4pHabMltwls
 ftBw==
X-Gm-Message-State: AFq9FYJTiMBP8PwoXUwo2ABH5P3DwNLR6wOGfN2Q87xYxOL45jNGxOSP
 9JlAUQxWpmBD/BPV3Fn/KibdYNoGivZPnripiq7MnhMI3DOAbnyx6Ms7T3xp426p38s=
X-Gm-Gg: AYBFou323GhvEYECpVKUjNMS2RvFyDRd5KcLmyEvC25wsuuAqpIdPpnf+Ivn/Y1Jo+u
 iH0qxZPJ8PSC8TCvWhQG8yOrbnunH8F/F4C7Rs7WcKlkbJn4AO6c5u8QEOICuwMjX1C7w8b1Yvk
 Mey90RZ63E/YNfyPEeimghMPj91C0BH3oeSWawPp62eKw77bhecXxL5DgPtGY1X5UcEw8hAhBcQ
 Qib89aM534Pj2JyB9XgGvP0+Is7b9rrSgBISX59bFocRd19rYprzcZnszbB+JARSNW4wBFYEUf6
 +7woB+CFma/gF6654LyN4cMsmBmFFXcfDzNJR0mi5yPzkylQqlE4sWgdYnqBPEOncuajMUXLc6d
 s5qadm1xBM/wcC4FWXRHDM9vItz0phWv8dzIkPEHKr0FWRDkNTiulsQqMQuwSIXkaeO831kQgnv
 YoX5F07HsIVexdVpMN+xR9ISPZxeCJTidKNbJTqQLjuJS8FnakXU35WjUrwExSgtYVcvnG30zwu
 3vB4AwUk52DAuJmxA==
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id
 a92af1059eb24-16a63b2edc7mr29895216c88.47.1791970996417; 
 Wed, 14 Oct 2026 02:43:16 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:43:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 20/34] hw/arm/virt: use unique QOM name
Date: Wed, 14 Oct 2026 17:41:35 +0800
Message-ID: <20261014094224.1976-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("arm-virt") so ARM virt
no longer collides with other virt-machine types in one process.
Keep the -M / help / migration name as virt-* via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/arm/virt.c         | 54 +++++++++++++++++++++++--------------------
 include/hw/arm/virt.h |  5 +++-
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d192515d85..ceb848ca386 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -121,23 +121,27 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         MachineClass *mc = MACHINE_CLASS(oc); \
         arm_virt_compat_default_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
-        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
+        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) \
+                   " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
         if (latest) { \
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
+        const TypeInfo virt_machine_info = \
+        { \
+            .name = target_combined_binary() ? \
+                    MACHINE_VER_TYPE_NAME("arm-virt", __VA_ARGS__) : \
+                    MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+            .parent = TYPE_VIRT_MACHINE, \
+            .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+            .is_available = target_base_arm, \
+        }; \
         MACHINE_VER_DELETION(__VA_ARGS__); \
-        type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
+        type_register_static(&virt_machine_info); \
     } \
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
@@ -4417,24 +4421,24 @@ static void virt_instance_finalize(Object *obj)
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
+        .name = TYPE_VIRT_MACHINE,
+        .parent = TYPE_MACHINE,
+        .abstract = true,
+        .instance_size = sizeof(VirtMachineState),
+        .class_size = sizeof(VirtMachineClass),
+        .class_init = virt_machine_class_init,
+        .instance_init = virt_instance_init,
+        .instance_finalize = virt_instance_finalize,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { }
+        },
+        .is_available = target_base_arm,
+    };
+
     type_register_static(&virt_machine_info);
 }
 type_init(machvirt_machine_init);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113..971eb973618 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -32,6 +32,7 @@
 
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
+#include "qemu/target-info.h"
 #include "hw/core/boards.h"
 #include "hw/acpi/ghes.h"
 #include "hw/arm/boot.h"
@@ -215,7 +216,9 @@ struct VirtMachineState {
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
 
-#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE (target_combined_binary() ? \
+                           MACHINE_TYPE_NAME("arm-virt") : \
+                           MACHINE_TYPE_NAME("virt"))
 OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
 
 void virt_acpi_setup(VirtMachineState *vms);
-- 
2.55.0.windows.3


