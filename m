Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB7AC5B549
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK27p-0001If-5w; Tue, 27 May 2025 17:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK27n-0001IO-Nt
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:46:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK27m-0006gW-5u
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=4Ko0I+dzrKlHJyDZYBtK6L6tmhZ+Lv9ewJO0p0QMVR4=; b=YsgqVs1z3F1fDI5XUJ78RAbMwl
 O8qp3mrg2NM+IZWJ3hPLBwul2mfj2x6lEgS9X4B5V1/f0k0RoBPuL0SaTTGEMnKS6e7oZYGGnyRDR
 IuN0Rgx9fAHmdhcYSol4cI98/VB0zV4fQNeVQsBOqYjK07usvIEYfDKD2MSwlOz5u0EeYOdWdI96D
 vRlDn/VYyvAqd63gRTSgbSm5RUan+VpHW+vCU+McF0joOa0+ZQo9kR1oJEGJq69STWnqtnvSvDnd6
 sHulv6vRaM4T6mIZdVxawft6vwPGTK2Yx/aPf/bauxuQM5Y2uhQjAoI+61oj2yxZy/WnaRPM/hlGy
 x3rY+gCJLifbnn7jb5X9sF/Bzsws+1bviRFThIF2xeIP8/6PiFlgVqpOtSBZdiQh72nAZN4c7TfBk
 ySq8a4hogalFVBjsV64Py6orpmozwV97bZyh2J/RlR9dWx66QHaiwcG0+BMF/piEXNzb5MwZa1SMh
 rLmhLFByLPOEK3QsopQBxQ53taD6G3GP0zykVsRtTnJIFTp17IeZg/Mag4A1qElwZpOGmOlSmAHjk
 HEf5B3rNeILnd5SMD4o9wOdN3SV2YWVF7JQX3f7/0wUaIwyxQJXdtNe/r4HzNcHUeKUDN1oQvY/F4
 WxVFhBjh1zJ1kSUTBh/tYz587mALEt3/Ou1BM2xMk=;
Received: from [2a02:8012:2f01:0:7607:4cc5:5176:1da8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK26P-0002hf-1x
 for qemu-devel@nongnu.org; Tue, 27 May 2025 22:44:53 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 27 May 2025 22:46:04 +0100
Message-Id: <20250527214605.350903-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7607:4cc5:5176:1da8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/1] qemu-sparc queue 20250527
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:

  Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 -0400)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20250527

for you to fetch changes up to 4ec799dd17dcbb0fa4e90e685d5d6fcf8f72338a:

  target/sparc: don't set FSR_NVA when comparing unordered floats (2025-05-27 20:09:13 +0100)

----------------------------------------------------------------
qemu-sparc queue:
 - Fix for FSR_NVA during unordered float comparison.

----------------------------------------------------------------
Clément Chigot (1):
      target/sparc: don't set FSR_NVA when comparing unordered floats

 target/sparc/fop_helper.c | 1 -
 1 file changed, 1 deletion(-)

