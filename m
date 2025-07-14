Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EC1C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIU-0003VH-Av; Mon, 14 Jul 2025 19:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHY-0006WO-3s
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHU-0005fx-CC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znDa8XirYCFJbWIhb2Af4aUAACoax7sDJMNQccypmgY=;
 b=bmB/g1rNlF0uKwag5pk7E+sX8syP9fYI0wQAqQrSEzkM6eiBKiwHnrsLAUNjFVJAiTPBIQ
 RqLpsxhV6VHq2g2uVUxLa2WaanRzdG8fB3BmKB/zCD3oTgVV10KTDAI4NIXehceNeFYPi/
 BPZY2ivxpfFE4QRHKd9USUKv3AG3T5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-o5rxuQa4NnS08HCjG41i1A-1; Mon, 14 Jul 2025 19:08:15 -0400
X-MC-Unique: o5rxuQa4NnS08HCjG41i1A-1
X-Mimecast-MFC-AGG-ID: o5rxuQa4NnS08HCjG41i1A_1752534494
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so30616335e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534494; x=1753139294;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znDa8XirYCFJbWIhb2Af4aUAACoax7sDJMNQccypmgY=;
 b=VYOLm5i7jQUpJVxOL4eh3kMWEc/IolM8nS6qVWGb6qjva89CeeqNQrbpGTDTERTWGx
 A/pXq+5a8NWkv1YEtEl21qlDoyh4P8RhsbZ5A3rB9CC1vNtHAW+HnTY/uHAnFpse+pQJ
 thUEgIauUEJAcBVmtIo0r4F9Eq+j9ZQ0GYfibUucbdvOyXv/0iEw+Q7DHGHvqOQOp/zl
 2ulCZ2Eb5ejLCi7g4wfpOw5GEFbiCnTiPG1N13eGmF8/woIurzFRNAMqyHVPTcIIIE6A
 1ryp1ICNN7STtdfH+KhlCAcVT6Cz3+bO5P3G+Y/yBzKfegaNGYvelFEgxsH857stGNLo
 64xQ==
X-Gm-Message-State: AOJu0YwOHZRRqlnfiV41WKwEHPmGALEPULGfzCx6QXwnyEwgg6eeZgJc
 7LprAVmVZwGMyNkghzLfVu3Gf05kFoxuoqCTQu1yj92OFLYAf5soQzdV5kkKGQV3ppjrS+4CBvG
 8n/5Pbv1Zxjw/FI7HBdC/AytS/lL00B6rjYGvwI31MtGL/F1diklHgrvLn1IPZf/er/U+YIwN3d
 X3eQpUTgqCIUUfVDeAHsi+nAuEtKDsZ4/9tw==
X-Gm-Gg: ASbGncvx+01SlArK9MMyfUyF3kvCm6RhXLQjOy92XmOba4tL9HKeoDPKFX3qNd1guCx
 SwtVB+lNc3pKVsgax6rSMHO7lEHAgfq6hNvKzSi8DQWtju6Sa0cdZvAUrFnnqE7uKIwxoOwGgRf
 QMvudo1d/QPszgOcCXGDamvwCph+rksW80Ib3DfSO2ZlSQsZFRAX1C6qAatTuZs4r1DeHzSu943
 2tiAHnruu4ETSq21NZMwCztPKwAqTGk+0u3GBypyg1bK82TEWb01Wi8gqbPCrg1FZasv8oATbvc
 0FmamXYXbsRAOciLsVn32tcLLAmwVp2Z
X-Received: by 2002:a05:600c:828a:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-455c6197d55mr141928085e9.0.1752534493617; 
 Mon, 14 Jul 2025 16:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFOBZwLVasnDGXxo7PcIhkhMSsBXmPalH67I/3pXuAZnmMcCgfXiEqomQSofGdSHOiwHMvsw==
