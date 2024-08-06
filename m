Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA662C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDdy-0002ps-8I; Tue, 06 Aug 2024 02:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDdv-0002o7-Df
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:25:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDdt-0003wM-8A
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:25:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so3630895ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722925555; x=1723530355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n7SlBnfqqwKsFIJPmL+a+e1HqsT6kCqcFeAET6j7zF8=;
 b=anpdbYZnKSltxvxRdRjkUGs24migtH/yWyEt9BtZzJnOYvn9EuStAlCUsjq98anxVf
 qagPprwlrbXjFzUxMCh7jDhc9tACNPWEam9G/1XK8BDD2kXs8m4QwgIl/OeOENN0vqjb
 7SYNJrgTA2f+RFzfMVStgikD4j8ZlpCZ2sT6yMzZgbqPLdaZWeGSRs881BJfsbQuM4q9
 dPpMku4OcBz1GBhjRuaP6tC36ALafSXClnDM85FJ9dh48SsEe00fBW8FG4hNeF5csAtm
 Kmy16WkYCsgf+ofa6bPzi6TMzSqgNB0XhWrzfI6i3D8xUnzNd8XX6ZDyEGbrbpEbWSEs
 B7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722925555; x=1723530355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7SlBnfqqwKsFIJPmL+a+e1HqsT6kCqcFeAET6j7zF8=;
 b=s4yUq66zT5POwQZyALIyQbNMbxf7+vieiaKe1ff5//DEMc/3wu3KKtZc4J+AKuLAuA
 tSmt/6NKt8jchC0Tc7fU2ikmnpOcnJZ2lgPxXCtezzXBfpsnEEH3j0ZiAcmG+YRmB/rA
 KeiITxk4COX70FZKHZq8gp53OEs4oldWmsB8WxB0SlcDHI236r3/X2LBWOYHKCE/z3NP
 WA+LJEhDGrbqx83M+bHW/GT6+rRuGogLOgUqOMzBpCjFcApg+ruEVAhDTDt/RYedFXDd
 HWiaEjH7fyeHMpDhldv8mjTpMsZnl0LDhJJCvGywvAJQ8B8uobIakSEDjJf4ZBb+whe1
 nBng==
X-Gm-Message-State: AOJu0YzZpyx5/7LuAnlkoc15yyQLbm5yKABsrUKWrTL04pJfsZVQDhGf
 yh4mEpSUIlx90xULWH8yZLMVuxCPqs8/RCcLGFnmwIKc33AjoL+d33cPvDH/
X-Google-Smtp-Source: AGHT+IGISUYc4aKfnc2mlZF9CPzB6PIHJY/48ZXQYM8okWp+tpto07lTCcPjRQdQqdy9hHEFWK+QZQ==
X-Received: by 2002:a17:902:d2ce:b0:1fa:fbe1:284e with SMTP id
 d9443c01a7336-1ff570ed054mr170519905ad.0.1722925555483; 
 Mon, 05 Aug 2024 23:25:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f161sm79464975ad.232.2024.08.05.23.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 23:25:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/5] riscv-to-apply queue
Date: Tue,  6 Aug 2024 16:25:40 +1000
Message-ID: <20240806062545.1250910-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

The following changes since commit e7207a9971dd41618b407030902b0b2256deb664:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-06 08:02:34 +1000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240806-2

for you to fetch changes up to b3a34eb90d8264bd73ccb25295b1a7e271a9029c:

  roms/opensbi: Update to v1.5.1 (2024-08-06 15:01:01 +1000)

----------------------------------------------------------------
RISC-V PR for 9.1

* roms/opensbi: update to v1.5.1
* target/riscv: Add asserts for out-of-bound access
* Remove redundant insn length check for zama16b

----------------------------------------------------------------
Atish Patra (1):
      target/riscv: Add asserts for out-of-bound access

Daniel Henrique Barboza (1):
      roms/opensbi: Update to v1.5.1

LIU Zhiwei (3):
      target/riscv: Remove redundant insn length check for zama16b
      target/riscv: Add MXLEN check for F/D/Q applies to zama16b
      target/riscv: Relax fld alignment requirement

 target/riscv/pmu.c                             |   4 ++++
 target/riscv/insn_trans/trans_rvd.c.inc        |  18 ++++++++++++++++--
 target/riscv/insn_trans/trans_rvf.c.inc        |   4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc        |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 268312 -> 268312 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 272504 -> 272504 bytes
 roms/opensbi                                   |   2 +-
 7 files changed, 25 insertions(+), 7 deletions(-)

