Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B58606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzNay5pP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAv7-0005yB-AI; Thu, 19 Nov 2026 17:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv4-0005wz-6O
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:54 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv1-0004Gj-1M
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:53 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF01F4467E;
 Thu, 19 Nov 2026 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAFB1F000C4;
 Thu, 19 Nov 2026 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795128467;
 bh=Syv35jHDqQcS27SgmH7IjE9J1k2g/lIbd6dvihp855w=;
 h=From:To:Cc:Subject:Date;
 b=hzNay5pP0yGrgThsCoZvPam6CNo8GEfrbVEGCMmEZOFGcPSRN9Bd41ExmaL6TIlGh
 /6oMNRqn5djLGu8EceDexwipQcfZH014xsry5vfAb0XijllfYm6a6rbzT7C71nXLbe
 QR0X3OKi/8znF9F0LFfSlJgSP9jeDiUv/saIHxNf/J0vOGv7u6vlSrByS2LCtdQGfU
 A8FdCFpNqT7hs4bBhA3yv4X1EBCptgChwIiICCvLPJDiWEVfIzg0otOq3ReiPPL6/u
 pgM3cBSG34XzQo25CtQI/Hhk+H2e010UldOfFord6cls1nQ9UA5u68sNSHlcwGHoF0
 S4T4gNne01gJA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/4] Hp715 fixes patches
Date: Thu, 19 Nov 2026 23:47:40 +0100
Message-ID: <20261119224744.31309-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 45b7c3e45e2b778e560a0734daa6aa0059bc0edc:

  Merge tag 'pull-ppc-for-11.2-rc2-20261119' of https://gitlab.com/harshpb/qemu into staging (2026-11-19 09:17:10 -0800)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hp715-fixes-pull-request

for you to fetch changes up to 42497091287f8ddbcb7537a8d1f28073430062d0:

  hw/hppa: preload a BTLB entry for the soft power button page (2026-11-19 22:58:20 +0100)

----------------------------------------------------------------
HPPA 715 core fixes for v11.2

Four patches from Keith for the 715 machine which fix interrupt issues, and
netbsd boot issues due to a badly mapped power button. For the latter a
previous commit from me needs to be reverted.

----------------------------------------------------------------

Keith Monahan (4):
  target/hppa: clear EIRR under the BQL and keep the interval timer
    matching
  target/hppa: re-arm the interval timer after loadvm
  Revert "target/hppa: Move emulated power button into CPU I/O region"
  hw/hppa: preload a BTLB entry for the soft power button page

 hw/hppa/machine.c        | 14 +++++---------
 target/hppa/cpu.h        |  2 --
 target/hppa/int_helper.c | 23 ++++++++++++++++++++++-
 target/hppa/machine.c    | 13 +++++++++++++
 4 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.54.0


