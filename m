Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EA2E937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxII-0006Ya-ES; Sun, 12 Apr 2026 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxI0-0006Ru-GB
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:04 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0004Xx-K4
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:00 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4138136f02eso2316920fac.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009835; x=1776614635;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1e+ElYrsw4Uwy1NUtuxiSSVkG57IJLzK/avf8LppdA=;
 b=Ra4TITOjrVmFKhw/EuZBlz2BJE/iEBBRuVb3DOeIbDUqPGdGXH021/pvTQe4Wk+gF+
 T+G8+qd/e67SfXusvKfVqiUMaX5q7sYujPbYbK+buEbxkBXJdQFo/zbrRM2NIXu7ZnAO
 A1FuveJC5+coHMnxzhmzVZfL6rK3tIbfOa4oswqoChdkwy/Q4O4wqoctTURYlsitaLA3
 +WySXE4d2axCAKo5XNLJ1e0sj7uy5vSNQ6lORDgV/TtzNtCnEkq+xiMB9mFpU/8+ECpk
 GU2mtkL3MPqaTfhRVgegiOx42oJzpor88nzzkE3ht7r4J/hn6NS7816nelJq/M/yP2Vb
 nFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009835; x=1776614635;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o1e+ElYrsw4Uwy1NUtuxiSSVkG57IJLzK/avf8LppdA=;
 b=XhK4hNijQpzlE+jY//2xBNSdQzce/yeg6TnYqI9YslXHt2ZSXDuLbe6RrIobqpAaGE
 jWudba/8SDQFVOgcW5lVyHIeR4SdySbKXJljVdCGbUaeCYo/Ckq2uRIXmwF6IzUFUJf4
 8zZT9jQEFutXHwadlXMYkcC+RMoVpiJ59tBw2YvFZEMED3m9OZeBx87AeUDrC14hdDZr
 Fldxb8a2LOR8ohTxeqzNT8kdk7gww6QnlL2ncrl5YHWelAzAN1Yk9ogR+/62BqoMhrFv
 vCrOWs4p71Gh2vODvWq42zazXfXMCg6AuvrW0dt3mbiTat1Drgk0a/FTWFUtzYxctUBk
 //NA==
X-Gm-Message-State: AOJu0YzdSrnZREu/Yjvilw/2RdEPN2W8m4Z0DxuhHmmRIqY7V/oYVp4X
 42sEcQTV3SO9woADPFSN8fRB6UMJPjtk7/1BTU6ra1fwc0F8ESMJMxnE8PH3PO6oRxjTe3TpX8o
 ULLCacaY=
X-Gm-Gg: AeBDievC94EEgbLsjCCbNR625OddhNKcym8A5FiCfcWcaxdwbueVyzenCFKzP+NUaTi
 s+tsAelMNayv/qQX45gXPEPYnIeys21EfmhPvUzoqhQN46cCGOADRzHaa8YJ4sC+S0XypkbkbH6
 o9m3Po417ouCwUcDkWRSELhj3OvgJkC55WYK40GFQ1Ht2+XCKHBrAgQivj0ygSw4wa+TIIqXVLm
 1gxV+vkZlVgy/lFhXyTvil0I3Zx5PFESjnZ6Mq8mZVcDvUOceY5wL/L7QX62qGc9xCEBe9JJEJj
 5lpPtQMmHK+12vDHhgi5nthRQzobVXABMLlshIS2SJ20JRyjRfocj7cQ2O1lMKthi6SwJYP/tkz
 3M0PknCEFmERENe9TrTQkBHWX1S/URy/36gGSXJZMZzLmVnHIv9ZqHbSkZQhc47wZMpo3ffl4c9
 rRLJkH7jnGfA==
X-Received: by 2002:a05:6870:3231:b0:423:9a50:438c with SMTP id
 586e51a60fabf-423e0dcd292mr5843205fac.1.1776009835371; 
 Sun, 12 Apr 2026 09:03:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:40 -0600
Subject: [PATCH 17/17] bsd-user: Add init_bsd_ioctl function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-17-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=27UGPnZgjmD1mPVP14mIEYcoboWhKhyrLBLgJZ9KMrg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IhaIZl1DLf4sWRc/Fz+nJssuEegRJau4Obx
 tgQTCw2/XKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIQAKCRBsHNEofbAR
 AHiCEACNMZ2W2HfLDsm/OMInvqijtr33iUi0tHNu3+B7An+5z/xItLFNmI0pAuEKVleubfqnOfC
 LLCCtyPwyoNI8b91Hlg5fVO94UB8vN/7qGtVdf6yF+53Q5M/f+N3tgXJ+ienxfoFEJd3Dy56KqC
 FApjLRRiXQkTp3RvBfs7yt7B+KNaLlZj0VW4lGOJLxGodt87zu5REHELLhcrGCMQM8fmimD0nxP
 f+q5VTbKb/huidjeQMX1fXMGAapWBdRLvRAoZBjjcIJTM4TGbmkcCekioQeEDLgNeV3XyJHHNy+
 co7YZe0ZnXElxYKY591F5y112NtVYy36VSYNA1WAv3+NOyOf9RuIMcc4sl1yVWq3rmYG7l1qrtK
 8TjORRVoKawUcLQW4W3EGH/xHfWnZrvm7cHOwFoeDQvTJNJu+2E3crp6dgYcQxmqlrLgtvTQk3x
 z1jyiZkY/Vv1PEf5z2T0pskLrMT1agfz2D9FJC95kTylaeWTt4Pw/QLAkadU1uZtQjmI8lyHoaV
 X5dW+kGwRmotCinvEoSpPSYYVunIw3zm5Mt369iVaq4stJAHvf4pxO5OQaNDQRBHqQDlExbAHAV
 TbrJfS2DGzNyR6onrRQHQ9BOzobLJtsvL+zELx77+CpLV3mqNVVg6Wv4XuzSiwHbqHGizQorRSY
 FwxQ5L5VoStywHQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x33.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index ae3ac7ae24..0b6a0943a2 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -394,3 +394,45 @@ abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg)
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


