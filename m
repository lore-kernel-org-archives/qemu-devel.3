Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43412C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBZ-000769-3E; Tue, 23 Jul 2024 06:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBT-0006tM-Ph
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBR-0001cU-O7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qA9H4BX2NYCarA+XIitFOqcduT5OCfIk2f7Otx3d0Y8=;
 b=OpqAYFA2HRWgHMRzLISoKW2XSYvH/xzh9DIrug3OOtgaFxodYXeFKS10LoFIUc6n0CMjbd
 qKHCmo4GbarX8kqiaqgPcQyYaXvD3tJi6NA1zchFXtcs3RUhTKJ/1Q/xOjUdDFcNUbs1N7
 AxqZ9Uc63ibLBhvp0K2QwxurR5EFkuk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-7cqhZtsUN1SS4TpOkhC9MQ-1; Tue, 23 Jul 2024 06:55:51 -0400
X-MC-Unique: 7cqhZtsUN1SS4TpOkhC9MQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77c6ea022fso114813766b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732149; x=1722336949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qA9H4BX2NYCarA+XIitFOqcduT5OCfIk2f7Otx3d0Y8=;
 b=VGhcCKG2jwuuFzTvWVTM6LU2Ue96d3uRmCgZajXBpCMa/RaDdFXP73OocJMlnaSTNF
 gGt37TQJM2LqMUdVsdDJHcAB6Hw2nsZGR4qWNwt9iYQcXswo17sYd2/z2hauyr0PX0M1
 hM59IzPnoZu+keTY1q5yGXSmSWA/p8R+fqkftqe8bFn5BHEhtIaHLXVD9N77c18+Qw4E
 kkEJJzbJvJY/bR48BrZkC/3jDYXmAIuxtEdGMa2vNBRs2T8ZcvV9TBm3TIDYZpi7ZAmD
 TD0T9ALG2flAN4JMxs7G4klErLmNacSk8NsJHOaip/xFldYc1M9N1scxZw/2k73rYCCR
 /ZKA==
X-Gm-Message-State: AOJu0YymwSV52AtyJGHyV1Y46ROE9CWO5iRRFJ6EEEhk842SrRLrNSWu
 KYEure13/jDsX1L0vBhf/pdPeNmP7U5/b4S+BznRDeBD86f6OqNT93ZtRucWSlp1kzQEJdPU0O5
 oyRthQgU3NfNns6el9ThxzUYd47y4m7B9jzrqzJUDZDLgH358SxR0Sth9ll+BZQ/108d6CYO8i/
 GVBKHFDDnujy7MeHWnhRJ+MK6ypCyn3g==
X-Received: by 2002:a17:907:7d8e:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a7a9424ec2dmr181696066b.9.1721732149194; 
 Tue, 23 Jul 2024 03:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvoju6b5vCAj8EA4VcKDeoobYMsBJMkN8J1IpSVOFJiXrGNM23fEaDWeTucskl12KYa3cCAA==
X-Received: by 2002:a17:907:7d8e:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a7a9424ec2dmr181693266b.9.1721732148637; 
 Tue, 23 Jul 2024 03:55:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c9273a5sm525604566b.165.2024.07.23.03.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:48 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 07/61] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
Message-ID: <75b800dd3bd8042503ddd4e8a4169f34349325e2.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

The spec states that reads/writes should have no effect and a part of
commands should be ignored when the media is disabled, not when the
sanitize command is running.

Introduce cxl_dev_media_disabled() to check if the media is disabled and
replace sanitize_running() with it.

Make sure that the media has been correctly disabled during sanitation
by adding an assert to __toggle_media(). Now, enabling when already
enabled or vice versa results in an assert() failure.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/r/20231222090051.3265307-4-42.hyeyoo@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20240705120643.959422-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 10 +++++-----
 hw/cxl/cxl-mailbox-utils.c  | 29 +++++++++++++++++------------
 hw/mem/cxl_type3.c          |  4 ++--
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b5beb7f90e..42a622197e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -397,16 +397,16 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
+{
+    uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
+}
 static inline bool scan_media_running(CXLCCI *cci)
 {
     return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
 }
 
-static inline bool sanitize_running(CXLCCI *cci)
-{
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
-}
-
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8ae9c6a699..522d9aa589 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2108,6 +2108,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate;
 
     *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
@@ -2128,18 +2129,22 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
-    /* forbid any selected commands while overwriting */
-    if (sanitize_running(cci)) {
-        if (h == cmd_events_get_records ||
-            h == cmd_ccls_get_partition_info ||
-            h == cmd_ccls_set_lsa ||
-            h == cmd_ccls_get_lsa ||
-            h == cmd_logs_get_log ||
-            h == cmd_media_get_poison_list ||
-            h == cmd_media_inject_poison ||
-            h == cmd_media_clear_poison ||
-            h == cmd_sanitize_overwrite) {
-            return CXL_MBOX_MEDIA_DISABLED;
+    /* forbid any selected commands while the media is disabled */
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
+        if (cxl_dev_media_disabled(cxl_dstate)) {
+            if (h == cmd_events_get_records ||
+                h == cmd_ccls_get_partition_info ||
+                h == cmd_ccls_set_lsa ||
+                h == cmd_ccls_get_lsa ||
+                h == cmd_logs_get_log ||
+                h == cmd_media_get_poison_list ||
+                h == cmd_media_inject_poison ||
+                h == cmd_media_clear_poison ||
+                h == cmd_sanitize_overwrite) {
+                return CXL_MBOX_MEDIA_DISABLED;
+            }
         }
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e763b9bff0..c7910687ae 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1142,7 +1142,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1164,7 +1164,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         return MEMTX_OK;
     }
 
-- 
MST


