Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC42CE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeAN-0004EZ-02; Wed, 08 Jan 2025 17:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAK-0004EG-9t
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:40 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAI-0006QV-A3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DFDDAA41C6E;
 Wed,  8 Jan 2025 22:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3852BC4CEDF;
 Wed,  8 Jan 2025 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736373877;
 bh=lZEjJ4XbotEJNSOPinIq1O73m1AqWJPsAYAqUEoSv38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SEgQR1s8tElFeNGhQ+q7dxeeCs+/wnm75jKx7jp60LrIdsTxNPeiH0I38tXbS+/mw
 1lPDmlZMKdVwcVuKjYXS3dxsaUCwGJzR3WgfmHQaP6LUpuj8d+HPQsWLQc3JcP+/Aq
 J08SSRnETd0OdiZ4dYqSbP60s3MkXT8Sko6UKCwLCo59i5hdFk9ksDCnwgwB2m/aQL
 4m5vyvkEaxqGuIT0rCxHrtOgXWmO3EJX9YAnJL7lm7sTPxdzcRNmmOdSX7mD8CcMn3
 aRtMPDnj50kwNn+noMcEzPtfQ35U8zP4LQ0S/Atatdk4HMqtYYxDJnxrlN7vYb5nn2
 Qt6VeVfMG+r5A==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v2 6/6] linux-user: netlink: Add missing QEMU_IFLA entries
Date: Wed,  8 Jan 2025 23:04:22 +0100
Message-ID: <20250108220422.169967-7-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108220422.169967-1-deller@kernel.org>
References: <20250108220422.169967-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

This fixes the following qemu warnings when building debian gupnp package:
 Unknown host QEMU_IFLA type: 61
 Unknown host QEMU_IFLA type: 58
 Unknown host QEMU_IFLA type: 59
 Unknown host QEMU_IFLA type: 60
 Unknown host QEMU_IFLA type: 32820

QEMU_IFLA type 32820 is actually NLA_NESTED | QEMU_IFLA_PROP_LIST (a nested
entry), which is why rta_type needs to be masked with NLA_TYPE_MASK.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/fd-trans.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index a5e6c6b6f2..6a8775bb55 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -145,6 +145,14 @@ enum {
     QEMU_IFLA_PROTO_DOWN_REASON,
     QEMU_IFLA_PARENT_DEV_NAME,
     QEMU_IFLA_PARENT_DEV_BUS_NAME,
+    QEMU_IFLA_GRO_MAX_SIZE,
+    QEMU_IFLA_TSO_MAX_SIZE,
+    QEMU_IFLA_TSO_MAX_SEGS,
+    QEMU_IFLA_ALLMULTI,
+    QEMU_IFLA_DEVLINK_PORT,
+    QEMU_IFLA_GSO_IPV4_MAX_SIZE,
+    QEMU_IFLA_GRO_IPV4_MAX_SIZE,
+    QEMU_IFLA_DPLL_PIN,
     QEMU___IFLA_MAX
 };
 
@@ -986,6 +994,22 @@ static abi_long host_to_target_data_vfinfo_nlattr(struct nlattr *nlattr,
     return 0;
 }
 
+static abi_long host_to_target_data_prop_nlattr(struct nlattr *nlattr,
+                                                void *context)
+{
+    switch (nlattr->nla_type) {
+    /* string */
+    case QEMU_IFLA_ALT_IFNAME:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unknown host PROP type: %d\n",
+                      nlattr->nla_type);
+        break;
+    }
+    return 0;
+}
+
+
 static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
 {
     uint32_t *u32;
@@ -994,7 +1018,7 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
     struct rtnl_link_ifmap *map;
     struct linkinfo_context li_context;
 
-    switch (rtattr->rta_type) {
+    switch (rtattr->rta_type & NLA_TYPE_MASK) {
     /* binary stream */
     case QEMU_IFLA_ADDRESS:
     case QEMU_IFLA_BROADCAST:
@@ -1032,6 +1056,12 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
     case QEMU_IFLA_CARRIER_DOWN_COUNT:
     case QEMU_IFLA_MIN_MTU:
     case QEMU_IFLA_MAX_MTU:
+    case QEMU_IFLA_GRO_MAX_SIZE:
+    case QEMU_IFLA_TSO_MAX_SIZE:
+    case QEMU_IFLA_TSO_MAX_SEGS:
+    case QEMU_IFLA_ALLMULTI:
+    case QEMU_IFLA_GSO_IPV4_MAX_SIZE:
+    case QEMU_IFLA_GRO_IPV4_MAX_SIZE:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
@@ -1127,6 +1157,10 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
         return host_to_target_for_each_nlattr(RTA_DATA(rtattr), rtattr->rta_len,
                                               NULL,
                                              host_to_target_data_vfinfo_nlattr);
+    case QEMU_IFLA_PROP_LIST:
+        return host_to_target_for_each_nlattr(RTA_DATA(rtattr), rtattr->rta_len,
+                                              NULL,
+                                             host_to_target_data_prop_nlattr);
     default:
         qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA type: %d\n",
                       rtattr->rta_type);
-- 
2.47.0


