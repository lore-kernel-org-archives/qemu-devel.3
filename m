Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8348DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0GtE-0002uf-Ts; Thu, 03 Apr 2025 05:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1u0GtC-0002u7-OV
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:29:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1u0Gt6-0000re-PL
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:29:34 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250403092142epoutp010286aa03b6441f9534711e2a4bfab13a~yxInjehnH0245602456epoutp01c
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 09:21:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250403092142epoutp010286aa03b6441f9534711e2a4bfab13a~yxInjehnH0245602456epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1743672102;
 bh=GRJ5SS0ceFZ6u/WGNw9HoPV2P9q+zrAFaXLxmXr3EUc=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=OhB0bYYSMk/44+HjUKbiyOzFrUomjRdxaRP49/jApKzWsOh8vIghdg9YLJZtX0Q9J
 Jhpvwkzf+Ft7y06tNYsl9kCo2RNScbitB+j4j56+J7rC8IzZhoGuZd+/h+9ZPXigUa
 4b38W0jcrRNz5QzlRgSnZYcl/ftm8QylknsvR3qE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20250403092141epcas2p398b352dd7b6f649371386e4289d43e55~yxInTU_jS1351813518epcas2p3b;
 Thu,  3 Apr 2025 09:21:41 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4ZSx7n2cgtz3hhT9; Thu,  3 Apr
 2025 09:21:41 +0000 (GMT)
X-AuditID: b6c32a45-9d3ff7000000263b-99-67ee53254ac6
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 36.DC.09787.5235EE76; Thu,  3 Apr 2025 18:21:41 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] hw/ufs: Fix incorrect comment for segment_size and
 allocation_unit_size
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250403092140epcms2p355a7f039871b3e5b409754ef450b9158@epcms2p3>
Date: Thu, 03 Apr 2025 18:21:40 +0900
X-CMS-MailID: 20250403092140epcms2p355a7f039871b3e5b409754ef450b9158
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmma5q8Lt0g559XBYvD2la3N96jdHi
 eO8OFgdmjyfXNjN59G1ZxRjAFJVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
 kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
 W1yal66Xl1piZWhgYGQKVJiQnfHq/DPmgl1cFcePPmNvYLzC0cXIySEhYCLx+fIH5i5GLg4h
 gR2MEvvWH2PvYuTg4BUQlPi7QxikRlggSuLatf+sILaQgJJE18KtzBBxA4l10/eA2WwCehJT
 ft9hBLFFBFQlXi3exAJiMwsYSyw5M5UdYhevxIz2pywQtrTE9uVbGSFsDYkfy3qZIWxRiZur
 37LD2O+PzYeqEZFovXcWqkZQ4sHP3YwgZ0oISEq8v6oIEa6XaH1/ih3kFQmBCYwSjcf+QM3R
 l7jWsRFsL6+Ar8SKCU1gc1iA7vy07TdUjYvEhTuNbBA3y0tsfzuHGWQ+s4CmxPpd+hCrlCWO
 3IL6ik+i4/BfuK8aNv7Gyt4x7wkThK0m8WjBFlYIW0bi4pxzzBMYlWYhwnkWkr2zEPYuYGRe
 xSiWWlCcm55abFRgCI/a5PzcTYzgxKbluoNx8tsPeocYmTgYDzFKcDArifAWar1NF+JNSays
 Si3Kjy8qzUktPsRoCvTxRGYp0eR8YGrNK4k3NLE0MDEzMzQ3MjUwVxLnPfTxabqQQHpiSWp2
 ampBahFMHxMHp1QDE0OwP8OUf2drHnp0rH8sEylZ8Ytv0gozBraOIt5it5iyep57Jx5O/vb4
 4YnZzZc7TJ5vvTct+9W+61Yyy0J9GGO/it6vNX06bRGzS9uFs7vk23tEOOfmJmZd/biJN4PJ
 qFmtp6Jyt9rZVSWT12kn/N/qvy+1jEu36uq1M6ze0908GZiP9L71Tcma/6jLo23D+iht5oOJ
 551DzcrzmjNXl0lesuhVS/o3t1dac8JplW8PTT/G+116WHkhQE2I93Gs+Ivqjst8omITun7J
 68902dqxsiTjkFrRxwNlqpc6tyXfPvK+yWJjS7VJvUlwoEWZUdAD2bnb/nurBW4p/9VZ8/ry
 ovumKukVvEf+r/+gxFKckWioxVxUnAgAjOwVlfUDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250403092140epcms2p355a7f039871b3e5b409754ef450b9158
References: <CGME20250403092140epcms2p355a7f039871b3e5b409754ef450b9158@epcms2p3>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=keosung.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The comments for segment_size and allocation_unit_size incorrectly
described them as 4KB. According to the UFS specification,
segment_size is expressed in units of 512 bytes.
Given segment_size = 0x2000 (8192), the actual size is 4MB.
Similarly, allocation_unit_size = 1 means 1 segment = 4MB.

This patch updates the comments to reflect the correct size.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 hw/ufs/ufs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ee13edacd8..542f13b10e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1753,8 +1753,8 @@ static void ufs_init_hc(UfsHc *u)
     u->geometry_desc.length = sizeof(GeometryDescriptor);
     u->geometry_desc.descriptor_idn = UFS_QUERY_DESC_IDN_GEOMETRY;
     u->geometry_desc.max_number_lu = (UFS_MAX_LUS == 32) ? 0x1 : 0x0;
-    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4KB */
-    u->geometry_desc.allocation_unit_size = 0x1; /* 4KB */
+    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4MB: 8192 * 512B */
+    u->geometry_desc.allocation_unit_size = 0x1; /* 4MB: 1 segment */
     u->geometry_desc.min_addr_block_size = 0x8; /* 4KB */
     u->geometry_desc.max_in_buffer_size = 0x8;
     u->geometry_desc.max_out_buffer_size = 0x8;
-- 
2.25.1


