Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198EEEB7EB5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiHg-00012u-Sk; Wed, 04 Mar 2026 04:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHa-00010o-EH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHX-0000Ie-Ap
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso58338165e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772615556; x=1773220356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aa7YS8YRAQ8yRhQF9Whg1Qcoxr3p3yRf12L+u0hXtWc=;
 b=V8sOSHHoGkICQW31sdmwjyIlSkdMZpg6GaA/89QAEwu7jmvG70eO9o39U7tlMQIBws
 3ki00JeRkVo/IF1e1RfOs3bLHUn/5u4i0CfNewbA9vxRiA5EqOzDyezdSM2aBLv3FOsm
 4B5LyD+PNJlmVH47s0sl5wND8g/yxIRY2GiWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772615556; x=1773220356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aa7YS8YRAQ8yRhQF9Whg1Qcoxr3p3yRf12L+u0hXtWc=;
 b=XJAIHtGDzDcYymvNcDvor/RwL5nbwFKZ9QLxEv1DWsADxWRebUxOqDylWegTqC0bqY
 0rVCKPfKUsYm8IqPxZv3MpznNldijEcxfpNUvqumfJiBx4QGR7vGog2XzU9w/mPnJIvL
 S4AbAnW2kfIouyrWQYrqpmhJg9/dnXDB5Nvmiy1oRl1q8Qy13T4B/oIutkC8xSpsVMCU
 UbahtcXzVGBwN7SJ3y5bLnoWi8XO+pIyu3UgNig7S4kkPFd2i3o00X+11JBuquL7Q+NZ
 XjqQZ+6DNOUmdqmzfbt5CDMka78CfTJRSXOm7rRnR5vFgpIV3sFsGw3yRVyeZMtFE8XO
 W8kg==
X-Gm-Message-State: AOJu0Yxjkqc/KYOv3dwMRFwBH9qX9RTRpXwD9SEiqbMQhaK50IK/GwoS
 APdZzod2f8FTXB51EM6nPsoFCJnfEroKJhjXceAXlfN0YNvtirWtHbIhs1Z5sizWgYjCYjh8kKi
 Xw1gYJ1k=
X-Gm-Gg: ATEYQzwL/rqvD2LsPTdUhPc6N29iSzuFIIssV6pwLJ9a/U1zQCrAkcB+yimhW6Px0Qy
 855flS2D/EnzXncud49CUiG5hv9spjcN3rIgL8PBmUtPmXYeTnM98tXj2OLZjEivo62y+2jRFLR
 QFo2ITcSTSi8FfyZ3CQM7jWZIn22IJtyjIGYnWNa8xumAsIztj3HzfG+74fXhPtiWF91py0j9Mi
 4sXne+EAgL58wz5PF8q305TyTU8ww1wlitimeGHz7f4zG3sZFH84qAH7CiQUugjEg5VPKO4Jeqz
 ulZvTm/bqoHlS+6JBzuWvkJ3+exFMGvA3PqHYZwUZsAG0ZxzTemvW0dEAx8kVDq+3BARIQubpON
 D858j17OPdRZDPJmflgSenb8s8mH0wyTLbjgLLUeykZGkFzSi+r69t/RIm1JaTloHebePgqXyqB
 CyRYZ+xNk/MHCMsNQESaZK1R4HHMQg095wDyvR5urHN0NbY/hTPgRBP6/TlbzstxD019BLJ/tg7
 feVhGf3oxq0ibpEnKfQS2I=
X-Received: by 2002:a05:600c:4e0f:b0:483:8f0f:36fe with SMTP id
 5b1f17b1804b1-48519837c8cmr20689175e9.1.1772615555873; 
 Wed, 04 Mar 2026 01:12:35 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00bac66d1b6d99e025.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:bac6:6d1b:6d99:e025])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c4489279sm9674234f8f.20.2026.03.04.01.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:12:35 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 3/4] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Date: Wed,  4 Mar 2026 10:12:28 +0100
