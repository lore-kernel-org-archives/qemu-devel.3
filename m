Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE4FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDi0-0003YQ-Hy; Thu, 06 Jun 2024 10:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDhq-0003Wu-1a
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:07 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDhn-0003Jp-C3
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:05 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-79523244ccfso75541885a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717682582; x=1718287382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CtwWyrZU1KCcn4ruTR9XofcdKuHmmRpHq/9UIGzeHqI=;
 b=F+cQR9dvSBvnnxI8UwqYh0ZShxnNp+5ZtJAP/ZwXwPQ557eLqI03Xk5mwcctn4P+lR
 JvtpvrUjcbObN4yQqeSc3//rzqbRKShi7r2xNtKW0mqOcvIpLYdRZWchdKDGBfAxcK7n
 ivE904eKAYY89Y8u4DKhR++yVwVZYXjeQN5i9NQpcXWMUfrwD4A9OE8fsfTLNlxnl3IO
 iwcibue6ltqAi9wchT4S8FBXtCw5SirDSW1RUNNbJj4BFDJ7C6/vr+grDqvhZaXNH5F5
 GmsLh5stkdi0q6MkXgmhJaiKCD1ZrH5td5ZOFCN+bQfSj+nhZOhCd6wNSLkRL7yOd9iN
 W1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682582; x=1718287382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CtwWyrZU1KCcn4ruTR9XofcdKuHmmRpHq/9UIGzeHqI=;
 b=Pm0fgCtXdqPhZezVaZMrHGQSryIlBb8n49EtWIZQGBcBOKnL/026kn4rbZUBK5eh/W
 Kwgg9Sy4FEh/yoY1O6Kgvct8GdRsRsKaVIRIRBDZ5bB4eyk2U8aSNkeErH/A/JJK/zJY
 t67tmUqI9gaNc9olhyCNDFAz1LJuWzjwRjZoLMGM9JaANbm4RHbZhIgCghGn0qGb8Wgr
 kuZxOiI+h7ZpiIfGGOqz9OgHOILwUSAFRLtcjkqhmHdzuRLgrbsmBKDpvp8Kzt4jH3lT
 mNTVpD6wJj7XAERZ3WA8JzYxEJ6CZWfEw0b+M3MLA2d885UfEpaxslXwMTrSFQgR8buR
 JE4Q==
X-Gm-Message-State: AOJu0YzJ/v0B/hn8ShZw6jK+wENeN0KeGe3HheojBIfOcY+U9FwVIEtJ
 hVICpImPrWdaiv0rLE0yMnTvvsCFzfwYeFGHpv8EA6vEPFEaPk2pvSS3Jr8CDQmoMBSHqN7MDge
 FbnmKVROlfdfMSjIJZyhAWitGZhvTWFh41yArBv1Li6kdcPgNeUl/WfrllH+IJ/OLYuAnIQjgSa
 UouA6aG0WPOHtM6a40K44bQu8ZyLjc
X-Google-Smtp-Source: AGHT+IGWDlhH4cgjcy+KJkbuIFwsEON6AfMBZwpmcT6UEGInnSeg1TcZ4ow18jIUUxdze5bqLAU4sQ==
X-Received: by 2002:a05:620a:460d:b0:792:fe42:27dc with SMTP id
 af79cd13be357-7952f0d627dmr466665285a.14.1717682581413; 
 Thu, 06 Jun 2024 07:03:01 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795330b2305sm62935685a.88.2024.06.06.07.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:03:00 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v3 0/6] Rework x86 page table walks
Date: Thu,  6 Jun 2024 10:02:47 -0400
Message-Id: <20240606140253.2277760-1-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This version of the 'info pg' command adopts Peter Maydell's request
to write guest-agnostic page table iterator and accessor code, along
with architecture-specific hooks.  The first patch in this series
contributes a generic page table iterator and an x86 instantiation.
As a client, we first introduce an 'info pg' monitor command, as well
as a compressing callback hook for creating succinct page table
representations.

After this, each successive patch replaces an exisitng x86 page table
walker with a use of common iterator code.

I could use advice on how to ensure this is sufficiently well tested.
I used 'make check' and 'make check-avocado', which both pass; what is
the typical standard for testing something like a page table related
change?

As far as generality, I have only attempted this on x86, but I expect
the design would work for any similar radix-tree style page table.

I am still new enough to the code base that I wasn't certain about
where to put the generic code, as well as naming conventions.

Per David Gilbert's suggestion, I was careful to ensure that monitor
calls do not perturb TLB state (see the read-only flag in some
functions).

Version 3 of this patch series moves 'info pg' into common monitor
code and implements the architecture-specific code hooks.  I did not
do this with the 'info mem' and 'info tlb' commands, since they have
implementations on other ISAs.

Don Porter (6):
  Add an "info pg" command that prints the current page tables
  Convert 'info tlb' to use generic iterator
  Convert 'info mem' to use generic iterator
  Convert x86_cpu_get_memory_mapping() to use generic iterators
  Move tcg implementation of x86 get_physical_address into common helper
    code.
  Convert x86_mmu_translate() to use common code.

 hmp-commands-info.hx                 |  13 +
 hw/core/cpu-sysemu.c                 | 140 ++++++
 include/hw/core/cpu.h                |  34 +-
 include/hw/core/sysemu-cpu-ops.h     | 169 +++++++
 include/monitor/hmp-target.h         |   1 +
 include/monitor/monitor.h            |   4 +
 monitor/hmp-cmds-target.c            | 198 ++++++++
 target/i386/arch_memory_mapping.c    | 621 ++++++++++++++---------
 target/i386/cpu.c                    |  12 +
 target/i386/cpu.h                    |  63 +++
 target/i386/helper.c                 | 523 +++++++++++++++----
 target/i386/monitor.c                | 724 +++++++++------------------
 target/i386/tcg/sysemu/excp_helper.c | 555 +-------------------
 13 files changed, 1688 insertions(+), 1369 deletions(-)

--
2.34.1

