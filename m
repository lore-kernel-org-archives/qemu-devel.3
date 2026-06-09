Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD87CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wY-000629-1D; Tue, 09 Jun 2026 15:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wO-0005zK-Ex
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wM-00064y-RP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so64417655e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032605; x=1781637405; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OH4Q74ERPGJwIH9McuO1k6xhWrHxhqiSPJG1425IFTs=;
 b=TcaW0SIEhx0GNjrRmmG/VnFEtS+Gb0hrmUg7vNo4g6fvRNbNYitsa5vg2Onxp1V72R
 CCvy0pa+/LOkpWqFVXeMNJGq3HL/vqmkpxWhp2qqCcnBPYxROw7mAP6tfECItYjqlLp6
 5IDORGscXkORK6BjCJV7LhbpYjKb4M4dHiqc1x/12Q/m+FLGH3RgO4YyPwBFk8abBZtw
 Cz2HpmB5lBjS1YjPwue5wjuVa34mkkg4jNZkYnpHI7wUJ/Qno0lfZ0He/MSRjL+Hoc+r
 7YT5G/GJpzwwwEMG8EEPMZwu96NDFFM9y3lf80GFFyDJc7FVqc6GpbaRPjnQwJCvEXKN
 rnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032605; x=1781637405;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OH4Q74ERPGJwIH9McuO1k6xhWrHxhqiSPJG1425IFTs=;
 b=ZkgVh7iTPZKMQVuplFDnfHZnIYhOJ/SgZz5OGMdCnKRwUGCNdJOnUfYISgGJYFZrmS
 Kalgs/GyLc02ceXPw50DZwhPt9ZCUOy7CpVIsRRTjIpWBsYLJ/z3HmbKg+ILVcnkZDmF
 pe1U/U8sDh68BGmtqkBsodwI7MVMf1OIdNa84yD4YW0sSu8ESUj4ABMH3J0tKtN8UDkq
 MAcmBNoOFdBmjJvzdl47yeh4Po5PQ4G2SnDX+ZwpV5AXkONy/XRPcrPElxuyNDqyC/ue
 le1XHg6HUzxzoo2HskRXKieyF4Qw1qxroFtEtbJeZgmc0XySahbip0QOFnzus/sdPkWs
 I1tw==
X-Gm-Message-State: AOJu0Yy6n0OgWfOEVHwepO5fr+0/SaqFfQxO8Nn+k2jEmn0kzKQ19UgJ
 ngGmVNyC3W6P1Ce4yShkCu/Hmc+4jnxIDB9alj+DPQ/FScBzUV5k8gNv
X-Gm-Gg: Acq92OE76QlFLk1OIVh6wtOBe8xCtwY8Sxb8W+xTinEVyI7rWH3lUyRBxY+kCwet8Fd
 9WugUBzw4gfqhznb47szW0FIn1itfYKVavBP7FfsZowX+p3WWO/SVMcGCHBuA1ERLJUBIxMRTzo
 CgRGyfdt29inF6BOkTzYYa/QpMmb1lKSb3jilamgJf4WJZxp8zbY42mXICPfrs3ee6uL33Q0gPZ
 URKugdTr5SZ+ddNcgrUzQndTVj7dTXDK83Kzs+z9pX0JBSCprGWsJubjh/o+XUt8akDv9Bf4Mey
 q7jow7d5ayX/bWHcAw6xg4P/k7RDVfue/Mixy8GC4hq8IhC3Qh2NoXsrqr0E+nDvZcDHRQT3gKA
 TBAfgp+5sKIpeJCvcu4YZyrZfLTjidF+gq72waeqq0+/DSmSal/UhA+1SsaOlCFuxpNlRdleSHK
 erVO8i6jSULMpSHJcEBnad0UnKB1pW0rW/aBt4ec2G3WoTlUgy7agcJGXfxd1qAqo=
X-Received: by 2002:a05:600c:4708:b0:490:bd66:e522 with SMTP id
 5b1f17b1804b1-490c26038d2mr343852385e9.29.1781032604927; 
 Tue, 09 Jun 2026 12:16:44 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm115984364f8f.29.2026.06.09.12.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:44 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:11 +0200
Subject: [PATCH v7 01/12] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-1-0c550fdcec15@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=2201;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=9+RA4/uRgkyYUZwZVDrcY1V52SqthzJ4VPoz0W5p3dU=;
 b=9bTaaLuF5xIqXgktzI943lEKRWKFzOs+8QCZkGZ9d+JvKgWFn3nU/lRAu/AYVnjiEu9FgkQUR
 julBy1wtjjEDjKQOOPJB0AgPgrt8ptoI/Rparf23mQsP8lXByK7b+Xe
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32b.google.com
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
2.54.0


