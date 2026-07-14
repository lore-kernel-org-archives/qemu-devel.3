Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC97DC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjURi-0003My-UY; Tue, 14 Jul 2026 00:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURJ-0003Kt-3B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:13 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURG-00083Y-Lf
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:12 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381b831d535so636745a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784002087; x=1784606887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H7t47+apX3OmXl0a317AY/pDcnzjmD7Bz5F9UNrHZh4=;
 b=MI4mofIQWjfz3/mgI30yUWuPuwhnly0XGTAm+X4tmuI8Zm8nXC5PPtuCA+2FPOWreQ
 YEsEMqpctIJM2QqkVJV2B0CtJXfQ0dlVQ7qGu3WdkZALOOMgDWrnDwfggACPvqLeHx2A
 qL2QAkV/vaALWRchW8qecfTUPQsewO14WsU7x1krxHPUhGreQf5GAFA/k314knghJ5by
 Aaj5j8PUu/ZMJuzdbOgH/tniyjMGahhGTP9HpW9yARF3p9c79PF1ofbO/SwtNdDrOB8d
 Xvbjlco/SuhgyuAYiE9/3agOHjQ+IUNCThhREmxXYU+nvvekfjoNIGv2jf1lovGd9AyK
 mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784002087; x=1784606887;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H7t47+apX3OmXl0a317AY/pDcnzjmD7Bz5F9UNrHZh4=;
 b=RyG+JcGvJ/KEanLsN480mseHHabLlsN6kr0Y3QZsYrAm57ADyWZLSSYrdz9sWQvJWi
 mmGVy74I1k/+OiytB9xN4IzsOEdXVyO30Gf8LH+C3vBXnxENwZjBJmbVzrF73xQvL9vA
 /lSwK6YCHxb3jjq3wxZ3ZZ3Kt8E0hFXGWEBlt9JaicaYxSA5XNWhbuSKx/RlLa3hqPn8
 jtihALPxOx1gNCQEqdQE33/u3bL1yq0vilDmpYeUFIFF4rm2NdcjqUCsVQAB0LPiP5Sg
 5kCTMZrBdPzaqRhbFHs6/udbIIQBdhq9i+cE71O37jhWSOp4XZ8f4lMHFP1H6lQ9RP1b
 jujQ==
X-Gm-Message-State: AOJu0Yy/MuihB7vhZvvD+ZaLXJijmp40BsidDbjEdyrlHfj9k1XhFDrd
 rFz1juK7K9Dg64slJdIPvM3AFRh9qBAZwxuptlkk6GR2tMnqzzMPQe79aNy1rg==
X-Gm-Gg: AfdE7cm1wCWXMOJwZk1+tFQdnQ9BeUAbR8u13uLUffnxhW6kdxYmwG9A4XDc44rMhJN
 ZAlPXwZpmW31AeN2VSxhAusbgFWMreDOaim/JrIAnVJuwt9hqGGft0Tfg2xTQE9VIS1uWUPeOOg
 MH6XV/0R0mlQPxr+Ae0nU2w2UIB9XtXgnpOYmMm/4LHZlf9b/9Wx0NvosE0brZ+KgfGEIjbFQhM
 kV6bbeSizrjM5SF7m4czxDFama9owPd3vKopTjQi+B6VaERGDq4seDMh+ymLwUStVIypHucnvUC
 kwhfPUnFATRPQAsOenTbtAxQPx2q/Ai/PZUzdXuU7dNCqegkkWL+B9nq248LoDS8m6PHUqspcrK
 48CMf3mEPhN/1d/jrjvkGBUTKBZtIKixz92lx078Zv1XrKVQknAvT9NRZ704qbelZCutvtum9J3
 cHzXYwuVhgraKR91uX7QDuzFrV7JD2DCc=
X-Received: by 2002:a17:90b:33c8:b0:387:e0db:3fb1 with SMTP id
 98e67ed59e1d1-38dc77993c3mr10806061a91.42.1784002087084; 
 Mon, 13 Jul 2026 21:08:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6cfbsm778840a91.3.2026.07.13.21.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 21:08:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/4] riscv-to-apply queue
Date: Tue, 14 Jul 2026 14:07:54 +1000
Message-ID: <20260714040758.28332-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f05:

  Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu into staging (2026-07-12 21:49:04 +0200)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260714

for you to fetch changes up to 8fb307591625731060d399aca42373c02c7cb040:

  tests/functional/riscv64: sifive_u: Fix kernel command line (2026-07-14 11:56:14 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1

* Mark Microchip PolarFire SoC as Odd Fixes in MAINTAINERS
* Fix RISC-V privilege level in uftrace plugin
* Add K230 Linux boot tests
* Fix kernel command line for sifive_u test

----------------------------------------------------------------
Alistair Francis (1):
      MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes

Bin Meng (1):
      tests/functional/riscv64: sifive_u: Fix kernel command line

Junze Cao (1):
      tests/functional/riscv64: Add K230 Linux boot tests

Yanfeng Liu (1):
      uftrace: riscv privilege level

 MAINTAINERS                               |   5 +-
 contrib/plugins/uftrace.c                 |  13 +++-
 tests/functional/riscv64/meson.build      |   2 +
 tests/functional/riscv64/test_k230.py     | 108 ++++++++++++++++++++++++++++++
 tests/functional/riscv64/test_sifive_u.py |   6 +-
 5 files changed, 127 insertions(+), 7 deletions(-)
 create mode 100755 tests/functional/riscv64/test_k230.py

