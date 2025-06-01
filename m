Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06C1C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 18:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLnAu-00021Y-QN; Sun, 01 Jun 2025 14:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAt-00021I-CU
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAr-0002ow-RA
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c9563fd9so2935045b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748801564; x=1749406364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WBLhmVUNFmmWr7iWGyD+QREshlRfuZn9YAw+EwxcsE=;
 b=lpMXUTP+2r/dBFp6QuWzwZK895DPgXVBXaT7Eb+nKjdcqZI3WCYWbrZoFrH/50KJ2U
 G++tfRcBZEIWPLwPKbPttThbf+63AQ5128LHql1yVCQeEWORs9wLkutW1Prs+WcP5ka7
 2/VjmGRRumdJPf+7HPTeDn1Ftedtd6JJvaVYIUxdlpeX8aC4c04uJjvSbn+Qin64T1oa
 1A2afBg04AOt3yVL9ydrDDiNy8gtvlzHMnR3Srsr/RjfdDljHz4j8p4kXEE8HRNfC6jc
 kvON1cqhE9NqFEX+k4DbVzqXac+U7P3JDfRooiPEZTIy+f7KyDl/Ofh1yJIclap+Ld+U
 eCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748801564; x=1749406364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3WBLhmVUNFmmWr7iWGyD+QREshlRfuZn9YAw+EwxcsE=;
 b=bq62lItsJyFBR4fDlX/eL1hjDeJLDwVrGyzOq/VzKk4+2FQYIUmyUVnnc9QN34JG+y
 aUDBaeGCiVoF8IMv3+89E3K3LeUO3WaEAEq4LGBwCd0I+GfJyfcIpnJI7eid5u3xtqYF
 2kQ/r+tAV7Ws5P9NaqRozBDIDw5WEan9guzxmCgvunTHA153kbq43Zip2ACn5sjDiPbK
 8hYWqRkZ8AJOcVbS982pnKLaNW2x84Kcz8uKmzRhvJ7RX+ZuwCgdRarDAegjy/m9nDq1
 32cS/LuBPsQYC3gx/FzUyjcTubBigXCYIpcuazlFBqgv9Nb+pHicg8DsysrJh7OjRuJ1
 VdrQ==
X-Gm-Message-State: AOJu0YxhnF70Pb3ID2owbNu1fxE2VDXT3DMZW2fvVpLZzCahkIkuWgGv
 I4tkNUr//NDpu38Ii/Q/jPdUsPCtD2p1p4XvcYJdobXMmmRlI5WMVFg5IH/zmVEp6pZM4w==
X-Gm-Gg: ASbGncvphJViFHAZv0GbI48HLCNcai+BQYHIQNDeksru6zzlthGEblg/lDpt9uU6Bno
 y8eSHmXi2xJBigXsSB4SnIf1UJzDjhZQn9tsGaFVHUM6B6NFz+hUuzGIkx9athj+QsBlGEBPjtB
 Ma6kHPDoQnrolnFSnRrCEn9ozRO0bTYCN6epsv/qFxOtXx2ctlr97DGjd/28mJFZP3qi8Fd+l1d
 pt/xSoOZSb9wr3Zsj63o5pKcmy4JhuHGRi8HssxoXO0NkDMQBQE3NWV0GxGhrXTyFAeInf4PxwT
 x1NEsiitFoU+gImVe5+7G4eA9zc9+iDaDXYTXyAa5EXvTRYks2mO5Qa38G/7Zw==
X-Google-Smtp-Source: AGHT+IGJ8LcEKExYmpW+rhMh2S/WK9qeFiecSO5i3z+vg1zitqHFCfw5LMF1q134xtjoCedPAGbqDQ==
X-Received: by 2002:a05:6a00:a27:b0:736:5438:ccc with SMTP id
 d2e1a72fcca58-747c1a83bd3mr13717140b3a.9.1748801563981; 
 Sun, 01 Jun 2025 11:12:43 -0700 (PDT)
Received: from ubuntu.. ([49.207.58.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afed4bafsm6189191b3a.79.2025.06.01.11.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 11:12:43 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Mads Ynddal <mads@ynddal.dk>, Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 3/3] trace/log: seperate cold path of tracing functions
Date: Sun,  1 Jun 2025 18:12:31 +0000
Message-Id: <20250601181231.3461-4-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250601181231.3461-1-tanishdesai37@gmail.com>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x42f.google.com
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

Moved frequently used hot paths from the .c file to the .h file to enable inlining
and improve performance. This approach is inspired by past QEMU optimizations,
where performance-critical code was inlined based on profiling results.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/log.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62e..ca53747950 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -24,6 +24,10 @@ def generate_h_begin(events, group):
     out('#include "qemu/log-for-trace.h"',
         '#include "qemu/error-report.h"',
         '')
+    for event in events:
+        out('void _log_%(api)s(%(args)s);',
+            api=event.api(),
+            args=event.args)
 
 
 def generate_h(event, group):
@@ -38,6 +42,22 @@ def generate_h(event, group):
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
+        '       _log_%(api)s(%(args)s);',
+        '    }',
+        cond=cond,
+        event_lineno=event.lineno,
+        event_filename=os.path.relpath(event.filename),
+        name=event.name,
+        fmt=event.fmt.rstrip("\n"),
+        argnames=argnames,
+        args = ", ".join(event.args.names()),
+        api=event.api())
+
+def generate_c(event, group):
+        argnames = ", ".join(event.args.names())
+        if len(event.args) > 0:
+            argnames = ", " + argnames
+            out('void _log_%(api)s(%(args)s){',
         '        if (message_with_timestamp) {',
         '            struct timeval _now;',
         '            gettimeofday(&_now, NULL);',
@@ -53,12 +73,14 @@ def generate_h(event, group):
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '        }',
         '    }',
-        cond=cond,
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
-        argnames=argnames)
+        argnames=argnames,
+        args=event.args,
+        api=event.api()
+        )
 
 
 def generate_h_backend_dstate(event, group):
-- 
2.34.1


