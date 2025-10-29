Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3FBCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE50J-0005M1-1M; Wed, 29 Oct 2025 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xl-0003PY-16
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xL-00054x-6V
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtAAnCMnWfQp6D27CSN/aCx9dp2ZDJqLGDcQmHk6UmY=;
 b=I1DFxX9vH/5gZQDuyj7R7tb8sRftIMyzG7DtNNdNUvH3yw9TMSDXf9RBmYBOiaitCfyUhl
 kIWc2ZjcVXeZ5EcTuGwxqNQKqHjZSL+IloRHW+tpFEMr03zqNerbF9HP37YvvtrH9fPK6H
 WFepMeGztoxg53OfygXONYaZofI05xI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-dHTALuoZNJWQ3tVmJGj0gA-1; Wed,
 29 Oct 2025 08:07:06 -0400
X-MC-Unique: dHTALuoZNJWQ3tVmJGj0gA-1
X-Mimecast-MFC-AGG-ID: dHTALuoZNJWQ3tVmJGj0gA_1761739626
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB8A1809A04; Wed, 29 Oct 2025 12:07:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF11A180057C; Wed, 29 Oct 2025 12:07:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/18] block: Improve comments in BlockLimits
Date: Wed, 29 Oct 2025 13:06:31 +0100
Message-ID: <20251029120634.288467-16-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Patches to expose the limits in QAPI have made clear that the existing
documentation of BlockLimits could be improved: The meaning of
min_mem_alignment and opt_mem_alignment could be clearer, and talking
about better alignment values isn't helpful when we only detect these
values and never choose them.

Make the changes in the BlockLimits documentation now, so that the
patches exposing the fields in QAPI can use descriptions consistent with
it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251024123041.51254-2-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index c55b35da8e..f2a4e863fc 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -817,10 +817,10 @@ typedef struct BlockLimits {
     int64_t max_pdiscard;
 
     /*
-     * Optimal alignment for discard requests in bytes. A power of 2
-     * is best but not mandatory.  Must be a multiple of
-     * bl.request_alignment, and must be less than max_pdiscard if
-     * that is set. May be 0 if bl.request_alignment is good enough
+     * Optimal alignment for discard requests in bytes. Note that this doesn't
+     * have to be a power of two. Must be a multiple of bl.request_alignment,
+     * and must be less than max_pdiscard if that is set. May be 0 if
+     * bl.request_alignment is good enough.
      */
     uint32_t pdiscard_alignment;
 
@@ -831,11 +831,10 @@ typedef struct BlockLimits {
     int64_t max_pwrite_zeroes;
 
     /*
-     * Optimal alignment for write zeroes requests in bytes. A power
-     * of 2 is best but not mandatory.  Must be a multiple of
-     * bl.request_alignment, and must be less than max_pwrite_zeroes
-     * if that is set. May be 0 if bl.request_alignment is good
-     * enough
+     * Optimal alignment for write zeroes requests in bytes. Note that this
+     * doesn't have to be a power of two. Must be a multiple of
+     * bl.request_alignment, and must be less than max_pwrite_zeroes if that is
+     * set. May be 0 if bl.request_alignment is good enough.
      */
     uint32_t pwrite_zeroes_alignment;
 
@@ -863,18 +862,23 @@ typedef struct BlockLimits {
     uint64_t max_hw_transfer;
 
     /*
-     * Maximal number of scatter/gather elements allowed by the hardware.
+     * Maximum number of scatter/gather elements allowed by the hardware.
      * Applies whenever transfers to the device bypass the kernel I/O
      * scheduler, for example with SG_IO.  If larger than max_iov
      * or if zero, blk_get_max_hw_iov will fall back to max_iov.
      */
     int max_hw_iov;
 
-
-    /* memory alignment, in bytes so that no bounce buffer is needed */
+    /*
+     * Minimal required memory alignment in bytes for zero-copy I/O to succeed.
+     * For unaligned requests, a bounce buffer will be used.
+     */
     size_t min_mem_alignment;
 
-    /* memory alignment, in bytes, for bounce buffer */
+    /*
+     * Optimal memory alignment in bytes. This is the alignment used for any
+     * buffer allocations QEMU performs internally.
+     */
     size_t opt_mem_alignment;
 
     /* maximum number of iovec elements */
-- 
2.51.0


