Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEB3FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJNj-0006Pz-PZ; Tue, 05 May 2026 13:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuraxt@gmail.com>) id 1wKGIg-0001JI-EF
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:59:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zuraxt@gmail.com>) id 1wKGIe-0001rd-BQ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:59:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso65335655e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777989537; x=1778594337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FjfKyzqKo8dYsreja2pN/NQNwtFTmkUUNBMDn1BMkrY=;
 b=gQk/oMghd2WbEguQNWeknY5cg9H6kzbPyTct3TDz4LlOJOL8H9fBrrVglW06B3PrWJ
 BUbamgN/1ABX0DKQKuKsyvQPD7PIglehmBejNB/5+blt4NFUxA2Nad83kTAPWCHBkJeR
 DBNHuPRVUXnNeyHbzTf7fYi5SyXWEIm7LRasENINWEpgqXl81CNQK8S88KJeQyAVhdx8
 RYkDGnYQo7rbxJ6RmQJMaI5hKYaSqaDHi2Pa1ggMNo5IBEsrMywgnqRufdImiE8AhcMy
 Fl+pZRR34P+2YuGItcMyoVeZoLD0DbTkoPbFClqjWWVuDInteXbp3P7pVmbzt047jSsX
 mA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989537; x=1778594337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjfKyzqKo8dYsreja2pN/NQNwtFTmkUUNBMDn1BMkrY=;
 b=seE4vdNJFo5oqCfhVU2YlpRcVHIjg20GyfsAKJV8l9rETQwTEOfMfpWSPM7iIeJUz8
 NtMcEeW83StEju6UMIOx9u6y36BXqnocSPY4PgaP+P0KtyJDDFuei7ePakZMGDxs+9dV
 fHr3COfPOnMN9nF4vv5H96j1KZR+3zta4mIDV3i5uEea7Yd2aCAzye/eEJZuQS3RI48z
 P4GXrVFsdOK3C717F75538BL9K7nuz6r94X+yJR9OQin2ucm8Opj38QVDkaxGZSzIc1L
 8kJDEm8OF6pK0BnW+em15F0NJ8iO5KkMLOBZdj0Nv43lo7hd6lbzsy+kX8YrQuWlU+Cz
 IKcA==
X-Gm-Message-State: AOJu0Yw1Loppu1QHTbheuLDrUPwEfPxiK61iDhNdwOrqLgD9s4qm24O1
 gm11uYnOaOAu55sw+Ok00MUJiwzMjZdWriSrNAq7OzqqD5kLsc9ofGQPGOli9MUA0Pc=
X-Gm-Gg: AeBDiesgRYgZt8E8UkpPKcFbD+BrCuUBgJnRmRJ7fr2Q4UfNtpsWfaYITcOfotZ1Dd4
 lFPMBbHeMaISgwhDg87qrNVFX7ujZZeSA239On7G35UKUCjnPTXqPGRftj7XuRH1WUVJPBUGEDW
 el6R3q6XNIXBdIjK7hhAuv2DX/Or4XGuLOJ84mzgDmWEnzcfKuR4kfeQ3t36Z75RQsMl8RgDt6k
 pIo4AOLGr1vnfdrA8d4mqj+lbUj1td5ef0Fxd6LCfiyGbItXie0n6/Wdq4U8xsSGZ5asxJVs/yr
 ZBlOuAyXOFJptWgUoESsFWqnNGcgDeIVRuT7v/u+AZEBcl9bKUu05cRiCxK9bXijz/ALSr4UBtd
 msB2zn/f1EeF30Kd1lEOip9JyOrrKfi0UQilKVk+wPfVOgV4pAdHl8W0G8Wr6FFJXnlPkq+8f7E
 SceyOlujYU8b2UIX4X0qz6T9H3BbmE9jgx7a8=
X-Received: by 2002:a05:600c:797:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-48d035e8304mr111971115e9.28.1777989536737; 
 Tue, 05 May 2026 06:58:56 -0700 (PDT)
