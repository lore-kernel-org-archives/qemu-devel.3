Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD83C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 17:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYOq-00083i-Gv; Fri, 24 May 2024 13:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYOo-00082Z-MG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:10 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYOl-0007YV-OF
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:10 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-794977cbd66so117831085a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1716570485; x=1717175285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+q2wureYC0x5sAnynNVZCEcaKAnFlmdzjN66ruC6JE=;
 b=OKPykFMhc7DWJodx+9S6c19OSua/5Cim0MnmZ6TSvGDaycCEYj0iIkoCkTgouBcet9
 qbAcYRW6l8JVlEd1nRdpJSoxkCC418Bdw9clvwAtqJIlohVy2UupwSTpYOKtQWxmqOTO
 AMS67nsurmInwDA10B717QEY+kSpzS+yjYajT0NTfACPTAQqCN/yhKrIkD2eu0h0wCZl
 zTbuT+C7CDgrohMMmM9QgfYZUd7yVvIO7lm4ntFP4B9Af7YVkShG69av+5NKjZ/8thqt
 IvWce2G/kXtrvEIM1wffrX5C3xePhnPshpJqhGrDPo/4yQvFVYCUPXVuhIqmRbwryjpZ
 Z9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716570485; x=1717175285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+q2wureYC0x5sAnynNVZCEcaKAnFlmdzjN66ruC6JE=;
 b=byA7dUQFxZQzaT9pGF43wghX6fiamTIECNRa7p3agvTMZnHu/iCuKnaSpWQUsjA5zs
 wVhay04VaXz2JgpcPjN25JupoNwX7H+SbumlwMGE/4FTs2ZuwbaHX2iABMQeAHpdw/4+
 qeKtGBNIVpLeYn+vict0t9ucqrh9uwyNZMpoD3gAmuD5VoOWOiP20icdNwxoutHIrBM6
 /z74C/eXXDh4DrkERlm1RREmWs3cgEZ+qQfeQ9iDWFOT0vVxmSqVdbiYjmLS7mrokDbU
 lWC/on4D5S6ZpaDiJWzvoKLgInzWd0aUoCXzCYspiYE+yQ1j4hit7accNbJcmz9pMmPq
 eK4w==
X-Gm-Message-State: AOJu0YzhjvfiHohjin18Sh6lNuLCaFpMKBAiFQc1uDvk5rZqNF4RETmS
 Yb6/rqKbowm478qV7/gOG7o6OMnzLxsM9laglfUkFCo/NHOr8Gk8JKkxyFgwdp6kOEjKY6zOwGV
 SlEI+AQTvWlqN6EuAotA8qx6g4ZglLGIJoyf8JFboUeYGN7MuUx7gBCuO59pzav5ZXxikYBfE5z
 A2HiHjYl4LrBeTmgom6QO9m9MuuHI3
X-Google-Smtp-Source: AGHT+IG3c0eojlh3TOqngGHHoYAUykJXz4ir3JGWiVL/XuyM+4kYa44jYacGwdB/oesRTdSnlw7gIA==
X-Received: by 2002:a05:620a:9361:b0:793:1a75:177e with SMTP id
 af79cd13be357-794ab0f83f7mr290086085a.50.1716570485371; 
 Fri, 24 May 2024 10:08:05 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0f0fsm79816585a.38.2024.05.24.10.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 10:08:04 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, Don Porter <porter@cs.unc.edu>
Subject: [PATCH v2 0/6] Rework x86 page table walks
Date: Fri, 24 May 2024 13:07:42 -0400
Message-Id: <20240524170748.1842030-1-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZiKkWCjreGOMFX5p@gallifrey>
References: <ZiKkWCjreGOMFX5p@gallifrey>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x731.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
to write some guest-agnostic page table iterator and accessor code,
along with architecture-specific hooks.  The first patch in this
series contributes a generic page table iterator and an x86
instantiation.  As a client, we first introduce an 'info pg' monitor
command, as well as a compressing callback hook for creating succinct
page table representations.

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

I appreciate Nadav's suggestion about other ways to pursue the same
goal: I ended up deciding I would like to try my hand at consolidating
the x86 page table code.

Don Porter (6):
  Add an "info pg" command that prints the current page tables
  Convert 'info tlb' to use generic iterator
  Convert 'info mem' to use generic iterator
  Convert x86_cpu_get_memory_mapping() to use generic iterators
  Move tcg implementation of x86 get_physical_address into common helper
    code.
  Convert x86_mmu_translate() to use common code.

 hmp-commands-info.hx                 |  26 +
 include/monitor/hmp-target.h         |   1 +
 target/i386/arch_memory_mapping.c    | 735 +++++++++++++++-------
 target/i386/cpu.h                    |  66 ++
 target/i386/helper.c                 | 518 ++++++++++++----
 target/i386/monitor.c                | 883 +++++++++++++--------------
 target/i386/tcg/sysemu/excp_helper.c | 555 +----------------
 7 files changed, 1439 insertions(+), 1345 deletions(-)

--
2.34.1

