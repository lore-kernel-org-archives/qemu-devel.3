Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D1EE64002
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvT-0003yA-0N; Sun, 05 Apr 2026 03:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvQ-0003xj-Mo
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:40 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvN-0007Nf-QK
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:40 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso3546438eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374176; x=1775978976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxfini/03ZCMwgjgBQ4pisEMx2q4rGRX8zkQlXe0tR4=;
 b=NB8bg2WYH+z/AmCtJCvRXkos/w/gGzR/p8f4znh4dQsYnSWEU66n7Vu6oSknX9iSWf
 74fv6g01TFcAk/fh2N1yjSNNLNisdlpO6e7aoKgKJ/aFoWe5zg5rwoKCSKy/PkxS04C9
 gyCFgP00D5JehrGqcOTwzLdpiUE+CMKP5R+7bPxbHfDn1fIWUbvN/9rhFhSkmnEP9H70
 WtZZCDgVNd2duPPDeCRExel0icXuGTAd09jqjXyQ93eQWWOoAsELkn5eM4Rc7s90V6ns
 yyEToP3N/pPObSesmhDS0kgq+IOoAiwQSNRLph7ScLBNOh3n0+lpo532VU0K/gwAq2YB
 H7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374176; x=1775978976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxfini/03ZCMwgjgBQ4pisEMx2q4rGRX8zkQlXe0tR4=;
 b=VV1NTNLPXOdjIGJk+WMnicuiokkaXwulKFCzW1+8kCbvooif0Y2R6oPNwc8qoMqSxJ
 +hvD1OR86Wt2oEyaQB1efXrRY+uyR/RjyEG6Eo4g4en6UqLhr5MqHXRSA/LnRO+Mhtn9
 Lf4RLNEvh3Iy4YG2vINvkynCIwYWYXC9VTEyZIhKBSRU8hm79GEQOIRw/gpCMmDaGhj/
 hjyFp1LheOMGzPqB94fXIGwy71K9DdL7qFM4NiI2B9S+qAeCeS1X22ZrB8MD0C9JKNiR
 xkk5OYR7DQLqNtCkGIBSY2F5qRkGS7PQkEtLTW+5/brzShtBcaMzm399OPcj3L5ZOnd5
 S8ug==
X-Gm-Message-State: AOJu0YweX1qPYYIZTiu1m6aBJfGWc9NXGGpPqty+kGakmmOsJpn6LtgY
 sWiBIbxfW1HFuCosSzZhh7UzNoF1ws4ZLxJqyEagszgLmsI8RamnjWFEF8ALkhyNy2c=
X-Gm-Gg: AeBDietDqHRNB86d8jEc4skl6er5lAkiOkv/e9tOr3EwYO6ttIrPMKWbQTocmFaEsw9
 MndWujHnceNtZMqrZYS1aXiVmgKjPFyNRtF9kzLNEnGxpkNoildu40+enpToSdCcdFDPBZ2hwYA
 Wqug7NqhzTj1V+j8wjSnWsCWgeJWwunrknvAs1dqZoC3Q2kf60ipM5oLBG+ki6j1r2GXOVwF2pW
 4LsNXBnr/7E8CtTsXj/4q17KqGZb8EbCxX/B+2i2Ss8MCdF/7+pwQtaqtlQ9FVMlGzPqkLj52tT
 sVJi5XnvswGrp9rkQX94R7tRA2W5aKozTxNEEVwvM76F4J3otTZvFUJwg7YDdFn3KSmVRso9wxK
 SIIbYd99imKFhSl1jJwJUYi0zmcQToCzSnfudpOKUF6NVJjF5E9VyKoEOIZU7+MtKehGddRx8y7
 9+ZL/g/t29Pet8PB1j1nhLfm6PpqW/uoZC89wngB7wZ6u1aXXVBjQdORtLcx0kP97S+MvoRjY3e
 ZW39jN2U3/L/QcxiOmIANWrmqo=
X-Received: by 2002:a05:7301:3f0f:b0:2c8:7172:3b88 with SMTP id
 5a478bee46e88-2cbfc16ec3bmr3959627eec.28.1775374175786; 
 Sun, 05 Apr 2026 00:29:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:35 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjg@umich.edu>,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 07/10] vfio/apple: Add DriverKit dext client library
