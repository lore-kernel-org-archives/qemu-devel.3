Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3104AC02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 02:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj7k3-0004GZ-0A; Fri, 14 Feb 2025 21:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jz-0004F5-E0
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:11 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jw-0006dD-Fd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585823; bh=xwnweW21dRad/7sKoMcG8gqMmvOWqaVF1Wl/xjaIWB0=;
 h=From:To:Cc:Subject:Date:From;
 b=TlNToTgB6MSKxMjFV0VBBP1VU7U2Truo026rAt5njzWDGSf91As6b62+QQUBFzwND
 NMmT5WkHkWUQjuWLW0neHt93zKNhthYLY3KdprPI25UFrsMFyWeAZ5GR4ERxg3vpT7
 KW+CHAIseyXXQTqXzRHnIzpy237fik9e7u9Qg73H+emJd4ScVzDXyzqZJppANHyg5b
 bdQbYZHW+JZmVqOc5NafiOffgmQiP5LaM/D6ViIXeoMKpeq4EzMeMhFxb5fR5mvFsC
 HOPlhebEfRaUrpd1dKwTKJDuRZzh9vK8JQ/IvQsYJVpV4oBjuuOmUldk77pFQmYoY7
 HmQnBka2/ELSA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 749913F22BFA
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 18:17:03 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id E-lwy7D3nP-7; Fri, 14 Feb 2025 18:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585822; bh=xwnweW21dRad/7sKoMcG8gqMmvOWqaVF1Wl/xjaIWB0=;
 h=From:To:Cc:Subject:Date:From;
 b=W3UH4xw07B7ieELbbTACsvIQjE/J2iQ8uINnGiuzmsyMq6WVVbNQHAHLYhmqNu7Yo
 6/NDXatUYi3wAdo78/EWw1KfsaMX0xtk7ts0gljFWTgzw1Nj7b09wNfTuI9R+uW+z2
 RnjCPtBXj3vWSA4o2+Q6kGsjjAQOu292bPGzFm+06+xKs9YlrdI1JYxef7/2yysGUU
 4FO73sFCxwjv0b5n9nFbNgmGJG27Ib62OvTBtx4jzXi/iiMmLZvyrRZ2xL+O40VytN
 2ssqAUwW79pd1fnCVV70kFPH0IykTRflQ/Q4jmDwda5iyXGg4EHpMhuNpa6GGlw+4H
 gjBYkp5BtE0Zg==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 909C93F22BE0;
 Fri, 14 Feb 2025 18:17:02 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 544DD1E60096; Fri, 14 Feb 2025 18:17:02 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 0/5] Renesas RX target fixes
Date: Fri, 14 Feb 2025 18:16:49 -0800
Message-ID: <20250215021654.1786679-1-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I'm getting a Renesas toolchain working and found a couple of bugs
and a few fixes in the qemu target code for this device.

The two critical bugs which are fixed:

 1. Exception vector base address is incorrect. The
    right value is 0xffffff80.

 2. A bunch of opcode helper functions are incorrectly labeled as
    TCG_CALL_NO_WG. These helpers read and write virtual registers out
    of the global environment and so must not be marked with this flag.

The other changes included are sufficient to use qemu without needing
to start gdb as well, starting the machine using the reset vector
found in the exception table and then re-loading that vector during
subsequent reset operations.

With these fixes, the picolibc CI tests are now passing.

Keith Packard (5):
  hw/rx: Allow execution without either bios or kernel
  target/rx: Set exception vector base to 0xffffff80
  target/rx: Reset the CPU at qemu reset time
  target/rx: Load reset vector from memory after first run
  target/rx: Remove TCG_CALL_NO_WG from helpers which write env

 hw/rx/rx-gdbsim.c  |  3 ---
 target/rx/cpu.c    | 35 +++++++++++++++++++++++++++++------
 target/rx/helper.c |  2 +-
 target/rx/helper.h | 14 +++++++-------
 4 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.47.2


