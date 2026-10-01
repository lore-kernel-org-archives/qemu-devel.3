Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B03CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCISn-0000tV-0J; Thu, 01 Oct 2026 11:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISi-0000qu-8t
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISg-0000uz-Nl
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/z3aFk1Np3yQEBd0G9ugOCENeVZRxfoiuPxk0XaPfXA=;
 b=PnH9vnEXRZ/jq7cse8Ra3VLvyjbyW1Yh4Sa0Fa+E54+44hUaPKgs5U/yZyI1xSKRuJupP0
 Pjhroxp3DwUCSCVtJFlQT2sneTyk7v72rY1bEtuDKw2YIJ1eoKh2ocfhD8zQ0h3RuPv3Ha
 ZINRZZiw5Av+8j6rmvfGrOcDBzdrwwE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-I6BFbvCwPZ6YSMCcDgSkeg-1; Thu,
 01 Oct 2026 11:12:40 -0400
X-MC-Unique: I6BFbvCwPZ6YSMCcDgSkeg-1
X-Mimecast-MFC-AGG-ID: I6BFbvCwPZ6YSMCcDgSkeg_1790867559
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2BD01955DC9
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:39 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C99A31956042; Thu,  1 Oct 2026 15:12:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/20] trace: remove obsolete references to vcpu property
Date: Thu,  1 Oct 2026 16:12:15 +0100
Message-ID: <20261001151228.3373747-8-berrange@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The 'vcpu' property for trace events was removed 2 years ago
but some mentions of it remain in the code.

Fixes: 7ffc4894a6(trace: Remove deprecated 'vcpu' field from QMP trace events)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 trace/control-target.c |  6 ------
 trace/control.c        |  6 ------
 trace/control.h        | 12 ------------
 trace/event-internal.h | 11 -----------
 4 files changed, 35 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 24d9b7abbde..87b0f5037df 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -14,12 +14,6 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
 {
     assert(trace_event_get_state_static(ev));
 
-    /*
-     * There is no longer a "vcpu" property, dstate can only be 1 or
-     * 0. With it, we haven't instantiated any vCPU yet, so we will
-     * set a global state instead, and trace_init_vcpu will reconcile
-     * it afterwards.
-     */
     bool state_pre = *ev->dstate;
     if (state_pre != state) {
         if (state) {
diff --git a/trace/control.c b/trace/control.c
index 49f0a4c5cda..6971157cbe7 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -37,7 +37,6 @@ typedef struct TraceEventGroup {
 static TraceEventGroup *event_groups;
 static size_t nevent_groups;
 static uint32_t next_id;
-static uint32_t next_vcpu_id;
 #ifdef CONFIG_TRACE_SIMPLE
 static bool init_trace_on_startup;
 #endif
@@ -304,8 +303,3 @@ void trace_opt_parse(const char *optstr)
     trace_opts_file = g_strdup(qemu_opt_get(opts, "file"));
     qemu_opts_del(opts);
 }
-
-uint32_t trace_get_vcpu_event_count(void)
-{
-    return next_vcpu_id;
-}
diff --git a/trace/control.h b/trace/control.h
index 6754bfe052b..20033fb6669 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -139,8 +139,6 @@ static bool trace_event_get_state_static(TraceEvent *ev);
  * trace_event_get_state_dynamic:
  *
  * Get the dynamic tracing state of an event.
- *
- * If the event has the 'vcpu' property, gets the OR'ed state of all vCPUs.
  */
 static bool trace_event_get_state_dynamic(TraceEvent *ev);
 
@@ -149,8 +147,6 @@ static bool trace_event_get_state_dynamic(TraceEvent *ev);
  *
  * Set the dynamic tracing state of an event.
  *
- * If the event has the 'vcpu' property, sets the state on all vCPUs.
- *
  * Pre-condition: trace_event_get_state_static(ev) == true
  */
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state);
@@ -203,14 +199,6 @@ extern QemuOptsList qemu_trace_opts;
  */
 void trace_opt_parse(const char *optstr);
 
-/**
- * trace_get_vcpu_event_count:
- *
- * Return the number of known vcpu-specific events
- */
-uint32_t trace_get_vcpu_event_count(void);
-
-
 #include "control-internal.h"
 
 #endif /* TRACE__CONTROL_H */
diff --git a/trace/event-internal.h b/trace/event-internal.h
index 1d57b0ff1b5..cc095a6ad54 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -10,12 +10,6 @@
 #ifndef TRACE__EVENT_INTERNAL_H
 #define TRACE__EVENT_INTERNAL_H
 
-/*
- * Special value for TraceEvent.vcpu_id field to indicate
- * that the event is not VCPU specific
- */
-#define TRACE_VCPU_EVENT_NONE ((uint32_t)-1)
-
 /**
  * TraceEvent:
  * @id: Unique event identifier.
@@ -23,11 +17,6 @@
  * @sstate: Static tracing state.
  * @dstate: Dynamic tracing state
  *
- * Interpretation of @dstate depends on whether the event has the 'vcpu'
- *  property:
- * - false: Boolean value indicating whether the event is active.
- * - true : Integral counting the number of vCPUs that have this event enabled.
- *
  * Opaque generic description of a tracing event.
  */
 typedef struct TraceEvent {
-- 
2.55.0


