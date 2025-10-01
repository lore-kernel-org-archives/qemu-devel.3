Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD6BCCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zZJ-0006Ie-KK; Wed, 01 Oct 2025 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v3zZG-0006Hg-OF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:20:38 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v3zZ2-00058R-LZ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759335625; x=1790871625;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5U3jhzQr2eCXFOfbnzxWx0bi5Ix/OJalOBY89wnTlYI=;
 b=bifwoAmMa7rwSZUhCfSe2IsaC7peLy50QGTb5r2v4IBxMvSerQMfsc70
 SfJGdMuWB+nPEEH38nfmnWX84jIXhnqfz7DMgAdcG25RFNgOMj3gn4SVI
 jSN33lAQ1lvvm9tfExUMZ/eX4YCZsS2WEnpmkS3PJtpndltUHbIMSPrLh M=;
X-CSE-ConnectionGUID: dkVQ+KakQaKh2WvPY8OHjg==
X-CSE-MsgGUID: FAOF8WNBRjW15JgDIdXG4Q==
X-IronPort-AV: E=Sophos;i="6.18,307,1751234400"; 
   d="scan'208";a="3123363"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 01 Oct 2025 18:20:21 +0200
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id 37F9F2ED6;
 Wed,  1 Oct 2025 18:20:21 +0200 (CEST)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, ppandit@redhat.com,
 berrange@redhat.com, Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 2/3] migration/ram: fix docs of ram_handle_zero
Date: Wed,  1 Oct 2025 18:18:22 +0200
Message-ID: <20251001161823.2032399-3-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Remove outdated 'ch' parameter from the function documentation.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
---
 migration/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114f..e238c9233f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3552,7 +3552,6 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
  * determined to be zero, then zap it.
  *
  * @host: host address for the zero page
- * @ch: what the page is filled from.  We only support zero
  * @size: size of the zero page
  */
 void ram_handle_zero(void *host, uint64_t size)
-- 
2.48.1


