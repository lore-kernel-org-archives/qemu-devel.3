Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEAFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lEk-0005C7-8r; Tue, 30 Sep 2025 21:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEi-0005Bw-77
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEa-0007xW-F3
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so47362895e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280536; x=1759885336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E95z1LitnEsQAC+IDKkKPOZh6LcS9ALCsacoPjved+U=;
 b=DhnrnXn4Tc0q4q2rZjfCzaLGWLVay6+CVDzrSaJNYV4VX9586P0PjrYaFAu/aOjBXM
 fzULzfBw02hFDU3sNYjvRCuQ4pMWonFpUF3SfrsWmRmbs8PcSuPbAiEDZ/7CkvN7ZPqE
 iPNDTGGuEukcnMJ4CwWcqIRaigC6C+pFI+GF/oXUxxXgXQlLgale+BLANvFVDywXfxtn
 KqeA5S+xbo5i18hO30fo/Cr3OQV8YCUAhBdI4rch2yyyinEP3ZCvuwAHqXdVUffEBIbJ
 P04vOvdwswppwCIMS38Q50jv2KAXHrSRTp5xW4U9uEy5F6RAIaHrd+XbHpQwbY9PTdtR
 lyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280536; x=1759885336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E95z1LitnEsQAC+IDKkKPOZh6LcS9ALCsacoPjved+U=;
 b=Vb7mQWyi2/bTvB1CB1ayzCXSIbXH6sVHhoF42gOv69EGzO74SqzSFRRPhQhZByTPBT
 j/NO0dr4HW3T8L4snXKPxnKcvx6RbQvnojFuSAlz69IrO5qv9Kdgfky9D3KMyWrj++0y
 8Sq9LuWOzy2CioxVtfmkLrSpRNXwlKC/0sa3Ti4UZ5LSGiL8Bcp79A8n4Kralqdv5TjU
 eNtxSXJHcwTR50wL4K9q6Z9GUcZmo6Qo9ClYLHf4RQe5KWkK1QuG3Qv1MkME5InqHwRu
 gr85BG3QxyN4iS+KoeuTMv7GP/V20MLXfpyQoKuqe//juDeGQwUzhRub5x6FEvS6+u85
 6hMQ==
X-Gm-Message-State: AOJu0Yw9xy0E/iC/olNveUEsEjl9EoY8G8gH0JFNDNU3L1WXxcmbX6d7
 yT9wDWBtI1Z3t2XwglW04kKXnp55HuUeYpxtw9lBrGFGQ4yYID/3LTrxMmS4U75IVugYqo1tAV2
 z8mtpTpRUNw==
X-Gm-Gg: ASbGncuwjtUElM5GteH1ReXhM4v2MoxqXZmIFfvYYjbYdTa/vlS0n91Q5NRtBcbFJ3L
 r6Dg1F5FquOtrspR2dbszONy6CXM/O87+ojyxlkanP+/STsN5nupDuR3i6R0a78alZLvpu9szaH
 dF3FxTzHL69S4BGXQO8eqggQKc3DYxdeKFWFSfNMf96srZDhHgER5NRmUnHy27GFZ/Pc8gq+AZM
 NZB+ZSUFH/mDa2033mUHR1nhPPBEh1BxI1J18HAgr9CqsEmHP+hwDUO5UTvjxRnLqMsibhz6/3j
 y0gRbRBxyH9+FZTdAiP8cPu+/mQfUkWQa/mcvPIxvkvLcDcsR1s/lat/BX2hLsdBfBZMriAyIZB
 /k7BPL/8IIvhXlj8q6ddzxheyUfGrN6Qjew8w9rh/inthxH8m5BmthkD/rCPZxhPdFz1YGJCbZ+
 z74aZIUADD7mzssGDvJfkFbQ3S2hHpTIZlaKhLs7yhPqmoZrxK4lbyIw==
X-Google-Smtp-Source: AGHT+IH40O7EwScL5QaCUo3bATKbMaaGb/W4QizlO/YTtsqCqCReWYP7rh5t8KrEv01hrhpIzc8IZQ==
X-Received: by 2002:a05:600c:4748:b0:46e:5df3:190d with SMTP id
 5b1f17b1804b1-46e61285eb1mr11032815e9.11.1759280536078; 
 Tue, 30 Sep 2025 18:02:16 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:15 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 01/24] hw/core: Introduce administrative power-state
 property and its accessors
