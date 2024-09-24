Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F5CF9C72
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 21:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stCpP-0003cI-Tc; Tue, 24 Sep 2024 17:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1stCpO-0003bh-Tm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 17:12:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1stCpM-0002NN-Sd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 17:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=yFVQQxJI/m+KYLvfB8oRoVs+nG4g9XfCs/D0W7McpgA=; b=JBtk8w6YtK6G37CJBAM4rlKIJU
 gnlXGXZm9b37blyZzSokANwGN66ILrrgltYGpIki/EeVgYIp3vCTUUEFqepgZKLVP7VWZV2u/kyzB
 qrRt1o23t4itRxffnAm60G8BYM/ZXC0vsME6lLhwSnR4U5DrqaCP0V8k9/tL0muXudPJ6rE+91UBW
 by5OtEpsCZBS2r7zojUzeugjKFFwDy+/bXhLchb7r8gzH6y4WnFMzL32YK1bOOBjkm4my31pD/Pg1
 i2fAiNEQdMpcUMcQdGyjjBYGtA22QmSoJBHPdFM8A4SWb3pXzx4rHylZLqsoOVWq019/OdgB78Ubt
 mgARngFxQZQinsoERuX7MmofhbeqTv7OvhIcTeoah0ib/b3/N93Zjg+AlqD/9tXIEVvnmUG5NWxXp
 U+n3eu1fk2b2VvDHlAB736ByiEJsRo7SW7DG8oHoDIPFriKNltCkLGNbwiq4T+Dhz75Q0TtUlaUDr
 Eep9j26rZ2pOWhWum9JHp40azfajf9BATY5wpXQ83/0iYap5djXyO1JsRmD2lqZYIerINlthCPPXv
 86IpfB/l9N0D+GTsVZ7qCy/rSh/KrJLc9Qe2f5kEm//OUCpAy97GEcyJHr/y/VAT4mNMt6ONIUQqL
 rio2Q8gVHq7uHdsSybBuhEUgG2oeIzyQSZaXi2Mbc=;
Received: from [2a00:23c4:8bb8:7000:995a:ab79:688d:baed]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1stCp8-0002Zr-JQ; Tue, 24 Sep 2024 22:11:58 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue, 24 Sep 2024 22:11:52 +0100
Message-Id: <20240924211153.1473771-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:995a:ab79:688d:baed
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/1] qemu-openbios queue 20240924
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

The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:

  Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-openbios-20240924

for you to fetch changes up to 972208be775a37dccb3047702ea1582e9936102c:

  roms/openbios: update OpenBIOS images to c3a19c1e built from submodule (2024-09-24 20:58:54 +0100)

----------------------------------------------------------------
qemu-openbios queue
- Update OpenBIOS images to c3a19c1e built from submodule

----------------------------------------------------------------
Mark Cave-Ayland (1):
      roms/openbios: update OpenBIOS images to c3a19c1e built from submodule

 pc-bios/openbios-ppc     | Bin 677196 -> 677200 bytes
 pc-bios/openbios-sparc32 | Bin 382080 -> 382080 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)

