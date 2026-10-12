Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEFCCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEeE-0003YX-8y; Mon, 12 Oct 2026 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe2-0003UZ-Qk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe1-0002Ne-4n
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso23685055e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806200; x=1792411000; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MstEAWU1blj2PCI2V3llDd9pakarAGpJUmZdN5XPX9k=;
 b=eBMBWXqnW03Z3/nGurBtt568zqhhvqMzVfB1tgGNduuw1FqY6Tgnqq4CtdwvXdHQDM
 bM2RWkVKIwe8xnEAGlQl6w0oAgX9CKm5V891mq3fglyobBV7EX1OqzDEYfKigAc0x9QG
 77vPPaGXIoeK1FLhlUQXjngVgnajzrxSWeDmRUnYweF3Q0sd05x+SkVIyGtMnyVX2z3l
 SS2czqDLFV1/k8NvfOHYu+NsAsFtir98y1CUZ6vtLa3wumiWRyYdXK+xqfWFCSIEbx3f
 pbjo2bLNiM/rStDKFXWSyfIgT4xzvcsAQNdBhYzRdgJtkX5E6H+WBgICxOYAsB615frh
 3gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806200; x=1792411000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MstEAWU1blj2PCI2V3llDd9pakarAGpJUmZdN5XPX9k=;
 b=mFoLLp1rajOcZ8Qy/f7tzyFJtk8mdTd4wBMxJS7/IINye4cjLZltkxFc5FQ06iwPSh
 A31pipkLhg7R3LJXcRmf9BbgxOp79c3ZgMWUasvBncI7OzZ3T+FLhW7St/hvvNmfB07c
 v7LLMRibVte4t6jpxO6fr1uqm9PQeD7tR6DyNFr+c+TONoiTWLGjmeK60HM6g2gxx1EC
 PZmjYIhihW5OAunmNjTBrq76B2Hj4XQ0GIILz0ZEQBuODLTuSc+rAPn4PztwjZzesyED
 KFlTRUrAREBudqDj0baI6lIpgvspAIQ9wEHavwV5OMFPqh1/ERgZRYNnRhRoNpUh8cP+
 lWnw==
X-Gm-Message-State: AFq9FYJQdnLH2gJZkhM0ujEFo3P7QDF+wCiyvISOetLh4M9Bz7iU/Qz6
 GHm+hKMNSN3UGb9toTk8jx5BMZzPSpr7SBbC9DtYF5NFvKRePSioysln
X-Gm-Gg: AYBFou0Dd5/p/iAsIqY8oNvHzqgkl35hX7QOTpXyhGzR6l5RoRbqnfTepxdzBoi/IuU
 8JMjjRMdbOtpwJmoafrs1BfrnBooRXxSX/A4eXFiOvka/+pmA1DeV6wRNtOfhnD0ru8tT2woest
 ZEvLqgJdL/DFWtUtUENGPTILHAu7pn3EtF7itEd8O0jjg9nDu1Sm+mZntFFuEKEOV4VnE1uQigp
 Zdlbh8hhImAdqRBQkQbqklMlJ4ZbMV8W1RCZzFaTiymNI4+jgsYmfIUNaX+Zig2GMTkF1+aevix
 bGwsyWLADQlUSUqDFHWtB3XsXwV5L3IQexER6c5SfdMCVJjgcWvEuPy8bFmhL1EWNDGH0lRvcI1
 kYJdqflF5qD36KGguVwiaJgcKj4Tc+a8MArEsCHXvM9QOULIqcQmugIGwD9grkUtviU6jMZ+Uni
 xPIPjFCF0gmytdiE76Cwd2EKXDFExb2tDIMMDwr0VWa3bUekksEWcvI+nVo7oPVp2VM2J2Vyvgg
 FzLRoPtdVnzJYlW0lSDmnBG8pbvhrrmRu5sOw==
X-Received: by 2002:a05:600c:620d:b0:4a1:8d46:6235 with SMTP id
 5b1f17b1804b1-4a18e483d48mr158223745e9.3.1791806199608; 
 Mon, 12 Oct 2026 04:56:39 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bbbdd75sm221032245e9.1.2026.10.12.04.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:39 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:57 +0200
Subject: [PATCH v9 06/12] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v9-6-8db78320ba81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=2839;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=1qB0JZGl6GBNoHHB/796lwNjmYfWm4NgGE+kHTBkts8=;
 b=uoXGjhq217upC+46xf0d83205R2wI/SGBSZBw17rHbXMD7FarecB7n5yJhXt1hPv3C1d620NX
 /hXGa4kL0fmBrKdD/EoPngbh7gzqkfX6w4reVGfsUCrA58KyheIys8R
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32a.google.com
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

Update the terminal size upon SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: use DECLARE_INSTANCE_CHECKER,
        qemu_chr_resize_stdio -> stdio_chr_resize,
        remove notifier in char_stdio_finalize]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index fe1cbb2d88..58299ff436 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -34,7 +34,9 @@
 #include "chardev/char-win-stdio.h"
 #else
 #include <termios.h>
+#include <sys/ioctl.h>
 #include "chardev/char-fd.h"
+#include "qemu/main-loop.h"
 #endif
 
 #ifndef _WIN32
@@ -46,6 +48,14 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
 
+typedef struct {
+    FDChardev parent;
+    Notifier resize_notifier;
+} StdioChardev;
+
+DECLARE_INSTANCE_CHECKER(StdioChardev, STDIO_CHARDEV,
+                         TYPE_CHARDEV_STDIO)
+
 static void term_exit(void)
 {
     if (stdio_in_use) {
@@ -85,8 +95,23 @@ static void term_stdio_handler(int sig)
     stdio_chr_set_echo(NULL, stdio_echo_state);
 }
 
+static void stdio_chr_resize(Chardev *chr)
+{
+    struct winsize ws;
+    if (ioctl(1, TIOCGWINSZ, &ws) != -1) {
+        qemu_chr_resize(chr, ws.ws_col, ws.ws_row);
+    }
+}
+
+static void term_resize_notify(Notifier *n, void *data)
+{
+    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
+    stdio_chr_resize(CHARDEV(s));
+}
+
 static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
+    StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
@@ -121,6 +146,10 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     stdio_allow_signal = !opts->has_signal || opts->signal;
     stdio_chr_set_echo(chr, false);
 
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
+    stdio_chr_resize(chr);
+
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return true;
 }
@@ -151,7 +180,10 @@ static void char_stdio_class_init(ObjectClass *oc, const void *data)
 
 static void char_stdio_finalize(Object *obj)
 {
+    StdioChardev *s = STDIO_CHARDEV(obj);
+
 #ifndef _WIN32
+    sigwinch_remove_notifier(&s->resize_notifier);
     term_exit();
 #endif
 }
@@ -162,6 +194,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,

-- 
2.56.0


