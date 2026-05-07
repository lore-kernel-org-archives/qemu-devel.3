Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89460CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPp-0006Wu-MN; Wed, 06 May 2026 22:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPo-0006Vw-E7
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:40 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPm-0007gQ-RW
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:40 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso181415fac.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120677; x=1778725477;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjLAaxyHsT0TSUBZY3ZQm0quejVhCnFXvIzmgKnvhDc=;
 b=iFFS58y+nuSSZdd4IV/t/ccExwtSS+yGO+b73ERUPuhO9pMKaFMo1KBPsCyl+pIgdX
 TQ4ZbXjYtXhTq1nV9D0MFgN8JRHP3eGmj0JuO09jo+1azjNb3pHJzRKXkhHOp1xB0Mjn
 cVh3m1/9sGcGkg9a2zMuxqyav2XjKG5JGgG1U/hmn/Ne46cpEyrl60aQl9UN97YPiep8
 7++Q6n9q0lxCF22RuQl+2q6ETLKrcOHI4yeJAFx4OXFrGlsKTrHOnldm/B+O0gPp22vX
 h81IchMvhvyOtGql6geRwv66KsFU+JxDQ7Z9HqjaNYG7dbpoLqv49VOgU3mjgYY4MQN8
 6YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120677; x=1778725477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjLAaxyHsT0TSUBZY3ZQm0quejVhCnFXvIzmgKnvhDc=;
 b=BuV08pio9TbCOB3+rDsbrNHJ9h4FhVEZk+P/w+GcgZXW3e7m5+Ucvww7Y3npXV69OZ
 JKjkslIgpBKg16bgh0ekZwEq0jE9cn80vHrmBpS5dwYtBjfedCD37UcS3EYdPHDrp9IP
 N2y5BXzZtzmk3u3u3VAaBVITHhwGETH9svi+YCLhjXxHxfdFa37hZcxdg4We5j8gdtNG
 wpsaf049+o47J03Y7FHs4PQtEGie7V3iceE+YlISzPSeb12z+oX9nJagjMai8gCEUnlK
 urA1Oi9KxzXl0uNAULcN8zZAiYbwvwLIOud9SJsrjcweXlfgPmTqqNjdspXKeDafyMQA
 w3Tg==
X-Gm-Message-State: AOJu0YzVvtu83QnOyVDbgUMnv5ZhPRIFniwfxJmFN655kkZr7qVuOO3N
 GWenNGeNkCFP0n5fFKcngzhqhioMXJIB1XN60VgG/Gz4hCJRGSRfHqNsyddflDxtmYDDeZDmH33
 LDjAhF7A=
X-Gm-Gg: AeBDietcmgYFSGjqtVoMusT4GZL/gGnmlZMklXV7g7ASkPFYOc80LQuLJAKLJJHmMYo
 1zkXDwTgsePJknEWEoqigGVNSTekZpLIn2NKvUQH89JNU3EsN5C/8XfITY9HGZw7SzLCDNq3ml4
 xpL4ucPDpJjyYvTRdxwYLAO1Qty/zdx1F90pIuDoo0u8kw7sXqgnJ6hqNqJ+i6os/nHX530quOf
 N5OcpwY3UADOlZhy4R5SgHCTGeaWZFLQlmQMPR4RMovfseMJ4gti7PWt0lr/UMcs4QHQRfHxQqu
 k0uq/nm6T0YK4rf1o71Qeyb++OrRX2GN0WGe4KdyexJb1pRIOq9mgO3w2w24QREAzAlyPmM78qi
 yhy4i2NGogNLYubZhfxP8vy+/7qvlh0S/gGCxG5u4tnXEDfUuNYPFhEk706s7SNLgyO54ljaArh
 aJEM8GDaqxsfjtOl9YzWXx8K/UfwQ+RWZHFkXOShPoPw==
X-Received: by 2002:a05:6820:160b:b0:694:9a8a:2ce with SMTP id
 006d021491bc7-69998c8fed0mr3228427eaf.8.1778120677083; 
 Wed, 06 May 2026 19:24:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 16/25] bsd-user: Add bsd-ioctl.h header
Date: Wed,  6 May 2026 20:22:10 -0600
Message-ID: <20260507022219.44171-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
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


