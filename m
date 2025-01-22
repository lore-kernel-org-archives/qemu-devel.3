Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8D7C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 21:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tai9O-0001mP-6m; Wed, 22 Jan 2025 16:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tai9N-0001mF-CJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 16:20:37 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tai9L-00059r-Ks
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 16:20:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 896D2A4299D;
 Wed, 22 Jan 2025 21:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD3EC4CED2;
 Wed, 22 Jan 2025 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737580830;
 bh=Bl/q/A7gkrSKc73DKlkSo8lPVvD0GN8eoIkREP3mRsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V+8EejQURMYN/GMCKUXWc12RAOdojjk+15orhnx4ZEFjJaHAgEjaOHklr6Dqr1qaF
 a1yTNsVOb5LsjNGrLfo+mmDuBSqTkhu7gRirBCWZ/cHezyHQrzL+aRbF4tdoMgC1wo
 O4UKOdueXUCHAglLA4OvA/GtsNK0OQE98xAXUA2lj7ZY3Xgj0MWzaFewcREGOsYnPy
 V2uiZo7PiEZXKlUQ4cclL9POnos1TF0uBGDKy9LPYj8mPBEEd4DPGGgApV+/liQ/bm
 aXrdrbBh4+tvm24haMmY+k3LxzIC0whiQsZ83/Su6GvadmBlImkLWrhN+nTwrwXlPO
 FGVe46JA1SQew==
Date: Wed, 22 Jan 2025 22:20:26 +0100
From: Helge Deller <deller@kernel.org>
To: Laurent Vivier <laurent@vivier.eu>, linux-parisc@vger.kernel.org
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, deller@gmx.de
Subject: Re: [PATCH v4 1/7] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Message-ID: <Z5FhGi9HD0GzLbjQ@p100>
References: <20250120213340.359195-1-deller@kernel.org>
 <20250120213340.359195-2-deller@kernel.org>
 <fa016fb1-1f24-4e03-876e-58b4a0296962@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa016fb1-1f24-4e03-876e-58b4a0296962@vivier.eu>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

* Laurent Vivier <laurent@vivier.eu>:
> [...]
> It would be cleaner to replace all the IFA_XXX by their QEMU_IFA_XXX.

Thanks for review, Laurent!

Below I've merged patch #1 and #7, as suggested by you.
Is this OK?
Can you review?

Thanks!
Helge
________________________________________

From: Helge Deller <deller@gmx.de>
Date: Mon, 20 Jan 2025 22:20:41 +0100
Subject: [PATCH] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()

Fix this warning:
 Unknown host IFA type: 11

While adding IFA_PROTO, convert all IFA_XXX values over to QEMU_IFA_XXX values
to avoid a build failure on Ubuntu 22.04 (kernel v5.18 which does not know
IFA_PROTO yet).

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c04a97c73a..2e714c8e56 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -31,6 +31,22 @@
 #include "fd-trans.h"
 #include "signal-common.h"
 
+enum {
+    QEMU_IFA_UNSPEC,
+    QEMU_IFA_ADDRESS,
+    QEMU_IFA_LOCAL,
+    QEMU_IFA_LABEL,
+    QEMU_IFA_BROADCAST,
+    QEMU_IFA_ANYCAST,
+    QEMU_IFA_CACHEINFO,
+    QEMU_IFA_MULTICAST,
+    QEMU_IFA_FLAGS,
+    QEMU_IFA_RT_PRIORITY,
+    QEMU_IFA_TARGET_NETNSID,
+    QEMU_IFA_PROTO,
+    QEMU__IFA__MAX,
+};
+
 enum {
     QEMU_IFLA_BR_UNSPEC,
     QEMU_IFLA_BR_FORWARD_DELAY,
@@ -1138,20 +1154,21 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
 
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case IFA_ADDRESS:
-    case IFA_LOCAL:
+    case QEMU_IFA_ADDRESS:
+    case QEMU_IFA_LOCAL:
+    case QEMU_IFA_PROTO:
         break;
     /* string */
-    case IFA_LABEL:
+    case QEMU_IFA_LABEL:
         break;
     /* u32 */
-    case IFA_FLAGS:
-    case IFA_BROADCAST:
+    case QEMU_IFA_FLAGS:
+    case QEMU_IFA_BROADCAST:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
     /* struct ifa_cacheinfo */
-    case IFA_CACHEINFO:
+    case QEMU_IFA_CACHEINFO:
         ci = RTA_DATA(rtattr);
         ci->ifa_prefered = tswap32(ci->ifa_prefered);
         ci->ifa_valid = tswap32(ci->ifa_valid);
@@ -1398,8 +1415,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
 {
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case IFA_LOCAL:
-    case IFA_ADDRESS:
+    case QEMU_IFA_LOCAL:
+    case QEMU_IFA_ADDRESS:
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Unknown target IFA type: %d\n",

