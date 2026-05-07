Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80F5CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoQ9-0007OH-7R; Wed, 06 May 2026 22:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoQ1-00078L-9y
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:54 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPz-0007hp-Sy
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:53 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-688a8e5fe5eso181723eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120689; x=1778725489;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VP2ZZa8QaHuzkqWfiEQ1tuvq28xRUkNEtGYAQT4zOY=;
 b=cJY/rOgZp086vu4CPNcGe5xHMK9TWbalGbTUCNxaeXDPd+51VTSoHTj62L0dOnCpj+
 dpu9LLDT4RoARX9w9RkRP4BXxrU5viNN/3IVxUTqhjhc5fZ1GrmNMav0nmavdxUC9lQj
 Ew7U0IVhgDkviTMFqKLo3+zOQKI84rtKvUSjza0RGmCx8sWKzvilJEkt3GijIUK6yzAf
 8OCmxiWmSvvdHAkemy1CwKZGwC7BHToThxVpKN7SaJtQ9fuhMA6SQcRkk9X1x345QQx+
 /WvD4eltUUZXn30DmhnU/vQbIwoK6bWNtiHRtxpiwiD/Qk0RcoxfweNQr0WeGu/b4WY/
 O3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120689; x=1778725489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3VP2ZZa8QaHuzkqWfiEQ1tuvq28xRUkNEtGYAQT4zOY=;
 b=Z5fzYKcfg5mnDLOtPsUNmhSXhfmKVa4hd7LXvQ3w/H75o8uopneKzCqSDBlQ8lVoH2
 s1AQsrdGnCwUiKis5ucC5ZXN82yiSaAj5rvEieV1R8UrNST6JgTA91sIs+xACP8QZyBx
 hAq4mwbs0ZBoDYViJ+xX3IWZQNQYF276V8VURErMKzaPXSeUJvan6FBo8KIngP1I7t0S
 dwy8odtNpLQoz6c5b1V24OIexX/5KMp0zSdbB4vd8jaI3Fbx0e7HGGxb/vIe47MZ1qyT
 kxQPtCCbu6pwMcrx8DZRlg0kr431l4G/EoFrHq37fSvZ/HL1DUA0F8ONlrucXpv1u0vW
 SFMQ==
X-Gm-Message-State: AOJu0YzzWrOiQ9Tv22UolffTWBWphlE25jcty47Fy0E5Gf6w45cRa4P6
 yxeVOdzeN7IgFvrVnpyqiciDztgWeMgZ/eBnrHoiJSpEB189n5DEMuFVhMXQkeBey7dH6L2ZS62
 JRGAlo9Q=
X-Gm-Gg: AeBDiesv3aW44ueBkTEG4tp7QpogJNvI2tdCCUWykzz/3nU8T3avfR8I1CaZiyu3jlB
 ue+9yylPh8ZHhX3bjYnibmyMgAneEDhhlrRbzCcO1dW5N8C+aS5buKsL417Y0fONFkurm6ySgdO
 JvsS8oE4F3nNuZKdBHAQdi1Fc6k7NuU4y2gtCUjDV8cUt5R5q13/obdiyhCk7Txeb+GqgX62giV
 MYDkpMxG2/GQZGVSB/eyJHgZD1391DiM/PGVSrfrW95Qxe45I2qKA4QNcBs2h6n0Qy/edzJbDxg
 Hts4jhj21Zmcnq9bm4CrA+u/bOCC9xnMkl5t1kGrd+aw/ueIpB+YGbWxf+OVpZ2gn5h0BwXA1XN
 cZCAqq9gmBuj8USDkt4y6vynCmvV5/Nb3sZgF3eR/hg4prOUSHh1tymUJHmLnYnbedCoEdKxGOo
 yAobBTuudntvSedSE3eYEE
X-Received: by 2002:a05:6820:4b14:b0:694:89e2:74fd with SMTP id
 006d021491bc7-69998d4eb2bmr3151851eaf.50.1778120689110; 
 Wed, 06 May 2026 19:24:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 24/25] bsd-user: Add init_bsd_ioctl function
Date: Wed,  6 May 2026 20:22:18 -0600
Message-ID: <20260507022219.44171-25-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc29.google.com
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


