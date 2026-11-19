Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE86606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y2ApfxcG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2jy-0003ze-Py; Thu, 19 Nov 2026 09:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2jq-0003x1-7Z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:46 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2jn-0000S3-6i
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:45 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1520203f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795097021; x=1795701821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CFjR7KoIzZi0APpVGZa/YSYzouuZgQbuPxDzBcXTztw=;
 b=y2ApfxcGT+Bl68XaQQeDZRboeWtSiH4l34v4rwEj2+vyCxTnKnhDfJWBQtXbXmnVMt
 3Ve6/AB8edYBoV/mcz73zy9ACCGWLZlgM3C1epb9meK/Ay+fR2RB1MfbIi0hrwWkfgiU
 iCPGfN/Ycqwe/jUTBetNWcFR8Ux1i7VBZcVNsmw8uh/uBuon/5bXUCbG5oIFylCrcccN
 07zqdnLuU++rZY2ekO2DkhIW8Q0bnrR8oYyzAE+OneUmQQ46gUX0/hJd01GuZGde+0Mj
 hCe8wdESYlVii2Z34JaMvhx3xpmFRFN53XZOWH/X+C4MOwy0QLE91pj0P/DsGV0RvqIO
 /PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795097021; x=1795701821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CFjR7KoIzZi0APpVGZa/YSYzouuZgQbuPxDzBcXTztw=;
 b=HdhzQZ4+s1X0T8cqgHPmLplVHibvVZ9c/RRSFilNFN2Jji8z90hv8e1LurjyrsfZlk
 xN/I09cil07xWVRQyrnGmmQjx/MexACmaLW137LXjh/PAg9hbckpM5RftbXTTFk0F7tN
 64sj2PsXc/XrthGHlehX//epGTzBiXQPxu6dMqr311mqtkypwxXk/Cvk4R6RpghWRIpx
 EGPBqMk+Gd55PiYBlVYZM3kXuXG0/4WS1kax1s0n+A4rh/jwkcsBsx8Rwyvv8nA8Pc7m
 4Lzks9qlLA9rtR6cvuF2R5fBGIpGOjJaC+UDvBpp3DnrrW8/iA84+7Y/ax5nPXuViKiI
 NWZw==
X-Gm-Message-State: APuU4Z+9l/HfVpSb7C7V3FGuqxTerTXIuqFe1h0s3O1rxgJpyY8xROQK
 jITVdrEdoR4XKe8NvU9/hpZfgXA5HS7X4mJlu6glMOhdmH7BUblmQV5PLalbqnRCzY9xqoJrQco
 +gP2FW0M=
X-Gm-Gg: AZFdTZep3fycSerqXqSnYUtaPBnRxk4GKJ2VctDpEIhDT+q1gC0iBteii5Bjg26mFjD
 mBhAJePnFcbzquwCR7LiUK4yYPyFmk1Lkb6owhQnkdoHsSUDiJrCiY6iVX8T2RqpVCk3PQlE6bJ
 xQh3SPSlgHjPFwk7a9FN5+1THc4KS1oLGvgGpMh453rI4xlHaO7RSYJKMXwVlfKN1p1y+I7LMW3
 oERDYm/alCHSi9IAJ25TSZgUBAS3PNo3QJDiz7WRfAX+8TfBGja9kc1V0cXRWUC3sWXIOjQDmKw
 6FaZwhCKMfzd3fI3+Q1EwE33cQdAxbYlQEqlwpvLOsTTWmoC7LS/R1YzK/9jv9KbmwufdsLGZ8E
 MK3PpgieTQl+1hc8ZoSZPU4dOqlFYuM2qXHtZTFYpTCyublTBg9lzLTv5k8unmO1xql3IjJ6s3j
 S2+p9FyJr/kEHmQo7z6E3NSVj+woDixjPw2M9OzsL9o3BEKyl1l+Npwq1arCEGX/3FhiBPQVqOy
 lhu8eDJE2BruXIf5O6ovjZzWPVjprqZcdDeuEoTpYTWIWXkDqbdWmJ8Ek6ChaOF0JweO6Kfzfoy
 PiDi7CypIetOGmli6idtjM8GduA/dGB78J3OgGfC+9GFwAxR9WW3hNVk6rMRNB/llbasozvhl1/
 pbpDHzABcahLriCyZet5tZsKpQRfxaNBbKw==
X-Received: by 2002:a05:6000:4027:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-4a63d2d0341mr14147413f8f.26.1795097021431; 
 Thu, 19 Nov 2026 06:03:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab53e891d8sm19118f8f.10.2026.11.19.06.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:03:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH for-11.2 1/2] block/qcow2: Detect corrupt images where first
 refcount block is empty
Date: Thu, 19 Nov 2026 14:03:37 +0000
Message-ID: <20261119140338.2918386-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119140338.2918386-1-peter.maydell@linaro.org>
References: <20261119140338.2918386-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a QCOW2 image, the header is always cluster zero, and so that
cluster must have a non-zero refcount.  This means that an image
where the first entry in the refcount table is zero, or where it
points to a refblock which is empty, must be corrupt.  Detect this in
alloc_refblock().

This fixes a bug where 'qemu-img amend -o refcount_bits=...' would
crash on a corrupted image where the entire refcount table was empty.
The crash happened because walk_over_reftable() would return with
new_reftable_size == 0 and new_reftable == NULL.
qcow2_change_refcount_table() updated s->refcount_table and
s->refcount_table_size with these bogus values, and
update_max_refcount_table_index() would crash trying to dereference
NULL[UINT_MAX]. We add a defensive assertion here that the
new refcount table isn't zero-sized; this can't be reached because
it only happens in the corruption case that we now detect.

Cc: qemu-stable@nongnu.org
Fixes: 791c9a004efbcff ("qcow2: Add function for refcount order amendment")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3690
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/qcow2-refcount.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index df7f6d2f234..2102386147a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3139,6 +3139,14 @@ alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
     BDRVQcow2State *s = bs->opaque;
     int64_t offset;
 
+    if (reftable_index == 0 && refblock_empty) {
+        /* The header is in cluster 0 so it must have a non-zero refcount */
+        qcow2_signal_corruption(bs, true, -1, -1,
+                                "first refblock is empty");
+        error_setg(errp, "Image is corrupt (first refblock is empty)");
+        return -EIO;
+    }
+
     if (!refblock_empty && reftable_index >= *reftable_size) {
         uint64_t *new_reftable;
         uint64_t new_reftable_size;
@@ -3451,6 +3459,13 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
         }
     } while (new_allocation);
 
+    /*
+     * This can only happen if the reftable is all zeroes, but the header is
+     * in cluster 0 and must have a non-zero refcount, and we check that in
+     * alloc_refblock().
+     */
+    assert(new_reftable_size != 0);
+
     /* Second, write the new refblocks */
     ret = walk_over_reftable(bs, &new_reftable, &new_reftable_index,
                              &new_reftable_size, new_refblock,
-- 
2.43.0


