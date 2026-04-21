Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043AFF327BB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5kM-00010z-SY; Tue, 21 Apr 2026 03:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5kK-00010G-M5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:42:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5kJ-0004Hq-BS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:42:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so17453805ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776757329; x=1777362129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BlXF2wF8Bs5vmjMH57PslnSGQCy5v1tI5/CdD1QyvJQ=;
 b=ZckSr0d8jynTkpFLlO4XKMlgPJDN3nCXECOVx/rsVupBVrrFtoxDbOiDpslJVvSD80
 Pk1B5kwKZ7U9wRs8rJ8A7dw5nT76IV3lAdAQb5wIbOZ5k6IMlnsmXTgqLE/bmVRJS5DJ
 644NQUSPu1S/PHvJUm6xdeJNLQPT0ws0sac83R32ODUF7vkmA+kHC6r5c7lVzqnkhHFK
 DLjShs8NiiF54EOZh/7JuT410Vdhx89toE6SjYITrVLPWTP65+HOkYYPEKph4NTNyQ0e
 SBSRQsk6HBwM3I+Z/Hi9lRohRcS9jVfbywhZnbo0Eo5fcEfYwhzPXizoDbNMbSvc3Hya
 rwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757329; x=1777362129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlXF2wF8Bs5vmjMH57PslnSGQCy5v1tI5/CdD1QyvJQ=;
 b=rvXuzZH7SsqWurhUHTPqhYyNPMceZPl8tvicRWqv9Jl35DsH6eW3/MxaGyLUX8x7Kj
 5/xuySF7yEfBHXOfVfGCX4slzJgCnx9dgnwqIROs0PeQu2icrB8bphgrKDMG9jwv1jKI
 uDcHTelA36iH97//xF1Xac39XLeA7R2be7dn2l8uTG2PdAx0QdPVbLn2wf8sz/neH7as
 ZoXqLSNAej8tV+fh4kHasveiSYGiBOJ5eoixQlE5PvtKqzT3MPw9HCcfgJ42KeRa0Bnp
 7GEGdU5iCEYX6IhW/eFIWOlV9hZDohxhMrxQme/qK2GzMnbpkA3rIoOVfGzA4TkwwHKq
 /WZw==
X-Gm-Message-State: AOJu0YyRjAr+kEkKsdPj2jUU5wPf5UUTn3YCNfGecdsGWZzsZKe6vOOa
 q2FS3w02nSb9kVeLkq8z4I2RGSMeXZ8pSLnO5UElukeYcbhRPEDskhSEw1bQFWI+wSp3NtznbV2
 ZY7vaDCUlKUiOTuFNyqk100NXk8MZ2n6oXm5xuwfTWMkNovvRRe5OhiwMWBTtX+MjaqVwlFU7cN
 JWKBusvbRbUqhb0EiA9DMUHlgclLshNz6Hex2neo/XyrjmSA9M
X-Gm-Gg: AeBDievYVeD+iYobjsEC5ZEKjUn9WUVEro0hLE2G937uEZ7wAtVA5ZMlrnmpT9PVjQ1
 urXqFfsCOgkJMcjz11q3HZpcgO0cjdE66A4YQXOFMC0g33svn/c8BoIshDeSm5k3T/RycdyRIrP
 N/scPV1b7knT9cdCVkyQhC+boSgv4a/vKXzLKjVqCeg/tUEQbhWNyyZ2hB8srZrNPNYRAUWAbgV
 TZ9+tuH0Y6OvIvscXbb207bf8wvb/gqpf1z1GYsADXpX7484jhn+T0pxycjQCWBh0ogMpxoDUuk
 kR3PJFwE3HQiALScEsSk03yWzFDn6MA21thWySpFSNe7OtqXXpljeJUvfUXe5vV5yg0cKAJdwDE
 yR/60OPlvFFz11OVMmINHsyL+P64rLZ6z/BvVyNbWLIO0TPLt0lw2FBVbmzSpJ8SaRJD7H+zI26
 ukKrH16vK2rgia/XWnNZycXTqnXKU5zYwRGcKyZQXRrSZN5DfVEfUFLbq7YR1V
X-Received: by 2002:a17:903:1a2d:b0:2b2:4b4e:e4d8 with SMTP id
 d9443c01a7336-2b5f9e5df87mr177465705ad.4.1776757329360; 
 Tue, 21 Apr 2026 00:42:09 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff918sm133191675ad.13.2026.04.21.00.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:42:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 0/2] Add the implied rules for G and B extensions
Date: Tue, 21 Apr 2026 15:42:02 +0800
Message-ID: <20260421074204.2908422-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add the implied rules for G and B extensions to enable the implied
extensions.

Changelog:
  v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
      implied extensions can be enabled by the implied rules.

Frank Chang (1):
  target/riscv: Add standard B extension implied rule

Jim Shu (1):
  target/riscv: Add the implied rule for G extension

 target/riscv/cpu.c         | 26 ++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 77 --------------------------------------
 2 files changed, 25 insertions(+), 78 deletions(-)

--
2.43.0


