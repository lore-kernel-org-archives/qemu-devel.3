Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC92C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 22:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuvM-0006LG-Tj; Wed, 21 Feb 2024 17:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcuvL-0006Kc-6k
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:18:43 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcuvJ-00052O-DD
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:18:42 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e4670921a4so2569885b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708553920; x=1709158720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3eOoPoBtiVXDT6AV5oY9oRUy6gnV0e2NQmiQBMRCPgQ=;
 b=CMffqOAetoghoFLva0S5YmV0XXqWZp9kwMc1eeXLpcQKhOi3XMPCP5wi+1C+aNXEpB
 NGn0wa9HmIdP32yW9qR2R6wbWIE3Viax61AuBrnxlrCylyCQdYqMCCnJ0VZSPYJh5XpQ
 IObRmWYm7/+a0gtd5+O6dhM2yd3nyPNsbA7gMbYnVhQYdu5uQekf7J4QfNcG17P6m0ux
 atXJVBtAIdSbTLCFTHBv+bTv/yoh/7z0u2QH6fe/52QdX0jc9N06M0TCtcE9neUTs3Ft
 8K54tN75w7P2f1CirOOZGsYPUvTg1GATvxYcwEXFtO7ohM+cuB3HEqMk91wyKr/7PLdd
 7wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708553920; x=1709158720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3eOoPoBtiVXDT6AV5oY9oRUy6gnV0e2NQmiQBMRCPgQ=;
 b=jB9XRApjRHuS4mkEZ/oPb429oTCbpEHtuB93TWpUaouoc3+bBRHrB/Y/flVrX/x4tH
 8qK+BpzQEsfYSSON091xYXzbGfVQgDv6LEH0cv14R+RDj3YlOsw/E+pm8DnA5A9nDCv2
 Y+QvkdgbxdZTyOgcKR7AK9Lcz+LzSwSFYh9EwndiVuQdjGVlAJd2ymt1lHmWQdpfMabr
 msHeQPetSxtm7XNl6Ehg1C4ZDXA20b/Woc7QAnP/dFUMDeWO7WPHfN8XGZeg42jVWMoX
 PFCoLGytvfhn5SfO4khwpeUAsmMYH3Dr46zVDcDSnF5QnkwOhwBH9CRe25Je0xD5v/7n
 6VTQ==
X-Gm-Message-State: AOJu0YxEs//BTNUdsk9cT3AEVnTp0UJtl6S+rSVnkCT7gFB/g5Vyd8VI
 lsD8aA5OzQ++xs2ISFE/HXXBK+ctikjtM1Vzoethu5hwDcEvZZGMuljZBsFe
X-Google-Smtp-Source: AGHT+IFsr8K1nO/2YAfQgcGS4KCkKl0rtcFgGDEJYzvTIO3VbMJ8KMSGzsH6Rz4SfpK0xt8N3ycTIg==
X-Received: by 2002:a05:6a20:55a1:b0:19e:9966:228d with SMTP id
 kk33-20020a056a2055a100b0019e9966228dmr16525661pzb.20.1708553919772; 
 Wed, 21 Feb 2024 14:18:39 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:11c8:8961:5acd:73dd])
 by smtp.gmail.com with ESMTPSA id
 x22-20020a056a000bd600b006e47664b05dsm4635952pfu.212.2024.02.21.14.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 14:18:39 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v2] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output
 payload space zeroing
Date: Wed, 21 Feb 2024 14:18:11 -0800
Message-ID: <20240221221824.1092966-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 hw/cxl/cxl-mailbox-utils.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e5eb97cb91..fda88470a3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -226,7 +226,6 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
     log_type = payload_in[0];
 
     pl = (CXLGetEventPayload *)payload_out;
-    memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
                 CXL_EVENT_RECORD_SIZE;
@@ -264,7 +263,6 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
     CXLEventLog *log;
 
     policy = (CXLEventInterruptPolicy *)payload_out;
-    memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     if (log->irq_enabled) {
@@ -363,7 +361,6 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
 
     is_identify = (void *)payload_out;
-    memset(is_identify, 0, sizeof(*is_identify));
     is_identify->pcie_vid = class->vendor_id;
     is_identify->pcie_did = class->device_id;
     if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
@@ -597,7 +594,6 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
 
     bg_op_status = (void *)payload_out;
-    memset(bg_op_status, 0, sizeof(*bg_op_status));
     bg_op_status->status = cci->bg.complete_pct << 1;
     if (cci->bg.runtime > 0) {
         bg_op_status->status |= 1U << 0;
@@ -636,7 +632,6 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     }
 
     fw_info = (void *)payload_out;
-    memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
     fw_info->slot_info = BIT(0) | BIT(3);
@@ -792,7 +787,6 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     }
 
     id = (void *)payload_out;
-    memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
@@ -1079,7 +1073,6 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
     assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 
-    memset(out, 0, out_pl_len);
     QLIST_FOREACH(ent, poison_list, node) {
         uint64_t start, stop;
 
-- 
2.43.0


