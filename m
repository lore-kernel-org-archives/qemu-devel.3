Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF19C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCDl-0007J0-Ry; Mon, 29 Jun 2026 09:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0e3085ddc7fb137b727829913c20ad9d08577bdb@kylie.crudebyte.com>)
 id 1weCDk-0007Ht-VD; Mon, 29 Jun 2026 09:40:20 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0e3085ddc7fb137b727829913c20ad9d08577bdb@kylie.crudebyte.com>)
 id 1weCDj-0004pf-9n; Mon, 29 Jun 2026 09:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=JFJiWtJxyrEw3flRMhi/G/BAccH/foEXolMe42jdQ+k=; b=irLz8
 5/WwLPFfe7nbjfj9aY3GE6vxNlnUTpLjyi5FVJvZKeMRe0QtKkaMnr9RIR1lRjDMR5/u5sFwewNJx
 XV1CCAJwqLITBRL+zuohhw5bFT4LsItrFuZMM0ueSqppAEEWfX653VyVa4yi+5ykuaCR5x3VicbFM
 wGgeMk3R+me//juA177Qy7vigspaOpBGfHr9+VDTEF1d4n24mLeyIjPyUPw7NoupEEprPobSodY4Y
 8YSEi2Uc9iMQwinn3uKQBdJ+k96y62H3N5KyyJIbFe5MGaDfg5Aq/+9F1T2ow8k5RJiwwLtrgpBMC
 /BlsOI4CmgsE7WDPdbAwcoLvCyQNzAFkpaVPrWuVvZ3GR65UIjiq+rFvvSiBZ04jDhcuSas6FaRTO
 pmzWlALdh5AHm/SldNppgkhxpBvK470ZDznpM4deB5U/Fbme0B3X3zYsI3jHYV4e+ysyr4O27RjLQ
 D1B4n3FRIRKNLeTpoJ4XzDAxaoq8g6YE+IdQD/Z6qKcPsbtqyl89ZTSaRvFo/7oKF+MraUXTPyvfk
 UuxGwAh1RhokrKhvvBr+SeEyKuyO2fYPopc33/UNQ8DLkKL51AL2IAh5issdeAJiRGJPRP5AvZfV2
 LCcJ9enx4dc7gSFi2aPJeivE2hXbnbKdb9NHVVFQkmOqWwxeCoIRE+93qfxa08=;
Message-ID: <0e3085ddc7fb137b727829913c20ad9d08577bdb.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 15/23] hw/9pfs: enable xattr (mockup) support for synth fs
 driver
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=0e3085ddc7fb137b727829913c20ad9d08577bdb@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The synth backend is used for testing only. Enable xattr operations
by making lsetxattr and lremovexattr callbacks to return success
result.

They are still actually not doing anything, they just pretend to be
working to prevent 9pfs server from erroring out on xattr requests.

This allows the subsequent test case patches to verify xattr FID
limit enforcement.

Link: https://lore.kernel.org/qemu-devel/9c1c7128135f3bd9c2f62a3f64bb730b6a94ec7a.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-synth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 322dc3bb69..4b0732e093 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -477,15 +477,15 @@ static int synth_lsetxattr(FsContext *ctx, V9fsPath *path,
                                 const char *name, void *value,
                                 size_t size, int flags)
 {
-    errno = ENOTSUP;
-    return -1;
+    /* pretend it worked */
+    return 0;
 }
 
 static int synth_lremovexattr(FsContext *ctx,
                                    V9fsPath *path, const char *name)
 {
-    errno = ENOTSUP;
-    return -1;
+    /* pretend it worked */
+    return 0;
 }
 
 static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
-- 
2.47.3


