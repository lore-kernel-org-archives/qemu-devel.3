Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4374CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoVz-0007ac-M1; Wed, 06 May 2026 22:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVc-0007U2-3w
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:42 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVa-0000Ya-OD
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:39 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dea1272943so232403a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121037; x=1778725837;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjLAaxyHsT0TSUBZY3ZQm0quejVhCnFXvIzmgKnvhDc=;
 b=iXl7gwjp6wbd/ou9MtU3uV7RYh9gDfu7Ke7UeugRx3TW/XahsPDyC0JlHGpsfhkBJb
 hX0JRv3XWkZnxkQpWYFvvuQh4Hn6PzQUWh0NPKm4G1dG0RgcS1odgnkz9tdkBPWOW0S/
 WbJoYkF6rvBJf5kBHu5fywSBkPG67j1mXBGLiwbAN/IC0HK9wiMVSFBvEgsdOv9VMAGg
 BuaMuTwTA7ukmAaVkSaeUgG2wECNr+yERrXhlIy4Lbo46dvmQWVEa9OfhfEmYr5+R19U
 RY+TqnTu0aVPtWA+Dtk+dBNM5pqRivf6HE7pR2hrb4Ri9rMS+nYps4uAr1ZoXly4Aj/D
 AH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121037; x=1778725837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjLAaxyHsT0TSUBZY3ZQm0quejVhCnFXvIzmgKnvhDc=;
 b=TZdRv2lyb01qLj/wtdB85npTQhFSVsOwKQMzqW/Jxz3IGqXcids8Rrzg6wYS/0IN+1
 qCGbZM5R8VRKbaMpPwy0qLHkYRbH5S4Q9x7TDEMDCZLcLLxdYNWSNI8cDkRoIvcgxSlx
 4yNYDtI72j950GTXtKFcjW8j/USbO8YRwT1APNbQVcO03xcZMiLA+nMntoz6eo7LVBVN
 T34vRwAAtrcDBHz4swm4BWWavNzlbE4cGow6v43BtxHkSR/d3tuyhGkw6FgEzz1qsZQD
 EfEV/NJkGaYuOEJCmOkRoQtzu/PF+mFdsiOATLdim6UOduS+h1Jzhb1zuGR8Utnl8k8u
 o79g==
X-Gm-Message-State: AOJu0YwwwaP4OWExDY6+QCMskb4C86ahUKqwA+JDxHSsNsxk5V/UGqPQ
 zQ9GLJl8DqMr12EEOc4+PTP3YN3w/VzDVsIsqchl+2RJnzkc0VVuTN9M/PYWVwtfCQ5M7bq/Fjp
 ZPCRYkvU=
X-Gm-Gg: AeBDieu558F/cigwAQAcxwp7eXKVFtcIm4ttKe1odOaCLI+r/bRN8PAMnbpZyq3L4aO
 tc4u9ScZLStIKk2TTeflbobc9Y9B7vf+gFaae7BpdKKPvFHneNcuOL2tMFj1NOISL+exBS9HqKQ
 VSlpCQVQ4+UlRQLRlng/IJ47dEHucKb6uPhUt6ZbEwhIGAaNXgdarrrlO6JSQHs7ELMpBbTEdvB
 mTQyII91IMpapjl/gNmJsXn5WVxYt4pLcz+6y1r3Bb+tN6jNltOwtFAYTHAW8qZC62enU+OfRG2
 5i2znQRArAerlcV/RvYlPD1r5X8+thwblhCWZeRJuQ4CEsVp+RprdO/HLgv6WPS8LegzMEmAGLR
 ypch4QFlYdthaX9tUH21XbvBdH7JtDZG7TFDH+IFDbD/E2HSYkQlFS/FtDmwt10bIi2WTar/M8d
 QP3ok5QNFYODF3hf4Je4YA
X-Received: by 2002:a05:6830:488e:b0:7dc:e336:c828 with SMTP id
 46e09a7af769-7e1deea5b89mr3935049a34.10.1778121037432; 
 Wed, 06 May 2026 19:30:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 16/25] bsd-user: Add bsd-ioctl.h header
Date: Wed,  6 May 2026 20:28:18 -0600
Message-ID: <20260507022827.44499-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

Add bsd-ioctl.h header declaring the public ioctl emulation API:
do_bsd_ioctl() for processing ioctl system calls and init_bsd_ioctl()
for initialization.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 bsd-user/bsd-ioctl.h

diff --git a/bsd-user/bsd-ioctl.h b/bsd-user/bsd-ioctl.h
new file mode 100644
index 0000000000..bf9bb72bc9
--- /dev/null
+++ b/bsd-user/bsd-ioctl.h
@@ -0,0 +1,14 @@
+/*
+ * ioctl system call definitions
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_IOCTL_H
+#define BSD_IOCTL_H
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg);
+void init_bsd_ioctl(void);
+
+#endif /* BSD_IOCTL_H */
-- 
2.52.0


