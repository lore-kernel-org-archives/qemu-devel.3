Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571D0CD3444
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWt-0001cC-9O; Wed, 06 May 2026 22:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVp-0007XB-Vt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:31:00 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVo-0000aJ-Ec
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:53 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so216206a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121048; x=1778725848;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc7ktAKkXmg4BG5PFQIrRCVxKx0sZHqRW/Vi7G51a1U=;
 b=Oxy9e4O3OWpOgbJEkvigQUKvwnKf0fcXUclZ6v7lcW3yYPXKdDQ7D+KsHw0VPG9+/h
 aD+ltiaPR9UZU4YQKT8hY3qBq0n5vSt6x9hKjwAuFmCYznmHm78aUd3BgXsNtzqr85F5
 Bt2Z9cTS4/dCPB9uOEuuVwM9Dtz+Z3bLzPNtRIo5SjROJU/zQ6zdMXdVyLr0KgVfg8FY
 6ec77rAX4r4K9fYjzf1FgbFB3JaueFlpZzIQpnmJYKeG4u8YReBQDwogIYsr+JxK51kp
 4FENfFD08ALRbqaQa0QFvZj1ky0WCiMLFw9EgXPur25b3s7xT511Y3Dj2NN2OXJS54jm
 HqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121048; x=1778725848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc7ktAKkXmg4BG5PFQIrRCVxKx0sZHqRW/Vi7G51a1U=;
 b=mJzuucWcoHDT8n9YJBoKI+Gyqad6r4S60eEBMnTlxGSBwXkLEvKsa/jzP4V5Rxknie
 VBWpZ/PbEI/USMXB+YFPGRjR/ysgqChT6hGzgshRvJRzLtx7uCEZKm9sXQikeux/GsSa
 Z31nrh+2wqRo5Flh0nwmshkz0RFOvtl3lzS/XAgPLwn8LMLIOxw6lfuDg66671tbWJYe
 f4GVVKbYQDS5EwQDJAjnrT9J14DWBX8BJcgMhdEjwDpe78CzwhPTq4vdQ67A2Jbh43Y8
 CR3ibmDUk1dzAl++p0zSwMc11KNgRMVYWugOttYkQi0kdmoETqikG0YG4tHPIHHOYNRF
 bRcg==
X-Gm-Message-State: AOJu0Yxgtr0aWa/yQMdjtFeLX+3PDqjgxMQBju8BqnzPPqaxXTiA2FZD
 S2PmCW0gprpXKMpSuavkMUrII7WE/oq3JwHgwCE4/bJQM/Y6P2HQ8FkEKqNE/lZ5kFmczorJJ2z
 8P105YFI=
X-Gm-Gg: AeBDieuedYOFgxGRzZc7Q+dppLlAa/2dGbwHbCM+n5i8gLsuocFJA+YXzl8d1yWFP+R
 k3H9/eYTFEHg7yw65TTUhOzTVc0fuRJ94E6EAkxwzRDJ76WRoEPYRsRhcQ5DlpEG/y//bFjn9kC
 Ivh7oCngRAZ8Rpr/1gzNlPtpWGik2m3w/1Y61ex7VQiO0TzId1QpiF94Lw2w1Q4MDBtzUjEbMk7
 AWLB+ac3pOMwbr9CTadqvn9If6btWsYLxG5lVim8H+IAXfH/Ob1sa9y+41gYrjwsAvbGq1q/icG
 e7pVMltMnRAczeO/1N0E8iuVWp2Eo55QnOzsanlrQ4ksSrze2J/8wsG9cbj9UUV5/n4i1RlctTQ
 I3JRPnfRWiqZl2JWXvU59oLlHk0EI2B/ue1E+/qBGZwMICgNHmv4bYTpcW7P9MY+87VsokObzsO
 KnmEW1cNjlDdQo5UbDxAOOeagksKF4Q5k=
X-Received: by 2002:a05:6830:3142:b0:7dc:3d7e:40c2 with SMTP id
 46e09a7af769-7e1df23c9bemr3813545a34.27.1778121048181; 
 Wed, 06 May 2026 19:30:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 25/25] bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c
 to the build
Date: Wed,  6 May 2026 20:28:27 -0600
Message-ID: <20260507022827.44499-26-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Finally, connect do_bsd_ioctl to the build. Call bsd_ioctl_init() from
syscall_init()

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 9 +++++++++
 bsd-user/meson.build          | 1 +
 2 files changed, 10 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ca819fc530..90ef1bd916 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -34,6 +34,7 @@
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
+#include "bsd-ioctl.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
 #include "bsd-misc.h"
@@ -689,6 +690,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * ioctl(2)
+         */
+    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
+        ret = do_bsd_ioctl(arg1, arg2, arg3);
+        break;
+
         /*
          * stat system calls
          */
@@ -993,4 +1001,5 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
 void syscall_init(void)
 {
+    init_bsd_ioctl();
 }
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 9cc5c6c459..2abcae5122 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-ioctl.c',
   'bsd-mem.c',
   'bsd-misc.c',
   'bsd-proc.c',
-- 
2.52.0


