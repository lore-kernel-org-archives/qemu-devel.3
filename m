Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CA8CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasj-00057Q-0l; Tue, 29 Sep 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBase-00056a-Ue
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:37 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasd-0006Lq-7z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:36 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso41578315e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700032; x=1791304832; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=umrn8HLPDOvFFL2RpBiWvZyNCiuGMe8R/n/m430ufD8=;
 b=hq83/uydCBHGZHmPZrwrVFGqiGpx9euf/nunsXao4ySj8l4x0z2ZOEWg1uePwhG8zD
 2p153p+LYfJi4fyBwNufTpDIi3CgqJoxB4pVtMCT211GlPFlXaCceF35AJVr9pQaEjJb
 y9rKCkPkrsFMHDwD5eCdbuqs8wq7L/EyryXbdqgsqM3bdEACZazaviZeMONjAODQa8cV
 r8X50ifXeq8KwzpG6KcwFOWIYJnFDUzqe0xyxEKZUUve3NA6xZHnIdtXLoUlY5o45pqg
 4wncqXke3Mzp9aDTvGv4hAu75ux1P/3bmJvH6A65SrmDCGokQL1PsJLcdmJrtMNPrHc/
 BFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700032; x=1791304832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=umrn8HLPDOvFFL2RpBiWvZyNCiuGMe8R/n/m430ufD8=;
 b=SBL7Q5/ptelh2M1If+7wc/tU7Xzk3f/Lg5OWY078Y2mQalxFu8MRBpyIEBRnNBXxpk
 nBS2X2u9SGnYhv2/cKMo0SuQjU3so2fKXV5aWq1uSIyzBpMmBP8VpJ+dtdDbBaNE4+Fm
 ZMT7kug9yGVM/ZmlCZKIsHIKc6Mep2WvvyUStPbJyB+RbWaXtkaf5tZn7474efZOar7k
 nMEjJ1Cqd3clyK/hYNwrUUgpStPzHkny49erblnbFQPNptXsv4GnAp3+42Q2dpitiL7f
 nvSKQ8OESIyA/YgD4WLSwT3Jm8fC8jVQwPHnaTLHgolNmoMyXQY+U3s7ArErPqh2phpi
 5M2A==
X-Gm-Message-State: AFuF++kS6koIHk9Rq+NvVE7Hl0jUAy81z6IYN/uSxMmWkzTNC+gIqcw4
 ymnWOrWgrnry6ZIGheC0do0i5MvXv82XSQMdlFKaWumFuA0K2ayYoFsc
X-Gm-Gg: AYBFou30qEgPZ6Y7UIZYcXP5EQX2YUbd+NS/A5oZE7SYeq6QYudSV4Ccr1c5NaJ2gD7
 gzwzVCbUB2yKu8QQjTl3JXF6SzIH0f3h7VAwExzZg7O2mTTDxTbaHqRUs0IA5pgeRbRQ5tsx56K
 OEjTRfbPK4p8U2AASIe9JKClVxVRK/rcJvXMa/eed1QubrWvsS0t+D+NPwQCSiMhHkr5XAMNwOE
 EhOdaAp/mUMmiDZXTYV1OCRMI9siEqDvQNKDMdDA0vsnVnQxO4W47GUgfPA1YejoDcuWJvaFQVL
 Oyj4+25q9bBOjP2i6PHXRYWIElqH1wL+WSGq67FsTa4zsxLd5gFcO8raa47Dt6mjVY7MWuWb4ZL
 44Jw226rLeyXCgvoBa+FR1bS3KovgnqIDwZncmyALFRCsTLHrBb4Uv484aS1rGx/TUv6rLWoWB+
 hCsccj/2uHFOdtXB1mc50ZpEQUbyZvYoZy4IxtEH0dilyf2UikUs4PwoGPRle5VITSjHmowqgbJ
 TY+bX1LBwRArdom6LfynNKOZUffmcYzm5jRtQ==
X-Received: by 2002:a05:600c:6216:b0:49f:fbad:29be with SMTP id
 5b1f17b1804b1-49ffbad2ce8mr186756055e9.34.1790700032255; 
 Tue, 29 Sep 2026 09:40:32 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf8f93csm97948635e9.5.2026.09.29.09.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:31 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:29 +0200
Subject: [PATCH v8 01/12] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-1-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
In-Reply-To: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=2201;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=t7htNSgqNPHw6qhkEHekMIj+qcr4FpFc1lUoQVqaq/E=;
 b=UeBCnc37/BYGVP2pPx4Ze+VysdDIaLQ0WLvLlLYCiX0YQ9HCvtYpiJrg8wOlcBpgv07uTmWFF
 MMaPU6h6m7MCxPLhdGEsD1UxZir7zsMWv9qLWSe8TkaH9JxxIpENti5
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x11.google.com
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
index a44f267373..c61c91f779 100644
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
index a82894e1d5..e4a3801e7d 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -168,6 +168,16 @@ int qemu_chr_fe_wait_connected(CharFrontend *c, Error **errp);
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
index 7377d8e60a..6394ec2ffe 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -66,6 +66,7 @@ struct Chardev {
     bool logtimestamp;
     bool log_line_start;
     int be_open;
+    uint16_t cols, rows;
     /* used to coordinate the chardev-change special-case: */
     bool handover_yank_instance;
     GSource *gsource;

-- 
2.55.0


