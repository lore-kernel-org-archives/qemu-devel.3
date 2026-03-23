Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C2DF483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYx-0000rs-Ce; Mon, 23 Mar 2026 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYq-0000df-CR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYm-0000vp-FJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so3725204f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284923; x=1774889723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iW/mGBeluixf2opbc2MDnMz1SrddnkAeDyx0dfna1yo=;
 b=CMFtDHB+BqRUTW7LeLyI0ik7EJ1Hb6K9uVOZbP8CbIf2Zph3rTeftammrH1deL/fqS
 wMRJYBplRhgAJfXSWz+il3pK+DppjMoZRB0GMRDNaxEQElEOyM2EBAXkjOAiIQDrVZFg
 p5xEZUIoGx4yET4H5w8xb3+fddRyTd01YExhcUeKgVDW+v5O6RVO5JlsVVkz1L/yVafV
 St8EecaUTJmmi7KXFiOamOLgIed/4oyKekHRA0F0yjbPJb/4zFunuOH0XzOYQu22ixey
 6wfoIyZTVaWQnlzPxawkqHBi5gs9yJv/Uw8quEAQKNZ6DKD1K3KxaE7NgU+vtuo4VDPr
 BU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284923; x=1774889723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iW/mGBeluixf2opbc2MDnMz1SrddnkAeDyx0dfna1yo=;
 b=ku/IqZP/SBxbeZ2G1LVjkx5Ke4i6klXB+31lXu1YscN9vDMb3A9Ys0eU4x6WH9MoTa
 3IQKtndZyuMuqiGoOMbeqXnD4pkxKzVKtDmVPWDV3SXa5XC6vGBbd+nnZw3cNE3odxpF
 v+LWsBDWpArGSVKkig0NVAggwK/FFKhVI/l/S1H6BzWoRfnh1iV6thOTxyVrAn0zhO3F
 ma/t1k9EHluHGtZ8buqRLS8BPYYWj42BcSQWHG20vjxysEEFG8sH7dCmIsIHDKwkKfEd
 /QvAk7xha34bUIcoAdeebusCWu8ZLulXGDiNAIJRzW5ttmM7CnG/v5Z/3FCuJARBHdi6
 ruAw==
X-Gm-Message-State: AOJu0YxV9xWzypXtuY+TFZfQdhBY3n3sZW/5j+IKntXuByMaqbTaaMdr
 +4sAF/VzD4BVhxwmwoA3lXMqTBGQb+VKArBFj8V1Q3/BW116I85oPc1rnM7BoXIDNO7/mlscA6j
 cGVf/8eE=
X-Gm-Gg: ATEYQzzrfq/sag8WeFFcAeFSiYr90uyqKZKF+UTvZo2G+oJCG4VoEjJtE1jxo4Z0yu2
 OpicPqclUGSwvz6tue/acHg7KAN4BKgbEaRwLpoJRBDyXOc5BWHj4/eJ2QwLshK/QpRRjsbMPt3
 JqRgLZrJml3KlpFSE24b3g9gfJPuL6K1YgTTQXTvhbXNiZDyRmEt6Wc7nVnT3/R6T/rz4G5Rtmu
 zeLpbQL1duenAek1gVTDvIJLEjP6EVtmbnb9rfE5hnaoKlcEALiMoiLANI/C9VCZ7PvQQ7WbUiA
 NWjJb1OeB2kVrxK/JMJXgLheH376M3uENVYNxV/xzk1DfTDFifJ8J+dx3lvRhBb5faJjh3pWlQS
 Gpyccsixqbmkqtx3u/OJR6jRmwiYtF8k33kYpaV05OyA1fmuYgh5dJORwTnexrjjD0ZPcFYOwtA
 wBTezOD2tNj21zuyNeB8qCfS1qUaEpoVy20RS7OdEXQQvWSdET+JTrR7gsO2lS0urVWJGBiUMi