X-Received: by 2002:a05:600c:828a:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-455c6197d55mr141927245e9.0.1752534492838; 
 Mon, 14 Jul 2025 16:08:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1a5sm13319208f8f.74.2025.07.14.16.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:12 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Xu <peterx@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PULL 45/97] qemu: Declare all load/store helper in 'qemu/bswap.h'
Message-ID: <ff8ae8ed2c8c1018a632d8c528d01a89214bd10c.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Restrict "exec/tswap.h" to the tswap*() methods,
move the load/store helpers with the other ones
declared in "qemu/bswap.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250708215320.70426-8-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/tswap.h                 | 70 --------------------------
 include/qemu/bswap.h                 | 73 ++++++++++++++++++++++++++++
 include/system/memory.h              |  1 -
 include/user/abitypes.h              |  1 -
 target/ppc/mmu-hash64.h              |  2 -
 hw/acpi/bios-linker-loader.c         |  2 -
 hw/arm/allwinner-r40.c               |  1 -
 hw/arm/boot.c                        |  2 +
 hw/arm/npcm7xx.c                     |  2 +-
 hw/block/hd-geometry.c               |  1 -
 hw/char/riscv_htif.c                 |  1 -
 hw/cxl/cxl-events.c                  |  2 -
 hw/display/artist.c                  |  1 +
 hw/display/ati.c                     |  1 +
 hw/net/can/ctucan_core.c             |  1 -
 hw/net/lan9118.c                     |  1 +
 hw/net/rtl8139.c                     |  1 +
 hw/net/vmxnet3.c                     |  1 -
 hw/pci-host/gt64120.c                |  1 +
 hw/pci-host/pnv_phb3.c               |  1 +
 hw/pci-host/pnv_phb4.c               |  1 +
 hw/pci-host/ppce500.c                |  1 -
 hw/pci-host/sh_pci.c                 |  1 -
 hw/s390x/s390-pci-inst.c             |  1 +
 hw/sensor/lsm303dlhc_mag.c           |  1 -
 hw/smbios/smbios.c                   |  1 +
 hw/vfio/migration-multifd.c          |  1 -
 hw/virtio/virtio-pci.c               |  1 +
 hw/vmapple/virtio-blk.c              |  1 -
 target/arm/cpu.c                     |  1 -
 target/i386/tcg/system/excp_helper.c |  1 -
 target/i386/xsave_helper.c           |  1 -
 target/riscv/vector_helper.c         |  1 -
 tests/tcg/plugins/mem.c              |  1 +
 34 files changed, 87 insertions(+), 93 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 55ffa63359..72219e2c43 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -69,74 +69,4 @@ static inline void tswap64s(uint64_t *s)
     }
 }
 
-/* Return ld{word}_{le,be}_p following target endianness. */
-#define LOAD_IMPL(word, args...)                    \
-do {                                                \
-    if (target_big_endian()) {                      \
-        return glue(glue(ld, word), _be_p)(args);   \
-    } else {                                        \
-        return glue(glue(ld, word), _le_p)(args);   \
-    }                                               \
-} while (0)
-
-static inline int lduw_p(const void *ptr)
-{
-    LOAD_IMPL(uw, ptr);
-}
-
-static inline int ldsw_p(const void *ptr)
-{
-    LOAD_IMPL(sw, ptr);
-}
-
-static inline int ldl_p(const void *ptr)
-{
-    LOAD_IMPL(l, ptr);
-}
-
-static inline uint64_t ldq_p(const void *ptr)
-{
-    LOAD_IMPL(q, ptr);
-}
-
-static inline uint64_t ldn_p(const void *ptr, int sz)
-{
-    LOAD_IMPL(n, ptr, sz);
-}
-
-#undef LOAD_IMPL
-
-/* Call st{word}_{le,be}_p following target endianness. */
-#define STORE_IMPL(word, args...)           \
-do {                                        \
-    if (target_big_endian()) {              \
-        glue(glue(st, word), _be_p)(args);  \
-    } else {                                \
-        glue(glue(st, word), _le_p)(args);  \
-    }                                       \
-} while (0)
-
-
-static inline void stw_p(void *ptr, uint16_t v)
-{
-    STORE_IMPL(w, ptr, v);
-}
-
-static inline void stl_p(void *ptr, uint32_t v)
-{
-    STORE_IMPL(l, ptr, v);
-}
-
-static inline void stq_p(void *ptr, uint64_t v)
-{
-    STORE_IMPL(q, ptr, v);
-}
-
-static inline void stn_p(void *ptr, int sz, uint64_t v)
-{
-    STORE_IMPL(n, ptr, sz, v);
-}
-
-#undef STORE_IMPL
-
 #endif  /* TSWAP_H */
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 9a11764536..39ba64046a 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,6 +1,8 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
+#include "qemu/target-info.h"
+
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
 #undef  bswap32
