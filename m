Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F27606D802
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=az/rOPJm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP4Ds-0008B7-CV; Thu, 05 Nov 2026 15:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Di-00088n-BJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:38:02 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Dg-0008R8-KP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:38:02 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so5442f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793911079; x=1794515879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0/FdpEVRylXUVeKH9DfVNC28N9DuT4bjTcViLL9br5g=;
 b=az/rOPJm9tMD4Bk0BuEn68Ntsxo6YKJbqpTxLFRea+dK4ic/gXlJ7NgD3EgMEICER3
 hcjzUQvh/dXgKJ4SUuda/ezI2onKs/PWq4u2elWqXmTjFlEeEJtEhYDeqCctRWJDR4D2
 TmdZqIp1KiJUrGEtLCd/eLNt8UUAtPwXIviiVEn9Wj3D3WuAPXsKvEmoyxC5o7dkUiAz
 5FUFpXL+IweQ7b5JvJ2MOH2aGyFWIcGfgzSFZ3SgEWGT/gEuSrJC5AJmgajphI6n+v+a
 bnBScoTVHCImKkGr0mZwgQxyBasbF4idutfhITxpE9WIe+y5d0zez20LaBYVz9jmSX7c
 thtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911079; x=1794515879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0/FdpEVRylXUVeKH9DfVNC28N9DuT4bjTcViLL9br5g=;
 b=K6AAzaxZXHpHQV0JnkGEPzsSrljQd+icwElDeBKPPtCYD6Up9zutLRcQcRSh6S5gSq
 La5AjZvEMA0rU8I0tqZ3ISOuMgwu5p5/Mzv1INvJuf/coKQ+jtDBuKBbosWrP/Nkh3To
 PkXI+u7RqHYFVpOCblo0orRW0zjbPS1Pwy/3OO+yo4YFWFO/IGqqwISfAGenaq1JiT9d
 WwgIYMs5CnWdlNZ+T04+S251y91jNdVa5vTOsU5ZpUURbJqHeoWi9q4ql8RolgVMw0OZ
 sV79nz/rupUAIZEoDbRp33tNf/n8GGqxbjbr2UUbzTU8kVfSM3o9N/lRHwB60Dkpxs1v
 9j2A==
X-Gm-Message-State: APuU4Z8LEHWx5TfC/BtRCzt2R4+FjtoF+cYIzMnR4f1uhk4glPJsGoWz
 S+WzYKjrrDItdlmikKBFNrlym2wMLATmvX2OTaVaZkflG1AUxaqYjQ/S6e+4qvCsBdWTKERolK7
 oUCLe
X-Gm-Gg: AYBFou05Dqc+HZ4GR/ewbDLvhxcucm1KWhs8HY+G0YtWjkJUULuCYdWoXGzymNQ4p5m
 83moEv7gX3c2dGvqxpJL+nVWbBkNaq6y6/cgoc3Q+JvPveDVO3NJ5fJvlpD4jZcuTX+sYQMGtgl
 PGm1CSpO7WbvIr6F5IkkEYtqDArYJ6xivUoIxjLJij7BJx9hNLoEnuQbaEP6rAKdwDKxA8pPIGk
 lLMaL4nN01/w4wsEGEqacTvLEUzN+lW0wkrcYF2QjFmWnHHb1SaXXwmZtINhWDgtOcbGUz80/k5
 vS1aqoxqj2qJ+0dOVqsckIwv6WKyA+oLnIuOlf6jYLn8oCeI8np6L+0pweJnn41b3BMjwR9btKX
 T3OuIrMnfzZFWsXGgbMGBPvh5LfyyZNEYDA6DI+4STe5AxdxYD8VHM+VvVEw5IK1kL064uLXkU7
 ABh2dGsqBGCMVogaSynuhXlU6P51IesMdFu5Ms2FkEhNDwca0NY6WP7qnlZwwnvxtLYS7eLmH8Q
 RSfrN6bWgZW/4+Da96x0d6NrDsWsq5VW24hlu7iQudemNmgzl4S/qEz0gN8OChXEiy/t/A313a3
 2oHG847Zt24eZky0Yd8CQVpl+g==
X-Received: by 2002:a05:6000:4698:b0:48d:fd4b:cdd6 with SMTP id
 ffacd0b85a97d-49276d4de9bmr1064898f8f.25.1793911079034; 
 Thu, 05 Nov 2026 12:37:59 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm11867435f8f.49.2026.11.05.12.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:37:58 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/3] block: notify only the replaced child in
 bdrv_replace_child_bs()
Date: Thu,  5 Nov 2026 21:37:52 +0100
Message-ID: <20261105203752.3169635-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105203752.3169635-1-den@openvz.org>
References: <20261105203752.3169635-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
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

bdrv_replace_child_bs() compares the sizes of the old and the new node
to decide whether @child has to be told, and then notifies every parent
of new_bs. The other parents already had that node and its size, so
they get a resize event for nothing: a scsi-hd sharing the new node
reports CAPACITY DATA HAS CHANGED to its guest although the capacity is
the same.

Notify @child alone. bdrv_parent_cb_resize() has no user left, so drop
it.

Fixes: 8b267376df87 ("block: notify the parent when a replaced child has a different size")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 block.c                      | 2 +-
 include/block/block_int-io.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 9df1a48c06..c3e7059556 100644
--- a/block.c
+++ b/block.c
@@ -5590,7 +5590,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
         int64_t new_len = bdrv_getlength(new_bs);
 
         if (new_len >= 0 && new_len != old_len) {
-            bdrv_parent_cb_resize(new_bs);
+            bdrv_child_notify_resize(child);
         }
     }
 
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 3cb72fecd4..6aa7b2184e 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -206,7 +206,4 @@ bdrv_co_child_notify_resize(BdrvChild *c);
 void co_wrapper_bdrv_rdlock
 bdrv_child_notify_resize(BdrvChild *c);
 
-void co_wrapper_bdrv_rdlock
-bdrv_parent_cb_resize(BlockDriverState *bs);
-
 #endif /* BLOCK_INT_IO_H */
-- 
2.53.0


