Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C80D29DFE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbFS-0000qR-Nw; Tue, 13 Jan 2026 05:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFJ-0000ot-2A
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:32 -0500
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFG-0006qT-0D
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1768298601; x=1768903401; i=laurent@vivier.eu;
 bh=F7YKD4nVzDFDHOYb/F9EWD45jaftk2ahK6dVwnyKzn8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jBiBMPbCKcJbbZNk+SKluc7VbqZHaDNt4WsaKHhmxeiwXcEUgWYpoZeIN1MCHmPT
 ctuP4CUojtGaCkZ7/N3vgitfyOd+08IiwUltPtXdRiU04l3zjrNo03JZPaKdARFs3
 3+/PNH6xpkRc8FflCACjlCEdrh9o6CxMURgvPoS0mR4JB/P/wzm74fm4v4RiD1RIN
 hbDUTBzFMhn/IWXFS4wfadt1PwYP/e7TOnZh/dkmwFL1+ueE8vvM0rUZFnavaVOJV
 QlVTbROhes1nGncuj2l2qHy8b2zKBKXOkjF1rpr5/taTX3CAweOyGJ0vVcKtAYFv9
 +aK+iPFQTHpCs30SYw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MQuwR-1vR5It3gFb-00KOii; Tue, 13
 Jan 2026 11:03:20 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/3] M68k for 11.0 patches
Date: Tue, 13 Jan 2026 11:03:17 +0100
Message-ID: <20260113100320.1009608-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gxh2/2iI4QYOzuZTvHAC0gQusJ+zujMOJDo7hnN6T6Q5Vl3pzBf
 yI+PlBD3X8iku8zSVuW/sDfpvXkSdxyHXpzJLu1UB0T+7D+XgrkpfHk21ik7EdooxNtlfou
 iFXxwUQhbWW/+GUHAKaIgjlpGck7XPKl4Qcfn+PntUKYafMiYlEIBI2U4kPa/bIKzT6sf4V
 7bN53XOsmnoTQGhOJth2Q==
