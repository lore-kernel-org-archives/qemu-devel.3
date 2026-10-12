Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13673CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEeE-0003Xe-11; Mon, 12 Oct 2026 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdy-0003So-N0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdx-0002MY-7V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1000374f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806196; x=1792410996; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pNtIniH1QJel5ZvqyD5P6odHkDoTjuMTi4f2c38EAug=;
 b=WR7U144xcD2qqWh4Mz/C7E3PynPWIXNMQ54gMIpqQpjzZ6Hd+4ay/xY8+ApisKmiH+
 4A92CyxpXkIwcoKz5YyBEC3p6xgbjk5QOY7DtoGx2il9AFmS6t1+TxJYB23mxM0K/cGU
 EmtIS6V+kwSglyYwgsOKo868OGbZr9voJ3Hsbdvs0KWJuyYl5vk8TP72Pa6sbM+JKKGu
 2XMi2NiPd+as+kfBVGG0rjNZTP25bCV82qs39Ut/4mLpfcQ6WoIJVOorw/Ysvl7vVxdS
 jStHWUIknE4uZlv9utzueraoKryrtkUYIQjwrYhpau17JxpffI7kBrYX07hzSWwhronQ
 HCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806196; x=1792410996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pNtIniH1QJel5ZvqyD5P6odHkDoTjuMTi4f2c38EAug=;
 b=ADDosOWbOA9vCenBRx7grf9cIHkrpwVTJAJ8pbSRoqhJkJ8OfvqpnYu9cl3pUOvL7O
 NUy9SMKGWrFXu8R2DFz1MjJI/ZyESOLwUCxV68mU3M/zJFuX3KF7/jAwGhtFllZWCadn
 Cvhf5bvg6ve2BZAOPp+gYQuW+XObWq90UhMJChzzL2hw8W1dBjN6EqpnEf/qCHtLOQ37
 G+PMrGUiM50qImYlaFk4ZQNFK43OMOTRUm9fNONroNoxEDcmQa9o5nSlsM9dKaDmCiuv
 i6VLnNYDkE1DsG4b2vQJOapbdaDY6+tbjxoh6nAMn10jBH3hYVeXQdCc4kBZ2HMbfY8R
 9o5A==
X-Gm-Message-State: AFq9FYKrDQd062G5so7dlq129THjjlmqTp3rXe5SfQY328HpQ86d4vy/
 opLmWoh3VdVUzrsgEtTvoJSKgCiIChnn7jiKF+vHYKsZVeakJ2gIgU17
X-Gm-Gg: AYBFou0e7NCWD0jUkSOG6sQi/o3QOSxEPob+XsZH0CqtP845Up7WDuR06cJtRGNYPOL
 0lXtOXqm0kks2sGxsZINAVT6Cms57KA4b/SJ3eGTvx5hxuT5EApdWp4xeV9SWaLGh0ZzF3t3do1
 Gqem8/rlPuKSiHi4ub+XUcMOkWHNlClFmTQcN9FLxpVVJQRfkCCmfjzqDdoYIFKIfLf7pM2paR3
 gTYz9rIfoLIQZr3acVHZaC5p28IZAuENOGKLmRDzSbTh4ivScf2wQH+1/Rl7P7s6uZqjNqSkc1p
 DBLgQ3UQgfkHOx7L62x0uTb0W7qdUgIDS+7hlTflX/JII/RKpKwr3JXOiqPovvit0CJgWY3xQYS
 OWvt/joTsZrIyrk1DZCOS1XENgjR6VUK75h9+f9tAEHH11Yw53478XPoV5oESq56uOPR62zZaW2
 QOcn+yvD+410WH/8iwJI2MGtOLMbWDUQi1VnOb64oW5VsP5S8R+olhAAfBSSxLHgjiIHkZrDeFo
 5KaP0QqWqh+dhk02h16k4GzKYE=
X-Received: by 2002:a05:6000:4714:b0:48b:1bf:ffb1 with SMTP id
 ffacd0b85a97d-48dbacf713fmr15682753f8f.54.1791806195461; 
 Mon, 12 Oct 2026 04:56:35 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e33d2sm20220487f8f.9.2026.10.12.04.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:35 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:54 +0200
Subject: [PATCH v9 03/12] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-3-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=1613;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=nKK+EFv63K2JxuitDhYbnijeqT/iaRN7xTg5XKak+Xo=;
 b=mbyCltjMJDe/rpF9iRDPhi9mn1TfsmOuEdlYSGZWkNry1nP/PIxbTYHLIWOW0vtg4v384nLNS
 LP9/AlovFk0AbT5RdJfxYAYCKW7Zs0uCwdP5O6brzkomk2Omf4V6YAT
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x430.google.com
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


