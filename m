Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F0606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Oeo1pMo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWS1q-0004FL-P1; Thu, 26 Nov 2026 00:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1d-0004Dw-Gn
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:28:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1Y-0001mo-09
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:28:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so58144605e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 21:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795670878; x=1796275678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CgF2Rl6OlcCIxvB5hOpq+nzQLcAAoXIy0ayd2QHpKA8=;
 b=0Oeo1pMoXF+PgeLiERp3zfcQwM3PHkO+Yqnakz/ISaMKRVwFcTd/a3q38I8GUUydhd
 rUTLBNbqdZmxrHQXiP0nVPVqro+QXcxUQeHtqP0j3lIpd/mW1HUM8BblcKWhPGtNhiQq
 jT9RUi2W3novSvvTVEDwotX8GcXGopU/XtfYTpYr3v5bgCtnEZn2V8UtLvTaLq/y0pj/
 2NU9AjVkbqViyd3MGKi0Q8R+TFR0rgufiS4nWOWicr2ePSvLf9ymCEoRWsEnNtalzVEe
 lfLN5xQaEt+fuUnIlg3rjO31leB3woIjQ0ul2GoZvKtO1YOcjLEkQ/7AMaq06/K+tLIY
 S6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795670878; x=1796275678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CgF2Rl6OlcCIxvB5hOpq+nzQLcAAoXIy0ayd2QHpKA8=;
 b=mrrlfLgMHt4e019MeRxA5kxeBPYDYDv3C9NOQvI8Q6mHPSD8efiIzuneQNLPXqdOok
 G+FpGiIzHNekGNVfV3R32lPFQtPqgdP6zDAKRrcIAjzLJsdMuFgTlIzNsv4AG+E47XcT
 6kZPy+Atho3DPDaO9h2EB5qcIbU6pYhZW0l0hvmevgxvIQyNXc5jggAygb0zYYWxt5oq
 8il8RrJo98TcP1tpDJ7AQXCKlyQNHb+POkV/rRQqYvZcaJ1tDOdwfIjqn2agWZBck+iq
 1wNrs2K7hQBoM34f+00D9duvdR5sEruA5rLOfNzTHJ3VDBkPyy7kCsh9AsS1Y/7jXJ8G
 5Jtg==
X-Forwarded-Encrypted: i=1;
 AL+hErGSi343g/uKZU+BBVAhvjxzyg4wKTAHaLko1uyBakMc9Wbb9IAY8VbygeySyvGK5Xx7MzSryc8vIu+z@nongnu.org
X-Gm-Message-State: APuU4Z+muY1dRxCu2Q4IFHKE+XdX3FzTnkbLT7FWQ3y/yNx9FZgBN8g4
 FiGjFf1ZDvC04q5ulUxB5qF2JnYpDrbWTjLor+3JW+LpAvMbW8H1qlOj
X-Gm-Gg: AZFdTZd3H7wADcyAeF93OZwnmo5wsNtZNigTsb9jEueKZV7YUbGS/YausHCC/O+pBy7
 9SE9KByuMXq8/k3yDwdiojNBU+HXpRHnjbAJ/PwcSR3wh3HYIwiNHovoZ5gN0zZOMDm8jDndSmE
 U52d7Mcp0eNvwFJ6DmfxzA2nOjbC5xwHqxRDy0owgFPHBv1NjtBwLmEboNHGZKiiUjCn290yzEt
 iCu+mA6ZBiMFHrVlFqMhF7UM+qKeAMiWBwxsLrNODsQJ+N6CgdvA7GYqNq+E2Y2AzZRUBS4ZPJE
 unc2Eqnf8pvwqIW/rGsD3HK5mPTWibVE17PGDnh0lYdu15zYdmiH9lOyLsGBYKYprnngnZEsFL9
 4H7B5fex9t095q5NfK/ld9OjFbasMuREAlg1SumUQjP1Ir2Yg/jF7swTb5EIfIYKujl37kDrdgO
 6Z9nbkj10M7StdTVERkQ4veG5IWXQxO9lAmlxWRu21NdGjRHYROWrB0NWe1oGRdV/u7n9EjZ+Gc
 txZsQY6UWyIJbiUQx+AlhQkHF2+WtT6skO3y3c8hkeWurmfvmBMC8MOSBdRc7A2upiTBk+WgZ0Q
 SS4dFMXzc+HdmDpXaZ/3lgQI2vDksEIAPfZZvzOdzrxfHzJam7WQ5hOqiwQy1a2G93Ody5Bl0Ha
 mT8MwLjwrCU3yHeEtpqnTb/+i
