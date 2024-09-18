Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F459CDD548
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxdV-0006QB-Q7; Wed, 18 Sep 2024 12:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqxdT-0006PH-KQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:34:35 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqxdR-0005y9-An
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=0HUIVhFEi8KBhPbRfPw6iR7BhicNPS5mVCyP+euce4M=; b=V8o28BtJoxPYCtnT
 aJPkaNaAosSht326TJiIVNgXmj5MZOyEJlbkM42gZDcLuR4VuoIjA5ub87fKYAkMtZm4flkr9Doya
 YNBfKrALC2LnFGD1IwXkH1EIwINUiSDvbKX5Y9TIHySjroNF+TpRdTzdQaPHe0inSv2+HCx4BPOFH
 tPQNbvS1qLdDuIvfgkFjnR6DEbjUWsziem/h50Spj+NGIbRE5VkrSFpru63rCYh2aphggdr+LeDaF
 5FdVvIqAPYlIuGu+lie4oQ9iiHucWoU4v8T/1FfdbE3w9JZl7LOsxrZzgx55+jrbEivXfkVPlTzZ+
 7Raa2KViEfanZWwPuQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqxdM-006Jq4-1x;
 Wed, 18 Sep 2024 16:34:28 +0000
From: dave@treblig.org
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] qemu-timer: Remove unused qemu_clock_get_main_loop_timerlist
Date: Wed, 18 Sep 2024 17:34:27 +0100
Message-ID: <20240918163427.175237-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qemu_clock_get_main_loop_timerlist has been unused since it was
originally added in
  ff83c66ecc ("aio / timers: Split QEMUClock into QEMUClock and QEMUTimerList")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/timer.h | 10 ----------
 util/qemu-timer.c    |  5 -----
 2 files changed, 15 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index fa56ec9481..ccd8578ae3 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -190,16 +190,6 @@ bool qemu_clock_use_for_deadline(QEMUClockType type);
  */
 int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask);
 
-/**
- * qemu_clock_get_main_loop_timerlist:
- * @type: the clock type
- *
- * Return the default timer list associated with a clock.
- *
- * Returns: the default timer list
- */
-QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type);
-
 /**
  * qemu_clock_nofify:
  * @type: the clock type
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..e5b5452e4e 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -291,11 +291,6 @@ QEMUClockType timerlist_get_clock(QEMUTimerList *timer_list)
     return timer_list->clock->type;
 }
 
-QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type)
-{
-    return main_loop_tlg.tl[type];
-}
-
 void timerlist_notify(QEMUTimerList *timer_list)
 {
     if (timer_list->notify_cb) {
-- 
2.46.0


