Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CDBC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCa2a-00046z-TH; Thu, 30 May 2024 03:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa2X-0003lx-75
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:17:33 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa2T-0005Z0-5I
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:17:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a98so258772a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717053447; x=1717658247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvNLJpx/j5Zo3jUuprmrG9QQOioGNCv1AT/8qxYHato=;
 b=xeJyC6XsXA6ZwkQ/9uJ3898wIEn7oo5gk2l1orY+tXb3lVAkyBN9N2fW7G1G18jriS
 VR14WKujPtRbr5GlLT+CFZQllkFn1FwFOXL+QrXZbuLf1I/unxvhzqzE3ztlDbeHPoaU
 0t/KaSXyq9QiKbcvyX7CCIJzEAT1uFN0HDxp/yTwVFmzUsudc3pRZL+rp2bpbYYwhooy
 UPKH9yoGcmrGwxt3IY9JlKjmOrisksBgwuPVW9zOu/gDmQsV5ObL4DcVzw8aQXP0+7jU
 2zknAUZ/ydy0xDxExAbcCwhZQsc7p18rVktEY1MKGTnHySqnZj7ZQ8AFAKlejJx2MnD5
 uTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717053447; x=1717658247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvNLJpx/j5Zo3jUuprmrG9QQOioGNCv1AT/8qxYHato=;
 b=ScPMV7GMOy0+Kp03mwwHvlZmjM80H7kQLdfuyyMSBQ2iyUd0/Eijm9nt6O+gRKTXFp
 +WKwLTztwilqx5SXfKWWegIoUGSrO/JyYseF+yodbuCTxTtPDs/68Gj0FQZUqIQjybgQ
 HiGv07BbkEAQtRY+CwJMJP/HZ54h+m/zhL93WxnqFxhtV9ROgxyxlWhPeFM8uJFWZadb
 zZNis1DLKbJmfZOM5VOlm3vnQTCWR/urUVQ4II3DPNhVgpXezV0c3jTYfn42Ni631bt2
 abQZVXGGFdjY4HEpE8hUB8tsbvYkMsRTzJ62BD3fBZr9OqMekmXFNyD4OIwMPgTBcYW+
 cGkA==
X-Gm-Message-State: AOJu0Ywz7Cxg5mSomO7cZMhpJ1CQ0z2LzyuS5T1TejY69g/PU1cB382d
 FJtNbV151lc70phtcCskfAUr1J4fS9SJIELunsszf8UFyT8oQofgj677q20qrvPjNFb/uNfouwO
 v
X-Google-Smtp-Source: AGHT+IFd0MQME9y+AdoHJ/L+l9sF0jKQLvOXrwpGfTgPTE2I1eWDnEJvRLUCykaPdAQ6KVrS8JI3zQ==
X-Received: by 2002:a17:906:28cd:b0:a55:8f2a:950d with SMTP id
 a640c23a62f3a-a65e8d15723mr67171066b.16.1717053447075; 
 Thu, 30 May 2024 00:17:27 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a878sm16506109f8f.43.2024.05.30.00.17.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 2/2] trace: Remove deprecated 'vcpu' field from QMP trace
 events
Date: Thu, 30 May 2024 09:15:48 +0200
Message-ID: <20240530071548.20074-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530071548.20074-1-philmd@linaro.org>
References: <20240530071548.20074-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'vcpu' fields are deprecated since commit 5485e52a33
("qapi: make the vcpu parameters deprecated for 8.1"),
time to remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 11 -----------
 docs/about/removed-features.rst |  6 ++++++
 qapi/trace.json                 | 27 +++------------------------
 trace/qmp.c                     |  2 --
 trace/trace-hmp-cmds.c          |  4 ++--
 5 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a61894db6..187c8a3f97 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -148,17 +148,6 @@ accepted incorrect commands will return an error. Users should make sure that
 all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
