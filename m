Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21B7CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU4cd-0007sJ-6b; Mon, 01 Jun 2026 11:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wU4Zd-00071l-KF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:29:05 -0400
Received: from mail-07.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wU4Zc-0000Ct-5N
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1780327732; x=1780586932;
 bh=OBqM34feaP3nuUtSKXMnW37Zrs8QzJgQ6/z+S6qyqc8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=eMQtJyZEjaalS0tF10NwcWctK07vxhNdXWCZvvk/ba4JbNRLhTLFK/+HSo6c2Z3bz
 +UBw4OQ6c3YkvzX6KIEPVs3YLT/dwzjWegQTdT7HgPoJWTaF1QvNCRYNeVxOMqPoBQ
 X+bqPA/wX9xXJ/Z44lMldyYpP9IZA0mgTQwU6Vtw/Xeu4kfNBaUb2/57KLtWd2WTrB
 leKOKFdg8k6O8E0NdW6FE7vCJhGl0UAxjjc3xik8YE9eU70YMkkXvYROmgpfxZS+l9
 U5VCaMK8c/fu3VK5sUGckifv2XC181gfdkE0n05GlkOCQ4CDs00LR4ZlRO+vVJkimr
 Czp4WLKDjW0GA==
X-Pm-Submission-Id: 4gTdCl1sC4z1DDLd
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, thuth@redhat.com
Subject: [PATCH v3 3/3] MAINTAINERS: adopt hw/misc/applesmc.c
Date: Mon,  1 Jun 2026 08:28:47 -0700
Message-ID: <20260601152847.26916-4-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260601152847.26916-1-matthew@pq.io>
References: <20260507152030.48753-1-matthew@pq.io>
 <20260601152847.26916-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.165.51.139; envelope-from=matthew@pq.io;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Jun 2026 11:32:02 -0400
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

hw/misc/applesmc.c has no MAINTAINERS entry, so patches to it are
not routed to anyone and get_maintainer.pl only resolves the open
list. Add an "Apple SMC" entry (Odd Fixes) so future changes have a
designated recipient.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7752917d8c..4155e1d93d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2106,6 +2106,11 @@ F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
 F: tests/qtest/xlnx-can*-test*
 
+Apple SMC
+M: Matthew Jackson <matthew@pq.io>
+S: Odd Fixes
+F: hw/misc/applesmc.c
+
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
-- 
2.50.1 (Apple Git-155)


