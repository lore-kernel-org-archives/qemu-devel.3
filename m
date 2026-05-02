Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D862CD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsW-0007uw-Gj; Sat, 02 May 2026 13:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsR-0007th-Cq
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:40 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsP-0007Fn-V3
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:39 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de4ed0593fso1693546a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741896; x=1778346696;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uXSkyeAuBF8dF7CtfiQUOv3GW9Lp97cqaaHYWkMyp/Q=;
 b=VR6WBv+aXRjK6/VjzBxU/BI7giI8Ez4ccNqyVr0+klozkz8gTeKmC0miZ1ty2spQQY
 9HIRK02phnXR/QGUKDuZzY6odHARBRyZoKqL1zYV8/bhLnQGvRohPaaX45e/LcrrTjUM
 qlBdZUVoeN7xokl49F5CXE6O26OOJ6RWFm2zWmPe6BEaljA6ezt5UAdngvrBctCGclGt
 4qOYXPuJI3M2Y1YtIJYTO83aEuQ3lgmi53Drd9j7VG/fObB3x+IuVOJsXOn9r45zXbgG
 WTWEM/DZpJke0f5Qe+rfTYL2hHKGEZLVbQ5rBs0M5WEWs/gpVKPzjnotHVoB4jOgpx9q
 y3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741896; x=1778346696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uXSkyeAuBF8dF7CtfiQUOv3GW9Lp97cqaaHYWkMyp/Q=;
 b=XjmVnPrlXYQPsAnrsgEmSwV9amJJ4/8taNbJfwYMuKwpvhYcBsznk9O4cQm4s0h+rV
 FGwQ5Zq+q+GE62+JwaGmoH9dSY8AspU67oyIISqTBNoL/At06xoq9VnqIBjcKgWyIpP+
 Kow3TNCkL1y8gGRVd/UZShS2cvZw4IehvYIb7dQnLq+cdbdRAG73eNvNREqhyizgHjBj
 kLGWPBsH3ptFGJ7YEaViJua/fBtqinIurpJ3bItNdvrwIa2b3PKLRT/lZGvajt41rY/b
 J01Kou+kNYMb9Q2RS8/WUCm/a7n8XvxkHLl1mHzNNuQeo2tSTZVaoYLYtzgPLiv1kqqR
 y9FA==
X-Gm-Message-State: AOJu0YyT/ILDVYbulKwWFttb0oz7HzyAfoevddm/87fOH5Cq6p7XgVmr
 0yXJw0yCdOOuLpo7DXbj/KYMSepYsBnakj38Oh5wHCvQq6gGsv4f2DVO/ujmKrvbm/uNnzyclaH
 Sw3iQjy0=
X-Gm-Gg: AeBDieull3bYbnLVzezIlmW9lhO+CKHr2R9EXu7fWt56nnlp0En0d8V/bw1V1RPfJFA
 F6h7BBxeOXekNfB3WFdqdmTgIeYJ4/eyI7KQfki56zi99Ci7VBwtfcP5mCQbaDW9/XoO9pJAWpi
 mtrIW0hQH5qC1e56VWo5qh9Rje/9mPjkkiMzIzacHt4AWYrYfIf0mN+lPlGPs4QHsB7CZ1rACSe
 6pU/MMomk5m5kOzN2BLl2OCrb9NHera+NUwaGu2rKB8zDTp/Xd1j0q8JxOo13/l6CHoXe5fFQLh
 qRS/lVDkZue2d9PzWW7e4XoOccyRmo2E4JK7xoxtXWi6VM6QyU2at2+P3UrzJS3mxUvTGA3Ftbz
 mt5u8sKQU04snWqCo2e4H3qk8PpwOwC6ebqpzJ+YVf+s/BbXpJB1df5X5Hcro6JvalkAzxvrhnc
 PNywAw28UsJDzx5U9q/mnO
X-Received: by 2002:a05:6830:2a14:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7dee0f85980mr2197075a34.0.1777741896662; 
 Sat, 02 May 2026 10:11:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:39 -0600
Subject: [PATCH v3 18/19] bsd-user: Add init_bsd_ioctl function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-18-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=+jZfdOHvs6mPyd8v5lZEHn1dUAl1Uq1WFnmnnryznIM=;
 b=kA0DAAoBbBzRKH2wEQAByyZiAGn2L9GgeTSOP1tZa95+aktPTv924sxHDib39gqOv1cAJD9zB
 YkCMwQAAQoAHRYhBCA1+JSwCqPPfM3ht2wc0Sh9sBEABQJp9i/RAAoJEGwc0Sh9sBEAKPcQAIl3
 FGWkEZKiMXsgnB5gzBcfR4qKdM7RRcUouq1f3k/nn9muD33CB7FIVu9gljaaYVkhNHysUPQO8bm
 Hn1ApU5Sbc2cJnWwr50M0Wsb81FSQuN48Aq451dAduUuTd3jJqGGqhLGkuKQjMrIDhPWBTfxQ41
 AThzONg+VC4kTZripIKf3uT1TdKPHItwie+Hcpzt+JVqPouN8uXr4l5i1bX6nevIe0tmdFEO8Oi
 JH44F8J08bzYPPPBZfmBmFwbxHAqQDGdn5b1jVl19xlgFDKw7XUK2D+y65VgskfcznrBqXt/XJr
 SjiWgBl6IqTiyxdNkR3jDKtDmnHuiLMCsEzcRnHL+XhKp0DqPl26YTwaKz1dSKnWeMTndyLk+57
 D2EPKJ2QFiKSZncWsggHjTpFx1MrSe/TOpcHpQejM/Q2Nq26IHgVD4E6kfk4HxiOWcDzJuxSV+K
 +8md2JRC4LSXlHfpsYbYGW14rhJqgZ6B/nAleT0E+5qvTi0l8XFaf/SD87Tfcr77rJKyPYPvx3n
 7/eLVr8GZhswkP9Y5uxfdn0O8dvGW6AEl3IISyu9+q/80ToPCTV8MNUdET+6JTu/+jC4Y2KS751
 RzW1JOjfN+GdaGwoTdJ0sRTaVgXSfL9E6n/HHZKXOHvorWCBUTQUywWdZXV4EzDTwzv5OTf6Dc9
 eMmzW
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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

Add initialization function that registers thunk structures and
patches ioctl table entries with correct size parameters for
target architecture.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
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


