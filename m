Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220BCC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kSC-0002jT-DW; Thu, 10 Sep 2026 15:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQH-0002Gi-VW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:09 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kPW-0004dG-GV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068347; x=1789673147; i=deller@gmx.de;
 bh=LHFdTcBUWU6Ue8Ny1E4LW/F/BIYE44KH5f1YUoO4xeY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=R4KG+Z6ztn3g5BwPyo2cHSb8XukovX0TrbMRF7gH4WN8uSIRop5eg/ON0wBtft4K
 64JxJ/7FKmfbyoLI/BKTYz6OSbVlwZbJXzlRwqw3KaFS7+SMqooZSEnlhI0h6mfcO
 0inWcIIZ/KywK47XDadPqdIairPaSKVXBrTMr1yyBYBETuvnQgvwKSiorEPYZ/HgF
 XVPguw0jbCb6lxvCQUMDgmemkPF1OiFN20xUk0z9reswSwVarvQ8/21dUNBN1ca3v
 piEsuXKcfxjsWwkFu4H1Tu0+J4C8yxhxdg1jhCuea9HV3DIFh6gYnLLM0Oy5wzQKf
 EHs3lDKoHz6GPySOHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1wmo930aby-00thUc; Thu, 10
 Sep 2026 21:25:47 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/7] Linux user patches
Date: Thu, 10 Sep 2026 21:25:37 +0200
Message-ID: <20260910192545.768850-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVsqoHopur57Aj2M3U7PPQYLsOD9jSS/23GCDUP3ZYX7LhxNN2W
 N2aeLnS5wAojOp87zxTex0xsHrCfv80aKwlh29+S3nErNlKTtoYMnduzhL0czoyozhxlbGa
 1zp+Rc0EFD2R0Dmy533/4wt72Pci5EaVIoQgYJC+nFf0/I3xvekg39Pz1AUQCEcBv38ypDn
 WLJ2iOPT7+WiiD2Gw12LQ==
UI-OutboundReport: notjunk:1;M01:P0:uoAODiEmlu4=;fWZQPZqYuAh5T6PictH04tsbvyc
 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
 LH1xN4FQKOXm9Qi4QvUjcx
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d=
6:

  Merge tag 'qom-qapi-pr-pr-v1' of https://gitlab.com/marcandre.lureau/qem=
u into staging (2026-09-08 18:35:31 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to f67617fc82b32022901cc4d566caad618f945611:

  linux-user/x86_64: write the floating-point registers to a core dump (20=
26-09-10 21:16:34 +0200)

=2D---------------------------------------------------------------
linux-user pull request

- madvise fixes
- fix sigcontext on x86 to show correct trap number
- add hexagon HWCAP support
- add FP registers in coredump on x86

=2D---------------------------------------------------------------

Alex Benn=C3=A9e (1):
  linux-user: madvise() on unmapped ranges should return ENOMEM

Brian Cain (1):
  linux-user/hexagon: Add HWCAP support

Helge Deller (1):
  linux-user: Fix target_madvise() to always return TARGET_xxx error
    codes

Matt Turner (3):
  target/i386: split the FNINIT out of do_fsave()
  linux-user/i386: write the floating-point registers to a core dump
  linux-user/x86_64: write the floating-point registers to a core dump

Nat Brown (1):
  linux-user/i386: report the real trap number in sigcontext.trapno

 linux-user/hexagon/elfload.c              | 61 +++++++++++++++++++++++
 linux-user/hexagon/target_elf.h           | 30 +++++++++++
 linux-user/i386/cpu_loop.c                |  9 ++++
 linux-user/i386/elfload.c                 |  7 +++
 linux-user/i386/signal.c                  |  6 +--
 linux-user/i386/target_elf.h              | 18 +++++++
 linux-user/mmap.c                         | 20 ++++++--
 linux-user/x86_64/elfload.c               | 11 ++++
 linux-user/x86_64/target_elf.h            | 20 ++++++++
 target/i386/cpu.h                         | 12 +++++
 target/i386/tcg/fpu_helper.c              | 13 ++++-
 target/i386/tcg/user/excp_helper.c        |  8 +--
 tests/tcg/multiarch/linux/linux-madvise.c | 20 ++++++++
 13 files changed, 221 insertions(+), 14 deletions(-)

=2D-=20
2.55.0


