Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C9CCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 10:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stloK-00040f-Sl; Thu, 26 Sep 2024 06:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66f53402.v1-bed7b4e8d2e64ca6923f6d14752892a7@bounce.vates.tech>)
 id 1stloJ-0003vc-7n
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:33:23 -0400
Received: from mail136-20.atl41.mandrillapp.com ([198.2.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66f53402.v1-bed7b4e8d2e64ca6923f6d14752892a7@bounce.vates.tech>)
 id 1stloH-0002B9-9w
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1727345667; x=1727606167;
 bh=v3B/Sq5q797M597CcyjXUiFgMC2JpYVkeXzk/0VKvek=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=tp4PIaaIl69Ttun2mNGvvB5A61t+EhtSwSsVvqLwiL5B7uZoWd0uqGre7CRd+xv+X
 9aiqKbbK+fmWzod7/ybr1RDcLDixpzctIn9S+3Rl9QVWzEceuuf3tDUGY9cMrP0vZB
 Cz8alBkd9/1nKAS8licKkP5Vp/4jVFZJcdm2HUgvV5v8XfzMqeL/texwM7Zm8gMs7x
 pZbcDSxkpNmpURHqgkVrIlaVlvhwZXu+BuL1pzQqOSp1C7kaj7gsB+oJYv8rjpXGU6
 mPlvqFS5jjWi4B67MGFqXRyerlCixikTQBZ5SjG8VVbLdwXG47H2+HtVnRQTnGEj0j
 R8MD2xoQcaheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1727345667; x=1727606167; i=anthony.perard@vates.tech;
 bh=v3B/Sq5q797M597CcyjXUiFgMC2JpYVkeXzk/0VKvek=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=JFzeOgt+OvofUo8sxjJQGQA4x58mgj2gGF5E0wMN5NsOyevINP8sScBBBnlUjOn7u
 uPg1kewvMgLaoodpraIUfBGSrEq3owXOARAqXUE2mP83Zw3GFZ1llxhKq2DXOW+xx6
 adHUn3pcER6S1JDkNvAAo93PHjqUUZtf9QaxeUmlTU2IDcTBrA+YKACG49LIuuUW+z
 a44rRBI6RwpYZLkvDB4Gu8xW85XKbh5lLsPSbk3X0mpTDYwN8U9VUGNKNl2qxo0eLE
 2TWApaFygskt+/egL0rdWGX7xEqZvsIrKpdDMiBo25DCcLktu/hrGT/IJQRf4SBO6a
 R5EJktSuC0pUQ==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail136-20.atl41.mandrillapp.com (Mailchimp) with ESMTP id
 4XDqFt74XgzCfBkVf
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 10:14:26 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PATCH=201/2]=20include:=20update=20Xen=20public=20headers=20io/blkif.h?=
Received: from [37.26.189.201] by mandrillapp.com id
 bed7b4e8d2e64ca6923f6d14752892a7; Thu, 26 Sep 2024 10:14:26 +0000
X-Mailer: git-send-email 2.39.2
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1727345665475
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@vates.tech>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org
Message-Id: <20240926101334.2388-2-anthony.perard@vates.tech>
In-Reply-To: <20240926101334.2388-1-anthony.perard@vates.tech>
References: <20240926101334.2388-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.bed7b4e8d2e64ca6923f6d14752892a7?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240926:md
Date: Thu, 26 Sep 2024 10:14:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.136.20;
 envelope-from=bounce-md_30504962.66f53402.v1-bed7b4e8d2e64ca6923f6d14752892a7@bounce.vates.tech;
 helo=mail136-20.atl41.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 include/hw/xen/interface/io/blkif.h | 52 +++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 22f1eef0c0..9b00d633d3 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -237,12 +237,16 @@
  * sector-size
  *      Values:         <uint32_t>
  *
- *      The logical block size, in bytes, of the underlying storage. This
- *      must be a power of two with a minimum value of 512.
+ *      The logical block size, in bytes, of the underlying storage. This must
+ *      be a power of two with a minimum value of 512.  The sector size should
+ *      only be used for request segment length and alignment.
  *
