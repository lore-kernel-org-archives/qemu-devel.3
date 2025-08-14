Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF96CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbth-0007H0-Th; Thu, 14 Aug 2025 13:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umbtc-0007Ft-4h
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:37:49 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umbtS-0006lC-Ne
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:37:47 -0400
DKIM-Signature: a=rsa-sha256; bh=v7N1DlzFOKbp5/CJtJ/OY+lr3lrWR5b+TzL/s+dnPLs=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1755193052; v=1;
 b=NBu8UKYr6e+T+p9Fjf/D+/z6TaBol8sAgK5OeNuN+FnaJz4KtpBk+KeATF13gAys/7RMSI1/
 khkaDu+WPJcqeRx4YFZesvjKhhpNwEhKoKo2Prm6I7aLprTEVbTbB5X/u7zaWpjG8qA0Lf8KIsw
 YFGeYcqCxjsu1Cts54OahOA5GUYBVHPoLtgPdSb6/1JZhtkBin7y8NBZPIOrl1JNyirXtFZa2V2
 +IwOu1QrfYUDUyNVhK+NHn0CYG7K+906cWJsiSvJNyD1NIqVxnBiwWLZe4UC39MRpe3F/rhaWlA
 yRHKfdLSIL8IY6gjMfEN5zy628H3xqwj9WNIRfNWpycMA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id A68B122FB2;
 Thu, 14 Aug 2025 17:37:32 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Thu, 14 Aug 2025 17:37:32 +0000
Subject: [PATCH qemu v3 0/1] Default disable ignore guest PAT quirk (third
 revision)
MIME-Version: 1.0
Message-ID: <175519305258.21579.8228319741764786681-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This follows up on the first two. The second was technically fine but I
was told to move a thanks note out of the commit message.

Addresses: https://gitlab.com/qemu-project/qemu/-/issues/2943

myrslint (1):
  Default disable ignore guest PAT quirk (second revision)

 target/i386/kvm/kvm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.49.1

