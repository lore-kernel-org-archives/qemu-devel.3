Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E96C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC6B-0000Ck-Nr; Mon, 16 Jun 2025 11:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC60-0008WH-UH
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:50:05 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC5z-0003GP-3B
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:50:04 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 39ECB737B
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750088998;
 cv=none;
 b=WwCuB2mamigF/+5eE+2Vdy3VFgO5gcbwQIRi+4W7NI6V9FizcPY8H8PaIb66e2uO46n+kPZolCyn3Zf8f9YU28pK4QUFNCV796zw3qc13tkZDIiYzvtbNDTWPdoX19v1Wg7HThoESabMsEzlo1mgB/vPFjKs+FMTXoUhT3JQ61gUR8kLBwOAe8k6t9B0fbIlJtGB8lQnmzi1wzJLCUPNTmKCTWaBU1hMfKccGm1RUbp2bA3/05E9vrYikbxjAw2WSoOnxyXLdYGz0Kw+mtUdran04Y1qyvD/6LtoD49JNCSVR33Nf5mI94ilRa7iVa1fX9gqxQla3P4pbH9bUyS3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750088998; c=relaxed/simple;
 bh=AdX+pbXmv9eeLx2TICcIfvUDdEy0BT7Wklw7bbJ4PIQ=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=rNhLyvVnL+jdFrSP0vq/p8hjGtXx3L0Idhw2zpC4bceeO7nG8Iw3hLWYfRBGhxmAoiMe9azNc4iqqvTxPrBF7ekJLSFydUKip/WNv+bVfKgTuoBQHZpjgKFMubkUz/kTzSdjH8FNpkC6PY8wWE2esUR5lMCEDpSR7nWjjDgtNRf070Nr2oj0gTfSzWxQFUl4qNywZSa9v+5PGGu4lDz5oCz/FZuQZLk/RG/7nlSn/9yIpXZaKpGG3uPOIQWYzQizWzkf0Mo51+VZmb8XLbybiUP3UZJbVwCEcrsz/qfGHph7I3cVoM1au5rHHptKilmQ/K/dlKklrvh+AXvP71C5sQ==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750088998;
 bh=AdX+pbXmv9eeLx2TICcIfvUDdEy0BT7Wklw7bbJ4PIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=paahbG/7yGb+EMgz2W7PhdPrSa8/tTuX9iScWdWLVTp8nheia9AwvwA5E+fxA8/wU
 d8ta0OO75DtayuDXxiwQI9awSzW87iakfz0CZfiJ6nZ+65PZN2C+YeYU3R+24DW4Z8
 MFH5ntW7b4L0bjh71FEQbZ08Z21i+QPa/0wSnhgwrlaFpBlXxWkdSpYRT/O759By3O
 j+C5IX8b8CCa53cBzkBxEx6iCijjerAehe7xQ38SwP9q4qxnwcSzS1qTR5zy0og7bq
 Ve1rXa6Rm2Q9mvjAi2pPG5jnGc+YWP5MvEvNSDFZmcbXZJf7uo0UdReexT37feF+8U
 itdmXhPI3uXjQ==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 39ECB737B;
 Mon, 16 Jun 2025 23:49:55 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 3/6] MAINTAINERS: fix vendor capitalization (Vmware -> VMware)
Date: Mon, 16 Jun 2025 11:49:30 -0400
Message-ID: <20250616.qemu.relocated.03@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616.qemu.relocated@sean.taipei>
References: <20250616.qemu.relocated@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"VMware" is the vendor's official spelling.
Adjust the spelling in MAINTAINERS for consistency.

Signed-off-by: Sean Wei <me@sean.taipei>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0477e124d1..7428217361 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2528,7 +2528,7 @@ F: net/eth.c
 F: hw/net/net_rx_pkt*
 F: hw/net/net_tx_pkt*
 
-Vmware
+VMware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: docs/specs/vmw_pvscsi-spec.rst
-- 
2.49.0


