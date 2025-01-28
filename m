Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E0C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjc6-0002Em-4p; Tue, 28 Jan 2025 06:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcjbz-0002EW-HV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:18:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcjbx-000551-PA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:18:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385df53e559so3993435f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738063107; x=1738667907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYrLqiOXcaakZxlAQt7EUmigWAEMqhVrl2IG/lxJyhw=;
 b=DWB9U66/eUyYqyAikz8fSeEqWtIBFLT6qGt6A+kJShZHHL29uiSskZwcP2XOgyZT5J
 Z2USlXtfwb/rJBaAdtFUqUnd2uN+oHPBZl8HsdzP34nzPRSf0CkUkejuk4RUZx10Dlee
 QZgOTez58ZInwlDxWIDbbKZ85797ULPjEkVR74PS3X/9RZ5NpI7DyFD/sB+3JAso+vW8
 a7zHgJuxO0CGDdp3M2JDBOskaT9ion3n5mzU++rYRr4HTBC4J1FwkV4gS6CKTmE+m6VV
 Fv7dxrYUUjZXGY1WEZ+Nj8MuTyke/YaDFE193O5Vlgz/1ukD6GXt0ff99SeAvHEQ+L9f
 lZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738063107; x=1738667907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYrLqiOXcaakZxlAQt7EUmigWAEMqhVrl2IG/lxJyhw=;
 b=RCvx8SitY/iQMPar5BilcC4xXk6XxnwVwJUCCWzSAbs1rMWkxKKd6Fot8r1NAccY5l
 eKHmfdwqajq7hrQavhzcoL5pXfGaPQLGG1Xi2NYSlTGZul+iJ3nce1ui2gdS+yroKSAE
 Y3WI7lh5L13n5iB8P+u/Xl5DwjolT1K1nWUSi5gRv839auN/fpgJfwgsotEcNkOvE1m7
 J1toyF2KOErWzMYMvMiTMOHzGOVZOBZpcm31mDwloST0dixQZuh2b8T+gbEBBb0b30CZ
 rVTN5gFxv6KaocvIgdgtQENcvLP2OZn5aT6FgHKs96yTb/jcRBiGCLMc0m2yHfWTLQZq
 Gx3A==
X-Gm-Message-State: AOJu0YzKsdLK7MnCRVYYMmS1iM5NNWYyc9/F0u5nZ5lZRrFZWlowMnj8
 2AkmenmQWuqQRUAHws50CyPkLzK3yJyc3zY4+CaZjW9fPYJMtb5BLeAaYQceLoDUEqmz9QE02pH
 RCxs=
X-Gm-Gg: ASbGncuU18/DvogcblHeqH+KDdeUKnbJzl/W+BREEZrmDGBZthShh/y8KjxxW2D66BG
 5aN3F/ypsbxgqny6k6g6eXviWVeJ8L6bKQtctwecCxRW5F7qEsfFDsLCorXbAapyJDPdwH5//Lo
 IcAiGpyrxdgC7MpUS1g/uZkOXnTdVsJnW15cjtUGMMjKiCdSScFfivoCyZr7LHHABQkh4/C/0OK
 uu3UZUYxhZ6vcK5vLHn/oR60uT0q/r3LNHk03TMScr36pnbcsN5eS1W/yR4al8AEKVvd/Uz39Zp
 6DOaG6/bAcrmNSY1XaOmN+wnbBzBAef5p4zyxfP/MjCW1/64iMeOocF6nBhwgkFuVg==
X-Google-Smtp-Source: AGHT+IHuyptLaRttD9sYQjH4mdAu0F/Xvz8DUVOj+7pYznWKRjFlcYnhiRd7S+GEQeAAPBF5mr0tSg==
X-Received: by 2002:a05:6000:1887:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38bf56639d5mr43298969f8f.21.1738063107562; 
 Tue, 28 Jan 2025 03:18:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17630asm13849683f8f.6.2025.01.28.03.18.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 03:18:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] tests/qtest: Extract qtest_qom_has_concrete_type() helper
Date: Tue, 28 Jan 2025 12:18:20 +0100
Message-ID: <20250128111821.93767-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128111821.93767-1-philmd@linaro.org>
References: <20250128111821.93767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Extract qtest_qom_has_concrete_type() out of qtest_has_device()
in order to re-use it in the following commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.c | 89 ++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 38 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index a1e105f27f9..7e9366ad6d5 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -978,6 +978,56 @@ const char *qtest_get_arch(void)
     return end + 1;
 }
 
+static bool qtest_qom_has_concrete_type(const char *parent_typename,
+                                        const char *child_typename,
+                                        QList **cached_list)
+{
+    QList *list = cached_list ? *cached_list : NULL;
+    const QListEntry *p;
+    QObject *qobj;
+    QString *qstr;
+    QDict *devinfo;
+    int idx;
+
+    if (!list) {
+        QDict *resp;
+        QDict *args;
+        QTestState *qts = qtest_init("-machine none");
+
+        args = qdict_new();
+        qdict_put_bool(args, "abstract", false);
+        qdict_put_str(args, "implements", parent_typename);
+
+        resp = qtest_qmp(qts, "{'execute': 'qom-list-types', 'arguments': %p }",
+                         args);
+        g_assert(qdict_haskey(resp, "return"));
+        list = qdict_get_qlist(resp, "return");
+        qobject_ref(list);
+        qobject_unref(resp);
+
+        qtest_quit(qts);
+
+        if (cached_list) {
+            *cached_list = list;
+        }
+    }
+
+    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
+        devinfo = qobject_to(QDict, qlist_entry_obj(p));
+        g_assert(devinfo);
+
+        qobj = qdict_get(devinfo, "name");
+        g_assert(qobj);
+        qstr = qobject_to(QString, qobj);
+        g_assert(qstr);
+        if (g_str_equal(qstring_get_str(qstr), child_typename)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 bool qtest_has_accel(const char *accel_name)
 {
     if (g_str_equal(accel_name, "tcg")) {
@@ -1757,45 +1807,8 @@ bool qtest_has_machine(const char *machine)
 bool qtest_has_device(const char *device)
 {
     static QList *list;
-    const QListEntry *p;
-    QObject *qobj;
-    QString *qstr;
-    QDict *devinfo;
-    int idx;
 
-    if (!list) {
-        QDict *resp;
-        QDict *args;
-        QTestState *qts = qtest_init("-machine none");
-
-        args = qdict_new();
-        qdict_put_bool(args, "abstract", false);
-        qdict_put_str(args, "implements", "device");
-
-        resp = qtest_qmp(qts, "{'execute': 'qom-list-types', 'arguments': %p }",
-                         args);
-        g_assert(qdict_haskey(resp, "return"));
-        list = qdict_get_qlist(resp, "return");
-        qobject_ref(list);
-        qobject_unref(resp);
-
-        qtest_quit(qts);
-    }
-
-    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
-        devinfo = qobject_to(QDict, qlist_entry_obj(p));
-        g_assert(devinfo);
-
-        qobj = qdict_get(devinfo, "name");
-        g_assert(qobj);
-        qstr = qobject_to(QString, qobj);
-        g_assert(qstr);
-        if (g_str_equal(qstring_get_str(qstr), device)) {
-            return true;
-        }
-    }
-
-    return false;
+    return qtest_qom_has_concrete_type("device", device, &list);
 }
 
 /*
-- 
2.47.1


