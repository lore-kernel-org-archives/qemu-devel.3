Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91012CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHm0-0006t9-1O; Wed, 24 Jun 2026 03:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjt-00055q-6o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:40 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjr-000358-Cc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:36 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c8894387780so224023a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284974; x=1782889774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgKE2S4eyL5USYP8aXntr0iu36Ri7ZI72KioEt4jQl0=;
 b=Q8X6Pr/zbb5AY0MbuX8dArUO0ggl9jzAWbABzHCGrKYEksUmji3ZlN42E4X3U+9r+h
 2CQh1JYi1DgAsNf/uPbaOr+D44suO+cVD/F36v0Pd+8X/dbK4S14sVA1RZCHj3NbBSDe
 PfvDcqBHhA2W0tVxMKXoU6TaOp3lr1VriB+sKU6ssPaqHS9Nd3fqgtF5XLwhMlBS7UIS
 ZHMoiLMWnuKQHnN6apST20PiaStU1UtrsvFrxKapwSX+sNpGRc63/FPVEtsFscFsvnif
 jgxXDqqlsjzGcvq+pSoAfxZqqGMHOIiS4k//7AKrh1BzZa3w7LYGpy0ys9hJit+g4adq
 RxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284974; x=1782889774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PgKE2S4eyL5USYP8aXntr0iu36Ri7ZI72KioEt4jQl0=;
 b=U3TNifuzm2TmJvghTkpuVEZmbA/87DCsJxfVZPGfW70dLISHu5o5rsMSfQ1QB+WjZy
 m8lN4DllA6+5t1ZYCLZgJod0PT34owyM3bd5qVx/BpjkVwVkIUD+RLBkgQ5LfVI14vOw
 HkyakowQjg+BMZFy9hMnLioTRU45miSZqM1O7Q56h2ytS8rc8RMJRZF1rORUYoUHfrxs
 JRHvJZVQ1wQNDl1tumGCt3R56UhlzXK0uWLDpqg+J+kY+oq0xWgRPVYeFGelCe/V7CCT
 93U17+CQ3m4QhBMGdkXnUeVTZrj0L6srGySD5AGT5CESNo8f+CgEC0mkyx1ZAEK/7jLq
 eADg==
X-Gm-Message-State: AOJu0Yz0t11RWwCU7JZBQ0mZ8EjRiaeN+HhmoW7Qr7GQPFyCcqTCGaPy
 5JVZrCKJPR5chWhGyyt1IaNH+KvDitKKhxygfVT7YShDoOHIYK9jxFgRZN0eY51eYAs=
X-Gm-Gg: AfdE7cnqcj+DqVXB0ofmlm2wEny3/hTJcrep0vspM5mZWRSzNChhpgmuplhGvdoYLgD
 5TWYkE70MxTWXcLuCTZMwJDmvBo3mvYsD+f2gDdimygLM4mJ9IqHK/gdcvJ/j0AMUyeHznAaUFL
 C6UpKydgwKa9UhrkIHzyWVt9KKOiHSOJe3xozpLB9GV+I2Xw6PRsQu/0IFALXHpEwKDLjGhz8Lp
 6qxnHmB5mIkPXmnzoX2kwZKDMHFH2pwBrF+8BLtu9+uUV3fRdPJtsL9AcC2IPJ0GmVCWkC1GeXZ
 Tyn8Xmsoo6dqEju4aKc/HwggpZAL8EK9U1RaYQj4YnyqoOdupBeBBGux/HLX0s9AhpZ8O84UjmB
 d+Ro+m9QFVifJJwBRTp04onrXvJ7v8anChKw/lM0mQ85z8/lzMjDbQDavaWnwzGP2Gkb58msfpw
 u/JxAAAey79Qs5btOdBuo5Uq3L3dOvVQ1ZH+YytdcAmLiJMUzATihA
X-Received: by 2002:a05:6a21:b93:b0:3b3:1b38:d9d6 with SMTP id
 adf61e73a8af0-3bd2d2ec82fmr2534181637.39.1782284973943; 
 Wed, 24 Jun 2026 00:09:33 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 08/17] monitor: switch to iothread_unsafe_get_aio_context()
Date: Wed, 24 Jun 2026 15:08:42 +0800
Message-ID: <20260624070851.13342-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x532.google.com
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

Since previous patches introduced explicit monitor tracking and reference
counting via IOThreadHolder during initialization, standard global calls
to iothread_get_aio_context() are no longer appropriate for raw context
fetches.

Switch the remaining fallback sites in monitor_suspend(), monitor_resume(),
and monitor_init_qmp() to use iothread_unsafe_get_aio_context(). This aligns
with the new safe ref/unref lifecycles introduced for monitor tracking.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor.c | 4 ++--
 monitor/qmp.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index c3eec8c069..98727f3d20 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(iothread_unsafe_get_aio_context(mon_iothread));
     }
 
     trace_monitor_suspend(mon, 1);
@@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
         AioContext *ctx;
 
         if (mon->use_io_thread) {
-            ctx = iothread_get_aio_context(mon_iothread);
+            ctx = iothread_unsafe_get_aio_context(mon_iothread);
         } else {
             ctx = qemu_get_aio_context();
         }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 8fd71386e8..3341df19c8 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -550,7 +550,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_bh_schedule_oneshot(iothread_unsafe_get_aio_context(mon_iothread),
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-- 
2.49.0


