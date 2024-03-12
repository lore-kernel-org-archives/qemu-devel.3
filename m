Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515D2C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Y1-0006bE-Jf; Tue, 12 Mar 2024 13:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5VT-0007kn-OL; Tue, 12 Mar 2024 13:01:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5VR-000093-4z; Tue, 12 Mar 2024 13:01:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so614417b3a.2; 
 Tue, 12 Mar 2024 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262895; x=1710867695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2gX2wZRZwnsfISaLROX6zVjfiOGenKvEwzj5dh2eCo=;
 b=IDqBT2ERwKIAb1qhUpBEeWed+pwarjp4WrSjCegxYcpP3pL0A/s2bhZ3DqHBo4K+ZQ
 105s2WNmz0xV9x7JhEE0JMKIQUWdKAO43dCerenaT1usfrAcVdjYqCAcX8FgdFf7vDSY
 BmJ7wStDyg0Q6I2V5H7JTsyXpbI2GSEIzVl2cQ2yCNB7ycGZQmHEQAgYClaaftiKaZLE
 h3siMA6rSjhKeWTJHVJIopG0Vl2bPALzxd31/oYKtXTlrVecBn+tjz7No5y3QzbJo+uJ
 t2zNVMKHKHCKop9xf0w5GxLNyoURhUOXin9Aggv3ioE7ZO9hx4frR0kKazmsOSMjN2dB
 QnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262895; x=1710867695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2gX2wZRZwnsfISaLROX6zVjfiOGenKvEwzj5dh2eCo=;
 b=OY7ibA7s3yCw8nSkAXuekRDUilWQTKG3f235/kuNRSP3eB3ax3Q4yo6Nl7QPti00iQ
 UEqh2J2inrGFM2HLjdFxlQ1tarIR0cxT5zsfenE4mD/CWL2/KG/xAmRmnnpdDp8PZPRG
 Os3QD2DxY2Mi29jumWLWPhzga1PiaOxw9yVHCalxh7TjIDIwLtkp1Jk4kdoRX9SLtzuq
 ZpGlre/zjTUIwObwvJNnGxUB/s6UG9PZBD7C5ddGDHNZChd0HNKSIpI7DymR4pAAMwej
 k85VYNXJcJnfviKKepbI2FnnwGsz83C0SUpQfIYtDFi9F7WTclueYnAblKjGtxU83uHW
 F+CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSnm85EMZLv4cTKN6qrWvuGc2k8IHGFbmnF7TrV8HJSHoMKQ8pShsWO6gxPPCdqH19ZVQbtgob4PVOXoT3yurtEoDs
X-Gm-Message-State: AOJu0YyfXyIieKD0thaSqdz0nLbZ0y2cwLSZ2vVwUjAR/9KCFreS25/S
 B54zS77YzSj2L6XWRRt7Dyq31N8aBDUDccKI62johSzfasUsqskk2Rudnmfy+bE=
X-Google-Smtp-Source: AGHT+IHgAGttvZRLLgvbVASjEVI0G0brtsy9gYPZLrdZvf/T39w3blETB2na+fKfKugV5EKYJavUpA==
X-Received: by 2002:a05:6a00:1a89:b0:6e6:2af9:7553 with SMTP id
 e9-20020a056a001a8900b006e62af97553mr42798pfv.5.1710262894981; 
 Tue, 12 Mar 2024 10:01:34 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:01:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 35/38] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
Date: Wed, 13 Mar 2024 02:58:46 +1000
Message-ID: <20240312165851.2240242-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Introduce the nested PAPR hcalls:
    - H_GUEST_GET_STATE which is used to get state of a nested guest or
      a guest VCPU. The value field for each element in the request is
      destination to be updated to reflect current state on success.
    - H_GUEST_SET_STATE which is used to modify the state of a guest or
      a guest VCPU. On success, guest (or its VCPU) state shall be
      updated as per the value field for the requested element(s).

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 268 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   3 +
 include/hw/ppc/spapr_nested.h |  23 +++
 3 files changed, 294 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index cd7fa90350..cea282926f 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1029,6 +1029,140 @@ void spapr_nested_gsb_init(void)
     }
 }
 
