Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFA606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=V2agp9AC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWDqR-0004j9-34; Wed, 25 Nov 2026 09:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1xWDq7-0004iR-LC
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:19:18 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1xWDq3-0000Gs-0p
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:19:14 -0500
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7795E3FC3E
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795616345;
 bh=CNbJ4jdeAVy36pkVRuptg2UhOmOsN/k7g6IByvQ0+9E=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=V2agp9AC9D44Ste4KQ+x7Hq6dIAOXl3/rqJADRtNK92ghL6wri1O3FYcrOSXgzViN
 Gbdo0MCA4spHpDgm/8dzsThF5AkuaLGqf2wXPeuz8YihHnWEpf5ORMJqkpEXKxFEop
 0C036EOzDxiidy+3lRN670qiyR9K7nhD9uK4e8nqYLtkWRc+xvnnU6ak3wQ0dc2Ax+
 CFEQCPG4+o7dpx+6Ug7k01tUcCEySGmEmkglEzRdjCXaO7kKYHYv06V1RmjAr3TnHb
 d1CbKQx8UJO0DLRRguzgBTGf2zFujrUEeGqgUALV24rWWG4CXXTASIITHHIrwW1o1g
 7wDeunzX/L40u1a29aDgsEFJEV9lPVc4ERHlvuo+GC7k9DdGKPKRJi9wqJgEzRXTOB
 jRNpHyCG3JujAXCPEvhbViV7xB/w1yrfLREB8fc/TdLKcKlBJqHkcF6GBjHR/7R4JJ
 Yes09bNT45EkxHAN+iYM92tBwci8uYVqZLJ0jIRgvrq0ctFJBLMmd0TFdtLCNYW7UO
 8igL51zxEhZImNQmnXa0M9hvQ1VtuqPiLVgF5zRu/SIbML0aOh70zuAlMJZIhll4/N
 TNNTSo1jg32J8Xrsiu7BD3Z2HfjiiBCIXeoXak6WJR7qlaLmPo3FG5mBG7NKnfQIwW
 vrjlFdmSexry9z7hUJaRjVvw=
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5edfbb5b812so1956503e0c.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 06:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616344; x=1796221144;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CNbJ4jdeAVy36pkVRuptg2UhOmOsN/k7g6IByvQ0+9E=;
 b=RdM0lCNX7tSJCvQJ5EydSLkopqcx4RBT5XfCopbnXLeAsf2V74uzo1TN8FevPRoh3E
 LxQNmrfRZnNFnCtzdmNW/neZqcRbkDUX9nrlCpFtjuzX3OwHKD5jqw9ZRi9rDhqTe5yB
 isKunYADC5IprWVkwTuWOudV++s2vaK2B+VMFuWKRAnTbqduT0ruX0w5/WoNHKhgFhu4
 xgHklW2fwidJIJJF8g21ZNScHI5aXuLWW4/UhKP4HC2bHum0BVeynN5UKW8+eKW+6cBW
 3EqifnH/ZAc1RCdtDuTwD3AGjANmB56ER86jHCSLOWVEgW//uwXpLmjk7EO6QBet4F29
 bGTw==
X-Gm-Message-State: APuU4Z/x7gLXCGiGPtHwLF36kVpORkXqUXvRh/CxFBQzdwHEbRiWNlZ7
 hQAglQkTe5AKoqImct6Vi52j1ERDrbS5D87LHaEXSE52cF86f1A0P2/p1eGvsFWiBKL9NHoQ7Hs
 HFA3TBfIw89ydTBt0cKLdcZFPeSm4vHkoBJf3J8ggEiR/mnuH1NY0yFlMLteP8qxHPLFtepuw
X-Gm-Gg: AZFdTZfFesYHcv+3/VVx8iTVGBODiOXWgH3s3Nmw+FbjA2Zw+U7HJahxD/SQx/SV+ox
 7tyu1NHDsri4st7ULQSDIIvGCu61py5g19CgjwuULX4PTzKdf7imuaLnt97mqczmwhxX40M6eRB
 hQhf1P2Hsql2UXZrBIyzoGeo4rjeqN0rMRLE6cVVj0pmB5B5WCz3BGd/1luoJcEe6j7rQHAkpjc
 6MwMNhIwi3yrYgythbXnGmED/ap2CjpihQO8qG6K/+F3b4vosukOBJE7/Iy1b4D3lita8NslZOi
 4x5HJULdxKylhPQR7Yk6qG5O/ySsF8PBst/AiQ1UdJ4Hf0fHFM+IBNfIfvHWgzZruNYU25WX5q2
 +WVVsKiAjARBSi7XIvU2J+vB3fCPt8MyNMenurVp1EXvjG7EyxEeR8dWPFh6tmtl5AEr4yZcKTb
 Es01bAA1pk95lHyjTIxhlsQkNPY3wXj5IkK9c=
X-Received: by 2002:a05:6122:4b88:b0:5ca:fc48:5634 with SMTP id
 71dfb90a1353d-5ee8aed35femr9671584e0c.11.1795616344178; 
 Wed, 25 Nov 2026 06:19:04 -0800 (PST)
X-Received: by 2002:a05:6122:4b88:b0:5ca:fc48:5634 with SMTP id
 71dfb90a1353d-5ee8aed35femr9671557e0c.11.1795616343762; 
 Wed, 25 Nov 2026 06:19:03 -0800 (PST)
