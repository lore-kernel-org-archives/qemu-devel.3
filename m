Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsDC0ltJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWQka-0004XQ-89; Wed, 25 Nov 2026 23:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOoY-0008OM-Ob; Wed, 25 Nov 2026 21:02:24 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOoX-0006dd-0l; Wed, 25 Nov 2026 21:02:22 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7F7060234;
 Thu, 26 Nov 2026 02:02:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795658536;
 b=i8tL3LezcKNxFbEXayu6nK+asQ0TCczsWSaYmpY8GfKEy23DAnB9D78Ktju5yNYUMKaW
 uahtWlyvtcRZjPWSi2wqFOYW6gKr5xNDBzFjMR0kGubjWlVxGTepRLHrU94Vy3enI48sJ
 0aR3UCHB2He79C4WZJq6ymkagwP7Gsq7yXD+OUpg6x0QvHKNJSZ6NIaw4ydjgJ+IN8yKD
 eaSd3YeKKynpCtieyO6gDRtVSEzADp8gfojjCK0shkBWNyOKrnJbSg5X85Q7ZYH4gyWfX
 MAK8uxuQbutgOWIU1ey/cVZMrPykx8XKmDu1kJ3CsR2OfK0xlgcWY4OANonSXlo/FhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795658536;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=lz5B1/pYN52nUQdXvSehhsMOR+cpHCwwoplpPzcIHqs=;
 b=jJVkSwiRfASIeyjdS3AXeMlPLqZ+fhlTrcq92MpS69+9hbjLwdujUEp44oRrSld8kOnY
 62N0acQa4PYIDOIGpKlQFR4pq3lu39JclpLJJIKJlO/wJAs5IgXIV2kk1Mdm+IF1bafRT
 uaRa9KuxBeH6k4aKLUg1kbusiYbHcagBbXEKvCij3vttCwvYINRCr6YE2K0LTwYWk/jRv
 B/7lHYW9urRKuK1UbSiqZhxT1K7MNZcEp8VzuCPYWkKjNvvDZ4qQ+gPDXmiPBWvhTvFWO
 sKTgphnJjwo5oTg7P5QoZF1Ls81ew9EQx8t30+wo4Jt0hENh9rY9AUSL8g89oHKetiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 76F141F000CF;
 Thu, 26 Nov 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795658536;
 bh=lz5B1/pYN52nUQdXvSehhsMOR+cpHCwwoplpPzcIHqs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=JsDC0ltJC1BlxKxaZPUi2iLZrLlO+IEZ/+IP66ipxBBjW4AlY4xXXd0YKaA7x3r30
 jgcmm8Rr0pmVtdbShDSsNNRPfSQPfWmHf1OIIcf4Fpn5ONHjR4qnL0NVtCttDOo2iB
 iifLbjuFQNB0ttdq6sGuAbyiV2kts1kdTvDXUxeRNyYao6hMAdyK5cfmhli/0N1iaF
 unxw39OOvGExw7hgMlUS1RxD6dUCxUVtznl2VPw4jc+lk552JpMoUeFrn3glDTzX3d
 mFbyz3Q51+V66NZqTmZv8lmazHrSha2d2yPpeu0oEjz+cb4UltKp83AgkvEI92fvjA
 futYX50qOb5qw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F37C94D180;
 Thu, 26 Nov 2026 02:02:10 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Thu, 26 Nov 2026 11:02:09 +0900
Subject: [PATCH v4 1/5] block: add an accessor for the active zone limit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-zoned-ufs-v4b-v4-1-f90239d12a55@samsung.com>
References: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
In-Reply-To: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stanley Jhu <stanleyjhu@google.com>, 
 Keoseong Park <keosung.park@samsung.com>, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795658528; l=1796;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=TBiFpQFT/9RXsABdcgs7OOsn9LXZG6k+QhQ33mxHGPc=;
 b=xyA/YlLPKFFMXWspm2MVtP0IZK8h1oSznI7SAdADwQe+GKbGf8ueQo9EBaoN8BbnfRJzlppVF
 Xq1UziodUyaD7mrlRiyoQ7GB1FVdUiphNQlzT3Uz6AxgY7jWt4R7YON
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=devnull+daejun7.park.samsung.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 23:06:16 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

Add blk_get_max_active_zones() next to blk_get_max_open_zones(). A
device model whose protocol cannot report an active zone limit, such as
ZBC, needs it to reject a backend whose limit a guest could reach.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 block/block-backend.c             | 11 +++++++++++
 include/system/block-backend-io.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 397ec9ed5a..1e591a81b9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2371,6 +2371,17 @@ uint64_t blk_get_zone_capacity(BlockBackend *blk)
     return bs ? bs->bl.zone_capacity : 0;
 }
 
+/*
+ * Returns the maximum number of active zones of a zoned backend, or 0 if
+ * there is no limit or @blk is not zoned.
+ */
+uint32_t blk_get_max_active_zones(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.max_active_zones : 0;
+}
+
 /* Returns the optimal write zeroes alignment, in bytes; guaranteed nonzero */
 uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
 {
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index 7c958843b4..aa6303c8a1 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -125,6 +125,7 @@ uint64_t blk_get_zone_size(BlockBackend *blk);
 BlockZoneModel blk_get_zone_model(BlockBackend *blk);
 uint32_t blk_get_max_open_zones(BlockBackend *blk);
 uint64_t blk_get_zone_capacity(BlockBackend *blk);
+uint32_t blk_get_max_active_zones(BlockBackend *blk);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,

-- 
2.43.0



