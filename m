Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06228606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnrROFb5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DXsq2eLX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Ec-00054b-Hl; Wed, 28 Oct 2026 13:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7E1-0004ou-KU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Dz-0003R2-Vh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gsYpqqNsWCDbPhmHvOVJ9XTiCUpe2ciD0w9tmZpqsBk=;
 b=dnrROFb52dvRwm+p+4WBNT5ql2NorAR6aGOkiHerbrE5lwRzUjhZCfk4GO5qSTE7BePL6Q
 dC2W5+8aQKsVpaZCd0SLeqooQftzj3d0nhYCCEtg/PqYcKRnIqeBhClL1V7+BkaZWUP7Ey
 HkccsQzoBsNhCXA36amPvlHS9FbE8Wk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-xaZ5YVhIOQq4UBNJmBJfvw-1; Wed, 28 Oct 2026 13:13:59 -0400
X-MC-Unique: xaZ5YVhIOQq4UBNJmBJfvw-1
X-Mimecast-MFC-AGG-ID: xaZ5YVhIOQq4UBNJmBJfvw_1793207638
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48df02b91f9so1536161f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207638; x=1793812438; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gsYpqqNsWCDbPhmHvOVJ9XTiCUpe2ciD0w9tmZpqsBk=;
 b=DXsq2eLXrGyjX2BmxLTS6EZkplxiLe0/3uE+cWpZ6AR+YRjDnkCLMhBIQ92S2Te+bO
 oChkXDuipGZhduI0MYckmK5d4CowLFAuqCOZMzEi+HAG2b/hPu7X3a+nYq4JuZXZm+ZP
 hFn2XFVY+04eLtihDsEj8tT8nqP4YOPLTVgK5XoWdqyPQwxZzLJ9EgBkYx6Yx0EBL5ta
 /hqXYW+BcOa7GmhxHrVrzlJQX9nPCWCjJhgjikSPJuJ49kGnUHTygpGCRkbf6FlDOLVY
 z6Jj6vx7IyEGPjrP7CWy0/i5gDssLi942DuCQuywTTboo9ONsvQ6bWaIYh/Cf8IEIcRq
 ep/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207638; x=1793812438;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gsYpqqNsWCDbPhmHvOVJ9XTiCUpe2ciD0w9tmZpqsBk=;
 b=zkqbSlelFmrFX/SH+hHiLWfCSvR8G4LVSdd5CZeTLKNJr/7SaQudtCfXTWwr5VrMqx
 Hhd3ivNKGpn2ja6bR68WK+ak0arrEWAg8JmJfWE3r5tGz01MzYDQMxF8bzf3WDEhj7/t
 yBkT/8fqmnSsi5HqcN9J2poZdbGBhxPM5oyrBo6ctDcps0nVYmO5RcU43O6dJjq/tFBL
 Qqnqz3VOId5OO6WUSrXrlpgkS91QziRI1H1UtbCpnW+FVdp7YzcDpcwZllD+d9W7X150
 PQj0K9HV0gGKm6N0ljWPH9mTXDvls8fJzsM2bDXgDS0sQfSRl/5azuFX2vRLbvDqRMZz
 L4fg==
X-Gm-Message-State: AFq9FYK2l0vpDPDvBTRW94h3i40fxWNf6hbZJZtbILnzKHwc4mwxsK3W
 w5Ca4eocCsBOlp4yG0W0apdxyOcgyJLog2VQuIfK+oBELcXC3khBnc13STsb8ABmU6HqRUNJFkk
 SdzTKVTQl3lzm5tEkvKlJk/drvO43TxKnb5ge7ScY+KG1VY/8pI5IQ2emHY5WdI/zfvk86k5Y06
 z8L2o13WDrB+W81f5CACSAX0ZGxWfymnxshA==
X-Gm-Gg: AYBFou0Y/g2xZLBdoD/n1+glYO9xE66blzRq7hVWRrJFravSo0sZiYRAhqBNng2AGBN
 jaRhaKkro8IB60YyKOWJyuvpUYTrVceD4xaMVDJOsPKLfc/gDGVlwMlD6FfAzjJpoXQfy2jVm8q
 bi5fjxIwjURzcu4HnOIvNpbkmKGm3R4DzxvCsrW6Ixw5SWPmzGhCqoxtQ2GXZll0BYfUETv7CyX
 uL51cPGCmLuD0hA8MfH/R9/8T3XArd4FBnemtR7cXVgF9IEopjJn8PUo5qy8h8Lc8ImGYk1dhLK
 iV01yXX65VdXaO9J6cJ1UOdmCOORlouqMK1cges3neVEUWZTFkT/hwpqoWqGdzH2cGB2qWEXptL
 zCREKKtkmuyc51ob3Wsr7GfOdHpcBkykM3cdmwYtS
X-Received: by 2002:a05:6000:98b:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48e64945b11mr612263f8f.3.1793207638277; 
 Wed, 28 Oct 2026 10:13:58 -0700 (PDT)
X-Received: by 2002:a05:6000:98b:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48e64945b11mr612173f8f.3.1793207637644; 
 Wed, 28 Oct 2026 10:13:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3418sm26513824f8f.41.2026.10.28.10.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:13:57 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:13:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Omer Can Vural <can.omer.5306@outlook.com>, vhost-user@lists.linux.dev
Subject: [PULL 01/78] libvhost-user: protect against OOB memory table access
Message-ID: <d033951e563397b3f6a7162e3de6bd90dcc770e9.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SET_MEM_TABLE handler uses nregions from the message as a loop
bound without checking that it is below VHOST_MEMORY_BASELINE_NREGIONS,
so a malformed message causes an out-of-bounds access to the
regions[] and fds[] arrays.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f42f ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4403
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: Omer Can Vural <can.omer.5306@outlook.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <8adc88f2f535ab0566a5df1c66db728112dd6f74.1789469161.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2fed792e85..52817cc733 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1105,6 +1105,13 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     vu_remove_all_mem_regs(dev);
 
     DPRINT("Nregions: %u\n", memory->nregions);
+
+    if (memory->nregions > VHOST_MEMORY_BASELINE_NREGIONS) {
+        vu_panic(dev, "Invalid set_mem_table nregions: %u > %u",
+                 memory->nregions, VHOST_MEMORY_BASELINE_NREGIONS);
+        return false;
+    }
+
     for (i = 0; i < memory->nregions; i++) {
         _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
         close(vmsg->fds[i]);
-- 
MST


