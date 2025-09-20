Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99113CAC5AC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07He-0004zI-JE; Sat, 20 Sep 2025 19:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HR-0004Z0-DQ
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HL-0006eg-Uu
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so2673879f8f.0
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411966; x=1759016766; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y8b1m3nNjRvsgCA/3OAkRK5Tn4EnpI6Wrj/uOCDNwX4=;
 b=f51wH0gi+acPD3D8CcLcwQjhOScNY4CK9QhnlmRthlzfcH58ytPG5JX5IES4WRQ+5p
 wjd5sowgqu2NokZpAV8CrzHAOdyupRZ+euR0+El4czpkDfomG/Wi3WQIZ/twyb7A9eyQ
 rnqiCPuDE0hlJ5tZLxZNcpCLMl020FB5YJe5FPI+kGgrKRlmzA3NX5ABGBdAMzZlWH5q
 SDifiW32R2PrhE012tof5Ac5hZVieHPa1P6JEeGRMCREP9o0nLTnwV/0+WVQ36v81s/E
 H3NG9p+IsrUPOLuH0UFyouJdAbiRo+SEdqR9OB+meOlYBYVeDvXdpsaIb5URDaOEH8Pl
 TmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411966; x=1759016766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8b1m3nNjRvsgCA/3OAkRK5Tn4EnpI6Wrj/uOCDNwX4=;
 b=aRRnf1VF7mwMjxyJSqk97K7LiPm73JGZhlKUQO8KcTUgLnfStH7E9BCmgoysg5zbEH
 ZRbBySxl863amDzKKKXaxUgIT16xQ2+RekR6wQuxfutZ0uPRY2JrWdKP1o0v+VOy+g9j
 4xqCVqT/yKqQQgWVJ6kHemb9HYitzny0Z/ud6w8NVYnMUo6NrV/RotlZWiEyZkkyJcc1
 P8Vq7Sv5oPkVyP6nA4+BjfrUuhlr4qPKFYnf8IjdBAYoB0KDlo9vq4I+16Xlcwa71JyJ
 Gud5YDw7XhNHVz/0xoMRn27SIJVNd31LQuv6cwxLssEFG3MitDb/SatcBDvpDQ4yCjg1
 3L9w==
X-Gm-Message-State: AOJu0YzcS+UNGn2gJ555j91STRUlKy3VUMpkRmOJGo006hCh4qfIY/qE
 b+Nqyi12z7cJzgDpO2YTCkcZbOdsgNVbCZ0BZeucEVFKLlpy3tFwj1bu
X-Gm-Gg: ASbGnctcz+GTdmUt6G51a5+sAK7fg/qCS3CtO5MsvjCXh9pmitYu22EBzcuAen4rPsR
 xivOYH3epA7DyOGOSzB5JDZPcISH+o2NWqilnY7j2ubL53vT3r5VlxLFyRTxLrSjKhkoW4Vr4Ry
 O450i8fx+we99J8cmNG70qjwyRvUtwLX+WvhBEII3Lu2oVm4EOSeWKFwko36rxEEzmjfFCl7R3V
 MHoZjfMh80TmTAXM0qy/j+t669lQDIUhAotizFw8QBnsbLrp9Ditr+zsZwzY1VtNbOpIhGeWDFb
 qHaMzeG43AguTNrbzUJ9aAuvdTUyWoLr3SY3sL53cCFqEfWINTgajttSMxEV7PMuiAWCd7JDl3k
 bHHY5lR2PmKgUqeygFaI813d6BXHK0eUrGUHyMNlTyQ1BcC0r2MnVT7DsVOKQ85o=
X-Google-Smtp-Source: AGHT+IFKI8KLAPj5bk3CegRqPq8lN8lLXlqLLrl2Q7aZpyvYYqB9gd6J0Dz3nKBLlpE4zQx89rzt/g==
X-Received: by 2002:a05:6000:400c:b0:3ea:9042:e682 with SMTP id
 ffacd0b85a97d-3ee7c55430amr6667997f8f.11.1758411966340; 
 Sat, 20 Sep 2025 16:46:06 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-464f5d053f2sm142259325e9.20.2025.09.20.16.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:05 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:31 +0200
Subject: [PATCH RFC v5 01/12] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-1-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=2276;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=qKds+se7c4I8+/AcqhGDFyyVfjfxbvfkq+ChYOtNMzo=;
 b=oOALkNNtoP+4iyR/iK7otC7SHypbWLJUKZmFiX0DK8qVj8TlU5CTNwYWjZIovHMFWgR9aIWww
 AhyyjOhFofiCjQw34YDEL/cuaWljbPjlXiZA8N4Y80kW2ncY5otXfzb
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x432.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

These fields should be interpreted as the size of the terminal connected
to a given chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-fe.c         | 13 +++++++++++++
 include/chardev/char-fe.h | 10 ++++++++++
 include/chardev/char.h    |  1 +
 3 files changed, 24 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 158a5f4f551ee49120eee6ebdf772fb450739f47..8622898bd414c208b5a0397b439e18a8bf0b8a92 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -329,6 +329,19 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
     }
 }
 
+void qemu_chr_fe_get_winsize(CharBackend *be, uint16_t *cols, uint16_t *rows)
+{
+    Chardev *chr = be->chr;
+
+    if (chr) {
+        *cols = chr->cols;
+        *rows = chr->rows;
+    } else {
+        *cols = 0;
+        *rows = 0;
+    }
+}
+
 void qemu_chr_fe_set_open(CharBackend *be, bool is_open)
 {
     Chardev *chr = be->chr;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 8ef05b3dd095bdcaa51b10482261a29b1e8233c7..02d5606fa343ac64a76f48dcd250b5431a0a7761 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -158,6 +158,16 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
  */
 void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
 
+/**
+ * qemu_chr_fe_get_winsize:
+ * @cols: the address for storing columns
+ * @rows: the address for storing rows
+ *
+ * Get the size of the terminal connected to the chardev backend.
+ * Returns *cols = *rows = 0, if no associated Chardev.
+ */
+void qemu_chr_fe_get_winsize(CharBackend *be, uint16_t *cols, uint16_t *rows);
+
 /**
  * qemu_chr_fe_set_open:
  * @be: a CharBackend
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 429852f8d9d3c5a7e061acea3561b019b15d658f..336b2e68d099e70a9abe71ef842b160bf12ea932 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -65,6 +65,7 @@ struct Chardev {
     char *filename;
     int logfd;
     int be_open;
+    uint16_t cols, rows;
     /* used to coordinate the chardev-change special-case: */
     bool handover_yank_instance;
     GSource *gsource;

-- 
2.51.0


