Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5191EC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsSR-0003GL-UK; Tue, 25 Feb 2025 05:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tmsSE-0003AV-8l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:46:28 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tmsS4-0004ji-GF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:46:20 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-221206dbd7eso111553175ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 02:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1740480351; x=1741085151;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9jT300ohWiqRs4Jh9/ODHS6wUTziLMVsUZ4EAjvq2xQ=;
 b=LT0fxZg2kVVgxPC3yQkJ4tbE/PGCAPq3jVX8dRob3GycZ9UnUvPtgvlMpvySBwkAYs
 /KeJvM1S8jKVowccJuKCYmR6YIhHHsWQuSe67uV+ZXoPt207q1f4ceupdnWUhnVo8I9C
 lr1D52VBpSH0IPaw3Q75gOm6ZbKzDP+BL8EBUpew32z/tv16TuFDwKnAqvyYjfjbvuXo
 swUuC9FwL549EQhOL7a41fKqmEn2BKLVP1jzGYxLW4Ir5C6v2Kv1DAfbfmcgRyAgFgBQ
 k+PMHM+ksijbuVuOxytujHHDm0GeP4pL501cjcIVIkIpLnIsfoWcSyzO2G2cBzBX6cF2
 omAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740480351; x=1741085151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9jT300ohWiqRs4Jh9/ODHS6wUTziLMVsUZ4EAjvq2xQ=;
 b=BuK0gOFuHA/aPgZk+ENK0vwxre8mZAIx6dhqRtMu5B+pP36LcD56JNn4P0TwjZwtsH
 NBvADqgigJQ4+ujUIcBsrebvtPTLbNcns1WQMVahXdXqPs0txKERbXaiWc4img0TJiZ3
 NX52rooXlRjMFOAHxTN9fuo2ibqHr5tO6KLqmP2faiq43Z3ojaT1A1C+FvLpBdCVKzAA
 TqLa6Ct2E8oWnIHuZH7cooRAx0Y95mFZ3Eur+HQFdEVE9+ntK9kEP407QXXR36f4W2Bv
 hAk9cLXMPKFm2g45/xaU92q19NKoOZ+azQgVpIK8TpzWam1od2twKMCpQJ2ynrNT0ISb
 sneg==
X-Gm-Message-State: AOJu0YxE7dV9PpR0pNVBv+lH3rsMTZj9pdglhKEGv78VnFvR3cI/c7kV
 F62I8R8UQOuCiRWlFPxreHTy3x7o3fXvc3vqvgczFemqUFio45jzppGRIcPfGhxh5klHBMvrn2H
 uaLBP2g==
X-Gm-Gg: ASbGncv23x0i0CZ4GcvHLntHvV6Upu8bMmdGkmHpVBvwuMYpg8qrMCwFOnpa/qp4xXZ
 G0lCHSLow5ZSL/gX6cQvxi2b3pWY2+EG5roU5XeeVLAxlx+Xqa3iy64LZ7pX0mUERbCAKQvM8xV
 kQ8tuZ6pE2s/uHhu5GhvvWBM8LDhvUTtR3S8CowOvjcnzFdEo9+LMRn9swNtxMWHRmCUVsfS2uj
 rVm7mLV6AQdayXWkFQk7QMEYF1QgnjlxYYbDm9CCW27ntzPC0xcTSNjNfYg+ebFOB1BsEOt+4M1
 HSA0TrBqIB5ETlKS/ILRz7kgjHBskAHFqT1XhKM=
X-Google-Smtp-Source: AGHT+IF8bkrLKs6qKTnwoPc5K/9CqqKUTeWxiDbHCiW41Td/0X4LMw5sW7OQ4Hv8w/N6R6Fd5m7y3w==
X-Received: by 2002:a17:903:2f48:b0:220:e392:c73 with SMTP id
 d9443c01a7336-2219ff51610mr307162395ad.22.1740480350328; 
 Tue, 25 Feb 2025 02:45:50 -0800 (PST)
Received: from 9950x.taila029d.ts.net ([1.202.18.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0ad990sm11197875ad.215.2025.02.25.02.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 02:45:50 -0800 (PST)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, yuhua@smartx.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] chardev: use remoteAddr if the chardev is client
Date: Tue, 25 Feb 2025 18:45:26 +0800
Message-ID: <20250225104526.2924175-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If the chardev is client, the socket file path in localAddr may be NULL.
This is because the socket path comes from getsockname(), according
to man page, getsockname() returns the current address bound by the
socket sockfd. If the chardev is client, it's socket is unbound sockfd.

Therefore, when computing the client chardev socket file path, using
remoteAddr is more appropriate.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 chardev/char-socket.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 91496ceda9..2f842f9f88 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -571,9 +571,13 @@ static char *qemu_chr_compute_filename(SocketChardev *s)
 
     switch (ss->ss_family) {
     case AF_UNIX:
-        return g_strdup_printf("unix:%s%s",
-                               ((struct sockaddr_un *)(ss))->sun_path,
-                               s->is_listen ? ",server=on" : "");
+        if (s->is_listen) {
+            return g_strdup_printf("unix:%s,server=on",
+                                   ((struct sockaddr_un *)(ss))->sun_path);
+        } else {
+            return g_strdup_printf("unix:%s",
+                                   ((struct sockaddr_un *)(ps))->sun_path);
+        }
     case AF_INET6:
         left  = "[";
         right = "]";
-- 
2.48.1


