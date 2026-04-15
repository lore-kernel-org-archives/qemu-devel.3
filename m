Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0917FA0C39
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCu3U-0001KK-T3; Wed, 15 Apr 2026 02:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3Q-0001JM-Oa
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:48:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3O-0001fc-6i
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:48:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so61102475ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776235729; x=1776840529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=WdZjmiP4vh/w8MYVzwdlVgguAaDE/OLRbREjHmN8D+M=;
 b=f3ubI1oGLWabOkwI8ob286EVf5LULbsongP2FncleJxL//N/U8GCG5jIyah3EiZzvO
 ojmqpP6dG4aebnmZjiXsePFUBMDLxaCU+Cg+pgLSR+VT292B5VMwOSvnnndEN7WgCmhU
 jmpNgaGj/fJEdUR3OLqBxyPsBCYkoZ4kIuPepELnlbMJ6QQdNX/yW/ChNOcDQ6MyiE8V
 bEkLUTKT9juG+OxvyGji06fr+cnTtMzBrfODjKJfOI3NOtb1PHHHw474vCm/0FGdyFP0
 fP87L447XTZ41aJspUcPTL/kQDb4GEMCmJisWkCYFA+BFQskFAk+b2Ipp/EWKjpXmPPx
 lBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235729; x=1776840529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdZjmiP4vh/w8MYVzwdlVgguAaDE/OLRbREjHmN8D+M=;
 b=P47eW/utRc1eitsLLINNjo+Dg6EFdYDA95lb+h+SR4460eKJ5+wUTYbNnt+ytqqNsx
 HMb9EIJ7zC2F5DTD4ILyyeSumT0Y1CUtm1QBeScco7ewuvO3EOx8z8WBumt4g1kVP8Xi
 5LXK36qLqlqwP7i8ziUMtZO29lWjNXqUscla6kxE8YTMSqkhZQ6LPnOu2StYX6wgSu/y
 yb1AsjozFeMFDJCuKeygFHfzFoB3rui63mkb+aZPum3ujsmGZx36DwZmTa073XTbgxZc
 guJ4eOUcJfhyhXswp/rOCqJrbhMfQUgaNSQitpkEVb9GcKdoI9LOM7spQkS2hFjk3yWY
 OoEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+48OPYPFa0rXCfJxU/JRNKpTEf0WoFWcqmrisbwkEyjc/jHQo4yT9UJTDlDFolM00grxBxA9scB/DT@nongnu.org
X-Gm-Message-State: AOJu0Yy0D6xQmusUWrvbsq+F6vyMdoePLnEo3lgdP5c+vveWDf9xDGX0
 GT+PdcNagcwyj/9WePZWq0Ku7Fn5gfqJEqwYJaUgN1RDD/BnDtnVXtBP
X-Gm-Gg: AeBDiesI/8IMhOo+kkUW5f6AmKlqHADR0c25Iu6XkbUTIk6gRvtOtChnirxZaBpZfmV
 vfGwY+W8Vc4Vy4NL/uq7VfWhZN1IcpJwB4pQxouoRFHkcBLz4h13Yie9Cbq/SvXOBPE85B9vibw
 ceGQPUUz48IIaqXTii7Dr8eblcItLYAaICjnpE1fgXW6w8uF9+oX65WiMMqZBDjcGrMI54qtu53
 xt5WoipEXxwnyNat/epC5KJs+vlzaDafvjFA2xl3UQ2Vjhe7WZiPwwXzK8TpXXnYsmq60bq9fIH
 oBk/cTTjJ/YieQsoQR47KFPxZHXqijDlCmf1U2TUSqjCqkqg1tWHEu0kSgdQTxtiJE3pCCHNZLE
 Fkgg7g5MpwBM1rUaOkHuD4xcBw+27S72xFKcfu1xHQaTPskylm4LqVKpCYsynFXTH26eR/ZRCI8
 aV04sirbfo/0fSdeDwb7maIYGlUvzpssthsQN+CI9MWb3rXdqCuGIujAI9ZsLTO/816LxheU1ZC
 sydn+TmhQwsHdySFkKJjQ==
X-Received: by 2002:a17:903:acf:b0:2ae:ce35:2686 with SMTP id
 d9443c01a7336-2b2d59393fcmr210903245ad.5.1776235728577; 
 Tue, 14 Apr 2026 23:48:48 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478142565sm10353195ad.37.2026.04.14.23.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:48:48 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 0/4] hw/riscv: Boot setup improvements
Date: Wed, 15 Apr 2026 16:48:32 +1000
Message-ID: <20260415064838.652297-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v2: Tweak commit message in patch 4, add Daniel's r-b

The first two patches improve the boot infrastructure for riscv so
machines with split memory regions can load payloads into the correct
region. 

The second two patches improve usability when attempting to run opensbi
in less common situations.

This series are prerequisites for the Atlantis machine.

Nicholas Piggin (4):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  hw/riscv/boot: Warn if a ELF format file is loaded as a binary
  hw/riscv/boot: Provide a simple halting payload

 include/hw/riscv/boot.h    | 14 +++++++-
 hw/riscv/boot.c            | 73 ++++++++++++++++++++++++++++++++------
 hw/riscv/microchip_pfsoc.c |  6 ++--
 hw/riscv/opentitan.c       |  6 ++--
 hw/riscv/shakti_c.c        |  6 +++-
 hw/riscv/sifive_u.c        |  3 +-
 hw/riscv/spike.c           |  6 ++--
 hw/riscv/virt.c            |  7 ++--
 hw/riscv/xiangshan_kmh.c   |  6 +++-
 9 files changed, 104 insertions(+), 23 deletions(-)

-- 
2.47.3


