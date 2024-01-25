Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196FEC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5n1-0004aO-4h; Thu, 25 Jan 2024 14:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5mz-0004Zr-6z
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:29 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5mx-00015N-Fp
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:28 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29041136f73so3842001a91.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706212405; x=1706817205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MKkWlwwYYk5o7CvSFPpJVirm/B1Ja/1V+c7BjnxxjbA=;
 b=IKcWSfMe0tgGmyLv72Bx1maAj643wozeh/Kp5R/egW2IoLxPoTQWoKOVoOKxYmGmXB
 u9azgbEoTyjUuhlc4zad08XP1jA0El1aRCJOca+ugRIpusUCAEj/22Z0ic2CYyK//xIO
 FW8YBJz3JvaJlY2oM+AmiQKEcaNKKd1lP/oKJP37B2ZR81rLZTVZ8MQ+5DzV/hitkb/Y
 G31xSK8O5pBFwlU8jf4H8XVWfzQaXHUvaYi62LLqoN5yVS5I7TFiIj1jDHBB3YPqyrz8
 6y4HxKQkxgaHUDOt24zvGmaSFBCvPGNtaOy3OSIDIqhiASjnEAl7wZ12aoCBUzqnZhW3
 m62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212405; x=1706817205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKkWlwwYYk5o7CvSFPpJVirm/B1Ja/1V+c7BjnxxjbA=;
 b=oFnOlmrlbDNUUJH01Spgk9+5R4QOXmLd+L2+i7/xdI01znOjPhg6oVyZQkLR9qMx7Y
 wN5/A55MJGnnFMNJhXBUz0eYeOqY+stfyE/BvPoxP4dnghacKnXpbwJfQWixWhz7rDHp
 U7DQZeouio7UAx3zpA0OAJtDN23jLCLJ2VGn+Wsb0T3jErX5v0sXIhXZFku99FlbDn4O
 5r9m2U5TzllmpkkbACZxjhLWQ7WOOdyuKsHREpgMVugkoRtlVFEtyj+wvoz4e0J1oSGU
 GeQobt5DtnUNAQiC45frkXnxFtS/9Z0dEsoMZ4mDoB41zALNJb4TJKV5qPZwfwHZG0i1
 mpzw==
X-Gm-Message-State: AOJu0Yy1o+iWYN6obVz0SrzoENFAU/2FIByRIRDfTGsuBlcmDoczVixo
 O6xrU8viU1yVpHrs40eSdgpZ3iEpQuyhPScH2C7T0QCnyqsHxh+WfNXo9LRE/5ilKwdDmpj4F9o
 F
X-Google-Smtp-Source: AGHT+IH+EqFEyaFymb9+H9z7kPe1kSYtvIEtTur9cLU4QGToXQNwdydtHW9t2+rsHf57v+j3ZMYDDg==
X-Received: by 2002:a17:90b:a16:b0:28c:a632:1f87 with SMTP id
 gg22-20020a17090b0a1600b0028ca6321f87mr137281pjb.34.1706212405597; 
 Thu, 25 Jan 2024 11:53:25 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a17090ad40700b0028b6759d8c1sm1958613pju.29.2024.01.25.11.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 11:53:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/6] riscv: named features riscv,isa, 'svade' rework
Date: Thu, 25 Jan 2024 16:53:13 -0300
Message-ID: <20240125195319.329181-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a bundle of fixes based on discoveries that were made in the
last week or so:

- what we call "named features" are actually real extensions, which are
  considered to be ratified by the profile spec that defines them. This
  means that we need to add riscv,isa strings for them. More info can be
  found on the commit msg of patch 2;

- the design behind 'svade' and 'svadu' is wrong. 'svade' does not mean
  'we do not have svadu'. In fact they can coexist. Patch 5 gives more
  details about it.


After this series, 'svade' is promoted to a regular extension and all
the named features QEMU implements are now being displayed in riscv,isa.


Andrew Jones (3):
  target/riscv: Reset henvcfg to zero
  target/riscv: Gate hardware A/D PTE bit updating
  target/riscv: Promote svade to a normal extension

Daniel Henrique Barboza (3):
  target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
  target/riscv: add riscv,isa to named features
  target/riscv: add remaining named features

 target/riscv/cpu.c         | 63 ++++++++++++++++++++++++++++----------
 target/riscv/cpu_cfg.h     | 15 +++++++--
 target/riscv/cpu_helper.c  | 18 ++++++++---
 target/riscv/csr.c         |  2 +-
 target/riscv/tcg/tcg-cpu.c | 42 +++++++++++++++----------
 5 files changed, 99 insertions(+), 41 deletions(-)

-- 
2.43.0


