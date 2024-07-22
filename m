Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F2AC3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjp-0002wu-DE; Sun, 21 Jul 2024 20:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjn-0002pX-Cr
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjl-0005jG-L7
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CF9wnkqMRVtlUyE0ujh6CTNBrHFoLR3JIkaPiCQ6bXA=;
 b=EyLmg3JpxqfuSaFHPmnNbtvwI8C2BXRES4COKC1oi2dhNq51cCgCP34MEwjsRnYNNeBPAP
 jZh4P4Lbrj1pAuSpo/+MphR7iedRw2slooxekOenmOYN/zEX1mgi0cTMPU1cfPfa/o/nZ9
 C8SUNNis6FNS7+q7lteNJz8GtgDJU2Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-avx2uitnPguTYZ8K-9beLw-1; Sun, 21 Jul 2024 20:17:02 -0400
X-MC-Unique: avx2uitnPguTYZ8K-9beLw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42668699453so37761475e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607417; x=1722212217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF9wnkqMRVtlUyE0ujh6CTNBrHFoLR3JIkaPiCQ6bXA=;
 b=JKQhyrJOIfhOiTxzYS+T92DjzKXJ+06LFB3EAtB8ZSGojPAnCYR/k98LNJkCZHANGJ
 YQDWfL6DG3s8GBoV7eFV/DrkL7WJMSN3cny+D+vmr1JkKMSzvXVf17+a9YP3S1e6kcRh
 ZvX7bJ8ZeqCeCrKfoFlu4mDIrClMVo8f7wHofuaSLwqIos3iSiXRhTHfQm1rppWFA4c9
 H5fSASi0dPlLyKwSthCqoJoYqU5QDBz3KNfOT6FFBMvH8jny0KmjPipCoKh0S8XBxZY/
 Z06dU7z+rlPs8+H7V9QvwerADkdWFa950iP+KZtxvt7mjqj2NnnvpzGQ/mhyRpxSGx9n
 x/Bg==
X-Gm-Message-State: AOJu0YxN963PJ+0PO4Zpp2vwMrG6g2mlA845LXH5P/CZYq/Khea0zXmK
 RpLN1qWzcDn7KHOKaLm+CYWB6wpjFOpETSWpoYMcDfXrAwRI0OGZVKLCHYeX3rq+CHRs49kdZds
 xY5q5uoGQAsF3QcwpGNt36zmrogTODzrMI1epv9XRBMFFAX3MVjD5KXxa7Bm5KSTASwF6cHxt39
 os5jGUgZZmhfeD0PCCtOYpEbvg20dkSQ==
X-Received: by 2002:a05:600c:45ce:b0:426:5520:b835 with SMTP id
 5b1f17b1804b1-427dc515ce5mr41304855e9.5.1721607417691; 
 Sun, 21 Jul 2024 17:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ1ZIUina0IxNB8IX3esuxwgnc83668GYDaHHrcjKhXw3xSTXpr1FAcv260bDz6VyoIzp+LQ==
X-Received: by 2002:a05:600c:45ce:b0:426:5520:b835 with SMTP id
 5b1f17b1804b1-427dc515ce5mr41304685e9.5.1721607416990; 
 Sun, 21 Jul 2024 17:16:56 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878811899sm6976742f8f.116.2024.07.21.17.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:16:56 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:16:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 03/63] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox
 output payload space zeroing
Message-ID: <b7dbfe4f47884e67a309c206b3eadec339a0d3b6.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fan Ni <fan.ni@samsung.com>

The whole mailbox output payload space is already zeroed after copying
out the input payload, which happens before processing the specific mailbox
command:
https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/20240221221824.1092966-1-nifan.cxl@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705113956.941732-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 74eeb6fde7..facec42dc8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -235,7 +235,6 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
     log_type = payload_in[0];
 
     pl = (CXLGetEventPayload *)payload_out;
-    memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
                 CXL_EVENT_RECORD_SIZE;
@@ -273,7 +272,6 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
     CXLEventLog *log;
 
     policy = (CXLEventInterruptPolicy *)payload_out;
-    memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     if (log->irq_enabled) {
@@ -372,7 +370,6 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
 
     is_identify = (void *)payload_out;
-    memset(is_identify, 0, sizeof(*is_identify));
     is_identify->pcie_vid = class->vendor_id;
     is_identify->pcie_did = class->device_id;
     if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
@@ -606,7 +603,6 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
 
     bg_op_status = (void *)payload_out;
-    memset(bg_op_status, 0, sizeof(*bg_op_status));
     bg_op_status->status = cci->bg.complete_pct << 1;
     if (cci->bg.runtime > 0) {
         bg_op_status->status |= 1U << 0;
@@ -647,7 +643,6 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     }
 
     fw_info = (void *)payload_out;
-    memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
     fw_info->slot_info = BIT(0) | BIT(3);
@@ -805,7 +800,6 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     }
 
     id = (void *)payload_out;
-    memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
@@ -1095,7 +1089,6 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
     assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 
-    memset(out, 0, out_pl_len);
     QLIST_FOREACH(ent, poison_list, node) {
         uint64_t start, stop;
 
-- 
MST


