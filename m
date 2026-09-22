Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D51EC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x952D-00026i-Id; Tue, 22 Sep 2026 14:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1x952A-00026V-JK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:16:03 -0400
Received: from mail-vs2-x0f.google.com ([2a00:1450:4864:3a::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1x9529-0003ZB-3j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:16:02 -0400
Received: by mail-vs2-x0f.google.com with SMTP id
 ada2fe7eead31-785686d2112so43329137.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790100958; x=1790705758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bdchGATpBJ/Ac4UQhNiWhj9IkXn8QY/w59BNmjbPJyA=;
 b=DBTvDDx3W5J5qi2GcsgKnbbSWwBK1bF6AQ44L+2s2Oa2G+Xh01GGKhw7gdRRlJ53sw
 h1I1oDZ3axw7rULH5rRWrm1RmhEJm4cyZAKe4fIJ2q9cDBbZItlpAlPBLf3osvDQUHEq
 8RMHEaQW44UOyNiSudJmUEc8FChU85POSS9VWHg3m2tLVrlAmScsmp25kt4T40tD0Pn5
 H8xOmnALuWDXaItWxuyHBWjTDltVdWMxUG9jEqM6hrG23Sws4G3mYVQ1XezoFzeDs8CW
 NrRSA5FNUQEcbVcrSGDqMJfH3zJ0Nf/uP0ChyFElWaFTbBtzE4b++GbMxGR2ne5MSOLc
 vueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790100958; x=1790705758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bdchGATpBJ/Ac4UQhNiWhj9IkXn8QY/w59BNmjbPJyA=;
 b=I2wjPeA2XdM7f5eGyjKRM7Rz5Gx4P+UoTeeIMhzl5LAU9OSZjd7zfCV9yD86acWnL+
 zo5+oZw2mYoT9IK9z3q9FYXaR/jepVanY5zD3ygvmzH/ikto29nPNHVsDmLs+kj+d8DT
 vrJqRfeAXDrQysEeQA9Zs0aUhzLJChZLfGKaCkYm85gwaxLQ2QVA+HBk6EG+dUm8r5Ro
 kURl/VJCVQ1n4JB3rFX/w1FQGBvDP/ViNrIPl8h1rfQ5dEbIFjPs1pd/EvSM/ol2Jna6
 72b49bnOxMbEs49kZ2TZKF4WN8Q7odb/JgONbyHdkeGcvSagsQ7g5sXUp3UwNN+URQ2t
 H6TQ==
X-Gm-Message-State: AFuF++m2rNWNyw1Rhp6tysiEOEJ9SNybo3Hn9V5YgPmtRDaPHi127DA7
 Gt6PEXhrXQD7bDnVuKnGoj0e/R0B6uGg7fTokKe3qZLOYUz29CHYKU4/jTbgFLOY
X-Gm-Gg: AYBFou00vWYJXKxJeLMsJOrD9+cZmm4J6uH10HzSWSilkzX4hJ7pOBlaWYjBFymLmFl
 XKP4GLZRd/f7IfyvEACGpL/unyl0lUEMRToy778LpB8P9NBNNLETQr9XG54khw4AnaJzWDLvYv3
 FDKs26gyHhVXarHTVFx+eD6T/QumwOe45TqDA+kIgq+FUurKHUf0aO2BO+AgR16ZBFiLBjefLk6
 CjY9aLyZ5rc0GmWhew8qUJ9pU7yE0Nsu+UkA6ACaC8X/DTOWLYANSMN/no37snbtqAvWFnkNd19
 it5MbYEcpmCroksJ4gTjJkyhiMqUO/7CadMEHOpV2SVSLmR3g6+OVAx1Z+MwDRmMkJkjxo2E6mW
 4siZyxJdVKrZHwWJ/ega5ia09cHffsgLgvr/sp6OyO3jPY3zMkXKTuzslIioRW2+Bqt9qgxCWnM
 bysTeCqE4vKucVe8vioLEv5gU6lf/wGBYHJWOhbe2Lxw0cuIY6QLvUia6ajcA7grA8QlT/fblWM
 flatjBoNXHZP51+m6mdag==
X-Received: by 2002:a05:6102:4b0a:b0:7a5:e455:1823 with SMTP id
 ada2fe7eead31-7ac1d4f39fdmr202071137.27.1790100958394; 
 Tue, 22 Sep 2026 11:15:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140c432220sm3174786d6.28.2026.09.22.11.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 11:15:58 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] backends/cryptodev-lkcf: fix teardown order of eventfd and
 workers
Date: Tue, 22 Sep 2026 14:15:26 -0400
Message-ID: <20260922181548.499505-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:3a::f;
 envelope-from=oss.patchbox@gmail.com; helo=mail-vs2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In cryptodev_lkcf_cleanup(), close(lkcf->eventfd) is called before
joining worker threads via qemu_thread_join(), and the eventfd read
handler registered with qemu_set_fd_handler() is never unregistered.

If an LKCF async crypto task or a main-loop fd callback remains active
during backend cleanup:
1. In-flight worker threads calling eventfd_write() may access a closed
   or already reused file descriptor.
2. The main-loop fd handler may fire on a reused descriptor or
   reference freed LKCF backend objects, resulting in use-after-free
   (UAF) or crash.

Fix this by unregistering the eventfd handler with qemu_set_fd_handler()
prior to joining worker threads, and delaying close(lkcf->eventfd) until
all worker threads have terminated.

Fixes: 39fff6f3e8b3 ("cryptodev: Add a lkcf-backend for cryptodev")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 backends/cryptodev-lkcf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 3fe29d3104c..2f85c382b21 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -264,10 +264,11 @@ static void cryptodev_lkcf_cleanup(CryptoDevBackend *backend, Error **errp)
     qemu_mutex_unlock(&lkcf->mutex);
     qemu_cond_broadcast(&lkcf->cond);
 
-    close(lkcf->eventfd);
+    qemu_set_fd_handler(lkcf->eventfd, NULL, NULL, NULL);
     for (i = 0; i < NR_WORKER_THREAD; i++) {
         qemu_thread_join(&lkcf->worker_threads[i]);
     }
+    close(lkcf->eventfd);
 
     QSIMPLEQ_FOREACH_SAFE(task, &lkcf->requests, queue, next) {
         if (task->cb) {
-- 
2.43.0


