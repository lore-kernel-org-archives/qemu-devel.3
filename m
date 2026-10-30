Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A6606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D0MJWIi0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgF-0001Tl-OY; Fri, 30 Oct 2026 07:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg5-0001PU-26
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg2-0002nI-PI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so346835f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359301; x=1793964101; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6GoihID3NL4nc1Mkmoc/1/qZ8Kz/J2UXjW1hpXDbIGU=;
 b=D0MJWIi0Z2wZDBeY5srXrQJQi/yC+75hbGjcsz+i8eI6i2tbVflHSjuP6jG9xgT0Tb
 RmldrRFFcFT5RudSjzK7D3ZmiA7/9Z1M3LkMNrvf/kz2tHqjawQtiniHeBcLWkXX1FWp
 uaFgqfo3dG+VxpRX6MFKQibiJi+spHncT4aXILL23l21WPoZAB8lhPgvwwk2oQMKA43M
 ujLXUD/srnbvqBWl1bGY/sviR4E/gM073BHVxake2diJ7HXRAoQ1pMhbvkY9MBqQIZq/
 Eteu+GFu270MX1THBb8SysTCdTi9/pxA9D6SrNvEHjauLtg5x97Ast1JXSx74eedCIpO
 BczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359301; x=1793964101;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6GoihID3NL4nc1Mkmoc/1/qZ8Kz/J2UXjW1hpXDbIGU=;
 b=INKLxqoC/9B0+qLQikv3ZXSLSr0Ux+tAAes2yRgBCaHdX6lj8zLatLxbwYNJ9otkkE
 bniquqaweysFC4jYnl/PS96DW7kkEfwSP/jMO3uY2f7oFmEJWSgg9A2Inlq97BT5igM0
 1TYcEZjqw/xBPpOms8AZ9UJN0N9XY0gSHLarkwORObf54x9Pn07vhi77VZMkXNmzjLeI
 pZDc1rxpT79SlMZJriA0/UyXEmCuZlU15TUxGZ80OlThKJ+47R2cI55J/4uwsCt+vtWy
 RSFJC50JIdshv3KqK4GT28xSXg1TAmztdpaRSjPRXa69/R5rHDbkI2J0VpaLfqFc1TFZ
 /jlg==
X-Gm-Message-State: AFq9FYJRwIMIfQK9iljaRaaYJFFzIhFYVFgqMq0BNUITWlh9OjMUFgq7
 H9RpWMk8aLJdq6K9bivJzJ/5SJ7heptYgJtn63VlazKmy0U7AdCtVs3V
X-Gm-Gg: AYBFou1xBen3aYzA8hhpGzdjnsoAZfFs8K3+Rbw7eklHvPc6kxCJkEUYETU6jAjxrDe
 ZnSg4ueKHu35qKf/1Hn9Oixeo1POILXze4Ndyp0VihYbbiSw+J6UlWhN5KteiV8WpysB65eWCAm
 KpZ6rG/zPB8KGmfa5hvYjy2Xa7ToCERL6MdxhXwonpzRERI7yUoKGa5nrD5xsZvLUaJaFKjG/aJ
 4gMOr6PioGuFUbHCNrm4tSASRCE+gzsD8zkHX+AijZonx8IpWwEulPDf8KoaK0mtDuF0BYet8Cu
 Hx8DmrrqcibqUDnVREc3kbVKFTwcZ1vLiZ7k6APgl9uPDt8h2QzPdz3hEr17Ko0K4mhqluEYaQb
 m+q3Zys4XpCpmTphlmeNDwCi3sI+1ee39deNeNEp7SeJUZ9QvFShn7g0Z+SbGc34y/O0MYGZT+T
 FA3STGrRiBuixxv1st7/U5vVXGxNZL2uv+crNPJS/JRUl7T1pt9ImA6rcGeZpcw4rSYHtwJ6sbq
 NWNAm7GOYf8m63IfEs9a123bKtwKnc+awi2B7UiCHO1DmzqJgZK3qshHpL5MBRWAtjLxjRVRWO5
 FWmmE525PC1GXk5UAexV4ihBMo6GHW9XidS0cMdjlhjuj8kvZk4S/eGUh7KzT0sIPRzq1TDht71
 JSX0IDmE860yvao9HbCXeS2CvEkm2xs7Sid0m39xyot3Xz/cvTGXV2/W4kH3eWg==
X-Received: by 2002:a05:6000:2f84:b0:48e:e98:8b64 with SMTP id
 ffacd0b85a97d-48e6e2eb232mr4479528f8f.19.1793359301149; 
 Fri, 30 Oct 2026 04:21:41 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:40 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:21:02 +0100
Subject: [PATCH v2 9/9] contrib/vhost-user-blk: enable it on any POSIX system
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-vhost-user-posix-v2-9-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
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