Date: Wed,  1 Oct 2025 01:01:04 +0000
Message-Id: <20251001010127.3092631-2-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

Some devices cannot be hot-unplugged, either because removal is not meaningful
(e.g. on-board devices) or not supported (e.g. certain PCIe devices). Others,
such as CPUs on architectures like ARM, lack native hotplug support but can
still have their availability controlled through host policy. In all these
cases, a mechanism is needed to track and control a device’s *administrative*
power state — independent of its runtime operational state — so QEMU can:

  - Disable a device while keeping it described in firmware, ACPI, or other
    configuration.
  - Prevent guest use until explicitly re-enabled.
  - Coordinate transitions with platform-specific power handlers and migration
    logic.

This patch introduces the core qdev support for administrative power state —
defining the property, enum, and accessors — without yet applying it to any
device. Later patches in this series integrate it with helper APIs
(qdev_disable(), qdev_enable(), etc.) and specific device types such as CPUs,
completing the flow with platform-specific handlers.

Key additions:
  - New enum DeviceAdminPowerState with ENABLED, DISABLED, and REMOVED states,
    defaulting to ENABLED.
  - New DeviceClass flag admin_power_state_supported to advertise support for
    administrative transitions.
  - New QOM property "admin_power_state" to query or set the state on supported
    devices.
  - Internal accessors device_get_admin_power_state() and
    device_set_admin_power_state() to manage state changes, including safe
    handling when the device is not yet realized.

The enum models *policy* rather than electrical or functional power state, and
is distinct from runtime mechanisms (e.g. PSCI for ARM CPUs). The actual
operational state of a device is maintained by platform-specific or device-
specific code, which enforces runtime behaviour based on the administrative
setting. Every device starts administratively ENABLED by default. A DISABLED
device remains logically present but blocked from operation; a REMOVED device
is logically absent.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/core/qdev.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h | 54 ++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c       |  1 +
 3 files changed, 117 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f600226176..8502d6216f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -633,6 +633,53 @@ static bool device_get_hotplugged(Object *obj, Error **errp)
     return dev->hotplugged;
 }
 
+static int device_get_admin_power_state(Object *obj, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    return dev->admin_power_state;
+}
+
+static void
+device_set_admin_power_state(Object *obj, int new_state, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->admin_power_state_supported) {
+        error_setg(errp, "Device '%s' admin power state change not supported",
+                   object_get_typename(obj));
+        return;
+    }
+
+    switch (new_state) {
+    case DEVICE_ADMIN_POWER_STATE_DISABLED: {
+        /*
+         * TODO: Operational state transition triggered by administrative action
+         * Powering off the realized device either synchronously or via OSPM.
+         */
+
+        qatomic_set(&dev->admin_power_state, DEVICE_ADMIN_POWER_STATE_DISABLED);
+        smp_wmb();
+        break;
+    }
+    case DEVICE_ADMIN_POWER_STATE_ENABLED: {
+        /*
+         * TODO: Operational state transition triggered by administrative action
+         * Powering on the device and restoring migration registration.
+         */
+
+        qatomic_set(&dev->admin_power_state, DEVICE_ADMIN_POWER_STATE_ENABLED);
+        smp_wmb();
+        break;
+    }
+    default:
+        error_setg(errp, "Invalid admin power state %d for device '%s'",
+                   new_state, dev->id);
+        break;
+    }
+}
+
 static void device_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -644,6 +691,7 @@ static void device_initfn(Object *obj)
 
     dev->instance_id_alias = -1;
     dev->realized = false;
+    dev->admin_power_state = DEVICE_ADMIN_POWER_STATE_ENABLED;
     dev->allow_unplug_during_migration = false;
 
     QLIST_INIT(&dev->gpios);
@@ -731,6 +779,15 @@ device_vmstate_if_get_id(VMStateIf *obj)
     return qdev_get_dev_path(dev);
 }
 
+static const QEnumLookup device_admin_power_state_lookup = {
+    .array = (const char *const[]) {
+        [DEVICE_ADMIN_POWER_STATE_ENABLED]  = "enabled",
+        [DEVICE_ADMIN_POWER_STATE_REMOVED]  = "removed",
+        [DEVICE_ADMIN_POWER_STATE_DISABLED] = "disabled",
+    },
+    .size = DEVICE_ADMIN_POWER_STATE_MAX,
+};
+
 static void device_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -765,6 +822,11 @@ static void device_class_init(ObjectClass *class, const void *data)
                                    device_get_hotpluggable, NULL);
     object_class_property_add_bool(class, "hotplugged",
                                    device_get_hotplugged, NULL);
