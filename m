Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED187D3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT09g-0003aG-Nn; Tue, 09 Dec 2025 11:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09c-0003Za-4E
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:32 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09a-0003q1-Le
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:31 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so4431295b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765296086; x=1765900886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rivaeWgzfjbN0/XP4iJvdVQO9NW74la6gLp7r9Zqauo=;
 b=H9/gfDI8K8plTNkF1IiKA4jQIIinbVwuL4qPUhwfjCI4N+2pb5u5vdklK5eBK/4ZeG
 WaDYacKYn/jqqTED2EXBGbjLkx1iWX3v1sWAmq7MgnWG57zw65TmbTnv7NHs3b+bjpre
 95z/QdIjz4RLmjnYY1vnH0QMAlVcrAIeicctcJ5mvRYXrClnfjpuVoClYbpIlao1S8aY
 tV8l0ZARKPdAIokmSpfGKgFrDP2xYKQR9nYpXgctIIrrPpD3p8dpSN7qQVeEF6+Drl/O
 c8/MNDPOOCc5oKDU2xIVCIvv67BMkOHQj3aapjxuvVvx9Pp9+dWbpojh47cA+kRnA873
 Mxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296086; x=1765900886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rivaeWgzfjbN0/XP4iJvdVQO9NW74la6gLp7r9Zqauo=;
 b=dooE98nUK09hf0VcJ3JZM4bbBHjxaf7DhQmKmJP8KDt9xdn6+8ZZkBBT98oQW5PPmP
 D6X21gnApFd+S/45emqKaX6dVoa7DEZ+8uH12mf6JD4ds3tPnGRn4Ecr5E/YEw0Xu9ub
 qOXzjNTbLIicIOWApsWzX4CW6BBG+1/4sdPB47FIs1uMCjN0Vlh1ir8rb5W3WHJhrHyV
 Hn+Uw4/8FvQJU38cxYflYlaT1TddX2w08l3kiJIUgf7Ik37QaBYYlw9tZlXdSUJ2PPLQ
 vGrz8skc6cEO5MIOEjuzY6WMieyUZyjFuKUkuQmaLGEkqI11UA76Ya3ojPHBhXS8/AWj
 Knxg==
X-Gm-Message-State: AOJu0YzGdl4vG7tb1f6WwgrJIneMMmsFtX7Wa+88OUT/mtd85PEhlE7C
 JWRxFF2adnyTMlGoAuX4gpgNCUcsgA3dcvCcjxA7KsCPB3gHupaBG/6tqUaQsNmRGNC29ZUsCBl
 ITAC6bI5ZMuiwsRBlVNtYDs4PXLdWn/7R+zTHB5QJ/l6veJC/1tVqj0L40f5JF/TNybIys22lSb
 HL6kDnj7GkJSdRSJXFfL/nv1VMonqtXqHEEviyRGmIUBw=
X-Gm-Gg: ASbGncs6Is9ENBsS74DbqRkEP2zj95ah170Gk52GyWW1ODzPr37yCq/EGOU/ix4jmrl
 nBbUEYdFPj05j24mDqdbEea0B64lyD1VSjg8ovIjSPlDm7qT5bG/w/faH4givFH7ioeibb7NijX
 K+q9T+nIzLH0KBIS0pQxrFqOBvm6gFF2D2wqe7Y4ZfTvM1uINHZIMGGglg9CGFQDidD9r/xg0Fe
 OR4LPBFi2Yy3hzLVnkw3WpjBheHN5Eu3hutKWpeg1MKXTWRwbTxoYeCqFOn7JnXleF3OWDDusbV
 feLv9MB/fHHMN4dBEtw/VsFKO+2Isc/KwgezoNfkSH+POoDWah7wVxihWfNydrM2vIBq1u5W7M3
 AgyeB/22y2vi9wggsKx/PttzKArpkEdCpaWIrtJI9siuEdKynZ4gTqrVMyUmfEcN33nUANNA9i9
 2bc1nmJ2/TsJg9tbLannwWhR5r+akuWEPuvwym8Q==
X-Google-Smtp-Source: AGHT+IHsnMbY5uLNjPDdb/Xd4nRn1fbOf79ejhHFm3R6+aJ7SOdbL3SZgB/Q9jcp5sGuYqe1cNq/tA==
X-Received: by 2002:a05:6a00:3d53:b0:7e8:4587:e8c4 with SMTP id
 d2e1a72fcca58-7e8c46983b1mr8838989b3a.55.1765296085566; 
 Tue, 09 Dec 2025 08:01:25 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e29ff6c68csm16475242b3a.19.2025.12.09.08.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:01:25 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 0/4] Fix SiFive UART spurious IRQ issue and misc updates
Date: Wed, 10 Dec 2025 00:01:13 +0800
Message-ID: <20251209160117.1239596-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x431.google.com
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

This patch series fixes the spurious IRQ issue in the SiFive UART on Linux
introduced after commit [1], which changed character transmission from
synchronous to asynchronous.

Currently, the txwm interrupt pending status is only updated when the
asynchronous transmit handler runs. This can cause the txwm interrupt
state to become unsynchronized between the SiFive UART and the interrupt
controller.

This issue has been observed on resource-constrained systems, where
Linux reports spurious IRQ errors. In these cases, the asynchronous
transmit handler is unable to drain the TX FIFO quickly enough to update
the txwm pending status before software reads the IP register, which
derives the txwm pending state directly from the actual number of
characters in the TX FIFO.

The remaining patches contain miscellaneous updates, including
implementing txctrl.txen and rxctrl.rxen, update IRQ when rxctrl is
written and remove the unused ip variable.

[1] 53c1557b230986ab6320a58e1b2c26216ecd86d5

Frank Chang (4):
  hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
  hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIFO
    enqueue
  hw/char: sifive_uart: Update IRQ when rxctrl is written
  hw/char: sifive_uart: Remove ip variable

 hw/char/sifive_uart.c         | 46 ++++++++++++++++++++++++++++-------
 include/hw/char/sifive_uart.h |  3 ++-
 2 files changed, 39 insertions(+), 10 deletions(-)

--
2.43.0


