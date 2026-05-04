Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07923CD342F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxQP-0004cn-Ju; Mon, 04 May 2026 13:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1wJxQN-0004cA-0k
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:49:43 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1wJxQG-0000aE-Ha
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:From:From
 :Subject; bh=aqkAkBPa3HD/kPEa9LKSL8bPxlBYKg1gzh7jfFxIm0Q=; b=CnNgBe1/4ijMLf5D
 pslSTxPb55QsGhf7hr3kwgsNUs0HGYuCx48Oj6QF9DDrv5VMWa7j1fAFYmDZpuGaoymGUzTNVEqo/
 gNGo0R2odAVb6z9SMBi4FQoh2V8kq0fwZ23+CdXNfGa/b6X6JGOk/G3umI50q6+YH7m9ZSFS+CRDN
 +dnq90Lin4mdUFjjvdCM/kfSyHe5nHWU/YfaYK4Um/OFomRYk6yRd5nF+9hDUGgIQ1K+TjCcnW/56
 Mjl0EUv3qzLkAvTFSMcnfw4KbKAR0aHfA/EiWZp64Vnptg+vi+gosb5UNCGTsYJ/ZLPgd0gNyeZkp
 d4S/SHvdpjQDEIGYIw==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1wJxQ7-00000000ZQZ-0Opr;
 Mon, 04 May 2026 17:49:27 +0000
From: dave@treblig.org
To: qemu-devel@nongnu.org,
	armbru@redhat.com
Cc: AlanoSong@163.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 0/4] HMP roll up
Date: Mon,  4 May 2026 18:49:10 +0100
Message-ID: <20260504174914.122607-1-dave@treblig.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Hi Markus,
  Can you merge this little set through your monitor set?

Dave

AlanoSong@163.com (1):
  monitor: Add `clear` command

Dr. David Alan Gilbert (3):
  hmp*hx: Move info docs
  hxtool: Split srst/erst add checks
  hxtool: Error on missing docs

 hmp-commands-info.hx  |  9 +--------
 hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 11 +++++++++++
 scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 80 insertions(+), 21 deletions(-)

-- 
2.54.0


