Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCA7D59F5C
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDFo-00046C-6H; Fri, 12 Dec 2025 19:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gq88aQoKCiUNBSDNPSDPTHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--marcmorcos.bounces.google.com>)
 id 1vUDFm-00044C-21
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:54 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gq88aQoKCiUNBSDNPSDPTHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--marcmorcos.bounces.google.com>)
 id 1vUDFk-0006kw-D9
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:53 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-34a907477b3so3146822a91.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584770; x=1766189570; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=sl9CNn1EVZEpq7y7cqXda6K3glgb23SOapyyZsDMnjg=;
 b=4pZ1FmmzyE1y2KxjngM/SwFJJKXIK4JsJXyKbkDzP9tDfZIaZXA928X8Qhmd3hGehE
 WsY/AZjbtD1hTR2xVZidDvJGiHqnMrFyw9HGFsVS2fy8lriY10CezXBkLaa3J+aaSbzB
 ziuKpwpRvQN32T//+ms7/8CWTNGZT5guVrMSWDmSLOaHWXiOAHiw9f7oweIy9DkusKLb
 psEaGH8Unxs2/xgyUkfTd1Yrg5mIRaRQh9VGf3T2WPqivuSbwHA3OF3dQxo9Y28BvUvl
 VgWe6mFYhAXvzYcqKlTp0ILtm+zQ9GZ/yz0/vJsmNl87Acct5fi6PZ8Opb1SlHf7YAYg
 hlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584770; x=1766189570;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sl9CNn1EVZEpq7y7cqXda6K3glgb23SOapyyZsDMnjg=;
 b=OfoybIOykaUruvi/WtIgo8kB7GZt2B1z+E7jQJFndE5qhlipYkqROEpz+Rpg6oMFEz
 6ja/+x/GCiEitshfQfd5hpub5thFO0gve9Aa2Mw9J2vpAYu3Z64UZyW5jR5mHd0ikAWI
 GLJgsXXBjkEzts6CAnGORjeE653EE/VDzGwiyr3WwIzXIotQOY7eM6O1E1PRI652ZkMu
 LBqRXx54UyME32Bzfu+Z8yBtc01zw+ZnaSrq+FOltTfEivWZLBLisf0ODvF64vcciw1d
 sBMYXLiq7a5z1Y1sV2F+cu4hhVc5dlcKhSClf2MW4CbWvVEt6yGtolyY5XuBP14T++Op
 w9PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoICTVtfrbKheEXjKtZZFM9y3wR44tyZl2QcCrFlv8s66AAAwQ9mJ159+clmO2bE+23pIiiH/27vl8@nongnu.org
X-Gm-Message-State: AOJu0YxOl7BdDlh9By9FOuskPQcGDKKKGpX9KoFDff4ApnnUavP4gS0D
 HIEta+dW6FXBEVejODDtMcC+B1eOZznocajxOAPfkHzA83WVt56aJGlQ49K0BTcA1ZrMaoMXNzi
 vsdTxBY4gFph1aGzCu1bAFA==
X-Google-Smtp-Source: AGHT+IFZgGy/54LFCIOGtITvodQtwjMNPJrpkO2x08T+X+pQSvoE39BYo7+RVpUI+PyJkSXvQR/0R145JbF7QwnW
X-Received: from dlbqe2.prod.google.com ([2002:a05:7023:b82:b0:11b:13:9d43])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:78f:b0:11f:2c69:3e with SMTP id
 a92af1059eb24-11f35475ccamr2979494c88.6.1765584770388; 
 Fri, 12 Dec 2025 16:12:50 -0800 (PST)
Date: Sat, 13 Dec 2025 00:12:33 +0000
In-Reply-To: <20251213001234.2039232-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001234.2039232-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001234.2039232-4-marcmorcos@google.com>
Subject: [PATCH 3/4] qmp: Fix thread race
From: Marc Morcos <marcmorcos@google.com>
To: maintainer_email_from_script@google.com
Cc: cc_list_from_script@google.com, qemu-devel@nongnu.org, 
 Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3gq88aQoKCiUNBSDNPSDPTHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--marcmorcos.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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


