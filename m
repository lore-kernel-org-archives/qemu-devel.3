Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00628C71131
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDU-0000O8-S2; Mon, 09 Jun 2025 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDS-0000Jw-OY
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDQ-0004VY-V2
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81vpRbPBsl4TxnkuqSVUCogqP7kEXR/iTLHp+dsYNmM=;
 b=YhEGNd17w2Q4O8WnFbsgkG0KR6VJI7qrv5x+hPsqcXxutwSz9TVjf9vvG3cQJvb9T3v6Hz
 eI0ABkZao/dBQnHYtoTgXaFQHDzE8a+ak6Aq3tQCxp8/QaqujhdM9Vqhrgq3xXhd2XivLy
 +DPikUMQaqZLdXAOz+hPbpi+OCmxifE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WrAZOdTUOQ6xog6OK0mAqA-1; Mon, 09 Jun 2025 12:19:15 -0400
X-MC-Unique: WrAZOdTUOQ6xog6OK0mAqA-1
X-Mimecast-MFC-AGG-ID: WrAZOdTUOQ6xog6OK0mAqA_1749485955
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6faca0f2677so127365306d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485954; x=1750090754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81vpRbPBsl4TxnkuqSVUCogqP7kEXR/iTLHp+dsYNmM=;
 b=Pgz8BaZVufntzZ4voVjUWDvf2oxkIPHWel5Vb7yQwvTbejLLvw4+WAl2XZiH8StLFT
 RIJHGUDdOATy+HDmIvzR4H4L/zZfqxq37dUJpKYSzOEtmPY53gpfi2bFfRLlopI5HqsE
 fISxnNPno71F+crRsFP2UmDN/T0fpVm16xnsg9a1xHoU+ujPwEQHlskWPPg9xUIZKqRX
 m8jEsRT5MGVoHwIii3W3IwgZlnLT4ST5ctHTzqYeom9GA0/U2ORldjLC6YETtk7ZX5vj
 +PPJTKuCkB3AFqmVCKkQdlt7Vwuf0Wpg6MIiYcKGo2NErOIYpB0rXhB6MeM128d8Ub12
 fnEw==
X-Gm-Message-State: AOJu0Yw8T9F+9s8/7O3QTfwgpg9yKyEyETWWnVXbWau4Rd/mgtyRAH9a
 WFru/t5zwyYJl6cOsCkONntLdyktiTgQbzTrE8IGFYCnwjdrZmEh5ZA+wWgLrfSe1gtb0L6qUU+
 LXGZSttivXQkVi9WwKqqfHWW17W4YmlQGuUJOR9CvuLesfWr6GGBoPEF/g2cVenoymGEll87zNd
 E9CXo1sAfi8p1l/qH1/uXKPyzvAEajtI2Tu9+kwA==
X-Gm-Gg: ASbGncunbd5SlcNT/rWoIA61qV1BrNvBdozoIpOWwsie0X3HuSmu6h9zD69iVLr5fRU
 mVFthWoIVA900AL18b6dcMYGWJUqsSY1wLB6m4bX6k5F/6f0XC2K/ha9qlNOsfWCNUqFDVLNvIF
 WqPCN34VcbwnwS/+N8SVL8iWn8UNMUbD9bgRP1XuLE6zVUnDCpBEdWQCkNnGGnSfUnvb2JnxltI
 eBUOtYv6hOmZmZGFdLpe8YMnZr4EHMMhfHV54h1e9oMWHhfgLpzIAZY4h7t1i6C3A5/X3KUX5ox
 NV4=
X-Received: by 2002:a05:6214:528d:b0:6fa:bab1:f797 with SMTP id
 6a1803df08f44-6fb08fe4c73mr220722506d6.10.1749485954447; 
 Mon, 09 Jun 2025 09:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZErq1RkJKPnlNKJLCLF5JDlQ1gErGbxsBDnSZAz9cCLB4pVASt1u/61YVXtUWWCw0j8lZhw==
X-Received: by 2002:a05:6214:528d:b0:6fa:bab1:f797 with SMTP id
 6a1803df08f44-6fb08fe4c73mr220722006d6.10.1749485953970; 
 Mon, 09 Jun 2025 09:19:13 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH v2 11/11] migration/postcopy: Avoid clearing dirty bitmap for
 postcopy too
Date: Mon,  9 Jun 2025 12:18:55 -0400
Message-ID: <20250609161855.6603-12-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a follow up on the other commit "migration/ram: avoid to do log
clear in the last round" but for postcopy.

https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com

I can observe more than 10% reduction of average page fault latency during
postcopy phase with this optimization:

  Before: 268.00us (+-1.87%)
  After:  232.67us (+-2.01%)

The test was done with a 16GB VM with 80 vCPUs, running a workload that
busy random writes to 13GB memory.

Cc: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index a1d0e8ada2..cd4aafd15c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -835,8 +835,10 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      * protections isn't needed as we know there will be either (1) no
      * further writes if migration will complete, or (2) migration fails
      * at last then tracking isn't needed either.
+     *
+     * Do the same for postcopy due to the same reason.
      */
-    if (!rs->last_stage) {
+    if (!rs->last_stage && !migration_in_postcopy()) {
         /*
          * Clear dirty bitmap if needed.  This _must_ be called before we
          * send any of the page in the chunk because we need to make sure
-- 
2.49.0


