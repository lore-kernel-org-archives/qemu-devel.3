Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C01CD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcwQ-0005mg-0K; Wed, 06 May 2026 10:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwJ-0005bB-FH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwH-0002Dx-Q0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso77652625e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076563; x=1778681363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJ0OWL8WJExfKsdO5nO8p6D5eIKwLGM2sS6DWKi+43g=;
 b=r9IK6XUnZtB9NuYeayxRu4wk+MH3mcOEnpwPS8POXiF02N6gS647kHTRXjKQaLFlV7
 5X57rocJFd1dlevWNYd03S1BwQY2w7Ag0kOIMh3fEsF6tLAs6Zxnp6gL6SiO/f/Q/uLK
 tu9WxLSKoIK0YAS5ew64fhygWxJCXz9JQxMwcrPra4IoJsd14aysEBk8L7/o12bH7SRh
 AbBxMqKSMXc+4NYnZg6g+I5DXMc6SNsfCl+IzzU8GwwFvvnk/Ad4O+AryyIkyAcUeZBr
 1GXNsJRO6oa1DSjiqhuGRUFxnHfdiNMDQ9rUelbZlE7XhBBymtriaSlCU0PIckLR+EZB
 pTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076563; x=1778681363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HJ0OWL8WJExfKsdO5nO8p6D5eIKwLGM2sS6DWKi+43g=;
 b=cFfO7xAJCTSmpShncq8m8zHntBvlhVpyjJ+mrp2vmnOtYIWcxtSIG92draQMm72WVU
 fjt/4XJ3sbWfJ876f6O4BJ6y2uoyd2qXzgBqSk+ma+kyjkPgdJn3CjX0aPOF0AT9E8IN
 NeQV3wRDdEeEcWuyjYq+RiLtAQmC+rNug+UWvgWbNO8JL+9flowMwiNThf4BR7LtfVlZ
 5dmneVXZYOsD5CxFRgcVejKPpxDn3rhVUxkpHEFRRl6CGrO40Qpy9ipSDpTKrvtX5SU9
 GfwcH6T8e83l3EM25ttOsnP9h4Gaz0AM3B+zoK4NZyEp81+j4bPE8A5mmbxb0FCQ4dR8
 VkFA==
X-Gm-Message-State: AOJu0YwYlfIneHodcvQm1rdI+6vmJ+oqDLqYaQSbnzYFkr6xxjQT6EOz
 E1l6LwR60o57td9DFek38OcV8he7vEYWcrG3R7qpRPVk1aVsJTQqabSv8OtcnbgTGuLlC2jgU3U
 Jsk2aA9o=
X-Gm-Gg: AeBDievoo0BVKBK1OIbS6CvjTkMiv4D0NWVUClSkXF7eEDQj1htoYCgsfmculr/sIT5
 5r0frezwgNLHqKP/GuK/Nezd9ElLsRGmiwx8db75zm+RaMWoyEmmAQECLMtJvJ31EyOrz4TXD55
 PpEzyQnRstbdWhTMdGzDczPskoi/DpKDOrmFJK7kyYDyzBXTh44mMtQro3mqcwva7CgcWcPHRCY
 rjMeXDiP9SwJMEbmS0RKD+A3WvhilHryEGkPcCNyO1D0Fv6CCBBbZ17yBQYLLzHruEzY8j8yPAG
 CqBHkS5RUgJ5VcyI5D1uKiLcHnBhixsYDrY5SfJXQhPQrmYUQYRshRtPKbJcFKaHpaZJrGkT6Ef
 f2lk/ChfZySWPoIfN9hOW8HYrjnGDuqEc4zonj5rPGAd7AQGb6upFiP4lBVJzfhO2xY+0/YDVCo
 PQPmcIXy8YNr4CaFz4wmW/n+3joRKMA1nwMEUJg6C2A4vw4qNx6IrKrl12QsuL/IPCFunwSVRBD
 pNJznXoBds=
X-Received: by 2002:a05:600c:a30d:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48e51e08228mr42688095e9.3.1778076562792; 
 Wed, 06 May 2026 07:09:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02c5asm12763743f8f.19.2026.05.06.07.09.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 106/110] cocci: Do not initialize variable used by
 QSIMPLEQ_FOREACH macro
Date: Wed,  6 May 2026 15:55:18 +0200
Message-ID: <20260506135524.20617-107-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The QSIMPLEQ_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-4-philmd@linaro.org>
---
 block/blkdebug.c               | 2 +-
 migration/block-dirty-bitmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 8a4a8cb85ea..fdc96d1f45d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -591,7 +591,7 @@ static int coroutine_fn rule_check(BlockDriverState *bs, uint64_t offset,
                                    uint64_t bytes, BlkdebugIOType iotype)
 {
     BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    BlkdebugRule *rule;
     int error;
     bool immediately;
 
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index a061aad8177..87009c45182 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1216,7 +1216,7 @@ fail:
 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
-    SaveBitmapState *dbms = NULL;
+    SaveBitmapState *dbms;
 
     if (init_dirty_bitmap_migration(s, errp) < 0) {
         return -1;
-- 
2.53.0


