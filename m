Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D174CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhWg-0006nB-Mp; Mon, 05 Oct 2026 08:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVK-0005zn-Bb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVI-0004iV-4H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAOh1/B1/tdEaQvr+uMoadWgWliSLwqcPrKUviE2qZE=;
 b=Lgxvv5XN11s6Iba4555Ki6l0mwRtDVbv4i9W6gxGNZtjrLn4Yb1WrH9TMHNlBVsdXcivJb
 KEze4XxQ2sLGm9Pqys9By59JZSdszgkkafBrQK/X63pp7hqC3GpR3ElmXBf0ja0H4z1r9+
 L6G117565bB3Hzqk6Bzxb7oD+L6VNxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-KpAkN3NkPaiPGY9bf-ijoA-1; Mon,
 05 Oct 2026 08:09:10 -0400
X-MC-Unique: KpAkN3NkPaiPGY9bf-ijoA-1
X-Mimecast-MFC-AGG-ID: KpAkN3NkPaiPGY9bf-ijoA_1791202149
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24A641802148; Mon,  5 Oct 2026 12:09:09 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD9563001D2A; Mon,  5 Oct 2026 12:09:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/24] trace: drop unused
 trace_event_set_state_dynamic_init()
Date: Mon,  5 Oct 2026 13:08:37 +0100
Message-ID: <20261005120855.421973-7-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The use of this method was mistakenly dropped in 0d4e995c73.
When the 'vcpu' property was dropped, however, this became
functionally identical to trace_event_set_state_dynamic().

Fixes: 0d4e995c7368f8bdc8845beb499b650386a38819
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 stubs/trace-control.c  |  5 -----
 trace/control-target.c | 21 ---------------------
 trace/event-internal.h |  2 --
 3 files changed, 28 deletions(-)

diff --git a/stubs/trace-control.c b/stubs/trace-control.c
index b428f34c878..3f196835db0 100644
--- a/stubs/trace-control.c
+++ b/stubs/trace-control.c
@@ -11,11 +11,6 @@
 #include "trace/control.h"
 
 
-void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
-{
-    trace_event_set_state_dynamic(ev, state);
-}
-
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
 {
     bool state_pre;
diff --git a/trace/control-target.c b/trace/control-target.c
index 57ceac21084..24d9b7abbde 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -10,27 +10,6 @@
 #include "qemu/osdep.h"
 #include "trace/control.h"
 
-
-void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
-{
-    bool state_pre;
-    assert(trace_event_get_state_static(ev));
-    /*
-     * We ignore the "vcpu" property here, since no vCPUs have been created
-     * yet. Then dstate can only be 1 or 0.
-     */
-    state_pre = *ev->dstate;
-    if (state_pre != state) {
-        if (state) {
-            trace_events_enabled_count++;
-            *ev->dstate = 1;
-        } else {
-            trace_events_enabled_count--;
-            *ev->dstate = 0;
-        }
-    }
-}
-
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
 {
     assert(trace_event_get_state_static(ev));
diff --git a/trace/event-internal.h b/trace/event-internal.h
index 0c24e01b521..1d57b0ff1b5 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -37,6 +37,4 @@ typedef struct TraceEvent {
     uint16_t *dstate;
 } TraceEvent;
 
-void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state);
-
 #endif /* TRACE__EVENT_INTERNAL_H */
-- 
2.55.0


