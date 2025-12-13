Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B2DD59F53
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDHo-0006gB-6X; Fri, 12 Dec 2025 19:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_688aQoKCqIOCTEOQTEQUIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--marcmorcos.bounces.google.com>)
 id 1vUDHm-0006fV-LH
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:58 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_688aQoKCqIOCTEOQTEQUIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--marcmorcos.bounces.google.com>)
 id 1vUDHl-000797-56
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:58 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so1714528a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584895; x=1766189695; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=sl9CNn1EVZEpq7y7cqXda6K3glgb23SOapyyZsDMnjg=;
 b=HP0QXTSRWHK3x/2uHqxk3k1zqJ8DnpoIet2AUAJL+trOXKL0DYQPJ6ia19Fl3mSpNI
 d6tupxAZGfiLLJ+YBA+/5j18kWhWk2MyaRQNZE0bea/dsxztOhxhGQcTGf6MreF9HCyk
 kDP7wo/+349GqYOEJ6wobXmDU7oroAZ5ZbxmMrV47gFMMplNqlGPySVkZGg7iyUVqEYz
 6k4pa0V3U169NX+vfOCyKN1r4S6OZK5q9R0SibDjQ4Ch5b357WC47kOtFeBEKIGCqmI6
 VPadAqGUwTnVy7ZXSAPNdHoxUnTceQWhnUMfKZf/3q2zLyU5hntHjr15X14jxPGTkY35
 lTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584895; x=1766189695;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sl9CNn1EVZEpq7y7cqXda6K3glgb23SOapyyZsDMnjg=;
 b=Ytqb4dBtDBkIOzzaeu0uMz1+rgYG0ufn4YyNwirqQsMEZMB9bnRW8GWwU256gPkJLM
 ZLGtoA5usncU0/Lq2tgDTkLfLL67QzPp+Sa9xI6suD7QHaVS+W1epvSzXMbcjSSVw6JA
 lQayN2W3+oeQAMFCFBjdL1BkQz86K/mAn9V7NtDxkQhzZyXYd227y3IQ8PGmQwFNGN64
 AgCHezPO6HOx7ezRFgRsjRSpqjMQhLaekDHdig1GBPWcjWFhIAbir+DJjKc9MLGCpSEp
 upvdxRPhyBqj5HIqMcY8MobyirpdjRwIWreZydmEjvMdA8YWcUeiKKZx1Fut5Nbbedet
 ENBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCKE6/O1JzzobaRSLgzVtL2bJn+ow7YCle1IVz/PRZI0BGO2DZyIDlZju/mtkIb6zrA4SqOiA6E7eF@nongnu.org
X-Gm-Message-State: AOJu0YyLn9Tovg+kHRZpmiIacozW+TmonWdz7RFzksPPvuMfVQldhq/X
 rwdSRj8mT+f64DS9OSrhUt4eZYSoFUXJ6Vw5JzoBa51WaQNVqjeWGv12pBav9uog/0ANnwLo58h
 OBXkk47F6kYqoyFExlTn3ew==
X-Google-Smtp-Source: AGHT+IE8+xrHCWoej8QIHCaGCUtpB6hyutXgRJeL9Co2narXZoICzwtqZy/98P5K8Cw5wHfygJT+Pm+hzJ2VPvoE
X-Received: from dycmv3.prod.google.com ([2002:a05:693c:2803:b0:2ac:3a02:feae])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:6213:b0:2a4:3593:ddf3 with SMTP id
 5a478bee46e88-2ac3012b8a3mr3278144eec.32.1765584895347; 
 Fri, 12 Dec 2025 16:14:55 -0800 (PST)
Date: Sat, 13 Dec 2025 00:14:42 +0000
In-Reply-To: <20251213001443.2041258-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001443.2041258-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001443.2041258-4-marcmorcos@google.com>
Subject: [PATCH 3/4] qmp: Fix thread race
From: Marc Morcos <marcmorcos@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3_688aQoKCqIOCTEOQTEQUIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--marcmorcos.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This fixes a thread race involving the monitor in monitor_qmp_event and monitor_qapi_event_emit .

Signed-off-by: Marc Morcos <marcmorcos@google.com>
---
 monitor/monitor.c | 11 ++++++++++-
 monitor/qmp.c     |  6 ++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index c5a5d30877..4bfd72939d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -338,6 +338,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
     Monitor *mon;
     MonitorQMP *qmp_mon;
+    bool do_send = false;
 
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
@@ -346,7 +347,15 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
         }
 
         qmp_mon = container_of(mon, MonitorQMP, common);
-        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
+        do_send = false;
+
+        WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+            if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
+                do_send = true;
+            }
+        }
+
+        if (do_send) {
             qmp_send_response(qmp_mon, qdict);
         }
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb99a12d94..e1419a9efa 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -462,8 +462,10 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->commands = &qmp_cap_negotiation_commands;
-        monitor_qmp_caps_reset(mon);
+        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
+            mon->commands = &qmp_cap_negotiation_commands;
+            monitor_qmp_caps_reset(mon);
+        }
         data = qmp_greeting(mon);
         qmp_send_response(mon, data);
         qobject_unref(data);
-- 
2.52.0.239.gd5f0c6e74e-goog


