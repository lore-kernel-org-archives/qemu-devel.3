Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF8606A32E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=eJHkUByp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVuz-0003eB-Cc; Mon, 23 Nov 2026 10:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVrN-0001SB-RI
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:21:38 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVrL-0003dI-O7
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:21:37 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b4cc793704so23569927b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795447294; x=1796052094; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YoyzAh15+NSYeyDm4eHRz3J/8trqzznIPnykW7AlBmQ=;
 b=eJHkUByp4KHGk7LyzXAAtgRxnmxWi2/Hb3CwHiIQKAyL4Sga/F6y99OVJoa71YciSx
 XYgIE6B+3EdSYpJeC4HXFKqtqNIkkVcOaQnXSNUBR4u6vLCXxKGMwEMu8Of0v8Jtew3N
 /3lT2XeCs2LHel4vvuoN1DeTb8lVqNV6GldX7QYaqyeIERcq1/Lh2ALCXEOqv5VKUA5W
 IJ9ymzKLzmLiSOEEww/F1cVZQxULvhN1uTh1OGpjunhy6gkNER7tBvLJwNFCkAURVmVP
 tA3c+u+Havm2pMusY4YKlnqsB5lDz/HFJ104fi/YMpnONMoY6ztBwhizCfEyJ+rX1zT9
 bSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795447294; x=1796052094;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YoyzAh15+NSYeyDm4eHRz3J/8trqzznIPnykW7AlBmQ=;
 b=v6oqdDNAtmvC5xqw5shPh2t+z/x4X4jVVZRLmD9gOVPmLIZnTchSP/2QpxGkAHFlY8
 aR1z3X5/kWYhVdHbshBL/EhTEnhuubwZ1DfpZOXi+stNdDTmKINjcCH+t92hj5AqY0QP
 9pEyRPbo6iRuZ8D1caVFPfwrBiqt1302vS8a/KEDIHlG48Sehg5cy/61E7Vnr9QGfwyu
 WXtzuyX6F2YKCqgNLNPoedJ3OdZva98UcVuJjB2zu1UakCCKocURd+KZGOGkGaeQT/0U
 q/wkongr70J3kILlprqPYA2UGkFlHA7K1cKoFigLJy+JUtG9cCBD9ghrfSS7AVRRsy4z
 rOWA==
X-Gm-Message-State: APuU4Z8/2se4WVnM18+wPv0xuDSYioZZ6rsXu0J5Qi8t9bqScVMkPKJr
 Wwcba454BXm/M5+mQbNMpRVuYa3sXL9W9VfZEBCH4Eswm02KeIXVfs61B4HLUtOkH5g=
X-Gm-Gg: AZFdTZcFvvNq65nw2y+mJ5mCOVDVcfKeF7Jclm32PD+lK9wkrzC4obrWLUtJiifpjlz
 is0QzFOFyhZfHEYMRzO5F9NF+HXytx30kreJYxXnClXB9h5KoIF9BVqEyrBl8ChohYolKW0EZK+
 MSUPjjBAyJ+x/39VX+9vk/HCcF6P+C9LFoQ1PiiPW7GVICnPeHpv7d2EFy3H3llo3lC4hhfeli1
 hBnrH4SApGN9XcxBz3voihprZVDtCQVLJ6oYtOe9D9uU9ATjPLNO7aBqfWKW8l/wtcuBjJJfRLi
 jsD8MUBXLt8djPEfwcFeLzqiwI2/g+tJxpxNy2O0uN+3Kl+SJCQFC+X2Kr2NHmeBY/x7UyoUng/
 H3h/D9fjGf2frAA30g5M3nBMuxvhmKij8b2DdHuYnt9tOeyimwHtzPuy/FkpPKg8bLBH+ZNt3wW
 zYvMjdQyHOqMGl0jMFUMMx7/VsJTfjjfrfuXRJ2Ts88exeGiw8eo7PdujEunuuPZ5X9iYVP8rmP
 ZrTgs5fMajGY/aY3vyW+8iN9GKN5fZyReZj3HMDxqdjVb/h6DyMJOo+9ZFaBVGcJ1RY2C+K3UNq
 RdjH1YwUXOtPeoGJ42lMwV0s0TaCc15d6ZXX1HEXx+Z0g65w6Xz/vKfGDkWcYfs/9qmTI5Vbimy
 SCvO4zDDzUx7pV3t6QTaALRoxtCTNAw==
X-Received: by 2002:a05:690e:812:10b0:67d:ea5e:e50a with SMTP id
 956f58d0204a3-67df442605amr2554729d50.46.1795447294253; 
 Mon, 23 Nov 2026 07:21:34 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:f880:d5ac:69f1:fb89])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67df3353258sm5747939d50.9.2026.11.23.07.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:21:33 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH v2 0/2] m25p80: Clear write enable latch (WEL) at the end
 of SPI operations
Date: Mon, 23 Nov 2026 09:21:15 -0600
Message-Id: <20261123-m25p80_write_enable_fix-v2-0-0ac94f99e91f@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtZBGsC/4WNQQ6CMBREr2K6tuT3E0RdeQ9DSFs+UiMtaStqC
 He3xQO4fJOZNwsL5A0Fdt4tzNNsgnE2Ae53TA/S3oibLjFDwIMQAviI1XSE9uVNpJasVA9qe/P
 mXd2fqhJEjSWxtJ48pXgzX5sfh6e6k45ZlxuDCdH5z3Y9i9z7/zILDryUKJUGqFHBxYVQRLJZ5
 cnGQruRNeu6fgHmVyK32gAAAA==
X-Change-ID: 20261110-m25p80_write_enable_fix-d7f95301723e
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The m25p80 model in qemu doesn't deassert the write enable latch (WEL)
at the end page program and erase operations. This series contains a fix
for that, to match real hardware behaviour.

This series also has a fix to the aspeed_smc tests. These tests exercise
the m25p80 flash model by sending page program (PP) ops, but do not send
write enable (WREN) before each PP op as the spec requires. The test is
updated to do so.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Changes in v2:
- Add Fixes tags to both commits
- Link to v1: https://lore.kernel.org/qemu-devel/20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com

---
Anirudh Srinivasan (2):
      test/qtest/aspeed_smc-test: Send write enable before each page program command
      m25p80: Clear write_enable after page program and flash erase operation

 hw/block/m25p80.c              |  6 ++++++
 tests/qtest/aspeed-smc-utils.c | 24 +++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
change-id: 20261110-m25p80_write_enable_fix-d7f95301723e

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>


