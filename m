Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B797EC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqRq-0004e1-1j; Tue, 11 Aug 2026 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRY-0004YR-4F
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:16 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRW-0000TH-IK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a1f80fd2e4so221839a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469953; x=1787074753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/JzRXJJhfykp1Yow4iskX+SbSIGhsF2ft8QA0zD6CcA=;
 b=kj1e/4faQfPa+q+2oyseuAx5hWO/9H5oB/4O37TcKNMyZABmtV8cL26kWmv1VyMt51
 OBsPx69oWg/3ofTfFWg6cVak6nkZJlmt1MEM+/mxhLMixzWcD4t2uVJVDpXRUsWAoixG
 1nzC6oR7XrmOfXuPNYtU0hIhvqvpMOpsi6Obywq8Zh5iYPnWLMtKNqt7b9bcAe/9cM4n
 1Qj0vtxRrA6X9cbRdlmMi6NrcNBxWRUeL8uODYPrt1kYGMsPsV7cbCiIR+tGW6cu9m1r
 MiN4HwcfULoWe5jMOih9v0Ge8HxvnqMFRJ2cb/paayhiBecMFhxLienc1A/6z5oUY4TD
 pZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469953; x=1787074753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/JzRXJJhfykp1Yow4iskX+SbSIGhsF2ft8QA0zD6CcA=;
 b=hd+011wFxvrx+kTa7Y2B6cLZ4uAvZbVegpqY+gEtE6Pv371djhinQsHtE7pqMEBZqW
 66q4L/XTLmYd1pIC6z2Gluu3ucmbailDehPFInevIDfwrY/BbjRcAVzkIfYKg1K6PNP1
 Xvzj75yvL/ydoub+2FPzNaayKvZQ8lJa4+SXIeY1qtuZGKqtq+88SyFDyP3LI2m8q9lO
 G+QA3+d26MOrAQJhZ4yuicmPf5i4RSGSCgHfjeXSOvjcd9spVkKrokDSSWVcL/rihJdf
 rkPstI07nYYrRqeBveBFxEQnleFGC5qk2uHv6Rqo/a0deF5BaJhj/7HaXu+tPT5FtW3U
 6GmQ==
X-Gm-Message-State: AOJu0YycTx8vlkGcMiTNy/jj2Gvmi0SXMMrbC2sGDMfP9Co6XCNEzZ2X
 jQF605KjijtQdz8pkthp8z1TwDm7kDkVLevYACd76cogG31vqHjD/fN2OzihSunsPW5FI71kAu8
 a80oM
X-Gm-Gg: AR+sD10gXk+w5/u5I8DCeNaLKKGxUfNhBT6K3Z3mSxxGdxcnuuRE4l6BmBfgCmta3Ei
 UQGIhCx4wH9thnOLjyTfLE/LfpntwfcGSNmtcjUlQaNErNY/ZSIMXR1Dj6jrQpQZ03RegDDYQNL
 rzO7CXaFOMpmh2apnGHP4cXPJqtjJLxjjLf5J8Jv4Qwx5Z1IkGqcdz7B8dKlsb2l+A4S1OIsD20
 hHETI5MtDSPz67/dJKB7Sy7jAXGoLJ+1AjFoSnbI/plbzc3LUG2ZUpS5nG8ZNKAXsrVEWVSUrpD
 s8vw13/k1FdPawwyGp1MmRQSEg/tKowZ3IGa+jwBuCKcksaHMKxqM0kjHeTvpyKK9CI1UEsxyHZ
 3TSTY1kPx3W/uUn+UnEU47anDgJ04mZRcWtGF639PWCXCbl5tp4x2GwtnkAsw8bdcrb9tCH9NSd
 ltknGRrQgHLYC0DZ4pF1fXrMPgG9oVCrFn1AAQ/FRYoucBL4AMK1lqH2Bu
X-Received: by 2002:a05:6402:4014:b0:69f:c929:b88 with SMTP id
 4fb4d7f45d1cf-6a36d763d52mr920129a12.5.1786469953022; 
 Tue, 11 Aug 2026 10:39:13 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/8] parallels: bound the bitmap L1 table against the bitmap
 size
Date: Tue, 11 Aug 2026 19:38:53 +0200
Message-ID: <20260811173857.396571-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=den@openvz.org; helo=mail-ed1-x533.google.com
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

parallels_load_bitmap_data() derives the number of bytes to
deserialize from "bm_size - offset" without checking that the offset
is still inside the bitmap, and an offset past the end makes that
subtraction underflow.

The overflow which used to produce such an offset is fixed by
"dirty-bitmap: fix integer overflow in serialization coverage", but
both the cluster size and the L1 contents come from the image, so
refuse the table explicitly. The check cannot reject a valid table:
l1_size is DIV_ROUND_UP(bm_size, limit), so the largest offset the
loop reaches is (l1_size - 1) * limit, always below bm_size.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 830ac78a11..63fe4d5b1e 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -76,8 +76,17 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
     buf = qemu_blockalign(bs, s->cluster_size);
     limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
     for (i = 0, offset = 0; i < l1_size; ++i, offset += limit) {
-        uint64_t count = MIN(bm_size - offset, limit);
-        uint64_t entry = l1_table[i];
+        uint64_t count, entry;
+
+        if (offset >= bm_size) {
+            error_setg(errp, "Bitmap L1 table covers more than the bitmap "
+                       "size %" PRIu64, bm_size);
+            ret = -EINVAL;
+            goto finish;
+        }
+
+        count = MIN(bm_size - offset, limit);
+        entry = l1_table[i];
 
         if (entry == 0) {
             /* No need to deserialize zeros because @bitmap is cleared. */
-- 
2.53.0


