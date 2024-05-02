Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5BAC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFC-0008NW-35; Thu, 02 May 2024 01:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF5-0008MK-MX
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PEz-0002bD-NA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f2f6142d64so7057737b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628660; x=1715233460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uh/e9AC7IaGAogX1ZpLqkQ+Kxck2qAEP70TLZWNb2mc=;
 b=f3YtZMG4iJkLd5jv6GCJVHedFCOfbsSPTHNh+jXqpT7qvJsqdrXt0nZRG/wRJ+PeRw
 7P9R3aRaiuJQhCS6NE995/lPIG07Xvr2xR0IdTihs5wqdMBeaayD0RGCVcjuJt6UH4Qv
 AHcmx5rptkSIagrkV0RdBOLfkxjLQJjDRa1txg59kJK3W2jd3FlX38Fqgj0Y2qit1oeJ
 mouD3/uP1me2dE6V/AlKRczfnAHVRb8hrhUnBN5xinULShFe5Q7kP7wwdQ9swXkulWyi
 ldQjXah0VPRGn2JUPlLZ/5iQs6Wm66BwICIp/Fiy2kDjpBytnTssHd+E8tQ+68dS0xZA
 i4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628660; x=1715233460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uh/e9AC7IaGAogX1ZpLqkQ+Kxck2qAEP70TLZWNb2mc=;
 b=crl3g345oN/RTEKbIoUKG/sV2pfF+AxTLSpUr6V7BSrtNKbUjOGpqaHiU/+vgSHesS
 cZt/w1KBbj8swlkK3TD476BR2WKi0sSIcUKhok9zuR7g4hSEaByLTm4/PK4dOjWNfwTF
 fvH86wwmNzt/BbdYZA9AH+fTIqtPQR8wywtNfYmtQvOLZKs68hrrqm+MO83DZGm06Eqn
 c1V1op99KpK8cdMJiozDTdK1ij0GAdqOApPJ2vhAsAnl0N4N1xl/6eVymcneA7UPo28E
 Dnw6moyy/FOmi0DULsWsuE11riGyTuNT+Hi1N+o3PgMVUt8Gmtd1tmqQqVpxorHEhS/N
 HUjA==
X-Gm-Message-State: AOJu0YyZjxcc15t1ZRxSO3v5JuCwCkU1oRUb7E3ON5yOgO3yyhu0Ylqv
 4DbOL/wl0YRewy6FRxRUBGuYj+YhpJrpE53bvAak69eESLkzSfRFJYUepJUwl6NIzpU3VMpGLdZ
 V
X-Google-Smtp-Source: AGHT+IGTlEBNULUOw3UXzBI9eQ5z1S63Wi58QBl71qTl1NZ4nfnS1NVpj+yMWUyEc3VguhDUnJJLbw==
X-Received: by 2002:a05:6a00:3a16:b0:6ec:f9d3:d0c6 with SMTP id
 fj22-20020a056a003a1600b006ecf9d3d0c6mr1381405pfb.16.1714628660012; 
 Wed, 01 May 2024 22:44:20 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 00/14] target/s390x: Fix and improve PER
Date: Wed,  1 May 2024 22:44:03 -0700
Message-Id: <20240502054417.234340-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Split out from 

v1: https://lore.kernel.org/qemu-devel/20220906101747.344559-1-richard.henderson@linaro.org/
v4: https://lore.kernel.org/qemu-devel/20230220184052.163465-1-richard.henderson@linaro.org/

after I noticed that the testcase,

https://lore.kernel.org/qemu-devel/20221130174610.434590-2-iii@linux.ibm.com/

does not actually work under KVM.

In fact, support for PER_CR9_EVENT_BRANCH in TCG is broken.
This cleans it up and improves things so that when only one PER bit
is set (what I assume to be the normal state of afairs), we have
less overhead.

I'm not sure that all of the interactions are correct, particularly
with multiple PER triggers or other exceptions.  For that, we'd need
a more complex test case.  But at least branches match hardware now.


r~


Richard Henderson (14):
  target/s390x: Do not use unwind for per_check_exception
  target/s390x: Move cpu_get_tb_cpu_state out of line
  target/s390x: Update CR9 bits
  target/s390x: Record separate PER bits in TB flags
  target/s390x: Disable conditional branch-to-next for PER
  target/s390x: Introduce help_goto_indirect
  target/s390x: Simplify help_branch
  target/s390x: Split per_breaking_event from per_branch_*
  target/s390x: Raise exception from helper_per_branch
  target/s390x: Raise exception from per_store_real
  target/s390x: Fix helper_per_ifetch flags
  target/s390x: Simplify per_ifetch, per_check_exception
  target/s390x: Adjust check of noreturn in translate_one
  tests/tcg/s390x: Add per.S

 target/s390x/cpu.h                      |  83 ++++----
 target/s390x/helper.h                   |   8 +-
 target/s390x/cpu.c                      |  36 ++++
 target/s390x/tcg/excp_helper.c          |   2 +-
 target/s390x/tcg/misc_helper.c          |  68 ++++---
 target/s390x/tcg/translate.c            | 248 +++++++++---------------
 tests/tcg/s390x/Makefile.softmmu-target |   1 +
 tests/tcg/s390x/per.S                   |  82 ++++++++
 8 files changed, 302 insertions(+), 226 deletions(-)
 create mode 100644 tests/tcg/s390x/per.S

-- 
2.34.1


