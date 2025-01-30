Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC365C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRvY-0003eC-LL; Thu, 30 Jan 2025 05:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRvW-0003dk-OM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:37:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRvV-0002Yt-6K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:37:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso4033725e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738233455; x=1738838255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg5MaFKnNzop8+TLP/dVC/2mW49fQZIVVDSrPsECg1A=;
 b=K3Djlh6ugtlKCQqmgHwDSSs+C6dM6WLkxogf+9cDAcW+VBEbJhulvStOskkFRbddRV
 pQZa5ah6uwGTajaG6jCBRgT/kD08+XHQQi9c4U8llUkT/ymn36xVwpkmbbs20FOzCIz8
 MRFYmAXfIz/t0rPaV6JTex3TueGusS3B/qdlVp47bjCKDDM2A1n0giCpYYf9CkcO5ik1
 iIxBLYVO4OYlqKmTA2OEYNZtYxBDB69cBUpNh4w6SMQpXaRfZ1TCgRhE6dvR96yzGTg+
 LkEzXh1gQmnWko7Am+LCNjlW+MqX8QRtFNLwASXP/C3tdEAkh6dK+5W/k2rK95fpZPHc
 oiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738233455; x=1738838255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pg5MaFKnNzop8+TLP/dVC/2mW49fQZIVVDSrPsECg1A=;
 b=OizelDYBZUFyasYYV0g3lt7TcWFX7s6npIkln0hsYUAyXGDQKJoCIKP4Q9oKteaRpe
 najvrMypYgdGZhJKpIfWigsbcs1/vm3BVHhRYFjrqij4UukzSFMuU3Hd8zyELg+NKtC4
 Z4b8O45S8I4PWHgIPudMwGfkgWn2xyGWEiaC+6cyfjhw+Z2uSNLR3ywgKhlVn+bzd72y
 ZNTXwz3Co4DhD2uU8W71r0I/jAxHq4nNx4migtJIhhAfsGRxepvXoXK5VHJgunbXCHuv
 we/2O2aGvVddC20a6RaIN82RidROjJj1dKH+YoXvzMI5e837CPDFHrZ77soS8wlTD7dO
 Fw6g==
X-Gm-Message-State: AOJu0Yz1x1U3z69kRTXS9DzLxHbjwiRmgLmca3dpVpQX8WRO+zymGbC4
 35ae4Ieflr0zGJ0/3dA2eETUdcVbp3k0JlS/cYNy/gn3OeXZlxDkhVMY/5PJOVo7shpJWQ0zKSg
 hzUs=
X-Gm-Gg: ASbGncuQaLaiplzu3Vk/SMtAa7yPTPYkgknMEqLrLa2v6bCkaEW6J+CM4HC/3R8uuHh
 OxlozmgFWU8ujtBn3WF4tqycpw7Z/3NLy521MC5VwVGz9Fgaq6GKMf2zlH1L+V5q0auw+5PAcZ6
 RGXhKKFhDzVj2KhBiB3aO5Nj8zlziBfrn1EZmNcZ/v7BNoHaFhslEnxDbshNsE8ZdSeybJJ0sEp
 LZijGKexUe24snb6RLB7C/moF83f7dawnOBZAfQ7lisFoqp5PI20YF4v3IIaqziSOEb190v8S9B
 B9EExRfQU0fN0nx8Cr9ngQk+6oH70G8lxIeYTTx/bvU/9qc2u4VjHhfUjJSxEV4pIQ==
X-Google-Smtp-Source: AGHT+IG+nd03K6bXfTItyDPlrQaxlloknSN7c9PECZGXc3Uso0wTuNV9xeI8f/uUiqaWMOWrrWjoWg==
X-Received: by 2002:a05:600c:3d9b:b0:434:f297:8e85 with SMTP id
 5b1f17b1804b1-438dc3c39d6mr65674835e9.10.1738233455104; 
 Thu, 30 Jan 2025 02:37:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf831sm1596604f8f.90.2025.01.30.02.37.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 02:37:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, xen-devel@lists.xenproject.org,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] tests/qtest: Extract qtest_qom_has_concrete_type()
 helper
Date: Thu, 30 Jan 2025 11:37:27 +0100
Message-ID: <20250130103728.536-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130103728.536-1-philmd@linaro.org>
References: <20250130103728.536-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Extract qtest_qom_has_concrete_type() out of qtest_has_device()
in order to re-use it in the following commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


