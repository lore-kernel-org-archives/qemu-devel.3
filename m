Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A458CC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEhw-0006Aq-Je; Mon, 31 Mar 2025 08:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEht-0006AM-Fd
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:37 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEhr-00016W-Hn
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22409077c06so122412125ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743425852; x=1744030652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mokU+2VFOpNhHXg7YiJYhXSuRZQ9zKfmxJUiElq6MHs=;
 b=V2zPPjnrnHd5cDgRMW+stWVMTaB63W41UALIkw/jObZuT52C3t2RK2sumAITds+ACh
 dyT+wyCXU+yoHhM3YA+fZigZc7X0h1OoajxPPK5eCC8p2ChChlmaOK6UshZH2Lnt6azF
 fdnLaiPHTjCpEgvEOh8GieGAc7dEHcM49z2kxeDjKlh16QbH02/3DhyIEw5vdGm3njQW
 TvvhwRXY8nIxNObyS4VFuoTQ/PWv/UFfKdLYf0uvSOvgqCkYLI7lRW7WtUW6uY9gDPFb
 6TBn7pqZ9AexXEEOmNl1qEPazOHicqwcrFH+f4bOm6JQPi4nVKyhgLTiHq2bVb/F+tfO
 Z4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425852; x=1744030652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mokU+2VFOpNhHXg7YiJYhXSuRZQ9zKfmxJUiElq6MHs=;
 b=trBBUs3npFgOsuLBUcT7yeq5Ooz0JkYggLoyIzgTtefwazrVa6Aictw3ZR4ZV/V9Hp
 42vGhs6adJvJoDE5BgXxCnJtafnu21vGkZSEK+A3IcozVAjbJ3/8w+vqJAXRsnI4QsRp
 pmsMdBcyO6Aedi3P5L4lAl6wpecbRqssqDJXfFCUpYNgfSyJLmgzsv+7x3CNVQiJqLys
 7gV6vIZejRXSmfQZ9+OgrZXhUUN4ZKQEP0nhoL5Ruu5nGIV8aB9jYrJkRuS5N2P0Yhf7
 T86e+6cNl/bLKAIUnxfBWqQAbBi9bBNn1hfs8J0sIX5fvGAaMjFpEfHRNvjILFM8BG5i
 Cv9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS24Tj3j45jy/DZ2/HHvo0/6bM53jNfTL1bTaNoY9Kr+RKSKBIbk+ymunEI+xf4rba6kL+ebdQ7JoB@nongnu.org
X-Gm-Message-State: AOJu0Yw2QK74NCjNQUy8S0yGV8xkm6SOqWbjv3MyzPF/2DbqDLND2EWl
 xct/uoxkBCAg31IZ1cPwnkHPaPHBF2neydI7z4djKslvNaIiWld6
X-Gm-Gg: ASbGncuYHIXNyEvvvBCHbxqXNfy04wcq2g6H7Zu5yavdggBM8f8khBt781FXS8/Cy8x
 n3PPoq1Xp2X8edxLrCLk37ik6Rl2Iz1csd8SGj9UzOJW/NxP2K0uQMB7H+UHv0gc83zelJWOe88
 Dooqv5AamLekbZasyvHkvbDna0/aCLNwMI7Q9pY9Xi/VGHy7clVeRXtosYDn0x7O3cutTWmkB2A
 Qtskr+wIT9lxVPUosEk9YxGYtYGbyQR6eqyho5s0JRvVbaza6odcA8YM5faJYWDe90EWiiTNtT5
 a5EfhbFDfPtfxxI+zhDtRH05k4O49mkHMNFmNXmfgWO7j9rWIbvAj01P5zAb
X-Google-Smtp-Source: AGHT+IH+/VRPWWRHAspFOaRrz3ApLQU0iXMW41KNS58kJZufS1rmuWd2kJ7WU665xQOdsHvuqdLvPA==
X-Received: by 2002:a05:6a21:920d:b0:1f5:84c8:5d03 with SMTP id
 adf61e73a8af0-2009f5ba5c5mr16146414637.3.1743425852426; 
 Mon, 31 Mar 2025 05:57:32 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b67dc0fsm6324016a12.16.2025.03.31.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:57:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] ipmi: bmc-sim improvements
Date: Mon, 31 Mar 2025 22:57:21 +1000
Message-ID: <20250331125724.607355-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These little things came up when looking at behaviour of IPMI with
the bmc-sim implementation running the ppc powernv machine, and
trying to clean up error messages and missing features.

Thanks,
Nick

Nicholas Piggin (3):
  ipmi/bmc-sim: implement watchdog dont log flag
  ipmi/bmc-sim: add error handling for 'Set BMC Global Enables' command
  ipmi/bmc-sim: Add 'Get Channel Info' command

 include/hw/ipmi/ipmi.h | 14 ++++++++
 hw/ipmi/ipmi_bmc_sim.c | 73 +++++++++++++++++++++++++++++++++++++++---
 hw/ipmi/ipmi_bt.c      |  2 ++
 hw/ipmi/ipmi_kcs.c     |  1 +
 4 files changed, 86 insertions(+), 4 deletions(-)

-- 
2.47.1


