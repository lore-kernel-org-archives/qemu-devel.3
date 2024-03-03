Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83178C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 05:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgegY-0006My-Lo; Sun, 03 Mar 2024 00:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgegW-0006MY-A3
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:46:52 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgegU-0003Sq-Kd
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:46:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D4597601BC;
 Sun,  3 Mar 2024 05:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BDFC433C7;
 Sun,  3 Mar 2024 05:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709444808;
 bh=mLYFY4A7BeiD5YOQKXZ5xrcH5Y1m2DlFCP6A02xNApc=;
 h=From:To:Cc:Subject:Date:From;
 b=oRHNWeKQMbJ4RVI8HpNlxDsesxTFSJwbx4EYGJR/VPD67FfsXy8Pk66l3bhxyjhNN
 GdV8+v1eBbB6M4NzoOhD6o8fL8nTRV16zlD29dtKgMl/SGBl9JWMnifO1QL2sbIiv7
 e4Cb0Zls69A32yL3mOJQqwr2EsyNayXmZoH+BIlAvt1deV18Cgc8tdmENoX/i7XDfu
 8D/Gvkh0CTFfo8QsYxa8/D56IHwFnueompZ3up4acSNTdNkrecX0fxLD6+GP4nXFDr
 kQRaIU1Eq83qk0iJQ5FDbH1R2uMYx1qdpUtnAv/JNq0D2B3+3bkFrP0Lv6j7+NRmUD
 3virB7JqUocMg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 0/5] Hppa latest patches
Date: Sun,  3 Mar 2024 06:46:40 +0100
Message-ID: <20240303054645.3004-1-deller@kernel.org>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:

  Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-latest-pull-request

for you to fetch changes up to 839a88e8bd1a1efe05844c39a59985482894f4de:

  roms/hppa: Add build rules for hppa-firmware (2024-03-03 06:41:19 +0100)

----------------------------------------------------------------
HPPA64 updates

----------------------------------------------------------------

Guenter Roeck (1):
  target: hppa: Fix unaligned double word accesses for hppa64

Helge Deller (4):
  target/hppa: Restore unwind_breg before calculating ior
  pc-bios/meson: Add hppa-firmware64.img blob
  pc-bios/README: Add information about hppa-firmware
  roms/hppa: Add build rules for hppa-firmware

 pc-bios/README           | 6 ++++++
 pc-bios/meson.build      | 1 +
 roms/Makefile            | 7 +++++++
 target/hppa/cpu.c        | 3 ++-
 target/hppa/helper.c     | 3 ++-
 target/hppa/mem_helper.c | 3 ++-
 target/hppa/op_helper.c  | 3 ++-
 7 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.44.0