X-Received: by 2002:a05:600c:4349:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-4870f1fc613mr2794785e9.7.1774284922580; 
 Mon, 23 Mar 2026 09:55:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1d8138sm81234235e9.34.2026.03.23.09.55.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:55:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/27] hw/hyperv: add QEMU_PACKED to uapi structs
Date: Mon, 23 Mar 2026 17:52:18 +0100
Message-ID: <20260323165218.96607-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

The uapi definitions are marked with __packed hints in the kernel
headers, since we want to keep the contract of the Microsoft Hypervisor
ABI explicit, we should also added them in our vendored files, with a
few notable exceptions where the attribute is a noop.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
[PMD: Do not include "qemu/compiler.h"]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/hyperv/hvgdk_mini.h | 35 +++++++++++++++++++++-------------
 include/hw/hyperv/hvhdk.h      | 12 ++++++------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index cb52cc9de28..c3a8f33280a 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -211,7 +211,7 @@ enum hv_intercept_type {
 struct hv_u128 {
     uint64_t low_part;
     uint64_t high_part;
-};
+} QEMU_PACKED;
 
 union hv_x64_xmm_control_status_register {
     struct hv_u128 as_uint128;
@@ -326,13 +326,13 @@ typedef struct hv_x64_segment_register {
         };
         uint16_t attributes;
     };
-} hv_x64_segment_register;
+} QEMU_PACKED hv_x64_segment_register;
 
 typedef struct hv_x64_table_register {
     uint16_t pad[3];
     uint16_t limit;
     uint64_t base;
-} hv_x64_table_register;
+} QEMU_PACKED hv_x64_table_register;
 
 union hv_x64_fp_control_status_register {
     struct hv_u128 as_uint128;
@@ -416,6 +416,10 @@ typedef union hv_register_value {
     union hv_x64_register_sev_control sev_control;
 } hv_register_value;
 
+/*
+ * This struct is __packed in the kernel. Since all members are naturally
+ * aligned, we can omit QEMU_PACKED to avoid address-of-packed-member warnings.
+ */
 typedef struct hv_register_assoc {
     uint32_t name;         /* enum hv_register_name */
     uint32_t reserved1;
@@ -439,7 +443,7 @@ typedef struct hv_input_get_vp_registers {
     uint8_t  rsvd_z8;
     uint16_t rsvd_z16;
     uint32_t names[];
-} hv_input_get_vp_registers;
+} QEMU_PACKED hv_input_get_vp_registers;
 
 typedef struct hv_input_set_vp_registers {
     uint64_t partition_id;
@@ -448,7 +452,7 @@ typedef struct hv_input_set_vp_registers {
     uint8_t  rsvd_z8;
     uint16_t rsvd_z16;
     struct hv_register_assoc elements[];
-} hv_input_set_vp_registers;
+} QEMU_PACKED hv_input_set_vp_registers;
 
 union hv_interrupt_control {
     uint64_t as_uint64;
@@ -468,7 +472,7 @@ struct hv_input_assert_virtual_interrupt {
     uint8_t target_vtl;
     uint8_t rsvd_z0;
     uint16_t rsvd_z1;
-};
+} QEMU_PACKED;
 
 /* /dev/mshv */
 #define MSHV_CREATE_PARTITION   _IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
@@ -487,6 +491,11 @@ struct hv_input_assert_virtual_interrupt {
  ********************************
  */
 
+/*
+ * This struct is __packed in the kernel, but since all members are naturally
+ * aligned, so we can omit QEMU_PACKED to avoid address-of-packed-member
+ * warnings.
+ */
 struct hv_local_interrupt_controller_state {
     /* HV_X64_INTERRUPT_CONTROLLER_STATE */
     uint32_t apic_id;
@@ -644,7 +653,7 @@ struct hv_x64_intercept_message_header {
     struct hv_x64_segment_register cs_segment;
     uint64_t rip;
     uint64_t rflags;
-};
+} QEMU_PACKED;
 
 union hv_x64_io_port_access_info {
     uint8_t as_uint8;
@@ -669,7 +678,7 @@ typedef struct hv_x64_io_port_intercept_message {
     uint64_t rcx;
     uint64_t rsi;
     uint64_t rdi;
-} hv_x64_io_port_intercept_message;
+} QEMU_PACKED hv_x64_io_port_intercept_message;
 
 union hv_x64_memory_access_info {
     uint8_t as_uint8;
@@ -692,7 +701,7 @@ struct hv_x64_memory_intercept_message {
     uint64_t guest_virtual_address;
     uint64_t guest_physical_address;
     uint8_t instruction_bytes[16];
-};
+} QEMU_PACKED;
 
 union hv_message_flags {
     uint8_t asu8;
@@ -711,14 +720,14 @@ struct hv_message_header {
         uint64_t sender;
         union hv_port_id port;
     };
-};
+} QEMU_PACKED;
 
 struct hv_message {
     struct hv_message_header header;
     union {
         uint64_t payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
     } u;
-};
+} QEMU_PACKED;
 
 /* From  github.com/rust-vmm/mshv-bindings/src/x86_64/regs.rs */
 
