Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758B3C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTF9-00032c-JO; Thu, 20 Mar 2025 23:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTF1-0002wy-Ct
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTEz-00080E-Dn
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2243803b776so7815ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742528411; x=1743133211;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kByEk8Ezb+MN3eJtjKV8YMAmgK1UNNA7qz2bIqmhrE=;
 b=kh4yb1YraM1Ab2zIjMUHdgay+bR+bcKe3mynm+m8z6OErgj9s1+zsKdsDUqdIuElFV
 lIV1yd11lyqjgPvgRqY1ocam8ejS4ErVI2UI59b5m5WLi4P1OTOAGWHr4jZrJYChncJv
 rB9DM//lrucraelTYwZxehv98S5eQBUzi07iPlyzTmYPl6x8Z/b3ZQUz/nzN6mug4CEq
 wAFMs+vuaI+bqsAAAK0KpIrH20l5qbjX6S/Yb2rCV4YACer54bQmWWexylRRO+0XuENx
 vzc5PTn16T/pDRbQCHSBW1mJpo31WEHSiyLDjM054mnK4aIsCp+H8vXJBr5BuKPoRxD6
 hvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742528411; x=1743133211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/kByEk8Ezb+MN3eJtjKV8YMAmgK1UNNA7qz2bIqmhrE=;
 b=gRkbKu86Vfm+/Cn6Ut8VWcfri6+VqLPWGkqSipI1XxG0Z4FwjjS7puwVu/qgCkfmwU
 tBmcEYoaZGqjm0PqstnW0fgxWzjL0IpPXmgV/P3YQR7o4CEJj3O2/B3GmeKQ3o+MHZFf
 FmgSbSaqvNpDqOB5SOh6ALzUOL3HysXd8NDYVCCnbBf2FUa2alkQM+W0wt1DBwzvyC0Q
 jErehQxaWrtHi/eYizmgVCANXnu6UPQbfmhdD7hUR9tCgpAIWQnNx62yLPkjdGZJXuPf
 nRBsRaFdbeaexHP3AisBKDfgJR+uMhUy59MHQEYNSr4Ic9t+kpE8yXMHerADlFYie2Ty
 6Zpg==
X-Gm-Message-State: AOJu0YwBMV+Qx87RtyYN3M9J3gQZteGcNVAY31952NanIRSA2kGPzr/g
 B0V8L4e2XsTLvF3PsEfjy5gi6sQ1JkmIlti0yra0x1yadb/9vq/ugMz+63of1hcHCDkGuX9N/a+
 F0UUbwDvl
X-Gm-Gg: ASbGncs1Otlk6dY+187cXFehntdfas/h8BjwGEhZyngk8IHnNMyl2y/n+F5Yh1mpJee
 2Eux0TBB2/ih2bXs/rpt3Fk2Yl6oMJjZSzEF7iUZZldzqDSDjkqsCRDFA4Vduxeh7H/WjwY/Lc1
 /ynr3LrqpDMToTZE53BM7nfl7y5pyc4FvmwUybxm4UCxS7L/WJJ/GMBT+JxiQWxBOMM8Ryfj5dI
 SlHLRPbjWC6CDpscwodRhK3Qg7oOERTuOabrQFYFMYoquHo1x8iYyIxDT4h4Vv9KDIhZ6yfZCU/
 kQS0oHLhh2oRcvGldi2pdVJgV+y0d796NERxUZoiGZy13MRnF/EwpsgND14HlE0kVQ==
X-Google-Smtp-Source: AGHT+IHpvR62fNkaBd5UeLAcRxSKjSbM3zgDh2KyVM+gyDC0wpvpfyXMmxFS4OKH7tcxaGJdGTOvwg==
X-Received: by 2002:a17:903:2d2:b0:223:6744:bfb9 with SMTP id
 d9443c01a7336-22780e02a15mr34789405ad.41.1742528411534; 
 Thu, 20 Mar 2025 20:40:11 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.85.74.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b8075sm6079725ad.128.2025.03.20.20.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 20:40:11 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, dengpc12@chinatelecom.cn
Subject: [RFC 3/3] vdagent: Drop blocker to support migration
Date: Fri, 21 Mar 2025 11:38:13 +0800
Message-Id: <428847678b4d47b4469236da2d888db18cc4c31c.1742527956.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742527956.git.yong.huang@smartx.com>
References: <cover.1742527956.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 ui/vdagent.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 4635e8fa56..36b0568135 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -6,7 +6,6 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
-#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
@@ -33,9 +32,6 @@
 struct VDAgentChardev {
     Chardev parent;
 
-    /* TODO: migration isn't yet supported */
-    Error *migration_blocker;
-
     /* config */
     bool mouse;
     bool clipboard;
@@ -673,10 +669,6 @@ static void vdagent_chr_open(Chardev *chr,
     return;
 #endif
 
-    if (migrate_add_blocker(&vd->migration_blocker, errp) != 0) {
-        return;
-    }
-
     vd->mouse = VDAGENT_MOUSE_DEFAULT;
     if (cfg->has_mouse) {
         vd->mouse = cfg->mouse;
@@ -998,15 +990,12 @@ static void vdagent_chr_init(Object *obj)
 
     buffer_init(&vd->outbuf, "vdagent-outbuf");
     vmstate_register(NULL, 0, &vmstate_vdagent, vd);
-    error_setg(&vd->migration_blocker,
-               "The vdagent chardev doesn't yet support migration");
 }
 
 static void vdagent_chr_fini(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
-    migrate_del_blocker(&vd->migration_blocker);
     vdagent_disconnect(vd);
     if (vd->mouse_hs) {
         qemu_input_handler_unregister(vd->mouse_hs);
-- 
2.27.0


