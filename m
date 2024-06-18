Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA5C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJb5d-0003AO-DX; Tue, 18 Jun 2024 11:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJb5c-0003A4-7c
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:49:44 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJb5a-0004sR-Br
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:49:44 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52c8ddc2b29so6066557e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718725779; x=1719330579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qf0WQqL4k26M6w163OMfSJBmzPZjEk7hsyrTXViawrk=;
 b=OY4yyliQxNBLVCwJvoqqxPXsGykKFlXxVdJfUeTL4ZDAiNorgvbuZEGtJETIEhyJaC
 N3L/5jkD2Ldum+AKkKwpnJP+deN5Jaaj3+S/0lSZTRmofi7x7RQzdLvDsfnrougijwgH
 BnkmWIY2QpXjXQIox5cl1Vn1vfqPx5xeR0h9Wfl5fnZQsyskIiAjtJ+fkgsE5u5b4kho
 3wC7I0SDDbYxXvW+1MqRQzuc9Q+fHdh0ZXcmshT3FWfqiPxf65/TU4Sa0TzMM8sTe6Ck
 NcjH6BSwoDFAiCFnA/LbAjQdtSwKBgdSJ92dUYzn81hTqwwGEinM9i8moBDaFJeD+3eN
 dIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725779; x=1719330579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qf0WQqL4k26M6w163OMfSJBmzPZjEk7hsyrTXViawrk=;
 b=bz8aO/f3zh8OV3b4vVl1kYOw8JeSE1vW7FDBBn7EJ1vkhv7dS6Zv9i4ImFvvcUfPsD
 L4NspkxAW0o9U6aAzahSqNChkd+G+aVlJwK6458DviObg3SDqehLJfD6kHutD6XEompK
 82b2dO6zMSogpd/97wyMaSKwzRgxHD1Iib1zTPajGj0Nlt8coXhnOiFqtPOW/wsmvcPD
 2uas5IXqRoshHQeXZAozuawgcdRldofAIJXPbsAlhPbp4TOhOmO+NEi/8bOqNQMcq60/
 StwnB236Bi0xXqB48gA2qU/5DoWHg5AUc7jmR1PR6cY8Z8daUnGGcQ0HHvLVHeQCU1Rz
 ztKg==
X-Gm-Message-State: AOJu0YxQvQ6GyQ0cIV0/uWNvZFFET8lpkX2G2ip0JManGaRhBNgC93DV
 /K9Oa3/xkzMfaFVPQGlRazQcw+LIw0c3aISDYYLG8JzPcywbs1EJV6qjoI7NIkw69w==
X-Google-Smtp-Source: AGHT+IFcDtUiEKA5noNpZEBiP7DcBxJkwjkODHbfpobMl0Q3cm4d1AfLTTagrLXvsHxm+nyKda1hYg==
X-Received: by 2002:a05:6512:2013:b0:52c:93f4:390 with SMTP id
 2adb3069b0e04-52ccaa2c7bemr42853e87.4.1718725779052; 
 Tue, 18 Jun 2024 08:49:39 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ca2888c2esm1548746e87.300.2024.06.18.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:49:37 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PULL v1 0/3] Xilinx DMA/Ethernet updates
Date: Tue, 18 Jun 2024 17:49:32 +0200
Message-ID: <20240618154935.203544-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit 900536d3e97aed7fdd9cb4dadd3bf7023360e819:

  Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' of https://github.com/newfriday/qemu into staging (2024-06-17 11:40:24 -0700)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xilinx-queue-2024-06-17.for-upstream

for you to fetch changes up to 3a6d374b754b4b345195ff6846eeaffedc96a7c5:

  hw/net: Fix the transmission return size (2024-06-18 14:52:05 +0200)

----------------------------------------------------------------
Xilinx queue:

hw/dma: Add error handling for loading descriptions failing (Fea Wang)

----------------------------------------------------------------
Fea.Wang (3):
      hw/dma: Enhance error handling in loading description
      hw/dma: Add a trace log for a description loading failure
      hw/net: Fix the transmission return size

 hw/dma/trace-events     |  3 +++
 hw/dma/xilinx_axidma.c  | 33 +++++++++++++++++++++++++++++----
 hw/net/xilinx_axienet.c |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.43.0


