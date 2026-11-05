Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F49606A32E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=PIVG1VM3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP4Dj-00089P-VU; Thu, 05 Nov 2026 15:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Dh-00088X-NQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:38:02 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Df-0008Qs-Lg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:38:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e47347279so266f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793911078; x=1794515878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OMgwXKosApxknZR4S+le2PxhGVVDehuMZCeG1zhnEkk=;
 b=PIVG1VM3Rm0QKeUPtMnjOnT1LKUzljBIDX4Op0uJ9KYMGq6nUIiZ+/1WXs6VoNuGQ6
 5trRxEOzfbpW0WPMkFLCF3oI1K1vQGJaQbOx9s+f7lZnyz42JzsH4aalsoXPzDkfkRJn
 uP4j8P0w3TJ4i3+M8nWDCBcSWaWzcKJyskbQ3/O+64tB/FBMgCM99bAd263Rcim+2iMp
 xp81JbEgYwcNdmFDxj9P9o0N9zaRM8B/ylQC3sIer0NXe/PaDjGJfLFGPWmEHKmczRr/
 +ztC4SSyGwoApqcsHT7x+PFAbtaDP48bzZH2ZOdlEf5+qLxSE3c1aJ/ezjqOfwBkcj1I
 73Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911078; x=1794515878;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OMgwXKosApxknZR4S+le2PxhGVVDehuMZCeG1zhnEkk=;
 b=OGqp84PO+h15xoa2LroAwR1O7Gyf5SsurRGW1dY7MMPBDROrCy773re0llh79eEH3x
 UF1pnzopHXf5TAJX6qt+MjJecJPsBD4Ls+ZcxgkdvwzeJCvQs8I1ugesTNqnpjej9uV/
 8qqT43RZ8BWGDoUohVg5S5+lsAvtzYFQmwmco/mz7dC7hQX4Z4z3tifV4fnJQch91Hs9
 51Keq3g69f0wgUi8CMt7cxU8L8ZJaTNDUTsiaEdIbhu+QSysc1nyPprIwUP2RZgmc+8q
 dh5+mUMOuotV//kxQgOWEkBAHWTTOciM/vaeqI/b7hZ6fZ8sNQMwT04wi37EsujEVIa2
 Iqvw==
X-Gm-Message-State: APuU4Z8SRKH5SwiWx0dwRqtwgFOILCJYWa2CTV2pRPEGwSfGJTM7Er7I
 JjAq2Ps5xWISGlHgGCbIw4KqRI1OhQ9QDhsKy7YQpCBrecYOLFkpS4zh3uCEOquknIt+Ji+DPPv
 GktCn
X-Gm-Gg: AYBFou3RZg4jJTAmVawB/nD1vKqDU1MYvPzJiQPJ7yhXIaadO+MfTZJk6ZVaTzDhKZO
 5/2PnhhAnaUO8BVKWiymD/LChjSIuLYCNrLNfxos8q6AzGRuxUEgBboS+BvvQdPCSid6htsEt1/
 V+y54KTn5U/TQOxy6p9NuJFW06Fl+XPikUT3BujtURf6egmLU3V4f4O+0VlH8PwsoIbnAtcIp1Q
 W3lUJpXWsiTXuVNREmU6Lc1heUkFEpAmX8Ad++JPmHg3kVWjOPf4W6Bro3hH93kOetj8gMkQISh
 LCuAkdIgl8uam60zsXWdJ+Y0PmbW8lpNx7MHD/JhpDqG3+GQVXCF/t/aBK++w3ur6JhmyxnLciC
 XxJvCu4gq2HvKt8HJHGP1C6BJUBqCYluwrbG2rnvOTt6ZOlYeR+me+exCLVIMD1EFYt8out7PJ7
 lV2jkYrOePIlkKI0uCFq33SeyJrv3edLJ4kjph3DUaTJtsNfWSOfGPpOZClBHcmBb8nqh5Zy/xd
 mG+yGa1+mk13jxTOFYn7Ws7CZMJei+7Pz35NgpnuWn0wEsp+vyPnpzIc+Kj/DdhwB/AgD3piAp1
 6QezyokUOv+gIe4OEx46colHdw==
X-Received: by 2002:a05:6000:2913:b0:490:2033:1477 with SMTP id
 ffacd0b85a97d-4928021743bmr1186817f8f.56.1793911078047; 
 Thu, 05 Nov 2026 12:37:58 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm11867435f8f.49.2026.11.05.12.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:37:57 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/3] block: add bdrv_child_notify_resize() to notify a single
 parent
Date: Thu,  5 Nov 2026 21:37:51 +0100
Message-ID: <20261105203752.3169635-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105203752.3169635-1-den@openvz.org>
References: <20261105203752.3169635-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

bdrv_co_parent_cb_resize() calls the resize hook of every parent of a
node. bdrv_replace_child_bs() needs to call it for one BdrvChild, and
from outside a coroutine.

Move the call into bdrv_co_child_notify_resize(), make the loop use it,
and add a co_wrapper for callers outside a coroutine.

No functional change.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 block/io.c                   | 14 +++++++++++---
 include/block/block_int-io.h |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 06b1fc13b9..ea77f34204 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3634,6 +3634,16 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
                                    bytes, read_flags, write_flags);
 }
 
+void coroutine_fn bdrv_co_child_notify_resize(BdrvChild *c)
+{
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    if (c->klass->resize) {
+        c->klass->resize(c);
+    }
+}
+
 void coroutine_fn bdrv_co_parent_cb_resize(BlockDriverState *bs)
 {
     BdrvChild *c;
@@ -3642,9 +3652,7 @@ void coroutine_fn bdrv_co_parent_cb_resize(BlockDriverState *bs)
     assert_bdrv_graph_readable();
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->klass->resize) {
-            c->klass->resize(c);
-        }
+        bdrv_co_child_notify_resize(c);
     }
 }
 
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 95d0dd7a05..3cb72fecd4 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -197,6 +197,15 @@ void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes);
 void coroutine_fn GRAPH_RDLOCK
 bdrv_co_parent_cb_resize(BlockDriverState *bs);
 
+/*
+ * Notify the parent behind @c that the size of its child changed.
+ */
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_child_notify_resize(BdrvChild *c);
+
+void co_wrapper_bdrv_rdlock
+bdrv_child_notify_resize(BdrvChild *c);
+
 void co_wrapper_bdrv_rdlock
 bdrv_parent_cb_resize(BlockDriverState *bs);
 
-- 
2.53.0


