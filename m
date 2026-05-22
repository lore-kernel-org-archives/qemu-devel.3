Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF60CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPR5-0004iY-Vs; Fri, 22 May 2026 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wQKv6-0005OZ-QZ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:07:49 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wQKv3-0002jp-Vn
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:07:48 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a8ee4b703fso6583381e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779437263; x=1780042063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTXnbyvk/cqKWEhYjnlE7291MHIAgtVT3fS3zVYhA24=;
 b=fLdZA7Y5bPLYPIYqbPlEYr8ZRYjiSnEGBF52wCxfPaL1HBFW8ZOquzXAihnkjEQunv
 MFw3AY+N3+wkwFGyMiDM/lH1v9CQ9QrYIyrxBBgITK/aD/NBTaE3XaCicnC9Tb8qS5J8
 4fDflwA/y14o5X4KuycD1vhPVFzJg9msQAYoRypbhRLnLrI5RnWU/qwL8tztaojIdCkg
 DUhZl02D4Z0kyViJLCXN5VmrdbL1vH2di4hRzHA904iN5unEuxzw8z6hn0IqRNlAmpgt
 naqwDm10MprEXoAZoEhpE553PKQCRIJsntnOTNzg2OrkqVNaTcGYOkrKfmZiEb2sg/BD
 GUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779437263; x=1780042063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vTXnbyvk/cqKWEhYjnlE7291MHIAgtVT3fS3zVYhA24=;
 b=I19tVA+AK3P/Sd4aNr9U15XFLMRNOoCVSY2NDCkI8cHfoZOWnhmQ2gkxAPNxpRdUwt
 swRi2uJ71JyWeu383HKaNWzrfj6k9YMPw+Rq/vrRQf+RaWlLc1+TV/vxDRFWnu+bMExy
 rRZYzAurcx0FU5pt5uDc7qVFQ2PNfKAUSr4hpeqrHQctawiS1p65lK06TywaH+6TYOb1
 0MQ6zqyXMXIbvGIwF8bV38WfCJRXEc4aT6J9wP+TLX1wjdm7FZ2+n4GjaiK8fmias07F
 dPvKrV3Cjpapvk4KXvCLJdNp+QZWdyS+CW3MyDlt/pvrNTVO8HRgFPn2YubexrPIebAb
 qKSw==
X-Gm-Message-State: AOJu0YxqC9ScXxnAi6agE8z4HpXNfUARPChbwMppPjK+IBrbPJfCum9b
 rrIU2xa/ONu8lvdaSsbPIEvBdsNFicu0crrsYj2Ilpd0fCj/xJySvSXECvD6HAiAANw=
X-Gm-Gg: Acq92OG2uGs8mavTzCcBbj2CIiLEu9mPygipBog1rE8E5fugde5/RuK7L7+5UGrqqAN
 EsFecmfEY3b6muwadZJezERK2wWPUmcfeTJmNFNhNcKh2KpKlvreX1BiR3BlvTeiZBMeH47dS25
 Coz619Te8i0IFJ7Tx80LFDbT/LwU5ndAGXOOP3VtEeZu6uJKQ8FX//hXwrwFq33+cAyvewryDHw
 hg+BBx+1djwFyKKs12NiXqXQM3aT5JyzO6LJ8GChV5vGIq2X/EA2cgdb2117aSVRzY66sMT9yHQ
 Rl6f03mmkxbKSjNlUpzH+pPNr29NaQKB/D+kaqGV+GtbhvBGUrBrIROC+CtfeqncVPMs9y3jf6K
 7tKxLHe0MML277dToDUGHzVQgNiUafkuId7WraBYaM9ZIjn8Izn3RQfftaxf9qd4X0TxgmT73Ok
 ruOpqCkTmGEbK7
X-Received: by 2002:a05:6512:3ca7:b0:5a8:f03c:fb1e with SMTP id
 2adb3069b0e04-5aa323b52damr733766e87.18.1779437263227; 
 Fri, 22 May 2026 01:07:43 -0700 (PDT)
Received: from machine.. ([37.113.215.232]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf95c9sm239722e87.78.2026.05.22.01.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 01:07:42 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jasowang@redhat.com,
 Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH 1/2] net/colo-compare: Use QEMU_LOCK_GUARD to simplify mutex
 handling
Date: Fri, 22 May 2026 11:06:43 +0300
Message-ID: <20260522080644.9531-2-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522080644.9531-1-randomjack94dev@gmail.com>
References: <20260522080644.9531-1-randomjack94dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=randomjack94dev@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 May 2026 08:57:05 -0400
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

Replace qemu_mutex_(un)lock() calls with the QEMU_LOCK_GUARD().

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
---
 net/colo-compare.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 823b8aa323..5986fb1e88 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -902,14 +902,13 @@ static void check_old_packet_regular(void *opaque)
 void colo_notify_compares_event(void *opaque, int event, Error **errp)
 {
     CompareState *s;
-    qemu_mutex_lock(&colo_compare_mutex);
+    QEMU_LOCK_GUARD(&colo_compare_mutex);
 
     if (!colo_compare_active) {
-        qemu_mutex_unlock(&colo_compare_mutex);
         return;
     }
 
-    qemu_mutex_lock(&event_mtx);
+    QEMU_LOCK_GUARD(&event_mtx);
     QTAILQ_FOREACH(s, &net_compares, next) {
         s->event = event;
         qemu_bh_schedule(s->event_bh);
@@ -919,9 +918,6 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
     while (event_unhandled_count > 0) {
         qemu_cond_wait(&event_complete_cond, &event_mtx);
     }
-
-    qemu_mutex_unlock(&event_mtx);
-    qemu_mutex_unlock(&colo_compare_mutex);
 }
 
 static void colo_compare_timer_init(CompareState *s)
-- 
2.43.0


