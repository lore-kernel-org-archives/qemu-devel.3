Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71334CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGeg-0000Gq-CK; Mon, 12 Oct 2026 10:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeY-00005f-3O
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeW-00067w-LQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so1880108f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813919; x=1792418719; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pNtIniH1QJel5ZvqyD5P6odHkDoTjuMTi4f2c38EAug=;
 b=CO30gmRabW9M98klDZ1yMV2TFy7Hd4mKQolo9oWnjoP8lhK/OL/X7SlkTROP4rleDx
 3TgwvaOkrLBdQUsxXKmZhye9Q2CMjqZpufgweuMbYS7m/EeyJ8JNp1yBmPY+3oWMU5GY
 6bjfIuW+eTxP6jhCJ6G4Rvw2O9Jyzy0oz4kfwJy0YkjdpqVQwdUF+HhWluH4SG8jp3cY
 b4cc/Zxl/GCVZtVho5P+L49dz//MltOkCwHrlZwzml9jnt31SeFp6cwjg4Z9mctAryo5
 JPljbr39q4loHz1g2V5V2ZxVYQ3AJwviJI+nBGZbUNNdTjXNjYHuuVRS62ljvR7irBzA
 XawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813919; x=1792418719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pNtIniH1QJel5ZvqyD5P6odHkDoTjuMTi4f2c38EAug=;
 b=sJ/Bc102cCfc6x7NxtMQQ2VvmTa+RyQCL1+yd/wrmOUPkMgqjznJDz6ynoNc2zHFPi
 9NdmLDDkIOUAQ9pd3JG6brO2bg1jmZGweJjOQuEnEyfy20IzD2uWS2dyw9jIrn3yvY5Q
 aLVgeEdmwOLRAhjR3eDIGdjDoda1DswnvGFEZ8Y0MoRpI0tH0lU0en629vNGNLL8S1Ab
 u2Vx1xBOfAw8+VSGrwFUqo8F4VxzvRwv9CJtZ+PANMXrumD+RKtSXNF3lYJjWZtXOVm0
 JRK64EkHpw1q4INLmQxq4QQWi5f1333xbLIF4K4B4uaANto2mGJL6a3OdLG9Jw80X3j/
 UHgA==
X-Gm-Message-State: AFq9FYKOEOffZbHhVvEM9FEJqvIO/PT+UVC96IvJZzx8KgFhA04hhtDA
 ouItDtfR2f5/Ra5+2WrfoBvVF6hbFmGVsHNM2KuRQp9NmwklArNcUFTZ
X-Gm-Gg: AYBFou1F5odPuXU5GMPXCcWyyRy4c0Mw/ck3705WyP79P8Tn0GYb7fZPoLp0amNvAUr
 sJT9lE2WDs7iFtRlr0Ne8oB3LinHlRHd4MIiIIZHvK0oAdBaASQ+w1yL2Phdtyxcil+Tiuv8DRd
 qoPH+XGGW00Wk3MUqDQDPvnHm7mh5bXvkKHEmopn5aqxpDbKjL8zQ+KCjGGtVAP58L1w4WWTULX
 l8PgGTaIFcdA0go0b7I3DYcfi8EnXN4NVUQFVh7ji2IPDJbxGSxOxQ4jwo0NDmRbo9AgflScQA2
 lsc/BBU3zt9DrmHaBcsVaBxnR1DSPd0e2Ut1J9qF7M5lDkFabXwC9q4j/OHMqvRPV0wW7HcYTmt
 mc6CtGSMBSo5brWwX8UTg6sZWgvquuHilofMgYX1sxPKAWii5tvImN8U6nxgUTwfK72RSnrFvfd
 jDIQ5P2oPLptVO5akeR6goSw/05nKFWe4SQdhoxdarOP+U8wdiQLvMhKNlYC1KJa8A1oFiWItGp
 oppL8jDIv/+oQx2+FQpFkk/XpQfqF34pCvq
X-Received: by 2002:adf:e011:0:20b0:48a:fbf7:15c9 with SMTP id
 ffacd0b85a97d-48dba787717mr12394245f8f.1.1791813918632; 
 Mon, 12 Oct 2026 07:05:18 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9463499sm18798184f8f.3.2026.10.12.07.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:13 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:02 +0200
Subject: [PATCH v10 03/12] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v10-3-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
In-Reply-To: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
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
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=1613;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=nKK+EFv63K2JxuitDhYbnijeqT/iaRN7xTg5XKak+Xo=;
 b=qcK2jt8XffbSSi93qUtu0BNDVGoT9n0Agh11yErbpS6AIarvvJm3Wsa9y+fR7sW6WW6H2/CzL
 fruNoBIRiQiCO5hv9+tzuyvxVS/viThVpdEvHhohJUq3n0kQjfkwd5q
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 40d2180ce7..8c8386e5b5 100644
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
2.56.0


