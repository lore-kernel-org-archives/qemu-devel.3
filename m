Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F49FCCF2D9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhm9E-0003p1-37; Mon, 19 Jan 2026 05:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8z-0003ee-4M
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8x-0005hp-0z
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768817154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ua7njaz9pOiUUx2wfrxq6ER/uHzoU4+I1XH8S0BIZyM=;
 b=U8zM2HjIZRv6eArkXgs+38bn5HultOhO7u/vqMnn7hQieqyD4++82rR/cmpAH0fBnG1S/h
 OLTrP4OXtMzCtrHFB3oqOBax8FRO2UHRgNH2OFS+/k1K3ZPI21nDNY4eioEEWbezSSKWmK
 aTVGLtg1fX53No2hnex9QSj31L9leTo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-RsTwRDSuO664I8Do9Ha9Tw-1; Mon,
 19 Jan 2026 05:05:50 -0500
X-MC-Unique: RsTwRDSuO664I8Do9Ha9Tw-1
X-Mimecast-MFC-AGG-ID: RsTwRDSuO664I8Do9Ha9Tw_1768817148
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B12F18D65E1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C83911801760
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8AB2021E66D3; Mon, 19 Jan 2026 11:05:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] Clean up decorations and whitespace around header guards
Date: Mon, 19 Jan 2026 11:05:37 +0100
Message-ID: <20260119100537.463312-6-armbru@redhat.com>
In-Reply-To: <20260119100537.463312-1-armbru@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cleaned up with scripts/clean-header-guards.pl.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 crypto/akcipherpriv.h                       | 2 +-
 crypto/der.h                                | 2 +-
 hw/net/e1000x_regs.h                        | 2 +-
 hw/riscv/riscv-iommu-bits.h                 | 2 +-
 include/accel/accel-cpu-target.h            | 2 +-
 include/exec/tswap.h                        | 2 +-
 include/hw/char/max78000_uart.h             | 2 +-
 include/hw/fsi/fsi-master.h                 | 3 ++-
 include/hw/intc/loongarch_extioi_common.h   | 2 +-
 include/hw/intc/loongarch_pic_common.h      | 2 +-
 include/hw/misc/allwinner-a10-ccm.h         | 2 +-
 include/hw/ppc/pnv_n1_chiplet.h             | 2 +-
 include/semihosting/uaccess.h               | 2 +-
 include/system/ioport.h                     | 2 +-
 include/tcg/tcg-temp-internal.h             | 2 +-
 target/hexagon/idef-parser/parser-helpers.h | 2 +-
 target/i386/kvm/xen-compat.h                | 2 +-
 target/loongarch/cpu-mmu.h                  | 2 +-
 target/loongarch/tcg/tcg_loongarch.h        | 4 +++-
 target/riscv/cpu_vendorid.h                 | 2 +-
 20 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/crypto/akcipherpriv.h b/crypto/akcipherpriv.h
index 3b33e54f08..09db61f120 100644
--- a/crypto/akcipherpriv.h
+++ b/crypto/akcipherpriv.h
@@ -52,4 +52,4 @@ struct QCryptoAkCipherDriver {
     void (*free)(QCryptoAkCipher *akcipher);
 };
 
-#endif /* QCRYPTO_AKCIPHER_H */
+#endif /* QCRYPTO_AKCIPHERPRIV_H */
diff --git a/crypto/der.h b/crypto/der.h
index bcfa4a2495..99275012c6 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -261,4 +261,4 @@ size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx);
 void qcrypto_der_encode_ctx_flush_and_free(QCryptoEncodeContext *ctx,
                                            uint8_t *dst);
 
-#endif  /* QCRYPTO_ASN1_DECODER_H */
+#endif /* QCRYPTO_ASN1_DECODER_H */
diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index e9a74de6f4..971653e9b2 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -968,4 +968,4 @@ struct e1000_context_desc {
 #define E1000_VFTA_ENTRY_MASK           0x7F
 #define E1000_VFTA_ENTRY_BIT_SHIFT_MASK 0x1F
 
-#endif /* HW_E1000_REGS_H */
+#endif /* HW_E1000X_REGS_H */
diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 47fe01bee5..685f9af4e0 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -466,4 +466,4 @@ struct riscv_iommu_msi_pte {
 #define RISCV_IOMMU_MSI_MRIF_NPPN       RISCV_IOMMU_PPN_FIELD
 #define RISCV_IOMMU_MSI_MRIF_NID_MSB    BIT_ULL(60)
 
-#endif /* _RISCV_IOMMU_BITS_H_ */
+#endif /* HW_RISCV_IOMMU_BITS_H */
diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 6feb344e29..4ac85ddf74 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -28,4 +28,4 @@
 #define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
 
-#endif /* ACCEL_CPU_H */
+#endif /* ACCEL_CPU_TARGET_H */
diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c43..31c7d3d40b 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -69,4 +69,4 @@ static inline void tswap64s(uint64_t *s)
     }
 }
 
-#endif  /* TSWAP_H */
+#endif /* TSWAP_H */
diff --git a/include/hw/char/max78000_uart.h b/include/hw/char/max78000_uart.h
index 6977c7b3f1..bef42f5078 100644
--- a/include/hw/char/max78000_uart.h
+++ b/include/hw/char/max78000_uart.h
@@ -75,4 +75,4 @@ struct Max78000UartState {
     CharFrontend chr;
     qemu_irq irq;
 };
-#endif /* HW_STM32F2XX_USART_H */
+#endif /* HW_MAX78000_UART_H */
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
index 60ddaa994f..193f6e0fde 100644
--- a/include/hw/fsi/fsi-master.h
+++ b/include/hw/fsi/fsi-master.h
@@ -4,6 +4,7 @@
  *
  * IBM Flexible Service Interface Master
  */
