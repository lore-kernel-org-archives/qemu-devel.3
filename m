Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EC60A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G+CMGrBZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtA1-0001z4-Da; Thu, 22 Oct 2026 09:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9W-0000Un-Iv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-00057v-9y
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1072965f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676890; x=1793281690; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6GoihID3NL4nc1Mkmoc/1/qZ8Kz/J2UXjW1hpXDbIGU=;
 b=G+CMGrBZoUIvpsR1nwe7uputxfYhJFBc/5kjLjVcUBmDU8DMDcryZvC4UFphGFUBIR
 yqaiN9PtXvAKYPZS8g5LZUpHXqSIbXlvQcySKyFDEXNb1w9dA6waGmWBg7k5uODK7r5j
 iA0dJ5t+2EE4yi2RUFb2h3y4wcxGWe/cQtIpa4C9XOY0u86LDOQmTcCtmA2rml1e8RPp
 oBV7pAuu3jYIws+/1CYncBO7rWGJ/QAze+/Qoz/GzzN+gDIAFRVB4KXkOZjF5Ek8nurE
 1uk0MO7IWMrNKl2v5CZzyS1z1wKUKG1XP3Zv4ApnEE3YyriR9DSDpw0YajnHLuoRiQeC
 skPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676890; x=1793281690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6GoihID3NL4nc1Mkmoc/1/qZ8Kz/J2UXjW1hpXDbIGU=;
 b=aW0LVat6Lke2DHSEp20c//MntrOIfqNl7DdGSRl8QSJonNyFmnTo/gO3DpNKd1cgNs
 Snl5Bas+ELtb9u8XVUzuOPFYrmmXfJJp0y9eB+AqFDbXDetGIRb6q4f50u0NkTSwreGA
 /I1KgkLYFNELJ28lJsnPAfi2k4d/c3FN96oFjc9gyFtN5RrSNBcg13EyKwhCZIcuduV+
 ieWt9XSdTrTdQr1D3+7vYdoX5/iPodrP13dvJmZeKlpZUGHpcX0z8JLI3B1gcgFA7Y6/
 Ict4xgm+pQdU/DJfCfDxpo6U1ZcMbs1FbMQeaHU9w1rSD8NlYba34dEw1I8nzklVjbVC
 xy6g==
X-Gm-Message-State: AFq9FYIjkTX6U9zD8AZ4bOTJAfJN8trIaOkn3JIMiV57pfkMjpt8hcVi
 nguMJ8YOzQ44b/hjGKRnpaboRbYsMMyLD2ToYwglHT17yIAvb41Cw68J
X-Gm-Gg: AYBFou0lF9ltVwQ8dEpUnRxyyc5O92nX+oOKbrrRPgh1I/I+qf2L9Y+iFLJsE663WrE
 roh0+omS72Z2Mo3C0t6vJRceM8K8sA9+9VNXjWQJ0fLzrkABv+WhXdCKJ/k/eFjZ3zHSsRR95og
 WKI5AeO/7R1rUNBwtELB06yOudIRW5iqItvpURkgzh39kjRdhyl+THSkVYkZpFQwuVtj+l82i9k
 AagcY5IbzFGSykIEhZXN10fETn1mstiqQ66D4r6CrJ8utCjbrizLSvtYeR5npikVnnyI56bVRjM
 oayCd8a4YVd/LW/JVAKvpcQLH2HL392bQRlng9/FREFst5N8HJiKIsIu0Hb0GNFOLZ/ytbalfW4
 L3khuYtkQ8AP0Ka72ySM8vkiUMQy8fA4Bz4exPWuoTLXuqiXoP5XN4vLzh0LFbxkzlPany7Jl2a
 zDfd4EY03rOsbrwfTuy6oF/2Quh3LpfpZcJDQ+KDQs+7oC1EjeZ58BU/pIjfD0qnb5aISut33Ci
 traGP7hj4x97pD790VY51WgLGz/PZ43QjpXh13Mrz+eFheS3bWwmoXWTxS+b9VHfwWZB7uYDUp+
 gtaW9JYdxub++1CEPwwQ7tbXSVvavyJxz3NQvkO8CB4qnzOuBkQ1BQfp+A7YOA6WOzV2rvyoIBE
 lbGVXq1pVAA==
X-Received: by 2002:a05:6000:25c4:b0:48d:facb:5937 with SMTP id
 ffacd0b85a97d-48e2642d1b6mr11766931f8f.7.1792676889686; 
 Thu, 22 Oct 2026 06:48:09 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:09 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:28 +0200
Subject: [PATCH 7/8] contrib/vhost-user-blk: enable it on any POSIX system
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-vhost-user-posix-v1-7-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

Let's make the code more portable by adding defines from
block/file-posix.c to support O_DIRECT in other systems (e.g. macOS).

vhost-user-server.c is a dependency, let's enable it for any POSIX
system.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 14 ++++++++++++++
 meson.build                             |  2 --
 util/meson.build                        |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 6cc18a1c04..419ad2a10d 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -25,6 +25,20 @@
 #include <sys/ioctl.h>
 #endif
 
+/* OS X does not have O_DSYNC */
+#ifndef O_DSYNC
+#ifdef O_SYNC
+#define O_DSYNC O_SYNC
+#elif defined(O_FSYNC)
+#define O_DSYNC O_FSYNC
+#endif
+#endif
+
+/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
+#ifndef O_DIRECT
+#define O_DIRECT O_DSYNC
+#endif
+
 enum {
     VHOST_USER_BLK_MAX_QUEUES = 8,
 };
diff --git a/meson.build b/meson.build
index 4f4068e7a7..1250d467a0 100644
--- a/meson.build
+++ b/meson.build
@@ -2177,8 +2177,6 @@ osdep_prefix = '''
 '''
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
-  .require(host_os == 'linux',
-           error_message: 'vhost_user_blk_server requires linux') \
   .require(have_vhost_user,
            error_message: 'vhost_user_blk_server requires vhost-user support') \
   .disable_auto_if(not have_tools and not have_system) \
diff --git a/util/meson.build b/util/meson.build
index fa174c07a5..54ca587362 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -105,10 +105,12 @@ if have_block
     util_ss.add(files('filemonitor-stub.c'))
   endif
   if host_os == 'linux'
-    util_ss.add(files('vhost-user-server.c'), vhost_user)
     util_ss.add(files('vfio-helpers.c'))
     util_ss.add(files('chardev_open.c'))
   endif
+  if host_os != 'windows'
+    util_ss.add(files('vhost-user-server.c'), vhost_user)
+  endif
   util_ss.add(files('yank.c'))
 endif
 

-- 
2.55.0


