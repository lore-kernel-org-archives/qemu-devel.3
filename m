Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA682C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZQ-0006fA-Ks; Thu, 23 May 2024 13:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYh-0005wW-G1
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYX-0003eD-Jb
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:48:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f332511457so6149485ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486521; x=1717091321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwLDZR/KWKZ72BeL4YQ5O0fvqFWZ5B2YkSZHDV4y31s=;
 b=fHyD3oq9KCLKeOoulFDLaWa5FKUJupCINkJvj4qugOdy+GEIDjIU/sC8c6KfVe1JLd
 rCm6FDKtL3h5pStULNofsKAiLxL3G8dCqJF+X7SnRRpDT4OIKo9ycuIdgwb3lyP5hBpT
 SU36y1GOsT/CNFArh00+eDYdjpu7AuWlZE+h8TvRdwF9U9/C76w34hR6S4wToECIs47i
 M2xIZsilJf1bMP7wGYwXnx6640p2NVswgc/C9EaPYQOXEAkgwI7M/cZAueJY5UeRZVSu
 G2YuLyM62Uue/IKMZc2l1QpT0a/1I9DXJKkgxS2emrx/iQg6mr75bsQ0L0kntdT6podO
 xDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486521; x=1717091321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwLDZR/KWKZ72BeL4YQ5O0fvqFWZ5B2YkSZHDV4y31s=;
 b=j2sd6N9yLWQv7yd2wbzHsa3PYxzsOBXmK3E8qGBt035KELQ1TVLu1pe4tKlq+leroz
 NDy/fWxSKwbr1a5pUeaE/QdPEWlLoGK/Xy0tP8q3tr79PO5IICM34vQYsHXe8yJw5+9n
 cFKCECbZ63iXdm40F0RcrOdHRB/NawkviLDkR0UEQyA+eVbOvMK/hmvUq8YnRgBfwoJq
 l1VwrNMFe89UHcJPDfX3mCaHhEAPFSLTqxbeiB2YyUwgjlAxI/a8vtRkKoTO4g7xiWC5
 UQPHCFGYwR3dfX3H2ygjb5gW168imvOL81f6BB4qnfS9ZlDl9v7nN5OxFuRbIODWbDvc
 udwA==
X-Gm-Message-State: AOJu0YwaXsQD0wOMl7/FnRA4OGkhjsqgJ/uWn+59QAwDgKEhE45ffuhi
 V/QMNZQhksfkDllWKZuhlHwF8G1ee8jxtn2zH4Q6a+UfLuySMPWn/VEfcg==
X-Google-Smtp-Source: AGHT+IGMzDozcFp7jk5pIqT2r+oB433amL8mIwl7y+Q6sXnIRKqq4W15tY3TetnNKZWNSELBHrLsYQ==
X-Received: by 2002:a17:903:1c8:b0:1f3:61c:30a2 with SMTP id
 d9443c01a7336-1f4486d4ffamr418345ad.2.1716486520814; 
 Thu, 23 May 2024 10:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:48:40 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com,
 Gregory Price <gourry.memverge@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v8 02/14] hw/cxl/mailbox: interface to add CCI commands to an
 existing CCI
Date: Thu, 23 May 2024 10:44:42 -0700
Message-ID: <20240523174651.1089554-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gregory Price <gourry.memverge@gmail.com>

This enables wrapper devices to customize the base device's CCI
(for example, with custom commands outside the specification)
without the need to change the base device.

The also enabled the base device to dispatch those commands without
requiring additional driver support.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>

--
Heavily edited by Jonathan Cameron to increase code reuse
---
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++--
 include/hw/cxl/cxl_device.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2c9f50f0f9..4bcd727f4c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1424,9 +1424,9 @@ static void bg_timercb(void *opaque)
     }
 }
 
-void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+static void cxl_rebuild_cel(CXLCCI *cci)
 {
-    cci->payload_max = payload_max;
+    cci->cel_size = 0; /* Reset for a fresh build */
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cci->cxl_cmd_set[set][cmd].handler) {
@@ -1440,6 +1440,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
             }
         }
     }
+}
+
+void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+{
+    cci->payload_max = payload_max;
+    cxl_rebuild_cel(cci);
+
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
     cci->bg.runtime = 0;
@@ -1458,6 +1465,14 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
     }
 }
 
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                                 size_t payload_max)
+{
+    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
+    cxl_rebuild_cel(cci);
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ccc4611875..a5f8e25020 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -301,6 +301,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                          size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
-- 
2.43.0