+
 #ifndef FSI_FSI_MASTER_H
 #define FSI_FSI_MASTER_H
 
@@ -29,4 +30,4 @@ typedef struct FSIMasterState {
 } FSIMasterState;
 
 
-#endif /* FSI_FSI_H */
+#endif /* FSI_FSI_MASTER_H */
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 2dbc2563eb..878e0a4586 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -100,4 +100,4 @@ struct LoongArchExtIOICommonClass {
     int (*pre_save)(void *s);
     int (*post_load)(void *s, int version_id);
 };
-#endif /* LOONGARCH_EXTIOI_H */
+#endif /* LOONGARCH_EXTIOI_COMMON_H */
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 1627ec0899..14897a6972 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -79,4 +79,4 @@ struct LoongArchPICCommonClass {
     int (*pre_save)(LoongArchPICCommonState *s);
     int (*post_load)(LoongArchPICCommonState *s, int version_id);
 };
-#endif  /* HW_LOONGARCH_PIC_COMMON_H */
+#endif /* HW_LOONGARCH_PIC_COMMON_H */
diff --git a/include/hw/misc/allwinner-a10-ccm.h b/include/hw/misc/allwinner-a10-ccm.h
index 109b83f4df..a80b814ce7 100644
--- a/include/hw/misc/allwinner-a10-ccm.h
+++ b/include/hw/misc/allwinner-a10-ccm.h
@@ -64,4 +64,4 @@ struct AwA10ClockCtlState {
     uint32_t regs[AW_A10_CCM_REGS_NUM];
 };
 
-#endif /* HW_MISC_ALLWINNER_H3_CCU_H */
+#endif /* HW_MISC_ALLWINNER_A10_CCM_H */
diff --git a/include/hw/ppc/pnv_n1_chiplet.h b/include/hw/ppc/pnv_n1_chiplet.h
index a7ad039668..ff563eaee1 100644
--- a/include/hw/ppc/pnv_n1_chiplet.h
+++ b/include/hw/ppc/pnv_n1_chiplet.h
@@ -29,4 +29,4 @@ typedef struct PnvN1Chiplet {
 #define PNV_PB_SCOM_ES_SIZE 4
     PnvPbScom es[PNV_PB_SCOM_ES_SIZE];
 } PnvN1Chiplet;
-#endif /*PPC_PNV_N1_CHIPLET_H */
+#endif /* PPC_PNV_N1_CHIPLET_H */
diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 2093a49827..2e6f80971f 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -118,4 +118,4 @@ void uaccess_unlock_user(CPUArchState *env, void *p,
 ssize_t uaccess_strlen_user(CPUArchState *env, vaddr addr);
 #define target_strlen(p) uaccess_strlen_user(env, p)
 
-#endif /* SEMIHOSTING_SOFTMMU_UACCESS_H */
+#endif /* SEMIHOSTING_UACCESS_H */
diff --git a/include/system/ioport.h b/include/system/ioport.h
index 780ea5a676..6ff57039c1 100644
--- a/include/system/ioport.h
+++ b/include/system/ioport.h
@@ -72,4 +72,4 @@ void portio_list_del(PortioList *piolist);
 void portio_list_set_enabled(PortioList *piolist, bool enabled);
 void portio_list_set_address(PortioList *piolist, uint32_t addr);
 
-#endif /* IOPORT_H */
+#endif /* SYSTEM_IOPORT_H */
diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 98f91e68b7..b3c78e309a 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -48,4 +48,4 @@ static inline void tcg_temp_ebb_reset_freed(TCGContext *s)
     memset(s->free_temps, 0, sizeof(s->free_temps));
 }
 
-#endif /* TCG_TEMP_FREE_H */
+#endif /* TCG_TEMP_INTERNAL_H */
diff --git a/target/hexagon/idef-parser/parser-helpers.h b/target/hexagon/idef-parser/parser-helpers.h
index 2087d534a9..d763a3609b 100644
--- a/target/hexagon/idef-parser/parser-helpers.h
+++ b/target/hexagon/idef-parser/parser-helpers.h
@@ -350,4 +350,4 @@ void assert_signedness(Context *c,
                        YYLTYPE *locp,
                        HexSignedness signedness);
 
-#endif /* PARSER_HELPERS_h */
+#endif /* PARSER_HELPERS_H */
diff --git a/target/i386/kvm/xen-compat.h b/target/i386/kvm/xen-compat.h
index 7f30180cc2..9f46eb2aa7 100644
--- a/target/i386/kvm/xen-compat.h
+++ b/target/i386/kvm/xen-compat.h
@@ -67,4 +67,4 @@ struct compat_physdev_map_pirq {
     uint64_t table_base;
 } __attribute__((packed));
 
-#endif /* QEMU_I386_XEN_COMPAT_H */
+#endif /* QEMU_I386_KVM_XEN_COMPAT_H */
diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2259de9d36..a585cd3332 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -99,4 +99,4 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
-#endif  /* LOONGARCH_CPU_MMU_H */
+#endif /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 7fb627f2d6..ef6ced33a7 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -4,8 +4,10 @@
  *
  * Copyright (c) 2025 Loongson Technology Corporation Limited
  */
+
 #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
 #define TARGET_LOONGARCH_TCG_LOONGARCH_H
+
 #include "cpu.h"
 #include "cpu-mmu.h"
 
@@ -20,4 +22,4 @@ TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
                                    MMUAccessType access_type, int mmu_idx);
 
-#endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
+#endif /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index f1ffc66542..d55632b73d 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -8,4 +8,4 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
-#endif /*  TARGET_RISCV_CPU_VENDORID_H */
+#endif /* TARGET_RISCV_CPU_VENDORID_H */
-- 
2.52.0


