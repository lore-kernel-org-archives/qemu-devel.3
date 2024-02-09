Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1944C4829F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPVL-0003lg-61; Fri, 09 Feb 2024 06:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV5-0003eB-VV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:57:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV2-0002SO-8y
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 80F346208D;
 Fri,  9 Feb 2024 11:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE736C433C7;
 Fri,  9 Feb 2024 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707479815;
 bh=/Smd6TlhJ7ils6p1rE0hxNHghyQlnq/f2lHer5smscw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CxS4vvEZ3QLqN4fKSSXR53yJ4IKgq8zMMSQpU1uahDZ36XcZ7/HjcmJ9RdoPpxs0P
 MPflSsomeg47bTTju/kzsyLmElqITveryHaroNejY1m6OeqeVrdlcS4J7DIbGdOq1p
 j83o030ltAACUwYELWytXy3ho+0bcJPbCKYeRNpBa0OqijjPSOE4HOf2m3Nc6bvl/7
 z/iBq5tVSWyZGROw1+c9LKoBuCi2eb9NLlqFB9nevsVy5or2e9ZG+uml7AG+J3Gmsy
 jjyqJwlW755ogPCWgHsITGRdYhJvRgx6hRbuavNFiHcbb3/CxynDA44OggMNMTW5lw
 F8ghC+ldT9HDw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 11/12] target/hppa: Update SeaBIOS-hppa to version 16
Date: Fri,  9 Feb 2024 12:56:32 +0100
Message-ID: <20240209115633.55823-12-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209115633.55823-1-deller@kernel.org>
References: <20240209115633.55823-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

SeaBIOS-hppa version 16 news & enhancements:

- Initial 64-bit firmware release
- Added fault handler to catch and report firmware bugs
- Use Qemu's builtin_console_out() via diag 0x101
- parisc-qemu-install Makefile target to install firmware in qemu
- Added -fw_cfg opt/OS64,string=3 option

Fixes:

- Avoid crash when booting without SCSI controller
- Avoid possible crashes while detecting LASI LAN & graphics
- Don't check layers in PDC_MEM_MAP_HPA, fixes NetBSD
- Ensure cache definition does not trigger endless loops
- Mark B160L as 32-bit machine in inventory

Signed-off-by: Helge Deller <deller@gmx.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 roms/seabios-hppa | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index e4eac85880..03774edaad 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f
+Subproject commit 03774edaad3bfae090ac96ca5450353c641637d1
-- 
2.43.0


