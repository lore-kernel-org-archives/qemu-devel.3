Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89886C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOh8A-0007bb-BF; Mon, 09 Jun 2025 14:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uOh88-0007bQ-Dm
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:21:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uOh86-0003PG-Lp
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:21:56 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3138e64b3fcso816735a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749493312; x=1750098112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxpiaOnOBTTIbdk7Y8S1B3jd7cKgGacR2QM0LlKQKQc=;
 b=N1zOiBr54hZcPWnEXrHYA7nYOmXezPuNnmjWAczKE3yOIIMCN9lK3kcwjDtX4uXZAG
 UEw6A2jya2bRioaZezV8VQijLGPKBd7uwSs74hPF5wvSWXPWim+hN1X1GDQxlZIhZWLT
 6tGHXeFRnMpufsGIJcvLFMTsDL+0pHUcSq0SFIPDThuA17Uw6STAWyW67b3Ij75uOeWB
 b3siDH3NDv7tFu2H7jkIRULjXfZi1/28a5yOLDg2uWrfeplJoGG/3pQTEAuDqzJ0TcGS
 q3k7Dt96EBKjGuu71QNhLG+HWTRue1dVLVWQI72U7nK91E7jOFT/DIkzz1D0dZOPptmx
 SFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749493312; x=1750098112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxpiaOnOBTTIbdk7Y8S1B3jd7cKgGacR2QM0LlKQKQc=;
 b=KnpL7qfVasaKgsTiBvSHzkVhbheWyLd4s4zGnDNJpJQFiyWs7Y9T0URQfpv0vflyGT
 cQzt8mEiiaDkNugnKoQA39jJhvSNfaLVAYglNj6FFZG4g3LrhjMZLr6nOam7+SMuV+T/
 iwK54DjWwdzhR7Hx/yGazo/Rq9DCKA+EmvnO20+L1xdrPfV0ZU49p6fPACMyu5PspsWo
 pkYA3Wl7FBikaCKjDzW+2rCXu8uXj/Xq3d1YyylRqss4/MLypItjmzwCHpH4O31tJoxx
 vtVnl4DuCnS5jpjoO2bOgDoy1UPV2KdvWvJ0nMGpTFiRR5i0EhO/2IzkM9I6YeQPEvlX
 pM2g==
X-Gm-Message-State: AOJu0YzC1xD6rA6KoemsqlKOttZ3QG+Jv6z0nJgwaaNXNCqjW+UwTclU
 1DSgtgiAfhMb+gFhc4Z5yA9tIMh5DDDvv5ENJ2yjVT6B4t8kvyICSD2JOiht+6wvvF1AgA==
X-Gm-Gg: ASbGncsSgnoLDh++W2R9F9nbL8cgO+T1aPKAy7Z27en3M83zvfoEmcOFEyU5zRwVzDO
 bDRQ3Val3rRopKuM8lki3sOnQUOobU3HgLpbDVBUxN2Yv/snjdGIVPCHgVuqKeTuebMLcJMeMzy
 JNadjp9WJBffiyhbQ9QXrANRCDBJpA0jf4ssuhahvPv/jZ9Tx/a5SZN6nkK+/b3K08N9L/pYUbA
 63HEN2LLeBG6J5tpJFCSp4BA6POYHuotiNQMK2Hwyg82kkbMIIAz4lgbJ0ZkFDEC4gcUN1sx1NZ
 JYRjb+cASaFjuDY5KvRZoBiRzVbqaPkv96PZZnzx+tY8Kws856vCw+uSexjfUwx2WgYW48l1
X-Google-Smtp-Source: AGHT+IFV6UkG8Pke8bGaSocejm/40sl+fdiMCVC7STnOAicYwcmS2+fAZ2fmHPXYnB1sCzE/XnLOoQ==
X-Received: by 2002:a17:90b:5203:b0:313:352f:6620 with SMTP id
 98e67ed59e1d1-313472c0109mr19779187a91.4.1749493311966; 
 Mon, 09 Jun 2025 11:21:51 -0700 (PDT)
Received: from ubuntu.. ([49.207.57.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b044e2bsm6009440a91.5.2025.06.09.11.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 11:21:51 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, mads@ynddal.dk,
 balaton@eik.bme.hu, philmd@linaro.org, peter.maydell@linaro.org,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH] utils/log: add qemu_log_timestamp() to encapsulate timestamp
 logging
Date: Mon,  9 Jun 2025 18:20:45 +0000
Message-Id: <20250609182044.21703-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Moved the logic for timestamped logging (~6 lines) from a_nocheck__trace_foo(header) into a new qemu_log_timestamp() function in util/log.c. This avoids code duplication across binaries and enables reuse as a standalone utility.
Encapsulation helps reduce build size significantly, particularly when many trace points are present. On Ubuntu 22 with
./configure --target-list=aarch64-softmmu --enable-kvm --enable-trace-backends=log,
this change reduced the build directory size from ~1435.27 MB to ~1412 MB (~23 MB saved).
Notable reductions include:
    trace/: ~2.6 MB
    libqemuutil.a.p: ~3 MB
A detailed report of size changes (in bytes) for relevant folders and subfolders will follow in a trailing mail.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 include/qemu/log-for-trace.h     |  3 +++
 scripts/tracetool/backend/log.py | 13 +------------
 util/log.c                       | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index d47c9cd446..680f30a8a9 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -32,4 +32,7 @@ static inline bool qemu_loglevel_mask(int mask)
 /* main logging function */
 void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
 
+/* main logging function with timestamp */
+void G_GNUC_PRINTF(1, 2) qemu_log_timestamp(const char *fmt, ...);
+
 #endif
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62e..3358afb43a 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -38,20 +38,9 @@ def generate_h(event, group):
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
-        '        if (message_with_timestamp) {',
-        '            struct timeval _now;',
-        '            gettimeofday(&_now, NULL);',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
-        '                     qemu_get_thread_id(),',
-        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
-        '                     %(argnames)s);',
+        '            qemu_log_timestamp("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        } else {',
-        '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
-        '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        }',
         '    }',
         cond=cond,
         event_lineno=event.lineno,
diff --git a/util/log.c b/util/log.c
index b87d399e4c..996530fe7e 100644
--- a/util/log.c
+++ b/util/log.c
@@ -143,6 +143,24 @@ void qemu_log_unlock(FILE *logfile)
     }
 }
 
+
+void qemu_log_timestamp(const char *fmt, ...)
+{
+    FILE *f = qemu_log_trylock();
+    if (f) {
+        va_list ap;
+        if(message_with_timestamp){
+            struct timeval _now;
+            gettimeofday(&_now, NULL);
+            fprintf(f,"%d@%zu.%06zu:",qemu_get_thread_id(),(size_t)_now.tv_sec, (size_t)_now.tv_usec);
+        }
+        va_start(ap, fmt);
+        vfprintf(f, fmt, ap);
+        va_end(ap);
+    }
+    qemu_log_unlock(f);
+}
+
 void qemu_log(const char *fmt, ...)
 {
     FILE *f = qemu_log_trylock();
-- 
2.34.1