Date: Sun,  5 Apr 2026 00:28:51 -0700
Message-ID: <20260405072857.66484-8-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1330.google.com
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

From: "Scott J. Goldman" <scottjg@umich.edu>

Add the C client library for communicating with the VFIOUserPCIDriver
DriverKit extension (dext) on macOS.  This provides the low-level
IOUserClient wrappers that the Apple VFIO backend will use:

- Connection management (connect, disconnect, claim)
- PCI config space read/write (individual and block)
- BAR info queries, BAR mapping/unmapping, MMIO read/write
- DMA region registration and unregistration
- Interrupt setup, pending IRQ polling, async notification
- Device reset (FLR with hot-reset fallback)

All calls go through IOKit's IOConnectCallScalarMethod /
IOConnectMapMemory64 to the dext, which mediates access to the
physical PCI device via PCIDriverKit.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 hw/vfio/apple-dext-client.c | 681 ++++++++++++++++++++++++++++++++++++
 hw/vfio/apple-dext-client.h | 253 ++++++++++++++
 hw/vfio/meson.build         |   7 +
 3 files changed, 941 insertions(+)
 create mode 100644 hw/vfio/apple-dext-client.c
 create mode 100644 hw/vfio/apple-dext-client.h

diff --git a/hw/vfio/apple-dext-client.c b/hw/vfio/apple-dext-client.c
new file mode 100644
index 0000000000..7ba03fc6e9
--- /dev/null
+++ b/hw/vfio/apple-dext-client.c
@@ -0,0 +1,681 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * C client implementation for communicating with the VFIOUserPCIDriver dext
+ * via IOKit IOUserClient.
+ *
+ * Copyright (c) 2026 Scott J. Goldman
+ */
+
+#include "qemu/osdep.h"
+
+#include "apple-dext-client.h"
+
+#include <CoreFoundation/CoreFoundation.h>
+#include <IOKit/IOKitLib.h>
+#include <dispatch/dispatch.h>
+#include <string.h>
+
+enum {
+    kSelectorGetIdentity        = 0,
+    kSelectorClaim              = 1,
+    kSelectorTerminate          = 2,
+    kSelectorAllocateDMABuffer  = 3,
+    kSelectorFreeDMABuffer      = 4,
+    kSelectorRegisterDMARegion  = 5,
+    kSelectorUnregisterDMARegion = 6,
+    kSelectorProbeDMARegion     = 7,
+    kSelectorConfigRead         = 8,
+    kSelectorConfigWrite        = 9,
+    kSelectorGetBARInfo         = 10,
+    kSelectorMMIORead           = 11,
+    kSelectorMMIOWrite          = 12,
+    kSelectorSetupInterrupts    = 13,
+    kSelectorCheckInterrupt     = 14,
+    kSelectorWaitInterrupt      = 15,
+    kSelectorSetIRQMask         = 16,
+    kSelectorResetDevice        = 17,
+};
+
+/*
+ * Keep this in sync with PCIDriverKit BAR type encoding. Bit 3 indicates
+ * prefetchability for memory BARs.
+ */
+#define APPLE_DEXT_BAR_PREFETCHABLE_MASK 0x08
+#ifndef kIOMapWriteCombineCache
+#define kIOMapWriteCombineCache 0x00000400
+#endif
+
+static bool
+dext_service_matches_class(io_service_t service, const char *className)
+{
+    bool match = false;
+    CFTypeRef ref;
+
+    ref = IORegistryEntryCreateCFProperty(service, CFSTR("IOUserClass"),
+                                          kCFAllocatorDefault, 0);
+    if (ref == NULL) {
+        return false;
+    }
+
+    if (CFGetTypeID(ref) == CFStringGetTypeID()) {
+        CFStringRef expected = CFStringCreateWithCString(
+            kCFAllocatorDefault, className, kCFStringEncodingUTF8);
+        if (expected != NULL) {
+            match = CFStringCompare((CFStringRef)ref, expected, 0)
+                    == kCFCompareEqualTo;
+            CFRelease(expected);
+        }
+    }
+    CFRelease(ref);
+    return match;
+}
+
+static bool
+dext_connection_matches_bdf(io_connect_t connection,
+                            uint8_t bus, uint8_t device, uint8_t function)
+{
+    uint64_t output[6] = {0};
+    uint32_t outputCount = 6;
+    kern_return_t kr;
+
+    kr = IOConnectCallMethod(connection, kSelectorGetIdentity,
+                             NULL, 0, NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS || outputCount < 3) {
+        return false;
+    }
+
+    return (uint8_t)output[0] == bus &&
+           (uint8_t)output[1] == device &&
+           (uint8_t)output[2] == function;
+}
+
+io_connect_t
+apple_dext_connect(uint8_t bus, uint8_t device, uint8_t function)
+{
+    CFMutableDictionaryRef matching;
+    io_iterator_t iterator = IO_OBJECT_NULL;
+    io_connect_t result = IO_OBJECT_NULL;
+    io_service_t service;
+    kern_return_t kr;
+
+    matching = IOServiceMatching("IOUserService");
+    if (matching == NULL) {
+        return IO_OBJECT_NULL;
+    }
+
+    kr = IOServiceGetMatchingServices(kIOMainPortDefault, matching, &iterator);
+    if (kr != KERN_SUCCESS) {
+        return IO_OBJECT_NULL;
+    }
+
+    while ((service = IOIteratorNext(iterator)) != IO_OBJECT_NULL) {
+        io_connect_t connection = IO_OBJECT_NULL;
+
+        if (!dext_service_matches_class(service, "VFIOUserPCIDriver")) {
+            IOObjectRelease(service);
+            continue;
+        }
+
+        kr = IOServiceOpen(service, mach_task_self(), 0, &connection);
+        IOObjectRelease(service);
+
+        if (kr != KERN_SUCCESS) {
+            continue;
+        }
+
+        if (dext_connection_matches_bdf(connection, bus, device, function)) {
+            result = connection;
+            break;
+        }
+
+        IOServiceClose(connection);
+    }
+
+    IOObjectRelease(iterator);
+    return result;
+}
+
+void
+apple_dext_disconnect(io_connect_t connection)
+{
+    if (connection != IO_OBJECT_NULL) {
+        IOServiceClose(connection);
+    }
+}
+
+kern_return_t
+apple_dext_claim(io_connect_t connection)
+{
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectCallMethod(connection,
+                               kSelectorClaim,
+                               NULL, 0, NULL, 0,
+                               NULL, NULL, NULL, NULL);
+}
+
+kern_return_t
+apple_dext_register_dma(io_connect_t connection,
+                            uint64_t iova,
+                            uint64_t client_va,
+                            uint64_t size,
+                            uint64_t *out_bus_addr,
+                            uint64_t *out_bus_len)
+{
+    uint64_t input[3] = { iova, client_va, size };
+    uint64_t output[3] = {0};
+    uint32_t outputCount = 3;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorRegisterDMARegion,
+                             input, 3,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    if (out_bus_addr != NULL && outputCount >= 2) {
+        *out_bus_addr = output[1];
+    }
+    if (out_bus_len != NULL && outputCount >= 3) {
+        *out_bus_len = output[2];
+    }
+
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_unregister_dma(io_connect_t connection,
+                              uint64_t iova)
+{
+    uint64_t input[1] = { iova };
+
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectCallMethod(connection,
+                               kSelectorUnregisterDMARegion,
+                               input, 1,
+                               NULL, 0,
+                               NULL, NULL,
+                               NULL, NULL);
+}
+
+kern_return_t
+apple_dext_probe_dma(io_connect_t connection,
+                         uint64_t iova,
+                         uint64_t offset,
+                         uint64_t *out_word)
+{
+    uint64_t input[2] = { iova, offset };
+    uint64_t output[1] = {0};
+    uint32_t outputCount = 1;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL || out_word == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorProbeDMARegion,
+                             input, 2,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    *out_word = output[0];
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_config_read(io_connect_t connection,
+                           uint64_t offset,
+                           uint64_t width,
+                           uint64_t *out_value)
+{
+    uint64_t input[2] = { offset, width };
+    uint64_t output[1] = {0};
+    uint32_t outputCount = 1;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL || out_value == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorConfigRead,
+                             input, 2,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    *out_value = output[0];
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_config_write(io_connect_t connection,
+                            uint64_t offset,
+                            uint64_t width,
+                            uint64_t value)
+{
+    uint64_t input[3] = { offset, width, value };
+
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectCallMethod(connection,
+                               kSelectorConfigWrite,
+                               input, 3,
+                               NULL, 0,
+                               NULL, NULL,
+                               NULL, NULL);
+}
+
+kern_return_t
+apple_dext_config_read_block(io_connect_t connection,
+                                 uint64_t offset,
+                                 void *buf,
+                                 size_t len)
+{
+    uint8_t *dst = (uint8_t *)buf;
+    uint64_t pos = offset;
+    size_t remaining = len;
+
+    if (connection == IO_OBJECT_NULL || buf == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    while (remaining >= 4) {
+        uint64_t val = 0;
+        uint32_t dword;
+        kern_return_t kr;
+
+        kr = apple_dext_config_read(connection, pos, 4, &val);
+        if (kr != KERN_SUCCESS) {
+            return kr;
+        }
+        dword = (uint32_t)val;
+        memcpy(dst, &dword, 4);
+        dst += 4;
+        pos += 4;
+        remaining -= 4;
+    }
+
+    while (remaining > 0) {
+        uint64_t val = 0;
+        kern_return_t kr;
+
+        kr = apple_dext_config_read(connection, pos, 1, &val);
+        if (kr != KERN_SUCCESS) {
+            return kr;
+        }
+        *dst = (uint8_t)val;
+        dst++;
+        pos++;
+        remaining--;
+    }
+
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_get_bar_info(io_connect_t connection,
+                            uint8_t bar,
+                            uint8_t *out_mem_idx,
+                            uint64_t *out_size,
+                            uint8_t *out_type)
+{
+    uint64_t input[1] = { bar };
+    uint64_t output[3] = {0};
+    uint32_t outputCount = 3;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorGetBARInfo,
+                             input, 1,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    if (out_mem_idx != NULL) {
+        *out_mem_idx = (uint8_t)output[0];
+    }
+    if (out_size != NULL) {
+        *out_size = output[1];
+    }
+    if (out_type != NULL) {
+        *out_type = (uint8_t)output[2];
+    }
+
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_map_bar(io_connect_t connection,
+                       uint8_t bar,
+                       mach_vm_address_t *out_addr,
+                       mach_vm_size_t *out_size,
+                       uint8_t *out_type)
+{
+    uint64_t bar_size = 0;
+    uint8_t bar_type = 0;
+    uint32_t mem_type;
+    mach_vm_address_t addr = 0;
+    mach_vm_size_t size = 0;
+    IOOptionBits opts = kIOMapAnywhere;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL || out_addr == NULL || out_size == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = apple_dext_get_bar_info(connection, bar, NULL,
+                                     &bar_size, &bar_type);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    /*
+     * The memory type for IOConnectMapMemory64 must match the dext's
+     * CopyClientMemoryForType expectation:
+     * kVFIOUserPCIDriverUserClientMemoryTypeBAR0 (= 1) plus the BAR index.
+     * This is NOT the same as the PCIDriverKit internal memoryIndex returned
+     * by GetBARInfo.
+     */
+    mem_type = 1 + (uint32_t)bar;
+
+    if (bar_type & APPLE_DEXT_BAR_PREFETCHABLE_MASK) {
+        opts |= kIOMapWriteCombineCache;
+    }
+
+    kr = IOConnectMapMemory64(connection, mem_type, mach_task_self(),
+                              &addr, &size, opts);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    *out_addr = addr;
+    *out_size = size;
+    if (out_type != NULL) {
+        *out_type = bar_type;
+    }
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_unmap_bar(io_connect_t connection,
+                         uint8_t bar,
+                         mach_vm_address_t addr)
+{
+    uint32_t mem_type = 1 + (uint32_t)bar;
+
+    if (connection == IO_OBJECT_NULL || addr == 0) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectUnmapMemory64(connection, mem_type, mach_task_self(), addr);
+}
+
+kern_return_t
+apple_dext_mmio_read(io_connect_t connection,
+                         uint8_t mem_idx,
+                         uint64_t offset,
+                         uint64_t width,
+                         uint64_t *out_value)
+{
+    uint64_t input[3] = { mem_idx, offset, width };
+    uint64_t output[1] = {0};
+    uint32_t outputCount = 1;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL || out_value == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorMMIORead,
+                             input, 3,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    *out_value = output[0];
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_mmio_write(io_connect_t connection,
+                          uint8_t mem_idx,
+                          uint64_t offset,
+                          uint64_t width,
+                          uint64_t value)
+{
+    uint64_t input[4] = { mem_idx, offset, width, value };
+
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectCallMethod(connection,
+                               kSelectorMMIOWrite,
+                               input, 4,
+                               NULL, 0,
+                               NULL, NULL,
+                               NULL, NULL);
+}
+
+kern_return_t
+apple_dext_setup_interrupts(io_connect_t connection,
+                                uint32_t *out_num_vectors)
+{
+    uint64_t output[1] = {0};
+    uint32_t outputCount = 1;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorSetupInterrupts,
+                             NULL, 0,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    if (out_num_vectors != NULL && outputCount >= 1) {
+        *out_num_vectors = (uint32_t)output[0];
+    }
+
+    return kIOReturnSuccess;
+}
+
+kern_return_t
+apple_dext_reset_device(io_connect_t connection)
+{
+    if (connection == IO_OBJECT_NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectCallMethod(connection,
+                               kSelectorResetDevice,
+                               NULL, 0, NULL, 0,
+                               NULL, NULL, NULL, NULL);
+}
+
+kern_return_t
+apple_dext_set_irq_mask(io_connect_t connection, const uint64_t mask[4])
+{
+    if (connection == IO_OBJECT_NULL || mask == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    return IOConnectCallMethod(connection,
+                               kSelectorSetIRQMask,
+                               mask, 4,
+                               NULL, 0,
+                               NULL, NULL,
+                               NULL, NULL);
+}
+
+kern_return_t
+apple_dext_read_pending_irqs(io_connect_t connection, uint64_t pending[4])
+{
+    uint64_t output[4] = {0};
+    uint32_t outputCount = 4;
+    kern_return_t kr;
+    uint32_t i;
+
+    if (connection == IO_OBJECT_NULL || pending == NULL) {
+        return kIOReturnBadArgument;
+    }
+
+    kr = IOConnectCallMethod(connection,
+                             kSelectorCheckInterrupt,
+                             NULL, 0,
+                             NULL, 0,
+                             output, &outputCount,
+                             NULL, NULL);
+    if (kr != KERN_SUCCESS) {
+        return kr;
+    }
+
+    for (i = 0; i < 4; i++) {
+        pending[i] = (i < outputCount) ? output[i] : 0;
+    }
+
+    return kIOReturnSuccess;
+}
+
+struct AppleDextInterruptNotify {
+    io_connect_t connection;
+    IONotificationPortRef notifyPort;
+    mach_port_t machPort;
+    dispatch_queue_t dispatchQueue;
+    void (*handler_fn)(void *opaque);
+    void *opaque;
+};
+
+static void
+apple_dext_async_callback(void *refcon, IOReturn result,
+                          void **args, uint32_t numArgs)
+{
+    AppleDextInterruptNotify *notify = refcon;
+
+    if (result == kIOReturnSuccess && notify->handler_fn) {
+        notify->handler_fn(notify->opaque);
+    }
+}
+
+static kern_return_t
+apple_dext_interrupt_notify_arm(AppleDextInterruptNotify *notify)
+{
+    uint64_t asyncRef[kIOAsyncCalloutCount];
+
+    asyncRef[kIOAsyncCalloutFuncIndex] =
+        (uint64_t)(uintptr_t)apple_dext_async_callback;
+    asyncRef[kIOAsyncCalloutRefconIndex] =
+        (uint64_t)(uintptr_t)notify;
+
+    return IOConnectCallAsyncMethod(notify->connection,
+                                    kSelectorWaitInterrupt,
+                                    notify->machPort,
+                                    asyncRef, kIOAsyncCalloutCount,
+                                    NULL, 0, NULL, 0,
+                                    NULL, NULL, NULL, NULL);
+}
+
+AppleDextInterruptNotify *
+apple_dext_interrupt_notify_create(io_connect_t connection,
+                                   void (*handler_fn)(void *opaque),
+                                   void *opaque)
+{
+    AppleDextInterruptNotify *notify;
+    kern_return_t kr;
+
+    if (connection == IO_OBJECT_NULL || handler_fn == NULL) {
+        return NULL;
+    }
+
+    notify = g_new0(AppleDextInterruptNotify, 1);
+    notify->connection = connection;
+    notify->handler_fn = handler_fn;
+    notify->opaque = opaque;
+
+    notify->notifyPort = IONotificationPortCreate(kIOMainPortDefault);
+    if (!notify->notifyPort) {
+        g_free(notify);
+        return NULL;
+    }
+
+    notify->dispatchQueue = dispatch_queue_create(
+        "org.qemu.vfio-apple.irq-notify", DISPATCH_QUEUE_SERIAL);
+    IONotificationPortSetDispatchQueue(notify->notifyPort,
+                                       notify->dispatchQueue);
+    notify->machPort = IONotificationPortGetMachPort(notify->notifyPort);
+
+    kr = apple_dext_interrupt_notify_arm(notify);
+    if (kr != KERN_SUCCESS) {
+        IONotificationPortDestroy(notify->notifyPort);
+        dispatch_release(notify->dispatchQueue);
+        g_free(notify);
+        return NULL;
+    }
+
+    return notify;
+}
+
+kern_return_t
+apple_dext_interrupt_notify_rearm(AppleDextInterruptNotify *notify)
+{
+    if (!notify) {
+        return kIOReturnBadArgument;
+    }
+    return apple_dext_interrupt_notify_arm(notify);
+}
+
+void
+apple_dext_interrupt_notify_destroy(AppleDextInterruptNotify *notify)
+{
+    if (!notify) {
+        return;
+    }
+
+    IONotificationPortDestroy(notify->notifyPort);
+    dispatch_release(notify->dispatchQueue);
+    g_free(notify);
+}
diff --git a/hw/vfio/apple-dext-client.h b/hw/vfio/apple-dext-client.h
new file mode 100644
index 0000000000..07574493e6
--- /dev/null
+++ b/hw/vfio/apple-dext-client.h
@@ -0,0 +1,253 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * C API for connecting to the VFIOUserPCIDriver DriverKit extension.
+ *
+ * The vfio-user server process uses this to:
+ *  1. Find and open an IOUserClient to the dext for a given PCI BDF.
+ *  2. Claim the device so the dext opens its IOPCIDevice provider.
+ *  3. Register client-owned memory (QEMU guest RAM mapped via shared file)
+ *     for DMA by the physical PCI device.
+ *  4. Unregister DMA regions when QEMU removes them.
+ *
+ * Integration with libvfio-user:
+ *   vfu_dma_register_cb_t  ->  apple_dext_register_dma()
+ *   vfu_dma_unregister_cb_t -> apple_dext_unregister_dma()
+ *
+ * Copyright (c) 2026 Scott J. Goldman
+ */
+
+#ifndef HW_VFIO_APPLE_DEXT_CLIENT_H
+#define HW_VFIO_APPLE_DEXT_CLIENT_H
+
+#include <IOKit/IOKitLib.h>
+#include <stdint.h>
+
+/*
+ * Find the VFIOUserPCIDriver dext instance matching the given PCI BDF
+ * and open an IOUserClient connection to it.
+ * Returns IO_OBJECT_NULL on failure.
+ */
+io_connect_t apple_dext_connect(uint8_t bus, uint8_t device,
+                                    uint8_t function);
+
+/*
+ * Close a previously opened connection.
+ */
+void apple_dext_disconnect(io_connect_t connection);
+
+/*
+ * Claim the PCI device through the dext (opens the IOPCIDevice provider).
+ * Must be called before registering DMA regions.
+ */
+kern_return_t apple_dext_claim(io_connect_t connection);
+
+/*
+ * Register a region of this process's address space for DMA.
+ *
+ * @iova:         guest IOVA (device-visible DMA address)
+ * @client_va:    virtual address of the memory in this process
+ * @size:         region size in bytes
+ * @out_bus_addr: receives first DMA bus address segment (may be NULL)
+ * @out_bus_len:  receives first DMA bus address segment length (may be NULL)
+ *
+ * The memory at client_va must remain valid and mapped until the region
+ * is unregistered.
+ */
+kern_return_t apple_dext_register_dma(io_connect_t connection,
+                                          uint64_t iova,
+                                          uint64_t client_va,
+                                          uint64_t size,
+                                          uint64_t *out_bus_addr,
+                                          uint64_t *out_bus_len);
+
+/*
+ * Unregister a previously registered DMA region identified by its IOVA.
+ */
+kern_return_t apple_dext_unregister_dma(io_connect_t connection,
+                                            uint64_t iova);
+
+/*
+ * Read 8 bytes from a registered DMA region's IOMemoryDescriptor.
+ * Used to verify the descriptor references the same physical pages
+ * as the client's virtual mapping.
+ *
+ * @iova:     base IOVA of the registered region
+ * @offset:   byte offset within the region to read from
+ * @out_word: receives the 8-byte value read from the descriptor
+ */
+kern_return_t apple_dext_probe_dma(io_connect_t connection,
+                                       uint64_t iova,
+                                       uint64_t offset,
+                                       uint64_t *out_word);
+
+/*
+ * Read from PCI configuration space.
+ *
+ * @offset: byte offset into config space
+ * @width:  access width in bytes (1, 2, or 4)
+ * @out_value: receives the value read
+ */
+kern_return_t apple_dext_config_read(io_connect_t connection,
+                                         uint64_t offset,
+                                         uint64_t width,
+                                         uint64_t *out_value);
+
+/*
+ * Write to PCI configuration space.
+ *
+ * @offset: byte offset into config space
+ * @width:  access width in bytes (1, 2, or 4)
+ * @value:  value to write
+ */
+kern_return_t apple_dext_config_write(io_connect_t connection,
+                                          uint64_t offset,
+                                          uint64_t width,
+                                          uint64_t value);
+
+/*
+ * Read a contiguous block of PCI configuration space.
+ * Internally issues repeated 32-bit reads, with a final
+ * narrower read for any trailing bytes.
+ *
+ * @offset: starting byte offset
+ * @buf:    destination buffer
+ * @len:    number of bytes to read
+ */
+kern_return_t apple_dext_config_read_block(io_connect_t connection,
+                                               uint64_t offset,
+                                               void *buf,
+                                               size_t len);
+
+/*
+ * Query BAR information from the PCI device.
+ *
+ * @bar:          BAR index (0-5)
+ * @out_mem_idx:  receives the memory index for MemoryRead/Write calls
+ * @out_size:     receives the BAR size in bytes
+ * @out_type:     receives the BAR type (mem32, mem64, io, etc.)
+ */
+kern_return_t apple_dext_get_bar_info(io_connect_t connection,
+                                          uint8_t bar,
+                                          uint8_t *out_mem_idx,
+                                          uint64_t *out_size,
+                                          uint8_t *out_type);
+
+/*
+ * Map a PCI BAR directly into this process through the dext.
+ *
+ * The dext supplies the BAR's IOMemoryDescriptor and IOKit applies the
+ * appropriate cache mode for the BAR type (default-cache for BAR0 style
+ * register windows, write-combine for prefetchable apertures).
+ *
+ * @bar:      BAR index (0-5)
+ * @out_addr: receives the mapped virtual address
+ * @out_size: receives the mapped size
+ * @out_type: receives the BAR type (may be NULL)
+ */
+kern_return_t apple_dext_map_bar(io_connect_t connection,
+                                     uint8_t bar,
+                                     mach_vm_address_t *out_addr,
+                                     mach_vm_size_t *out_size,
+                                     uint8_t *out_type);
+
+/*
+ * Unmap a BAR previously mapped with apple_dext_map_bar().
+ */
+kern_return_t apple_dext_unmap_bar(io_connect_t connection,
+                                       uint8_t bar,
+                                       mach_vm_address_t addr);
+
+/*
+ * Read from a PCI BAR (MMIO).
+ *
+ * @mem_idx: memory index from apple_dext_get_bar_info
+ * @offset:  byte offset within the BAR
+ * @width:   access width in bytes (1, 2, 4, or 8)
+ * @out_value: receives the value read
+ */
+kern_return_t apple_dext_mmio_read(io_connect_t connection,
+                                       uint8_t mem_idx,
+                                       uint64_t offset,
+                                       uint64_t width,
+                                       uint64_t *out_value);
+
+/*
+ * Write to a PCI BAR (MMIO).
+ *
+ * @mem_idx: memory index from apple_dext_get_bar_info
+ * @offset:  byte offset within the BAR
+ * @width:   access width in bytes (1, 2, 4, or 8)
+ * @value:   value to write
+ */
+kern_return_t apple_dext_mmio_write(io_connect_t connection,
+                                        uint8_t mem_idx,
+                                        uint64_t offset,
+                                        uint64_t width,
+                                        uint64_t value);
+
+/*
+ * Set up interrupt forwarding for the PCI device.
+ * Creates IOInterruptDispatchSource handlers for all available
+ * MSI/MSI-X vectors in the dext. Interrupts are queued in a ring
+ * buffer and retrieved via apple_dext_check_interrupt().
+ *
+ * @out_num_vectors: receives the number of interrupt vectors registered
+ */
+kern_return_t apple_dext_setup_interrupts(io_connect_t connection,
+                                              uint32_t *out_num_vectors);
+
+/*
+ * Reset the PCI device via the dext.  Tries FLR first, then falls
+ * back to PM reset (D3hot → D0 transition).
+ */
+kern_return_t apple_dext_reset_device(io_connect_t connection);
+
+/*
+ * Set the IRQ enable mask in the dext.  Only vectors with their
+ * corresponding bit set will be recorded as pending when the
+ * hardware fires.  mask[] is 4 x uint64_t covering 256 vectors.
+ */
+kern_return_t apple_dext_set_irq_mask(io_connect_t connection,
+                                      const uint64_t mask[4]);
+
+/*
+ * Read and clear all pending interrupt bits from the dext.
+ * Returns up to 256 bits (4 MSI/MSI-X vectors per bit) across
+ * 4 uint64_t words.  Each bit that was set is atomically cleared
+ * in the dext.
+ */
+kern_return_t apple_dext_read_pending_irqs(io_connect_t connection,
+                                           uint64_t pending[4]);
+
+/*
+ * Opaque state for async interrupt notification from the dext.
+ */
+typedef struct AppleDextInterruptNotify AppleDextInterruptNotify;
+
+/*
+ * Create async interrupt notification.  handler_fn is called on a GCD
+ * dispatch queue whenever the dext signals that one or more interrupt
+ * bits have been set.  The handler should wake the QEMU main loop,
+ * which then calls apple_dext_read_pending_irqs() to drain the bits.
+ *
+ * The notification is armed immediately upon creation.
+ */
+AppleDextInterruptNotify *
+apple_dext_interrupt_notify_create(io_connect_t connection,
+                                   void (*handler_fn)(void *opaque),
+                                   void *opaque);
+
+/*
+ * Re-arm the async interrupt notification after draining pending bits.
+ * Must be called after each wakeup to receive subsequent notifications.
+ */
+kern_return_t
+apple_dext_interrupt_notify_rearm(AppleDextInterruptNotify *notify);
+
+/*
+ * Tear down and free async interrupt notification state.
+ */
+void apple_dext_interrupt_notify_destroy(AppleDextInterruptNotify *notify);
+
+#endif /* HW_VFIO_APPLE_DEXT_CLIENT_H */
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 1ee9c11d5b..965c8e5b80 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -36,3 +36,10 @@ system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
 ))
+
+# Apple VFIO backend
+if host_os == 'darwin'
+  system_ss.add(when: 'CONFIG_VFIO',
+                if_true: [files('apple-dext-client.c'),
+                coref, iokit])
+endif
-- 
2.50.1 (Apple Git-155)


