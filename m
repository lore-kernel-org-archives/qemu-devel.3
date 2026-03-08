Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BDCEA853E
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHyW-000513-Hn; Sun, 08 Mar 2026 13:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHxH-0003qr-UU
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:23 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHxG-00042M-3D
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 754E244099;
 Sun,  8 Mar 2026 17:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6605C116C6;
 Sun,  8 Mar 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772991010;
 bh=C+C82ybik9x9gjXt76xrkRauzAp/2YKwqHuKob5hmVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dt/fMkJdITwV3L7QbwE9SbFLhNFqbgy6DtVFWVYdBloFfgisfwFsLtDSuGaA1uBQq
 nchEJwOIA41x4nNzv01OYkRTfvdh8SS+zKGFmvrmzTmFm3WPF4Vv+cojiGg71TLYVG
 P+5qFdGHZiRR4F2WJcUnBPug8tfRiz0MTqv+8dIM90SfytXrIhO5IoAZmUDN2V3I2H
 cwZ1Qmepcz6jGeHQUJEIgJ+qYUG5RQUY1n+LE2zo++BSp8Fsyvs2bgsb6eC1r2buoO
 dDibaxLJWW8Z1KHB/XiDgvmCj84wfyBy5+RuTXdapzm+RZucyBNFvCcHQouOWSJ39n
 /yQip/CnOhNsQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/12] linux-user: Improve formatting for mremap()
Date: Sun,  8 Mar 2026 18:29:36 +0100
Message-ID: <20260308172936.2835-13-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


