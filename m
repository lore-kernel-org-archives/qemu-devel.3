Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC0C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 18:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umFu7-0003qS-IA; Wed, 13 Aug 2025 14:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umFu2-0003pN-LM
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 14:08:46 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umFtu-0001rt-Cl
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 14:08:45 -0400
DKIM-Signature: a=rsa-sha256; bh=bsnQc68QKP5EYzLkP3YaI/koVRKh+wpgjA3T6BGSAuQ=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1755108513; v=1;
 b=QJF+SG2cU00bWrL623qrm9okKnaGyeCJjhpG8w4ZFXrzHlQkUlTDeQfLgkg5rg7v+J+RDCSo
 0t4LMnr76s/fwfVBFCD7KkpVeywKItznndZWWDXXtL1ad2id+kz3vdj3KFC9PHPqMcakf1VtL1C
 bIGvml5itlq601Ut9WREqBKMLq7TJP7nRw/9mWXuWugGtHk6kAp1nNmlE62+2G20jVmJYgmbvMm
 DXguD55blv0vXHBKv8d7Eu7HmWPWfb0txU/v9WTxOHJB9KJBAQQ5rtuH2wm8Lg8jMxnvBNrWzRy
 h7XSfqs4WCLTFw+RQzJGr/ZdT3ZdiBeQbjlBz/lzL6giw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 5F0A122F40;
 Wed, 13 Aug 2025 18:08:33 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Wed, 13 Aug 2025 18:08:33 +0000
MIME-Version: 1.0
Subject: [PATCH qemu v2 0/1] Default disable ignore guest PAT quirk
Message-ID: <175510851329.15645.802219111760057966-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
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

Details of the issue addressed can be found here:
https://gitlab.com/qemu-project/qemu/-/issues/2943

Most Intel CPUs in current use have self-snoop. The few added lines of
code also check for availability of the quirk disablement option so if
some CPU does not have this feature no change of behavior will occur.

myrslint (1):
  Default disable ignore guest PAT quirk (second revision)

 target/i386/kvm/kvm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.49.1

