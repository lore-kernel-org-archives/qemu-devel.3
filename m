Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0977BCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKad-00055E-2s; Fri, 29 Mar 2024 18:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKaa-00054k-JB
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKaY-0001oq-PP
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6fb9a494aso2025075b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750841; x=1712355641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qr/N/lqi8D0MtNgzf7ekyOoEdRFxQBJmydgqZvhBPbg=;
 b=tGZ2W9vBTRhEX5XSNMz2i66FW9Sk98wYicXh/c9btOdOwINvg72kgKpMtVlcU3n2m1
 2w2/OrrVjFyeRcJph4g5xWKe/DX7ER36T7fUCAUj5cwHI3OBn1DTVL8pXkLrwxX4rNzN
 S2QXkksKXNbRmH/uVAHg4faVPgPRi8yakmZ6seyfh6kvJ3tZ0oYrupPg/5iVSoXU/iF5
 Thzw5b3VXWl5iTNhIArXkKblu1UrtYCkXJxTjTTA6FDHrigLXtMvugFJv2w5tdh7ie4a
 60LbtHKMn2XxpKCZY7CAFjFadgTgyxTTiCjNvTlxiGJnNMETAnIvgsSQ/17kPKqsS0sw
 gXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750841; x=1712355641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qr/N/lqi8D0MtNgzf7ekyOoEdRFxQBJmydgqZvhBPbg=;
 b=MNjobMgjLZz0NAT9/PHu+f/9AC5VRvPbtqTu66Eu92Pk+kdzSmaKIIUOuxyDTJ2xnl
 ipDbgV+HnhIrhIP9OpNo71zIc2GEorJ6eu2NMcIslmZHB1I5XEEFHiHm4Oua/mY8y1gv
 nBFdWW+I5cc9cH0vtGzktSfYRK3Lq1UgzEVpV8pthBaDBnLdHx2z1Z8OjyfoiZZzWDCf
 K/vDWM2Ia6eo8sDV3xLtFnVn+YeoYEcIEk1oSvo3PYnYLuoMlx1KJ4Ael5JOf9Z/jFMY
 CMJXYin045HMkABkERZcxz/Z4ZHS3BKM2E6IY+J0Pl9fS9LEYgFwJ9cM9qoRCpp1osHe
 8f3Q==
X-Gm-Message-State: AOJu0YzJKX9tBx2ZHRdbqkPB4c/j2PhjH9FOxg9ovq4wD5vgJ+cEtvSv
 uGMPfIIvPI/a6+zHx/su3ATU5WaN0QBVc+ajU8herRcGcTwyCPNez/XbZfXqwK7Fwsq4pyCwllw
 4
X-Google-Smtp-Source: AGHT+IGFk8+vlggyJxWOX3H11ujAmoRwTrE9tZcmKUgu428eyLItnMFwAqKbC+1wOLXPkvzZgiiMMw==
X-Received: by 2002:a05:6a00:3ccb:b0:6ea:ab45:6532 with SMTP id
 ln11-20020a056a003ccb00b006eaab456532mr3804293pfb.1.1711750840901; 
 Fri, 29 Mar 2024 15:20:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] tcg + linux-user patch queue
Date: Fri, 29 Mar 2024 12:20:30 -1000
Message-Id: <20240329222037.1735350-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:

  Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240329

for you to fetch changes up to dafa0ecc97850c325fe85cd87dc0b536858d171a:

  accel/tcg: Use CPUState.get_pc in cpu_io_recompile (2024-03-29 12:16:00 -1000)

----------------------------------------------------------------
linux-user: Fix shmat(NULL) for host != guest page size
tcg/optimize: Fix sign_mask for logical right-shift
accel/tcg: Use CPUState.get_pc in cpu_io_recompile
disas: Show opcodes for target_disas and monitor_disas

----------------------------------------------------------------
Ilya Leoshkevich (4):
      linux-user: Fix semctl() strace
      linux-user: Fix shmat() strace
      linux-user: Fix shmat(NULL) for h != g
      tests/tcg: Test shmat(NULL)

Richard Henderson (3):
      tcg/optimize: Fix sign_mask for logical right-shift
      disas: Show opcodes for target_disas and monitor_disas
      accel/tcg: Use CPUState.get_pc in cpu_io_recompile

 accel/tcg/translate-all.c                    |  2 +-
 disas/disas-mon.c                            |  1 +
 disas/disas.c                                |  1 +
 linux-user/mmap.c                            |  2 +-
 linux-user/strace.c                          | 10 +++-----
 tcg/optimize.c                               |  2 +-
 tests/tcg/aarch64/test-2248.c                | 28 ++++++++++++++++++++
 tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target            |  1 +
 9 files changed, 75 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2248.c
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c

