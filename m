Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4C1C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6Pm-0008Ck-RH; Fri, 26 Jun 2026 09:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pf-0008BC-7q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pd-0000zG-Bj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso507231f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782479764; x=1783084564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ThB6GTLIkB2LxwLs/Jboo1V2nmPNwlN/KgRc5rVPHo=;
 b=XMNByCZszYxmNSAZfGz0sY+bI1IFrhgorPpppVdz56RVwlZohcrwuPq6wuv45O1Nf9
 +5Ze6TnhExCBYo9Q9xSKnfs+momUMn/SI4FkgYeHx0Ut/UlPXQn42QQaGS0LKH9cr65J
 UjKBsYFpxLn/Z9ZSFLzau00lJBs0+vAE9lgc6la3Q4FdehdiMPIGx2l2lSnoNALTy170
 /c+putOsosfm0O0nSN8plJjAdyWK6wbsuec1oGfLckHMk3HUdOMov96fo3tM+/VRXwKb
 4fnR9QBWfXBMDljbBd1SMdN3PAKFfc8vgVig7Bkfw3WeIN0QKfNCil/oBeO23AdyJI5N
 LC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782479764; x=1783084564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ThB6GTLIkB2LxwLs/Jboo1V2nmPNwlN/KgRc5rVPHo=;
 b=GVGpL14R8hU1kv7diCmOxZIHHumD1NbXHCuUBlajjZJB7gjTFApLDOenMbeTA/eZCQ
 QBJqKb8FPus2FuJsVI+dOnHnJXOgCMjbsK4q9QB++i2RrI7qUPgMnig7PPolPHiNigYJ
 OiJC3q6v3wMKouJ5DaLP+JCFSjzpUKnobcKAjyCm8PeJ1m9Y+MjphfUPyhjP6Bzcho7R
 HLBZNVr/1hERItd+xE2yyFzAqXjJP0a+isaZ1k7C31i2rsoUdL/PJsQOp/kGesz3VdR9
 fDdRr564L3bf9Zc/gjBihh00bWTgI5jrmqsYCFKBN6RJlSWmNtCG7V+WdG1eCrV7S1QO
 KAgw==
X-Gm-Message-State: AOJu0Yw3eT/ue14cKMEKVdyDIRl2+kegkjyFwvm3FJJGSxtytepjfVj7
 LlIrufZ0nDhHUsO9nhgldCKcuVyvITs8A+6g6goH2K+GYrj227f0BJmp6f4VMg==
X-Gm-Gg: AfdE7ck/QuS7koTpkTGUolo5MeL9D91TnNwPIx4TkdmV9wxhVHTcVVMEt/x17wYkDrq
 GxgTThA8I5tKeaVW7Dl1ZIi+wsxMYtoCZfrNPaOfAwhZLyHfOY4eEzuq07GgnJomPYUbndh8zRh
 2S7q26l0SD7yED6G3zdFu/PPAybthqZ0p2YsZ3PSGBhtmjm5BRTcJwoM8BcYmaRXHYK6sSeYGTu
 aZGuPNsGDwvtUdHZNwESSE6LWWTgWWwK3gce7S0hLmXwCq6lFJhHDrD4MLIyuzaSc4SWcOS0dtq
 lcbHa0H3mhRzzyCSOm3Wny9iT0AXXonlN1en8yJc0VRiUyS9OpDYZbJVf/+pPzG5YkQn5jnpt3l
 n/VKycCYUmbK9XWJ/FAmRsBimiUPUIy/swEc40jdOI1rkr8SzSTVgCG5uBBHodb0tDS5IFM3i1b
 8o85akbwvrQrkfefQG+q4dQjqQzztQqUiqiJRBwMP8xCuStA==
X-Received: by 2002:a05:6000:2c0f:b0:46b:ea12:2912 with SMTP id
 ffacd0b85a97d-46dc05553f8mr11618756f8f.5.1782479762730; 
 Fri, 26 Jun 2026 06:16:02 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:b369:c9c1:81a0:4afc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm26093756f8f.29.2026.06.26.06.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:16:02 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v13 2/6] block: widen BlockLimits.zone_size to uint64_t
Date: Fri, 26 Jun 2026 15:15:51 +0200
Message-ID: <20260626131555.459792-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626131555.459792-1-faithilikerun@gmail.com>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x434.google.com
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

The zone-size field in BlockLimits is currently uint32_t, capping
expressible zone sizes at 4 GiB. Real zoned-device protocols
like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
uint64_t to match.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c               | 2 +-
 include/block/block_int-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c985da94f..ddb159c58b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3600,7 +3600,7 @@ raw_co_zone_append(BlockDriverState *bs,
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
-                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
         return -EINVAL;
     }
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..7571ed9968 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -901,7 +901,7 @@ typedef struct BlockLimits {
     BlockZoneModel zoned;
 
     /* zone size expressed in bytes */
-    uint32_t zone_size;
+    uint64_t zone_size;
 
     /* total number of zones */
     uint32_t nr_zones;
-- 
2.53.0