@@ -432,4 +434,75 @@ DO_STN_LDN_P(be)
 #undef le_bswaps
 #undef be_bswaps
 
+
+/* Return ld{word}_{le,be}_p following target endianness. */
+#define LOAD_IMPL(word, args...)                    \
+do {                                                \
+    if (target_big_endian()) {                      \
+        return glue(glue(ld, word), _be_p)(args);   \
+    } else {                                        \
+        return glue(glue(ld, word), _le_p)(args);   \
+    }                                               \
+} while (0)
+
+static inline int lduw_p(const void *ptr)
+{
+    LOAD_IMPL(uw, ptr);
+}
+
+static inline int ldsw_p(const void *ptr)
+{
+    LOAD_IMPL(sw, ptr);
+}
+
+static inline int ldl_p(const void *ptr)
+{
+    LOAD_IMPL(l, ptr);
+}
+
+static inline uint64_t ldq_p(const void *ptr)
+{
+    LOAD_IMPL(q, ptr);
+}
+
+static inline uint64_t ldn_p(const void *ptr, int sz)
+{
+    LOAD_IMPL(n, ptr, sz);
+}
+
+#undef LOAD_IMPL
+
+/* Call st{word}_{le,be}_p following target endianness. */
+#define STORE_IMPL(word, args...)           \
+do {                                        \
+    if (target_big_endian()) {              \
+        glue(glue(st, word), _be_p)(args);  \
+    } else {                                \
+        glue(glue(st, word), _le_p)(args);  \
+    }                                       \
+} while (0)
+
+
+static inline void stw_p(void *ptr, uint16_t v)
+{
+    STORE_IMPL(w, ptr, v);
+}
+
+static inline void stl_p(void *ptr, uint32_t v)
+{
+    STORE_IMPL(l, ptr, v);
+}
+
+static inline void stq_p(void *ptr, uint64_t v)
+{
+    STORE_IMPL(q, ptr, v);
+}
+
+static inline void stn_p(void *ptr, int sz, uint64_t v)
+{
+    STORE_IMPL(n, ptr, sz, v);
+}
+
+#undef STORE_IMPL
+
 #endif /* BSWAP_H */
diff --git a/include/system/memory.h b/include/system/memory.h
index d6d069fd50..e2cd6ed126 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -19,7 +19,6 @@
 #include "exec/memattrs.h"
 #include "exec/memop.h"
 #include "exec/ramlist.h"
-#include "exec/tswap.h"
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
diff --git a/include/user/abitypes.h b/include/user/abitypes.h
index 7528124b62..be7a876523 100644
--- a/include/user/abitypes.h
+++ b/include/user/abitypes.h
@@ -6,7 +6,6 @@
 #endif
 
 #include "exec/cpu-defs.h"
