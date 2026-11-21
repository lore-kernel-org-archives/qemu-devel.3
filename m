Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CE606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0S6CLhSu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUryW-0004Sq-D1; Sat, 21 Nov 2026 15:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUryU-0004SX-Nw
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 15:46:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUryS-0005zm-E6
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 15:46:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so16592265e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795293975; x=1795898775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dR4oPwMzXZwkzKBHINmHc4eivvVzlJdhh6T4Ur7acMs=;
 b=0S6CLhSuHf5LkgYUFHyGqWOCsFsDytGC0F0MwcGTjcBeUNbsTCjftSuuL3MuQ3kqQL
 WkHrdHBCqzCzZXAn7wGIfeAPv0dDH3Owm9P1eWQ2VGRPJi2/nyUWBkEJY88X0FRkOH+R
 IaMSm6a5GKh2+rXVB9mjHnl48d3fWodF/+Q4m0VmsjHDw1x8AFYg+YRzanAUfVZWdQEH
 PbWXJeTbCPbmdSJ9FqJYhDJQ65q3ur8c/R7O2990/kw/rKTwt9Cudwf9m7n4pTYdaxU6
 /4HTLWDykqMMSAZOwxnwlqYG2OTby/sblgAZ8B3bXcMUw5jlx5ZUjOGsej6SqtkMPWNs
 Rs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795293975; x=1795898775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dR4oPwMzXZwkzKBHINmHc4eivvVzlJdhh6T4Ur7acMs=;
 b=xiJQd1ZY4lPkLoUXeD1wQRJaD+KBfwZg17jO412bL0F0GKg2IfwwyEXVjRjgdency2
 uVLa625+dza6aSRyAWskASFN7HgnYe85nMeg0fRbO+ZcJmVHs695I+vZeb2p4TiTmMPo
 eGqlDCeIjtyLrGmaoACBnqPRShp2GfeFySA8wL1UdeQu4tdh9v/GZRsTTSkBBKVrXQCy
 9+RCHDHDeOtbXuA6Fk2KkzHmJhKqoZfIs5O5F1uB0o/7CP9XR41i8NvFr6/W+zQA8Lm8
 A3i5UxXh9GdhcRcl3H7JmJs1KAqOsgHqPymylK5hjbep2FtcqK/N1bsqMtBp7oAy1lJ/
 QYIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEU+mTJ1Y2JYTxXcTbfXIg+uNTK170uKfS6H18NV6BjLaNojTeNP1rgWp/FrvyX3U916sNXkvz2ui0k@nongnu.org
X-Gm-Message-State: APuU4Z/ZoodCRZ6qNylCfbLfpZQLCBD3yy95yRidBdQRUkumLbXIhxbP
 G6ll5xDu6q3//R289AoapxHbV3djv8+R/I0FkKRAXE3CORwgziIjK/4l
X-Gm-Gg: AZFdTZejEGvr36qKvbT8RgM4phdlunhYhs/VKzCsZKvsmA8OdklgAME6V6yFJS0EhSQ
 dos93FIEEZATDYYFkenLL5/h5dk+JjunXT+uv6cjlOBnVn2lpJZnQSqMLavnjha8uxG33NY5lWY
 zjbGJ9KqoVBfPa1Mt8UvdfR+6+/5zI9ZtAPcYdJMUngzcdXOJntiOTOGXGkPmqropNi/ZsKNjOj
 3U3L2R8ikkIaAbIkqCjodQmpgbU+5dJ3djwrj3O/ZfJYOoETo1yjT54fqxgNjJipyBRFoUtLgd+
 TPTECG1RkiLIGbMGbCxQ7hh0hXuwTP/jv0WTPdWlhGWZ0a/fVSh8JDmZYmM/n7OAiFyfv5ayMbP
 bZLyEzNgpF8b1dlW5aqkwnVS2qsXIcrTzS4SzPkAKZ7boTTDVp/HuekZUUOhmHCyZ/M+s3es3Jz
 LUEaEp4C/PAJWiI84RzXmxpdEp+Tqa06XS0FmDfaE/ZD7vbZVuaIjbfX/7lG3dHkVK40eYKfR9v
 VvC9zrhKxV7mI3EEf87riHAK8BHEYcxLndHZCxaC3DP5ZNlOQk0kWpqPDziAcPrwuRO1YkLi2vG
 H8w5oq8RO7Zs05ftTRYiKve0qpUPKmff5y28V9DxyLf+h/wfN292DdHKX6ZpeWI8hjwU1bEiu9G
 D7AdnLewJNlegLn0UQtP+ulE=
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id
 5b1f17b1804b1-4bb888267f4mr158170395e9.29.1795293974532; 
 Sat, 21 Nov 2026 12:46:14 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 12:46:14 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v2 2/3] target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH
 select an nVHE EL2
Date: Sun, 22 Nov 2026 01:46:00 +0500
Message-ID: <20261121204601.741616-3-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

