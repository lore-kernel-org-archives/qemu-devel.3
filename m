Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9265CC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIk-0002wm-MW; Fri, 06 Jun 2025 08:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIi-0002wT-Sq
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIg-0005xF-10
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OEZAydAtRep2cd2MJ/5ePwBqgR/AFd6bAV53Md7KlE=;
 b=RJpc5khCG67meZeWF7C2jgyvS1W4shZNRYfmVJ3jXSIVSu1ZA+91Y/dY7G1M9E1rT3PybJ
 mIfwbGdbs9COixNKjCWkWVEjioBtB3i/ByPIaSLSdcmvxDZaiZpqoxjV8mKJmUiFyaFzg2
 fvBH1wwcB0LFf9f68BE9Eo72tcZzn18=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-M90O1GilOzei4jPglm4LSA-1; Fri, 06 Jun 2025 08:35:54 -0400
X-MC-Unique: M90O1GilOzei4jPglm4LSA-1
X-Mimecast-MFC-AGG-ID: M90O1GilOzei4jPglm4LSA_1749213353
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5232c6ae8so947141f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213352; x=1749818152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OEZAydAtRep2cd2MJ/5ePwBqgR/AFd6bAV53Md7KlE=;
 b=JzHgVzdOtstc3tcSRQt41XcpKgA7DO0SXhwnB7LjBJi/tyAsIEKS/zuSMHZenqMat7
 K6aS4Ojl+6KAHD0amL+9rI7KjZHGorfgDSiIrikNcPgHjAyBPn5pWuBDSzEH6uU22V6E
 ffENwbJWC9LyPrELdRWqclcSSV0M1A7eWfBa3GTFnnonXfgX8JHA85oIIM3D9P2cBgfn
 jKJSTDoveSvGklw1HLZPS6DPeQC+49+wH+WqboT8YqE5M5YsD6tHKctCc9p/Ws4113vv
 NTlOcNb7Dvinok23V22P2z3Vfzt2wtrv7PibhmQBw+aOCK4ebjE2fIucA4y6xfl9Mlns
 YpXQ==
X-Gm-Message-State: AOJu0Yxn4JFQ8mqePU5ORJ4BuW/Xie9rqc3vcTLIz4pxYH0VRtQ+noz2
 Ber1jDwgyIvdfYaQs/4VDePKqxd6jfI5eLtjmfqqy55WmSB5D9pKW4YWFsuDC86erIoJEGIG6hz
 ihcPRDBmwWQAfT5IkhF5FpDcQ7LNkzzCWfA6Qxm5idxUy5aq/nuYTRov2qUrlw2jYngwmyH3lqc
 Ugts48FH+HcYii/lZP1JIOsypv693fBwlFIwk45ZCq
X-Gm-Gg: ASbGncu7IqXdVovem1kCzCPMpnNIW8Tp2hit6G1/Gd008tbkEcR7i7O0i7DwGASZ8oY
 nIgeAG5g/U+cYbiH0HwVTc0xBUU+Mry5wpUHTR8d5qLNw9uWpKmFSgMmciRL3RBCHMsmkB+QLr5
 4+c8BUHcP7692wK0wB+3mrL41swaR55NWDwRnbF1P7APfFqOkLcqswZWyMGAJ5j1EeNsq7VqcMJ
 YgQyDOXgQ/hrLIT81GIMgHlAeQPtd71Iuk+eR7t+oWzuEVJk4TUV5LFco1rR4+mVkIs/i9KpHH2
 cXYdhyqcqX5N7w==
X-Received: by 2002:a05:6000:144d:b0:3a5:2cb5:642f with SMTP id
 ffacd0b85a97d-3a531cc57c7mr2489627f8f.34.1749213352553; 
 Fri, 06 Jun 2025 05:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEncvU5eNL0Qd2kT73rlpC6AZwp9V6xG9K+/xERZNJt3eqKLqGPgp8xyRnu6x+m2GQVRhDEWw==
X-Received: by 2002:a05:6000:144d:b0:3a5:2cb5:642f with SMTP id
 ffacd0b85a97d-3a531cc57c7mr2489609f8f.34.1749213352121; 
 Fri, 06 Jun 2025 05:35:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137277afsm22840465e9.30.2025.06.06.05.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/31] qemu-thread: Replace __linux__ with CONFIG_LINUX
Date: Fri,  6 Jun 2025 14:34:33 +0200
Message-ID: <20250606123447.538131-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

scripts/checkpatch.pl warns for __linux__ saying "architecture specific
defines should be avoided".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250526-event-v4-4-5b784cc8e1de@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread-posix.h | 2 +-
 util/qemu-thread-posix.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index 5f2f3d1386b..c412623a914 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -33,7 +33,7 @@ struct QemuSemaphore {
 };
 
 struct QemuEvent {
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_t lock;
     pthread_cond_t cond;
 #endif
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index f80f564e762..3dc4d30052e 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -317,7 +317,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
     qemu_mutex_unlock(&sem->mutex);
 }
 
-#ifdef __linux__
+#ifdef CONFIG_LINUX
 #include "qemu/futex.h"
 #else
 static inline void qemu_futex_wake(QemuEvent *ev, int n)
@@ -363,7 +363,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 
 void qemu_event_init(QemuEvent *ev, bool init)
 {
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_init(&ev->lock, NULL);
     pthread_cond_init(&ev->cond, NULL);
 #endif
@@ -376,7 +376,7 @@ void qemu_event_destroy(QemuEvent *ev)
 {
     assert(ev->initialized);
     ev->initialized = false;
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_destroy(&ev->lock);
     pthread_cond_destroy(&ev->cond);
 #endif
-- 
2.49.0