Received: from [127.0.1.1] (r190-135-228-133.dialup.adsl.anteldata.net.uy.
 [190.135.228.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee8b42f564sm17550287e0c.2.2026.11.25.06.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:19:03 -0800 (PST)
From: Jorge Merlino <jorge.merlino@canonical.com>
Date: Wed, 25 Nov 2026 11:18:46 -0300
Subject: [PATCH v2] block: Add tracepoint at end of read/write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-debug-block-ops-b4-v2-1-ed384499385f@canonical.com>
X-B4-Tracking: v=1; b=H4sIAEXuBmsC/32NQQ6CMBBFr0Jm7Zi2YgOuvIdhUdopTMSWtEo0h
 LtbOYDL95L//gqZElOGS7VCooUzx1BAHSqwowkDIbvCoITSohUtOupfA/ZTtHeMc8a+RqdJ+9Y
 42SgPZTgn8vzeo7eu8Mj5GdNn/1jkz/7NLRIlqlqc/akmK3RztSbEwNZMRxsf0G3b9gW8KSZxu
 AAAAA==
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Jorge Merlino <jorge.merlino@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355;
 i=jorge.merlino@canonical.com; h=from:subject:message-id;
 bh=5TCDuoRciue7rfBhpf6Tyd1/Bk5iQperYOd2+/2YHKw=;
 b=owEBbQKS/ZANAwAKAbCmxgD4DSg7AcsmYgBrBu5V98JJXJPSbxdFTlqPgKKM4ln+oTPY0tQhC
 0zOw91F8aWJAjMEAAEKAB0WIQSX6BDfnZ5646Dykg6wpsYA+A0oOwUCawbuVQAKCRCwpsYA+A0o
 O7YCEACWZJSOckIR+y5Z/CHI34mQ2leTimgMbd7rHt/qXHRJKBy51M3ma1K3yZ2H7tzq6WH/FLO
 CJGYeipaYdEBYdHaJtHzBhCHjbXGtBS0ufww3Wd4CIhKjILfbZleVeKKIXcdPCO2GRaWdjTiFcT
 ZBATGX4ArpV178FjeG8ltugX4GqmLper2WtphIlENtExwocvtd9p2fODRnc5PUesCHLZBAXwYHv
 rsFdOYBvy/tbqJXQuzKaMPEfBsLJbPFEO0z+oT3N7DFbv1jMrgbTNS+lYjN/Ye311GvCgWFJPiQ
 mB3w/dmzlJnV+Z3EA0JEtivXkNxlCtxiqR4jWZjRMLjs/eV7trixKgyrcl+36/OGjsBvAZzKfEO
 iElrP1k2H/G92/aEa93YgkFgMzM9TXZNuiZtSUUGA0v6r3dKOoIWmuiF5b171gjNBvSQ7ptqO03
 VpC5m1pZzofJ/k5WgbE9RMSrGpB3IlTTq5Vn+lNGacEBCv7tiruMBzwIN5DZl9SnqXh/v+a/HqS
 a1eEwbl55ty8y5RvLDeaMCeuf6uUrMi0KZJduw50IW8Y4Ud96LF7LjSDpWBuQ8KDXIwjsMwA6TP
 DYsTkJ/CPjM4QuwOHz/su7tSpeW4gKkbOJqT2MzSYgNNMZhr0t1/JxTZsuhs2bnepreo7P5HgC+
 85IpGaJU1+khNKQ==
X-Developer-Key: i=jorge.merlino@canonical.com; a=openpgp;
 fpr=EAEE4B9833141159D1CD846907F02065E74A8FC3
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=jorge.merlino@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add new debug tracepoints when block read and write operations finish to
be able to measure latency.

Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>
---
This patch adds debug tracepoints when block read and write operations
finish. The log includes the parameters used when the operation was
initiated so that the start and finish messages can be easily
correlated. Also the return value of the operation is logged.

This can be used to analyze latency issues with block operations.
---
Changes in v2:
- Updated subject line mentioning trace points
- Added traces so that the end trace appears even in error cases
- Link to v1: https://lore.kernel.org/qemu-devel/20260909-debug-block-ops-b4-v1-1-2405f34ec068@canonical.com
---
 block/block-backend.c | 4 ++++
 block/trace-events    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc4..2a06913be5 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1351,6 +1351,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = blk_check_byte_request(blk, offset, bytes);
     if (ret < 0) {
+        trace_blk_co_preadv_done(blk, bs, offset, bytes, ret);
         return ret;
     }
 
@@ -1364,6 +1365,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
                               flags);
+    trace_blk_co_preadv_done(blk, bs, offset, bytes, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
@@ -1426,6 +1428,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = blk_check_byte_request(blk, offset, bytes);
     if (ret < 0) {
+        trace_blk_co_pwritev_done(blk, bs, offset, bytes, ret);
         return ret;
     }
 
@@ -1442,6 +1445,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
                                flags);
+    trace_blk_co_pwritev_done(blk, bs, offset, bytes, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
diff --git a/block/trace-events b/block/trace-events
index 950c82d4b8..842c3fc809 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -7,6 +7,8 @@ bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 # block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
 blk_co_pwritev(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
+blk_co_preadv_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
+blk_co_pwritev_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
 blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 

---
base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
change-id: 20260909-debug-block-ops-b4-d6e6f9ad182f

Best regards,
-- 
Jorge Merlino <jorge.merlino@canonical.com>


