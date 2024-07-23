Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58057C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBV-0006sX-Im; Tue, 23 Jul 2024 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDB9-0006nL-Ql
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDB8-0001aM-0f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CF9wnkqMRVtlUyE0ujh6CTNBrHFoLR3JIkaPiCQ6bXA=;
 b=TdwwKqEDKbRfjQ90orl6IXNgOC5zoJfUaFe1157ZINbxbGeb+i8OVbejcXY3De2W4jjPjc
 lpRd+ctFe339iKOtNek9L9EEnY+c4RaPN6n9eTNvP6+4W4M6ehQm/0Xyo++Jpv/pK8hK3s
 N5SnuU9+nfC0+txrYIm6hn0x93FdJcY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-MLtbJdfPPAa60-5_x8A19w-1; Tue, 23 Jul 2024 06:55:30 -0400
X-MC-Unique: MLtbJdfPPAa60-5_x8A19w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52efe4c2372so2703486e87.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732128; x=1722336928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF9wnkqMRVtlUyE0ujh6CTNBrHFoLR3JIkaPiCQ6bXA=;
 b=sp2J7tRPIx3Zb3I+7/BvDWMS/B4C4Rowx9NDLisctulqz129mDtuWdpW+kNrz6ugMk
 rB0CyWUxxTWUwECrMkDtK+lrZGRB71KCnaQmEl2U5w++WgAh8fm0X+0ShW0+gKJZLbWx
 04YHqS7x7kiTFBzpddtInI7GzNglbQ1B5pr4tRegLCOO8DtU4cN9kTbMNtrLnoBAmmjz
 /Ap77iR1JdbZcCDUV2huidPWGOCTMBRgfQdpXi4/XRGrw7KwfZr+EL4YbnTkFK/D8sip
 dKe320//BZRfjfixCrJX3guc4UDqvARMJDsEALhMZ4nA5U10oV4IOqoftWTj0dC9dZRZ
 Qh0A==
X-Gm-Message-State: AOJu0YzgSFu5n0TwyYrPbmjO0nermTjZ180gD98qki0N0yijReAVvBNg
 32+U2VEP44EPuKJbtYRq7EIZsGCDhji4Fo+lIv+jB5gwDDV5QrLfxudYeysjCin+o/zXG4oMub+
 e0MUZ7gUKq9qJq3B99KKTsFfM+oXssmNMKy3n0iMONB0bX1MCOeYHciV9J1xkYsABqkvbKm7G8s
 UNElmFUsIEcSF2tNGaCtUfohQXsE9QYw==
X-Received: by 2002:a05:6512:3984:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52efb7db65bmr6462017e87.44.1721732128466; 
 Tue, 23 Jul 2024 03:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPipkBu7Sx8Ha++7Pa53+7D7zfR7I9vHXYbrNov+mntCi1onf43jttho9KeVffjrBT2SPLCQ==
X-Received: by 2002:a05:6512:3984:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52efb7db65bmr6461982e87.44.1721732127625; 
 Tue, 23 Jul 2024 03:55:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30aaa31e0sm7328912a12.27.2024.07.23.03.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:27 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 03/61] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox
 output payload space zeroing
Message-ID: <b7dbfe4f47884e67a309c206b3eadec339a0d3b6.1721731723.git.mst@redhat.com>
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


