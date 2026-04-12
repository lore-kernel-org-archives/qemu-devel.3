Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B231DE937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIG-0006XT-Kz; Sun, 12 Apr 2026 12:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHp-0006Ps-Fj
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:52 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHh-0004UB-MB
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:47 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-404254ffe8aso2409445fac.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009814; x=1776614614;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AMr7jz7FRFjQWOZT8lC9LVSiGIZkZ996tBpI4CHStjU=;
 b=eM7YZztDmRcF1DjbYy2y4eT1yFBm6o+UthcW62p1xUGES6Fc2dKZskiYQEOUz9LloF
 SFh/WZTKPjSZecKKkA+MoAEVGD9ffgE54mMQhIFIn2z32EIYOBfxClUz+ijOx4iMw06D
 ukMNmHg6psmnlv/3U0PZ2ypl5/WVov6+fQ95SuBDKuF8Wq2LNZ1HY/4+MgQc7DMMlbGA
 cEhblx9RsVIcq6VsmOFkCEgTE/Y31kr8OF6BdZj1vG2SHAeWWyOrA9yL8r+gBOJy9Rdk
 1tym9nphZveRLo1kIWoiQoyfxY6iSCt/TPQD3KFdmg+Mo1pTnVWl+vb8P8fk3INmiF8P
 J3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009814; x=1776614614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AMr7jz7FRFjQWOZT8lC9LVSiGIZkZ996tBpI4CHStjU=;
 b=QLDqe8eCPY6mSz+2j7lLO7HRgYpzLkr47+6/Z/Edyu7uknL0BegtH7Y5A4BnyetibG
 4caY6+zpHF+6jJNQZmfdZJ7nSANwGfmJsFzexmYA9FhsEG3jFMkbRSWbsgOreXO974uW
 HSdlKOIw4NvUMV0NGJAsbC9PuzhQhYpPUbUIwVX7T520L1gsKSkXTNbKo9aC/cW7/fZ9
 KjLnJxT2fALuCbWj3fxt7FxrkyxHm+NuCqSOvsZXeLH0PFCSLm9F8LjLY3ZAbbIcqemt
 XFxrECYErkcqpnolVmuVyNoaQTBCq3FJIrjRxys/TX/1kCrOpMQJKHZniAEMdv8Yvo2q
 PaNg==
X-Gm-Message-State: AOJu0YzGhSYhKs7xGqJRPjPJ/48SPMNFdzoCufNRWwNF6tA38j9ExDsT
 wn8U4nD9os4PvLbMNb/oeDPiiozaL/0LMy1GZk5mygaqJU60r3mVecscpNKuxW9yHFCJ+1MavUV
 pDnOLoqY=
X-Gm-Gg: AeBDievvoJ2RPaROySnsalMJfG3M7n1/9kOMea0Y1PBORWH6H7glXTxr7MWXXK9BR0K
 aMuU9sv1bW2Wt35KID0PzB4woQ9/xM/zjmi3YvonDVtAi1G/GvLEi3sJHE8SMD+FkqIkI3L8NGz
 M5hcHBga66ejSBaUgsEs0X8nuArJ9FFWTDCsgBH+3jo5LeVhQwROGUF8CRjmD2ZjnZJUUMnj9kV
 J+3dpwq0yo3QDu78g7AX6ff8XMiGjildb7BivNE24FuiLdYsOajOa/aj+QQrnvSqGSFSp0+XAHR
 NH0MB0LyU79I4/vDfinxqFJKf0K/HaWvCD8HpwxCw/2GfoU3rPC5HWacHs7kDfOXkPxjMoL5Cp1
 KxuMaMy0kFjs8axHz70o1DrzKG8At+r62BBSYU97z8pMGshhgDay/kHUxFtA6ymzJOYznrQUAyw
 zO4JSqY/7ieB3huimrMNGQ
X-Received: by 2002:a05:6870:2188:b0:423:69cd:14d1 with SMTP id
 586e51a60fabf-423e1f241d9mr4904496fac.21.1776009814110; 
 Sun, 12 Apr 2026 09:03:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:25 -0600
