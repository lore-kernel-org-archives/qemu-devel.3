Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B276BCAC5AA
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hg-0004zy-Nj; Sat, 20 Sep 2025 19:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HW-0004dt-ND
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HR-0006f2-5t
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so1859216f8f.2
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411969; x=1759016769; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rvBTG/+9uS+f4Heq4c0Vn8ltH3qtiDIFK5wU9txYcq8=;
 b=AwcIKz5NWVy3/PbfQEfPtOYqtNVUQ/ye6VGVJCxe7Ddcar6dvpICuVCw9Hed4g5gfC
 lU6zfD/Oppo4sOsYzARm4UeAJLuZnHPQfZmFfJPTXcTselE/dw2yFUnf+X2bg8X6Ilqb
 K4fXMTaM8Ab/a9D29G4wjeXmioOk6I/8SdjnZW0r+JidxOoD1nzFuVsggpLFCWSH0YnA
 Vk/SzjtPor+tTlVLJOZHh3dO/U0bSil1U04vbgSDQRTiWLBTpjCSS8O4wG/pZl5rMzFT
 UCvrmJ04sWDGfWrNQgxA72e2xBfMkLcJORldhTa/myd0oNGlPvs3zicbvgPq9DOcN4bk
 UdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411969; x=1759016769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvBTG/+9uS+f4Heq4c0Vn8ltH3qtiDIFK5wU9txYcq8=;
 b=WnQCweC/iEe90abOv/kBXtaGe7eg6lD67wFaljKxnP+XiNaDyX0sRzKgT1+SNGooXj
 KHntk3JQ0E1qu0jCpRU0RT3xg5qqfNuxrG9Kpw20OJG5diQitoXsNFjf6wt4lu/x34JI
 W2P3aOCyx1ZXZ53OxV6fZGy2aMHPe0E+4lmUoMN4sTT/n7lw/TCYtM/AhaieKWQlbCUq
 P1i1uRXLykiBW1L8I+KaET362kbnrAxHePHeyeQN1KCb6LUXEODtRfT0Bt1/Is7y9eDL
 xvko3bXNi8v7gWHzQmnLvd914SMvLdEt+qvxsy0x7hAzhyo5htq8wE+7kN4tLNV04go6
 9gtw==
X-Gm-Message-State: AOJu0Ywo3JIK7nbfryHUkks0VmU75jld0XycZopsVdGwOcmnRip5jET4
 EdnomBvmI9tZqLUY1Z/CxKitDVLp4pOpYk/og2QYmJehty7+NAbYXEO7
X-Gm-Gg: ASbGncv3unI69TyWmSA3ggPUyLh4jn23jiOlFmYl/tE46u4QDDTBQ2g9RZoav/bfqWh
 yRg0ISGQQ3yCIqMy9LLc/19zKLm6AEhRHO/qGWAfKCT0IVI6ndxlA57BYcQfssoe/VlrthlUyEg
 v6oEY84YVLmiGxRF8jWB2XSGN4NVDvKEbjZP6cY83bG2vu5WlNOWFxkLLr/D6H60ecI2Tt7QIgb
 WCyA3bGktYGX4No/lHmh7T5z0PhepjrdY4nQ3L5Kc78dQkNIhZn+KsLttb99Uic656KvJJIbDil
 CKPkILXqMrsZ66GDIVMDI5gnfKL15bcAmzcGaP6YBRjxeWPuilO/ofAD4ixHDduYxe7xTYxrqLD
 n/qjnDIi/x5Dot7idEekQ/p/VZ2877AP1lG5/ZcztnjXgrJmnzGbT
X-Google-Smtp-Source: AGHT+IGRoj9SRzbKiyUxZ3l42ZKr3XtggmDkJcvnkY2gig+0IRgpvA5zxFCA81eWWB7UW8lHAa16cw==
X-Received: by 2002:adf:b35c:0:b0:3f4:8579:3692 with SMTP id
 ffacd0b85a97d-3f485793972mr1680268f8f.11.1758411969007; 
 Sat, 20 Sep 2025 16:46:09 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-464f5a285efsm161723765e9.18.2025.09.20.16.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:08 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:33 +0200
Subject: [PATCH RFC v5 03/12] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-3-89e3c6727060@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=1677;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=EbVowVm5LMaQukItgCxeH7pJeB8Mnn5jMPvv+tRJQpY=;
 b=iyft8MpVjFYz3uVM9G+jSleY9DpFYRLWM4DW4Hl+UbKYvPbPZasxhYg3+LYKdpco50XmYIim9
 DSBkY9J9WTFANsHJwkuQZtZXvyHvH48k0P0yfMnyTFAWGQthSPXzgU8
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

This function should be called whenever we learn about a new size of
the terminal connected to a chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 635d19fea4fd4bd0c7f171f055fe940f9f5ebed5..b45d79cb9b57643827eb7479257fdda2cf6b0434 100644
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
index 45cb6349756ac8072dffab9354108caf90cd3565..1e69b038241074d627ebb7f096e98aee9953ebdf 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 

-- 
2.51.0


