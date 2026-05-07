Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F95CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWG-0007lG-1Z; Wed, 06 May 2026 22:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVW-0007T7-Bf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:34 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVT-0000VL-Lw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:34 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so176260a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121024; x=1778725824;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/18BWWz2Wbj63GAgi/PilHsC5xbsmE42NiHRmg2gYNo=;
 b=wE0kottk5XNzUZkYFYdca6/UJK3TkhQrC66Ha0beyHJoUX9kReaBsDrVwgsSnTGP39
 g6rEYc7tT4gQlJXgEyJ6ig9JA5vZEZLK/uJvgWFzE7gTJl1LGe9QcccSntXS5DzYK1tL
 OwVIob5xkirhOGNwGrvZ2/ObzLbwmdCSwHnboxtJENI3EAzLPhcbK/3qaNMQ/E2Gdp53
 qTD7WaoHQjMIljbYNuXbdB2LgltSbXpDRi02tJcYdCF6f140V0JJbCPICckYnyDU4tRw
 dkqqNZfBuMsSmLp8Z/fXAVf3uEwP8tRGhj5OoVJvJUZE2PvhEbsAw5zUjD85ZmeTh4wz
 bTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121024; x=1778725824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/18BWWz2Wbj63GAgi/PilHsC5xbsmE42NiHRmg2gYNo=;
 b=WcIgoy3UxH1/CJnp0GEVmBnaH6jd7MREe4D/ZY2OkwRS1jJgfUDJgwiQiyC1pmaFrF
 Aq2jHQENsGYlpAZPEIumEc05WRiAcQiD4ZNXTIJo+1zgzONiYRDRPv4vXAwSvaP0mPbf
 iXYHWmm//i6/VneG6zxZSoI43i1Xm3ukDVBp5+dkkc9/MuRw29kX/NlIM2jxdJPNhJaR
 ahPgm18wgvUiAt4bJ05xqCywgIGDgdvUsfONgP+k0p0OzouTQ0HKhQEu9gl47ep1k9to
 gi1s3USHQsCGL3rK7BRTXNsYgNLW4ovL44YbhBAT0ijzfMYFZgltJxhtqW2tNhMXhqaN
 qbYg==
X-Gm-Message-State: AOJu0YzIfyGP1Ba4ZTxDLpnw4ZrNky1sbfuFyJn4KbtIeGw/GPptA3zk
 OaFmtO20mX9EDi/2iPe5zp+a3/PhH2Mee62RFpVD+gxk/G4ssCi1Tty4RFyciQoU9GvUKiY6ZnT
 8qQhELEc=
X-Gm-Gg: AeBDietblThljGfxV3XJpSA9MYE3Owt6oCtEIW9x32End9i/qvsOt46LPIem88Pkoat
 mtCv389l2CNAR6YHHwEnmO+NCv0yq+OIT5sp8AgSIPKdvVD+Mp9WKCKWxM6uq5PwReYxn0z7fIx
 Ojvf/rRDYGdL+vFsf2nfDYrzPCu/cnKTtRORL6JGVF3xZHLKSQIoTWmjJhvwDD1IqxbuKgFYxmD
 7UWaKj/mC4y55e/dv75C3Kf3aEFHVn6MbDcxQzzUWJsNQbqMcdC2fxiMQyphxL6qO83COwbIxAv
 dzrC7O5ZEYVJd9aJPjTsD45ikL5ksg5tBgLzAcoNDeHdQTfRNMSaVhVO8i0DQ4MXF2cqGxOIEIR
 1/oKPoTQZEsA0ywEh7fPhx5RVc8n2aetYpgWreJ4QPCbQU7ZjFV1DvQ0LkKYOZxv8CmQl9+MVrR
 VxXDEE1y4yYr5RcSt4Di38
X-Received: by 2002:a05:6830:921:b0:7d8:b269:e99b with SMTP id
 46e09a7af769-7e1defd48f0mr3145649a34.17.1778121023942; 
 Wed, 06 May 2026 19:30:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/25] bsd-user: Create os-syscall.h
Date: Wed,  6 May 2026 20:28:06 -0600
Message-ID: <20260507022827.44499-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

Create os-syscall.h. The purpose of this file is to define anything
that's different among the BSDs, like system call numbers and
time_t. While there's a lot more different between the BSDs, this is at
least a start at capturing it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 bsd-user/freebsd/os-syscall.h

diff --git a/bsd-user/freebsd/os-syscall.h b/bsd-user/freebsd/os-syscall.h
new file mode 100644
index 0000000000..962adfa91a
--- /dev/null
+++ b/bsd-user/freebsd/os-syscall.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2023 Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * OS-Specific portion of syscall_defs.h
+ */
+
+#include "syscall_nr.h"
+
+/*
+ * FreeBSD uses a 64bits time_t except on i386 so we have to add a special case
+ * here.
+ */
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+typedef int32_t target_time_t;
+#else
+typedef int64_t target_time_t;
+#endif
+
+typedef abi_long target_suseconds_t;
-- 
2.52.0


