Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA2606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QY7Qa2bF;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T7KI3uY8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3bh-0004C5-Ib; Thu, 19 Nov 2026 09:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU3W7-0007zW-Du
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU3Vt-0001Ku-0I
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795099998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h8XeLTehm/K55teUc4g8IAfHo2NMdQKlyg3q2YLJK88=;
 b=QY7Qa2bFAfBDq8KFPl5txcIQy8I9XaWU+qxNfzY/fVYnRpqRAxcYDEtyXl6HkQbIc06tlF
 3Sh+zvdV3zS+Uclv7I1UROgK30FUS2Lgql5ODjaFETcmRPfhJ1zPtDelgrtCxBl1b76s1f
 ciaFagxT19jD1NG8B4Ug0sFNmsoFxYI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-6uXBU4j4O1aMP3DIympjlA-1; Thu, 19 Nov 2026 14:53:16 +0000
X-MC-Unique: 6uXBU4j4O1aMP3DIympjlA-1
X-Mimecast-MFC-AGG-ID: 6uXBU4j4O1aMP3DIympjlA_1795099995
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5c156f01aabso1418731e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795099995; x=1795704795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h8XeLTehm/K55teUc4g8IAfHo2NMdQKlyg3q2YLJK88=;
 b=T7KI3uY8+//mcog9R2l9zmPmq8bsqmwx+FriILyo7UXNPxv6B59zLAl5Anp4iU9qin
 DM4tXlmdVNaj6TNwTlofkmV/YsyKNNdDmStkDre29Tey7GzucBFYIKL8BJWKkZed2bZu
 VmAGknaySLnvT8LOV23LZsI1jlsbLAk2kTchhuueG5iopOhg3kYW6jOw0y97XJTLxS/u
 HPzBcPyvstDP/XQMnizEXXWCJ1RSvuXm9YsuCGHTfvdN7pr1pkgsFlyYQ2YyknJYrqlr
 uwYFOWJzwClZzyyq7qltfb0s62uOmPJAFlHJs+aESpJ79p5fwoRybBuunTXX9l7AgMzf
 P8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795099995; x=1795704795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h8XeLTehm/K55teUc4g8IAfHo2NMdQKlyg3q2YLJK88=;
 b=rj8uOaNEKYwB34//tf84Uf53htUmG98LrzAxDTungre3iRBuHJX5LyK+skZ1d3t0qu
 CqUkEJN/aBPCd6wSekXzAglfPlgWCyGl2c9qSbG5eJxzUiPg3Z0fV2vzQ+AIE5NwLOnf
 F3KrbB3oJfDHod5dDEsZ9vyaMSR3BkhH5eUG5gLiShVSHfXxhUnYawMNXPo/qqPIJoDY
 2wwb3a1QW+hmcnX7wJM/9Oivqw3ToTqZFhj039UiwpBrfEKbpllycQ9IaAblu/Rlamwl
 3Z0qeIeLFr366rm+a+oSXnKTNSqVTmZfSmavCyzy5JfVvH7ZfbnU2N8Rj78Jv9J2PlHZ
 JDZw==
X-Gm-Message-State: APuU4Z/iRuXwBGN8v/XR0Tt/xt7rA9O4zVM/3DlerF2n+w2BA3JWaxld
 yuUIRY+6l0WzMBLW5B9frP6pgmow6TDNmQyGiInAgh9bfDQlU+i6Eo1XOEKY3SCHrhkFUr3876S
 GjgB6RpUzWxFTZVLtvabiCHt4yNmBDDeL6ZyBk1D7nQ+7tGGUHr8oLC2NT71x15m+t/MqZnFEIJ
 fVnhCPGmXor/VAz5NL6o7VVmMWTPPBBKH4BXM5hQ==
X-Gm-Gg: AYBFou03ntLYUD0nfBs4f2tkVwhqyOCvMb6XAaLEaj2yqDxQV9SM0WCXHrwLKn8O0gz
 KdUdbISKOLQ4ZKrgAuGiaiQpMMHKUeZdrLs8VlkntViLAXIT+40aQVVnTMLLZtUzwIaphrMTNKy
 kivcufSX902G049yBtumTy9iYbuXUFXIBRMfETK1sknYHeuyZGroT+mnkiaXorBBVwdZY2a5fO+
 Wc2ZNLkjKTDr953ntBplCsc6FJy1sb0oNq1CcRu6mNcA/uyx8YhBTxqSc2PkdtVkZTECBhPf5eD
 d0leXv/5Wu7EvFubNqoW9OVuzVMzgc8dHAnciDIHS+zy8KYoHeLnMKB5YdE/m34RpwIZ5gLUWBh
 D3Tc7boi1Gi+0BFpfhg0klMvG+4E4RccUU+hPrG+qc08Q
X-Received: by 2002:a05:6512:6891:10b0:5c1:b107:2bb with SMTP id
 2adb3069b0e04-5c1b107097dmr753509e87.29.1795099994932; 
 Thu, 19 Nov 2026 06:53:14 -0800 (PST)
X-Received: by 2002:a05:6512:6891:10b0:5c1:b107:2bb with SMTP id
 2adb3069b0e04-5c1b107097dmr753490e87.29.1795099994285; 
 Thu, 19 Nov 2026 06:53:14 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1aa2d9b98sm1591405e87.1.2026.11.19.06.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:53:13 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Hongyan Xu <getshell@seu.edu.cn>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: [PATCH for-12.0] coroutine: Make yield_until_fd_readable() detach fd
 handler always
Date: Thu, 19 Nov 2026 09:53:11 -0500
Message-ID: <20261119145311.1144878-1-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hongyan reported a possible use-after-free of RDMA migration code:

https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn

The issue seems real, while this patch is a proposal to fix it in a simpler
way, meanwhile it should be a problem to the yield_until_fd_readable()
helper in general, so it should make more sense to be fixed there too.

The problem is about the use of the stack allocated FDYieldUntilData where
we must make sure after yield_until_fd_readable() returns it's not used
anywhere.  If the coroutine yielded can be entered from outside of this
helper (fd_coroutine_enter()), then the aio handler might be installed even
after yield_until_fd_readable() returns, and that makes the stack variable
accessible by aio codd, even if stack gone.

Fix it by moving the aio handler removal outside the handler.

Reported-by: Hongyan Xu <getshell@seu.edu.cn>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

NOTE: I targeted this for 12.0 because the bug was not introduced in 11.2,
however this seems to be a real bug fix to coroutine in general, I'll leave
that to maintainers to decide if to pick it for 11.2.
---
 util/qemu-coroutine-io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 364f4d5abf..3c0a7feafa 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -74,7 +74,6 @@ typedef struct {
 static void fd_coroutine_enter(void *opaque)
 {
     FDYieldUntilData *data = opaque;
-    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
     qemu_coroutine_enter(data->co);
 }
 
@@ -89,4 +88,9 @@ void coroutine_fn yield_until_fd_readable(int fd)
     aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
                        &data);
     qemu_coroutine_yield();
+    /*
+     * Always remove the fd handler, no matter the re-entering of this
+     * coroutine was caused by fd_coroutine_enter() or something else.
+     */
+    aio_set_fd_handler(data.ctx, fd, NULL, NULL, NULL, NULL, NULL);
 }
-- 
2.56.0


