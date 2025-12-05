Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E8DD339A6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRZqX-0005Nj-Ai; Fri, 05 Dec 2025 12:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRZqV-0005Na-Ro
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:43:56 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRZqU-0000Gn-3S
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:43:55 -0500
DKIM-Signature: a=rsa-sha256; bh=/+XuP5CRfi7fGS1CYAJHrUDI9A3JAql3DvCl8xfri9U=; 
 c=simple/simple; d=git.sr.ht; h=From:Date:Subject:Reply-to:To;
 q=dns/txt; s=20240113; t=1764956630; v=1;
 b=GE3BHdZ+DaYn+E24yI1yaSXZLywihPumB5iJ1VPrNCCoirD6VDgFGO3Y7uasntopSNbcB7XN
 wOJLn90zN/dvrUNdT32mYKnRl4Ne+IrWZaBDpmtl4jNdvYLe+pQyAU+Xf7sXyrLagvMnytI7Ge/
 l8x65Ux6GAWQH4Psm4IbOr++S6/sqikm6RMUjP1ZdxZGBNR1o53uIZ3SkBMNeIN5iwQsj550edL
 MC7EHy1q4YNO90aCXUVkaZSDsDbWJlVdFzLdmOvoKdsdjKkGFKc++Rfa/U+n4WFilgs/nxojWyO
 tgIPgeY85aWrL6hgwj8h2YtuCIR0BhV8lJv3vRqUk8KDQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 9FEFC24443
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 17:43:50 +0000 (UTC)
From: ~katharine_chui <katharine_chui@git.sr.ht>
Date: Fri, 05 Dec 2025 17:43:50 +0000
Subject: [PATCH qemu 0/1] ui/sdl2: add multitouch support
MIME-Version: 1.0
Message-ID: <176495663056.25695.17714158054733102404-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
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
Reply-To: ~katharine_chui <kwchuiaa@connect.ust.hk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SDL2 has multi touch events, use those to provide multitouch like with
the GTK ui

Katharine Chui (1):
  ui/sdl2: add multitouch support

 include/ui/sdl2.h |  9 +++++
 ui/sdl2.c         | 98 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

-- 
2.49.1

