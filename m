Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064D9C4828A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMIZ-0000oV-Nf; Fri, 26 Jan 2024 08:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIX-0000lU-Vu
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:10 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIT-0007b8-K9
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:09 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cf35e5c2ddso4474721fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706275863; x=1706880663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0nf21EKXMPkJM8ze3CVTUdJSzYvTzNLrOGzIKTot8cI=;
 b=NGXOMCzhf7FnaY5lM1lGcQk4UUI9UplT7IeO8UhuTHGfaz4G7cgkPRgwwW0xxQHAea
 k3KWp7tTEtx77i5M1blaD5Y1049FbKGWqAyCVW0zC6oNB33IBKKQefcVCsQNASmKYgsC
 qbdSOeS+bL2gbVmgxV71rJLZww4XTd3vLIWaE9EsyroH+dUrw+sElz5GxdPv1ZORAUN2
 MpvPXV/sOtJx3PEnb/oZFIfiszZ0oBFLN54bSGHCk/YpCETDbbweATi6J2mAuSZdGEXs
 hNZsOLMBo65Bxy9hO9GnmmS+iWGAmSYiWhurevVd+TAVqQFLYETZAWMw6hm+LI6nMxvV
 VjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706275863; x=1706880663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0nf21EKXMPkJM8ze3CVTUdJSzYvTzNLrOGzIKTot8cI=;
 b=VeXHqDxj+yrt3nPomZ43lXjo5vCzmawNvKeYtBsas+waO1PChQ+jW/rnLeOsj8YFkQ
 Pyb+lo5XUWkdp3MlQqn4WXOnbiED0br2y9hhKuyrC3BWIzrmAE6/GLqnigkUiGZRkbCq
 B+Uz6A+HbtmBB2PwJ29DGAqVJ4gZeFkGkjLLhichwugey1izC6TOIy7EJ2wr72S8OJPS
 KfAVqd5Muh41wTQwWqwy4sbjryfyGEwDQdjPTXfevNrNtklIhuKgj9cTZ06cBBt746iP
 NBQwg2TcWq5AqTWxoa0ahh1h0mqhAm8BusA5Lb7bsrFg+69zZqgLf8k4Pnw0MQXuWLiN
 6usw==
X-Gm-Message-State: AOJu0YzzUBZ2JB8Vy631GR7xthmuu78Stt+aYckwbj4Q0CNzQvHlVpRI
 BqRdRXKEsdKW/vx1g+5jjIQwoBIzgILJ9wIcMt+AAFneLhA5ewE8rE1XI9C7VS0dl7etePOElcb
 l
X-Google-Smtp-Source: AGHT+IH/3nPvij2/Z40gkyapC2Sm2N7u2M9Oa9iv2pAw6MCBxnf//mzepqHY+RDHMUgFr+hI9qOnVw==
X-Received: by 2002:a2e:b5c4:0:b0:2cc:fc52:df9e with SMTP id
 g4-20020a2eb5c4000000b002ccfc52df9emr682130ljn.12.1706275863345; 
 Fri, 26 Jan 2024 05:31:03 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 x16-20020aa7d390000000b0055c2b21be1dsm600205edq.35.2024.01.26.05.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:31:02 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
Subject: [PATCH v2 0/6] riscv: named features riscv,isa, 'svade' rework
Date: Fri, 26 Jan 2024 14:31:02 +0100
Message-ID: <20240126133101.61344-8-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v2:
 - Ensure svade is off by default even for the max cpu type


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
 target/riscv/tcg/tcg-cpu.c | 48 +++++++++++++++++++----------
 5 files changed, 105 insertions(+), 41 deletions(-)

-- 
2.43.0


