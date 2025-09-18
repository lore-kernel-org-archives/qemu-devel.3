Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA4FCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzL88-0007Dh-An; Thu, 18 Sep 2025 16:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c921e5496f23221335bea0c9104364409cd0b2b8@kylie.crudebyte.com>)
 id 1uzL87-0007DZ-59
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:21:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c921e5496f23221335bea0c9104364409cd0b2b8@kylie.crudebyte.com>)
 id 1uzL7u-00038K-Du
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=tabMCwy7ZIrTCNu0YMYyNHd98OeNj4eDJXKYqrDHN2o=; b=ccLcy
 6U/SsmpRVjVd8dI+mqBGwLIrateW5YiV1OZkYOUXjQaCVi/95XMBr33tKin/JK4Rn4NehqNgMUm4r
 giNX7DoDCREdjOnjTTpwlqQmBv74itlWLxbmMIo4PR/c+7rFiqgSPeEd//HwBICvY54tv1keoq07+
 ZBTUf9uvnmwRvbrZHrYo5Ac1dKY5RG7QCvWwF1G7FZR9isYM5Ll8zD+ROPor6VgTLFICYRejlXt2B
 vYL48RJSbkmxizI15hvIrlfj00ZDLTh79qG8Oc0A7Hh6faX6t/oAOdX3Hc+RYgRyojX70auOnWh6n
 f7HSWDbf0M70/7m/GSTP2PBO5dm91Jj6FZwIUNZmdkn+oQve6nEnmlxYJ7KNZACC76VFOihPvgY75
 GL1vqg0PZuUcQXRA2O9p2GvC2ctW5k9XQP+tCzXg2sxCLNKfGuqBEYmBqI0vBhDtEHKChCnXBTwMo
 MGfZBaFyups/Kb+2XA/N4hZ0TEIn3x1R1mmUCr165T68y1KmzeuNbSaT/bIItg7vvNWwmk51opbRT
 TJkxKuv+5s6yRbNTOjc5Os5bEFF7cKIKTit8xbwSsBtRmRQ76SRto2YmJOTam1hbfD49qfP41eHiT
 nv8w25OIU5fVBaF0B0jQVavN3WEHs9gjsRkvVM9HiA+ZupYEJlrwLFhBOZ+T7E=;
Message-Id: <c921e5496f23221335bea0c9104364409cd0b2b8.1758224558.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1758224558.git.qemu_oss@crudebyte.com>
References: <cover.1758224558.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 18 Sep 2025 21:42:39 +0200
Subject: [PULL 2/2] 9pfs: Stop including gstrfuncs.h
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Peter Foley <pefoley@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c921e5496f23221335bea0c9104364409cd0b2b8@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
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

From: Peter Foley <pefoley@google.com>

gstrfuncs.h is not intended to be included directly.
In fact this only works because glib.h is already included by osdep.h.
Just remove the include.

Signed-off-by: Peter Foley <pefoley@google.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250905-9p-v2-1-2ad31999684d@google.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-util-generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
index 4c1e9c887d..b71fa2cb37 100644
--- a/hw/9pfs/9p-util-generic.c
+++ b/hw/9pfs/9p-util-generic.c
@@ -2,7 +2,6 @@
 
 #include "qemu/osdep.h"
 #include "9p-util.h"
-#include <glib/gstrfuncs.h>
 
 char *qemu_open_flags_tostr(int flags)
 {
-- 
2.39.5


