Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0226CC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGC8-0002UY-LO; Mon, 16 Jun 2025 16:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC5-0002S9-AP
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC0-00072W-Rk
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-234c5b57557so46990145ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750104750; x=1750709550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgOv3QDrLKhGVW571WktLHmM4FnfBbBuC/m2NpVkdPg=;
 b=S3Oay+OBJEdhBxmbeZMuhpZh03ZbsjnZD2jjx46EYjLq60+ASQz8r6csf5cJyc5/n5
 Z8w24u4wlWNRgvOXgWdh9E7cStfS9GUbQ3clT4P/cjK0/wdts3py3zom8nIAUGgLcwtY
 ZQdxsGVypbTgVL9SAo/8E/sBRYBRsWzB0YNMpq1spbtFemVa9Z0+wb4z1tT9zvFsgoMa
 l82gDmrn9Y3L0w6Gqjc7a98xwRPTMMkCWqFMldd34knsrYY2u9m79foeEBKhxHKql3gK
 OCMoFSwL3BbL0s9wQ3dCnBiq0xt2Yjl08cnOV41rrP3r8u+vzTyO90QbE+o5DEYWcRKy
 74tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750104750; x=1750709550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgOv3QDrLKhGVW571WktLHmM4FnfBbBuC/m2NpVkdPg=;
 b=iCstnnMDqmQULFlEqHYPsr/L9+JRQu7Wt+jhM9AP5R8KyYTISTJznB5wmxWvZikOkr
 zKFaUFX7PTVmVoe2NEL3WJKAWmTCmGmqeZXNuIhs9hGN55Qd6tAz3AEGt5Sx4MoXUL8l
 bj2cYiXJnrWx5n2cneugj+yMLkxHGOwzOtDv6l+USyDHcyNgdwbgMheXFF/33PojdALF
 2/1vk9HWgHjsQ+Mntd8Hlr/0Jvh9jOTpR3WMp6NiqefLVbuTvVIMudFn2Ulj/D2lZg0k
 tgGLWNlrH7Gq8n1Xl/S+I4zslyyweh535eypKXSms7d2GnENSkXlWzmPoa+ZFnzi0h2N
 TfEA==
X-Gm-Message-State: AOJu0YziOZihh6/paOfoW3YChv6g5i0mljOPicAXsPjuEd5RD5mSHgTZ
 CM8gVeQWaI55cGJ6PAQVIzgICfogzelRU5nfS2MEoskWtxoixnO58m5ohaFkfKGxLnE7Rw==
X-Gm-Gg: ASbGnctoFq4RhymS6Pb9ihNldB8w/xEH9bxvDAI47NtaVAvkxEAAff1Y11rNYkCJzGv
 p6HIt+TkwmXKN670riOoF2VpAFUzPPifbLUplAEaZacxwlcURRPDHm/KC/L7WyrxfaRQc3PPQeg
 cgbKHal9QJkjIBIwMATRoIzRj8YVCA2+ozaYKM+bukf1ne0VH/+JuSHDoHptU+HosF2PzEh4mNp
 PUfTVeUx+TQXtRvHyoFsOGKoqnwrVd5AgT3fT5+TyYujLJQVuXRnz759lCkjqe9WWOHx5iS9YFM
 YFS5mL9TMuQvULNRcBfPSBlOYqX9j5Ql3qzSd2s/LP3KDpQEIuOrycjGfLUPYbDkR6VC6ezrgBO
 HwQ==
X-Google-Smtp-Source: AGHT+IHRcn+Cd7E7Imk4di+9+p9PyhEH+jIPZL0wga1pLreg7d1TbCRbaAR7bE+nXvs7KThvFaiUQw==
X-Received: by 2002:a17:902:8bc8:b0:234:a139:120d with SMTP id
 d9443c01a7336-2366b32e4ebmr97028755ad.7.1750104750542; 
 Mon, 16 Jun 2025 13:12:30 -0700 (PDT)
Received: from ubuntu.. ([49.207.59.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1642dfdsm7369494a12.18.2025.06.16.13.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:12:30 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 1/3] tracetool: removed the unused vcpu property
Date: Mon, 16 Jun 2025 20:12:20 +0000
Message-Id: <20250616201222.6416-2-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616201222.6416-1-tanishdesai37@gmail.com>
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x62f.google.com
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

The vcpu property is no longer used in these backends. Removing it avoids
unnecessary checks and simplifies the code generation for these trace backends.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/log.py    | 6 +-----
 scripts/tracetool/backend/simple.py | 6 +-----
 scripts/tracetool/backend/syslog.py | 6 +-----
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62e..f24acad74c 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -31,11 +31,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        if (message_with_timestamp) {',
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 2688d4b64b..7c84c06b20 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -37,11 +37,7 @@ def generate_h_begin(events, group):
 
 def generate_h(event, group):
     event_id = 'TRACE_' + event.name.upper()
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % event_id
+    cond = "trace_event_get_state(%s)" % event_id
     out('    if (%(cond)s) {',
         '        _simple_%(api)s(%(args)s);',
         '    }',
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6cc..6fdc1142fb 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -30,11 +30,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-- 
2.34.1


