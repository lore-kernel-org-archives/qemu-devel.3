Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5044CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wo-00069S-3A; Tue, 09 Jun 2026 15:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wQ-00060t-Hu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wO-0006CS-Oq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b7866869so66343095e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032607; x=1781637407; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9B/5E6JiMUlKt4qUW1t+m5CI7s5nzI7dp/Xg9QWxW90=;
 b=fFSz3iBfbArGhPYOH00Hlswk9pCTkx7wIZyjSYqn5CiPWWbLdGp0IUpXuxYuiDodgs
 Rux+IcxdNQiLbp+tvDZTzpk4bu2JNNWeiVjFXuwHsd1792mJsHKJWsYHkBQtLzAPIYFc
 A2qU42gvk1X61eIxZiyeYo0US94x7zAeXLqyH9bzZ5jwtk3JGQJ5rRAwuxqKRWliuUld
 ZfI5P1nUQOSMRpYue97rq/a52jW1wt3nU/33Z3Ax99VPZk3KWdNnm/ZpfVMvZoLp7ko1
 YK17iRQn6b0MvgM3VW8X8tycgDl6bWR+NrGpCl4aNFtnKuzcXJkWtkM3xeELiXHrSAgr
 9Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032607; x=1781637407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9B/5E6JiMUlKt4qUW1t+m5CI7s5nzI7dp/Xg9QWxW90=;
 b=YjO4bkdt8t64JVljO4LIGPMMVMpu4V2w1sD3/HXwOwHUEoFAVfi9LxkehoIIb/6XTE
 DpYubsn4bWGUkecmBR+poXEVF7ZmqNyH2z4wLxshMtxgSw3W99TIs9HelvHNxyco8ylU
 F4vrea1TpOKgHKz8Ym7j9DGY9svttjcZ4s95uYsJY2E+tjuOgOUlczBRvw+zZrK/Mghk
 YirJHlUSucS/ZPiHnBIuDwn9Ciq6A/R43brucG1kohRWDNzJJVYnnDdSdg/nLa5/Vck8
 C1sLpD+xGbkcYvlgpprKxbdR4GThz0Ks1dSIUF4+Sk+TPXDFPGvH6oWduIbJEUnZteta
 /plQ==
X-Gm-Message-State: AOJu0YyIXvSZkXBSeKt9ZoArnb7Wk/SDOiplBNNxJjlryrTb651UV8sq
 509uD8DbOalBM+2B9Bf7XKad4KeJm0nJJD5cpQfGGstsQccSqVByIK5K
X-Gm-Gg: Acq92OG0Lc9I+0V519u1GyFk4w79ctgIz1RlwkY3clTHlMBi5iDl+EW4C09GO9hSmNv
 Fzpo3cWwdWfFeE3EA9nYiNDMhTkQ5mOAB9n1A+UfOw0eYAVQXaeI6YJhuf9R8mH07+elzoNvvj5
 HK6PW3XeVpx8M6NwujtI4lhEfLgQsNtoKCRtyb2jKrlzJhW5cJWjM+8DC2UWjk64qVVYpSkrtSm
 5kdjc45vRAqx+gOu9v3bbKaZRIkmBGUs9ti8OdFoijAeCNGC4Ue+rC20hBvGGtihPnlor44ItPq
 JaJNWLnopaw967Rp1RB2k1dzugAxUgUCvP6PK3DF2oxnJmPnT8QUudOFYmCSaamcLNyV6lQTq2k
 9YZGi0ePIKsC5ygp2DjLO+ORG54An8iZmfHX24nxxQ2OxaSSlLq7Di52a90mWJ9amPuMOq38IXW
 LDP5c+kgYde/LHV8mDSxSEPVCYPZVIb3TJtOd+zPD09aKYSJXtXS18CHhlwAu+PG4=
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-490c264cc2emr364165075e9.33.1781032607150; 
 Tue, 09 Jun 2026 12:16:47 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc413541sm540304905e9.14.2026.06.09.12.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:46 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:13 +0200
Subject: [PATCH v7 03/12] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-3-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=1613;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=uSUCdVC3f6uZBZ1BrcWPv0sdcMuziw41oxVRB1g/F+Q=;
 b=4mlBCeHcmFdwRamnV9YtkmGSCdXrPu3Kkbw3uavLWOF7Glu5kDkkdIQfdeg0ggATr6rP1rgK6
 Pi3aZmX3jN+AVFKGpbmjQUzHvH8tV09DQf2gCc0Qz7T2aT2okalR0dz
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

This function should be called whenever we learn about a new size of
the terminal connected to a chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 5e62f2949e..d4ef717c56 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -386,6 +386,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp)
     return 0;
 }
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
+{
+    if (cols != chr->cols || rows != chr->rows) {
+        chr->cols = cols;
+        chr->rows = rows;
+        if (chr->be_open) {
+            qemu_chr_be_event(chr, CHR_EVENT_RESIZE);
+        }
+    }
+}
+
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ee9f24038b..2616c19cc0 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -235,6 +235,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 

-- 
2.54.0