+static struct guest_state_element *guest_state_element_next(
+    struct guest_state_element *element,
+    int64_t *len,
+    int64_t *num_elements)
+{
+    uint16_t size;
+
+    /* size is of element->value[] only. Not whole guest_state_element */
+    size = be16_to_cpu(element->size);
+
+    if (len) {
+        *len -= size + offsetof(struct guest_state_element, value);
+    }
+
+    if (num_elements) {
+        *num_elements -= 1;
+    }
+
+    return (struct guest_state_element *)(element->value + size);
+}
+
+static
+struct guest_state_element_type *guest_state_element_type_find(uint16_t id)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(guest_state_element_types); i++)
+        if (id == guest_state_element_types[i].id) {
+            return &guest_state_element_types[i];
+        }
+
+    return NULL;
+}
+
+static void log_element(struct guest_state_element *element,
+                        struct guest_state_request *gsr)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "h_guest_%s_state id:0x%04x size:0x%04x",
+                  gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get",
+                  be16_to_cpu(element->id), be16_to_cpu(element->size));
+    qemu_log_mask(LOG_GUEST_ERROR, "buf:0x%016"PRIx64" ...\n",
+                  be64_to_cpu(*(uint64_t *)element->value));
+}
+
+static bool guest_state_request_check(struct guest_state_request *gsr)
+{
+    int64_t num_elements, len = gsr->len;
+    struct guest_state_buffer *gsb = gsr->gsb;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    uint16_t id, size;
+
+    /* gsb->num_elements = 0 == 32 bits long */
+    assert(len >= 4);
+
+    num_elements = be32_to_cpu(gsb->num_elements);
+    element = gsb->elements;
+    len -= sizeof(gsb->num_elements);
+
+    /* Walk the buffer to validate the length */
+    while (num_elements) {
+
+        id = be16_to_cpu(element->id);
+        size = be16_to_cpu(element->size);
+
+        if (false) {
+            log_element(element, gsr);
+        }
+        /* buffer size too small */
+        if (len < 0) {
+            return false;
+        }
+
+        type = guest_state_element_type_find(id);
+        if (!type) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Element ID %04x unknown\n", id);
+            log_element(element, gsr);
+            return false;
+        }
+
+        if (id == GSB_HV_VCPU_IGNORED_ID) {
+            goto next_element;
+        }
+
+        if (size != type->size) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Size mismatch. Element ID:%04x."
+                          "Size Exp:%i Got:%i\n", id, type->size, size);
+            log_element(element, gsr);
+            return false;
+        }
+
+        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
+            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Trying to set a read-only Element "
+                          "ID:%04x.\n", id);
+            return false;
+        }
+
+        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
+            /* guest wide element type */
+            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        } else {
+            /* thread wide element type */
+            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        }
+next_element:
+        element = guest_state_element_next(element, &len, &num_elements);
+
+    }
+    return true;
+}
+
+static bool is_gsr_invalid(struct guest_state_request *gsr,
+                                   struct guest_state_element *element,
+                                   struct guest_state_element_type *type)
+{
+    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
+        (*(uint64_t *)(element->value) & ~(type->mask))) {
+        log_element(element, gsr);
+        qemu_log_mask(LOG_GUEST_ERROR, "L1 can't set reserved bits "
+                      "(allowed mask: 0x%08"PRIx64")\n", type->mask);
+        return true;
+    }
+    return false;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -1264,6 +1398,136 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
+                                 uint64_t vcpuid,
+                                 struct guest_state_request *gsr)
+{
+    void *ptr;
+    uint16_t id;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    int64_t lenleft, num_elements;
+
+    lenleft = gsr->len;
+
+    if (!guest_state_request_check(gsr)) {
+        return H_P3;
+    }
+
+    num_elements = be32_to_cpu(gsr->gsb->num_elements);
+    element = gsr->gsb->elements;
+    /* Process the elements */
+    while (num_elements) {
+        type = NULL;
+        /* log_element(element, gsr); */
+
+        id = be16_to_cpu(element->id);
+        if (id == GSB_HV_VCPU_IGNORED_ID) {
+            goto next_element;
+        }
+
+        type = guest_state_element_type_find(id);
+        assert(type);
+
+        /* Get pointer to guest data to get/set */
+        if (type->location && type->copy) {
+            ptr = type->location(guest, vcpuid);
+            assert(ptr);
+            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
+                return H_INVALID_ELEMENT_VALUE;
+            }
+            type->copy(ptr + type->offset, element->value,
+                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : false);
+        }
+
+next_element:
+        element = guest_state_element_next(element, &lenleft, &num_elements);
+    }
+
+    return H_SUCCESS;
+}
+
+static target_ulong map_and_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineStateNestedGuest *guest,
+                                         uint64_t vcpuid,
+                                         struct guest_state_request *gsr)
+{
+    target_ulong rc;
+    int64_t len;
+    bool is_write;
+
+    len = gsr->len;
+    /* only get_state would require write access to the provided buffer */
+    is_write = (gsr->flags & GUEST_STATE_REQUEST_SET) ? false : true;
+    gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
+                                 is_write, MEMTXATTRS_UNSPECIFIED);
+    if (!gsr->gsb) {
+        rc = H_P3;
+        goto out1;
+    }
+
+    if (len != gsr->len) {
+        rc = H_P3;
+        goto out1;
+    }
+
+    rc = getset_state(guest, vcpuid, gsr);
+
+out1:
+    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
+    return rc;
+}
+
+static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
+                                         target_ulong *args,
+                                         bool set)
+{
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    target_ulong vcpuid = args[2];
+    target_ulong buf = args[3];
+    target_ulong buflen = args[4];
+    struct guest_state_request gsr;
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return H_P2;
+    }
+    gsr.buf = buf;
+    assert(buflen <= GSB_MAX_BUF_SIZE);
+    gsr.len = buflen;
+    gsr.flags = 0;
+    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
+    }
+    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+        return H_PARAMETER; /* flag not supported yet */
+    }
+
+    if (set) {
+        gsr.flags |= GUEST_STATE_REQUEST_SET;
+    }
+    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
+}
+
+static target_ulong h_guest_set_state(PowerPCCPU *cpu,
+                                      SpaprMachineState *spapr,
+                                      target_ulong opcode,
+                                      target_ulong *args)
+{
+    return h_guest_getset_state(cpu, spapr, args, true);
+}
+
+static target_ulong h_guest_get_state(PowerPCCPU *cpu,
+                                      SpaprMachineState *spapr,
+                                      target_ulong opcode,
+                                      target_ulong *args)
+{
+    return h_guest_getset_state(cpu, spapr, args, false);
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1289,6 +1553,8 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_CREATE, h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE, h_guest_delete);
     spapr_register_hypercall(H_GUEST_CREATE_VCPU, h_guest_create_vcpu);
