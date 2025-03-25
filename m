Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C9C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 20:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txBKf-0002lx-32; Tue, 25 Mar 2025 16:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1txBKd-0002lC-3W; Tue, 25 Mar 2025 16:57:07 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1txBKZ-0002Xn-61; Tue, 25 Mar 2025 16:57:06 -0400
DKIM-Signature: a=rsa-sha256; bh=8/RBsoX6Ih2HEV322wVLWsxwEtJcj3rG0PpJE1ehlbM=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1742936219; v=1;
 b=lWhJadpbEf0Gs/LLVzXIM2EdITHs3hvOUlWZxU5tP1pyz2X3fTmcFdh2iYkq5AEyiZIQx3vP
 GUsiXq+ViyVc3hJ5Rw90VShlRZsyb17hW0LXJk9OjFkEWi7tNHs7u9dKIJ3Rak4oKj5ec8xKFu5
 xYCNZGhp4Ki7MwSa8jOqMvfNlFxT+J7Nk+AL2w3raaIq2xD8Lzj+/8+ONksmDoc0Dpxm1N7CTWp
 nwoSx9pWSKuftB6WrWmB/ya9Rh6EtFYiqfyMmlr83xcPbo2SX23wU98MA9S+p2trgPfQDq+hTzj
 0sGfyc6INNm1Z3nf8o0T6S9btvbvbpHAIeNyAqg9cOzHQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 33E512069A;
 Tue, 25 Mar 2025 20:56:59 +0000 (UTC)
From: ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht>
Date: Tue, 25 Mar 2025 20:56:59 +0000
Subject: [PATCH qemu 0/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
MIME-Version: 1.0
Message-ID: <174293621917.22751.11381319865102029969-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~h0lyalg0rithm <surajshirvankar@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Suggestion by Stefan Hajnoczi to improve io_uring performance

Suraj Shirvankar (1):
  Add IOURING_SETUP_SINGLE_ISSUER flag to improve iouring performance

 util/fdmon-io_uring.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.45.3