KVM runs a nested guest with a VHE-only EL2 (HCR_EL2.E2H RES1) unless
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at KVM_ARM_VCPU_INIT time.  With
that feature FEAT_VHE is hidden: ID_AA64MMFR1_EL1.VH reads 0 and
HCR_EL2.E2H is RES0.  Guest hypervisors which only support nVHE, such as
Xen, can only run in the latter mode.

Do not add a dedicated machine or CPU option for it.  Derive the vCPU
init feature from the ID register field selected by the user instead:
SYSREG_ID_AA64MMFR1_EL1_VH=0 requests KVM_ARM_VCPU_HAS_EL2_E2H0.

KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
"writable fields only" rule would not create the property.  Expose it
explicitly when the host supports KVM_CAP_ARM_EL2_E2H0.  As KVM already
reports the requested value after vCPU init, applying the property does
not need a KVM_SET_ONE_REG for this field, and the query-cpu-model-expansion
dry run on the scratch vCPU skips it.  Setting VH=0 without
virtualization=on is rejected.

Only ID_AA64MMFR1_EL1.VH is updated in QEMU's copy of the ID registers.
Other fields which KVM derives from E2H0 (e.g. ID_AA64MMFR4_EL1) are
not refreshed.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---

v2:
 - Use Eric Auger's SYSREG framework instead of a dedicated vhe
   machine/CPU property.
 - Expose the init-driven VH field only when KVM supports E2H0.
 - Add the virtualization=on consistency check and document VH=0.
 docs/system/arm/cpu-features.rst | 22 ++++++++++++++
 target/arm/cpu-idregs.h          | 31 +++++++++++++++++++
 target/arm/cpu64.c               | 51 +++++++++++++++++++++++++-------
 target/arm/kvm.c                 | 24 +++++++++++++--
 4 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 13454783cf..cde26c04b9 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -579,6 +579,28 @@ either not writable with the specific host kernel, unknown to this QEMU
 build, or intentionally not exposed because it overlaps a legacy composite
 option.
 
+Selecting an nVHE-only EL2
+--------------------------
+
+With ``-machine virt,virtualization=on``, KVM presents a VHE-only EL2 to
+the guest (``HCR_EL2.E2H`` is RES1) by default.  A guest hypervisor which
+only supports nVHE, such as a type-1 hypervisor like Xen, needs VHE to be
+hidden.  This is done by setting ``ID_AA64MMFR1_EL1.VH`` to 0::
+
+  $ qemu-system-aarch64 -M virt,virtualization=on -accel kvm \
+        -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0
+
+QEMU then requests ``KVM_ARM_VCPU_HAS_EL2_E2H0`` when initializing the
+vCPUs, so that ``HCR_EL2.E2H`` is RES0 for the guest.  Leaving the
+property unset, or setting it to 1, keeps the default VHE-only EL2.
+Setting it to 0 requires ``virtualization=on``.
+
+KVM does not allow userspace to write ``ID_AA64MMFR1_EL1.VH`` directly, so
+this is an exception to the rule that only writable fields get a
+property: the ``SYSREG_ID_AA64MMFR1_EL1_VH`` property is exposed when the
+host kernel supports ``KVM_CAP_ARM_EL2_E2H0``.  Without this support the
+property does not exist.
+
 A note on compatibility
 -----------------------
 
diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
index 465ec83c97..76d7b94858 100644
--- a/target/arm/cpu-idregs.h
+++ b/target/arm/cpu-idregs.h
@@ -73,4 +73,35 @@ int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysregPropApplyFn accel_apply_fn,
 bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
                                   uint64_t value, Error **errp);
 
+/**
+ * arm_cpu_sysreg_prop_get:
+ *
+ * Look up the value the user set through a SYSREG_<IDREG>_<FIELD>
+ * property, before it is applied to the vcpu.  Accelerators use it to
+ * derive vcpu init settings from the requested ID register values.
+ *
+ * @cpu: vcpu the property belongs to
+ * @reg_idx: ID register index (<REG>_EL1_IDX)
+ * @shift: lowest bit of the field
+ * @value: set to the requested field value when the property was set
+ *
+ * returns true if the property was set by the user
+ */
+bool arm_cpu_sysreg_prop_get(ARMCPU *cpu, int reg_idx, int shift,
+                             uint64_t *value);
+
+/**
+ * arm_cpu_sysreg_field_init_driven:
+ *
+ * Some fields cannot be written with the accelerator once the vcpu exists
+ * but are selected through a vcpu init feature instead (for instance
+ * ID_AA64MMFR1_EL1.VH with KVM_ARM_VCPU_HAS_EL2_E2H0).  Their SYSREG
+ * property is exposed even if the field is not writable.
+ *
+ * @field: ID register field
+ *
+ * returns true if @field is selected at vcpu init time on this host
+ */
+bool arm_cpu_sysreg_field_init_driven(ARM64SysRegField *field);
+
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c08eba7010..1fc3a4bb7c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -835,6 +835,21 @@ static ARM64SysRegField *arm_sysreg_get_field(ARM64SysReg *reg, int bit)
     return NULL;
 }
 