X-Received: by 2002:a05:600c:a11:b0:4bb:69f2:87f7 with SMTP id
 5b1f17b1804b1-4bb88812c92mr415783615e9.18.1795670877935; 
 Wed, 25 Nov 2026 21:27:57 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 21:27:57 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>,
 Khushit Shah <khushit.shah@nutanix.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v3 2/3] target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH
 select an nVHE EL2
Date: Thu, 26 Nov 2026 10:27:40 +0500
Message-ID: <20261126052741.90607-3-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

KVM runs a nested guest with a VHE-only EL2 (HCR_EL2.E2H RES1) unless
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at KVM_ARM_VCPU_INIT time. With
that feature FEAT_VHE is hidden: ID_AA64MMFR1_EL1.VH reads 0 and
HCR_EL2.E2H is RES0. Guest hypervisors which only support nVHE, such as
Xen, can only run in the latter mode.

Do not add a dedicated machine or CPU option for it.  Derive the vCPU
init feature from the ID register field selected by the user instead:
SYSREG_ID_AA64MMFR1_EL1_VH=0 requests KVM_ARM_VCPU_HAS_EL2_E2H0.

KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
"writable fields only" rule would not create the property. Expose it
explicitly when the host supports KVM_CAP_ARM_EL2_E2H0. Apply this
init-driven property before creating the scratch vCPU and use it when
initializing real vCPUs. Setting VH=0 without virtualization=on is
rejected.

KVM derives other ID register fields from the selected init mode. Re-read
ID_AA64MMFR1_EL1 and ID_AA64MMFR4_EL1 after vCPU initialization so QEMU's
cached CPU model and query-cpu-model-expansion agree with the values the
guest sees.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---

v3:
 - Apply init-driven properties before creating the scratch vCPU.
 - Refresh MMFR1 and MMFR4 from KVM after vCPU initialization.
 docs/system/arm/cpu-features.rst | 22 ++++++++++++
 target/arm/arm-qmp-cmds.c        | 38 +++++++++++++++++++++
 target/arm/cpu-idregs.h          | 31 +++++++++++++++++
 target/arm/cpu64.c               | 51 ++++++++++++++++++++++------
 target/arm/kvm-stub.c            |  5 +++
 target/arm/kvm.c                 | 58 ++++++++++++++++++++++++++++++--
 target/arm/kvm_arm.h             |  8 +++++
 7 files changed, 199 insertions(+), 14 deletions(-)

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
+hidden. This is done by setting ``ID_AA64MMFR1_EL1.VH`` to 0::
+
+  $ qemu-system-aarch64 -M virt,virtualization=on -accel kvm \
+        -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0
+
+QEMU then requests ``KVM_ARM_VCPU_HAS_EL2_E2H0`` when initializing the
+vCPUs, so that ``HCR_EL2.E2H`` is RES0 for the guest. Leaving the
+property unset, or setting it to 1, keeps the default VHE-only EL2.
+Setting it to 0 requires ``virtualization=on``.
+
+KVM does not allow userspace to write ``ID_AA64MMFR1_EL1.VH`` directly, so
+this is an exception to the rule that only writable fields get a
+property: the ``SYSREG_ID_AA64MMFR1_EL1_VH`` property is exposed when the
+host kernel supports ``KVM_CAP_ARM_EL2_E2H0``. Without this support the
+property does not exist.
+
 A note on compatibility
 -----------------------
 
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9a0258a3d6..b8e6c212a8 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -98,6 +98,7 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
     Visitor *visitor = NULL;
     Error *err = NULL;
     bool scratch_created = false;
