Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26124C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJA-0004w2-2N; Tue, 23 Jul 2024 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ5-0004ht-8F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ3-0007BB-9V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4p0LHYIjMjvQI23Lts1WhjklTNehlg506joAY8S7dI=;
 b=CaBVJ/O7vz7dHl2fyqV0oZdxvmYNiihfLV8LBlIWPiuODI29JVHcdAut0fSMp7h70hua3/
 jXMFHz7zMGb3Otg4VppZNw3oohQaLhDfrj/IHxnu7GDSQ5Bgnlg/EV8oKJjDMZrgzVyQLb
 BjdKNwXsc/PAKlmyIHKG8/hpmv6bKhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-hY3r6ZBOOBixVmgIMmlxPQ-1; Tue, 23 Jul 2024 10:15:53 -0400
X-MC-Unique: hY3r6ZBOOBixVmgIMmlxPQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725ef39e2so40053135e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744151; x=1722348951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4p0LHYIjMjvQI23Lts1WhjklTNehlg506joAY8S7dI=;
 b=LQPBGi4EhNOueGItZdp5yY/izoiM7AfCU4nRkAEebQvDr242LE9P9lLkQ7QHApKXZp
 zOredWaqS9uyyaG32OoVTegBS3yVSSyBhspgm0+qZXBa0QrEOd1CCXWcWguVIP977s2W
 I3sQ3gVHyh3qTtGboMyTlDCvPVVC/mgb5THUYFsKwAxFjMc5R5zIDoY+4tzP3a7Ee88V
 BSQ5HBHBDzo1n13FjcZdnI6cfYVan90MySc5UIthl6e3ZTfbdtl+1jqHH1A/oOaBHdwe
 JCYrlJ6xlebxj2HbBUIjNgAITGlxdcviz+na6fdvBlVBpXZyaNOaQa8L4qkSgKS7xnOt
 SXHA==
X-Gm-Message-State: AOJu0Ywax+GO44AQ6k9wHWyWKuoji7wv1W0iJ/flwXDR8oS6cHlhaUEw
 d46UBg0NOVemTF+AoZk6mgbAAQfcGs6cKSWuijxT2fmrLo1UZAJePT09kEtUhidixIMsrCKKpXK
 Yz3hm+RYQzBZh3z2/7anfmQYYEYk/Nl2Et4xXZHzC83oivMKp3jr2jhvshF48pVX0mlH20mZh//
 lVw5ojHiriJMlQQOG//uXKw93m9bClu6SRzUhv
X-Received: by 2002:a05:600c:3ba4:b0:426:5269:9827 with SMTP id
 5b1f17b1804b1-427dc4817d6mr80725495e9.0.1721744151362; 
 Tue, 23 Jul 2024 07:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbhialiTKcyHphI9IyZmhbdN1v/+4chrKOhhIhHp2VbW4vLCjBk+HZeU4kNXCJS3WXCdoImg==
X-Received: by 2002:a05:600c:3ba4:b0:426:5269:9827 with SMTP id
 5b1f17b1804b1-427dc4817d6mr80725315e9.0.1721744151050; 
 Tue, 23 Jul 2024 07:15:51 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071d0sm178610065e9.26.2024.07.23.07.15.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] hpet: remove unnecessary variable "index"
Date: Tue, 23 Jul 2024 16:15:25 +0200
Message-ID: <20240723141529.551737-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


