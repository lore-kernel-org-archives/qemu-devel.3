Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79837C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIh-0002wE-JP; Fri, 06 Jun 2025 08:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIe-0002v5-Vu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIZ-0005wb-RS
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXS5VDWwj+BpJo5fLFxeSHega56zD1JR/w7S6SSKz+k=;
 b=gHrJ0yU1Z50bIv3UFFuCOjfWYHo9zCPZHa2NB/pUYEK6FvaaG6iRYQ5fvNiLMRP46B1KY5
 wfimF/o/3c8veEISaJBt48Ju4OyIKB5azZwkm3b4xmSWJFho992ECwzruNfejx14qBYN+S
 4MPPRUiLJD1+yBw03jH7GG8U29nPXqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-5jDzXeYbMFWZwTmfK0yOOg-1; Fri, 06 Jun 2025 08:35:48 -0400
X-MC-Unique: 5jDzXeYbMFWZwTmfK0yOOg-1
X-Mimecast-MFC-AGG-ID: 5jDzXeYbMFWZwTmfK0yOOg_1749213347
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a37a0d1005so1432104f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213346; x=1749818146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXS5VDWwj+BpJo5fLFxeSHega56zD1JR/w7S6SSKz+k=;
 b=NDRKOh2Z49GJdeBMrn0FgsV6UKGVZ3XmEX5gZGB51qo+y3RnqWM/jIa32bvehg7Swc
 iocR3OmaPl/f/OgQiRqTJqd1jBMYpnJWAnQ2bG/LmM+iveYQgaHBl7UWqLI1cqe4KIWy
 svPP5g1kHLj1fYPokho0sH1afPPzP9uansJQFoKp9BaXRQ50UqdDSJqF4XDqRZWUf6aB
 kdIxHaOmQjcx2GaDHucHpPsl/n6F0U0/A9BOjzi9oxj+FngFfcJMzKoRNien2lOWk39h
 XJeLKt56Bfo3Vi/k6K/A1lWaQqoY/GUMmXfUiMYy3loU9qam57lyKnOd8GwLY4ACacQf
 H/7Q==
X-Gm-Message-State: AOJu0YwM3kX2cGjP76O2XWkENu5jkHZaIpZPQZhu9xB3+odCcbrZpVOY
 cUVYjhGDFHArNSMQ2NVhr5DGcdU1CKIl8dmsk77p/azwqkoOW2tip/kX6GO8nvxhMHlAa/bPXUO
 XRJtVlhC0YtAGnOBoCe3kfYV8MKb75pzffb7VX/4odPmZVOOtXJ7LcAo4riWY/kuh5xPEAtJ0Eq
 oKnQ1Hdk/5bF22KOYw4a/3nmjiKS37HEJZzDT+4Jks
X-Gm-Gg: ASbGncsnDpGamjt+EdR/dNKGnBEe4eWm1ursapsm+QVe7dO9YhI3XkmdlRV/8gTAvVj
 kNik8n/cnMbiQMyVotXSAI/GOBuzVFmX6ZomDx9EKRgeHprYk4tXOXJj23rnz286iQLpdi1RovI
 RClwRgOC5fVHvo83+ycTYXzUG7mtN9IhlEUywkCqIrd0CNfHGdJ8MLhNBFXCDpRlcblNqp3vGs5
 QwONezLE62dGESy+PExLwOV9hiD60pH86sOEueIaK+PGfKTXMLX/art+qpQsRVFppV1knNIRneI
 0CgD1B9uBDqA9SzqpiEXWPh8
X-Received: by 2002:a05:6000:250e:b0:3a5:2670:e220 with SMTP id
 ffacd0b85a97d-3a531cb01b7mr2696763f8f.32.1749213346246; 
 Fri, 06 Jun 2025 05:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmx9UXbyEE/Lm2PGVfGxFfy+2ui3LU67C/6o/SXEI3mQNyZ1OKh6SgXHzucZW3J2ugAsYNWg==
X-Received: by 2002:a05:6000:250e:b0:3a5:2670:e220 with SMTP id
 ffacd0b85a97d-3a531cb01b7mr2696745f8f.32.1749213345711; 
 Fri, 06 Jun 2025 05:35:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b3992sm1779863f8f.35.2025.06.06.05.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 17/31] futex: Check value after qemu_futex_wait()
Date: Fri,  6 Jun 2025 14:34:31 +0200
Message-ID: <20250606123447.538131-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

futex(2) - Linux manual page
https://man7.org/linux/man-pages/man2/futex.2.html
> Note that a wake-up can also be caused by common futex usage patterns
> in unrelated code that happened to have previously used the futex
> word's memory location (e.g., typical futex-based implementations of
> Pthreads mutexes can cause this under some conditions).  Therefore,
> callers should always conservatively assume that a return value of 0
> can mean a spurious wake-up, and use the futex word's value (i.e.,
> the user-space synchronization scheme) to decide whether to continue
> to block or not.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20250529-event-v5-1-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/futex.h              |  9 +++++++++
 tests/unit/test-aio-multithread.c |  4 +++-
 util/qemu-thread-posix.c          | 24 ++++++++++++------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 91ae88966e1..f5777400533 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
     qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
 }
 
+/*
+ * Note that a wake-up can also be caused by common futex usage patterns in
+ * unrelated code that happened to have previously used the futex word's
+ * memory location (e.g., typical futex-based implementations of Pthreads
+ * mutexes can cause this under some conditions).  Therefore, callers should
+ * always conservatively assume that it is a spurious wake-up, and use the futex
+ * word's value (i.e., the user-space synchronization scheme) to decide whether
+ * to continue to block or not.
+ */
 static inline void qemu_futex_wait(void *f, unsigned val)
 {
     while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 08d4570ccb1..8c2e41545a2 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -305,7 +305,9 @@ static void mcs_mutex_lock(void)
     prev = qatomic_xchg(&mutex_head, id);
     if (prev != -1) {
         qatomic_set(&nodes[prev].next, id);
-        qemu_futex_wait(&nodes[id].locked, 1);
+        while (qatomic_read(&nodes[id].locked) == 1) {
+            qemu_futex_wait(&nodes[id].locked, 1);
+        }
     }
 }
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b2e26e21205..f81fca5c116 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -428,17 +428,17 @@ void qemu_event_wait(QemuEvent *ev)
 
     assert(ev->initialized);
 
-    /*
-     * qemu_event_wait must synchronize with qemu_event_set even if it does
-     * not go down the slow path, so this load-acquire is needed that
-     * synchronizes with the first memory barrier in qemu_event_set().
-     *
-     * If we do go down the slow path, there is no requirement at all: we
-     * might miss a qemu_event_set() here but ultimately the memory barrier in
-     * qemu_futex_wait() will ensure the check is done correctly.
-     */
-    value = qatomic_load_acquire(&ev->value);
-    if (value != EV_SET) {
+    while (true) {
+        /*
+         * qemu_event_wait must synchronize with qemu_event_set even if it does
+         * not go down the slow path, so this load-acquire is needed that
+         * synchronizes with the first memory barrier in qemu_event_set().
+         */
+        value = qatomic_load_acquire(&ev->value);
+        if (value == EV_SET) {
+            break;
+        }
+
         if (value == EV_FREE) {
             /*
              * Leave the event reset and tell qemu_event_set that there are
@@ -452,7 +452,7 @@ void qemu_event_wait(QemuEvent *ev)
              * like the load above.
              */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
-                return;
+                break;
             }
         }
 
-- 
2.49.0


