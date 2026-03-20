Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BAE10987B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d3N-0005mq-MW; Fri, 20 Mar 2026 12:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3L-0005m0-Fq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3K-0001MM-1E
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b527ac5d0so433155f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025423; x=1774630223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K0Mx46DeVNbPDi+3Qbd6FXtet5fvH/iXU4vavaxSE2w=;
 b=YxmOi4/vdCij1S/evNEqZZg0yp9t7ICxVeMO9ladWUFW5+vCAdrkwsUP6HoNTg7Fj/
 6vafAvJwKtrxwyANAobtG/a8gDQ//9UE6wQhpRMdRtN1xMS8fZPkL8aECMjYIQ4BgNZ0
 L0LyAwIMm/qmLSmDRv/RgiZ3D64jokO6kOQUE8LkoqaLfS/0M5ci1BJdacnHPIuypeJQ
 JP+9qw5QnZVTyGi0f+wr2tdYSqHl9VYZSTnHR//lkbvD7onBqxDVz1V/URmTMYA6/X7t
 MpV7Bcfj79cijUfJRNbPqcZmIyhnsYMvUvwC918kIgER5bxsxUrD7C7Xi3oUY1ha81WC
 p7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025423; x=1774630223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0Mx46DeVNbPDi+3Qbd6FXtet5fvH/iXU4vavaxSE2w=;
 b=ncLECRm3Sf4H6v9xtHe3xqKe5ZtF+GEZiC/hbR9cbuXYJrVPKgEK8PEB3ry+NxlPYb
 deQ31KMFnGx+OcrJkFt70hji6Xj6Y/XXVJye7LUGhAJBMat9srLIvr7Q3hIfoEsW47za
 GkC9WBKZ7RRscXplQHK3frlGeAOuZgf9BF9OU0LplhL3l61GNv7m0j7mWj7zNDyKpQuy
 MZI6Hbqny+5OYKcppidww0vPC6I4/7f/gz1vN76nyqy5zj6JoS4nIf8qC3ip1g+y6Se2
 UBv1kzNup884PuiQCE4ockynrjvIfbSQ8ekTlJM0NGT2CXFMS5G7bjO58DRJiRsNc2m3
 HkQg==
X-Gm-Message-State: AOJu0YywThjXUiDQsP53z+a1BR1An56Cpkw1yuNuILY5TWszlneECXYZ
 SJaEt2dDte4CIXjxpOfzONyhwWPWE38jQCgBYz6mCNJa75sxTBmJ2fHf/zyo8y+qOAaCMacw1ak
 Jsz4+mcE=
X-Gm-Gg: ATEYQzxEvuSQFgzojjRUxD0pZroHQZGDplewEVz/aWGkV1PDeSb4TurjsgWEl4HQMnb
 TveYn92CG5V+QBoSFFKCZS3lFpAsjm030XNXeU9oXzOV2aWIpc0m4ziuzHXmeGKK5IW8NTJN+Lh
 bNe24iLz/XT250LClvVNa7DJJpMeul5UWbZz1zdpoKmw3RpElYWnK8r+Fw2khiFX+BY/Aa/Wd5x
 9rx26RAAkUC/IbGJVfeazrLup8ZIZSBApSr1qvbJ1KMThtJib0jfPzueciU9XO2FJN6VjQz0Acl
 Ecvun1wwlJL5FMvT83ewhnzl6cCBZ+2HZ0/X1RfBpfffxSd63b/NjEWuIQQ868rWIQTu9YmRcXv
 e+I50Hv8ExjDtsMZeeUMfwIY7nQovTtzcXB9IX12WAo5CDsZ3/tHTdxOUVQpzkGgbdbG7ebScD6
 x0bNORUhlUwTUzUjEaKayEIDhDUft/HQMQL0ZJg+4DbiDnCE6aZI95LpWTSQc0SSevsZO9SDXS
X-Received: by 2002:a5d:588c:0:b0:43b:410d:c4ad with SMTP id
 ffacd0b85a97d-43b642815e7mr6519566f8f.42.1774025423496; 
 Fri, 20 Mar 2026 09:50:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64715539sm8137757f8f.33.2026.03.20.09.50.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:50:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 0/7] monitor: Have 'info tlb' dump MMU information
 on monitor
Date: Fri, 20 Mar 2026 17:50:13 +0100
Message-ID: <20260320165021.39521-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently 'info tlb' dumps the MMU information on stdout, fix
by using the monitor console instead. Rename the dump_mmu()
functions to avoid name clash on single binary.

Since v1:
- Split Xtensa patch (pm215)
- Update m68k / ppc targets

Philippe Mathieu-Daudé (7):
  target/m68k: Have 'info tlb' dump MMU information on monitor
  target/ppc: Have 'info tlb' dump MMU information on monitor
  target/xtensa: Have 'info tlb' dump MMU information on monitor
  target/xtensa: Display [ID]TLB header within dump_tlb()
  target/m68k: Rename dump_mmu() -> m68k_monitor_dump_mmu()
  target/ppc: Rename dump_mmu() -> ppc_monitor_dump_mmu()
  target/xtensa: Rename dump_mmu() -> xtensa_monitor_dump_mmu()

 target/m68k/cpu.h          |   2 +-
 target/ppc/cpu.h           |   2 +-
 target/ppc/mmu-hash64.h    |   2 +-
 target/xtensa/cpu.h        |   2 +-
 target/m68k/helper.c       | 116 +++++++++++++++++++------------------
 target/m68k/monitor.c      |   2 +-
 target/ppc/mmu-hash64.c    |  10 ++--
 target/ppc/mmu_common.c    |  66 ++++++++++-----------
 target/ppc/monitor.c       |   2 +-
 target/xtensa/mmu_helper.c |  44 +++++++-------
 target/xtensa/monitor.c    |   2 +-
 11 files changed, 125 insertions(+), 125 deletions(-)

-- 
2.53.0


