Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD03C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPS-00086B-Go; Tue, 03 Jun 2025 07:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPL-0007xm-OW
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPH-0002As-Rz
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:15 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso845097566b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948530; x=1749553330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSHJXxc1UhfcVCxdzAUK0Y/TOr5iYPq2Hpx36H607ZU=;
 b=ga7fwdEJnRbs3Lu7Sng99OVV3gxLC3xh88cOr9Rk07Amc2yXS+zB151c1PnQdfAkCU
 /kjDTB2XTMX5iAYkPRXfv2MHjgsQDtIXRqd3JbTZgELxhZ8zJokzAjZ5Gg5q4rpAGC0A
 7eM5GxVz6vDfdCZRHJAQyvfVqHywZpn+lNLO0kRSGXaquLMZ+M49ZdNLqxvWmFD/gsKh
 HpApt4+rPcDho64P6ALaCVGpZcLzWGqioqiSqIKXP1TJLD3v/WDa8U0lYg0kd9sNA521
 ExkEgNpHyC3r5qGZmoDTB/iPrenNUTYCB0wivQEN1rN69qenZ2/gMwAd8MzT7IxDMqUo
 TPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948530; x=1749553330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSHJXxc1UhfcVCxdzAUK0Y/TOr5iYPq2Hpx36H607ZU=;
 b=inpTxzKTdOFGirlZKRmxX6aSOZM5NjbAKhmy4kx10nboeA1RYyQ8o1FIRs1hH38TY+
 iMU2kEm6FdgNKXKGAShAfP4Y2D4lYXKmGSm9Og9uCPLt0AcGBKnlYF/wdZpYrLPD3ZLk
 lYGqexJ9dsRc5Fi5WrAHlEmggHAYEpnEbtpaxLKCDdljbF9WDTFFkitoY0VDSGpXd+Me
 ko1WqVYXGBEpRNpo/5ujaiPyGwg3tzsKCn58ilrt8bSfPRs3GXldW6d8mAnrppcfI5aO
 wuHp0X1UmK/8h5erulFPpKaLMKes/8/VgOvqkgk/sHkoNJR8hw9wRBLLvYezSOuto7pm
 carw==
X-Gm-Message-State: AOJu0Yx1FaBfRhZQt5r4bKOQhS3PdrXl+BM2Uygw0MTh6FWnfMkMLzjt
 cIOGEDIXQxf/ZNfE+DzVlkzeqBYolSoJMXbSLcSaGquQoa9+LgMSakhaLHFLrX453qU=
X-Gm-Gg: ASbGncsRCwU7A0cQHCqC8RPTd4RdtxTBQpSz4fkWjSH/8kWPRMl0JcXCbzyWVS4GmB7
 U97hDT1jOgbDB3/el/DcQqOCLuA4u/HO1aeGTy7EpeJj+v7sdOMNyBuiKl6VbZhnBVW4pQtFZhm
 HY/0yndjvWKeWZPIrXRGBCvvkQ3bSw6qvVtdk4L0BtsREVnXh9NydX9XeQnfRmOUrLd9sDDlEPP
 OkqT/zIzXohrJldwTScJtuHphk4A9FdeErr4O4R5BOdzWqt83AJhO0spE7Da4ZgJ87FMZerAMbo
 rcEegVIJ5/UsBsZyQCZBF4B15HOXzYPdFaEfDn+2TqRR+HOvBkz1
X-Google-Smtp-Source: AGHT+IHHrnww0ujf4PTrrfN/HfEM6b/60/TWB/wH4jdxh2msGxXJH42Ja/KmZ39S2btbHm4kh8mdmw==
X-Received: by 2002:a17:906:dc8d:b0:ad2:3f1f:7974 with SMTP id
 a640c23a62f3a-adb493aba1dmr1213434366b.10.1748948530095; 
 Tue, 03 Jun 2025 04:02:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82d95bsm948177666b.57.2025.06.03.04.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 720B85F9DA;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 06/17] contrib/plugins: allow setting of instructions per
 quantum
Date: Tue,  3 Jun 2025 12:01:53 +0100
Message-ID: <20250603110204.838117-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

The default is we update time every 1/10th of a second or so. However
for some cases we might want to update time more frequently. Allow
this to be set via the command line through the ipq argument.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

---
v4
  - simplify error checking, don't bother with errno
v3
  - error checking for ipq
v2
  - checkpatch fixes.
---
 docs/about/emulation.rst |  4 ++++
 contrib/plugins/ips.c    | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a72591ee4d..456d01d5b0 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -811,6 +811,10 @@ This plugin can limit the number of Instructions Per Second that are executed::
   * - ips=N
     - Maximum number of instructions per cpu that can be executed in one second.
       The plugin will sleep when the given number of instructions is reached.
+  * - ipq=N
+    - Instructions per quantum. How many instructions before we re-calculate time.
+      The lower the number the more accurate time will be, but the less efficient the plugin.
+      Defaults to ips/10
 
 Other emulation features
 ------------------------
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index eb4418c25b..c9948976f6 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -145,6 +145,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
 {
+    bool ipq_set = false;
+
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -175,6 +177,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                     return -1;
                 }
             }
+        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
+            max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);
+
+            if (!max_insn_per_quantum) {
+                fprintf(stderr, "bad ipq value: %s\n", tokens[0]);
+                return -1;
+            }
+            ipq_set = true;
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -182,7 +192,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
-    max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
+
+    if (!ipq_set) {
+        max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
+    }
 
     if (max_insn_per_quantum == 0) {
         fprintf(stderr, "minimum of %d instructions per second needed\n",
-- 
2.47.2


