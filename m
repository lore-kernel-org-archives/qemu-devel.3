Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AD0CA0EE5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umAIR-0001VX-Bp; Wed, 13 Aug 2025 08:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1um54F-0007mR-W0
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:34:36 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1um548-0007sH-1W
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:34:34 -0400
DKIM-Signature: a=rsa-sha256; bh=l2XRd5mWoVKbDszSTWuPXeHpeeUG9cQZa7vxPy3C8lU=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1755066860; v=1;
 b=fcj96hOEzRraYFIV1VJw24AyOWpaMX7Zl5REZVEb6RGFrzy8fiJlGPWlE1RYmS46FBFT+i5P
 QDQYtDr15xkKtl3TLQjM2bn00cHWsZ82BSo6Nipj7UMTnQIibcqSqtaW+G4abii0Yz4XgjaFl1a
 8F7EtVfQdlb6JTw9J3GNY37JN0tpApvYfINtppFsF5da+SsMrZW4ECKIPttBlrIWM0JNyjDgJNd
 HMyVDM+aDaU4xkYaa93jqUdB0f/FcKQJtLuuEefRn5uI5EEA9mgU3J9sAltvoaou89kmW11gkYS
 CIdeyObH/7jTKX+16RUcfBTTtuPZva8Xzw2KGQ4Juqn2A==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 564B122EFF;
 Wed, 13 Aug 2025 06:34:20 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Wed, 13 Aug 2025 06:34:20 +0000
Subject: [PATCH qemu 0/1] A small patch to address Issue #2943
MIME-Version: 1.0
Message-ID: <175506686028.15648.7602021948044277748-0@git.sr.ht>
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
X-Mailman-Approved-At: Wed, 13 Aug 2025 08:09:32 -0400
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

Details of the issue can be found at: https://gitlab.com/qemu-
project/qemu/-/issues/2943

This patch by default disables the KVM_X86_QUIRK_IGNORE_GUEST_PAT quirk
because most Intel CPUs in current use do not need it. The bochs video
driver bug which required it has been fixed as well.

The end result is that guest PAT is honored.

myrslint (1):
  Default disable ignore guest PAT quirk

 accel/kvm/kvm-all.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.49.1

