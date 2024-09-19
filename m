Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD92CF3959
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 14:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srILc-0000xr-Q1; Thu, 19 Sep 2024 10:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srILa-0000xL-P2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:41:30 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srILY-0004B4-AJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=KA40/g1ghVIaIRDpuWMJlyaSiF/sx7D2viFql/Mt6Js=; b=KpEuPBINDAapwFD6
 lXcLN7o31xkzHoP6z4O8JAqqP3fB8mZnNEuUrvcnjzAPsKONWsjyFHdv5aMjP6lVHULCRhytuxM9S
 vu/X90ucShmxZO2KmmoVSrs2W63iSm0gzBqZRAkcvhC1ZGByv5f2tBJE/19jUEAi3chF4sOj0yDgm
 FAZM//B/0mr+vEQ62AoOpGGZ568LHaGFLLS9tHgfkCiaO9KHAgL063Qn+ObanqVNwA0rSzwK+C5eZ
 Rl2zXBrtoG1FeTrHIQWY2ky3YEbJpKTPrP0JsI0ZBDAT4ioJkmB30CRfW85+zBehIsagoH0pmMF9i
 PFcajjsWMuVbyrZJPQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srILW-006REK-0G;
 Thu, 19 Sep 2024 14:41:26 +0000
From: dave@treblig.org
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2] qemu-timer: Remove unused timer functions
Date: Thu, 19 Sep 2024 15:41:24 +0100
Message-ID: <20240919144124.309646-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
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

qemu_clock_get_main_loop_timerlist and timerlist_get_clock have been
unused since they were originally added in
  ff83c66ecc ("aio / timers: Split QEMUClock into QEMUClock and QEMUTimerList")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/timer.h | 21 ---------------------
 util/qemu-timer.c    | 10 ----------
 2 files changed, 31 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index fa56ec9481..cc167bd825 100644
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
@@ -326,17 +316,6 @@ bool timerlist_expired(QEMUTimerList *timer_list);
  */
 int64_t timerlist_deadline_ns(QEMUTimerList *timer_list);
 
-/**
- * timerlist_get_clock:
- * @timer_list: the timer list to operate on
- *
- * Determine the clock type associated with a timer list.
- *
- * Returns: the clock type associated with the
- * timer list.
- */
-QEMUClockType timerlist_get_clock(QEMUTimerList *timer_list);
-
 /**
  * timerlist_run_timers:
  * @timer_list: the timer list to use
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..df9327657a 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -286,16 +286,6 @@ int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask)
     return deadline;
 }
 
-QEMUClockType timerlist_get_clock(QEMUTimerList *timer_list)
-{
-    return timer_list->clock->type;
-}
-
-QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type)
-{
-    return main_loop_tlg.tl[type];
-}
-
 void timerlist_notify(QEMUTimerList *timer_list)
 {
     if (timer_list->notify_cb) {
-- 
2.46.1