-QEMU Machine Protocol (QMP) events
-----------------------------------
-
-``vcpu`` trace events (since 8.1)
-'''''''''''''''''''''''''''''''''
-
-The ability to instrument QEMU helper functions with vCPU-aware trace
-points was removed in 7.0. However QMP still exposed the vcpu
-parameter. This argument has now been deprecated and the remaining
-remaining trace points that used it are selected just by name.
-
 Host Architectures
 ------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f1e70263e2..1e64c27cd8 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -679,6 +679,12 @@ QEMU Machine Protocol (QMP) events
 
 MEM_UNPLUG_ERROR has been replaced by the more generic ``DEVICE_UNPLUG_GUEST_ERROR`` event.
 
+``vcpu`` trace events (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''
+
+The ability to instrument QEMU helper functions with vCPU-aware trace
+points was removed in 7.0.
+
 
 Human Monitor Protocol (HMP) commands
 -------------------------------------
diff --git a/qapi/trace.json b/qapi/trace.json
index 043d12f83e..9ebb6d9eaf 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -35,17 +35,10 @@
 #
 # @state: Tracing state.
 #
-# @vcpu: Whether this is a per-vCPU event (since 2.7).
-#
-# Features:
-#
-# @deprecated: Member @vcpu is deprecated, and always ignored.
-#
 # Since: 2.2
 ##
 { 'struct': 'TraceEventInfo',
-  'data': {'name': 'str', 'state': 'TraceEventState',
-           'vcpu': { 'type': 'bool', 'features': ['deprecated'] } } }
+  'data': {'name': 'str', 'state': 'TraceEventState' } }
 
 ##
 # @trace-event-get-state:
@@ -54,12 +47,6 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-# @vcpu: The vCPU to query (since 2.7).
-#
-# Features:
-#
-# @deprecated: Member @vcpu is deprecated, and always ignored.
-#
 # Returns: a list of @TraceEventInfo for the matching events
 #
 # Since: 2.2
@@ -71,8 +58,7 @@
 #     <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
 ##
 { 'command': 'trace-event-get-state',
-  'data': {'name': 'str',
-           '*vcpu': {'type': 'int', 'features': ['deprecated'] } },
+  'data': {'name': 'str' },
   'returns': ['TraceEventInfo'] }
 
 ##
@@ -86,12 +72,6 @@
 #
 # @ignore-unavailable: Do not match unavailable events with @name.
 #
-# @vcpu: The vCPU to act upon (all by default; since 2.7).
-#
-# Features:
-#
-# @deprecated: Member @vcpu is deprecated, and always ignored.
-#
 # Since: 2.2
 #
 # Example:
@@ -101,5 +81,4 @@
 #     <- { "return": {} }
 ##
 { 'command': 'trace-event-set-state',
-  'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool',
-           '*vcpu': {'type': 'int', 'features': ['deprecated'] } } }
+  'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool' } }
diff --git a/trace/qmp.c b/trace/qmp.c
index 3e3971c6a8..074a27b204 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -48,7 +48,6 @@ static bool check_events(bool ignore_unavailable, bool is_pattern,
 }
 
 TraceEventInfoList *qmp_trace_event_get_state(const char *name,
-                                              bool has_vcpu, int64_t vcpu,
                                               Error **errp)
 {
     TraceEventInfoList *events = NULL;
@@ -86,7 +85,6 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
 
 void qmp_trace_event_set_state(const char *name, bool enable,
                                bool has_ignore_unavailable, bool ignore_unavailable,
-                               bool has_vcpu, int64_t vcpu,
                                Error **errp)
 {
     TraceEventIter iter;
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index 86211fce27..d38dd600de 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -40,7 +40,7 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
 
     qmp_trace_event_set_state(tp_name, new_state,
-                              true, true, false, 0, &local_err);
+                              true, true, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
@@ -82,7 +82,7 @@ void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
         name = "*";
     }
 
-    events = qmp_trace_event_get_state(name, false, 0, &local_err);
+    events = qmp_trace_event_get_state(name, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return;
-- 
2.41.0


