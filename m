Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C78FCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPKg-0002cQ-U8; Thu, 15 Oct 2026 13:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHPKf-0002bd-28
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:33:33 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHPKd-0006Y2-Fp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:33:32 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b1cc392d8bso3154185a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792085610; x=1792690410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hG99PJPfomwuZjWMrKfUamyhpaYgesW+WY1q81KGOn0=;
 b=W/l0adKEe7YWqMQo6afaB3VjZxvP9kne4lGyFY+rMzHYzFfMoZapIr3mZkTOt7E6K6
 7jJzMwlc22LOZ0V1Zu7pUn0rTYRVlSyfPyu6WQONOcdJdRXT1KcP12zhDXmfSQqIEgDr
 Hio1GRRZM/P/ZMKI9YxiidGpE3etx7MbXhylkbFsAZ3tIgiwfmzjPjRymZgCWQzjoVg9
 CgVoOxC4KhBWo0QNexOARlnwGf0pCH86pIYmQyqXkMbeHNdQ0c4lNxcoeMc16Q6veXCZ
 lDhXdDNjtEXvzEbpiDYJAE8bSllF15bLzETAL5W23zqxBCN/Og7k8sygEs+yyUvv+vul
 vYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792085610; x=1792690410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hG99PJPfomwuZjWMrKfUamyhpaYgesW+WY1q81KGOn0=;
 b=CwJsq4UOZx38r6uZUCUjr37+DDO/wqsVProM/bE1YkbVRzuKHJA8RmMdVpuTXTES1h
 gHZouJn7ZQnaktrYcGTUDz8+RihvjrTL2Wn4//93aFNtaOkf4qJ++FVljrrFs5r3NTBF
 nla+jou25uF1ppPq7GvQtV/VGey9bQR2R1FQlo9yP1rLpe2EMglsPU769H/SBHmKT78b
 Q/8sTKOvZmB8ipis+Sl+5TrNSObEMH78vcExkQYlKk1VdAIkRl8URDGrsrAdyc97MFXX
 mR/FS7QMVNB8mUF12OGks03AB3GRpboCN94dflHHNhDfbVdiM32+jOpLji3YhoCt621v
 wQKA==
X-Gm-Message-State: AFq9FYL2f4OZIaQhGzjeryg6StIAn87b2058xPc8KTiZgcYou+3X4XYH
 vCE1OOs3bxfUOOa/YS7vKK1KqZpJZbweTqeAYs3bI1xOzF264GBXBIMHuliPmS1SHog=
X-Gm-Gg: AYBFou3/DIY7zaTOiZpXRdAYVQL0DMplXkce4W+gYF+PYpskyBRX8sF+edPA0i0HZNx
 lqS5es3SA1XTZBMJq/SAEHRPhop5C2/wTxlnFwclVCVWdthzHTcioH8FcIiQwWFwTwHJV3ELEuC
 a+mbmw/VMjDwRMj0YqEKhmmP4GAWNh+uN5iHD5Ofm8lcpkiN9r7pPCzHAZv1SnDKVyHa2wZCaXU
 vFKebtlGyoWoIEmV0oUXw70xLE5aIYSaz/Z+Ms1S5hJFKX5LYSxWx5RafNJw0pD2CmlXlLR703H
 IohFn5IlGiTivbqZFD++onZEvjXYrGGBzdIzBE7LrmCqNQggwYxP2XrtNBjDZtwFcdJ/kXSe5LZ
 BWbTu12+weSadnQtKbNUBddkx80SnXHZl0Fx2+LMvO/W/LegmIcU9uBS65ZaZuWIrgHSU7/HqBM
 jz26rYijnTiNVwuwIEkxVlAtSA70ajkE0GHp/BlPl3ymZL+TvmicDK3l83Xiq7S/jw+Lq+qNGJr
 /6o9a/4ZLMBWSZsKs5xaxmzRyIz4fR1vJh//TJhMa74KTpS0EoscvN9B6Hgyqj8SO9PSTI9O1cP
 zX/028HK6qI=
X-Received: by 2002:a05:6402:c50d:10b0:6b1:a509:875 with SMTP id
 4fb4d7f45d1cf-6b1a50909f5mr8583081a12.20.1792085609460; 
 Thu, 15 Oct 2026 10:33:29 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b20388cfe6sm2791433a12.28.2026.10.15.10.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:33:29 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, michael.roth@amd.com,
 kkostiuk@redhat.com, Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH 1/2] qga: fix build on illumos
Date: Thu, 15 Oct 2026 19:32:49 +0200
Message-ID: <20261015173250.65942-2-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015173250.65942-1-bogorodskiy@gmail.com>
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, build fails on illumos with:

../qga/commands-posix.c: In function 'qmp_guest_get_load':
../qga/commands-posix.c:1408:9: error: implicit declaration of function 'getloadavg' [-Wimplicit-function-declaration]
 1408 |     if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
      |         ^~~~~~~~~~
../qga/commands-posix.c:1408:9: warning: nested extern declaration of 'getloadavg' [-Wnested-externs]

This happens because including <sys/loadavg.h> which is needed
for getloadavg() on illumos is nested under the "#ifdef HAVE_GETIFADDRS"
block, and is not included when HAVE_GETIFADDRS is not defined.

As getloadavg() does not depend on HAVE_GETIFADDRS, include
<sys/loadavg.h> outside of the "#ifdef HAVE_GETIFADDRS".

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-posix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837e285b6d..f58169b43e 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -16,6 +16,9 @@
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
+#if defined(CONFIG_SOLARIS) && defined(CONFIG_GETLOADAVG)
+#include <sys/loadavg.h>
+#endif
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
@@ -43,9 +46,6 @@
 #include <net/ethernet.h>
 #endif
 #ifdef CONFIG_SOLARIS
-#ifdef CONFIG_GETLOADAVG
-#include <sys/loadavg.h>
-#endif
 #include <sys/sockio.h>
 #endif
 #endif
-- 
2.55.0


