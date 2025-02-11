Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7EDC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6G-0005gL-HQ; Tue, 11 Feb 2025 17:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6C-0005f4-IR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz64-000548-6g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Z1xQZdmuz+frZCLJTmyASbiF2Y//N1ej3oUF9uqFc=;
 b=XwJviLEf/WCplq3U1VFtILrZsApnziW1vHm65WFtlK1F2f7X6VX1fLqzGQnOv/7No7+7cB
 r1XH+UKsxEL5iviGs9v2lkLeB0PadvFAZBymXl8acJZRhBDC4ISILAY/NP1L6XcniHbcBu
 NdOHffl/7eH4PRHXHKYQypL+gBiPGSw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-Wo5kRHj5NeWbrtWNlMURDA-1; Tue, 11 Feb 2025 17:51:14 -0500
X-MC-Unique: Wo5kRHj5NeWbrtWNlMURDA-1
X-Mimecast-MFC-AGG-ID: Wo5kRHj5NeWbrtWNlMURDA
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5fc0058d68eso1672270eaf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314273; x=1739919073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7Z1xQZdmuz+frZCLJTmyASbiF2Y//N1ej3oUF9uqFc=;
 b=o8vaqjOCp5I53tPEK7N5jICrh5eiyoCsFYxF6erpFRlqZ7SjG8X09pzknrd5/ctLMU
 7XzRMepMj0zZLBnOBA5YVPb6lo3RW3iFVBOGTrcFMD5Xz3BoYsCZwextGDdrdGhhlH1s
 k5pcJd/fMHKctNmzFb7vGZBWXK9HBH63jJvyueb0E56m8MDtyAEH91naDNGKx6e6EMzl
 +iFKL47D6+SaLD4p6p4qieAFOplXAyg5ZtwUp6WPYADqlYBE63txwGDVQ506KplIErgw
 F8w4mqFpUB84kds26aQsArCgXHpqOG8b/34XWKWmBG7AVQ1g8RvJSE6qg3m9nINu7NK6
 BDDQ==
X-Gm-Message-State: AOJu0YzLCPTmGp3hkoRgDQJhA43+9g52YWzKHPEZmg3uIkHZvmDDqJqU
 6vYMUKKKStOOYxtuscLwQ62jDwZfFngWfsyctBEn9zY555B02P/4r0CLRVQCR6Al/fzKCe6qDdz
 qnJ9b26UGQoRnReb598ZEWaagnZtx/PwbWZ/CuU7wPKdjhRrjue843Yc50HhJCAzOCQY4I2+Ts9
 A4mrQkQ5Ap7AQuhq9MA9dJzcI71H0YRS0lkA==
X-Gm-Gg: ASbGnctxIrSch4KMysKSR6fQvLbxROupe3OXCtWra7VMoat2IsfF0gT0W5y12ltF6yh
 E/TIMyc3k8pSi6nDkx4Aqm/P1tZgPKY/93VzuPDBZQ2U4stVojXeKIMJeCr7UmCNMNLaSz9dbLr
 ju+q3y9A/rAmLvY7J5P/b4NS6MMNNnviFr+1vm5CTtV/4bkJ2S4a7IloqTU7TL7EOYD80zLtzOx
 sYoHKxHrHz6fsbr1Ftwl8ngEvglA7jYXekD8E5UYoP0gAiPfwMBYboB
X-Received: by 2002:a05:6820:1b82:b0:5fa:67c5:5bdf with SMTP id
 006d021491bc7-5fca167f789mr832729eaf.2.1739314272714; 
 Tue, 11 Feb 2025 14:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4flg+A6h/N/Zm6BoFHKJZ7R6sQwmotZHIv+Q0KjwtkO/c+ESvfnYotD4b5Oz5kTEVgq7ZAQ==
X-Received: by 2002:a05:6820:1b82:b0:5fa:67c5:5bdf with SMTP id
 006d021491bc7-5fca167f789mr832710eaf.2.1739314272239; 
 Tue, 11 Feb 2025 14:51:12 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:11 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 05/14] overcommit: introduce mem-lock=on-fault
Date: Tue, 11 Feb 2025 17:50:49 -0500
Message-ID: <20250211225059.182533-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
anonymous memory with a write-fault, which introduces a lot of extra
overhead in terms of memory usage when all you want to do is to prevent
kcompactd from migrating and compacting QEMU pages. Add an option to
only lock pages lazily as they're faulted by the process by using
MCL_ONFAULT if asked.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Link: https://lore.kernel.org/r/20250123131944.391886-5-d-tatianin@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/system.h  |  2 ++
 migration/postcopy-ram.c |  2 +-
 system/globals.c         |  7 ++++++-
 system/vl.c              | 34 +++++++++++++++++++++++++++-------
 qemu-options.hx          | 14 +++++++++-----
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/system/system.h b/include/system/system.h
index dc7628357a..a7effe7dfd 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -50,9 +50,11 @@ extern QEMUClockType rtc_clock;
 typedef enum {
     MLOCK_OFF = 0,
     MLOCK_ON,
+    MLOCK_ON_FAULT,
 } MlockState;
 
 bool should_mlock(MlockState);
