Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5170AC98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx8-00076C-Bz; Sun, 18 Jan 2026 22:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwc-00072a-BE
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:47 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwW-0004AW-L6
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:43 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso5340178a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793318; x=1769398118; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jK7GUviNL7O7EDOH4E6VZGB3H+hETZcKAa/uy/WwGY=;
 b=aQbDY5Jow32rbqA/FDmBPY7b7siFV/qBhPu1Rbhq45U/00SxPHKF1JEbYnLHpLye0n
 EtVJiekgC6af/gGqrIcofYk2GWXdsC3gcojp9JOmbdqHEptDGk+bFR/wDaZOWL/Pcgbq
 jT17o3BXHgG18ohsYbAcdHB9Vo5KcWATUaWf51yVZBui+nF0Ygkq70HkzDpb52LNEVZ9
 OMhKMTkQnDgtF1MasDDSEuD3iLHPqTTd8TQitXZt1aMB/Si/CIWXOiu1h+NVFQC3asST
 T+hMIBeAKOj3tuT7f85kZ9OXgFXJJXqI1hMZczLiuq58XBkqKDGaCUuJeUKdwVY9ktnZ
 I2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793318; x=1769398118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jK7GUviNL7O7EDOH4E6VZGB3H+hETZcKAa/uy/WwGY=;
 b=ObVvbnFPq84AeNMUDxaSGJezjhsnQAVmioSMapS/dj5ckdzizztEAv1KKpOw0P9kXS
 1VTApW8DFuAgGYtt/gZQlMpJqZ4g1h9DxSFcKVB8ilZWfypG4rxeZ8YztCt/fX+K7vYI
 ot1iQjBur4AEvKp4gS47WmofjAB/fw1UMPXnSuDHipLptXxInHevUaRBG/wXl85X7p2f
 XYMPtAk5dcxL1z39AI4nr794ZR3FmipRUrpdj/owKoZeYmbtvL6CzKN3f9BP8CFnFGuy
 QmYZbPzTGtKDDpx+HZHTT7v1ctTVhdQfSpNwiPP2PJgY0OuQNutx+9E11yEQFBT3JkqC
 JA0A==
X-Gm-Message-State: AOJu0YyWX/5fBUNFls8glHdNbAiBFanUTLsZIigzTmC9jBpxxl2sAGaS
 D9zwzKiaANsMlg40Hw5cf1fuIwVjN12KO3fxzlt2h8XhXJAp33qSXOAf
X-Gm-Gg: AY/fxX76K9rqMrj8djaMcdreMnmNSLpiOlGrIyce31wVaSiyPGpfgVIJRPMQ7YgsQGr
 64Y2l0hQOPYqMjUBFMrkZv+qciNO/0NuyrHu+kvCkNfHSmwn5LhcVjzJNMeYrzo/b2g/Fu5q+NY
 dY8BzrMyxvEiVhXFwbXi9iCu0ZP61u8DNTjxMaBKA3oa7JkXQ3ZO6hqueAX6nc0u1ANYGuqoWNf
 /4EXgn7dbFpie/JnXXPHjAx8VpQMO/p1xNaGThYvkR+NNerQ5ObtEo5t06/9XIWx7QLTILoxze/
 nDatPZ4X9BWHtHbqFqlNrFODtCvB681fE3SQkz2zjNF8jAsygsYefA/eVJAMGb4+zsC+6lJYtfK
 Yo6O8NyDkrX59l2Qhe4IIHJUGk+EPo8KRvFhqT85yoMF4gtrCDKpPwhQdrdsErwB3HL3RMI+zWz
 leVnDIxgU4ljRHABx+SNLt/Ve0B8KgNgKSIJx2y1Jk
X-Received: by 2002:a05:6402:210e:b0:64d:65d:2314 with SMTP id
 4fb4d7f45d1cf-65452ad66a6mr7293631a12.23.1768793318206; 
 Sun, 18 Jan 2026 19:28:38 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c49f4sm9012128a12.31.2026.01.18.19.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:37 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:44 +0100
Subject: [PATCH v6 01/12] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-1-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
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
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=2188;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=cs3jOpOKQqE9iM7bir6dwnRwj4x9AXZwFsh1SGhw+CI=;
 b=NEAZAACh9GsUurU1ZevHGmdMyGmWI6xSXiCigOVWTHMPtBha7JyMgZJxI45k7kww3Q0+23DNS
 TwxSSf7YOOTD1oKo41FKpp15AfRKYRbTB+LDeOtBqD+TodJSs4rxK0l
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x52b.google.com
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

These fields should be interpreted as the size of the terminal connected
to a given chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[Filip: CharBackend -> CharFrontend]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-fe.c         | 13 +++++++++++++
 include/chardev/char-fe.h | 10 ++++++++++
 include/chardev/char.h    |  1 +
 3 files changed, 24 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 34b83fc1c4..a3bb1071b3 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -329,6 +329,19 @@ void qemu_chr_fe_set_echo(CharFrontend *c, bool echo)
     }
 }
 
+void qemu_chr_fe_get_winsize(CharFrontend *c, uint16_t *cols, uint16_t *rows)
+{
+    Chardev *chr = c->chr;
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
 void qemu_chr_fe_set_open(CharFrontend *c, bool is_open)
 {
     Chardev *chr = c->chr;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 5f8a6df17d..53b8d2a1dc 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -157,6 +157,16 @@ int qemu_chr_fe_wait_connected(CharFrontend *c, Error **errp);
  */
 void qemu_chr_fe_set_echo(CharFrontend *c, bool echo);
 
+/**
+ * qemu_chr_fe_get_winsize:
+ * @cols: the address for storing columns
+ * @rows: the address for storing rows
+ *
+ * Get the size of the terminal connected to the chardev backend.
+ * Returns *cols = *rows = 0, if no associated Chardev.
+ */
+void qemu_chr_fe_get_winsize(CharFrontend *c, uint16_t *cols, uint16_t *rows);
+
 /**
  * qemu_chr_fe_set_open:
  * @c: a CharFrontend
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 192cad67d4..237238e5a0 100644
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
2.52.0


