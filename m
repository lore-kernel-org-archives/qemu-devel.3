Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8439AC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f8-0002mZ-Oz; Thu, 03 Sep 2026 10:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f0-0002fc-QI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ew-00040v-W0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495437bb891so9079965e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446601; x=1789051401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9H56BOI6x1HNNI7/8WusEwmBUtaW++scE8GWB5zaTo=;
 b=aDZX0W6wl2CMlSZ9egE2TNeBvZSC2wMWEFgCUZ24HWwtPZq+hQMCFW4zbnlVy8a6dH
 BbfG5GggaM4vVzz70MdNFsrqYDFre5oPYe0PDMSm4snumT6HgI+D37RarR1f8B+YXPnS
 iyVFBDCQy4DYvWmAu2C3xoH+kXXevJEoTgbH2UvE3cU0Gn2YQy98uMynS3pomedBeSWN
 LJ94nzieyzV7L2e2sPEBR/VWb11RSAEVb+R3D9riBON5NX5GEqgLl/P6iBY3F4AkqkUS
 DcEvCYhxdIytQEmBigYozeWhxMlNdgPY/2QJ4jBKL0tEZdJF6Ne48p6XNhmLaauw2VmF
 pGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446601; x=1789051401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9H56BOI6x1HNNI7/8WusEwmBUtaW++scE8GWB5zaTo=;
 b=lSVNIP9GXGgdWb7uGusOIYBOaTmFdvksa3XG0jlj/TGvJQw8e+Lj9oBbaljiKM4nEC
 mn/jk6zXutlON1iZR2upoJROQsMOhTkvLL4RDXaXD8YuWa4vZ6MNiUqFz4cWcBKDg1Op
 4KSENSOo6yVDSEK83XgXb5Lt/Ss967Ao+9NYyGsSiH8ZvC0HiNHIvIfKTlXtkgHrJmG5
 kAn/kKDW6ZDnsC641mtfD8hbOgzb/erk6zZ8uJPYczCWgpne27lgHUypt2aRA+A+RDe+
 tk1hwqJmlV8R+CxJUPVVgYr+unOqq+LXPf9rY0tUUdI9QJh8v2WWqY/R79wgHJDtVbk4
 zmEQ==
X-Gm-Message-State: AFuF++lFdvpRFL3+NjDwEbb8XwBqeY4bv1dz4WsuIXNzg1xBUEG7OtqI
 pWeZ8+D5WuEmASRkOGF2k8e7y+e8vVCHirIX56bWDbj2NrZXUzVyF32pov/OUD8tfgId6QHoDXs
 DIsqG
X-Gm-Gg: AYBFou0dQkxn7ATMeETae5B4YXSVacE2ZeCvcEXLWkouFpH8BtRkHzk+xZVKfYYzdXw
 MYDW0TFujBR+qmsS3mGRGO4jFXwdsJ4dtQWVAcFtH+nnWFmSbeSIADVePpyjkU+eRPSVEMe+rNU
 WoqkeUz1MI9qAzoA66bAK0NYC0UIVVUWQIe0M6uwqIkkhza2S18rYWdUZX6PpSyfm9dQYA9NKts
 R/bxWitymyf4r9DgrAsB4BxCM2zQlWBQhP+XrgMmM7x5y6+/H8oakZgUQUIR+RwmCxvFz6jWtGP
 6ESkJWI71JNZYlAf9TFjSx6bVnVspdJt9aP+BGZZKu7XfB/IDhHlM9Ntt3noNj8MoGQOMm6D1b/
 Qx0ba9AjPSOxL3zvnRhTLN/Nv2y6yrsLCP+LBhYtPzfucI1inOn3gS26WvPu0FdNFybN5IJG/06
 hKkALjtT1XK0R9OiMxqBPI7T7fpNQGV9xjyd2huXa7ORd9QXPZUkEL7Qww
X-Received: by 2002:a05:600c:4255:b0:49c:f13d:ffee with SMTP id
 5b1f17b1804b1-49cf13e05f4mr29385085e9.18.1788446601570; 
 Thu, 03 Sep 2026 07:43:21 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:20 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v7 08/25] parallels: Create used bitmap even if checks needed
Date: Thu,  3 Sep 2026 16:41:26 +0200
Message-ID: <20260903144143.2328870-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index cacf23143b..307e90ec71 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1476,13 +1476,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (!need_check) {
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            goto fail;
-        }
-        need_check = need_check || ret < 0; /* These are correctable errors */
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        goto fail;
     }
+    need_check = need_check || ret < 0; /* These are correctable errors */
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
-- 
2.53.0