- *      NOTE: Because of implementation bugs in some frontends this must be
- *            set to 512, unless the frontend advertizes a non-zero value
- *            in its "feature-large-sector-size" xenbus node. (See below).
+ *      When exposing a device that uses a logical sector size of 4096, the
+ *      only difference xenstore wise will be that 'sector-size' (and possibly
+ *      'physical-sector-size' if supported by the backend) will be 4096, but
+ *      the 'sectors' node will still be calculated using 512 byte units.  The
+ *      sector base units in the ring requests fields will all be 512 byte
+ *      based despite the logical sector size exposed in 'sector-size'.
  *
  * physical-sector-size
  *      Values:         <uint32_t>
@@ -254,9 +258,9 @@
  * sectors
  *      Values:         <uint64_t>
  *
- *      The size of the backend device, expressed in units of "sector-size".
- *      The product of "sector-size" and "sectors" must also be an integer
- *      multiple of "physical-sector-size", if that node is present.
+ *      The size of the backend device, expressed in units of 512b.  The
+ *      product of "sectors" * 512 must also be an integer multiple of
+ *      "physical-sector-size", if that node is present.
  *
  *****************************************************************************
  *                            Frontend XenBus Nodes
@@ -338,6 +342,7 @@
  * feature-large-sector-size
  *      Values:         0/1 (boolean)
  *      Default Value:  0
+ *      Notes:          DEPRECATED, 12
  *
  *      A value of "1" indicates that the frontend will correctly supply and
  *      interpret all sector-based quantities in terms of the "sector-size"
@@ -411,6 +416,11 @@
  *(10) The discard-secure property may be present and will be set to 1 if the
  *     backing device supports secure discard.
  *(11) Only used by Linux and NetBSD.
+ *(12) Possibly only ever implemented by the QEMU Qdisk backend and the Windows
+ *     PV block frontend.  Other backends and frontends supported 'sector-size'
+ *     values greater than 512 before such feature was added.  Frontends should
+ *     not expose this node, neither should backends make any decisions based
+ *     on it being exposed by the frontend.
  */
 
 /*
@@ -619,11 +629,14 @@
 #define BLKIF_MAX_INDIRECT_PAGES_PER_REQUEST 8
 
 /*
- * NB. 'first_sect' and 'last_sect' in blkif_request_segment, as well as
- * 'sector_number' in blkif_request, blkif_request_discard and
- * blkif_request_indirect are sector-based quantities. See the description
- * of the "feature-large-sector-size" frontend xenbus node above for
- * more information.
+ * NB. 'first_sect' and 'last_sect' in blkif_request_segment are all in units
+ * of 512 bytes, despite the 'sector-size' xenstore node possibly having a
+ * value greater than 512.
+ *
+ * The value in 'first_sect' and 'last_sect' fields must be setup so that the
+ * resulting segment offset and size is aligned to the logical sector size
+ * reported by the 'sector-size' xenstore node, see 'Backend Device Properties'
+ * section.
  */
 struct blkif_request_segment {
     grant_ref_t gref;        /* reference to I/O buffer frame        */
@@ -634,6 +647,10 @@ struct blkif_request_segment {
 
 /*
  * Starting ring element for any I/O request.
+ *
+ * The 'sector_number' field is in units of 512b, despite the value of the
+ * 'sector-size' xenstore node.  Note however that the offset in
+ * 'sector_number' must be aligned to 'sector-size'.
  */
 struct blkif_request {
     uint8_t        operation;    /* BLKIF_OP_???                         */
@@ -648,6 +665,10 @@ typedef struct blkif_request blkif_request_t;
 /*
  * Cast to this structure when blkif_request.operation == BLKIF_OP_DISCARD
  * sizeof(struct blkif_request_discard) <= sizeof(struct blkif_request)
+ *
+ * The 'sector_number' field is in units of 512b, despite the value of the
+ * 'sector-size' xenstore node.  Note however that the offset in
+ * 'sector_number' must be aligned to 'sector-size'.
  */
 struct blkif_request_discard {
     uint8_t        operation;    /* BLKIF_OP_DISCARD                     */
@@ -660,6 +681,11 @@ struct blkif_request_discard {
 };
 typedef struct blkif_request_discard blkif_request_discard_t;
 
+/*
+ * The 'sector_number' field is in units of 512b, despite the value of the
+ * 'sector-size' xenstore node.  Note however that the offset in
+ * 'sector_number' must be aligned to 'sector-size'.
+ */
 struct blkif_request_indirect {
     uint8_t        operation;    /* BLKIF_OP_INDIRECT                    */
     uint8_t        indirect_op;  /* BLKIF_OP_{READ/WRITE}                */
-- 


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

