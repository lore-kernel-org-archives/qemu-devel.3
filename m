Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DABCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrR-0004nU-DD; Fri, 22 Aug 2025 08:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrO-0004mO-BP
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrL-0002OJ-66
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlReG/+hxnj7VCu+zXagdieQwy6JVPcB87iHElBDdfk=;
 b=EywJyYNl6D75FdQfwBDmUHqMszwIK5bthV/1jyWgUU4sQDh4xV0fdsTrL4t3f1gvCN7DYG
 rOgqOS5BN56bgxlYBT+3TJB1wv1v6xroUPVcfHylY5l0fXW9M9EGJ2p1vO/ol7oUpZ0UJF
 HN8GXuO8FGakrZQY8MpCkEM67JSq69o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-FucmeFcdP9Kr9QvG93SowQ-1; Fri, 22 Aug 2025 08:27:03 -0400
X-MC-Unique: FucmeFcdP9Kr9QvG93SowQ-1
X-Mimecast-MFC-AGG-ID: FucmeFcdP9Kr9QvG93SowQ_1755865622
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b9edf5b346so863748f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865621; x=1756470421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlReG/+hxnj7VCu+zXagdieQwy6JVPcB87iHElBDdfk=;
 b=fMjsRy9KzSV/KFPW/vT8HooFOS58FshhftciaD58ZV4QxhgLweUcGxXeDBHSEH8Cwp
 /4gbMcBTqubi0WdaQriBcbKnXmxx1gJtsz4rOmOXWfjgh+rOISEsLpOwcXl5giGtGGZN
 2eCfzz3Wi/LKb5G82NGhI0Gs84HfzqgxxF/fsRjeOIu/Ahcu28i+5ynE9AS/FHh8REjP
 3FLw4Xp2sPMfb4GzcMJtJnwhBeI9q78npmhqH4+neLMOeVgkfltXlECkJ9IcrdeLl6UR
 BVnpBgzOIDdzXps/XcdNPgOJy0SxHjSg+ZuNJbO3y9tdj2lXviTf0OfP/66qGq9og0kH
 sZcg==
X-Gm-Message-State: AOJu0YyNx5D6tXhayhR3cNopXJH+aC+zgDATA7XvRHbUY+WhoIj16q0h
 5vf202nziczpPxBlxzA8bLohGWF/Sc5afhFxly0GhzUqRJzPPejpWPnxmkL2id20oUHeHjM/yzV
 2w8SAB+YXUjjkOu/FaAzFyT+y6uwTnrQHwMT/OPOYU8/ydshKjNpFA/yQacHpWWdpW2mVyuvucN
 HVJc/rgWkJwRkIibdY8fB7Fol65YNAstkQDiHvufhs
X-Gm-Gg: ASbGncvVBCIOwmjvf68vklRDI7x8RGe19NG19xOt1tjIztMWEfDjpNv11l7Gx0gMBng
 VA6nyGtp7pELUGdRPykJ1R+jJx3Q932FlvYAojX/h5ucmX75yLMglcES+vHujWv7Nhs/Yl8PDjT
 CJ/OF2NRRZKTt5sJNjSX8FCm7Gtoc9VMvH5UBbKbr0EmNqClaefvFVsladTjKOhGu4/CPtbWBIo
 i+lWbR/+tLCyIvMHQuAIgLw3djySsE6s4cpIpOIumgD+5vc2BcshszIZ7RYnz3iMZIUYeizSb5V
 4KaaenwtuqIaFi3r4+ZsUgaeukE4u/qtVIzDdCpYez8u9N7OM2kDhHHYyBRKAHmJRglD4HOcKS7
 qBNA2n9xdez6myIIz37bbukKvRs6Emf3JHOlR5F4UwQ==
X-Received: by 2002:a05:6000:2084:b0:3b7:931d:3789 with SMTP id
 ffacd0b85a97d-3c5da54e877mr1740190f8f.4.1755865620674; 
 Fri, 22 Aug 2025 05:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFHLCc76kFJLaNN5uE6YBztuhQlFjvYkXW0Bs26F9yF3XRMmwniv9Lq+QqVZ+LwGlm5frZAA==
X-Received: by 2002:a05:6000:2084:b0:3b7:931d:3789 with SMTP id
 ffacd0b85a97d-3c5da54e877mr1740170f8f.4.1755865620128; 
 Fri, 22 Aug 2025 05:27:00 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077c5767fsm15405123f8f.62.2025.08.22.05.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:26:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 01/14] treewide: write "unsigned long int" instead of "long
 unsigned int"
