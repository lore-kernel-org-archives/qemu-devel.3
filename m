Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C911C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGCG-0002WD-4j; Mon, 16 Jun 2025 16:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGCB-0002VC-JS
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:44 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC5-00073s-8y
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:43 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso5905440a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750104753; x=1750709553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uq8r4SY6dBJOUCHBztuIABwLi9QFf5rV0uIKi8BAX2Y=;
 b=UQZ6AIo7i0PPJb04zBK8i1qBvxvmt0khhnODL8NZY+Z4hsYyh8wSUxMo+bcdmGrGi8
 3n3yqnw4S6+CueEqT6egZUzxrZOjL0Pz0n/rmZu9eNqT6BTyl+X2gvAR4DAoGPn3qh1x
 4UmSu92+MAx6mDfo1a5Z56izQ3omWyST5bkOiLqfIRzb6H4CPX6BescPQ1z/IMrsvCN0
 F/XhpBVrhrP2pJ/mrnWJR4R3xLb0HmlGLsaW15DjIqq2lFxurfWTmM5qLsBmOAIzMd/D
 nKyPFhCq0RmNG91wL9aOhNFklcj4ETKBbFx5+KNLAyB10EBeC3p3R7TipJow6X2v8yhg
 8xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750104753; x=1750709553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uq8r4SY6dBJOUCHBztuIABwLi9QFf5rV0uIKi8BAX2Y=;
 b=GX7kN8+yYzStywk7LrbPtBHJuEt9Gbq25c39ZKI8LpnVU8caqE/Ozgy5z+D+Jdjufe
 bjcRtsatBgSxW8dI3nntEZsi9Cdxz71+YU4+Tx4ly5G8SFAb6Q9jtWL+lYmfEZ1wHWqd
 YRftBbLweI/bHmwZGAx0XtFa2ZVXrBwYxQi49q/DakILl78kah5mCbgK03T61cT/Kqa3
 m1v+FxOuQ2xR0TOy5UoUGvBrs7afKIGp5WhGS5k/TffWyVvzCOgINoDzF2+DTBvt/0PV
 YKQhM7AT8OMAJvVSyWkvCKmk81XI948AuLexGk5YswKdycNuXr3nFt9fCBdPPOdH9yCo
 MUqw==
X-Gm-Message-State: AOJu0YzJvw2s3KQsjUfmGeAlJVKWJN3NV+cVkvKpbf5p9j1+BUALmWUJ
 yPEjoW4CI3l4u3wk9IiddNB2u3SvPwGwf1vjwjYUx6m30fEM64N7m24+DqYnGmByiMECYA==
X-Gm-Gg: ASbGnctgNZvweO/OzcwJLNywhc77L2h0BmlWRBGUK8h1PqdsFEBFowJ9rHLlsgjXI+s
 OJjcmmKpsdbhW3stuorY2ugxE4YmQXdv347/xIbpvR/RIVMuSUGyuPCg8cy2EoyCkWXARvre+eF
 46aSQXqE775++YK7Les8UlsPfLCfJG9Vi9Cqzo1jaTymXhlbLZkqsL5Az2FPA8yAyaT8UwBBURB
 KB3mVRKxw948vNQ9TOreE0Jw19BboMAsyWwAleLdDIGCHBr7mQcgebilnAoD9FW0mqFH2oc//EK
 5eth2pwxpUVqO0mnf6u05zeFhiOZVckT+7ndVS6d980wVeFhWUmVrwiXB69IX/OE8hMQQ2gXFl6
 FQg==
X-Google-Smtp-Source: AGHT+IH2HblgeAwP+Nsiok75hKrwGZM2CSefExtvTqQzZyrNRCojSbSeJY68oUefXPV+QGBkII6HRA==
X-Received: by 2002:a05:6a20:e687:b0:1f5:9330:29fe with SMTP id
 adf61e73a8af0-21fbd4c7e08mr13286691637.17.1750104752982; 
 Mon, 16 Jun 2025 13:12:32 -0700 (PDT)
Received: from ubuntu.. ([49.207.59.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1642dfdsm7369494a12.18.2025.06.16.13.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:12:32 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 2/3] tracetool: introduce generate_unconditional
Date: Mon, 16 Jun 2025 20:12:21 +0000
Message-Id: <20250616201222.6416-3-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616201222.6416-1-tanishdesai37@gmail.com>
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch separates the generation logic of trace_foo() for the UST and DTrace backends from other backends.
The motivation is to remove the unnecessary if (true) in the _no_check function, as UST and DTrace do not require a trace_event_get_state check without introducing a seperate function it is very difficult to generate code which keeps them out of unified if condition.
With this separation, we can safely move the trace_event_get_state check into trace_foo for the other backends only, keeping UST/DTrace generation paths clean.
A new generate_h_unconditional function has been introduced for UST and DTrace. It behaves similarly to generate_h, but is defined only in UST and DTrace backends. This ensures that generate_h is used by the other backends, while UST/DTrace selectively use generate_h_unconditional.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/dtrace.py   |  3 ++-
 scripts/tracetool/backend/ust.py      |  2 +-
 scripts/tracetool/format/h.py         | 10 +++++++---
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 7bfcc86cc5..c4456a5efd 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -118,6 +118,9 @@ def generate_begin(self, events, group):
     def generate(self, event, group):
         self._run_function("generate_%s", event, group)
 
+    def generate_unconditional(self, event, group):
+        self._run_function("generate_%s_unconditional", event, group)
+    
     def generate_backend_dstate(self, event, group):
         self._run_function("generate_%s_backend_dstate", event, group)
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index e17edc9b9d..171b7e09ed 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -61,7 +61,8 @@ def generate_h_begin(events, group):
             '#endif',
             uppername=e.name.upper())
 
-def generate_h(event, group):
+
+def generate_h_unconditional(event, group):
     out('    QEMU_%(uppername)s(%(argnames)s);',
         uppername=event.name.upper(),
         argnames=", ".join(event.args.names()))
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index c857516f21..1564b490ec 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -30,7 +30,7 @@ def generate_h_begin(events, group):
         '')
 
 
-def generate_h(event, group):
+def generate_h_unconditional(event, group):
     argnames = ", ".join(event.args.names())
     if len(event.args) > 0:
         argnames = ", " + argnames
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index ea126b07ea..89d54b9aff 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -76,13 +76,17 @@ def generate(events, backend, group):
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
-            '    if (%(cond)s) {',
+            api=e.api(),
+            args=e.args)
+        
+        if "disable" not in e.properties:
+            backend.generate_unconditional(e, group)
+
+        out('    if (%(cond)s) {',
             '        %(api_nocheck)s(%(names)s);',
             '    }',
             '}',
-            api=e.api(),
             api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
-            args=e.args,
             names=", ".join(e.args.names()),
             cond=cond)
 
-- 
2.34.1


