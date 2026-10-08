Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA59CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt3g-0005IC-AB; Thu, 08 Oct 2026 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt3e-0005Hd-5G
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:41:34 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt3c-0004kH-NQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:41:33 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-16079d54c17so2772674c88.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791484891; x=1792089691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WCspp2e/GZmkeo9++AMsuDc1oZL/s0taAPRrDEZnR80=;
 b=hVu7l2sQUqUBi2hEXq7U7kAddI6TjvbcmWEJXjN+nAyMAV45k82hxQPYQhsHpkU32b
 30NMzefuCrgnIxq+lARswnGyNK151QlOmGPklP3uKhm2ZGC2+XJ3xWCB67P9Dw53C2ZL
 r+SxT5pOaltAmGHYUziUNhtYK4Vn1ZX6XOQgcK+1OkQcTHC0DxZ6uWAIT1o+BaDNqqdq
 4Zl3S7wLjlcIRc/AV6brx2ZdKXvHX7yPUvHjXb6ME/cx/ErS7+EJL5esnDzdGFVtjqhe
 Wvb1qglB2TCIwlLyNL31TUIz/r2l+O5x2te2m1qAIPyXHz1JMneSPDPxOUglPf3A/0nB
 ZxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791484891; x=1792089691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WCspp2e/GZmkeo9++AMsuDc1oZL/s0taAPRrDEZnR80=;
 b=TrHP2sGNT8gljB5o009EsrwpiP504IWBZhs//ioudSOc/+X3kky7aGv06xGGwK72DR
 tymfUM2D9usnSS1Sc/MpfY7swQN+tf7hYzASDecJ/OoL7/pvqhh092Xwo8gKIJJU4VTA
 7ER9Jqo82w+hpklw8xD1oA73ukurxyEV1BE5K2dzOH90IIrhgqinvnqUtnCHIO+8G6N3
 ZAjNk8i4zbfBmDYhX82u+esOyzTAnTdIdhIWa0YU9C+e5kZwyr+nmMKdFGtJPMC6NLSO
 aYsqjmpCqsUTq/4hKvwfSbDsQgTsTe39smzGRILKv6iH8cIAd1hMJvTpD1LqoaVqHXFE
 S8ow==
X-Gm-Message-State: AFuF++nrC5alS4bgWantdSiNYZRIjkXrUfO4REctzP2B7Fe4oQw9bSyI
 I6WLJ8U6vdeLkBdAVo0fX6HeJmq60dgXTBHYMziUNGeNywLkCoiAa44QJ6vuVOp0
X-Gm-Gg: AYBFou0Exljo2n9ADHD+ZuqqS9rj3p9KpcV681/GWpEWTUfHbZsCxJKRdVoa/rPHAWp
 dy0IR3c7pcc0cpxdQWTMlVzI9aBfpNjy/0g3XEG2j8MuUoOm9ZkA2uxzrRa/2pf8GcnwIZy6pw/
 e7FiJsVsCmQxQQ/8+PjKCtAqTS5v6sJy07SUGRPvePY2ZREb9RhrCyarj99X04w5pgb7oHGZtKD
 6leIP6K2vjKxsALpns0jKpgFBnKR8jpQqKhhcfPKYZYf6x1p/WfzsQ6dxBl/Y9xUt8iECtuJu2j
 FoKW0nJ/H2fwUtugWaW7eC0Xyqxz1G5FZVj6BSpurABeoNOyi6oLFJRCQpy0Z+TCaBvGmYfUVK5
 lzkad3tD9JNONhwy9xQCoXm3KwmQXd8TPKVJb2ANAqk8N9+6gb6BaeMZ3JC4Va1K7k6Rho8mfE/
 jJ+sLsrgf3mZIzH8PSdRluLEfv4/JJMf72STFa7sd8cuMxosOOm6ItOn6Q2wgn7QTR3F/AudGnx
 q38gqibmC4Sr96FJw==
X-Received: by 2002:a05:7022:1501:b0:149:50cb:216f with SMTP id
 a92af1059eb24-162088098f5mr7635457c88.33.1791484890935; 
 Thu, 08 Oct 2026 11:41:30 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a442ac67sm259515c88.18.2026.10.08.11.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 11:41:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/2] tests/qtest: fix PXE test build on MinGW
Date: Fri,  9 Oct 2026 02:41:18 +0800
Message-ID: <20261008184119.142-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261008184119.142-1-luoyonggang@gmail.com>
References: <20261008184119.142-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace the GNU-specific memmem() call with a bounded memcmp()
search. Preserve binary BIOS scanning across embedded NUL bytes
without relying on a function unavailable on MinGW.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/pxe-test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 61c92a2df45..37d74d7ee09 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -111,10 +111,18 @@ static bool s390_bios_has_string(const char *needle)
 {
     const char *contents;
     gsize len;
-    bool found;
+    size_t needle_len = strlen(needle);
+    bool found = false;
 
     contents = s390_bios_load(&len);
-    found = memmem(contents, len, needle, strlen(needle)) != NULL;
+    if (needle_len <= len) {
+        for (gsize i = 0; i <= len - needle_len; i++) {
+            if (memcmp(contents + i, needle, needle_len) == 0) {
+                found = true;
+                break;
+            }
+        }
+    }
 
     g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
     return found;
-- 
2.55.0.windows.3


