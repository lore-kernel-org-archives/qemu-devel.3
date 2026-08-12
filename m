Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C209BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8cC-0003Tf-RE; Wed, 12 Aug 2026 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8c3-0003QZ-6I; Wed, 12 Aug 2026 09:03:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8c1-0004GL-8F; Wed, 12 Aug 2026 09:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=DnuR9awghC/pSNqGppldMTXwl070xWC0v5RHgjPYQnI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QpRYshfv0hXeRLfGhIB+0P7U+WD4Wgj6PL3CKufMl6rFF2d0sfQwad3fq+fmaIT/z
 gYRg/wDf6ZNmAcKpbcwf1ax+Jv8+3Tk2oCDMwBXUpWZ/8US/e1eUYLcKdkG6PW69Gw
 KbcB1Dt24GGfoTv9DSkoOL3gO2DZrKU+PklL8dDg1TFz9pWamfzX0P137ZdKZ+1z1U
 5BNj0BzGIADzla09+tqpdv1dV620zO7CAItHQY3HcsfQS4s2xeggarzXJ02APmsBDn
 2iaQDFb5inhPtzGTu2k+YEmVqN8xL9whJ+C+mvYiBVLMnMnrndJrWbDkkLCgKwWf0U
 va2whxF59JvGA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 08D4F1CA481;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F187409B64;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C57A92F898; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 002/102] hw/uefi: remove debug function
Date: Wed, 12 Aug 2026 16:00:37 +0300
Message-ID: <20260812130233.621965-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

This was never meant to be present in production builds.  It's a code
path not hit on a normal boot (OVMF wouldn't try variable updates which
are not allowed), so this went unnoticed.

Remove the function.  If needed for debugging the git log is your
friend.

Fixes: CVE-2026-58582
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3615
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-3-kraxel@redhat.com>
(cherry picked from commit ff5a9eb13c862ed274ea0d0682a6573411e31543)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index eeb648a6745..64811ef4c45 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -37,37 +37,6 @@ const VMStateDescription vmstate_uefi_var_policy = {
     },
 };
 
-static void print_policy_entry(variable_policy_entry *pe)
-{
-    uint16_t *name = (void *)pe + pe->offset_to_name;
-
-    fprintf(stderr, "%s:\n", __func__);
-
-    fprintf(stderr, "    name ´");
-    while (*name) {
-        fprintf(stderr, "%c", *name);
-        name++;
-    }
-    fprintf(stderr, "', version=%d.%d, size=%d\n",
-            pe->version >> 16, pe->version & 0xffff, pe->size);
-
-    if (pe->min_size) {
-        fprintf(stderr, "    size min=%d\n", pe->min_size);
-    }
-    if (pe->max_size != UINT32_MAX) {
-        fprintf(stderr, "    size max=%u\n", pe->max_size);
-    }
-    if (pe->attributes_must_have) {
-        fprintf(stderr, "    attr must=0x%x\n", pe->attributes_must_have);
-    }
-    if (pe->attributes_cant_have) {
-        fprintf(stderr, "    attr cant=0x%x\n", pe->attributes_cant_have);
-    }
-    if (pe->lock_policy_type) {
-        fprintf(stderr, "    lock policy type %d\n", pe->lock_policy_type);
-    }
-}
-
 static gboolean wildcard_str_equal(uefi_var_policy *pol,
                                    uefi_variable *var)
 {
@@ -173,7 +142,6 @@ efi_status uefi_vars_policy_check(uefi_vars_state *uv,
     pe = pol->entry;
 
     uefi_trace_variable(__func__, var->guid, var->name, var->name_size);
-    print_policy_entry(pe);
 
     if ((var->attributes & pe->attributes_must_have) != pe->attributes_must_have) {
         trace_uefi_vars_policy_deny("must-have-attr");
-- 
2.47.3


