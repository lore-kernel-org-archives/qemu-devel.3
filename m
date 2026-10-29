Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C03606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=BRpIeu7r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCP-000404-Fb; Thu, 29 Oct 2026 18:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC4-0003um-I5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:57 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYBq-0006Vy-LO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311298; x=1793916098; i=deller@gmx.de;
 bh=iUQXsupoyC/nLn+1UVRAn5s20141P+RLMGYQcdbK8vM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BRpIeu7rZrgZzSGKsZ8thNh5ymOSZRRofbrdmlUsGLCHR50wiHXsxa+Jx8ZgrG/A
 kMDjtn3+yHC2KH2bSw9UoTc23qSRTZLvRumj7d4B/Y9TKbOvGpd0ctj5kJ9zBAkTN
 oevfui8cNJ0ZaGZ8aeH1Iv7GeZ7+4G3fyO6u/7p/DyIQMk88f9rmtzXwAfoKZP3w+
 Vj5lGygA/VATvH5fz3HgUt6KLNf94p18UDCHlXAn20hdsb/6tGGJ1Coz782GPs1bP
 Gf7eucnQIpD2Qhb0uEEpWWwron2cAVFeca0fgFX3Ai8scQOUEOXRELtDp4ZO4j6Wf
 k24BenHzfr+cjlfOsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1xMYBl34jY-008dZZ; Thu, 29
 Oct 2026 23:01:37 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 00/10] Hppa 715 2 patches
Date: Thu, 29 Oct 2026 23:01:25 +0100
Message-ID: <20261029220135.412284-1-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dpl5Hkhd25WtNHphTjWPk6h2MYtyQYBqNbra539m6FmNENSI4P3
 WNSfX1qalbCDS/JWIKF2ll955Ik6whnBR39QLPB0rFaB2dYQDCxE/YB7FWiNtiIJGRJZNRB
 gUZXGMlJr/enrQyVR83JIj5khrebObwKOJnVEUcws4Orbcjd+byKcjyrSxUAUqn3Yw8kVbm
 C2jfMfb0JsWtA43cYP22A==
UI-OutboundReport: notjunk:1;M01:P0:ukJUZyQjETo=;flz3XNCyx26oxyrxg94GG2l99wg
 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
 z9XujwD1scacC8/0yp/YKUzxxKseq+9mB
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HPPA architecture patches for HP-UX 9 and 715 machine

A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
Includes a graphics/artist fix, adjustment to 15 bits for protection IDs o=
n
the 32-bit CPUs and various other parts which were missing up to now.
Included is also the FPU patche from Kirill A. Korinsky and a new patch fr=
om
Keith which fixes the 32-bit load of PSW on big-endian machines.

To fully support HP-UX 9.05 an additional NCR710 patch series will follow =
soon.

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