+bool is_mlock_on_fault(MlockState);
 
 extern MlockState mlock_state;
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 04068ee039..5d3edfcfec 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     if (should_mlock(mlock_state)) {
-        if (os_mlock(false) < 0) {
+        if (os_mlock(is_mlock_on_fault(mlock_state)) < 0) {
             error_report("mlock: %s", strerror(errno));
             /*
              * It doesn't feel right to fail at this point, we have a valid
diff --git a/system/globals.c b/system/globals.c
index adeff38348..316623bd20 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -33,7 +33,12 @@
 
 bool should_mlock(MlockState state)
 {
-    return state == MLOCK_ON;
+    return state == MLOCK_ON || state == MLOCK_ON_FAULT;
+}
+
+bool is_mlock_on_fault(MlockState state)
+{
+    return state == MLOCK_ON_FAULT;
 }
 
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
diff --git a/system/vl.c b/system/vl.c
index 2895824c1a..3c0fa2ff64 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -351,7 +351,7 @@ static QemuOptsList qemu_overcommit_opts = {
     .desc = {
         {
             .name = "mem-lock",
-            .type = QEMU_OPT_BOOL,
+            .type = QEMU_OPT_STRING,
         },
         {
             .name = "cpu-pm",
@@ -797,7 +797,7 @@ static QemuOptsList qemu_run_with_opts = {
 static void realtime_init(void)
 {
     if (should_mlock(mlock_state)) {
-        if (os_mlock(false) < 0) {
+        if (os_mlock(is_mlock_on_fault(mlock_state)) < 0) {
             error_report("locking memory failed");
             exit(1);
         }
@@ -1878,7 +1878,7 @@ static void object_option_parse(const char *str)
 static void overcommit_parse(const char *str)
 {
     QemuOpts *opts;
-    bool enable_mlock;
+    const char *mem_lock_opt;
 
     opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
                                    str, false);
@@ -1886,11 +1886,31 @@ static void overcommit_parse(const char *str)
         exit(1);
     }
 
-    enable_mlock = qemu_opt_get_bool(opts, "mem-lock",
-                                     should_mlock(mlock_state));
-    mlock_state = enable_mlock ? MLOCK_ON : MLOCK_OFF;
-
     enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
+
+    mem_lock_opt = qemu_opt_get(opts, "mem-lock");
+    if (!mem_lock_opt) {
+        return;
+    }
+
+    if (strcmp(mem_lock_opt, "on") == 0) {
+        mlock_state = MLOCK_ON;
+        return;
+    }
+
+    if (strcmp(mem_lock_opt, "off") == 0) {
+        mlock_state = MLOCK_OFF;
+        return;
+    }
+
+    if (strcmp(mem_lock_opt, "on-fault") == 0) {
+        mlock_state = MLOCK_ON_FAULT;
+        return;
+    }
+
+    error_report("parameter 'mem-lock' expects one of "
+                 "'on', 'off', 'on-fault'");
+    exit(1);
 }
 
 /*
diff --git a/qemu-options.hx b/qemu-options.hx
index 1b26ad53bd..61270e3206 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4632,21 +4632,25 @@ SRST
 ERST
 
 DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
-    "-overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
+    "-overcommit [mem-lock=on|off|on-fault][cpu-pm=on|off]\n"
     "                run qemu with overcommit hints\n"
-    "                mem-lock=on|off controls memory lock support (default: off)\n"
+    "                mem-lock=on|off|on-fault controls memory lock support (default: off)\n"
     "                cpu-pm=on|off controls cpu power management (default: off)\n",
     QEMU_ARCH_ALL)
 SRST
-``-overcommit mem-lock=on|off``
+``-overcommit mem-lock=on|off|on-fault``
   \ 
 ``-overcommit cpu-pm=on|off``
     Run qemu with hints about host resource overcommit. The default is
     to assume that host overcommits all resources.
 
     Locking qemu and guest memory can be enabled via ``mem-lock=on``
-    (disabled by default). This works when host memory is not
-    overcommitted and reduces the worst-case latency for guest.
+    or ``mem-lock=on-fault`` (disabled by default). This works when
+    host memory is not overcommitted and reduces the worst-case latency for
+    guest. The on-fault option is better for reducing the memory footprint
+    since it makes allocations lazy, but the pages still get locked in place
+    once faulted by the guest or QEMU. Note that the two options are mutually
+    exclusive.
 
     Guest ability to manage power state of host cpus (increasing latency
     for other processes on the same host cpu, but decreasing latency for
-- 
2.47.0


