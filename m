Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1386C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScsD-0000J7-UX; Fri, 20 Jun 2025 10:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScs3-0000Hj-6Y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:35 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScs1-0001is-0d
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:34 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-311a6236effso1331740a91.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750430250; x=1751035050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mo/UcdRBnmSx+dkvg7nn6+3os5maF0Sk3Z74fE1uACY=;
 b=bE1ajetK0L4hp9s9Llkq61XqEWHVv1of1+ToG0Y90y+f2AX4l19/r7GTo6cS96cGk7
 TNf+y4cKpNeflPO7xqUEPlu7op43/+nJflPwl2UmR4UCD0lc6fPvROLVzwgKxwiqN/AO
 fvDSjqTIhNvDVxeIorZmmRFW5k0lYd8Ffte/aQQBXG2xvx/kXVCQSghVSif5vs070ZJ/
 Zmgta12mJxt/dHT6LCwVq5Gr5tXc+XTynmBXrvqRlGQjj0lRJCeOipS9NFJfFs35r2gx
 ap5vXH878yWYEuW0w/OSAP3R/CRelT8ga5SAVUOq96cV07uAHF9KLMIUVHe/RucaSqwD
 NfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430250; x=1751035050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mo/UcdRBnmSx+dkvg7nn6+3os5maF0Sk3Z74fE1uACY=;
 b=Lr77RZ3jZOyIdffGnKHwIt4W4GYc21q56VcWv+elgB3AI01GhOffspGAdD82S42quO
 mH5FaLsyPPGbJQ2h/0vfM8F5OAtkRjZmy178tGZFag0iAL3WnDnXFv5ohAWuMdAbOLyn
 UpQJGT+DkSe/tqinuTO+2ikBNGSQ893bTqqIKkYX6qgcYKabzAR7dEvn4Y3ydbyY+MgM
 DuLT6eu0FBhqKHXDhJsPzPwuFgCcuZVcqLXSfijAgpQrpV/JJpYG85+x8GaSu+wBs7cz
 qw1rI0JPBDag/Jd2kvu2Lw6sWi+kzzXEhNgUNRdpszYHVs35KNyue2AnCFmNGsELqxNZ
 TEAA==
X-Gm-Message-State: AOJu0Yz2YXZzejSLtS3VmzxnI+4zLupINuqpRqokh7blU5LyjvYonIj4
 qcqKYG9b96bOgktoKTjK/lJd5mtMsQ0z6OLU6+o+ZUhj6W5BwBbWSz5OGyp0XqdKfcIe6g==
X-Gm-Gg: ASbGncsgmWbs9rAArYtC65SngM8aWcYmQMtUKJEXgho6XhwFn2wjkMpjyKRXwwiygOo
 sbaHHH4RIelxOzONpoiMuhuJ16ath2b+I7+BK0NbaWmCqSL78k0SUxANlebFchmwTFpCmwsGxEC
 slgrbZXzLRgHfD8J6WHRwRa0H+5/xxWMT3Sm80/jQJfmrVBijhx9ElEtFVfNFP7vSPaOrL+5MyA
 a+fbR7OpEfU2l4Z3ER2QXpu7K5rhnmmBXQtLql03gh+BbRnPCUB07KN/iJxvmhQM8h9UyyrvRBv
 B1CmrOKAhilEPWDKl4hM8YMnC/CYL3QOAOLxvI8pEHwRh1E+Opm7tG7vAUm0fEFKcXLGhiDhB30
 /8PXfy48=
X-Google-Smtp-Source: AGHT+IGg8UVSEyjWg/V2EETztL/F211NPlIQJLdlQEf3yvz4E21Wu9inpqoriaroxDhvRDHuqq5GAw==
X-Received: by 2002:a17:90b:1e53:b0:313:31ca:a69 with SMTP id
 98e67ed59e1d1-3159d8c8f6cmr6349137a91.18.1750430249983; 
 Fri, 20 Jun 2025 07:37:29 -0700 (PDT)
Received: from ubuntu.. ([27.61.32.140]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a2f0cf5sm4368820a91.26.2025.06.20.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:37:29 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v2 2/3] tracetool: introduce generate_unconditional
Date: Fri, 20 Jun 2025 14:37:19 +0000
Message-Id: <20250620143720.3143-3-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620143720.3143-1-tanishdesai37@gmail.com>
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pj1-x1031.google.com
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

This patch separates the generation logic of trace_foo() for the UST
and DTrace backends from other backends.

The motivation is to remove the unnecessary if (true) in the trace_foo()
function, as UST and DTrace do not require a trace_event_get_state check
without introducing a seperate function it is very difficult to generate
code which keeps them out of unified if condition.

With this separation, we can safely move the trace_event_get_state check
into trace_foo for the other backends only, keeping UST/DTrace generation
paths clean.

A new generate_h_unconditional function has been introduced for UST and DTrace.
It behaves similarly to generate_h, but is defined only in UST and
DTrace backends.

This ensures that generate_h is used by the other backends, while UST/DTrace
selectively use generate_h_unconditional.

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


