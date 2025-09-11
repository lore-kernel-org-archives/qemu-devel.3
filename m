Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DC4CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjpA-00057J-QK; Thu, 11 Sep 2025 12:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uwjp4-00056E-UL
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:06:59 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uwjp3-00068q-4O
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:06:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32d6c194134so1310811a91.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757606814; x=1758211614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LMkhBnxP1K1lXBwRpWEfdoby7fEpJeDOFfIr89S0Eqo=;
 b=Y6BH+z7CMu3PxQeS3HUa/GKLnTUEl0uhZ8At4dV9AWLwTdkDFIxo/teOZjj0B4Pu3K
 gmDHJdArZQ14+oz2I0+hDr8eoGR+F0YdSNxzGlXzUrVus4velwpwspE6hAU+auXHdCTJ
 v1WR0FSGnrW+sg62+LbA2+iGx7QQj/5RVZPRyPcJ24yg3i5H0VXk3ea98PoxfztreRNv
 rq5Zk/jCsh5tKE7P7j9KKUK9hKQo5yS4/jShNJ0IVu7LkUTZwTUz3DvlDUf9TPvf9bx/
 FeEjZXlvLwUTp6lNWnkf1WzgUwutEuzdvFd689U9YbjMYpVPKp6xKmn9rU4XQ0Zey+Gi
 qP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757606814; x=1758211614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMkhBnxP1K1lXBwRpWEfdoby7fEpJeDOFfIr89S0Eqo=;
 b=QKalbx4udVGMwuFWztngkltxPDsYh8UMx8pyL262LcoIbMKmeylr/YnUJRpRgwihcY
 fOs//jG21tOHi42Gf5fco+JGjwHaP3MG+ezCtNUgBL6zdY5axNgXw4pIgefW5CDIsVvY
 hhUEEgUAOxQGLDgON3+C5DQx9fkAarjmRT747rbZ1TNvTMqS/uvbao04LKIdOuhglrs9
 bZ7ln3ivl1U1Z3U3wDgohSRf4QCPvJXax28qBknSqi2m4c2qPXRO++xIzVm08pofiujM
 nCs3ycLvPMV8BdGtrTVD9tUzbkmAw50OC4c+UxHmbGOA9R22wva72PHiS34GOtOfVFh2
 46Xg==
X-Gm-Message-State: AOJu0Yxz012m/jXprMLI2KHm7oxT5SG1tJaOppDhcwFluosxGjSH/yMb
 KilbWOf3o/FcLExdBTCxnOuhLH0XKRveBY3pVNE4LSXSgM2kX3ZMSG/RpmRCg/B9boOODKlc/8F
 yC/aP9Qc6IanUADJ1CxJww3PmDW/veoSLbTDi0QK4CmKXQc9cQNHkC5+Xq8xmdjv+TD8M+zxx3Y
 3/L2XgJv85bOrDPbSmVXqz8KXWnQa8N+AcWE45KpQkfEne0g==
X-Gm-Gg: ASbGnctryo5xN29zrE5jlgR4yEbOvrcZe1UFAPofXFKoUn/aD7Gz6muQ8DBB1XHQzcd
 2Q02EC8uctIs3KMZusQjtSwPQjuwaVmvjFkRKuiZyG8lo8tysRAlLmK1lIUE27OgE1RSBTn8pq0
 bJraFUJnGjuvTwTBostoBmZ7RCfhcESCeltPzcVTpXotOdASHQM+YjwLxJCfUlHyg6e40FjS7WI
 iEdPr1Rnu2i4E2ALSGb5AaGY0t1x8Xz07Hdurg2jhRAjZj41OSh0P+4DgKg3DYs42ldr8U4kyN0
 BGxddOrDWCmc/fta+sgxBDxtBBkkeQQgMyHxL9KrAvQf9KSkhntT8Tq0lBGxXS8ZDQyQwakY7jV
 fVA860aKQtTK+wl09ZA5fkEK4ypdMq0UZs+ALi8ZP+lhhTCtPYND6CEp72MNO
X-Google-Smtp-Source: AGHT+IGpNm5A2658L6+ROOG4L0n01PQizIba4+pp+39zluhCjRERtKb1dIut/EoP7iTZFi4E9l/8Pg==
X-Received: by 2002:a17:90b:5584:b0:32b:cb05:849a with SMTP id
 98e67ed59e1d1-32d43f936fbmr24008008a91.29.1757606813701; 
 Thu, 11 Sep 2025 09:06:53 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32dd9903a2asm2618765a91.24.2025.09.11.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 09:06:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 0/4] Fix SiFive UART character drop issue and minor refactors
Date: Fri, 12 Sep 2025 00:06:42 +0800
Message-ID: <20250911160647.5710-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
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

From: Frank Chang <frank.chang@sifive.com>

This patch set fixes the SiFive UART character drop issue introduced
after commit [1], which changed character printing from synchronous to
asynchronous.

Since UART now transmits characters asynchronously, it is possible for
the Tx FIFO to become full, causing new characters to be ignored and
dropped when running Linux. This happens because:

  1. The Linux SiFive UART driver sets the transmit watermark level to 1
     [2], meaning a transmit watermark interrupt is raised whenever a
     character is enqueued into the Tx FIFO.
  2. Upon receiving a transmit watermark interrupt, the Linux driver
     transfers up to a full Tx FIFO's worth of characters from the Linux
     serial transmit buffer [3], without checking the txdata.full flag
     before transferring multiple characters [4].

This patch set updates QEMU to honor the Tx/Rx watermark thresholds and
raise interrupts only when the Tx threshold is exceeded or the Rx
threshold is undercut.

The remaining patches contain minor refactors, including removing an
outdated comment about the Tx FIFO.

[1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
[2] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifive.c#L1039
[3] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifive.c#L538
[4] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifive.c#L291

Frank Chang (4):
  hw/char: sifive_uart: Raise IRQ according to the Tx/Rx watermark
    thresholds
  hw/char: sifive_uart: Avoid pushing Tx FIFO when size is zero
  hw/char: sifive_uart: Remove outdated comment about Tx FIFO
  hw/char: sifive_uart: Add newline to error message

 hw/char/sifive_uart.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

--
2.49.0


