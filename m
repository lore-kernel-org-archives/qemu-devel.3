Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A8C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 05:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpiMa-0000pg-7X; Thu, 28 Mar 2024 01:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMY-0000pM-RZ; Thu, 28 Mar 2024 01:31:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMX-0008PR-9s; Thu, 28 Mar 2024 01:31:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so1250948b3a.0; 
 Wed, 27 Mar 2024 22:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711603899; x=1712208699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s4aUGtWC/ud+pU2lGI9ts8YM1IlIGiz8jqFyH7n1v64=;
 b=IjEZVhPjM+Hz99L8KNaetc83ueDPmZPxvn9WXJ+wXTsflUlf/6mAo1tWoo+3O3op+S
 oU2K0rn14zyPl2x4VO3FfsLBVVYOlbZYGJ2RJZoOWeaXWmPYoztyn71X1xbanfuNjqRJ
 vqKzUbVWotGqo8OZPd0pZKWl8oKLjJ4e3cYW3NLad8GWLyTInvBzSRXG5mRDbXKIW3T5
 Nzs0J21kms0cjiBhDxX2A7UuTnjAiDUA3HE3HomLBZyNjpCXjcsAAGSEvLw+yScY2B70
 Ms960ZOSCFBJscAiiz9kD5RczowWXofH6n0JuEOUbh6sr9K7l3vYKZz9iY35JwLfiqSS
 HMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711603899; x=1712208699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4aUGtWC/ud+pU2lGI9ts8YM1IlIGiz8jqFyH7n1v64=;
 b=IHbQ/9bUaDbYFTaTh8GbX3y6MrTOs0wqSHFxgBnqMd2DaWJsfb+LVSvhSNtqSQuU0H
 LQxWTP14AwxvZjm/7lGQNbHNetNoaAIn9FlAL0JgIdgTLsocEidlBsb5QSd9WfEpUjJO
 zUVcUDUZZRnEVlIiFmEfKZZTnI1It11bWEEv/7JidW/40QNurtQhbDXFqE0MOb9cUlqQ
 IYdyuo1X6P2r4Hh/U5gUTt+nFQD6edYLYK3CPrOkMVJE6oApjlNWJ0eSESab08iAMTcF
 desbx+Jg/SSkrWFKcXnYb9czwSs+9Mxpi4h74J5SLqFuxuwPwMJBRm52M7tK0inPu3wh
 cQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcDIybaK0P1NzuRG/kPosLUMFmRKmFVYBex/rNVwmcC7iB0Nl0YaKc03RoTmF9SgOzvyOlB3ihp9WkfmdI8/cZ5bFhWYA=
X-Gm-Message-State: AOJu0Yx3JIecrpPNjn9MaJIl7hhMIJN5JQqszKVxXmpKk2qRV2uATrAy
 kfhXB1SB54knvSh+kAg9oNbI/q/2Kw95Msva8Adv6+XFWhpsnvgmWnH6pwZO4WM=
X-Google-Smtp-Source: AGHT+IF+FPbfuPaLyhGchJ33QbgfxPR+69WMXmW/WJffmTWAAAcYIQdfVi7i6EtEFULKGzZofWwkag==
X-Received: by 2002:a17:903:22d1:b0:1e0:185d:a73 with SMTP id
 y17-20020a17090322d100b001e0185d0a73mr2099537plg.9.1711603898889; 
 Wed, 27 Mar 2024 22:31:38 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a170902654d00b001e211a290efsm535018pln.132.2024.03.27.22.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 22:31:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/ppc: fix tlb flushing race
Date: Thu, 28 Mar 2024 15:31:28 +1000
Message-ID: <20240328053131.2604454-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ppc broadcast tlb flushes should be synchronised with other vCPUs,
like all other architectures that support such operations seem to
be doing.

Fixing ppc removes the last caller of the non-synced TLB flush
variants, we can remove some dead code. I'd like to merge patch 1
for 9.0, and hold patches 2 and 3 until 9.1 to avoid churn (unless
someone prefers to remove the dead code asap).

Thanks,
Nick

Nicholas Piggin (3):
  target/ppc: Fix broadcast tlbie synchronisation
  tcg/cputlb: Remove non-synced variants of global TLB flushes
  tcg/cputlb: remove other-cpu capability from TLB flushing

 docs/devel/multi-thread-tcg.rst |  13 +--
 include/exec/exec-all.h         |  97 ++++-----------------
 accel/tcg/cputlb.c              | 145 ++------------------------------
 target/ppc/helper_regs.c        |   2 +-
 target/ppc/mmu_helper.c         |   2 +-
 5 files changed, 30 insertions(+), 229 deletions(-)

-- 
2.42.0