+    spapr_register_hypercall(H_GUEST_SET_STATE, h_guest_set_state);
+    spapr_register_hypercall(H_GUEST_GET_STATE, h_guest_get_state);
 }
 
 void spapr_unregister_nested_papr(void)
@@ -1298,6 +1564,8 @@ void spapr_unregister_nested_papr(void)
     spapr_unregister_hypercall(H_GUEST_CREATE);
     spapr_unregister_hypercall(H_GUEST_DELETE);
     spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
+    spapr_unregister_hypercall(H_GUEST_SET_STATE);
+    spapr_unregister_hypercall(H_GUEST_GET_STATE);
 }
 
 #else
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 070135793a..6223873641 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -366,6 +366,7 @@ struct SpaprMachineState {
 #define H_OVERLAP         -68
 #define H_STATE           -75
 #define H_IN_USE          -77
+#define H_INVALID_ELEMENT_VALUE            -81
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -589,6 +590,8 @@ struct SpaprMachineState {
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
 #define H_GUEST_CREATE_VCPU      0x474
+#define H_GUEST_GET_STATE        0x478
+#define H_GUEST_SET_STATE        0x47C
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 3da02df7bb..bf9b258c29 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -224,6 +224,10 @@ typedef struct SpaprMachineStateNestedGuest {
 #define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
 #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
 #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
+#define GSB_MAX_BUF_SIZE              (1024 * 1024)
+#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
+#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
+#define GUEST_STATE_REQUEST_SET              0x2
 
 /*
  * As per ISA v3.1B, following bits are reserved:
@@ -322,6 +326,25 @@ typedef struct SpaprMachineStateNestedGuest {
 #define GSE_ENV_DWM(i, f, m) \
     GUEST_STATE_ELEMENT_MSK(i, 8, f, copy_state_8to8, m)
 
+struct guest_state_element {
+    uint16_t id;
+    uint16_t size;
+    uint8_t value[];
+} QEMU_PACKED;
+
+struct guest_state_buffer {
+    uint32_t num_elements;
+    struct guest_state_element elements[];
+} QEMU_PACKED;
+
+/* Actual buffer plus some metadata about the request */
+struct guest_state_request {
+    struct guest_state_buffer *gsb;
+    int64_t buf;
+    int64_t len;
+    uint16_t flags;
+};
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
-- 
2.42.0