+    object_class_property_add_enum(class, "admin_power_state",
+                                   "DeviceAdminPowerState",
+                                   &device_admin_power_state_lookup,
+                                   device_get_admin_power_state,
+                                   device_set_admin_power_state);
     object_class_property_add_link(class, "parent_bus", TYPE_BUS,
                                    offsetof(DeviceState, parent_bus), NULL, 0);
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da702..3bc212ab3a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -159,6 +159,7 @@ struct DeviceClass {
      */
     bool user_creatable;
     bool hotpluggable;
+    bool admin_power_state_supported;
 
     /* callbacks */
     /**
@@ -217,6 +218,55 @@ typedef QLIST_HEAD(, NamedGPIOList) NamedGPIOListHead;
 typedef QLIST_HEAD(, NamedClockList) NamedClockListHead;
 typedef QLIST_HEAD(, BusState) BusStateHead;
 
+/**
+ * enum DeviceAdminPowerState - Administrative control states for a device
+ *
+ * This enum defines abstract administrative states used by QEMU to enable,
+ * disable, or logically remove a device from the virtual machine. These
+ * states reflect administrative control over a device's power availability
+ * and presence in the system. These administrative states are distinct from
+ * runtime operational power states (e.g., PSCI states for ARM CPUs). They
+ * represent administrative *policy* rather than physical, electrical, or
+ * functional state.
+ *
+ * Administrative state is managed externally "via QMP, firmware, or other
+ * host-side policy agents" and acts as a gating policy that determines
+ * whether guest software is permitted to interact with the device. Most
+ * devices default to the ENABLED state unless explicitly disabled or removed.
+ *
+ * Changing a device administrative state may directly or indirectly affect
+ * its operational behavior. For example, a DISABLED device will reject guest
+ * attempts to power it on or transition it out of a suspended state. Not all
+ * devices support dynamic transitions between administrative states.
+ *
+ * - DEVICE_ADMIN_POWER_STATE_ENABLED:
+ *     The device is administratively enabled (i.e., logically present and
+ *     permitted to operate). Guest software may change its operational state
+ *     (e.g., activate, deactivate, suspend) within allowed architectural
+ *     semantics. This is the default state for most devices unless explicitly
+ *     disabled or unplugged.
+ *
+ * - DEVICE_ADMIN_POWER_STATE_DISABLED:
+ *     The device is administratively disabled. It remains logically present
+ *     but is blocked from functional operation. Guest-initiated transitions
+ *     are either suppressed or ignored. This is typically used to enforce
+ *     shutdown, deny execution, or offline the device without removing it.
+ *
+ * - DEVICE_ADMIN_POWER_STATE_REMOVED:
+ *     The device has been logically removed (e.g., via hot-unplug). It is no
+ *     longer considered present or visible to the guest. This state exists
+ *     for representational or transitional purposes only. In most cases,
+ *     once removed, the corresponding DeviceState object is destroyed and
+ *     no longer tracked. This concept may not apply to some devices as
+ *     architectural limitations might make unplug not meaningful.
+ */
+typedef enum DeviceAdminPowerState {
+    DEVICE_ADMIN_POWER_STATE_ENABLED = 0,
+    DEVICE_ADMIN_POWER_STATE_DISABLED,
+    DEVICE_ADMIN_POWER_STATE_REMOVED,
+    DEVICE_ADMIN_POWER_STATE_MAX
+} DeviceAdminPowerState;
+
 /**
  * struct DeviceState - common device state, accessed with qdev helpers
  *
@@ -240,6 +290,10 @@ struct DeviceState {
      * @realized: has device been realized?
      */
     bool realized;
+    /**
+     * @admin_power_state: device administrative power state
+     */
+    DeviceAdminPowerState admin_power_state;
     /**
      * @pending_deleted_event: track pending deletion events during unplug
      */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..0c9a2e7ea4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2765,6 +2765,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_get_core_xml_file = arm_gdb_get_core_xml_file;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = arm_disas_set_info;
+    dc->admin_power_state_supported = true;
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &arm_tcg_ops;
-- 
2.34.1


