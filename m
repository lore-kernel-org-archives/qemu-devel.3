Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE7606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XtrmDRkh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZ17-0005lf-Lu; Mon, 23 Nov 2026 13:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVZ0m-0005jy-ES
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:43:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVZ0i-0006Jf-HI
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:43:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so2819420f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795459406; x=1796064206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iIDeu641Hgg9gG+Jzk7r9/bqxi+GX+WV5MruQkwEdt8=;
 b=XtrmDRkhjhaDIlaN/PlgDWcNvujHbf9iySxHZ6IXm6EPWjpHCYNbYnYk8MI+D9/Rsi
 kUaeMScW9ZNa7xa8l0EFjgm0/HxiWpR5LrJfVMQ49Jgyd/vQMByVlUm+unNEf3YnyNsx
 nlhJ9XjJHV3iHxX95MREe6BcftPg3QRVUPpWl+3NgYZxuRBHdbdROzzVWullMVq13oh/
 Pn0q8q1NZLsCaYRRNuXIm7PFoaSD++PuAHTxs300X2H078mx4YZjKDXXHsZG84/z95PO
 Wz0s6rE8QLi1z/IWwKOSdnK51K0ni1F1UMKNu5377WNKGQH2V9r8OJoIecRDxw7j8m/O
 kATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459406; x=1796064206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIDeu641Hgg9gG+Jzk7r9/bqxi+GX+WV5MruQkwEdt8=;
 b=Lhxw2VeyhjILRXaTAu1MFPeWbRKp2sOO/shAtSl7SkOrezIbSBtiLc6R0OPSJimEXt
 lrnKbj/Qkv8r2NgL+hKF3c9kNxoWQfEwL9uKjebdiYBWE/My/ZJ0z6dF9lWzZp7gXkze
 Z1TG74fgKSO7r+IN5RcVE++6Nr97qvz1q/xdpj77aQOJRZ/3EkOFjqFf+vt0xSjTXpR+
 1wGtRmPh+lOcou/nfRh/0W1HhW/JnO6PjBCq0O97yNVOWpHy6mjO8280VKgwntWh1/rw
 0YJJgkpwOj5lsx7TYJ2ktQBcwByIA03BY763VmpeTuFjXorn7nPf3RScDyc4pJJChX8D
 sYJw==
X-Gm-Message-State: APuU4Z/ragywhFuGVOQ7HCx7jWOL6bHDPDaxFr0T+EeClNgKLg3wrCtU
 Y4L5hCq8PgWhm1g4Vn9QXBsuiXlc0y57XuuUAKnCDJHFWIvUOfmMQNu0Y+KmEcU16muSZ58utYy
 cLTC7
X-Gm-Gg: AZFdTZcy5LjaLAIb3usSY6ZEncEThlWwBg6T4tVN2WvaOAar2Mhzvc84VxU4B8ZW8II
 9iy2cNbkLB6Za4zGt7oNrdPscSlqWE9I+a9bKYEJpMMyuhNplX9k8l466/BgKqnsFhURa1TA9xy
 0Ahl97VxySVmncOmWfmdoJyYbfpkgbta3N2w6OFut0vRx8g9kDb+IjybdIu4YymSv9+2pWNNF9/
 DdYlr6f3yKIa8IyS4d05lFU4GtQsl2n+UYILFbjGUaZ70o1NymcLAD1DyrHJn/WOcsX5vLZP5uS
 Ai8CcOrU0HEgrL6w9AMOqm9havcx3mGyaz+QCcKLxWD6VXmdfjadEGkbJAU4dArPmfSmC22qRI+
 mbM9QBE1149mqp9Os/wFyEZkUvLEj6Ndm6dNrChC5LvzYK3VkPTesfngYF5DIyWbUgCEwCkSNpX
 rTMUVHtYHqCcNKeKHiQH2vKwxw+4klX/LxHTentjhSvUouhOxTfXPfSb//R6eyDrFQPsIKjBmrz
 hznUBnliL8xJ6qk4sqn29hfv0ejSOND6HToy/7PUnmjuI0sEzuBEodsH1S7K/fEkO9uskLo6j6/
 IOeOdvlG14JXJ51iMLvDmMlrYFJ3l8Y8AyU/2C0IIYMYrR7fbTCS+6j+0gxqlFCdsKjKyg8mdZA
 5GZWgnH7aG3iCfJqVJ3nNOUgLVuQ5i+lPcg==
X-Received: by 2002:adf:e9cb:0:b0:4aa:f018:e063 with SMTP id
 ffacd0b85a97d-4abb225e922mr17534662f8f.24.1795459406221; 
 Mon, 23 Nov 2026 10:43:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm26826863f8f.24.2026.11.23.10.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:43:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] block/vhdx-log: Fix loop index type in vhdx_log_flush_desc()
Date: Mon, 23 Nov 2026 18:43:24 +0000
Message-ID: <20261123184324.4085961-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In vhdx_log_flush_desc(), the when the log descriptor is a zero
descriptor it has a 64-bit "zero_length" field telling us how many
bytes of zeroes we should be writing.  However, the 'i' variable we
use as a loop index when we're actually writing out the zeroes is
only of "int" type, so we will mishandle the descriptor if it
specifies a large number of bytes.

Fix the type mismatch; since we're touching it anyway, restrict the
variable to the minimum necessary scope (the loop).

Note that although this bug could cause us to spin in this loop
performing disk writes for 2^31 iterations, the image could equally
well ask us to do that directly, since the file format permits a
valid log descriptor to specify a very large length.  This is at most
"guest self-DoS"; management applications should be imposing CPU and
memory caps when they validate untrusted images.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4019
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Fixes: 0a43a1b5d7c33 ("block: vhdx - log parsing, replay, and flush support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vhdx-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 5c20468e1e6..6f2996ee3b8 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -427,7 +427,6 @@ vhdx_log_flush_desc(BlockDriverState *bs, VHDXLogDescriptor *desc,
     uint32_t offset = 0;
     void *buffer = NULL;
     uint64_t count = 1;
-    int i;
 
     buffer = qemu_blockalign(bs, VHDX_LOG_SECTOR_SIZE);
 
@@ -473,7 +472,7 @@ vhdx_log_flush_desc(BlockDriverState *bs, VHDXLogDescriptor *desc,
     file_offset = desc->file_offset;
 
     /* count is only > 1 if we are writing zeroes */
-    for (i = 0; i < count; i++) {
+    for (uint64_t i = 0; i < count; i++) {
         ret = bdrv_pwrite_sync(bs->file, file_offset, VHDX_LOG_SECTOR_SIZE,
                                buffer, 0);
         if (ret < 0) {
-- 
2.43.0