-#include "exec/tswap.h"
 #include "user/tswap-target.h"
 
 #ifdef TARGET_ABI32
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index b8fb12a970..ae8d4b37ae 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,8 +1,6 @@
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
-#include "exec/tswap.h"
-
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index 108061828b..c9ffe449aa 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -22,8 +22,6 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 
-#include "qemu/bswap.h"
-
 /*
  * Linker/loader is a paravirtualized interface that passes commands to guest.
  * The commands can be used to request guest to
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 0bf700865c..c8eda39957 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/boards.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index becd827af1..d391cd01bb 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -15,6 +15,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
 #include "cpu.h"
+#include "exec/tswap.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
@@ -29,6 +30,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "qemu/bswap.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 2f30c49df5..ecfae328a9 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -24,7 +24,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/bswap.h"
+#include "exec/tswap.h"
 #include "qemu/units.h"
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index f3939e73f4..db221901cf 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -33,7 +33,6 @@
 #include "qemu/osdep.h"
 #include "system/block-backend.h"
 #include "qapi/qapi-types-block.h"
-#include "qemu/bswap.h"
 #include "hw/block/block.h"
 #include "trace.h"
 
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index c884be5d75..a78ea9b01c 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -29,7 +29,6 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
-#include "exec/tswap.h"
 #include "system/dma.h"
 #include "system/runstate.h"
 #include "trace.h"
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..f90470930d 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -8,8 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-
-#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 3fafc8a222..3c884c9243 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -12,6 +12,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/loader.h"
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 7de27732cd..f7c0006a87 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -22,6 +22,7 @@
 #include "vga-access.h"
 #include "hw/qdev-properties.h"
 #include "vga_regs.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index 17131a4e18..6bd99c477b 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -28,7 +28,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 6dda1e5c94..3017e12971 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -21,6 +21,7 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include <zlib.h> /* for crc32 */
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 654a087d80..324fb932aa 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -57,6 +57,7 @@
 #include "system/dma.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "qemu/bswap.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "system/system.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 7c0ca56b7c..af73aa8ef2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -22,7 +22,6 @@
 #include "net/tap.h"
 #include "net/checksum.h"
 #include "system/system.h"
-#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/pci/msix.h"
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index b12a25696c..b1d96f62fe 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
+#include "qemu/bswap.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index a4335f44f2..5d8383fac3 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -8,6 +8,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "hw/pci-host/pnv_phb3_regs.h"
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 77ea35299d..18992054e8 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -8,6 +8,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 52269b05bb..975d191ccb 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -20,7 +20,6 @@
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
-#include "qemu/bswap.h"
 #include "hw/pci-host/ppce500.h"
 #include "qom/object.h"
 
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index de8f6a84aa..62fb945075 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -28,7 +28,6 @@
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
-#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b5dddb22b8..a3bb5aa221 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -16,6 +16,7 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "qemu/error-report.h"
+#include "qemu/bswap.h"
 #include "system/hw_accel.h"
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index f9e501da84..cd5773ae64 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -28,7 +28,6 @@
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "qemu/bswap.h"
 
 enum LSM303DLHCMagReg {
     LSM303DLHC_MAG_REG_CRA          = 0x00,
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index ad4cd6721e..1ac063cfb4 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 55635486c8..9dc70fdf16 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -13,7 +13,6 @@
 #include "hw/vfio/vfio-device.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
-#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fba2372c93..767216d795 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bswap.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 532b5649ab..9de9aaae0b 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -19,7 +19,6 @@
 #include "hw/vmapple/vmapple.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-pci.h"
-#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 08c43f674a..e2b2337399 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,7 +23,6 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
-#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index c162621587..50040f6fca 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -25,7 +25,6 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
-#include "exec/tswap.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 24ab7be8e9..996e9f3bfe 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -5,7 +5,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/tswap.h"
 
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b41c29da0b..7c67d67a13 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -27,7 +27,6 @@
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "exec/target_page.h"
-#include "exec/tswap.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index ca4e8883dd..9649bce99c 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -20,6 +20,7 @@
  * few things provided by compiler.h.
  */
 #include <compiler.h>
+#include <stdbool.h>
 #include <bswap.h>
 #include <qemu-plugin.h>
 
-- 
MST


