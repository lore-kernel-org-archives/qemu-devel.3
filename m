Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA37F33A74
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9eA-0004AO-3e; Thu, 05 Mar 2026 09:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dy-000459-Ae
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:39 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dw-0001nk-Sd
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ae46b9c70dso19467195ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720735; x=1773325535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n+G8wq4mV7uFZlvEaI2XKVZECGIY8ZOlFUfi3a6yKw=;
 b=Ytz/3r1pItKJWZ5bgaB5ytUhkRz0qiPE3KsaVr3Z7wzTYDSyuR4d8sFpVuilzQLxOz
 kLWM0U9w5TKHjb9B5lPMY91b0X8nGe5opRgvPD/7H7SCSsOS2cSHHi9fy/6A8go5t7in
 9DKVfjJW5eT8d1GI06gqOe6+PIFlQzMQaI2tXhM6Or/FxpuhPkNixY2ebcLSGP8NJmC2
 H6ByQonwD3ECPFRhXmrYkburNBgUO01ZTgMGoVK76pDvuEDrJ4S69FCelWLfx86iG90v
 fOCH0gbtW6NH7bU9ifTmgMFof4RID/YPHi0rB+axAGOBv46HmyXypZ64C0U0Lw6EtpaP
 xb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720735; x=1773325535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5n+G8wq4mV7uFZlvEaI2XKVZECGIY8ZOlFUfi3a6yKw=;
 b=LwSlnxk+c56O6U/0MUiqIFCqpSN0lL0CXWfaacjRkMohKCAdiaMbLpWuiQ29gDq/l7
 UswRltYCKkUDBsw9lsrtTxwUH95RVyPGMFMQJokfp2uZUw2OWlsQB2gvcHQeO8K/CLQP
 sSd2tdQOrPjraXLqxsQX5TDmRcrq9FVs4TlfXoGuaYzvKKZAS5+JCiUD3jGXwC9FpSna
 57dkfKQpXBZhHr3ijgj/2kR0ssBdCCFLPOsVyelnXYXGGCA+dk1c4Kruvv2wH59Z/5LS
 uC7lj0fnoM5j3i2UD7xFNnI+wCxd1VrEHKGaNx74nCAMzXKE6dXpOh0lujNb0zLwWtfd
 K6qw==
X-Gm-Message-State: AOJu0Yx30jp0ELkjzff0LzPguXMHGVxmJzpdZxqlaeM0aiD8CduCVbWY
 MpsBqD27pHhg0G3palOhJkJEKyIMZDEV865oe53189DRseqViTfStjCws/qXy+leE4ejPA==
X-Gm-Gg: ATEYQzwpuJBmOx66RGmUVzHFNpxk6zrQ1UueeBJqBH5NjSUm0suZ4IHc1wn1NvZJWg0
 G42T2FOCNPuiHRbmJBn2Q8CCOeAN6kWs7RnhK/EYnwft7W1/P3FXIQ0quuBKhT6z24tUmgDHBJf
 4lgk/TPRNp380/lY8tzMqC45LW4jwd7GAtWqdiipovERkfOIWyTiZtUMyGr3AljnPvQu/d3+IHc
 cSMmLw+p0/aTeZtDq9W4pQ6cNqEoJpdgnJ8PasiuOuCD9EnFwPuvH8LNtmgWgX64b5q/X0trbPd
 SHa1aOz0rHoELiAxfqAnbWzaOyhQ/NXQ1Z5wj4EkeaX6g2+lR4zZsKsp4mCXJaXmcsiAMqShezj
 wTG3fKk5h+ALCLiMUrnsWMx7OHUGcRsS9T5IU2E3XgwUqw1xD54RTgEDLd4Y0g/XU36xIqfGfH1
 oHRr5vFSyRyMZIvTlN/uyZ0EMhTpl0Ei6YeV8iYc23+oFt18EkQBJ/OJTO654K+aIUyHA=
X-Received: by 2002:a17:902:7d85:b0:2ae:7f85:33d1 with SMTP id
 d9443c01a7336-2ae7f85369emr1272015ad.0.1772720735015; 
 Thu, 05 Mar 2026 06:25:35 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:34 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 08/13] block/export: Update tracking iothread users with
 holder name
Date: Thu,  5 Mar 2026 22:24:54 +0800
Message-ID: <20260305142459.52559-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x630.google.com
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

It seems we cannot find the corresponding resources
(the iothread and path) when deleting them in qmp_block_export_del.
The original method will be retained for the time being.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/export/export.c b/block/export/export.c
index f3bbf11070..98aca7f8c9 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -127,7 +127,12 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        /*
+         * It seems we cannot find the corresponding resources
+         * (the iothread and path) when deleting them in qmp_block_export_del.
+         * The original method will be retained for the time being.
+         */
+        new_ctx = iothread_get_aio_context(iothread, NULL);
 
         /* Ignore errors with fixed-iothread=false */
         set_context_errp = fixed_iothread ? errp : NULL;
-- 
2.49.0


