Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCECC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1zb-000112-Sh; Wed, 16 Jul 2025 09:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44b540338a3e271866a3d636359bfe6b2edecbb6@kylie.crudebyte.com>)
 id 1uc1sm-0004KT-LB
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:09:17 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44b540338a3e271866a3d636359bfe6b2edecbb6@kylie.crudebyte.com>)
 id 1uc1sj-0004Ie-MC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:References:In-Reply-To:Message-Id:Content-ID:
 Content-Description; bh=OYEY8UxDeP49eAShbSD6pdDT/uizTiS7zwXmv8Bx9IU=; b=BCxKg
 IFE29VLp0y0VuV7ojYl93baptDbIP4XI0lrYWycJnn4DXpa/NkLdZRzG4Mt3lqU1ms2ku9qL/tC3x
 A+f9foiW6pXilxxK3JD/0GVCC2HU0EwiiozGU7RI7IqtzR11lw9WfSUSX0ubb1Swnb7Jyq4Vu3tEZ
 R2Jqx1PQxSuTG2AzjNfo8Pn2CYFauUl32xHYYfoO/AHRcRZy90TWhV2X+dBH0jCJVtLRvSNPm8NPZ
 hfdyzDNCU4QlJTy+34n1yOhrVx6LBAT0mOjK4TLAy7A3JJ02dVztZvuS1KovJ22l/rnmy0Wkrp5Kd
 OC7c7st29kC5DshCqFCASIaMMiSJ2GEw/Fj8QPHROWI3lCxkaRZTa71KXn1f/OeByYRiEYrBqivsi
 AIlXrAcEXE95wZrxNM3kMTsslUmi67/o6uuAmdqB/qhHZHYSzGQxKxdvtHmybNnbtCLm8CrgCy1FP
 uRAMpk8UQkYtqmbwdZ3FSUbrXg90GorlFC4nB/Rlul68F1M1rZ3bbZw78lmL2XMR8ttjiD23ZVyXS
 7DmSXpE4oNARRWkkoESDs//4dLI8AhiDpq5URUGIrsIUEZGpxx1icU8mwSAFjo5xRK3vZ/vHsP9zT
 UhZM2cPUNtAIDlliKQQIbvo/IPW9zMUAvd+cYDf08W1ZKM+tnOUpoIKXA82PgM=;
Message-Id: <44b540338a3e271866a3d636359bfe6b2edecbb6.1752669861.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1752669861.git.qemu_oss@crudebyte.com>
References: <cover.1752669861.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 16 Jul 2025 14:44:22 +0200
Subject: [PULL 1/2] fsdev/9p-marshal: move G_GNUC_PRINTF to header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Sean Wei <me@sean.taipei>,
    Philippe Mathieu-Daudé <philmd@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=44b540338a3e271866a3d636359bfe6b2edecbb6@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sean Wei <me@sean.taipei>

v9fs_string_sprintf() is annotated with G_GNUC_PRINTF(2, 3) in
9p-marshal.c, but the prototype in fsdev/9p-marshal.h is missing the
attribute, so callers that include only the header do not get format
checking.

Move the annotation to the header and delete the duplicate in the
source file. No behavior change.

Signed-off-by: Sean Wei <me@sean.taipei>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250613.qemu.9p.01@sean.taipei>
[CS: fix code style (max. 80 chars per line)]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/9p-marshal.c | 3 +--
 fsdev/9p-marshal.h | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsdev/9p-marshal.c b/fsdev/9p-marshal.c
index f9b0336cd5..3455580703 100644
--- a/fsdev/9p-marshal.c
+++ b/fsdev/9p-marshal.c
@@ -27,8 +27,7 @@ void v9fs_string_free(V9fsString *str)
     str->size = 0;
 }
 
-void G_GNUC_PRINTF(2, 3)
-v9fs_string_sprintf(V9fsString *str, const char *fmt, ...)
+void v9fs_string_sprintf(V9fsString *str, const char *fmt, ...)
 {
     va_list ap;
 
diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
index f1abbe151c..8995e42067 100644
--- a/fsdev/9p-marshal.h
+++ b/fsdev/9p-marshal.h
@@ -76,7 +76,8 @@ static inline void v9fs_string_init(V9fsString *str)
     str->size = 0;
 }
 void v9fs_string_free(V9fsString *str);
-void v9fs_string_sprintf(V9fsString *str, const char *fmt, ...);
+void G_GNUC_PRINTF(2, 3) v9fs_string_sprintf(V9fsString *str, const char *fmt,
+                                             ...);
 void v9fs_string_copy(V9fsString *lhs, V9fsString *rhs);
 
 #endif
-- 
2.30.2


