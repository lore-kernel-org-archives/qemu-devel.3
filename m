Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6FCC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5BR-0004oU-EM; Thu, 23 Jan 2025 16:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5BP-0004nt-Pk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5BN-0002hF-Kc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1388529f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669372; x=1738274172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5VWfaC8kXx6Ag9VWFTq9PLW1Szy2XsyyXyNP6TzpwYM=;
 b=stHXLLdWMQ6kTM/CNpB2Sh4HK3n7v+IRi6F7eLDUmIyVbB3MaJrsr6ZM18RXGli/GL
 BiN63Mbgza8/qxU/0i4DU8uH1PLDlVufes7t//WYZ18rBPOgXqm8X0M9FRqGRog0r5TF
 dhsw9lVojOdAAGzd8L4PrV9ocdggn/iFgCyBNIca/HkTjezZANU2nG/Lnvk/xZEB+V3q
 qhZ1l7v94KAR/oqaJDLWRHOoooFQi0pnd0J8jhnKIg99rAdw6XnJvLcDNhoUG66CHDHL
 j8nfUQOP49wZdRFwcsonDid9B+Bo4pA+smDNmFTgBkLegLWbsJ+zEsD0eF4vIjxL9H1+
 GzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669372; x=1738274172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VWfaC8kXx6Ag9VWFTq9PLW1Szy2XsyyXyNP6TzpwYM=;
 b=g1zp8jnVw0OgMzv1YziB2tkWhj3XS0mi2Q8OkFz5SqmrBJVT/GIAMA14hecnLmrZDc
 fBw9NR+mNGiX00TMKbZuAktge8zUbjSvv2RKk37Jv/4Wx5JVCSVEjoP7YPPzLQrB2t75
 LJMv3NwofRXnyQXPfDBcLM7GzL/eNjW89lHm8mIOE1YVgCNpLqrC05eB8NGiyTIdzXQ4
 UACumY8jxzHc7gf/OArmmWQWEmsz8b140uP7jdw5DNMU5LSqz5sKwkTT0REruyDyx7IT
 JYRmBmqIm1o6ItWB4zAXETMkaSeRDY8xOBS2wp3NCqS6ySSNcL3igQ9sa89lS+yuNgll
 rYvA==
X-Gm-Message-State: AOJu0Yw+3V5lQaOY8Nz/2yxoNmCBgTXw/iCdGN68pYbUBuQyFUVhSrHh
 iFH6Zupg9K+L+6zl31zO9OF9Y9e08ANGiHroKdQ4dRj0NXM/IRda3HNtvCrY3aeKKxg9XB+a0yI
 zUZc=
X-Gm-Gg: ASbGnctt0uxR89LbEyOWOdjiNF9FZMWw8plEpiPimQCmp7k+5Fskvk15ygkhOpFsMux
 E5eNg/GfwETDd/T3mA2GZMKmq+WxoDI9iDAGABxZ39+UWEHTzIoMWCNsuJ95IGk9bBr3iLtruog
 ZE+z0+IfKb1PhaH5P0vu9UzGMgNMO4woi9SNmvoHqor1VYbf9PhwdqfqgVZaEO0TCvDM62uZG3c
 NhBffvlh/TzQ2gdJcSWDW4ouh91Pd2v0rR8Ou8/mkGt/QL0EQqzejxSVeJJRv+aT8tS+bcYZKRF
 1aCb9vJqiqs/nkfiJGh231t39R4kngrqHyYkp7EQ592/4q3pT5CQphU=
X-Google-Smtp-Source: AGHT+IF31fPoBhra9KXp40y/gW/MsJUnIjcJvH++tsN2b8Twv0ZG9UE5aIQNTtVNzvqOj4Uqa0ty7A==
X-Received: by 2002:a5d:588a:0:b0:38b:ed18:2f3b with SMTP id
 ffacd0b85a97d-38bf57bfc8cmr26593229f8f.48.1737669371588; 
 Thu, 23 Jan 2025 13:56:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d865sm815323f8f.38.2025.01.23.13.56.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/15] target/ppc: Move TCG code from excp_helper.c to
 tcg-excp_helper.c
Date: Thu, 23 Jan 2025 22:55:54 +0100
Message-ID: <20250123215609.30432-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This series is a simply a cleanup restricting TCG specific
exception-related code to TCG, by moving code to a new unit
named 'tcg-excp_helper.c'.

I ended doing it as a preliminary cleanup for the "Extract
TCG state from CPUState".

Diffstat shows 1K lines moved, but the patches are trivial
to review using 'git-diff --color-moved=dimmed-zebra' option.

Branch published as:
 https://gitlab.com/philmd/qemu/-/tree/ppc_excp_extract_tcg

Regards,

Phil.

Philippe Mathieu-Daudé (15):
  hw/ppc/spapr: Restrict CONFER hypercall to TCG
  hw/ppc/spapr: Restrict part of PAGE_INIT hypercall to TCG
  target/ppc: Make ppc_ldl_code() declaration public
  target/ppc: Move TCG specific exception handlers to tcg-excp_helper.c
  target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
  target/ppc: Ensure powerpc_checkstop() is only called under TCG
  target/ppc: Restrict powerpc_checkstop() to TCG
  target/ppc: Remove raise_exception_ra()
  target/ppc: Restrict exception helpers to TCG
  target/ppc: Restrict ppc_tcg_hv_emu() to TCG
  target/ppc: Restrict various common helpers to TCG
  target/ppc: Fix style in excp_helper.c
  target/ppc: Make powerpc_excp() prototype public
  target/ppc: Restrict various system helpers to TCG
  target/ppc: Restrict ATTN helper to TCG

 target/ppc/cpu.h             |   5 -
 target/ppc/internal.h        |   6 +
 hw/ppc/spapr_hcall.c         |   6 +-
 target/ppc/excp_helper.c     | 943 +----------------------------------
 target/ppc/tcg-excp_helper.c | 923 ++++++++++++++++++++++++++++++++++
 target/ppc/meson.build       |   1 +
 6 files changed, 950 insertions(+), 934 deletions(-)
 create mode 100644 target/ppc/tcg-excp_helper.c

-- 
2.47.1


