Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFD6083DB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h52Tafai
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNt29-0007rS-4P; Mon, 02 Nov 2026 09:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt22-0007or-ED
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt20-00078j-Pi
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793629743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kosoFqwi9RZUq4Rp4qEurlaVi6hF2rsZxtd6oLNka+o=;
 b=h52TafaiTus1CkXGTLEESW2RRcz1IghhJaN5Zp19jeCYR3+YuYjZ02P1yKVkw65SZuLtQn
 ydOD48fqq5QE9ID/XpJKRXF3s5Q/977rywfIsbAACWcOaVqzNQJinX6fl/SPzMR4AIxtJ5
 bSJ970NvlfPL29BH5u7B4HbJo4XyxNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-zSIzcVkrO02fT-3j-hEvvQ-1; Mon,
 02 Nov 2026 09:28:59 -0500
X-MC-Unique: zSIzcVkrO02fT-3j-hEvvQ-1
X-Mimecast-MFC-AGG-ID: zSIzcVkrO02fT-3j-hEvvQ_1793629738
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31FEE1954102; Mon,  2 Nov 2026 14:28:58 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5A801800444; Mon,  2 Nov 2026 14:28:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 07/25] trace: remove obsolete references to vcpu property
Date: Mon,  2 Nov 2026 14:28:26 +0000
Message-ID: <20261102142844.3464712-8-berrange@redhat.com>
In-Reply-To: <20261102142844.3464712-1-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 'vcpu' property for trace events was removed 2 years ago
but some mentions of it remain in the code.

Fixes: 7ffc4894a63b ("trace: Remove deprecated 'vcpu' field from QMP trace events")
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
2.56.0


