Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82856CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHH-0001pd-WB; Mon, 11 May 2026 10:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGJ-0000u2-Nk
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGG-0007JY-2v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso27637395ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508329; x=1779113129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bylwVIvheE4A13Mb11/ZHCJxDZDhKuXhRjY1sr2Fkk=;
 b=BdxOT7aqDbbuRH4v+Ckp/1qfIYExY/BqTAWoniPtEK5pBgPa1Wbbyo4G9q+bxMpqd8
 gaoDpTjRqCGNyKsdYqCrVPqkVp4Ch8ozSkLmgDIBSvEMlfc30fyvHNZBJvnMTtXKieXW
 DrpGK+brhNHOfk8gvyFDgglLCH9FhHJCR1du8xr4WIg6JSUXTBAIlItDV86S9gteY8te
 GTdl/lXUDO+nhrSeix5OLVsUMgEtxK8LSV0QYkZBRjUI3FpFFfRGv/UUC4a0LNRXV9yI
 +kzX8siwPRZzYskCp24MEVhMyqLYnG3XuQF1E2MhWLHRAtW/DMgoqijtOEk9y0lxSfGr
 t0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508329; x=1779113129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bylwVIvheE4A13Mb11/ZHCJxDZDhKuXhRjY1sr2Fkk=;
 b=ZK10O5O1Kos390mp2o6VXERVUvJq1j2BIImZl0LaXd7XqwlAUpAYePJwkDryZGkOkF
 hWD1qpa2o7jKZswKDdwFto5UUeAcOdndTxD5wAzfhtaytswY84kaUnQg8BlISmphmhKY
 4adPNbDi41OLHS/tvyE25+mDUJt4Ez9uqzMNCFwlBcr8149Ob8sGLAZJMETIzMcQi0Ln
 lcz+3dFWm9+KSkj1B4xJBUmPGd5StaBVog9G0yEfLbPo6sG12FTevyEZJ05My60L7okp
 iywdlWdWpKcOj7gKk4Ibw2R73t/qoV5JRwEfwkq8wbJIM9KZP+QWeMoe8xhzbi6aOmmS
 8/zQ==
X-Gm-Message-State: AOJu0YzSpMXovPuxBOYqwzpt2ngJkhTfHtJRX/Xs0HnCxi/pg8vI9TGi
 bExhEPPWGU2Xay/fuiB57rnT/zapaztqLOcohEH9WT+sSvgJ0P6xxumuJh1rAMAelkA=
X-Gm-Gg: Acq92OFP0bDUrTAPUCbpX/y5RGLdQhbUTv/KiPM8WVT/2x2EVsefWinaJk8tOy2zlXg
 ctGJID4F9wL//WaO6mDn35p9OPgXxqcsWFB4oyQK/yewFq1+ighqNjSNbxg5wC/y6XPOHH0djvl
 FQSRusbW7oTBNmGZCEFUZmFtWKwztg6z4zZJg6rpD/UIKaPMW4VXOb7oykdp83OLWtEjcyv7X/W
 hinqPVTnUxBQAdc+4JnsKu6ltxKcPZOVFOFVx4rEnpg+70R6WZkyZ8KXWdbCLwQIPQbxgVd8sb/
 ZxS+EUp/NWZKldMt8xWgAJbmT8ii0C2RVVlhb9GCAcDXggKHoC2JpOD4yNsMMkK8zR5TgItQUlf
 cseknIz+j2Q4jnpKoAVYs336tT0TvezFzOwGfXGswnlgG/ms06Fi434FKUorKXHXGBmhWm+Poo2
 wGrh4nrDj6H6JGkxPgjibfoo9jDrWWyQYViDqAWF4urgVuOw==
X-Received: by 2002:a17:903:3c45:b0:2bc:7eff:2d08 with SMTP id
 d9443c01a7336-2bc7eff2ec0mr101276615ad.41.1778508329304; 
 Mon, 11 May 2026 07:05:29 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:28 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 12/14] xen-block: Update tracking iothread users with
 holder name
Date: Mon, 11 May 2026 22:04:14 +0800
Message-ID: <20260511140416.28271-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x629.google.com
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..552bd8b039 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,11 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          path);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +654,10 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+
+        iothread_put_aio_context(dataplane->iothread, path);
     }
 
     g_free(dataplane);
-- 
2.49.0


