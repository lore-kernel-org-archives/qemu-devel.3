Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683FAC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrnv-0008SY-Nw; Mon, 22 Jul 2024 08:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrni-0007bS-8C
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnf-0007uz-OX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4p0LHYIjMjvQI23Lts1WhjklTNehlg506joAY8S7dI=;
 b=TF9ibDQWjTxLPmKwH5EmfzaSQRYOmkVrMF5b4bYHtoMswarS/+2b5oNhImLZlnORR70uxn
 reEzPgnjrrzIGSjVTBL2HUXYXljkXjGBBypvwjsUKpf02jXWtGHHybSWbWhp4908rffHaU
 V4IW1Yv/Yc7F7j4l+OGYaGfEUlgA/J4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-rDP7vz5mNkKgKUX41xw1KQ-1; Mon, 22 Jul 2024 08:05:51 -0400
X-MC-Unique: rDP7vz5mNkKgKUX41xw1KQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77e59a53c4so339886266b.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649950; x=1722254750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4p0LHYIjMjvQI23Lts1WhjklTNehlg506joAY8S7dI=;
 b=qw2xISquWwvnVz7P6G7XSNBuFfS4oe0DRBa3GQvDOwXWnQT6t6H5xgt/rKp9+R7DEZ
 uP9bRfOcoshXTMpH2SeA3r17NrY5qwsN89NNI9EXCS/Hg5xsqDQl6cIpzxyx5van9r6L
 G2ibeOmtBkDp1aI+q5vZUgRciSCVMlr6nRwewcN6/hlqHHRdnyE7S32NfJ5NPBti0Qi5
 YLL8qX0Mqjm1RbW3tttmzNfXcsu63CwYx0NN/mACMOWGHzVwiyKxwq5Ljqiw0wn5b/AF
 WK3A+g1ByHdZqQgsXNl2hdrwOwg+KNI2TIFvsfTTcompaiUZYfUkx4GoNK5uHeviQhh2
 a5VA==
X-Gm-Message-State: AOJu0YyQ6dxsxQNd4+Z9HU6Eg0R+hUx19duLD2y95d2xZn6MPcc87v0Q
 4nJQN5bZCjqfrwl45wMYeKptPCShn8kWD8NRxAOlboHCFM6Ca9CcC9Wb4lUclsyWJvzzHAiHwBH
 4kUoomXtirORHE1P5MI11TY4oUUMnCnzyfauRvIB3y1fnzK2rq18vwbH6eeEQ68eGBe3HSpp3MR
 sg8aoHXHM7Ym5SOv6621DThc1q28f9Yptafory
X-Received: by 2002:a17:907:3e1a:b0:a75:23bb:6087 with SMTP id
 a640c23a62f3a-a7a4c016cafmr472537566b.29.1721649949867; 
 Mon, 22 Jul 2024 05:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL9DpPt69DCrN4oscH9ziF6uIM8tcAlf8QWRNxtUJbIWNMpmLv23fuEI7m5SAgEAyUWDNzjg==
X-Received: by 2002:a17:907:3e1a:b0:a75:23bb:6087 with SMTP id
 a640c23a62f3a-a7a4c016cafmr472535766b.29.1721649949508; 
 Mon, 22 Jul 2024 05:05:49 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c8bf32esm414269566b.134.2024.07.22.05.05.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hpet: remove unnecessary variable "index"
Date: Mon, 22 Jul 2024 14:05:37 +0200
Message-ID: <20240722120541.70790-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722120541.70790-1-pbonzini@redhat.com>
References: <20240722120541.70790-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index bbb1e5f0897..380e272fbeb 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -437,12 +437,12 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
     HPETState *s = opaque;
-    uint64_t cur_tick, index;
+    uint64_t cur_tick;
 
     trace_hpet_ram_read(addr);
-    index = addr;
+
     /*address range of all TN regs*/
-    if (index >= 0x100 && index <= 0x3ff) {
+    if (addr >= 0x100 && addr <= 0x3ff) {
         uint8_t timer_id = (addr - 0x100) / 0x20;
         HPETTimer *timer = &s->timer[timer_id];
 
@@ -469,7 +469,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             break;
         }
     } else {
-        switch (index) {
+        switch (addr) {
         case HPET_ID:
             return s->capability;
         case HPET_PERIOD:
@@ -510,15 +510,14 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
 {
     int i;
     HPETState *s = opaque;
-    uint64_t old_val, new_val, val, index;
+    uint64_t old_val, new_val, val;
 
     trace_hpet_ram_write(addr, value);
-    index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
 
     /*address range of all TN regs*/
-    if (index >= 0x100 && index <= 0x3ff) {
+    if (addr >= 0x100 && addr <= 0x3ff) {
         uint8_t timer_id = (addr - 0x100) / 0x20;
         HPETTimer *timer = &s->timer[timer_id];
 
@@ -620,7 +619,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         }
         return;
     } else {
-        switch (index) {
+        switch (addr) {
         case HPET_ID:
             return;
         case HPET_CFG:
-- 
2.45.2


