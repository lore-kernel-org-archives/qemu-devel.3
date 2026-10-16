Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E6CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHr3X-0000po-KU; Fri, 16 Oct 2026 19:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHr3S-0000pT-1s
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:09:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHr3Q-0008K6-FX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:09:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so241891f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792192175; x=1792796975; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PilHsZjcEqFGHnD62Vrw08iZjdj9emsAmAEgEd76DEM=;
 b=QWP1AGVs3k5gzuTtWMBQRk4Vy6YJdi35QFwEOeeOGtceFE7ePESbZG42LsKdItQXOI
 cjYlyNC/KFj9mzJgo1FwxK2AN+/gDffs1b9oqJCkJQSYbw9eKze005FleqXyaOQ+cVqg
 UvDwStYcTF8sIyuJoR5gawq1bwg4slgbZGreNR3jbjeA4tfOaf6Py9rXaUuT1l73tH97
 C3mv2rfIUHj0Sf/mpfz6NhzVVqAM91FvQgy9CfNvQdrS2KExBQ50/mPdDhpGlVRsKKCp
 NAo3l1E90bEeL45u/KkKBttr14+XLFqrIBB/lpZi9mglJoPaE+iDTqNi8FFyQASjIYXC
 j3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192175; x=1792796975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PilHsZjcEqFGHnD62Vrw08iZjdj9emsAmAEgEd76DEM=;
 b=y+gPavgAAH1Wkg+9+07SkEmWWPa3mzGrdXp4jES5fUX0ah9rGTU9Lrlij3Xzy+8r1j
 8fPy1iEPri7bfP5yX98NEaNY8PQh4dgr8UnQtGPCn3IcvJZ7mv1ipG6YfWbN3amDd2bZ
 /YaOUBfqF2uVyyaPF16SLz+QeupmZX3Uuwtrx23OMdDj0GlCkhXBVGZozO5OON9HDwFl
 ojHOk6F72Y1eSYLVEm7dgl9/b32KWpANE6jhF9edRb8PIfW9Rb8hrW2YBaM5yAJnGaOV
 D5vIDeWnMOoobveXa33loJQB5kNHYjou/64vYph/6sf3c4EHa7AivYTZ75N0vhIGs5ly
 fVbw==
X-Gm-Message-State: AFq9FYL/uXOfO3pNbEstJ1t/5tJuz8Gb7QQo2dxH+fMFzp6yq7WhyOil
 AFF13emGsmc8obVNbKp6VgHSyNxZdSs5fyIP79agA++C4h4z3UunuDezsbh/Aw==
X-Gm-Gg: AYBFou3UugSli83nSGjjcyWiZfkENNOFuVAfyTR7FD9bz6LMhdbs0xe/TENXHs+tT7+
 iTXZOzSFgWsFaeAmmqPFmnBuLIBZfudvepe7KMHntCaGZGQoRfOXIYi+InFrpfIyILRLssUH0uq
 Sv/sF/LcX1Ukdv9GOcSrZC9NtIutgohgh3lanc5UqKDuZyr4kvWoQNrhLiuKX5bHOHYXg5FPH8y
 L80AmJsdMeSE6XJ1r1MFBP1nNTq18qP7J25/dQ5B5t5VdEGF9+05yHZAlK9gSv0kGpHITkfbCBI
 NDX3A6LKqV17AugV64+ZmLJLxjHRnSf0UcXfP7SNFrc1z6o1f5ntc7gLu+7UewkOMwXSA1KYmiT
 R8rwfu/6Sa4oWursxHCHwqVSonG6SAFPd1id+58TFgmEBf7mDrMQQHQHFS4rMq4aoeJ9uI5N++p
 hs8bFZ+ijW9zrpqQRW4BTbTkmWTqC07xZ/Rrer2X6KU5JMn0chdDzw/tBunMSn8FSgPjRLdFJDP
 qGIGT/lvSEwftKwWhk1gRp0PzST
X-Received: by 2002:a05:6000:260d:b0:48c:7f18:c85e with SMTP id
 ffacd0b85a97d-48e07fabbb0mr2099720f8f.45.1792192175040; 
 Fri, 16 Oct 2026 16:09:35 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfdeb18f8sm7096091f8f.20.2026.10.16.16.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:09:34 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sat, 17 Oct 2026 01:09:09 +0200
Subject: [PATCH v3 2/2] io: report a warning when a file channel is created
 from a stdio fd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-fix-stdio-close-v3-2-cfff0122a2a4@gmail.com>
References: <20261017-fix-stdio-close-v3-0-cfff0122a2a4@gmail.com>
In-Reply-To: <20261017-fix-stdio-close-v3-0-cfff0122a2a4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792192170; l=2300;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ImrpDK3H4/c3AIiT6aboGHS/WPcNusQTjY0EvxWUaPg=;
 b=XqmYPnhHsxtBUQSlq6umfyGBF9PQTumpNO0R81YMKY0aw6YxOgvrZVR2uB9oJpSJkSBD6uFW8
 bIvqfUR1YEADXRCLyUSS9jv8jULN5MpmZ0vgCxPe+o4pfSU9V1ckZJu
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

A channel closes its fd when the last reference to it is dropped.
Closing stdio fds is typically unwanted, so warn when they are passed to
qio_channel_file_new_fd().

Change the documentation of qio_channel_file_new_fd() to explicitly say
that passing stdio descriptors is incorrect.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 include/io/channel-file.h | 12 ++++++++----
 io/channel-file.c         |  6 ++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index d373a4e44d..6a6776ff8e 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -58,10 +58,14 @@ struct QIOChannelFile {
  * should be used instead, as this provides greater
  * functionality and cross platform portability.
  *
- * The channel will own the passed in file descriptor
- * and will take responsibility for closing it, so the
- * caller must not close it. If appropriate the caller
- * should dup() its FD before opening the channel.
+ * The channel will own the file descriptor that was
+ * passed to it and will take responsibility for closing
+ * it. This means the caller must not close it, and must
+ * not pass in descriptors that will remain in use after
+ * the channel is destroyed. In particular, @fd must
+ * not be one of the stdin/stdout/stderr descriptors. If
+ * requiring a channel to wrap a descriptor that should
+ * remain open, use qio_channel_file_new_dupfd() instead.
  *
  * Returns: the new channel object
  */
diff --git a/io/channel-file.c b/io/channel-file.c
index 5cef75a67c..4c9da6619b 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -23,6 +23,7 @@
 #include "io/channel-util.h"
 #include "io/channel-watch.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "trace.h"
@@ -32,6 +33,11 @@ qio_channel_file_new_fd(int fd)
 {
     QIOChannelFile *ioc;
 
+    if (fd <= STDERR_FILENO) {
+        warn_report("potential bug: creating a channel from stdio fd %d; "
+                    "the fd will be closed when the channel is destroyed", fd);
+    }
+
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
     ioc->fd = fd;

-- 
2.56.0


