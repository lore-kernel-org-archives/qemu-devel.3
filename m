Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED0AD339B5
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 18:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRafr-0000ny-1s; Fri, 05 Dec 2025 13:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRafo-0000kU-6d
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:36:56 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRafm-0000rS-8t
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:36:55 -0500
DKIM-Signature: a=rsa-sha256; bh=U4sHZo2vYI9DpEwuwFV391sTfFBrE6j4Hv4APCnMGbY=; 
 c=simple/simple; d=git.sr.ht; h=From:Date:Subject:Reply-to:To;
 q=dns/txt; s=20240113; t=1764959811; v=1;
 b=AmmFGPwZEs3iSXPFM9zsus/Ulbe8BmkEeAt7DM9VbkR5/H5i16unbJNrcVpVwVe8hdXudPe5
 TvkN22hyATnKMpOOmhzUGjKwr+EgvYMf9Q40smIHv3X/5coR+rgIQiBpxKayLiDfJrFRQLK5rpQ
 zLVEn1ammINSdslDHFKib7ru2e8j5hcvV218GVZGury4L0xDmqQe4SloYfJ7yC3ou6gcgZofdSh
 sUotfDDZM5y6phHBqbBUDM4NuGb0d7roiW1AIyKeSsRj3nG9E/sQxw9PTOE1Zvx7SIW1l3hlbrv
 wCCPqa5TaX8WnOX06XqCTJuZXV/Q5OcsbOcOuxB8d6Tzw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id D633B240D9
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 18:36:51 +0000 (UTC)
From: ~katharine_chui <katharine_chui@git.sr.ht>
Date: Fri, 05 Dec 2025 18:36:51 +0000
Subject: [PATCH qemu v2 0/1] ui/sdl2: add multitouch support
MIME-Version: 1.0
Message-ID: <176495981181.29650.15848321452328771053-0@git.sr.ht>
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

Compared to v1, this requests SDL to not emit mouse events on touch when
possible

Katharine Chui (1):
  ui/sdl2: add multitouch support

 include/ui/sdl2.h |  9 +++++
 ui/sdl2.c         | 99 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

-- 
2.49.1

