Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36104606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Aebok3bc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW8H-0007AR-Nd; Mon, 09 Nov 2026 15:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQW8G-0007AH-85
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:38:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQW8D-0008Ji-L5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:38:23 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so14211255e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794256700; x=1794861500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kiaGTPaIhhkuBN32c5SqvoTSji6XUXp8uk7moL2iJBk=;
 b=Aebok3bcYd8K4kJVGUDg/Xtmo8Kru0JwDkZt77r/qedE3Ktq3UfPVyh38Rl2GYFY6x
 0etiuvJIeUkYWybT+lBIIJOfqUtiniwETXn3JZ040AH8NBSll17giMA3T4ZmVagFenup
 fkNyefgbqYtxpOPMWyWArH4s3bssNcPceYs0vtb5/5YVri/PvrkpHRGbEvd/UP8tRLe3
 IUt31XxJqKZv8oLFKa7Y3/b1J3x7rozTHheD3p/8scAtZdXnxeRnvYyZKY4ttyzBWTEv
 YQNTad/uHJ2MyBGCRTIM0fbvYkzIqjnrr53LLWypJl0O6Hd4Y10ApJG/Bu+yBx6DYuEG
 /awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256700; x=1794861500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kiaGTPaIhhkuBN32c5SqvoTSji6XUXp8uk7moL2iJBk=;
 b=tyw2zRh/plb20HKkpLLPf9epx7VigH2cGOeXPr/kByrwF19WOP+aKzpZmKZnvplTNE
 PRzh7B3KDRESEy3Augs6qLUJIw7VvT/2U2pfqGomJS5x6hmzHNmG5XnflzQn4LByq0gf
 N577F26NYVE2BNMSuNO70D26f7Xt50LgwRoPt4opIWLQcsHTkpxCKkg3Dd/pAwIdwlPs
 VgpEi5Lr041/xoZHpQY/p4uCDnxqoW3+w5EVchD2nJiLr8HDaFiL1VhLfYKonrT5ZSIi
 ZkWnJlFdnXkX5zpJzHqyQ92dXpUFk1Q3c+t/FB/4TgWuqG0z+zHb029c5uc9U/ZGABzQ
 CXiw==
X-Gm-Message-State: APuU4Z+DBpMe35P3uNWvLAZqQkBzE5RQp4eO8x5hZfjnnPJ+CF8ku56q
 TAW8b8Q/rw9P3grng6OKTc02okDyq7ofVpZqEHUrfDP4U2359Jmr/YDj0sG9+c2DSC8GocxfqL3
 6YpW3SRI=
X-Gm-Gg: AYBFou0Ds5szDpfGd48/L91Qqra+8jphnLtfpkiMN3RThmU28Bn3/GokyZv7HF9aN5Y
 30jCKRbg8STqYRCWxFr75pcdHhk8NigdHM2srVmYMHbEOS6StQ8DDTk+DsMUJyPEIeC39ebTAFg
 y3kKz2FDxVyNG5PqIEhP73miDIP23YEblP96nYdbyPlP8g5wahP+uWamsxU1Y3nvzm0OKX1MbTZ
 qOFWcyKSyZoZx8Idqmd3mK5iufEkAoGXqiUrFjkfU/viGpVcZG8/n8Mml/7DYB64WIndJXeeFAk
 SYveAR6vf3IOnHuz9FM9ZhoXUw9u96U4tFMZ3vB8q368T43PhjrO01Q2xwx9gNXH9DMOBy/mnMc
 KyzNmQFSYyxq3d15Iy6VrUS9+UMTdBN4UrcS0huGi6OkST32xxMPWfZSj4HLFfrVAkDWggh2gBw
 1xXLBVl2FmGBB+yBk0+2oxb6BC2gwPQp/AUSxBOn8RhysPh0b4jsJGtdeVNriALt7LqOSEVYpka
 QMU/JSa83ebra4v9QJa0N2f84ksSbUf4cXX0hQo5+7GC3oALNXSJ9MHYHi2LPqryJO1Yp/RMm7+
 oLzHU+N9uzle04iL3UyYntFDafOtO2gChLwHktSx9iKAkSZhVq1pttqB2rquOg456KVKffxFKBo
 4b2CtqoEVW4LzMcsgId3xxvOfS62lzIzbmfk=
X-Received: by 2002:a05:600c:3b98:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4ba02351506mr6617925e9.32.1794256699290; 
 Mon, 09 Nov 2026 12:38:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498496ac658sm788504f8f.4.2026.11.09.12.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:38:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/usb/ccid-card-emulated: Use QemuSemaphore rather than
 QemuCond
