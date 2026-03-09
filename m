Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8A8F3C25E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxg-00044g-99; Mon, 09 Mar 2026 09:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxV-0003yY-5x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxT-00069N-Pn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DC83943CFE
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E01C4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064043;
 bh=C+C82ybik9x9gjXt76xrkRauzAp/2YKwqHuKob5hmVE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=GTMCgphvdrLchFY+O/ZfLEJ4yp62xotDX1nOzXri/3axYf63st8KoJe664Vp1PZHA
 ZTiGvk0SSI9c9tqNeOuVRXF36+75Q7jIln74AsKaSab+54hS8FJGKeImF8DIKcz+2j
 yrWgPcV5Ra2UkY+YzMMzJleUitRPIt7AMNtTODwblNsYskf9ckJGZnxuEqe3xgfT6+
 gCErvX4CZgLDfNg2dOO3PVoA24xM+s9M0ukH7uibw9zpOlBwn8gSzz3RWDC43j81U/
 1Qsg+n6EymOms7Wf6iULGVV04O0QPOmsB9WFoBqclRy9vqX605ZrNeYpnYLpVd1Wav
 zDh/OzvKzukyA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] linux-user: Improve formatting for mremap()
Date: Mon,  9 Mar 2026 14:47:11 +0100
Message-ID: <20260309134711.5312-11-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Improve slightly the strace output for mremap().
Print the old_address and new_address as hex values, old_size and
new_size as unsigned, and the flags as integer.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 linux-user/strace.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 51b5ead969..35f001fecd 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -641,7 +641,7 @@
 { TARGET_NR_mq_unlink, "mq_unlink" , NULL, print_mq_unlink, NULL },
 #endif
 #ifdef TARGET_NR_mremap
-{ TARGET_NR_mremap, "mremap" , NULL, NULL, NULL },
+{ TARGET_NR_mremap, "mremap" , "%s(%#x,%u,%u,%d,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_msgctl
 { TARGET_NR_msgctl, "msgctl" , NULL, NULL, NULL },
-- 
2.53.0


