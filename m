Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8062C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdpP-0003R2-JS; Fri, 17 Jul 2026 04:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdpJ-0003IN-SJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:21:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdpH-0000mc-Qv
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:21:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so14578f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276502; x=1784881302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7xK6PxWlvhFesfNR+/xfjx+pRhFzHlVG2WY97KRsBBM=;
 b=QqE3VMT99FbqL8Zxu6O3PBSMWoJ2aioC4WA/Kw/GfV8TPYxiVuYIyWRt2+7RKwkk+S
 0Mw5aoeq/+gq/2DFmOLAVwJ1S5FKQorfzM+Qlm8GzcKQh2XCpUcooZNGtTugK6v90Rwt
 QVccD1fmZBHiYAnpEKN34A8KjsrRThhAQPKLC2nFVLBp4QNOHCfjxFnoGaLofepxKjQH
 uhDfvxGwjtNa1thY4cUIArAHeKtK3seW5E3aqFSzXbqf/zUSDzw2y1xms9shjjvgERTO
 eD6mjS6E0MptwYRmOQyelBoepdXANcD0OK/lwY6QbqslReBzQpUnde+emOcfJUKju7di
 hFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276502; x=1784881302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7xK6PxWlvhFesfNR+/xfjx+pRhFzHlVG2WY97KRsBBM=;
 b=ZgT9TlFaoHSkBaJS30t1npSvzrGruruENBd/1hpGtuP2ordGNvf3k/s6cHXlQoAIvL
 z723mNF7FLsU3UEs3n0yAEvji8rh9CG1BVulbWgheZq6Jkd9Bif7Td8ZiSkA2jL90Rnn
 1TuIvKN3pvXAE5cm3XaVw+80DGboyPWsi1teJzP//VX1VOxmxsVap9UziVogUeDtOZk6
 7QfJmldscbcFcgYIf7XkQu2yOZPCxtF1jqhzvI9fWSYLRB261eylU0D8t1qKXLt0QAdD
 KtljUXyChx7g369YoIrJ/jZnTWsE2S77LHlAx7mEQTIx5XpVVRwN+sDu0RKMUnunKX80
 AIwQ==
X-Gm-Message-State: AOJu0YxKgIbxF8HWg0PwmF+qQMo0RbWuPN+UQr2KMWkXQo0rfxWZBMF0
 djFm1pKeIhpxeAIrQJpEbvMBu6kZZMdDIMPDM3NzbbG6ahzUyWK9jljMIl7X/lBqKkU=
X-Gm-Gg: AfdE7ckZvnQUUMzvgZubXRScI8Uxd5X7m7JK/ooDlk4XS/+22mR5m+7pAhl9Kt9DSbn
 f2MDfcDpSxtIqUT4aKR1cDd22qU1uJYiS0j9GbdAeuIZnlNiXTtMySzbaY3IyJwXE49jFP4quec
 6MxD0UtoAj7tzWVWUpQb1j/omUnPVDOfXKK/p6fuZR9TJ3Ly0u5pQm/yxTXjHCS9sCNQr3Dgw8Q
 MyKAjBIYpG7FiTNLfLT5gn5uRD3xDmDDCPOStHVWdD2T4GIZVxPkrXAcp6jH12Yahy2ns0kbfSt
 RR8Vz7qt/mNaqcjFjedd+ZsUJ6jYd+vV8Bi06iUghE76scocj+5ujxp4FSVqm+/OxwqNkIh1KP7
 S3Z0o0e54u6qDThEJ9nSMwZmqEI2f67JhDwIbc3XJq7lWnmVVPdMvttaXv1ELWYjkZBkfj/aYCW
 WtyMvTHgucbQZDKSySQQVfsPxqcvi4MA1OhLCY4uhLVyvaXwL7QyPD9FBVUi8A+thmzuQ2/XvMY
 OPkcb9BmkDjfk3t+DpUymeWbYIfvJl/SJAfepq39qjPqMixRZ0=
X-Received: by 2002:a05:6000:2c03:b0:473:975c:4fd1 with SMTP id
 ffacd0b85a97d-47f62314f83mr2059112f8f.25.1784276502053; 
 Fri, 17 Jul 2026 01:21:42 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edd7d3sm1622587f8f.25.2026.07.17.01.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:21:41 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 1/2] hw/core/machine: add a fallback default machine
Date: Fri, 17 Jul 2026 08:20:21 +0000
Message-ID: <20260717082122.2439916-2-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717082122.2439916-1-rohit.kuma1313@gmail.com>
References: <20260717082122.2439916-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rohitashv Kumar <roohiit@amazon.de>

find_default_machine() returns the single machine whose class sets
is_default. When QEMU is built with that machine compiled out there is
no default at all, and starting QEMU without -machine fails with
"No machine specified, and there is no default".

Add an is_default_fallback flag to MachineClass. When no is_default
machine is present, find_default_machine() returns the machine that
advertises itself as the fallback default. This changes nothing when
the primary default machine is built in: the is_default machine always
wins.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 include/hw/core/boards.h | 1 +
 system/vl.c              | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 29c68931..36c72e0c 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -294,6 +294,7 @@ struct MachineClass {
         pci_allow_0_address:1;
     bool auto_create_sdcard;
     bool is_default;
+    bool is_default_fallback;
     const char *default_machine_opts;
     const char *default_boot_order;
     const char *default_display;
diff --git a/system/vl.c b/system/vl.c
index 061cbdf8..b1123fe2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -862,6 +862,7 @@ static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
     MachineClass *default_machineclass = NULL;
+    MachineClass *fallback_machineclass = NULL;
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
@@ -869,10 +870,14 @@ static MachineClass *find_default_machine(GSList *machines)
         if (mc->is_default) {
             assert(default_machineclass == NULL && "Multiple default machines");
             default_machineclass = mc;
+        } else if (mc->is_default_fallback) {
+            assert(fallback_machineclass == NULL &&
+                   "Multiple fallback default machines");
+            fallback_machineclass = mc;
         }
     }
 
-    return default_machineclass;
+    return default_machineclass ? default_machineclass : fallback_machineclass;
 }
 
 static void version(void)
-- 
2.47.3