@@ -731,13 +740,13 @@ struct hv_cpuid_entry {
     uint32_t ecx;
     uint32_t edx;
     uint32_t padding[3];
-};
+} QEMU_PACKED;
 
 struct hv_cpuid {
     uint32_t nent;
     uint32_t padding;
     struct hv_cpuid_entry entries[0];
-};
+} QEMU_PACKED;
 
 #define IA32_MSR_TSC            0x00000010
 #define IA32_MSR_EFER           0xC0000080
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index 866c8211bfe..41af7438471 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -16,7 +16,7 @@ struct hv_input_set_partition_property {
     uint32_t property_code; /* enum hv_partition_property_code */
     uint32_t padding;
     uint64_t property_value;
-};
+} QEMU_PACKED;
 
 union hv_partition_synthetic_processor_features {
     uint64_t as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
@@ -201,12 +201,12 @@ typedef struct hv_input_translate_virtual_address {
     uint32_t padding;
     uint64_t control_flags;
     uint64_t gva_page;
-} hv_input_translate_virtual_address;
+} QEMU_PACKED hv_input_translate_virtual_address;
 
 typedef struct hv_output_translate_virtual_address {
     union hv_translate_gva_result translation_result;
     uint64_t gpa_page;
-} hv_output_translate_virtual_address;
+} QEMU_PACKED hv_output_translate_virtual_address;
 
 typedef struct hv_register_x64_cpuid_result_parameters {
     struct {
@@ -226,13 +226,13 @@ typedef struct hv_register_x64_cpuid_result_parameters {
         uint32_t edx;
         uint32_t edx_mask;
     } result;
-} hv_register_x64_cpuid_result_parameters;
+} QEMU_PACKED hv_register_x64_cpuid_result_parameters;
 
 typedef struct hv_register_x64_msr_result_parameters {
     uint32_t msr_index;
     uint32_t access_type;
     uint32_t action; /* enum hv_unimplemented_msr_action */
-} hv_register_x64_msr_result_parameters;
+} QEMU_PACKED hv_register_x64_msr_result_parameters;
 
 union hv_register_intercept_result_parameters {
     struct hv_register_x64_cpuid_result_parameters cpuid;
@@ -244,6 +244,6 @@ typedef struct hv_input_register_intercept_result {
     uint32_t vp_index;
     uint32_t intercept_type; /* enum hv_intercept_type */
     union hv_register_intercept_result_parameters parameters;
-} hv_input_register_intercept_result;
+} QEMU_PACKED hv_input_register_intercept_result;
 
 #endif /* HW_HYPERV_HVHDK_H */
-- 
2.53.0


