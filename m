Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6851125892
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLQ-0007h5-RZ; Wed, 11 Mar 2026 15:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PL3-0007Uy-N8; Wed, 11 Mar 2026 15:35:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PL0-00007P-Id; Wed, 11 Mar 2026 15:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257666; bh=FSMGlYph0E646l8xPKs1QSoOKQfE4LlZnojK7QnNiVY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nWIAG4VwPlLgRdG7WBU4F6YoUhaXDsUbphBHBTqtsndjriJ+osIjvokSgGIOryE9c
 zoVoAT9qSM3mSdUtVrjWyOPh0PxjtirK7DD2Tc9F5TlwXEAgz4xmz3ZD421htrr+zL
 qJLIhked0xZXWY6lbWlZZxw+l/ox95wnbRmSzZf7reaz9BTdDE8cAwM/aRLCcYzYMg
 /Xe2TNln0ECBQAw9f0KNuA9/iVboqXH53eL87ddkAaO45+G34ekXGn3NpKybIk0Apq
 WPokrZypqdg4cz7l6KicgxcRjmD3H7j8yRJZ4qYXgmX1aJMDI+E8Fru3aIbA/0gicE
 kXfUfc//3Xh4w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE5A31920F0;
 Wed, 11 Mar 2026 22:34:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E53C537C455;
 Wed, 11 Mar 2026 22:35:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 08/53] contrib/plugins/hotblocks: Print uint64_t with
 PRIu64 rather than PRId64
Date: Wed, 11 Mar 2026 22:34:01 +0300
Message-ID: <20260311193449.1096110-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alex Bradbury <asb@igalia.com>

qemu_plugin_u64_sum returns a uint64_t, so PRIu64 is the correct format
specifier.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/5d26c9d99ee87ac4a4034ff64e3d8881253eedf3.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
(cherry picked from commit e777f6ab91406884136b5679a9d64124832668d8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index cf4d6b8c36..40d8dae1cd 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -87,7 +87,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
-                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
                 rec->start_addr, rec->trans_count,
                 rec->insns,
                 qemu_plugin_u64_sum(
-- 
2.47.3


