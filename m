Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1253CC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXi8A-0001zB-DJ; Fri, 04 Jul 2025 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi85-0001yJ-4N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:09 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi82-0004bm-Ah
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:07 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6fb0eb0f0fbso12943536d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642104; x=1752246904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oa2zhtn7SrMvQwPB1AlA+6y1mdRzYmiTTXZ1QyH4Dk0=;
 b=w+TCcSOV1ULqUwR/OYomS9/P7nWqN/tUYUHnKznv6Qi8ZjjBURNz/HmXe5od2akcw6
 j+SueM8YR8ZCkmMLqPjGm5lK+YtNuqwpvVWu2I/lb0OqS8jpzHHHvewrYCP0bJIKkaXv
 jPFzVhyuUV3mZGq4SEC9pNDd65vyfreDuZYM2P0zb6uU6QvGi8HYQq3Pu7ZTnwjv5Ak1
 QduEvyEwwWEK8nvw/zofEZp+5TizVojMK2V8gqnB3z2mBjAMkoj4f0AguAfjXntIrnbc
 8+4N4I5bmuiBvCSFcFN1mriOeG5uCD21N//8KgpSSSHKsNkVcQsLkJJyxMS1IUOR+oIK
 c7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642104; x=1752246904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oa2zhtn7SrMvQwPB1AlA+6y1mdRzYmiTTXZ1QyH4Dk0=;
 b=EcYYlE7y+PW+Wf2EjIZWQtZM3VCgmRCZ1iWTnlUrqQ/p6BydJ3noyOVUxqN2wZOmKm
 YP4+ioAE1U06Y8g9uuueEok+ER1MpPHLihqbcQNAcLyvyYrRY0QgjvcYbfhnVgJ62iAY
 MhD6OpGt5Xa4jDFGAJvb5zEBi3LIv3SJ1oWmgAQtW//h7MHA8XzeLHIzoNg2Z5LCHmnr
 ZnW8jwMXyJSDIFXwryYn9szWsm8cLsKQOxYnJIvUtdLGhY1Vgw7hBU5gt9niFk45vnyL
 uiPE2Ph6ejNR+N/Z6VTCYsBMe7UVr2movsl82Ny3DSXHz56nDd4zYZS6Oo+3bTrQSU+H
 ZDyw==
X-Gm-Message-State: AOJu0YxqTLPluooQ9tFD94OmPPMO/1nSdr8Rz58VaBcjYiWkz0MHP7GH
 mV07HuujVy4+cjUoBNCmO9LyCPoYQ8fA2du+2PBpsBXrrDDMP5oKbdIIVZGHift3oQeLZtgbESC
 lSjsh
X-Gm-Gg: ASbGncvLcsdb/fD/D5V9DSs1OVXB6aubfyTPfrhyIC/RzquwglXJf0hHA92wFFKFh/g
 N2ArzrFrklCy3zdo6V3QV6Y3nFsqL883HSjFgXUTfBDlhL0vwuV6wPFnTaORNlr53Nj9eYnKwjV
 OHM4v0jtSaiAit/6cisi1Ho48hDqRSVwdcYr/sA31c+ig5NxC7uRxv1MMHLXYPgDe1SfQ3b2sMD
 zlSlRXCm7t2dDcXfXYy8sHv8YaZ0SiSS/lzH+0yggl53nB3MUayaNLLJ42BmiuUkTCkNWFhXrpc
 6HiO7i93NKlxBxexTHQJVzrqhScV/FO6+TxkSvWe4kRSHoai8Em9wVxA+tr2h1vgnHE=
X-Google-Smtp-Source: AGHT+IEbbVpxdtR4FV6sLGWAzkFGZo5K/VevjnVXsId49D3E1OpNEN5Xg8ZeQCesuYGmQBd4KdOrbQ==
X-Received: by 2002:a05:6214:4b09:b0:6fd:27:5a43 with SMTP id
 6a1803df08f44-702c5696090mr50371326d6.4.1751642104274; 
 Fri, 04 Jul 2025 08:15:04 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d6039fsm13658666d6.111.2025.07.04.08.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:15:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [WIP-for-10.1 v2 0/5] target/arm: Add FEAT_MEC to max cpu
Date: Fri,  4 Jul 2025 15:14:26 +0000
Message-Id: <20250704151431.1033520-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This series adds support for all FEAT_MEC registers to the arm64 max CPU.

It includes the FEAT_MEC registers but does not modify the translation regimes
to support the MECIDs. It also does not yet implement the two cache management
instructions introduced with FEAT_MEC. Despite these limitations, most software
stacks that rely on FEAT_MEC should work properly with this minimal support at
the moment.

I'm currently exploring possibilities to support FEAT_MEC encryption (or
obfuscation, for testing purposes) in QEMU for the various translation regimes
used on arm64.

Gustavo Romero (5):
  target/arm: Add the MECEn SCR_EL3 bit
  target/arm: Add FEAT_MEC registers
  target/arm: Add FEAT_SCTLR2
  target/arm: Add FEAT_TCR2
  target/arm: Advertise FEAT_MEC in cpu max

 docs/system/arm/emulation.rst |   3 +
 target/arm/cpu-features.h     |  15 +++
 target/arm/cpu.h              |  31 ++++++
 target/arm/helper.c           | 189 ++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |  18 ++++
 target/arm/tcg/cpu64.c        |   2 +
 6 files changed, 258 insertions(+)

-- 
2.34.1


