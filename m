Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89760C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnc-0007aP-ON; Fri, 01 Aug 2025 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhS-0005VV-Bl
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhQ-0002n4-HE
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XA9J84IWz65/jFGEF4PHg1aGXOZdSUvhbvxiqHCyUZw=;
 b=M0AA6d/FovoeRlY0ZUbxqevcyZmC21aSfqBTa74H7jR7Po3UKCHsmbgEeFFqV+F2qmcxuA
 1lQLqxgr0HD5Cwf3vrIp5dyU4LdIdRBATXt9U0C3Tmr6OG6dEwXGdAz8tR3afmby0Qv00W
 IRQ3V5SOm1nKBuKbWvrgmyhTU1yxJQY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179--xl1FdWtPei5eWUysydeBg-1; Fri, 01 Aug 2025 10:25:30 -0400
X-MC-Unique: -xl1FdWtPei5eWUysydeBg-1
X-Mimecast-MFC-AGG-ID: -xl1FdWtPei5eWUysydeBg_1754058329
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4560f28b2b1so6780045e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058329; x=1754663129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XA9J84IWz65/jFGEF4PHg1aGXOZdSUvhbvxiqHCyUZw=;
 b=WVms4Q+C/KptirinTi2hWAg05OhLheagb82SD0ySg0cToRn4vCJR28uMVxUBLkT+7A
 SHXZKRmWtyGLuiVIOhNRXCQayRxCwmRGoeVdl5UaupmkFv+aSXlBxF/+LkD0LVUYBhrv
 1IF+9MVrJEb4vEk/4NeJmSvVIsIk5eyWjoLgYM8eBf42kmIRa+aVjBzb3Eljh1Q0yxcp
 SBJGTf3rOSMQFgis1txlxfoKcJP2YykSPqvR5dprGUAWKtRWeE+rDNnxP/mfb4nWtpfC
 jCuBDxE4AR/tmq4GokeUxz49h+1RD+4ev+b8X9aZWCCJVAP0+ByyA7QDIpr+o5PP+I6a
 430g==
X-Gm-Message-State: AOJu0YwIYYr3zIKjdn1fuollE/W4tNaX1HicQZ7x/OLPmQrQIEpUK4e4
 1o30Zv9vhRlXku31c9PU5Tjf2PYokq8Tvmw11L4QL/xZW8KtrSc+SDoqSriK4myJbYs7L+Nxcmg
 liGBv/i6rt3WZkBXbHdsmQ2jIGBHjGBuweUzxFhYoRkpFopup+QZJd4I/w8dWZSdj9EBXsaIr9D
 +Pj2B7j0/vhHxGJowOwM7sGh0KWPKKuzgitQ==
X-Gm-Gg: ASbGncsB9BxSkuHte8eWlGAJaUGDQd3KEgOufOKK9lsDMZLFHCeb8lmXZQLJvjqT3Iw
 5FzK+txJWzDfbFQUmx0e9Hbdw1XzJSwW9FKTdwQJhTO26cU/I1j1YiXKFwFKg/qHsyCqqgKhpjM
 tZoT3c2nvo+JLWnAJfmfSCpajnyevQhKJh53bZWSgg6jWGzTevFz4LoVPEM+swxeAYS5QZEyg03
 c9ydiw+9oAo/k8GFmLK8iYaJsnuxBwasGO1hClIk0FcxbqPgoZqVGMtXNyXfp8vh1rHj6wvoGjt
 iWzsSUV3FsZxFEP5xPd9fFxg+VirCXzA
X-Received: by 2002:a05:600c:c059:20b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-458930a2ea5mr72424285e9.4.1754058328945; 
 Fri, 01 Aug 2025 07:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgFsLBip16NgLIYRqdPDAuPi03g4j+/ctXE9W03ABHfPZZlwshXYt704MMRORcjGcfvL40Fg==
X-Received: by 2002:a05:600c:c059:20b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-458930a2ea5mr72424015e9.4.1754058328447; 
 Fri, 01 Aug 2025 07:25:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536bc34sm106134815e9.2.2025.08.01.07.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:28 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/17] hw/i386/amd_iommu: Fix event log generation
Message-ID: <c0ef803a879b97f3d269348c968fb3874c2761f6.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Current event logging code is broken, because of following issues

