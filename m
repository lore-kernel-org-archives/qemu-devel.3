Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03018C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FcI-0007Xg-Ay; Fri, 25 Apr 2025 05:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FcF-0007Ud-ME
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:45:03 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FcD-00014G-JA
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:45:03 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-303a66af07eso1550317a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745574299; x=1746179099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xc6D1Kcyavm6Zaf+Pjisy1B0+BYE6/AfMyJmDB+WDd8=;
 b=ctLS04J/tNB1JSVTqmrFu3B/iTi987TJefI6AQisFu87BNyKxwownm1JyXgqvtRt5p
 zGhyg4xVmxIY2kpPSmr+roWnLjPiyQ/4Ft+tS6s1wQl+2NfOPjTrfGbVF0/HRntzDP7B
 EBT34MjwUXaIzj4gZm5O6IBm1+xCCqz4FlOYy2VWiOgCjPSgzVyqIbfJHcSl+5KM60ZX
 f592ZtkPKAKFt/lJqr/YmxtQhcMV9sXjeoCxyhhLC397Jiu8X5wpvo2ieGNlQC9OfQze
 u/PBViEJhKOG3pr56oOHfrZtGRvXuIp/b9ea9gdu4T561AeDV2KzdRgtQYuY3tXJddTL
 230Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745574299; x=1746179099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xc6D1Kcyavm6Zaf+Pjisy1B0+BYE6/AfMyJmDB+WDd8=;
 b=m8njy2UqefagzTEwwRkrJfScECiB5vFdW/xUpoL68X8STIcxcfXp67g539nxdzmL8S
 KxhIdwyVSRVq79YWc4BpcG9pg+WY5OVkznx12/Nh4/Njt11TnCeYBDpRJpdHpuxj8eua
 pnyJkKy2xMzcIKGSwvbJMpr5XY797rjvSi1Wht+CCyyJ6MfdBzk4PRekZvlNB+qt6gr+
 tFpIVOQAjWJ0y1Bfhedd1XFQlmvy92d5BSsr8vGazV7dtl2ed8ZIrjeNnnS4E1+/vYH3
 I9k+kPPrbgYTcGF2mM6O3eTB64zrNpCnRSUhjDLXirF8wd1HTU5v6UxLBDcCtTsYFFu0
 8WSA==
X-Gm-Message-State: AOJu0YyyyEGznJ3QSNzEePB4DoWTKnhR9J96NQ1rtluNm75Qw3m4/Pyv
 rLUIkL5Q/SWvX7OTnFCw+N9l3gWU/OVrMoHfBMooy3Q55R1p3eG9XCu0ylewj7GkLeK1D6RF607
 vz2ZyAwTh/0jzHljaosIijg1UG77t7msT8pknYJyB2fdMw1Ta2QGmD1RqgtGCj2LqBmld/XxjZs
 7ZXv1CBur026cqXWlpNLKcC6vswtOkbUYyyIk47y/oASUU
X-Gm-Gg: ASbGncuS0cap9A8iESNmHiFfvOkCh3MxbraFuwHWkorT5f7CjNCm5piR9r1G24W9+j4
 30SziICTdxS3myr+s/HAlW5eTCc2U6T0E0+seDnEiJMJJSOnYM4+X8JJSu16uCLRZFci0mIJSz8
 XFpKOjfgMidYAqjZo0EO7IAiUdIKsjCd3jBmeTg8uikV9sAolb4l8Of56+pXCGH2S9zvzaDgmdM
 IVdThp6XngQXNCjrWhMhi/j4+VQPPVk+XRA2YqrAKFpemCY7VTHxCIt7uB03jD68kB1U5bPkJ33
 TTS+mG6ygjPlHfbVdEbo8LfPfQ20qVTcjxrcGpiaszGZfuaQquT7leikMIU5wqYdcejFNvEBhpw
 uKSavDbSpvA==
X-Google-Smtp-Source: AGHT+IFZ2PikPOrV/Ibr3Rdbq5BcXSNgT1aNv+f4WyRVsPTyjcPpL+ufEpedk2UwErhnRLUFqcFCsQ==
X-Received: by 2002:a17:90b:524f:b0:2ff:4e90:3c55 with SMTP id
 98e67ed59e1d1-309f7e67d73mr2772386a91.27.1745574299444; 
 Fri, 25 Apr 2025 02:44:59 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.228.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f27e22dasm2288826a91.17.2025.04.25.02.44.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 02:44:59 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v2 0/2] Extend and configure PMP region count 
Date: Fri, 25 Apr 2025 17:44:50 +0800
Message-ID: <20250425094452.17013-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The first patch extends the number of PMP regions supported up to 64,
following the RISC-V Privileged Specification (version >1.12), where
RV32 can have up to 64 PMP regions configured through 16 CSRs.

The second patch makes the PMP region count configurable via a new
CPU parameter `num-pmp-regions`. This allows platforms to adjust
the number of PMP regions without relying on a fixed default value.
If unspecified, the default remains 16 to preserve compatibility.

change log: 
  V2:
  * Rebase on riscv-to-apply.next

Jay Chang (2):
  target/riscv: Extend PMP region up to 64
  target/riscv: Make PMP region count configurable

 target/riscv/cpu.c                |  54 ++++++++++++-
 target/riscv/cpu.h                |   2 +-
 target/riscv/cpu_bits.h           |  60 ++++++++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                | 129 +++++++++++++++++++++++++++++-
 target/riscv/machine.c            |   3 +-
 target/riscv/pmp.c                |  28 ++++---
 7 files changed, 261 insertions(+), 16 deletions(-)

-- 
2.48.1