Date: Mon,  9 Nov 2026 20:38:17 +0000
Message-ID: <20261109203817.1683717-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The emulated CCID card uses a QemuMutex and QemuCond to communicate
with its helper thread, but all it's trying to do here is "make the
helper thread loop wait until is signalled that it has more work to
do".  The existing code functions correctly, but "wait until the
other thread signals you" is more simply implemented with a
QemuSemaphore.

This avoids a Coverity complaint that we're not using the condition
variable in the standard

   lock mutex;
   while (!some_predicate) {
       cond_wait(condvar, mutex);
   }
   do stuff;
   unlock mutex;

pattern.

Resolves: Coverity CID 1547639
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've tested this with a functional test that exercises the
"use certificates stored in files" setup from the documentation,
but I still need to arrange to have the official tuxrun guest
kernel/images updated with the extra config necessary, so in
the meantime I'm just posting this patch, and hope to post
the functional-test as a separate patch later this week.
The issue has been floating around in Coverity for years and
the existing code is not incorrect, so there's no strong
urgency to get this into 11.2.

PS: there is no maintainers entry for the ccid-usb code;
would somebody (I guess from RedHat as the original
contributors of it) like to take it on? Or if it's really
"orphan" that would be worth documenting.

---
 hw/usb/ccid-card-emulated.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 6c8eec39faa..c504c52a7cd 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -129,8 +129,7 @@ struct EmulatedState {
     VReader *reader;
     QSIMPLEQ_HEAD(, EmulEvent) guest_apdu_list;
     QemuMutex vreader_mutex; /* and guest_apdu_list mutex */
-    QemuMutex handle_apdu_mutex;
-    QemuCond handle_apdu_cond;
+    QemuSemaphore handle_apdu_sem;
     EventNotifier notifier;
     int      quit_apdu_thread;
     QemuThread apdu_thread_id;
@@ -149,9 +148,7 @@ static void emulated_apdu_from_guest(CCIDCardState *base,
     qemu_mutex_lock(&card->vreader_mutex);
     QSIMPLEQ_INSERT_TAIL(&card->guest_apdu_list, event, entry);
     qemu_mutex_unlock(&card->vreader_mutex);
-    qemu_mutex_lock(&card->handle_apdu_mutex);
-    qemu_cond_signal(&card->handle_apdu_cond);
-    qemu_mutex_unlock(&card->handle_apdu_mutex);
+    qemu_sem_post(&card->handle_apdu_sem);
 }
 
 static const uint8_t *emulated_get_atr(CCIDCardState *base, uint32_t *len)
@@ -238,9 +235,7 @@ static void *handle_apdu_thread(void* arg)
     EmulEvent *event;
 
     while (1) {
-        qemu_mutex_lock(&card->handle_apdu_mutex);
-        qemu_cond_wait(&card->handle_apdu_cond, &card->handle_apdu_mutex);
-        qemu_mutex_unlock(&card->handle_apdu_mutex);
+        qemu_sem_wait(&card->handle_apdu_sem);
         if (card->quit_apdu_thread) {
             card->quit_apdu_thread = 0; /* debugging */
             break;
@@ -496,8 +491,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
     QSIMPLEQ_INIT(&card->guest_apdu_list);
     qemu_mutex_init(&card->event_list_mutex);
     qemu_mutex_init(&card->vreader_mutex);
-    qemu_mutex_init(&card->handle_apdu_mutex);
-    qemu_cond_init(&card->handle_apdu_cond);
+    qemu_sem_init(&card->handle_apdu_sem, 0);
     card->reader = NULL;
     card->quit_apdu_thread = 0;
     if (init_event_notifier(card, errp) < 0) {
@@ -556,8 +550,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
 out2:
     clean_event_notifier(card);
 out1:
-    qemu_cond_destroy(&card->handle_apdu_cond);
-    qemu_mutex_destroy(&card->handle_apdu_mutex);
+    qemu_sem_destroy(&card->handle_apdu_sem);
     qemu_mutex_destroy(&card->vreader_mutex);
     qemu_mutex_destroy(&card->event_list_mutex);
 }
@@ -571,13 +564,12 @@ static void emulated_unrealize(CCIDCardState *base)
     qemu_thread_join(&card->event_thread_id);
 
     card->quit_apdu_thread = 1; /* stop handle_apdu thread */
-    qemu_cond_signal(&card->handle_apdu_cond);
+    qemu_sem_post(&card->handle_apdu_sem);
     qemu_thread_join(&card->apdu_thread_id);
 
     clean_event_notifier(card);
     /* threads exited, can destroy all condvars/mutexes */
-    qemu_cond_destroy(&card->handle_apdu_cond);
-    qemu_mutex_destroy(&card->handle_apdu_mutex);
+    qemu_sem_destroy(&card->handle_apdu_sem);
     qemu_mutex_destroy(&card->vreader_mutex);
     qemu_mutex_destroy(&card->event_list_mutex);
 
-- 
2.43.0


