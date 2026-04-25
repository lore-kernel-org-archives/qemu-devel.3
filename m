Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EF6FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcU2-0006ax-7e; Sat, 25 Apr 2026 08:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wGcTy-0006aT-Un
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 08:51:38 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wGcTs-0001AR-BL
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 08:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9d
 lGPWAKv4yy6JwPN0eg9WWTOZg0NkUxVXptzHOHNlA=; b=SJifRdqs29XUvlivwU
 gCdTmeyjlhQ4VJkGTEeVWkHzuQXVZ+GMK3Lbd1UVwULlskIN3aXF7LnDTeblMqfq
 u4tWZZe6m1VaSmC7C2a0984yNxjHjP4ThgrlFmviFYenTGkgUQE5bp1B61xVTp+8
 vXlP3WxooeOmFRxwBaldluHJQ=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wDXP0XEuOxp+Fm4Bg--.64504S2; 
 Sat, 25 Apr 2026 20:51:17 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	pbonzini@redhat.com,
	Alano Song <AlanoSong@163.com>
Subject: [PATCH v2 0/1] monitor: Add `clear` command
Date: Sat, 25 Apr 2026 20:51:12 +0800
Message-ID: <20260425125113.37341-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXP0XEuOxp+Fm4Bg--.64504S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRi6pkDUUUU
X-Originating-IP: [240e:36f:15cf:8780:308a:f2b4:e0e:95c7]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC0wb0CWnsuMbg9wAA3E
Received-SPF: pass client-ip=220.197.31.2; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add `clear` command in monitor, just like linux
terminal `clear` command do.

---

v2:
- Correct the ANSI escape sequence order.
- Add more detailed comment in code.

v1: 
- Init commit, see:
  https://lore.kernel.org/qemu-devel/20260418133927.43012-1-AlanoSong@163.com/

Signed-off-by: Alano Song <AlanoSong@163.com>

---

Alano Song (1):
  monitor: Add `clear` command

 hmp-commands.hx       | 14 ++++++++++++++
 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 11 +++++++++++
 3 files changed, 26 insertions(+)

-- 
2.43.0


