Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AB606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=GmQWX03o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Se-0001kT-C2; Sat, 31 Oct 2026 04:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4ST-0001iF-3Y
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:03 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SQ-0001rn-NL
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435333; x=1794040133; i=deller@gmx.de;
 bh=VUr4y7DUqQOoZSpcL0p05CEdPwZ5QqFS5uZLGpRL4UU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GmQWX03ontgVF74sb+aYCJ7qO+cMfWouxd2/SvWlTDTa5734EOWVfcjCF0pxoS7l
 BfTI9ETCpHjPn2hve5GVMWy2KFg74MEl7OllM5IcpaPLMjwjIKd8HkXEt10VML24t
 /6yOhYItH/X7eL/RDsCZTYbRP83FBnGPAymu6omU94W4r4BKFsovydNueQWAyeeBf
 1yjk20Q/jfTSfaEBwGQwmFZk611RfmY8Iv7G81NVT6xxNuCuWUOxVA7Hurp/J/KDK
 6EIxSFB5coBqmihkj+BMh7W9aGiit8PxDQGJksyGG5ulmQvU02MoXBlY1sS5xuBSU
 frADqwjPq1Y8Odst8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1xSJmz3GOb-00Ebhg; Sat, 31
 Oct 2026 09:28:53 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 00/10] Hppa 715 2 patches
Date: Sat, 31 Oct 2026 09:28:40 +0100
Message-ID: <20261031082850.439293-1-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LhdTzrwHtgjn7Apnjplcc/ZmiT5/b7yF4/t+Ko7qqukivYFEHDx
 oscZAq5c8xJH7FlPwmkjV/IVQgEasqNPTdSAsWKSakHHyPnuFYXolYRdemHXr4/UsXhATbz
 0r9n61oQCt5ZWnIde22gYW1Cz7iAI8cVQzGI6ta0dzWc4971avtKnM82w/DF/4bu5MrKYk+
 mE611gReeNYF132q5ZpaQ==
UI-OutboundReport: notjunk:1;M01:P0:Bk5WDG3mggs=;SbKHnNz4wG1hOcRhkOiNCPQOmfd
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2=
b:

  Merge tag 'qga-pull-2026-10-28' of https://github.com/kostyanf14/qemu in=
to staging (2026-10-28 06:21:59 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-715-2-pull-request

for you to fetch changes up to 98c37479afc7acac3a155eb541d1c3fdb4c1255a:

  target/hppa: Map CPUs at same addresses as on physical machines (2026-10=
-29 19:14:55 +0100)

=2D---------------------------------------------------------------
Hppa 715 2 patches

HPPA architecture patches for HP-UX 9 and 715 machine

A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
Includes a graphics/artist fix, adjustment to 15 bits for protection IDs o=
n
the 32-bit CPUs and various other parts which were missing up to now.
Included is also the FPU patch from Kirill A. Korinsky and a new patch fro=
m
Keith which fixes the 32-bit load of PSW on big-endian machines.

To fully support HP-UX 9.05 an additional NCR710 patch series will follow =
soon.

=2D---------------------------------------------------------------

Helge Deller (3):
  hw/misc/lasi: LASI Harmony Audio presence emulation
  target/hppa: Update SeaBIOS-hppa to version 27
  target/hppa: Map CPUs at same addresses as on physical machines

Keith Monahan (6):
  target/hppa: Use 32-bit load of PSW in rsm and ssm
  target/hppa: Use 15 bit protection IDs on PA1.1 CPUs
  target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
  target/hppa: Implement local broadcast I/O space
  target/hppa: Preload I/O-space BTLB entries for LASI and the central
    bus
  artist: Redraw screen on colormap changes

Kirill A. Korinsky (1):
  target/hppa: restore lazy FPU context isolation

 hw/display/artist.c                   |   6 +
 hw/hppa/machine.c                     | 106 +++++++-
 hw/misc/lasi.c                        |  15 +-
 pc-bios/hppa-firmware.img             | Bin 641484 -> 634968 bytes
 pc-bios/hppa-firmware64.img           | Bin 682800 -> 682880 bytes
 roms/seabios-hppa                     |   2 +-
 target/hppa/cpu.c                     |   1 +
 target/hppa/cpu.h                     |   4 +-
 target/hppa/helper.h                  |   1 +
 target/hppa/mem_helper.c              |  25 +-
 target/hppa/translate.c               |  65 ++++-
 tests/functional/hppa/test_seabios.py |   6 +-
 tests/qtest/hppa-fpu-test.c           | 371 ++++++++++++++++++++++++++
 tests/qtest/meson.build               |   2 +
 14 files changed, 580 insertions(+), 24 deletions(-)
 create mode 100644 tests/qtest/hppa-fpu-test.c

=2D-=20
2.56.0