+bool arm_cpu_sysreg_prop_get(ARMCPU *cpu, int reg_idx, int shift,
+                             uint64_t *value)
+{
+    gpointer value_ptr;
+    uint64_t key = IDREG_FIELD_KEY(reg_idx, shift);
+
+    if (!g_hash_table_lookup_extended(cpu->sysreg_props,
+                                      GUINT_TO_POINTER(key), NULL,
+                                      &value_ptr)) {
+        return false;
+    }
+    *value = GPOINTER_TO_UINT(value_ptr);
+    return true;
+}
+
 /**
  * arm_cpu_validate_sysreg_prop:
  *
@@ -879,6 +894,13 @@ bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
             error_setg(errp, "%s is non null whereas pmu is unset", propname);
             return false;
         }
+    /* nVHE-only EL2, selected at vcpu init time */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64MMFR1_EL1_VH")) {
+        if (value == 0 && !cpu->has_el2) {
+            error_setg(errp, "%s=0 requires -machine virtualization=on",
+                       propname);
+            return false;
+        }
     /* aarch64=off */
     } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
@@ -988,17 +1010,9 @@ static void get_sysreg_prop(Object *obj, Visitor *v,
     int index = field->index;
     int lower = field->shift;
     int length = field->length;
-    gpointer value_ptr;
     uint64_t value;
-    uint64_t key = IDREG_FIELD_KEY(index, lower);
-    gboolean exists;
-
-    exists = g_hash_table_lookup_extended(cpu->sysreg_props,
-                                          GUINT_TO_POINTER(key), NULL,
-                                          &value_ptr);
-    if (exists) {
-        value = GPOINTER_TO_UINT(value_ptr);
-    } else {
+
+    if (!arm_cpu_sysreg_prop_get(cpu, index, lower, &value)) {
         uint64_t mask = MAKE_64BIT_MASK(lower, length);
         uint64_t *idregs = cpu->isar.idregs;
 
@@ -1028,6 +1042,20 @@ static const char * const aarch64_sysreg_prop_skip_list[] = {
     "SYSREG_ID_AA64ISAR2_EL1_GPA3",
 };
 
+/*
+ * Fields which KVM does not let userspace write with KVM_SET_ONE_REG,
+ * but which QEMU can still select through a vcpu init feature, see
+ * kvm_arm_vcpu_prepare_init_features().  ID_AA64MMFR1_EL1.VH is hidden
+ * by KVM_ARM_VCPU_HAS_EL2_E2H0, which requests an nVHE-only EL2.
+ */
+bool arm_cpu_sysreg_field_init_driven(ARM64SysRegField *field)
+{
+    /* Compare the field first: this runs for every ID register field */
+    return field->index == ID_AA64MMFR1_EL1_IDX &&
+           field->shift == R_ID_AA64MMFR1_VH_SHIFT &&
+           kvm_enabled() && kvm_arm_el2_e2h0_supported();
+}
+
 static bool aarch64_sysreg_prop_skipped(const char *prop_name)
 {
     for (int i = 0; i < ARRAY_SIZE(aarch64_sysreg_prop_skip_list); i++) {
@@ -1084,7 +1112,8 @@ aarch64_add_one_idreg_properties(Object *obj, ARM64SysReg *reg,
         }
         map = map & ~field_mask;
 
-        if (writable_only && !field_writable_mask) {
+        if (writable_only && !field_writable_mask &&
+            !arm_cpu_sysreg_field_init_driven(field)) {
             continue;
         }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8ef5597c68..bb4ca7e8d1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1324,9 +1324,15 @@ bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
         return false;
     }
 
-    ret = kvm_arm_override_idreg_field(cpufd, field, newfv, errp);
-    if (ret) {
-        return false;
+    /*
+     * Init-driven fields (e.g. VH) are selected through a vcpu init
+     * feature, which the scratch vcpu may not have: do not write them.
+     */
+    if (!arm_cpu_sysreg_field_init_driven(field)) {
+        ret = kvm_arm_override_idreg_field(cpufd, field, newfv, errp);
+        if (ret) {
+            return false;
+        }
     }
 
     cpu->isar.idregs[field->index] =
@@ -2239,7 +2245,19 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
                                       1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
     if (cpu->has_el2 && kvm_arm_el2_supported()) {
+        uint64_t vh;
+
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
+        /*
+         * KVM exposes a VHE-only EL2 by default.  An nVHE-only EL2 can
+         * only be selected at vcpu init time, so derive it from the
+         * requested ID_AA64MMFR1_EL1.VH value.
+         */
+        if (arm_cpu_sysreg_prop_get(cpu, ID_AA64MMFR1_EL1_IDX,
+                                    R_ID_AA64MMFR1_VH_SHIFT, &vh) &&
+            vh == 0) {
+            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2_E2H0;
+        }
     }
 }
 
-- 
2.34.1


