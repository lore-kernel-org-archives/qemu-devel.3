Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1115606D80D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=UyFSL5MD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP4Dj-00089J-HI; Thu, 05 Nov 2026 15:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Dg-00088I-FR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:38:00 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4De-0008Qf-RM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:38:00 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso712661f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793911077; x=1794515877; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gQ59WUswyZFGl+lE/zPWH93rHoMIyBMWbgB/2lHY66k=;
 b=UyFSL5MDJ6EpQl69qWiHdet7YxNdyMeTtQdrduujoXlDTKVXjNNR96vY8/q1kA5Y/T
 nL6XUopNyh1rB0W6TRXrbzD3PiOvCmZMrwwtqZLbQqgG1f1sMnFS4Di+kfkJp8r9dKK6
 CnpeeEaUhVrUScJWrbpBnJFiwviuwlfFM5bffhA2Ltzg+RU2XoNJyFUs4YbtL5fJw2eA
 F/A9gCIDn6f5f9kHZpV92BT6k6kXwqfy9vq+k5ii8APrw8KzWuvADJh8OJ6QQJvrL25G
 9kP+9US4796twIQtsuQXOe/qETd62fHlUh7gvVAknkb/ENXbUWX1yj/uOXBC9YjdNJzl
 BZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911077; x=1794515877;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gQ59WUswyZFGl+lE/zPWH93rHoMIyBMWbgB/2lHY66k=;
 b=Ie/kEsA3zcHGQ+AwFIWmjPGaZwMo3VF4Xh2gX4gzCnmx5uWJJKZJpQHta8t/mBSsi1
 0kXZ55J40CCVkagv0uxVtc86KHyVpBNleDoaA+p3BfNQj+RqrUD0jmZ7AYx+W3JEddVI
 9gKX56upW9g3+RBZ3P1Lr6QGz9M+GNc3wVUPda2AHjhIE7g6JctgS8awoLp5L5ZOxkoN
 XKw70FSb3rVN0qRaOh4FG3SSKEmyRB8ihSf1XZncYyLxs4ar9DC4Zjrb1N3hfYuDmer4
 fEnSX+BjqfX6bTkps91Tc9dELuwBZm6Q/YYE1ppgAid+8EbViyC3yiQClQwNyLRtU750
 niWQ==
X-Gm-Message-State: APuU4Z87PQI5mhXfZOqfG0r37KfvNOaCZqOhJMkUZaolUNOJuRgN+fW7
 fXYuxy87OV49JFbbVfVrk3LZY8eFqyFmkXdf030ngGQCw00JAbfZcC//l+kgzMMT70e6kGyKx6v
 3dg9m
X-Gm-Gg: AYBFou1z6jFZ9mkGyeFjN6Cn3DQ6w/WROR1YQDguGBjlPNjT4pnzqBaD4YbhffXPmqN
 Cp2wdRKD/Oy7FZ74TKRKWJtgoWMymnfTj3X+pG83xSEx5HAzobuTDKHFDLR7wtAGqF23dgcmAIV
 /JKdDS9WUfjSMELTVB/EQCLo4yz3lSSNxukF6h10eWrQYOIsozo/mSH6Otooa9GA8HirARqVIWD
 VPw/tkjJSiJKi16bFfC1N6nxaUZbLYINKlfdpc3hQiBDXKE67sTZpreVtAAqg+c5+K6UXov06Qw
 0ywfWI/SZoExmCrm2g/Xa1yLgVGLRIgSXNc3zir69KA9HYqm+/Km5CGrxhlYZsUlyfpYdHCTpGN
 BQ6ZgTZBw0AM9KXlJUw9CEIxlCtXFej+KPJmJrofeDyjmsyuObkn9KAoRicwxOny8RkDG+xz3PX
 Zy81GBaE84iZwEi1lj7XBzUuH3iCtwT12hmse+CY++YJABFQkmfH8W8gibkktDgGUP4y5ma4eZX
 +jMtvmBND3FHMwmE2Q1HD2ZYP4HI0VFmpXtXN/ItVfAs7kS007Q+KiAEbFjhwNucwaFUxJEPgJy
 XrMHd8L2d4UEIepwHrdKWWqFPQ==
X-Received: by 2002:a05:6000:25ea:b0:490:39ba:4359 with SMTP id
 ffacd0b85a97d-4927527d826mr1290206f8f.23.1793911077029; 
 Thu, 05 Nov 2026 12:37:57 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm11867435f8f.49.2026.11.05.12.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:37:56 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/3] block: read the old child length after draining in
 bdrv_replace_child_bs()
Date: Thu,  5 Nov 2026 21:37:50 +0100
Message-ID: <20261105203752.3169635-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105203752.3169635-1-den@openvz.org>
References: <20261105203752.3169635-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

bdrv_drained_begin() runs nested event loops, and old_bs can be resized
from there by something other than the BlockBackend being switched: an
export truncating it, or a block job completing. old_len read before
the drain is then stale, and comparing it with new_len sends a
notification the parent does not need or skips one it does.

Read it once both nodes are drained, so that the read, the comparison
and the notification see the same sizes. A resize which completes in
the drain notifies the parents of old_bs, @child included, on its own.

Fixes: 8b267376df87 ("block: notify the parent when a replaced child has a different size")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 block.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 006c341340..9df1a48c06 100644
--- a/block.c
+++ b/block.c
@@ -5566,11 +5566,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
 
     GLOBAL_STATE_CODE();
 
-    old_len = bdrv_getlength(old_bs);
-
     bdrv_ref(old_bs);
     bdrv_drained_begin(old_bs);
     bdrv_drained_begin(new_bs);
+
+    old_len = bdrv_getlength(old_bs);
+
     bdrv_graph_wrlock();
 
     bdrv_replace_child_tran(child, new_bs, tran);
-- 
2.53.0


