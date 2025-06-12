Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C55CC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 12:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPh2h-0002V0-NU; Thu, 12 Jun 2025 08:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uPh2f-0002Uj-I7
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:28:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uPh2d-0006y2-Gl
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:28:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22c33677183so7444855ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749731300; x=1750336100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m02+F5MiVnJQFIfIv3hYeXpw9ghwtDidGli202nMygI=;
 b=MwowxhLxO/Kx3WIbkoJ571SDErxxOWTVXJvCq+bdVjt+PtrohIs8WPRT5P1S6lDZAB
 pXTBbqxR3+7iCadMvTeDrc8N9+N5YGCnhjI/3D7BUjgf+eL3eNskwJwyvu9P0YJ39HZ8
 WR7GxABnSPO1/+904Xw3uLE8GW11Hs4so+1UuJ9uQUjjsiDg1qKO9ZM7CQylPsWhmV/v
 mSIH9mqGJ9O1q6TGV4QfTK5GDCUg5saq3CFQtO4/YTPWAD3cHnjThoXomPPB7I6ys8OU
 mdMxWNgd+5OjYL4+c4Qa83pNojpfNYy8Q2xX0PbfkvzqtQgCMiIEVJ2gUc3/HhMgT9ez
 t3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749731300; x=1750336100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m02+F5MiVnJQFIfIv3hYeXpw9ghwtDidGli202nMygI=;
 b=ruuPxYxO6965T7WLMaE7fiM64Rn0Lf+g2tO17yN8yLiMFRL7EtdrF6XuXZoeFTs8MH
 rLF2wlqU/BZQb6VOp3ObyRPYVYjJQLES+bZADBGuqecHhRGl8v0RHuMvcVqwQHyH+x/h
 M9pnvw5C/xKnQSXYVShxtzF6d9ycHlWGU25gHk3ev107WLaFq+wjg5y0VrcIU6PJ3rBH
 WkNTdccP+uAval68/WjZ80BEFrB24N3eRbkbmZd5kY+YlGZNhf3/yqnBcxMYhf8wFO7k
 bsTdLO5hgAATKkpRBWxn1/k9sxztFoKOPNBmSW3n8RC7WhKVUuvU8fcZ3TEFw6yN9Tfy
 fAeA==
X-Gm-Message-State: AOJu0Yz7Zj6ywpT/nG1eok3/HkXcJXAZRXB8l09S18Ddy5ORone6DHmI
 C/aansQvT9PesU61o4ouHZSzLXnORUwIZJWG0zsWANpASRPczcbP0UDKeIB8qOcCQq/etQ==
X-Gm-Gg: ASbGncvs2SJpcCRGD94zjKATngUxFsWfxzSaBbfEJRn/v3Q7LJGcjFz6n54fHr6pdkK
 +WPJZWVj+SuuxiqxXMQFAPuRLYVP+twoKBI9+A+L0xzDyb6ZeJRf4zHmeD+OCHj0q/pQeUp+mm3
 5rYG7l5g/0fZHpc3W9QZdB5eMWlN3sefMfXpwxPG4NJqvxaEYrVMeqKEymAyqfz3Qix84rdUehd
 47ASScySbBPWmJ9hlqxjfWcce/3Jfi7eR0tX3i8DTo4ZZl0b5QItJ3Q6pY9Eo+rQE2E6Yza835V
 jU9Q7LGxtbGokR/JtAr6mQQ/bqx7N91ko95Q33xTF9rATsUA5dZCNWoWXrwauWmtyJ4ANYlu
X-Google-Smtp-Source: AGHT+IFk5owXjZpBxYYhCouQRcFVlNV9j+9kJi0wZWc/KTYTBTor4+FIyXG+0meYl4d0ERZ8HX4x0Q==
X-Received: by 2002:a17:903:1a8c:b0:22f:c19c:810c with SMTP id
 d9443c01a7336-2364cabb390mr42546225ad.51.1749731300091; 
 Thu, 12 Jun 2025 05:28:20 -0700 (PDT)
Received: from ubuntu.. ([49.207.62.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e7031efsm12510625ad.188.2025.06.12.05.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 05:28:19 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, mads@ynddal.dk,
 balaton@eik.bme.hu, philmd@linaro.org, peter.maydell@linaro.org,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v2] utils/log: add qemu_log_timestamp()
Date: Thu, 12 Jun 2025 12:27:19 +0000
Message-Id: <20250612122718.18863-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x634.google.com
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

Moved the logic for timestamped logging (~6 lines) from a_nocheck__trace_foo(header) into a new qemu_log_timestamp() function in util/log.c.
This avoids code duplication across binaries and enables reuse as a standalone utility.
Encapsulation helps reduce build size significantly, particularly when many trace points are present. On Ubuntu 22 with
./configure --target-list=aarch64-softmmu --enable-kvm --enable-trace-backends=log,
this change reduced the build directory size significantly(~3%).

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
index b87d399e4c..6cd2a974c4 100644
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
+        qemu_log_unlock(f);
+    }
+}
+
 void qemu_log(const char *fmt, ...)
 {
     FILE *f = qemu_log_trylock();
-- 
2.34.1


