Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410EECA6001
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhWM-0006If-Od; Mon, 05 Oct 2026 08:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVL-0005zo-Pn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVK-0004im-4n
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYK8uyoSgHR5oFrvRW3UePwVftb7R2+FEmXyIxd1LQ4=;
 b=YATkvY5KYTapN/uSECPv5hYhKjMlsE0ngjjivSutuF0HWAgtim4Lqy/Z3/qDhKxVQNJAtP
 Qa6DhZgfGK6lOhCYLShYHsxNUKokJ1ekbqpmfus7IAWgaFxPtK+GQK3632Kiiy4lqZ8Z2/
 f4wJWlxBWmtpDp2gNT2qe3fV5BcAkdg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-DcPRTnNyMEu691REshvc6Q-1; Mon,
 05 Oct 2026 08:09:11 -0400
X-MC-Unique: DcPRTnNyMEu691REshvc6Q-1
X-Mimecast-MFC-AGG-ID: DcPRTnNyMEu691REshvc6Q_1791202151
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E24F81944B03; Mon,  5 Oct 2026 12:09:10 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7667D3001D2B; Mon,  5 Oct 2026 12:09:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/24] trace: remove obsolete references to vcpu property
Date: Mon,  5 Oct 2026 13:08:38 +0100
Message-ID: <20261005120855.421973-8-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


