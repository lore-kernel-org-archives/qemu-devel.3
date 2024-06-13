Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E203C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 01:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHZHq-0001rb-Ki; Wed, 12 Jun 2024 21:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sHZHp-0001r7-C8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 21:29:57 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sHZHn-00088t-5F
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 21:29:57 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6e57506bb2dso416666a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718242193; x=1718846993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pUxeVtXFywMjJ65TgYZqpczOCAAoUYi5WukUsqHRsHg=;
 b=GBAu9FhCfUdSdB7O7zgjUFuIWknEUDALYXwLFlLV5/vfuKXkHibJ3HUOSP670jzNZ9
 UcqCgmKvnvD3a1ucnF0hY+Z/e38V9oO3QByVUfPHKEI4P261TqhOOurmJ0wOESOuwgh4
 a0T6Pah7Czh2FnpDcz7IdvTTyT49s1iR6loImipZZ+AVgiWfiyO3Fd3rpVOYig+MtmTp
 KjUNaobzUoaXIdxflhLicUEh3e+sf1tjYbgC7S4Q6bx5U5ntOWyDULqxu9ZJ+Vc9oqZZ
 q7Azm9+WTR5JVcLUPZ3i1GhdsjSuJuSpEigQDhXQlO4PqP1AqjW3//FfGwV8jW0TtZbi
 z59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718242193; x=1718846993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pUxeVtXFywMjJ65TgYZqpczOCAAoUYi5WukUsqHRsHg=;
 b=aK0Z9kEJyYNdTezwlytFyDAjJKUtkHJ0EKWtfE7zChhPZziAynk50x4LLp9Bam4opV
 9dpC1t+GxDDa+eqku4R+XjaYyH5mifLgdgWfs/jg2R+uIF92ROuDuaC/vB8GPCRHjUOY
 L89pTA3Ybw2a7CTA8sAGajhMs7Xh92xCIsOh2vV9J8wAFcfMvGspHeQYSq84JczFAGLQ
 49NBQ8+mgMXecD9zZ4A2Ghrnw0whiif4okql8RM4gFdQJS44weSQjWnD4jkwf9OOZWcm
 PIVpQOXByVvb38YTY6Iriq7c/6swzz30RGCrOHG9pm7zJmW9Sj5wS1Qe+TzlSWdUN4Gf
 jf4Q==
X-Gm-Message-State: AOJu0YwdhvuiFSiEYUlQn8Ko8c3XC+YyKu4u7qSS9S6nSOmW6aufBBg2
 +APXhQGMh6ffgKQ+TrYtOqc4pXIfR5VX2/l9VRYDl9pfz/NEC4rc0VcgDtbKUeFADRZMGx1AQKi
 h7E8DvplJl8M02o8efmbmj0p7ypIGlyGAdG22ryTZgmnPL6Yt1etm6S+JoOgI27ZrAZ5AzQXaBZ
 vDHCZzn7/zE8BuvpgSCz5mHs19TmNjGzLrelw=
X-Google-Smtp-Source: AGHT+IG9S9an4bUXa4pAukc7+QeLlxmaoZz7ad+StH+Key/HS6w0n1sILvuE6PIebBiwOpLaJZJkRA==
X-Received: by 2002:a05:6a20:daa2:b0:1b8:3ddc:913b with SMTP id
 adf61e73a8af0-1b8a8dfb0ecmr3813796637.0.1718242192896; 
 Wed, 12 Jun 2024 18:29:52 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e723fasm1264155ad.97.2024.06.12.18.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 18:29:52 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v3 0/3] hw/dma: Add error handling for loading descriptions
 failing
Date: Thu, 13 Jun 2024 09:34:58 +0800
Message-Id: <20240613013501.426905-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x52c.google.com
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

The original code assumes that memory transmission is always successful,
but in some cases, it gets bus-error.

Add error handling for DMA reading description failures. Do some
reasonable settings, and return the corrected transmission size.
Finally, return the error status.

* Fix the trace format for an unsigned variable

base-commit: d82f37faf5643897b2e61abb229499d64a51aa26

[v2]
* Add DMASR_DECERR case
* Squash the two commits to one

base-commit: 915758c537b5fe09575291f4acd87e2d377a93de


[v1]
base-commit: 1806da76cb81088ea026ca3441551782b850e393

Fea.Wang (3):
  hw/dma: Enhance error handling in loading description
  hw/dma: Add a trace log for a description loading failure
  hw/net: Fix the transmission return size

Fea.Wang (3):
  hw/dma: Enhance error handling in loading description
  hw/dma: Add a trace log for a description loading failure
  hw/net: Fix the transmission return size

 hw/dma/trace-events     |  3 +++
 hw/dma/xilinx_axidma.c  | 33 +++++++++++++++++++++++++++++----
 hw/net/xilinx_axienet.c |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.34.1


