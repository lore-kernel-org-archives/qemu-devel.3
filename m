Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488AEFED2C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wma-0007Fg-Sc; Wed, 11 Mar 2026 23:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0WmZ-0007C8-Ca
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0WmX-000662-NA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485345e1013so12290295e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 20:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773286334; x=1773891134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RMshlMcP2B9t2iIitFYTdKOtZlH5dtNUNX5rxIofpRU=;
 b=Z4A64uAlNsH1z4IHpUpJZMlV9lR0Iu7gqx9ct6iOfXjVTT/2ZI3/hKwdjyelzWIZ8Q
 Wu7e8KHOIHhM9p9f1DBKZZ2idjzQyycpTDDb4TdKD//jI6524ZBo/LkOvkze+G32f1ab
 gxUlQKJB4dXjQ58PW+TzXyXkR2YIra32gtqmCxOECzQMS4PKr9j+c5o/gUw4XQKZAAck
 3u6Fr+5rXcMIVBtYnBkjBNbuDObXTrNHGRvQJFb23+gqvuzKZwj3j1foRYWIonNjijpm
 je4ozE0ZtGgzHLltjhsEH2ZxHLODF3tkjCrVUrKzyMzRipo07rcLH72bmhloZrX9b3qc
 f+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773286334; x=1773891134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMshlMcP2B9t2iIitFYTdKOtZlH5dtNUNX5rxIofpRU=;
 b=HjeUl8w2AdgqTz6HwG/yXxa/Q+UKlT3zhZTSUGeJrSIrl1Tl3cFu/nhcbjdpB5YgfM
 YGXVgw4rOvegr98fhMoQkMqwN+PwOtezChdZWJFsjfynkNwW03SWSz5Jf67trPfYFyKG
 mVPXhmk68V2+Q9aWAhhVVI88/UZM3eBQnnZBvAB9bD32E6HeqiL+Vdag5DC72IoSZoG6
 L27HCGy5Fl9xxXIEObgUifBRh+c+vAlI3QWo1Rt62/1PBKdABhtbmG4TTuJk7p8x7W2p
 OQoYFKOXojbIgw5v+FMyr/afS1OqV2XctFd/fI6DKEVJ91sC6kZ5qwiJCJHmjlzREDj8
 XaxQ==
X-Gm-Message-State: AOJu0YwzQXongCdr+VlkN7ps9rn1IG/5kI0OIOMi88oXrMlyl02iQwfP
 3r+PDb41jCz1YlXvV/sa54cd1WhYGIuFe9YinAUfkBLlfwZJG2hq0DRtDG7z3zwTIWPIOtTesBc
 D70j7Ds5124sKYR/abD6xGpaZ7wPaFulz3S31POW/fpH/J9HqB/W2+25TrWtRAZINXDd/JtLnxo
 mvSAsk4fE5RuCeod1AP6amzPCh8jlUv44vDlYEQtP2eQJzQg==
X-Gm-Gg: ATEYQzwmfJVmQHPAZAhkiFa9/rKCyqIrA/QzsbJNo9zlwGrisZvRBd02SPNNOR4R79M
 HFt8R4gT8xANVGN6UqpffClwOh2TO7hIzor1GmvKJQpsV0dCXi4Fmzx3nLDobMZtDsvBAOqFOdK
 iHdSAJt8mhLuFhE6usnR1Ba5uQF0kTcgXEVqmkx6XWimynudcmuUT4DQbhHawp7ESDnPual/HR8
 WsEZ2p5lF2R7PDI/BDRSJZvjRm5uBj0v1xtj7Itky6FQ8+4nI/fsGi1nYaIhoZ0xOEtteiFJ7yZ
 f3ygEv/UyJuU75cwD9jfbfTLNIkFDayqTyS9o+I1rHSPDQzdV5fDByEUsg2kZ0TDmw4qCti9AVt
 SqSzICiTf34ntbSUeR1LvFBzr/b++pSkqXXQnjKocf/S8G8bUOwOJm1lEao6Lol1mlQlmID0oMs
 zFq00Ig+uLEfSHnUb6YaKu4AiawhIjEj7/QxDguBwXWRIOPK7bdQ==
X-Received: by 2002:a05:600c:3583:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4854f583c9dmr33510155e9.8.1773286333748; 
 Wed, 11 Mar 2026 20:32:13 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm94807735e9.4.2026.03.11.20.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 20:32:13 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 0/4] Fix SiFive UART spurious IRQ issue and misc updates
Date: Thu, 12 Mar 2026 11:31:57 +0800
Message-ID: <20260312033201.1619554-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x32a.google.com
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

Changelog:
  v3:
    * Rebase to the latest master branch.
  v2:
    * Include txctrl.txen and rxctrl.rxen.

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


