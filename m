Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14342C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmK-0005qM-U9; Thu, 16 Jul 2026 13:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmJ-0005qB-K8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmI-0000SS-5O
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381ed661712so7238610a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222500; x=1784827300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3QDsfYN2rfgBtltKnnC9maVXXTU4QyxaR/nwD59M78o=;
 b=ccwsAnQNkhTABsaNGDRYPAYDbtVu2tj1Y2aL7uvq3/gcjO/nFAJHaexCgITRw2LrLL
 2RRC9T9OsNHxMKMajavw4du04nJ4tNbn35wALg0dX2zaamN1ZZJIk2iWuUS85H46xHEI
 yl5x5VnMwJW+s6GhbgEPF1LiaDrvAMDeTxJ3q2/Gu5SUv0lre5X9BwTajQFKdHNlir4J
 oqKNv/rTVZMgXGSSSV9W1OY37eyfJPdId+1EKQLx7VU4xfEqYb07i1mWPg0dnT+pn3DH
 SWPvolXh0YcpOW9L9gG5OgwveH/tEMqj068uUctVjYDe+kEZVBQhNPF9q+ipw5L/U569
 eKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222501; x=1784827301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3QDsfYN2rfgBtltKnnC9maVXXTU4QyxaR/nwD59M78o=;
 b=aEMvAj/Y3Ju1SPQB3M7svPkoWR39ZQYh8RPQFr2K/5A1UhcZRnFE/hrtreCyHVkKWv
 aKUP9MYnw9s2BLpAflgsUVna0NHJRwshxmSs113GgKpCNUO3wi1KEK6EogZQ/PZQP0Pb
 zuM/y3P3NOuq59oWUo/e3IzvREmef8XbYd7OXGKNSuDkd2hLAN5usJXUA+WgiQVokUnX
 XvqLjkZip6Zk18EQbyBGYAxyHc9/aMC5e88oQ4QL+GUzp0OtLmNezc+AmdLAyH2+gJnM
 8thMBpmd0NeK/qPYyd03loFUvtOa1Zg/9RJnegDd208241nRrVGvsAtoS6wI6kocCa66
 HebA==
X-Gm-Message-State: AOJu0YzI9kD16xFGGRTRC84p/CEdg5zq5hqFSmiXYEZVPoyLb+1BH3Wi
 PX0eCc1owkHN2CovVdIMMQIR07gKhysfLDt28DL8himnYMGWm2wgeEH/1Odd8FtYXjY=
X-Gm-Gg: AfdE7clCA9KQ42EGSpg+C1ArfcI7x3DfY1dQ6RixklRcobIq1r970OYPzC9WIU9d9HK
 eBkyVb6UKarUPYfT/E3jcsuOF7jfPK690iWD+0uECGNv6F/5daghmpeIXAaiKhVKqnj4C8WqEPz
 Fq43nBuwhXwjVsToiVbNuS3LrMhSunsHa9OroepP9wpD0Cidp8kFPgQy3oXpvFboxxMb4RKtIaq
 //NCJ59aNH7AsChuHz2R0EzAK2px5WqF2WUe+kcuDNXEc1XCgOr0NI94EwXs2yakJFakhpx0OJo
 j6BF+pGxu+fqcMeERHliy203R76Da8AxZATRp7nJxYOicrcZtyNdI8IG6VRQTO+VKk8dBvZJ5fK
 yY6XP8imbG4N7MLy0a9Hu24PPiJuHakEs05vgglRUxSb8fq2NGkZ5/6Y019GB/vn2FFxDe12fS/
 bhDNBOXgn+yrHRbZtPfgT/1Nyao/2DRA==
X-Received: by 2002:a17:90b:3a06:b0:387:e0bb:57f5 with SMTP id
 98e67ed59e1d1-38e1af72917mr10122716a91.38.1784222500555; 
 Thu, 16 Jul 2026 10:21:40 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:40 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V10 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
Date: Fri, 17 Jul 2026 01:20:45 +0800
Message-ID: <20260716172108.87700-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Normally the IOThread's AioContext is fetched using
iothread_ref_and_get_aio_context(), but there are legacy callers
without a clear ref/unref lifecycle. They cannot unref (e.g. because
they do not have an IOThread pointer), so provide an unsafe way to
fetch the AioContext without holding a reference count. This unsafe
API serves legacy callers - do not use it in new code.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                | 2 +-
 include/system/iothread.h | 9 +++++++++
 iothread.c                | 6 ++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..baeab3a3e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index 86f02c5a7d..3cce5eeb09 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -78,6 +78,15 @@ IOThread *iothread_by_id(const char *id);
  * thread-safe and must be called under the Big QEMU Lock (BQL).
  */
 AioContext *iothread_get_aio_context(IOThread *iothread);
+/*
+ * Normally the IOThread's AioContext is fetched using
+ * iothread_ref_and_get_aio_context(), but there are legacy callers
+ * without a clear ref/unref lifecycle. They cannot unref (e.g. because
+ * they do not have an IOThread pointer), so provide an unsafe way to
+ * fetch the AioContext without holding a reference count. This unsafe
+ * API serves legacy callers - do not use it in new code.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder);
 void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
diff --git a/iothread.c b/iothread.c
index f5d4708b25..157bb4d302 100644
--- a/iothread.c
+++ b/iothread.c
@@ -449,6 +449,12 @@ void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
     iothread_unref(iothread, holder);
 }
 
+/* Recommend migrating to the new API with IOThreadHolder as much as possible */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


