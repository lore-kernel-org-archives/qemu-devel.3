Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91218C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrny-0000LJ-QC; Mon, 22 Jul 2024 08:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnj-0007hU-Np
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrng-0007v6-8i
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SH5zwolTSCtrBQQLhcJsS5itYtwTMNlK41Ys5KgMIiY=;
 b=b3cj+rgx9wUcA2ef32h38nK0ZUkTjzLBEtn0F0f3ZkxiYWs3ihKUy1luTmyvRVVOlsf3+h
 4012hsOsi7faB7Vn6mjFB3M4pBYMquvUBxrNmyaNnwxIP0GOLBnzjDh2kAdTq5X+fdVizK
 RIEzh/ui7sfQiO7Fk7WjSMM/S3HJXu4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-o99HMqfeMZm0XJrUdc83Mw-1; Mon, 22 Jul 2024 08:05:54 -0400
X-MC-Unique: o99HMqfeMZm0XJrUdc83Mw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77e024eaa4so357554666b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649952; x=1722254752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SH5zwolTSCtrBQQLhcJsS5itYtwTMNlK41Ys5KgMIiY=;
 b=fGde4rO/9Xin9j8fx7JM0RJHfU/JjgTY6+6c4qf0bDWJ6Vf2GMhce24Fods5LBo+CL
 GsloUl9ArH05dFoMb3iRes+yZ8UMVsGvpexf9mEq2HYICqMeIHuue2/XpRyzQllC9a0k
 aqBubtEgdXVpXMxp+sZjEW4HtG1wIzr+pMvyCM1dF0+3vwRKCewjtAv9kfwMxvsAxxQW
 hWcgrsBYpe/yBumZE9saBKha1K65qM7x27cgSFsmoIoJCmD7YDk7tLuxFdP+FfT/GDr+
 9qwSzOp6OL/xpIGmMA9Jyw6/DUgHUSnh/xXiPLDZyCJJA7KIlllrA96KR0u2Jz4CSQ5e
 ipKA==
X-Gm-Message-State: AOJu0YzRKgEjzxB9QKJaAUr45LUSftNUgX34aarxOlJSP0c3UFw6Dxlt
 4v4iwYyu298kdh4jB5p/fFaGdnqYvm1A8QIgw1WzZMjq4APSP4l3WXzQYVKtj2MYLdZR4KnmiTG
 MbSc6Lh21bmnChPXtHVdbZW8s1xlKlgvKoDUCn6ETDb2poP6F9QaZ14CoLRZLwtt020/TvLH6YQ
 14fjxJyPv7CVpQKtj1Nff59uOaq95pM51Y3Sq6
X-Received: by 2002:a17:907:2d94:b0:a72:84c9:cedc with SMTP id
 a640c23a62f3a-a7a01115d81mr1346834366b.8.1721649952491; 
 Mon, 22 Jul 2024 05:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVepP+xxO5pGcHlPO+wKcXAjNJ4FPyvbSy3siSoBPH/qkVtasWjrzo0eqA/o1biA4AQ2t1vQ==
X-Received: by 2002:a17:907:2d94:b0:a72:84c9:cedc with SMTP id
 a640c23a62f3a-a7a01115d81mr1346833166b.8.1721649952009; 
 Mon, 22 Jul 2024 05:05:52 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c91e2e8sm415014066b.156.2024.07.22.05.05.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hpet: place read-only bits directly in "new_val"
Date: Mon, 22 Jul 2024 14:05:38 +0200
Message-ID: <20240722120541.70790-5-pbonzini@redhat.com>
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

The variable "val" is used for two different purposes.  As an intermediate
value when writing configuration registers, and to store the cleared bits
when writing ISR.

Use "new_val" for the former, and rename the variable so that it is clearer
for the latter case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 380e272fbeb..831e5a95b09 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -510,7 +510,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
 {
     int i;
     HPETState *s = opaque;
-    uint64_t old_val, new_val, val;
+    uint64_t old_val, new_val, cleared;
 
     trace_hpet_ram_write(addr, value);
     old_val = hpet_ram_read(opaque, addr, 4);
@@ -536,13 +536,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  */
                 update_irq(timer, 0);
             }
-            val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
-            timer->config = (timer->config & 0xffffffff00000000ULL) | val;
+            new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
+            timer->config = (timer->config & 0xffffffff00000000ULL) | new_val;
             if (activating_bit(old_val, new_val, HPET_TN_ENABLE)
                 && (s->isr & (1 << timer_id))) {
                 update_irq(timer, 1);
             }
-
             if (new_val & HPET_TN_32BIT) {
                 timer->cmp = (uint32_t)timer->cmp;
                 timer->period = (uint32_t)timer->period;
@@ -623,8 +622,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         case HPET_ID:
             return;
         case HPET_CFG:
-            val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-            s->config = (s->config & 0xffffffff00000000ULL) | val;
+            new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+            s->config = (s->config & 0xffffffff00000000ULL) | new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
                 s->hpet_offset =
@@ -658,9 +657,9 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             trace_hpet_invalid_hpet_cfg(4);
             break;
         case HPET_STATUS:
-            val = new_val & s->isr;
+            cleared = new_val & s->isr;
             for (i = 0; i < s->num_timers; i++) {
-                if (val & (1 << i)) {
+                if (cleared & (1 << i)) {
                     update_irq(&s->timer[i], 0);
                 }
             }
-- 
2.45.2