Date: Fri, 22 Aug 2025 14:26:42 +0200
Message-ID: <20250822122655.1353197-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Putting "unsigned" in anything but the first position is weird.  As such,
tracetool's Rust type conversion will not support it.  Remove it from
the whole of QEMU's source code, not just trace-events.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 crypto/pbkdf-gcrypt.c        | 2 +-
 crypto/pbkdf-gnutls.c        | 2 +-
 crypto/pbkdf-nettle.c        | 2 +-
 hw/display/exynos4210_fimd.c | 2 +-
 hw/misc/imx7_src.c           | 4 ++--
 hw/net/can/can_sja1000.c     | 4 ++--
 hw/xen/trace-events          | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index e89b8b1c768..f93996f674c 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -66,7 +66,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
     if (iterations > ULONG_MAX) {
         error_setg_errno(errp, ERANGE,
                          "PBKDF iterations %llu must be less than %lu",
-                         (long long unsigned)iterations, ULONG_MAX);
+                         (unsigned long long)iterations, ULONG_MAX);
         return -1;
     }
 
diff --git a/crypto/pbkdf-gnutls.c b/crypto/pbkdf-gnutls.c
index f34423f918b..46a3a869994 100644
--- a/crypto/pbkdf-gnutls.c
+++ b/crypto/pbkdf-gnutls.c
@@ -62,7 +62,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
     if (iterations > ULONG_MAX) {
         error_setg_errno(errp, ERANGE,
                          "PBKDF iterations %llu must be less than %lu",
-                         (long long unsigned)iterations, ULONG_MAX);
+                         (unsigned long long)iterations, ULONG_MAX);
         return -1;
     }
 
diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index 3ef9c1b52c4..3c8bbaf9f17 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -66,7 +66,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
     if (iterations > UINT_MAX) {
         error_setg_errno(errp, ERANGE,
                          "PBKDF iterations %llu must be less than %u",
-                         (long long unsigned)iterations, UINT_MAX);
+                         (unsigned long long)iterations, ULONG_MAX);
         return -1;
     }
 
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c61e0280a7c..5632aa1388c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1380,7 +1380,7 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
     uint32_t old_value;
 
     DPRINT_L2("write offset 0x%08x, value=%llu(0x%08llx)\n", offset,
-            (long long unsigned int)val, (long long unsigned int)val);
+            (unsigned long long)val, (unsigned long long)val);
 
     switch (offset) {
     case FIMD_VIDCON0:
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index df0b0a69057..817c95bf65b 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -169,7 +169,7 @@ static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMX7SRCState *s = (IMX7SRCState *)opaque;
     uint32_t index = offset >> 2;
-    long unsigned int change_mask;
+    uint32_t change_mask;
     uint32_t current_value = value;
 
     if (index >= SRC_MAX) {
@@ -180,7 +180,7 @@ static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
 
     trace_imx7_src_write(imx7_src_reg_name(SRC_A7RCR0), s->regs[SRC_A7RCR0]);
 
-    change_mask = s->regs[index] ^ (uint32_t)current_value;
+    change_mask = s->regs[index] ^ current_value;
 
     switch (index) {
     case SRC_A7RCR0:
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 5b6ba9df6c4..545c520c3b4 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -750,8 +750,8 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size)
             break;
         }
     }
-    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02lx\n",
-            (int)addr, size, (long unsigned int)temp);
+    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02x\n",
+            (int)addr, size, (unsigned)temp);
 
     return temp;
 }
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index b67942d07b4..3b71ee641ff 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -57,8 +57,8 @@ cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uin
 cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u data=0x%x"
 cpu_get_ioreq_from_shared_memory_req_not_ready(int state, int data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O request not ready: 0x%x, ptr: 0x%x, port: 0x%"PRIx64", data: 0x%"PRIx64", count: %u, size: %u"
 xen_main_loop_prepare_init_cpu(int id, void *cpu) "cpu_by_vcpu_id[%d]=%p"
-xen_map_ioreq_server_shared_page(long unsigned int ioreq_pfn) "shared page at pfn 0x%lx"
-xen_map_ioreq_server_buffered_io_page(long unsigned int ioreq_pfn) "buffered io page at pfn 0x%lx"
+xen_map_ioreq_server_shared_page(unsigned long int ioreq_pfn) "shared page at pfn 0x%lx"
+xen_map_ioreq_server_buffered_io_page(unsigned long int ioreq_pfn) "buffered io page at pfn 0x%lx"
 xen_map_ioreq_server_buffered_io_evtchn(int bufioreq_evtchn) "buffered io evtchn is 0x%x"
 destroy_hvm_domain_cannot_acquire_handle(void) "Cannot acquire xenctrl handle"
 destroy_hvm_domain_failed_action(const char *action, int sts, char *errno_s) "xc_domain_shutdown failed to issue %s, sts %d, %s"
-- 
2.50.1


