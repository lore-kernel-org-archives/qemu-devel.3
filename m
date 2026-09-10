Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B760C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4psn-0001XS-88; Thu, 10 Sep 2026 21:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ5-0001k1-1u
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:08 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPx-0007EB-2F
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:01 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so135284f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083764; x=1789688564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9H56BOI6x1HNNI7/8WusEwmBUtaW++scE8GWB5zaTo=;
 b=XSDt0VYCmZlmW6G+54d/hkZ93kzrTWxECJSFncalOjCJsZ1vM/tVNPtrU2CTpx8BxQ
 TmmjhZDjf2yfVFUk69AMqm7OwhY1dARJf5EtJoVmgWZAZRvYQPZrsQW60MfFnwMdBkpV
 6svMta/orWOJn5oOzqsNOkTyOWVtNzZJl2XM+dd4OwqYoRAA9d6vFkhNnJFQg9WY/VkH
 G79odwFqEw9crN0iBX029i2g8Tpz7LfsUM4m5E2yEAf81Z7aMxWaOQn0QDrhyvKEnnlq
 FeQndTPZCzLM/mavrFLEFeVYwnohtmPWpNlCU8OSvZ4cLlNUQq0iLx3riHnoemgfPNg1
 PQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083764; x=1789688564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9H56BOI6x1HNNI7/8WusEwmBUtaW++scE8GWB5zaTo=;
 b=pQnKJrej89b1lcpR/q+MJ3s3Twue3og3zUtzrEDsfngsjv1NdIY6Qon1P0c3uJa90B
 07H/Ckz4bucPCvJx7h0BQxXB7WAaabXIozxh7cmcFl3GVmHC7/4M6yY6njNK0r0swZxN
 yV+wc6psdPHmq3h40fEQk68O8p1SoUXj2frEDxx3fnRaGr6dOXTUU0DXLvdeTUl7LGTG
 Pv/TUdsa0I/pR+M3ZKb70nrOgN3cegQ7LI6NqDLqp27yUDdVdsjUaOrjayztsevZmYfN
 YGEQvBpmK+B9BpLgGDoEd96fjje7HOlxe+pJXXj/+winXRwr9mh+/NAhjDU2MYBYtUSE
 StMA==
X-Gm-Message-State: AFuF++mVGacuuLhJrYH6SAz/34Kf+4al7c2pgQIhpnI2J+nwd/XIb215
 +WBv9wDSRpzl6l5EZ6/iIYQ5AjTTkaKX0lPn59/mz00kqECby4StXGUMCX7P2/S3sVlsX1RfqjS
 d/zzU
X-Gm-Gg: AYBFou1rxQqdLxw/mm7jr4+UfHDLESHuSklQaJT8DmoVpTSiMtu1YrdA/TyqRZVbctF
 2UATgxC9i2kwrGrh60GgNZ8Yi3Meotfe3K8lm/0g/IS2H88dcex2TgT6Cb2wZmG3qQvDchOVQ/B
 QyVcTiwCi1zj82E+y8x7Pr8W7bm2DrfFQdl9+Vf0bu0SMlLWb9Jdgpq8GuCN1qShbFocMPNMwHE
 yTHDLEUcUCR01PE0SnqCw0PNwlK1tynjIb5jsu876AcluFuAJimvx9YoP5UYL9eLdKysoOBoTb/
 RSWc9sZqaFa4tO0AjVdDaGNDOXQhtusrWpWaN1drzDpaJMLuQxnEM9GiW5ofolaQneHFoRuXToT
 EfeWai6PIuf2QyL8TPrKNHzRTPutDvOKgbvwXHZu16XNy+79dnescCdRBOqZ+EU+HVf2tstS+1a
 SZXXp2KKtUXGc0yJSYShaL2QDrXOzwsK5abwFComoFSlUt+Nf/cAPz03kIB3x3CccXrlB5
X-Received: by 2002:a05:600c:4fd4:b0:49d:870:7a69 with SMTP id
 5b1f17b1804b1-49e619b8a83mr24707045e9.12.1789083763900; 
 Thu, 10 Sep 2026 16:42:43 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:43 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 15/29] parallels: Create used bitmap even if checks needed
Date: Fri, 11 Sep 2026 01:42:08 +0200
Message-ID: <20260910234222.3039975-16-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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


