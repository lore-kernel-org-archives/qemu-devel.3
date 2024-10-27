Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ED3D10C07
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 00:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4r6o-0004PK-3G; Sat, 26 Oct 2024 20:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t4r6l-0004P8-CP; Sat, 26 Oct 2024 20:26:15 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t4r6h-0000Q5-20; Sat, 26 Oct 2024 20:26:12 -0400
DKIM-Signature: a=rsa-sha256; bh=tvgSp1LVa2B1ISPg+tfS0oNA8PdFbts0KqLiCV7PTGE=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1729988769; v=1;
 b=GL6K3jUKltM1vA0rE6KA4z3EtGBGQppK/2QRsEvNO36uQL2AlIP1XuMWA8mdG1EoDMhmDy8i
 PogNeIYstjZ3gvG1Vb86F4w1jDknpu9c+u4JQK3+90euK6425dVRm0of20sJ97tiZt1ZKf9DvDu
 G1lTb0X3hhiPy1ygxkS0W/9PAoHlOTRqJG98ku9QfU+5bOOTTw8rj1B5H8yrlFBgL1YfgNEjHZ2
 PoNkg+Xdhg8IQKbDWb7s4Avdn5pTk3HORQaMdN3WUHucJgocjVaTLfhj69TdDRlUOyYQzQaQVBs
 JRLz+iay3jM6QtGOdmqiRpgq4yMD4HZCDnvZ0ywcTM4SA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id E9FD9200CB;
 Sun, 27 Oct 2024 00:26:08 +0000 (UTC)
From: ~axelheider <axelheider@git.sr.ht>
Date: Sun, 27 Oct 2024 00:26:08 +0000
Subject: [PATCH qemu.git 0/1] hw/intc/sifive_plic: add const qualifier to
 signature
MIME-Version: 1.0
Message-ID: <172998876893.15131.3277963343932581039-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: ~axelheider <axelheider@gmx.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add const qualifier to function signature. The function does not modify
the string. This allows passing read-only strings also.

Axel Heider (1):
  hw/intc/sifive_plic: add const qualifier to signature

 hw/intc/sifive_plic.c         | 2 +-
 include/hw/intc/sifive_plic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2