Received: from fedora ([109.172.173.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d184ed090sm17620935e9.33.2026.05.05.06.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:58:55 -0700 (PDT)
From: Zurab Kargareteli <zuraxt@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zurab Kargareteli <zuraxt@gmail.com>
Subject: [PATCH] po: Add Georgian (ka) translation
Date: Tue,  5 May 2026 17:58:37 +0400
Message-ID: <20260505135838.562522-1-zuraxt@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=zuraxt@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 May 2026 13:16:15 -0400
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

Signed-off-by: Zurab Kargareteli <zuraxt@gmail.com>
---
 po/LINGUAS |  1 +
 po/ka.po   | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 po/ka.po

diff --git a/po/LINGUAS b/po/LINGUAS
index 9b33a36..2769edc 100644
--- a/po/LINGUAS
+++ b/po/LINGUAS
@@ -2,6 +2,7 @@ bg
 de_DE
 fr_FR
 hu
+ka
 it
 sv
 tr
diff --git a/po/ka.po b/po/ka.po
new file mode 100644
index 0000000..6c3110d
--- /dev/null
+++ b/po/ka.po
@@ -0,0 +1,94 @@
+# Georgian translation for qemu.
+# Copyright (C) 2026 qemu's authors
+# This file is distributed under the same license as the qemu package.
+# Zurab Kargareteli<zuraxt@gmail.com, 2026.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: qemu\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2026-04-28 16:53+0200\n"
+"PO-Revision-Date: 2026-05-05 13:16+0200\n"
+"Last-Translator: Zurab Kargareteli <zuraxt@gmail.com>\n"
+"Language-Team: Georgian <(nothing)>\n"
+"Language: ka\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Generator: Poedit 3.9\n"
+
+#: ui/gtk.c:233
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - ჩაჭიდების მოსახსნელად დააწექით: Ctrl+Alt+G"
+
+#: ui/gtk.c:237
+msgid " [Paused]"
+msgstr " [შეჩერებულია]"
+
+#: ui/gtk.c:2208
+msgid "_Pause"
+msgstr "_შეჩერება"
+
+#: ui/gtk.c:2214
+msgid "_Reset"
+msgstr "ჩამოყ_რა"
+
+#: ui/gtk.c:2217
+msgid "Power _Down"
+msgstr "_გამორთვა"
+
+#: ui/gtk.c:2223
+msgid "_Quit"
+msgstr "გასვ_ლა"
+
+#: ui/gtk.c:2372
+msgid "_Fullscreen"
+msgstr "სრული ეკრა_ნზე"
+
+#: ui/gtk.c:2375
+msgid "_Copy"
+msgstr "_კოპირება"
+
+#: ui/gtk.c:2389
+msgid "Zoom _In"
+msgstr "_გადიდება"
+
+#: ui/gtk.c:2398
+msgid "Zoom _Out"
+msgstr "და_პატარავება"
+
+#: ui/gtk.c:2405
+msgid "Best _Fit"
+msgstr "საუკეთესოდ _ჩატევა"
+
+#: ui/gtk.c:2412
+msgid "Zoom To _Fit"
+msgstr "გადიდება დაპა_ტარავებაზე"
+
+#: ui/gtk.c:2418
+msgid "Grab On _Hover"
+msgstr "ჩაჭიდება _გადატარებისას"
+
+#: ui/gtk.c:2421
+msgid "_Grab Input"
+msgstr "შეტანის _ჩაჭიდება"
+
+#: ui/gtk.c:2450
+msgid "Show _Tabs"
+msgstr "_ჩანართების ჩვენება"
+
+#: ui/gtk.c:2453
+msgid "Detach Tab"
+msgstr "ჩანართის მოხსნა"
+
+#: ui/gtk.c:2457
+msgid "Show Menubar"
+msgstr "მენიუს ზოლის ჩვნება"
+
+#: ui/gtk.c:2479
+msgid "_Machine"
+msgstr "_მანქანა"
+
+#: ui/gtk.c:2484
+msgid "_View"
+msgstr "_ხედი"
-- 
2.53.0


