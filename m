Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B97DC98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx9-00076K-7F; Sun, 18 Jan 2026 22:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwe-00072c-6s
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:49 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwa-0004Ap-C2
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:47 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b872b588774so567163966b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793321; x=1769398121; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4foYyPMhJKQbs6aOEjiDFnRMrM3kKY2M3K62p7ATPBM=;
 b=jDad8HQ95tcBSbU1Tmmk5XJpx3sBWni2f+JNCoc300eHnUUEHK9rJqLvtBrStoPTtk
 DRIFjx6EgOp2xCo1G+uu/o870sAKz7V8YoRzKNJtoIFL631EnTRNr6PdAVb5neMYgzkP
 0Px/0rYwLCNBm15zn/Pe0J+HaIWJBut8/hmE7MMF4wBzWRhtA2h1NnsHurdSZXb2f6g2
 a7jQzHh8lOHJkAI2+TO0I+HIcOmwHBgpSucGrUbzJKKwrZNbiegGT4WhUkJMd7VqNFo4
 YBTP1SMZpZYTu9oh7LRlvutWasgInrVrs8dOpTF7+uTPCkPGWLeJq4AdnQDZtH/26iW1
 cKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793321; x=1769398121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4foYyPMhJKQbs6aOEjiDFnRMrM3kKY2M3K62p7ATPBM=;
 b=Kw+W/52NfW69hjlw4yprr6eUAVhIZvqyl52fMZNuCFGE6jk33uD5fwxJxRVBVlb/G3
 qX3YdpGE5fmty+GE6R1wiVcT187CND3zd6eoGp/MchFc77nrnm755yzKiHYY81b7ngow
 MuGsBlIOzqU4l0Ykp3VRbvvsc13eOpX0l1iRp8SDUfysWoArYNI7WsAp0vwoz0QBkomE
 bKLJUrYFQE90X985q0K76yzVvHCL681aLUHrhjTBrzpLOMtagYa2xgWdt7gLpjWmtlUD
 fG0H+EHwAYdxMwEU27qCKzrhwQuxFWiHHmkFMR7s5cctDZjhSDZVtD0No/89OhMbL4qP
 oePQ==
X-Gm-Message-State: AOJu0Ywk56c9QBqAX4x3w6UutDX/koRmgienWLA7wEYxMcQL8oHRVCYH
 XcVVsPjU5vWmWEbhM2Py/jDALWiH46VvporjROYBYjMceAtByoZ+iJrB
X-Gm-Gg: AY/fxX4G9MenYvKo2oKKuxw6je7bRTVM2B0uwG84186vchmJ1RLprNeXwI7nnI5UdXj
 r8Fecvj/F2lJ7l6h47ZaFmpTnyRl2MQ/5e6g3iXp98JdQh7oJbzZKrx23vb0DyVxOW+nPsqgxAN
 H7tUMmaD4slN1OvEySWfesEqGBqX9RvDEpOiy7qe8rQeAwGK+PQQUCN9ycLxhBYQXCcKlF5QSCr
 lwTbjZWx/b95Wf6QfTSw/irehSU851MyVG561ZxFZpadknwILusaLtNlETKcJbyEBMqrg29NjJu
 WnMWnKRvZsAHJGu3Zpw7I4Gm4v5JNE5grfQ+dIuX41CaedJrJeMbjjLczkPSJapZnrqnecJLfnh
 mOdNBf6l13srJOtYVMf3UOFARFKSPiGuk/l3uj7XEKq2NfArVVY93lN5/atXQP6DoobYKlQ8BSQ
 gRSGwlIO5/oLAmHiYK1ccQkhXpX9x4f2rMbjW/Qe6j
X-Received: by 2002:a17:907:a893:b0:b80:3fff:3369 with SMTP id
 a640c23a62f3a-b8792feb1c9mr929892266b.48.1768793320495; 
 Sun, 18 Jan 2026 19:28:40 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fbd23sm977771466b.51.2026.01.18.19.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:40 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:46 +0100
Subject: [PATCH v6 03/12] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-3-33a7b0330a7a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=1613;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=/VIQQilAfTFStWcg9B9/K7HOVCxT3zSP38BnQlYmmsA=;
 b=E5pZDnQgRrIi+VrQYDQGVYlXIwLk/uZY9/Kg1E9zrUW5ereud1TsuaLJ6YTAiaK5UEDs5Xp6h
 WSIpr4/BM0VACArGsjrSUYK96O8kkjnRFTbhJdtHgDWGEAL7QxrdOHq
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x634.google.com
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
index 0f493d793f..f3c6a12c99 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -351,6 +351,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp)
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
index 2c139f07dc..8e998ed3c1 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -234,6 +234,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 

-- 
2.52.0