Message-ID: <20260304091229.80725-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304091229.80725-1-alexander@mihalicyn.com>
References: <20260304091229.80725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x334.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC, which
helps to save/restore a dynamic array of pointers to
structures.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
v2:
- added VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC
---
 include/migration/vmstate.h | 33 ++++++++++++++
 migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20a..0bbe3317740 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_ptrs_array_entry;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -537,6 +538,38 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+/*
+ * For migrating a dynamically allocated uint32-indexed array
+ * of pointers to structures (with NULL entries and with auto memory allocation).
+ *
+ * _type: type of structure pointed to
+ * _vmsd: VMSD for structure
+ * start: size of structure pointed to (for auto memory allocation)
+ */
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .info       = &vmstate_info_ptrs_array_entry,                     \
+    .vmsd       = &(_vmsd),                                           \
+    .start      = sizeof(_type),                                      \
+    .size       = sizeof(_type *),                                    \
+    .flags      = VMS_VARRAY_UINT8|VMS_POINTER,                      \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .info       = &vmstate_info_ptrs_array_entry,                     \
+    .vmsd       = &(_vmsd),                                           \
+    .start      = sizeof(_type),                                      \
+    .size       = sizeof(_type *),                                    \
+    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                      \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
 #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb2114721..3335377cd07 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -942,3 +942,91 @@ const VMStateInfo vmstate_info_qlist = {
     .get  = get_qlist,
     .put  = put_qlist,
 };
+
+static int put_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
+                                const VMStateField *field, JSONWriter *vmdesc)
+{
+    const VMStateDescription *vmsd = field->vmsd;
+    int ret;
+    Error *local_err = NULL;
+    void *pv;
+
+    /*
+     * (ppv) is an address of an i-th element of a dynamic array.
+     *
+     * (ppv) can not be NULL unless we have some regression/bug in
+     * vmstate_save_state_v(), because it is result of pointer arithemic like:
+     * first_elem + size * i.
+     */
+    if (ppv == NULL) {
+        error_report("vmstate: put_ptrs_array_entry must be called with ppv != NULL");
+        return -EINVAL;
+    }
+
+    /* get a pointer to a structure */
+    pv = *(void **)ppv;
+
+    if (pv == NULL) {
+        /* write a mark telling that there was a NULL pointer */
+        qemu_put_byte(f, false);
+        return 0;
+    }
+
+    /* if pointer is not NULL, dump the structure contents with help of vmsd */
+    qemu_put_byte(f, true);
+    ret = vmstate_save_state(f, vmsd, pv, vmdesc, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    return 0;
+}
+
+static int get_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
+                                const VMStateField *field)
+{
+    int ret = 0;
+    Error *local_err = NULL;
+    const VMStateDescription *vmsd = field->vmsd;
+    /* size of structure pointed to by elements of array */
+    size_t size = field->start;
+
+    if (ppv == NULL) {
+        error_report("vmstate: get_ptrs_array_entry must be called with ppv != NULL");
+        return -EINVAL;
+    }
+
+    /*
+     * We start from a clean array, all elements must be NULL, unless
+     * something we haven't prepared for has changed in vmstate_save_state_v().
+     * Let's check for this just in case.
+     */
+    if (*(void **)ppv != NULL) {
+        error_report("vmstate: get_ptrs_array_entry must be called with *ppv == NULL");
+        return -EINVAL;
+    }
+
+    if (qemu_get_byte(f)) {
+        void *pv;
+
+        /* allocate memory for structure */
+        pv = g_malloc0(size);
+        ret = vmstate_load_state(f, vmsd, pv, vmsd->version_id, &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            g_free(pv);
+            return ret;
+        }
+
+        *(void **)ppv = pv;
+    }
+
+    return ret;
+}
+
+const VMStateInfo vmstate_info_ptrs_array_entry = {
+    .name = "ptrs_array_entry",
+    .get  = get_ptrs_array_entry,
+    .put  = put_ptrs_array_entry,
+};
-- 
2.47.3


