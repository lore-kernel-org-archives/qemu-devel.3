Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC24CF857F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2B5-0002vw-Q9; Thu, 20 Nov 2025 05:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vM2B4-0002uX-8A; Thu, 20 Nov 2025 05:46:14 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vM2B2-0003vR-Ax; Thu, 20 Nov 2025 05:46:13 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 170596014E;
 Thu, 20 Nov 2025 10:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A1C116D0;
 Thu, 20 Nov 2025 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763635567;
 bh=1Gm5cEgjo3v8iUuKqXhRnSnI1jymVVFPv4YDUhGqOLI=;
 h=From:To:Cc:Subject:Date:From;
 b=a1RoonEQuHzYgZhmNREsBV5xDpPXmxP7VC2abPe+4hmlL0k26HAeHfLl0fydGk6lI
 YDzQ7XPSu+F6cpZXPyd1gB95TT7Rgpng44faObHV/hPj3WsuZuULEvDJ600ASP6Y5v
 Sxv3cxnmKybOF6wDe9hzUxfqWFfvFbO8ZiTwa9IF7stn3901Hs2iJ41QXFxYkdiq3b
 e/mHx9wZ6i+tiatzOvn055/blcCEdiKMM57eB4zRgjLAVcU+HWdPWnDlMpri8FA0Rw
 ByGyaJhUguuq2nWjRKJRxeX0UMo+PmrGvjPKLmW7SpIsR4sumqNUYVDqzZz0fS8QkZ
 7O9GnTSqfD19Q==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1] MAINTAINERS: s390 maintainer updates
Date: Thu, 20 Nov 2025 11:46:02 +0100
Message-ID: <20251120104602.205718-1-david@kernel.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
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

Unfortunately, I don't have a lot of capacity lately to take good care of
s390 in QEMU like I used to; and it doesn't look like that situation
will change. So let me convert myself to a reviewer in the s390 areas I
co-maintain.

Fortunately, we still have two other maintainers for "S390 floating
interrupt controller", so no action needed on that front.

For the other sections we get two new maintainers: Hendrik will
maintain "S390 CPU models" and Ilya will co-maintain "S390 TCG CPUs".

Thanks Hendrik and Ilya for stepping up!

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1c5080e50..d048c9f30d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -364,8 +364,8 @@ F: target/rx/
 
 S390 TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
-M: David Hildenbrand <david@kernel.org>
-R: Ilya Leoshkevich <iii@linux.ibm.com>
+M: Ilya Leoshkevich <iii@linux.ibm.com>
+R: David Hildenbrand <david@kernel.org>
 S: Maintained
 F: target/s390x/
 F: target/s390x/tcg
@@ -1862,7 +1862,8 @@ F: target/s390x/ioinst.c
 L: qemu-s390x@nongnu.org
 
 S390 CPU models
-M: David Hildenbrand <david@kernel.org>
+M: Hendrik Brueckner <brueckner@linux.ibm.com>
+R: David Hildenbrand <david@kernel.org>
 S: Maintained
 F: target/s390x/cpu_features*.[ch]
 F: target/s390x/cpu_models.[ch]
@@ -2919,7 +2920,7 @@ L: qemu-s390x@nongnu.org
 S390 floating interrupt controller
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
-M: David Hildenbrand <david@kernel.org>
+R: David Hildenbrand <david@kernel.org>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/intc/s390_flic*.c
-- 
2.51.1


