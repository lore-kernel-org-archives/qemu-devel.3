Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FD5CDD55D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr3su-000775-HW; Wed, 18 Sep 2024 19:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr3st-00076P-3K
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:14:55 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr3sr-0005z7-Cz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=8KCKR8Z4fyMwdHYhXIg5dBaJGxaQw6CWDC5hIfzpuJ8=; b=io8+f1JDxjju290/
 ZcZEUg5i7dSfh6t9Rz6325VtS3sYomErzytiC+dsNjSRiMjBLQM9re7zknj50KUlf+xiIDk9qccJl
 JR703kxCmOkVpYci47V/FhsAF+bSPHZK5LRdBdxrYlNkh1gxuG5i669uBWWqtOZxc/ltSGe+bL6Vh
 gTndMB+2s42RCSEgjrqS1G/5mhukBX3pzUdzXqscFSl2cueBNS6OpLvS+WcBNedL5sLjKCRV3D7g+
 iXvkc+cDRJT1FhJP9AfvZwz3SAB/A3zK+l6b7Pe1ulALey6NRCySKV3uFBO5WviASfEwMF+hOaFLj
 9YOI+ZKtFT8yztot0A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr3sm-006Lww-26;
 Wed, 18 Sep 2024 23:14:48 +0000
From: dave@treblig.org
To: jiri@resnulli.us,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hw/net/rocker: Remove unused rocker_fp_ports
Date: Thu, 19 Sep 2024 00:14:47 +0100
Message-ID: <20240918231447.458796-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

rocker_fp_ports hasn't been used since it was added back in 2015.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/net/rocker/rocker.c | 5 -----
 hw/net/rocker/rocker.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 1ab5852113..5e74acc969 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -134,11 +134,6 @@ RockerPortList *qmp_query_rocker_ports(const char *name, Error **errp)
     return list;
 }
 
-uint32_t rocker_fp_ports(Rocker *r)
-{
-    return r->fp_ports;
-}
-
 static uint32_t rocker_get_pport_by_tx_ring(Rocker *r,
                                             DescRing *ring)
 {
diff --git a/hw/net/rocker/rocker.h b/hw/net/rocker/rocker.h
index f85354d9d1..6e0962f47a 100644
--- a/hw/net/rocker/rocker.h
+++ b/hw/net/rocker/rocker.h
@@ -72,7 +72,6 @@ DECLARE_INSTANCE_CHECKER(Rocker, ROCKER,
                          TYPE_ROCKER)
 
 Rocker *rocker_find(const char *name);
-uint32_t rocker_fp_ports(Rocker *r);
 int rocker_event_link_changed(Rocker *r, uint32_t pport, bool link_up);
 int rocker_event_mac_vlan_seen(Rocker *r, uint32_t pport, uint8_t *addr,
                                uint16_t vlan_id);
-- 
2.46.0