1. The code uses '|' instead of '&' to test the bit field, which causes
   vIOMMU to generate overflow interrupt for every log entry.
2. Code does not update the eventlog tail MMIO register after adding an
   entry to the buffer, because of which guest cannot process new
   entries (as head == tail means buffer is empty).
3. Compares eventlog tail (which is byte offset in the buffer) to
   eventlog length (which is number of maximum entries in the buffer).
   This causes vIOMMU to generate only fix number of event logs, after
   which it keeps on generating overflow interrupts, without
   actually resetting the log buffer.
4. Updates ComWaitInt instead of EventLogInt bitfield in Status
   register. Guest checks this field to see if there are new event log
   entries in the buffer.
5. Does not reset event log head and tail pointers when guest writes to
   eventlog base register.

Fix above issues, so that guest can process event log entries.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250801060507.3382-7-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  1 +
 hw/i386/amd_iommu.c | 44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 67078c6f1e..2476296c49 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -111,6 +111,7 @@
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
 #define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
 #define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
+#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
 #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6925085d29..26be69bec8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -160,10 +160,10 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
              (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
-/* OR a 64-bit register with a 64-bit value */
+/* AND a 64-bit register with a 64-bit value */
 static bool amdvi_test_mask(AMDVIState *s, hwaddr addr, uint64_t val)
 {
-    return amdvi_readq(s, addr) | val;
+    return amdvi_readq(s, addr) & val;
 }
 
 /* OR a 64-bit register with a 64-bit value storing result in the register */
@@ -192,19 +192,31 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
     }
 }
 
+static uint32_t get_next_eventlog_entry(AMDVIState *s)
+{
+    uint32_t evtlog_size = s->evtlog_len * AMDVI_EVENT_LEN;
+    return (s->evtlog_tail + AMDVI_EVENT_LEN) % evtlog_size;
+}
+
 static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 {
+    uint32_t evtlog_tail_next;
+
     /* event logging not enabled */
     if (!s->evtlog_enabled || amdvi_test_mask(s, AMDVI_MMIO_STATUS,
         AMDVI_MMIO_STATUS_EVT_OVF)) {
         return;
     }
 
+    evtlog_tail_next = get_next_eventlog_entry(s);
+
     /* event log buffer full */
-    if (s->evtlog_tail >= s->evtlog_len) {
-        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
-        /* generate interrupt */
-        amdvi_generate_msi_interrupt(s);
+    if (evtlog_tail_next == s->evtlog_head) {
+        /* generate overflow interrupt */
+        if (s->evtlog_intr) {
+            amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
+            amdvi_generate_msi_interrupt(s);
+        }
         return;
     }
 
@@ -213,9 +225,13 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
-    s->evtlog_tail += AMDVI_EVENT_LEN;
-    amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_COMP_INT);
-    amdvi_generate_msi_interrupt(s);
+    s->evtlog_tail = evtlog_tail_next;
+    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
+
+    if (s->evtlog_intr) {
+        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
+        amdvi_generate_msi_interrupt(s);
+    }
 }
 
 static void amdvi_setevent_bits(uint64_t *buffer, uint64_t value, int start,
@@ -731,9 +747,19 @@ static inline void amdvi_handle_excllim_write(AMDVIState *s)
 static inline void amdvi_handle_evtbase_write(AMDVIState *s)
 {
     uint64_t val = amdvi_readq(s, AMDVI_MMIO_EVENT_BASE);
+
+    if (amdvi_readq(s, AMDVI_MMIO_STATUS) & AMDVI_MMIO_STATUS_EVENT_INT)
+        /* Do not reset if eventlog interrupt bit is set*/
+        return;
+
     s->evtlog = val & AMDVI_MMIO_EVTLOG_BASE_MASK;
     s->evtlog_len = 1UL << (amdvi_readq(s, AMDVI_MMIO_EVTLOG_SIZE_BYTE)
                     & AMDVI_MMIO_EVTLOG_SIZE_MASK);
+
+    /* clear tail and head pointer to 0 when event base is updated */
+    s->evtlog_tail = s->evtlog_head = 0;
+    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_HEAD, s->evtlog_head);
+    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
 }
 
 static inline void amdvi_handle_evttail_write(AMDVIState *s)
-- 
MST


