Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E6BCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwugy-0006zV-Vb; Thu, 11 Sep 2025 23:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugw-0006yo-Fh
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugl-0007uI-RB
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b9a856dc2so8654955e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648580; x=1758253380; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y8b1m3nNjRvsgCA/3OAkRK5Tn4EnpI6Wrj/uOCDNwX4=;
 b=g9yuTLLB+Zma8z8MR4e6xP6oEg0bpk1Jwhjx2kfXpqyb7lOE8ShDLwWDG8La5GWt1o
 wvku/OxmfjHFjiq6IyviKIYcoz8r/Pu6wtDO24I4/Kli4iav2wsWvBtn5oE4LQHJpNj9
 Ecvz47EQLa1JNsrzNak6DUUpoHS5+GvWzb+WgJnl1MYFXev0d3+hb6mF7c19wWskP7+L
 r4o62+zmZROfXhpheEYkCfab7NWrQdwhtgq/s446OLmY0P0F7ipAvLuEeTeIEP30N4kt
 UWMEXypChoWUXkAbXFQ92KmM7YQ8gAnifQItz/P3/IwouIcbicCKWLifs2sPXvgtPmdi
 /ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648580; x=1758253380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8b1m3nNjRvsgCA/3OAkRK5Tn4EnpI6Wrj/uOCDNwX4=;
 b=F1Bk+095ouJAIjp2P1L1ynbJ9nj2/FnqcVt0oWGlHbMkdM5NfgJ00PfXcKwtkJeV7C
 BAyc6QMz9WFF2RWBZyqQ4eCkrTtVvrBe8128NeYzajBXLroG/BBD92rLGDoQ3VTQSf/R
 fUYClDzv+8cpeU4k0GNXvnLe6bjs5yLK+CMPBw7cO7x35XjXx0z3BWz6EtMEu7IsJ3Dn
 WvaRT277REvQ7WZFSZ9saruOeyf9GogYXBE74sctQ9+Ls2cmuCpoCfYj7E/YF/6CmVxp
 DnTEDB4l6bu+ezCryKtM/gBJa5w7xfg824OdVOM8n0r2U1fI8AhWT8gnhTIzsnxEmW+X
 rMSw==
X-Gm-Message-State: AOJu0YxuS4PvxaJJxTpSIQbWnQjqCdNqR9F7V/eCAHs9od08H57FJ+gJ
 +o1PQ96OUTwPMh/3/WawbVKCeRV6Y0LDAjulet0sw+iXftUBp1yBIMNE
X-Gm-Gg: ASbGncuQecI3L94djLPUZDVpp8QZxfqqFqUurZ/P9eapLZgVWAbmE3NZkGMP41G8ySi
 4btqCRx8qRXgEY8kmA5wH4GRUV/eC6EFMruPds5NHfdxIjDo+vI0sddZPbH+sPSX+U6kBcEy5Lq
 zKxvFEmmUyrPoq+rZuClscQ7xP3HrQvQUD0wNH1TDYGd1a5b7JFgHoWeqaEWWIStVPLNqZ9FQP0
 dH/I9PEZmuE2Y819mrtVGcFu8UMxJbKPVlkuEdO8VQOll3D9PAUpMlb4hWedWzNvCyLU1YgfAgt
 o+KcevMsIUH9gRzVQInAaRf9OogojKTpF3ciYQYSmdXJBWMggYJhR9FL1H2XReXxAyjr18khctF
 OWvcNpm+HIeR9qRKIug4VBxjREzrxQ64oJcrD+sjK/US9HkJP3qWM//GuFycgDmo=
X-Google-Smtp-Source: AGHT+IH6m5IMKtcPuLfy1JvzpVMMGQA1koS7rQUsnUTc7QYLwY682hUUgwXqMT3gF/FXK+eDZrcZZQ==
X-Received: by 2002:a7b:cd0b:0:b0:45d:dbf4:8880 with SMTP id
 5b1f17b1804b1-45f211efda6mr8328245e9.27.1757648580159; 
 Thu, 11 Sep 2025 20:43:00 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45e0155b415sm27707715e9.0.2025.09.11.20.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:42:59 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:46 +0200
Subject: [PATCH v4 01/10] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-1-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648576; l=2276;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=qKds+se7c4I8+/AcqhGDFyyVfjfxbvfkq+ChYOtNMzo=;
 b=Qz5gH8v3Vkob6UJw0Uc6Or4J/AKAFSF/tsOgz+XaBNTU9yJBczpx8EHeegYrVj7oF0SwckG4v
 IUWH/b42DYQCJo1Ox1Ef1Ow1ejW3rNFYFBxe8z5nxUAKmGrSCsRJ+Uz
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