Subject: [PATCH 02/17] bsd-user: Add FreeBSD file I/O ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-2-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=EbvF/Y9N6ysKAY6EEB2dujgG2t2X2bzpyoB14Ggqvkg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IflOjsC9jKrFLgCbRqdtjNtPYYmGeFwH6n5
 E5clq1qmzSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCHwAKCRBsHNEofbAR
 AKusD/9/Z2Sr/KkYKuDePlkbi8Sej224qEtpmKX4x+FTCWAYF8aDpBW93ZD111A2k1945qwcWNb
 DIzk7uBL9Udn6GkpG2RU1Jkb0652HYQS+nwJZIhx6kx5Qf1WTs+dj7k2BJAptENGHoyOwTjLr1K
 wcke2VT8iXh+b6omrnIpY3dJha/Ep+SToC0PTIN7nNj3LKxTO4EgO+1z7Me6wevMwRbn1/ia1HG
 J5ho0quzemc0quTyg9u4eT94wwwRJc0Va3PYMaPBv9hCfGAayYOTL91YGnQkdiGVq8FuAbRk2wD
 +1jbKqoH977QUN9N+WN1ds9ZIioDNkQog4srFv8+j5VHH5WOGk/PuWYno9ljSqCQHD12uY7Eusw
 DqnW2FECRn4nShVxfeE9CMrC2pPefa1Z5hawCpIZyC/qNAKs6mHp1ZTkPIaOBJkleOKocXpsuT1
 aVCdE/liJys6CwuXe/Nvv4M2tbHVLoIPjdvwYkTI0GemND1irVE+qp7/rADapC5F7PByIEeG/m1
 E+dLFzP5CWUqpifKmL5yqSouLL0H3lGXba5smPmT+jD7EsseGyNGZzPWCDjiUnrp2wHrxhg1jIE
 RJjA2Sf72fyRfAZoUl8B94hQcCT7F6uCE1aVyCsgoo1psGgyo2yXcGvQPh6VxVWeJxtXY5/WCmO
 jyu0gM0lpJslN9Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::34;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x34.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-filio.h with file I/O control ioctl definitions including
FIONREAD, FIONBIO, FIOASYNC, and FIOSETOWN for file descriptor control.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-filio.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-filio.h b/bsd-user/freebsd/os-ioctl-filio.h
new file mode 100644
index 0000000000..79e8f0b83d
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-filio.h
@@ -0,0 +1,34 @@
+/*
+ * FreeBSD filio definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_FILIO_H
+#define BSD_USER_FREEBSD_OS_IOCTL_FILIO_H
+
+/* see sys/filio.h */
+#define TARGET_FIOCLEX      TARGET_IO('f', 1)
+#define TARGET_FIONCLEX     TARGET_IO('f', 2)
+#define TARGET_FIONREAD     TARGET_IOR('f', 127, int)
+#define TARGET_FIONBIO      TARGET_IOW('f', 126, int)
+#define TARGET_FIOASYNC     TARGET_IOW('f', 125, int)
+#define TARGET_FIOSETOWN    TARGET_IOW('f', 124, int)
+#define TARGET_FIOGETOWN    TARGET_IOR('f', 123, int)
+#define TARGET_FIODTYPE     TARGET_IOR('f', 122, int)
+#define TARGET_FIOGETLBA    TARGET_IOR('f', 121, int)
+
+struct target_fiodgname_arg {
+    int32_t     len;
+    abi_ulong   buf;
+};
+
+#define TARGET_FIODGNAME    TARGET_IOW('f', 120,    \
+                struct target_fiodgname_arg)
+#define TARGET_FIONWRITE    TARGET_IOR('f', 119, int)
+#define TARGET_FIONSPACE    TARGET_IOR('f', 118, int)
+#define TARGET_FIOSEEKDATA  TARGET_IOWR('f', 97, off_t)
+#define TARGET_FIOSEEKHOLE  TARGET_IOWR('f', 98, off_t)
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_FILIO_H */

-- 
2.52.0