+    bool e2h0_requested = false;
     const char *name;
     int fdarray[3];
     int fd = -1;
@@ -173,6 +174,38 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
             goto bail_out;
         }
 
+        /*
+         * Init-driven SYSREG properties must be visible while the scratch
+         * vCPU is initialized, not only when the remaining properties are
+         * applied below.
+         */
+        for (const QDictEntry *entry = qdict_first(qdict_in);
+                 entry != NULL; entry = qdict_next(qdict_in, entry)) {
+            const char *key = qdict_entry_key(entry);
+            QObject *val_obj = qdict_entry_value(entry);
+            Visitor *v;
+            uint64_t value;
+
+            if (!strcmp(key, "SYSREG_ID_AA64MMFR1_EL1_VH")) {
+                v = qobject_input_visitor_new(val_obj);
+                if (!visit_type_uint64(v, key, &value, errp)) {
+                    visit_free(v);
+                    goto bail_out;
+                }
+                visit_free(v);
+                e2h0_requested = value == 0;
+            } else {
+                continue;
+            }
+
+            v = qobject_input_visitor_new(val_obj);
+            if (!object_property_set(obj, key, v, errp)) {
+                visit_free(v);
+                goto bail_out;
+            }
+            visit_free(v);
+        }
+
         /**
          * Test SYSREG option settings
          * In full mode, build a scratch vcpu that reflects composite legacy
@@ -237,6 +270,11 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
             visit_free(v);
         }
 
+        if (scratch_created && e2h0_requested &&
+            kvm_arm_refresh_e2h0_idregs(ARM_CPU(obj), fd, errp)) {
+            goto bail_out;
+        }
+
         visit_check_struct(visitor, &err);
         if (err) {
             goto bail_out;
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
 
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88e35909c4..75e82887d6 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -47,6 +47,11 @@ bool kvm_arm_el2_e2h0_supported(void)
     return false;
 }
 
+int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp)
+{
+    return 0;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8ef5597c68..2a72f52c44 100644
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
@@ -2183,6 +2189,30 @@ bool kvm_arm_el2_e2h0_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
 }
 
+int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp)
+{
+    static const ARMIDRegisterIdx indices[] = {
+        ID_AA64MMFR1_EL1_IDX,
+        ID_AA64MMFR4_EL1_IDX,
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(indices); i++) {
+        ARMIDRegisterIdx index = indices[i];
+        int ret;
+
+        ret = read_sys_reg64(fd, &cpu->isar.idregs[index],
+                             idregs_sysreg_to_kvm_reg(
+                                 id_register_sysreg[index]));
+        if (ret) {
+            error_setg(errp, "failed to refresh %s after vCPU init",
+                       arm64_id_regs[index].name);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
@@ -2239,7 +2269,19 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
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
 
@@ -2286,6 +2328,16 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
         return ret;
     }
 
+    uint64_t vh;
+    if (arm_cpu_sysreg_prop_get(cpu, ID_AA64MMFR1_EL1_IDX,
+                                R_ID_AA64MMFR1_VH_SHIFT, &vh) &&
+        vh == 0) {
+        ret = kvm_arm_refresh_e2h0_idregs(cpu, CPU(cpu)->kvm_fd, errp);
+        if (ret) {
+            return ret;
+        }
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 0916a5fdb4..670b410a1a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -208,6 +208,8 @@ bool kvm_arm_el2_supported(void);
  * KVM_ARM_VCPU_HAS_EL2_E2H0, and false otherwise.
  */
 bool kvm_arm_el2_e2h0_supported(void);
+
+int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -229,6 +231,12 @@ static inline bool kvm_arm_el2_e2h0_supported(void)
 {
     return false;
 }
+
+static inline int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd,
+                                              Error **errp)
+{
+    return 0;
+}
 #endif
 
 /**
-- 
2.34.1


