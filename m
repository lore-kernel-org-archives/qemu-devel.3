Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB200CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWL-0007yq-4D; Wed, 06 May 2026 22:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVo-0007X9-Rt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:31:00 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVl-0000aE-Ha
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:52 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de46b8e432so336190a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121047; x=1778725847;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VP2ZZa8QaHuzkqWfiEQ1tuvq28xRUkNEtGYAQT4zOY=;
 b=wyG24FtHywJED43fY3lZLainw+sask6thbnyDgm1DTEACeAF5TNszui2Ub539W1RGK
 LN6B20iGC11YYBSYPX10zNlfYsjdGM8RSMlctmtWSubsHSL0/XNn9UuYcng9y8sY8Lvj
 dhcD3EVGpiD9f1mSrqBvXWZM+wllD5sHRVeu1nU7k13iRx/L4sfjlXfsPEXqtFB3zd0m
 9iNhoMT9O0Vn1PtBxskmJdSmKt7sdwtiVEuuh77Alk35gk7hzgbk8brfeZ5mW+ns2Vmp
 NDk9ddPJpJ3tDLCfEna0xvWUlQaEqSag05SUeosUSMYof+2TA8h2ZIRzkKTvJQ4WGDIu
 cEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121047; x=1778725847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3VP2ZZa8QaHuzkqWfiEQ1tuvq28xRUkNEtGYAQT4zOY=;
 b=OvaH8Z1vx7H/rMW7TlXpmRh2Lf8iX40QihXbMJa9f/jSURgp8n7WnVexjUiT0xuBZD
 GUNGHCwVHGQ3W54Nxm3USkjrjGSeMaQ7NaIuy2fs3OAVdhOGcBBBHeaunLKuydbF2Mnn
 Ie2MQ1tGxzSiO84xbzbfij6qdqQINPJF/2okENUtNJnr4N48MjaML+WiIBymh6bAZbv4
 dIwXmMm3uapoEA64DDRh5HV/eXYUxPkeyhwvJsOkq5PtzzxSwwdNr9mcGkIXb2ZzWS1w
 HQUNfsz5l0HaLADHP6YmCvWGIL21FsIfy1BsvUagFcTFyJqYXTeevh7uLr6TZr2pf1cn
 kqaQ==
X-Gm-Message-State: AOJu0YzWNoX/RVP+WeuNl6gwzDjLvrVHWKB7ZS8/wObYQBVVbMKTG3DA
 LUO030xehVQIKqkFhUmuOoiY3gh6dyDtZTJqsQzT1bQWtybPaquAFy1+rSITvGyWaqHZ+l8+jxF
 n0hBaDxc=
X-Gm-Gg: AeBDietCZIaI1Vy5XJRzYogdWAfLIFkIcY/2A3Kx13dcu2o97xG61e3lO0oVGtJrgrR
 o4u05C0wH8w8uJ60Ji+4VKediAB0ixT3PuZJTQi66HYn4b4WWUek4MaTmdBkZh4fiCIZ2IbIE1f
 BiPSdtbnGGztk9Fgq0Bsht4Ffzp8AcRR2v881dvRhfmGSbnbXGM4FrS6qgK7ZU26yq/tgQA77xB
 GoqVAYxdbddTHAo75Gy1CiGxSPHG7FdA1KiKRsdRNVctTepSbkxsRpqLiabHSxMOEcxbK2VV0uO
 wxTPgizug74Ei+OJ7ik7RnjkObLNFLrpxpdThequCXm9atSSCZm9fakb1oq0jteVCUSYZzNi26z
 V+nWdxSPSivZf8NiCStUGPDByyDiC9sDX5SWjzYHfIC3pjawT+Y+jS6VcYha/z+Yt6bNYEjyesy
 /RZZ8NbfPBp6edpQ90d3W8blfyBgCZtrg=
X-Received: by 2002:a05:6830:3787:b0:7dc:db3c:1d82 with SMTP id
 46e09a7af769-7e1def16ecdmr3839784a34.10.1778121047222; 
 Wed, 06 May 2026 19:30:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/25] bsd-user: Add init_bsd_ioctl function
Date: Wed,  6 May 2026 20:28:26 -0600
Message-ID: <20260507022827.44499-25-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

Add initialization function that registers thunk structures and
patches ioctl table entries with correct size parameters for
target architecture.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 3940a69260..15e80bb21e 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -392,3 +392,45 @@ abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg)
     }
     return ret;
 }
+
+void init_bsd_ioctl(void)
+{
+    IOCTLEntry *ie;
+    const argtype *arg_type;
+    int size;
+
+    thunk_init(STRUCT_MAX);
+
+#define STRUCT(name, ...) \
+ thunk_register_struct(STRUCT_ ## name, #name, struct_ ## name ## _def);
+#define STRUCT_SPECIAL(name) \
+ thunk_register_struct_direct(STRUCT_ ## name, #name, &struct_ ## name ## _def);
+#include "os-ioctl-types.h"
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+    /*
+     * Patch the ioctl size if necessary using the fact that no
+     * ioctl has all the bits at '1' in the size field
+     * (IOCPARM_MAX - 1).
+     */
+    ie = ioctl_entries;
+    while (ie->target_cmd != 0) {
+        if (((ie->target_cmd >> TARGET_IOCPARM_SHIFT) &
+                    TARGET_IOCPARM_MASK) == TARGET_IOCPARM_MASK) {
+            arg_type = ie->arg_type;
+            if (arg_type[0] != TYPE_PTR) {
+                fprintf(stderr, "cannot patch size for ioctl 0x%x\n",
+                        ie->target_cmd);
+                exit(1);
+            }
+            arg_type++;
+            size = thunk_type_size(arg_type, 0);
+            ie->target_cmd = (ie->target_cmd &
+                    ~(TARGET_IOCPARM_MASK << TARGET_IOCPARM_SHIFT)) |
+                (size << TARGET_IOCPARM_SHIFT);
+        }
+        ie++;
+    }
+
+}
-- 
2.52.0


