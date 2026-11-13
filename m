Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F6606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bgVCePZm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnZJ-0001du-Qg; Fri, 13 Nov 2026 04:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnZ3-0001BW-Q7
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnZ2-000630-3X
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:21 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ea7190aea1so2924835ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562039; x=1795166839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=shgDA64rZZreNHgXJfZjEEX5dFaImNGkxX/JsRBR3Cg=;
 b=bgVCePZme/oc+ATjhBQAMEnkZkHh5yanRxzvGJNDv4douvn30FNek91o7avDNEDNaW
 xF2MwvUqhOIyeeIleNFsbKNG/F93qW0JtgNn91QYOTqxlId+d71ZlviscSm+2Jx1rz0h
 h2ZqBrRYJvhSClzkbv4indke58yUkIMIYLdkukG58NfBS9KzN3a3pMVJBqsCvHGCwR3b
 5LANCdyTcJlUE2pJ4QubJK2kzvWPhXBYMOdOblBwfT9vdkA2Bi801Z2jDnIXcUA/Fmlv
 dRWEQd+IRR95Cjn2zMULIbrY3Zg2D7NUaq83v3MkRj4HZBI3E/T+j1YJWdGAWX6z5+bZ
 EFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562039; x=1795166839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=shgDA64rZZreNHgXJfZjEEX5dFaImNGkxX/JsRBR3Cg=;
 b=q/aZNxAFHcZZkjCWa6wAqrpDr6s8ltQ9h4aJJOeiBuj/FEECKgcV7InHpXotXcClMF
 67Hz7AlanQYLVvBnqL5ZG5weMlbZmVEOC/a68DC23alp7oL4pcqtJ7AfvggreRaRIsLE
 2bbu3P8yvD25E99B3KkDE5Qc6+BQIKZfT3W8xl3YO940zfeCn50mSZmP0k02ecYwpToZ
 E2q+gOPQvfmtBDH/idJAoYpStD/W6ejAGe0DM9h9QFyb+6Z5Ep0RuJkDUZwCxJmxIIYg
 /VC84Z4c4WG0b23/PDUg+OcvwyRJzwSa8faKk6gZ0t/FGzrl/I7Z1ezQl21ytUGWayGM
 f+BQ==
X-Gm-Message-State: APuU4Z8ZhdOPRb4afkDlS3K4jlUUYNYHs2kYiuX+SHtGgTjeilr+727q
 RpLQ/XTYreh8IA+uOHHjzrcIbCIJTwuCE9De/9d99sOe8slFvVjMs2Ljoos1nPMm
X-Gm-Gg: AYBFou3oRa4q5ZmY02l6YsLfyiw6QAqdsjb1+MAbqWsoPchz7Se+F0SBE03ckRXxzOd
 6QRMRZb7Ep2e6qx8kld5vB24qf5ZXnEiG/KDyoHJ+PV+H52qNzK8E96RjtfRLGNc/pB3Gjo1z0M
 J6YI41l41F9s9riMF7QYe6+M1ugx22KisLZjD6fi98Laya2/H36EbR0ruXnSGu5M8AIwQOChPDf
 iYgmfqAARvdCaoZCLNZCfZEb5ZyefAuifsoaR8o8eWw6CoWbPFhCyqTgyfHpcmPiYPzn8ecVGxG
 O0g0G+4+85FGV41akb2qRi+uyf0EH9Ao0E4s1qxmI8WKMl1yqyEwcw6AJgui4KlYYm7a9oM0i43
 03uRPuKvFPAGEpRjgnnC5tK0V9u/THg6wUPu/iMIB+sjR2rIeTjOH7YZ7ocSWqHUPw0PZ0jUJMD
 wQEbM9D2TshgPbcY5b/zG8IBqhorMaHaXdU8LF7DcvniOsbp0vNHSSWhtw6hsCqF0vX8RnjXMMa
 JKvCqzRqq52veAgdzw5ffxdvuSZILrp2YfYqXz6UqM41TnRZB0GDFZAKX2WoNYRvjyIGrflqSLB
 kwdb3AZXGgmCkyvsSJcjNHDgkhpqH7W2zNMgullLfDHaZVhn9bWzN3AyVzA=
X-Received: by 2002:a17:903:8c4:b0:2e9:7ff5:544c with SMTP id
 d9443c01a7336-2ee0da7fe45mr18475855ad.25.1794562038761; 
 Fri, 13 Nov 2026 01:27:18 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:27:18 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 14/14] docs/devel: document holder-aware IOThread
 AioContext APIs
Date: Fri, 13 Nov 2026 17:26:05 +0800
Message-ID: <20261113092605.942292-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the obsolete iothread_get_aio_context() reference with the
holder-aware API. Document matching get/put calls and their BQL
requirements, and clarify that the unsafe accessor is for legacy
callers only.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/multiple-iothreads.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/docs/devel/multiple-iothreads.rst b/docs/devel/multiple-iothreads.rst
index a6eb046267..3bd8144ecc 100644
--- a/docs/devel/multiple-iothreads.rst
+++ b/docs/devel/multiple-iothreads.rst
@@ -88,11 +88,20 @@ argument, which is used to check for and prevent re-entrancy problems. For
 BHs associated with devices, the reentrancy-guard is contained in the
 corresponding ``DeviceState`` and named ``mem_reentrancy_guard``.
 
-The ``AioContext`` can be obtained from the ``IOThread`` using
-``iothread_get_aio_context()`` or for the main loop using
-``qemu_get_aio_context()``. Code that takes an ``AioContext`` argument
-works both in ``IOThread``\ s or the main loop, depending on which ``AioContext``
-instance the caller passes in.
+The ``AioContext`` can be obtained from an ``IOThread`` using
+``iothread_ref_and_get_aio_context(iothread, holder)``, or from the main loop
+using ``qemu_get_aio_context()``. Code accepting an ``AioContext`` works with
+either event loop.
+
+The ``iothread_ref_and_get_aio_context()`` registers a holder and takes
+an IOThread reference. After the caller has finished using the context,
+release the reference with ``iothread_unref_and_put_aio_context()``, passing
+the same IOThread and an equivalent holder. Both calls require the BQL.
+No matching IOThread put is needed for the main loop's context.
+
+``iothread_unsafe_get_aio_context()`` neither registers a holder nor takes a
+reference. It is for legacy callers that ensure the IOThread's lifetime
+themselves; new code must use the holder-aware API.
 
 How to synchronize with an ``IOThread``
 ---------------------------------------
-- 
2.53.0