UI-OutboundReport: notjunk:1;M01:P0:hsOoaS4HmmI=;VvjBlacxTg5O2DXBKHtrmMkwgn8
 X+n7p53j3sQgWHnZYZs8mVgt6CQTqpCdpxMlw/OCycHS6rEximPpCcPaymVotzBytsU85sHR8
 B4aslu+6dP9yE8ofZ2U+BInUa7suoys9xFy0Tf8aEazZHlGjmCmzDzmO9KCchgwmyg0dReXVK
 Xw6/B5bunuNsA0DKqjJRRf7qREht5jzvaIGfsczy8jXp53WZF+DjtU9ydWE+cEZPvp9z4Ueiy
 0qeam94C0LvQaMQaA/3NUk02Qt00RAJdrAyC30Px7aDZoeGyrDqIl712ErgyQactBvcgro6Ns
 1A5My8dyPzjMGOwkiJ+oUbJe2vJI/wpqo3y8Tm7m9dmELVAXgGGZJonqIdQGNaagJL66lS9NP
 OEk+tPcVCPaIzoySNw4yDaTKJTOE4h3ojN+v79ADs2GUljQS+foE2h1xem8jMRg/lC7xQF3Os
 X4VI7YJTiLxklr0A+k3b3Gl+x7U5xKo4RnTRyW6yjnOFRRyJ8sWVxuS+WPQjEdsM3kwsjBUUX
 HgunsqnZPeFDRTVfM+te2MFiaQT9D//GTjVF7tsnMlq3lFuWGb75mt0wHcmoWVIFX1m6pu9/C
 /NlSSnQw1PzvYiNRw+WnIj1X5cw31U8sgGAUXf//EZMTdXHgNzY5tbxZcfnoTyMttjvTDX+Yh
 qOQ3nnXX3DVrBOhamu0d3Xl1ruNAgpfaZ8vWIziwdyakIlGZ5PhE3LRPEIbQQo8ZxLKxfs9gD
 jQwoIqcyRZfuMiwmW1YR6v8WdPLOnM2NRwNSb1bvn3fxzjmTNRKkqOw17E4tYSxL/4sb0O1va
 Gs/5OLbgKgbgmo53qefWvlL9Fxxpr831vJ7klLenA0kBeKGbUB/eOmcdIKJv4IWP4YOJJbQky
 37TJqTaFHTiRsUrnDGEmKeetCCyLDO5rhp5ezrsti4R6iZcF4thgbLq7zGIW6EjyTL3CrStas
 EuOwdXbMKG/Jaeu14KSlfvO40wHxrauVfltZD7AMczQPg9oP648Fy+edCN3DYv5a1tNnYNyVw
 rva7PwyxxG+oP8w6Ql9t4sfziv5HHTFjgX9G0wI/DP6ONHSPcTlQQWAiDz2AipnytaqAb48e/
 BVDl01zwJhkG7rgXRSqtt2yXJlIpvh+NgWCIVWrWtXvOVuTFaig2jhGc7SonWlrzcI/JAhilr
 4PNRQUphu6MOuI5/Xa+wHrMB1uYchApeXXBauEme5g01WEpRgVDH3uxouelEqBSb0uXmxoNGa
 pXFfVg9oJPrP5wCGNfK0wjyA12GHVIUvdM0vtkXYnB5Jr7+D2gxlaoh/WsrCSwxS0wwqvt+zx
 20ZdXHes4/1eSq24VAmtiiV0tSfqrgKt0auvygDyLokq3Y58XVzFe2kEZEx4vI/EdDfHFF+WL
 AvsWQ8ne9eoyBAQlCWU5auE1NibTvEFI49AMIQZmAnSclrblIKA2RRlfXtlS6g6U5lPT5hO8Q
 jJ/k2Whz6B+5M9n+bJaPgyH2SBh7B9+W1rH3hoQ5o16uXc5O9DysnQnwPuoz0kzc6+km+Anbp
 vbeohUK9DuKGG9fkZSjT6V8SpBkk1uA1KXDpzpNYRWKSc7GJTgjTxsTNJkHk48iE2nxUYOmD3
 P+aysMhwkjyQfXA9+PSV4WEsn2hl/lHUZHlExI4NB9zoFCxWERFnV/MLqq78yLP/dnbpbRRS4
 FqSdBEdtZTLuwd3E+h9oteY3tkPw1Hyf14Cj1OwiA72+a1/P2PJ2LX46vj6rxYurciUMuyYmn
 PWVAnkTXtavtwuCOUWU0OfM4r8UR6fJ0Hw4gIbjChd7D4GGE/6j+DYOc=
Received-SPF: pass client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30=
f:

  Merge tag 'pull-riscv-to-apply-20260109' of https://github.com/alistair2=
3/qemu into staging (2026-01-10 10:31:57 +1100)

are available in the Git repository at:

  https://github.com/vivier/qemu-m68k.git tags/m68k-for-11.0-pull-request

for you to fetch changes up to cad529260a8503b79d76589f1427ee592e31a801:

  target/m68k: Improve CHK and CHK2; implement CMP2 (2026-01-12 16:26:48 +=
0100)

=2D---------------------------------------------------------------
Pull request for M68K emulation (20250113)

=2D---------------------------------------------------------------

Laurent Vivier (2):
  m68k: fix CAS2 writeback when Dc1=3D=3DDc2
  m68k: link.l is only available with 68020+

William Hooper (1):
  target/m68k: Improve CHK and CHK2; implement CMP2

 target/m68k/cpu.h       |   2 +
 target/m68k/helper.h    |   5 +-
 target/m68k/cpu.c       |   3 +-
 target/m68k/op_helper.c |  20 +++++---
 target/m68k/translate.c |  33 +++++++++----
 tests/tcg/m68k/trap.c   | 105 ++++++++++++++++++++++++++++++++++++++--
 6 files changed, 144 insertions(+), 24 deletions(-)

=2D-=20
2.52.0


