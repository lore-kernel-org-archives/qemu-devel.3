Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47548CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGeW-0008W1-33; Mon, 12 Oct 2026 10:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeR-0008Vb-Cn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeP-00066S-BF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so11983315e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813912; x=1792418712; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Db8kX/ZEk2mJULI24xKoMiCcaFqHTqsMQFyoHrvdHmI=;
 b=bImWg4lIKsEGTD6qPmpCIEholMmRLY3sZ/e5VQeVgfcJAtxtGtQkjIJ97bpLX6n0q8
 E0TIR9eZY+RdMSQP9ZY0hj5PhXSnEg8JfyDlQUnNrAGy8d6JOFbQMtk1jbPZAfTF5U6t
 0iOTG8EAoQ7FuzKKdWXlm2zEmzesWvkYgFbV1cGsecK0OigxOz4S4CDKLMqw+k2cx4f/
 kwbGlDJieKf9+yqTh2t1e8ETMBTt4QDM0jiQeLZET9JRtXBlaqYK20SP/y7EfzmzODY9
 v255Q7I3fjD2uoORBYWVboTdazs/tsaTaQE6EOgVGkQ+eYMzPB83MtG527obMY78mFFj
 uqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813912; x=1792418712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Db8kX/ZEk2mJULI24xKoMiCcaFqHTqsMQFyoHrvdHmI=;
 b=Yqfq1cuhhfRIX9qiCMtLUxDBIE70LbtYyq6Om0PLNM3L9myRhVL48W6w/eAeFklgrY
 eT/E0fiVBghfW8U/dA6jNBeeBhpFKCCdWcrPY9QCpWY5lOfIZO0XFIrP2+NO7ipR0gna
 L7HjwuqanVPCZtrujQmoygqvlCTo7UWcTh1f7AHGKZ0Ky7xMSMPQXM4TJHMe+8r8QiJX
 afYKABvJnQk5nGp6IgUiN/wQCAbgvdi5pTC3K2nV/OOKt9KiXzpe17x1MH29OYp/+NqY
 zJ+I6G9pVLLOSCroa3Sbw3vctKX+o843UA4PqA5zvHolp1kRlxi2P8nc0i5LL7GT0CJF
 NwEg==
X-Gm-Message-State: AFq9FYLuS+L868pjeYecDlY+mur4uK+xYHSDOXwEo5fzuwM6V9eEBdxY
 XyYvfDHitWeExGT0gswlhYVQwdly8xZuKJ9GVXcrpXhtaDRcXw3XR3lL
X-Gm-Gg: AYBFou1/ksJsOc3qAz9LjiXZTq+GMIXhJ6u9mUZ4MiwMxAivRybjT1E8dS3bfM/t5Uw
 /A/ciFg2vGcMmu8SlB/DDmAdDyPAprgYtwYiB9LLMMpqFlt8HGQDl0+XiR3ZKOKWLT6j2uCKdb6
 bAzJqFsdx4V1OvtlRH45+y12j95hpVrV3SbmPvMfpb1HswtY+vODHU/YG0C+cvrjjwYE0M7JYMj
 SBs5fYatALCXGO59Xuq05lESv5TIetbMXnyNGRPX3zmDuykqtjmmeeL/aNg/30bV7w0bVLfECId
 ifrGQoijOPRO1SkNkMwPI63IUV+s2AS/vg83szmJsVSw3YqFsORBxrdfaLB6VtZdo6kG/JiHkVj
 uBg6k40CPPDYlk2iFzAdeCiXMduu6kaX6V19fReRktiIIGwvOSEfSfeKRmNQIkvCR2BG8tR6q8j
 JbrajK+kvuOYchxSFjILO8k/n4nyIWazIBTHuxJH/n6wpf1WlSDjNWhMFYZDAri8ZVJv6dqHrch
 gMQH1ouXceuvhl9MNsOC/48kA==
X-Received: by 2002:a05:600c:6208:b0:4a1:698d:3042 with SMTP id
 5b1f17b1804b1-4a18e493143mr168032605e9.6.1791813911706; 
 Mon, 12 Oct 2026 07:05:11 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e49792bsm468029425e9.4.2026.10.12.07.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:09 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:00 +0200
Subject: [PATCH v10 01/12] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v10-1-2c3b10d829b3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=2201;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ISuMkVQZLr6aTSdzOIY+Zeiyr6PJh/I1vLVNp++Psys=;
 b=DioqHdsW3kovs3T2HRtC6RlM2ZFGhGpX2/m5V0HgZlgIRtlxatlqpC9NcEqp/vaXvce1veQ44
 0UOaEaGJAgVA1x1u51vdkpQQJOvVlgbgwXbxXrwdUeswaA0ZwY4PJ5o
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x336.google.com
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
2.56.0


