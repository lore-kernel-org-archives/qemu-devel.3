Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37485C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrkI-0005Fz-7y; Wed, 21 Feb 2024 13:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrkG-0005E1-4F
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:55:04 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrkC-0000Ip-PH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:55:03 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc418fa351so562395ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708541699; x=1709146499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mdlWEtI5Vo8QjSOvRxAX8c9GZTRWD5Fjvx9DwxqT0Xw=;
 b=E3LtdgSIZJotjhGuGiHGGMKzLTlaIinyI0wlMXM+kiGGRlLaF8Ky8OvFx30H3vugE+
 G2fzh9SGaf7ZwXD9gWSvtGnCD3oT9Hd4yjTwkHPIuB+9zU43WQM42RXIXFkk+u5nwG/f
 Q3vUVUY2oYxHDEGnarUwGY80K95ZIGi6bcGeIpSDAz+YoPOUuL8eLLIwmtow9Ra/tLl6
 gowXn/tE9wIfC2Y4Hv0TYCrzSIAALeHvAD1ac0MSuutbCIGEa2JS3QkHqvTNbaN8zCu/
 BUM+wr9hwdR+IRp8ewVealfQXHUJ+qNRMmMgz1lkvJ6ftLT3DRFe3da7QQPKrTqgwMcB
 6DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708541699; x=1709146499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdlWEtI5Vo8QjSOvRxAX8c9GZTRWD5Fjvx9DwxqT0Xw=;
 b=clVAmLeKYCvhFhxLg8AqUkIvwnVkpkoaUUgCJTmcGhr59UpjEQXbms1ElAICgnX8Ev
 treHDCL6Lt5uXrnlT3WTAlFCea29UoF5fYR8IWUFZU8QskYGUkq7gLXc21k+ZAhV3UXN
 qz7YhgnFyRXPVpv3gCsv/OZJcAQ3Z+MMj91ScFvTdUbFXFi1XpP6JBVV/Uc/7dMgfatC
 Ft1Izdkt2QJ5AhO6DgRNM3xQ6gX3hJ7rkwc3TKvx1ZRyyn7h9+S7ppERD+lFWQcdKabC
 Iy+tSxeWBAQmVd0Fqw6YFIiwCEc64KR8JEdYAR1Rpl9b1ZBsq/5PtAwzWN1mFjtAr41D
 iHpQ==
X-Gm-Message-State: AOJu0YxGCeVyUPZPtPBLcWEBlfmnSOmBQa9WUYK6DNAwBLX/QpPuhGJX
 MyeguncYGa0/xyIWNZdTqwkzkmhj/on669oKR1bmeW8DwzDkzKFSC5C0StJS
X-Google-Smtp-Source: AGHT+IE4uqkW4IzNcbVuOJMPESHpvT1GgDJD3hZbePuXMQUvw4Z988HiVxBxNo6qFAZnG3PW7zJ3qw==
X-Received: by 2002:a17:902:c40b:b0:1d9:5563:431 with SMTP id
 k11-20020a170902c40b00b001d955630431mr518335plk.7.1708541698755; 
 Wed, 21 Feb 2024 10:54:58 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a170902d50f00b001db4b3769f6sm8330277plg.280.2024.02.21.10.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:54:58 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output
 payload space zeroing
Date: Wed, 21 Feb 2024 10:53:44 -0800
Message-ID: <20240221185425.1088766-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62d.google.com
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
https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204

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


