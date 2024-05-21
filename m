Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4BAC25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9EKy-0007dV-St; Mon, 20 May 2024 21:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EKw-0007d2-4e; Mon, 20 May 2024 21:30:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EKt-0005Ib-Pp; Mon, 20 May 2024 21:30:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so95805585ad.0; 
 Mon, 20 May 2024 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255037; x=1716859837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kKNQiBABDgwYlftpYJMrcNKvONZWui6UY3F4MnXWJ8s=;
 b=ZF/Uo1+NlWb3t3B6bucaNUVQcNR/oeNxuNCnQITy0KCANcwfOut6AT180kGb7mVCX4
 sZ2JbGQyx84LO1zsBWbLczQGcHT1IFWbfkYYpa4+e4nNwplLhi+03+PSEEuDnU6pqq7n
 9sV9eRNqKwhBApkTVtsmV1E3UNtbw8aF066wMRH7/FiBUCljREyLX+RZE979GAmRQhDk
 JtY+BfuLEohKaMGI4khkYzNXbNzo5HjpBdMYI5muN3DLyJis/M8nXHmAjdzIEcgciPti
 VTe7FaPycOIhJKOY756NbxWY7tQiDZLn9DWJyiXqbp+EwHm5o+A4IthYqq2kTRQUS39/
 Zy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255037; x=1716859837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kKNQiBABDgwYlftpYJMrcNKvONZWui6UY3F4MnXWJ8s=;
 b=IhRz5SN8OtOvBAtRKxjOzYpki6G0+oxizaYR3Qgwy6yb5wk6QuTJ0nICiS78Qfr6Nz
 luERjqG8Trt4FfyTrTuQC3x3q673FHGsIE/PrlY/m5HZjvpg8P4meAFsa317osOnJpUk
 y37h4MEZ3SX4GhK5CL6tSVa/ZgQBAra31yAixJhAHQWpBJ4kKeg5Cq3H1U0P189z/8r6
 /JSJPn90UZ/L7/QLnPdY8oMo7JgqmTQhqwYEjbCOugcl72EEau3/a3RTlG9LfK3cbRQm
 sh2r7x28pEmRDn7b2SlkgF3HycTrspaGtKW6LzTjihYS6KftcuRtx5JcNIPWlm8/norD
 hGrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0UZX7a9tXtzU+VOpTFLd2JpIFoH/Qvz8rejHpU1wIIvCX7k9pPerIVvZiOVcmlOQ8cOjsrYEjzmsWo7I06P9tPknTHns=
X-Gm-Message-State: AOJu0YyREn6MHTsA3H/RmPeftnjGk67gHNHbYXJjwgKCSo/xc6Crnslv
 kUyTp/3GVT8C1s/is188Q03c3lGNsdVkUxYuJ6OahJ/ntMi841hvX6sYjQ==
X-Google-Smtp-Source: AGHT+IHfI1hlO2BugswQjhKjQAEHSuCzLE2JZ7tgQWBeE359nsrKpDgIOana/7yBYh2CvqJkAZKS3w==
X-Received: by 2002:a17:90b:1a8c:b0:2bd:7135:21a8 with SMTP id
 98e67ed59e1d1-2bd7135259cmr4906646a91.42.1716255037588; 
 Mon, 20 May 2024 18:30:37 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:30:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 00/12] target/ppc: Various TCG emulation patches
Date: Tue, 21 May 2024 11:30:16 +1000
Message-ID: <20240521013029.30082-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

This is a bunch of instruction and register additions, improved SMT
support, etc. for TCG.

Since v1:
- Not reposting the trivial memop patches that got reviews.
- Fix checkstop reason printing (Richard)
- Fix the attn instruction checks (Richard)
- Don't allocate tcg temp before SMT and serialization checks
  in spr_core_write_generic32() (Richard)
- Move attn to decodetree.

Thanks
Nick

Nicholas Piggin (12):
  target/ppc: Make checkstop actually stop the system
  target/ppc: improve checkstop logging
  target/ppc: Implement attn instruction on BookS 64-bit processors
  target/ppc: BookE DECAR SPR is 32-bit
  target/ppc: Wire up BookE ATB registers for e500 family
  target/ppc: Add PPR32 SPR
  target/ppc: add helper to write per-LPAR SPRs
  target/ppc: Add SMT support to simple SPRs
  target/ppc: Add SMT support to PTCR SPR
  target/ppc: Implement LDBAR, TTR SPRs
  target/ppc: Implement SPRC/SPRD SPRs
  target/ppc: add SMT support to msgsnd broadcast

 target/ppc/cpu.h                              |  28 +++-
 target/ppc/helper.h                           |   6 +-
 target/ppc/spr_common.h                       |   7 +
 target/ppc/insn32.decode                      |   4 +
 target/ppc/cpu_init.c                         | 132 +++++++++++++++++-
 target/ppc/excp_helper.c                      | 114 +++++++++++----
 target/ppc/misc_helper.c                      |  82 ++++++++++-
 target/ppc/translate.c                        |  66 +++++++++
 target/ppc/translate/misc-impl.c.inc          |  10 ++
 .../ppc/translate/processor-ctrl-impl.c.inc   |   2 +-
 10 files changed, 409 insertions(+), 42 deletions(-)

-- 
2.43.0


