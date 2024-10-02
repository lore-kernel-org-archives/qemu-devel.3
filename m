Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4AECF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyqY-0006e2-41; Wed, 02 Oct 2024 08:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqS-0006cK-3r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqN-0003bV-Vp
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727873559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xmq4GC+9kCDc1p7+kptIsRu1ieSdCxQFnIYTqYQA+ro=;
 b=eWml9G6dEzxqbvMkzYHZaZzIvqvLdcQT9YUp8/Fl+S15vZO7VAP/6nr3Dv/PoQBUFL2e0z
 HdX3W+WWZFhCVJQBIaK9wxpabddt/M8hDyd01cD5WlH34vcULRn1DhCW8GJ6qNmc0VHEuj
 hwfAkbf6OoDIY+BrHiPAUMMcRbFA5rA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-7YiDJIWdOaWJuc8s_dKQLw-1; Wed,
 02 Oct 2024 08:52:38 -0400
X-MC-Unique: 7YiDJIWdOaWJuc8s_dKQLw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F08C1955EB5; Wed,  2 Oct 2024 12:52:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E71A019560A3; Wed,  2 Oct 2024 12:52:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/5] qemu-timer: Remove unused timer functions
Date: Wed,  2 Oct 2024 14:52:25 +0200
Message-ID: <20241002125226.282193-5-thuth@redhat.com>
In-Reply-To: <20241002125226.282193-1-thuth@redhat.com>
References: <20241002125226.282193-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qemu_clock_get_main_loop_timerlist and timerlist_get_clock have been
unused since they were originally added in
  ff83c66ecc ("aio / timers: Split QEMUClock into QEMUClock and QEMUTimerList")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240919144124.309646-1-dave@treblig.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
index 6b1533bc2a..42b74c0444 100644
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


