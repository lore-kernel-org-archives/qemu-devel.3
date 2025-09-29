Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA39ACCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9d-0001LF-DF; Mon, 29 Sep 2025 11:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8r-0000pv-Gk
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8X-0000LS-NR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjND0aUj9KRlLexwJ1p+kxgUGn2cNQpl2JPdVKoLLh0=;
 b=ckI5cV2xodQxFlw4EfCOh0r9FtF9mW+vvc6hZwBcAqpYAwdLqVByczE+Jx87YAnLJ846kF
 vtmlI+p1U3gf3mFAZtJXCvwp7uZRXnkhFx4wpdztYu9UfLE0rWUUXentyUuq/QytgjSqXt
 QCGG7N2/sjA8703/57iWz3Du81HLqMQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-feaH2fCJMfqggnFtMGtygg-1; Mon, 29 Sep 2025 11:49:56 -0400
X-MC-Unique: feaH2fCJMfqggnFtMGtygg-1
X-Mimecast-MFC-AGG-ID: feaH2fCJMfqggnFtMGtygg_1759160995
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-634c2fc71c9so3960433a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160994; x=1759765794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjND0aUj9KRlLexwJ1p+kxgUGn2cNQpl2JPdVKoLLh0=;
 b=UQet9JsRqCiss607G5CFM3ekkuZvGE1aSRwzkHQ8gHjyPvFXekbWpit9Rocnw4aGaH
 egbOJF5FPJF9TKGV1SdZweebF2643YZvorCa9QDy/NxXFywytUAi1IpmzIAqVSiwixkb
 JAJF5AXS9NtJerfXV0vKQRWIt+5++iLFDv1Jg1eXhidRZfbVUaVn5PUMt7LK7BFpU2D7
 24qBETBgiRITZ5+mXoIzEvEY84IH0lX7ewkc+FFf1SELcyLE9z3/XM3K8hEmWLCy61iF
 RjxQisbbMzv67nGN6J64JiUMlxAKhQH+Dyj4wBoQPCQgxdtmbOdiHLbHUiFMTY1dp1qF
 Yhzw==
X-Gm-Message-State: AOJu0YxO7ME+dDf5j0GlX5o8frgAx6dqX3lrwxKTGFQLLfHPiKjKaHnv
 flAKMJ9CW9b8RW+HigC/TqzfH1H1epbNMfxKRYyllVzQ0dPg8RzGvpUe5+9m6GCdpkFD5j21HuU
 L9EKO79aCnUfQwZlK742DOI22Yp99hI6UB7iswmQtCN6E/u05ZHrO+upFl4aQqpIRsrTtiwFWee
 509VoRZzTb2gu4OJNMF88zaACW/HemyCExKKEnueKO
X-Gm-Gg: ASbGnctKXIp7Yz6218PHN7LgeDmO+h1VtPFUEhhYhDdYrIlVywPGjtRc4wMfHtfe8Rw
 KTIxTgNa+Th6mU59iN0dYEcLmX/+9Idz9ZDWWHph89XaUhcrrj7PbC7/IVsrZ/d67byNJ736SMY
 QM0F0hY7cK8TpEgWqZEL+C0hoKr2YtwaxxgsmJnpaI7C+6GwNmBOGKsNeciXbazb8w2gSr6CA5w
 aLu+W+CFbsInfKRU6TyfCCHNijvGL1A60rDSJiOjXv1Usr4dh7jAPu80hgqydRBVBJ26K80ajZv
 WQ+OszvxAgn8BIBh3TeKmTvAwqbKDln5FzAo0AimTQc9in3bSjjLCsY0RM8PrvIemPzTrsTAbJP
 4p2mWgE0NdKBQoBQlhNL++I7Tj/hw4gotgZUyVbI+ONhVbQ==
X-Received: by 2002:a17:907:9719:b0:b04:1957:8e72 with SMTP id
 a640c23a62f3a-b34bd053b67mr1751123566b.65.1759160993995; 
 Mon, 29 Sep 2025 08:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKO9VryLhKU504aYLxA60cVWk4YbnI4yzk6F9rOZvT0rFxzsDRodNbJ93yIEvGPTluvssMZw==
X-Received: by 2002:a17:907:9719:b0:b04:1957:8e72 with SMTP id
 a640c23a62f3a-b34bd053b67mr1751120366b.65.1759160993538; 
 Mon, 29 Sep 2025 08:49:53 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3ae61b7260sm490844766b.48.2025.09.29.08.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 05/16] trace/ftrace: move snprintf+write from tracepoints to
 ftrace.c
Date: Mon, 29 Sep 2025 17:49:27 +0200
Message-ID: <20250929154938.594389-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This simplifies the Python code and reduces the size of the tracepoints.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tracetool/ftrace.h            | 28 ++++++----------------------
 trace/ftrace.h                      |  1 +
 trace/ftrace.c                      | 15 +++++++++++++++
 scripts/tracetool/backend/ftrace.py | 12 ++----------
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index fe22ea0f09f..1dfe4239413 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -21,18 +21,10 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    {
-        char ftrace_buf[MAX_TRACE_STRLEN];
-        int unused __attribute__ ((unused));
-        int trlen;
-        if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
-            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
-                             "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
-#line 33 "ftrace.h"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
+#line 28 "ftrace.h"
     }
 }
 
@@ -42,18 +34,10 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    {
-        char ftrace_buf[MAX_TRACE_STRLEN];
-        int unused __attribute__ ((unused));
-        int trlen;
-        if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
-            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
-                             "test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
-#line 54 "ftrace.h"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
+#line 41 "ftrace.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/trace/ftrace.h b/trace/ftrace.h
index cb5e35d2171..16c122816d1 100644
--- a/trace/ftrace.h
+++ b/trace/ftrace.h
@@ -8,5 +8,6 @@
 extern int trace_marker_fd;
 
 bool ftrace_init(void);
+G_GNUC_PRINTF(1, 2) void ftrace_write(const char *fmt, ...);
 
 #endif /* TRACE_FTRACE_H */
diff --git a/trace/ftrace.c b/trace/ftrace.c
index 9749543d9b2..6875faedb9c 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -38,6 +38,21 @@ static int find_mount(char *mount_point, const char *fstype)
     return ret;
 }
 
+void ftrace_write(const char *fmt, ...)
+{
+    char ftrace_buf[MAX_TRACE_STRLEN];
+    int unused __attribute__ ((unused));
+    int trlen;
+    va_list ap;
+
+    va_start(ap, fmt);
+    trlen = vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
+    va_end(ap);
+
+    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
+    unused = write(trace_marker_fd, ftrace_buf, trlen);
+}
+
 bool ftrace_init(void)
 {
     char mount_point[PATH_MAX];
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index a14aafcee62..8c0ce3f23a0 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -28,18 +28,10 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    {',
-        '        char ftrace_buf[MAX_TRACE_STRLEN];',
-        '        int unused __attribute__ ((unused));',
-        '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
+    out('    if (trace_event_get_state(%(event_id)s)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
-        '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
-        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
         '    }',
         name=event.name,
         args=event.args,
-- 
2.51.0


