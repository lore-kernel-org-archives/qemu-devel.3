Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 18:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn0zA-0003gG-5c; Wed, 20 Mar 2024 14:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn0z7-0003fs-Q7
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:48:22 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn0z5-0007KX-J0
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:48:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0067D61042;
 Wed, 20 Mar 2024 18:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5ACC433C7;
 Wed, 20 Mar 2024 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710960490;
 bh=ha1LEcL4Xc7VR4aNs9WU5Hfcva65yyOdxoxTKPlLajk=;
 h=From:To:Cc:Subject:Date:From;
 b=oA0bgX1wUh9xCKOVjft6pufVjps6S0kiO/H2oK4SeVjqJeU0gf1oUbxvdFeLGAnsU
 7Y64hkEfaiRc0eRNQ3JUjTjjpyQp6NMLEWcDEYbEBjtoND3hayEuhZNt0ZVhJa+7qx
 HsArzCWboyKj8/2oaICcWZGaf2d6JKEieI4wQudCndGGeZqpjDmMPLtCbMxnoZpJey
 MR7YQeaxBkPRSVcdG1+qo8waA4zHLLnxIQKfn2Nxweay7P4S+xhYyfUqDNgt48Awh6
 jxkfN7VfncGH4CFqSTOtPdylt7/Mfgd9yKPXNETD5RJgr6ZpH7zA34bST8jZ7rJf+c
 SRDxmHLnDsGZw==
From: Felipe Balbi <balbi@kernel.org>
To: qemu-devel@nongnu.org
Cc: Felipe Balbi <felipe@balbi.sh>
Subject: [PATCH 0/2] Add support for STM32G0 SoC family
Date: Wed, 20 Mar 2024 20:47:57 +0200
Message-ID: <20240320184759.754619-1-balbi@kernel.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=balbi@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

From: Felipe Balbi <felipe@balbi.sh>

Hi all,

These two patches add support for STM32G0 family and nucleo-g071rb
board. Patches have been tested with minimal embedded rust examples.

Felipe Balbi (2):
  hw/arm: Add support for stm32g000 SoC family
  hw/arm: Add nucleo-g071rb board

 hw/arm/Kconfig                 |  12 ++
 hw/arm/meson.build             |   2 +
 hw/arm/nucleo-g071rb.c         |  70 ++++++++++
 hw/arm/stm32g000_soc.c         | 246 +++++++++++++++++++++++++++++++++
 include/hw/arm/stm32g000_soc.h |  62 +++++++++
 5 files changed, 392 insertions(+)
 create mode 100644 hw/arm/nucleo-g071rb.c
 create mode 100644 hw/arm/stm32g000_soc.c
 create mode 100644 include/hw/arm/stm32g000_soc.h

-- 
2.44.0


