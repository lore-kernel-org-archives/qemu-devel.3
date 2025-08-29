Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F70ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNHT-0000la-Sc; Sat, 30 Aug 2025 11:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiy-0001K1-9a
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiv-0008U8-VC
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjvNoEBlPGGeT3X9UNFdF+p5pPcBnEqxoXo/cfNszuk=;
 b=Sn8DdndLwP4YooRfGx9OENn2Fm3MfnmPrvhMTCVGulssHX2z5clPlnctb6JN7sRyLSsQ+R
 vRxWFr9k9odrXitNE/9dTb2HE6zjs0wQfg2sTL/j1vbYlIbachyLTGAz1ME85PgKramJ2l
 8jXFhEvUycEDJ4J1mFfhlBejZARA2Hs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-zsE0KYShMKiWc0Iz4wdSVQ-1; Fri, 29 Aug 2025 09:00:52 -0400
X-MC-Unique: zsE0KYShMKiWc0Iz4wdSVQ-1
X-Mimecast-MFC-AGG-ID: zsE0KYShMKiWc0Iz4wdSVQ_1756472452
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0cb0aaso16055485e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472451; x=1757077251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjvNoEBlPGGeT3X9UNFdF+p5pPcBnEqxoXo/cfNszuk=;
 b=F/Nygcs9DNvdyKmJpGVGui8ldYi8+kwI41UHILnkW/pWnd01PU5Y7btOKOX807B3nN
 acCfbOdO+yMGgtTA2PxqNVSMnGY/chdIk8JFw8Nd38afx3wTuamAzhwZxpEKlsrATWdb
 +Z1laeFg1TWumHLSiDp++1AwnYmqsBVAE8Jwy6sMTrIvkLSyVbzIqBQSgN2QLJ/14UjS
 RETF31LlFRu2ezExHzeHoBRIOoNytjkCDy44FqeMt0CStTiegyDa4N8QS/u319oUeeCG
 78N8vBCKfFL45vOtBoSjFa3oUviNVZUw3tLvoDPo0XkF425NOgtvqspglm69v2yLvuOn
 oZVw==
X-Gm-Message-State: AOJu0YwYUWFcFb5xvx39BuhUcWk5iBHBlOTOe39gwntXaaNZ4BV6cTNl
 iEEJb64P6xHVcnRgwKN98al1gtaKe0xgMUTjKtTODtRsLlDxMjjvRHHtCIBPzMvCXxwlCJV4MZP
 RCkcD7UpqdwRf0VrIzHcvnjHnswqjbojFCSlimnuCTdG7FLmQu7yuswXI1fhbfuhATZzM+zMfzG
 npRlb0VwEoTTb3YljIkC7ZguZFGHV2S8xXfALnKeFK
X-Gm-Gg: ASbGncu4tdtTSfmDYllix7rwwerjKVnKA0fJVAsGihYS0eT10Uz0UymWF2FdvHURxFs
 4syeUKvVsqWMiVda0ojf2dzA7dbHsK55o2BxNpPFHeGxgc9ZJI4y+XQ6zP1NC//qoH+QB3+VL/A
 O4XOe8z44Rn77aZAEWRW4+upwxFMUl+ubTqEEBRM7r7+NLmAocdFWxOO0q5Zlgc2seqBpFz5ihS
 mH6VRe4yzGiDb8reKK0cKPM6gEb20Hp2IUeFaPcjDL++gW5KZLf8iGY/rAuKrM5URRRIj0FzljL
 0ZvO9uZMdojd0RDWnbjYPIBvOA3KuM+/voYvM9rYAXAADjZyh+897tKF/Y63tTRpFd8egx6B/gA
 qck9rVy7rWQTmv2+a3C4zyE+gAuVKfzTGoXo+MIzusZg=
X-Received: by 2002:a05:600c:35c9:b0:459:d821:a45b with SMTP id
 5b1f17b1804b1-45b5179e76dmr233551795e9.9.1756472450650; 
 Fri, 29 Aug 2025 06:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl/yq7DKUacBbEGNQMFu2WNmfyJ0yh1gJONhbfuoGUwZhUI52suGzBzk5YsZVXsm/iFYS0KQ==
X-Received: by 2002:a05:600c:35c9:b0:459:d821:a45b with SMTP id
 5b1f17b1804b1-45b5179e76dmr233551485e9.9.1756472450190; 
 Fri, 29 Aug 2025 06:00:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9431sm3308063f8f.44.2025.08.29.06.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 22/28] memory: reintroduce BQL-free fine-grained PIO/MMIO
Date: Fri, 29 Aug 2025 14:59:29 +0200
Message-ID: <20250829125935.1526984-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
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

From: Igor Mammedov <imammedo@redhat.com>

This patch brings back Jan's idea [1] of BQL-free IO access

This will let us make access to ACPI PM/HPET timers cheaper,
and prevent BQL contention in case of workload that heavily
uses the timers with a lot of vCPUs.

1) 196ea13104f (memory: Add global-locking property to memory regions)
   ... de7ea885c539 (kvm: Switch to unlocked MMIO)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250814160600.2327672-2-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/memory.h | 12 ++++++++++++
 system/memory.c         | 15 +++++++++++++++
 system/physmem.c        |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed1261..aa85fc27a10 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -833,6 +833,7 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
+    bool lockless_io;
     bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
@@ -2341,6 +2342,17 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
  */
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
+/**
+ * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.
+ *
+ * Enable BQL-free access for devices that are well prepared to handle
+ * locking during I/O themselves: either by doing fine grained locking or
+ * by providing lock-free I/O schemes.
+ *
+ * @mr: the memory region to be updated.
+ */
+void memory_region_enable_lockless_io(MemoryRegion *mr);
+
 /**
  * memory_region_add_eventfd: Request an eventfd to be triggered when a word
  *                            is written to a location.
diff --git a/system/memory.c b/system/memory.c
index 56465479406..44701c465c1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2546,6 +2546,21 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
+void memory_region_enable_lockless_io(MemoryRegion *mr)
+{
+    mr->lockless_io = true;
+    /*
+     * reentrancy_guard has per device scope, that when enabled
+     * will effectively prevent concurrent access to device's IO
+     * MemoryRegion(s) by not calling accessor callback.
+     *
+     * Turn it off for lock-less IO enabled devices, to allow
+     * concurrent IO.
+     * TODO: remove this when reentrancy_guard becomes per transaction.
+     */
+    mr->disable_reentrancy_guard = true;
+}
+
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
diff --git a/system/physmem.c b/system/physmem.c
index e5dd760e0bc..f498572fc82 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2900,7 +2900,7 @@ bool prepare_mmio_access(MemoryRegion *mr)
 {
     bool release_lock = false;
 
-    if (!bql_locked()) {
+    if (!bql_locked() && !mr->lockless_io) {
         bql_lock();
         release_lock = true;
     }
-- 
2.51.0


