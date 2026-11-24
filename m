Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA0606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QcCjnY4u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqa8-00055E-QA; Tue, 24 Nov 2026 08:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa5-00054R-Uh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:10 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa4-0007NM-4V
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso41921185e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526946; x=1796131746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a1j+dqvk41rdeLoPHnPHelCKmFcC4w9ZK0uNbwh8VsE=;
 b=QcCjnY4uv3WaYksYvO92waCeX/b9VpR2DNi6gRBWyc+xRDbZ5AVNU4HuQmz8fsuGew
 3Eod9De1pCdiSoDisYfrr27DXK5+9uARI6Lah66mlA3cssrFV1a2nq/ISzXD1XYUUY9K
 sBpbdaICOWIgojU+SviRtaOo+xy/fq46fbjbEfNK5o8JhBFEc2ylJIRxMZ25JvzZKgf3
 2pyEAVUsoNt7aUEPqGHrAtDxRuBuJ877Nbf6z/fXOFWFOjZQ7tC4dRxzr90cRvDfH5W7
 IjF+2JsknqvVe+GLsKIhGoMFa8p3zsbqogjSpGs6V2KlrTbDh9VoRfgxfECYWoayXtGm
 xO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526946; x=1796131746;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a1j+dqvk41rdeLoPHnPHelCKmFcC4w9ZK0uNbwh8VsE=;
 b=2gapDCQgWm8fDk/oZXzzpvuaCQF7lIInr9AVIvIZmVRWVacUY7/zfNqCCledtWIbR6
 VNXKSWbGIXaMaA+AteZDgpXe+an9OX13my+eHdr/qKXVv+YIobXYKMffk+9HGL5KqsK9
 VzooWtdLB7uf2nxoN4L70bs0hF4LDT4Wfhp/FqfflTAi86rsF9dCEJRTBzR2OZgQRKZ3
 wlmvtUHMZbV7tUG+qMNYqyr3sYfLlk4PCQkHE7Uc5BzMnlTr6UvlaCsAlgzZ72UXzGUg
 zkZy3eCBh5k4aUFY7XZ3sWk6IDav0mqWImgP5ShDKou9v3nPf3h6AjkcFhONCp7v1tSp
 +7zA==
X-Gm-Message-State: APuU4Z8sG7xv/2Qx2rgzT01r/zse4wyD9Of/qdK3RoGJVSwZUtFJoekO
 zBAHh7FYV/r/aoLT32I2B8PO1fzS/7PAL2FNSUKG4rrgItyyeedKWnUEJxZuFMCq2qgBKrlVGaf
 5FFju
X-Gm-Gg: AZFdTZdGdbsmxpFKg0k/mT+6fqUtpW2DEGqJsBje+N5rTC7YbrWCB3dHQNaE6DsIQRu
 ghYiLTR5CTGjuDj5d/aC3s2CTGS4mXOZgrerUoukR8N7APFFcn92XOTcbnMPFnshTTqOSzUkhFd
 D/lpRuCwV0XavC4ntIMbV1yxPmCcC6hSDT6r+InEwpUpiodv4OHUjYB5wG/mpWqSh/sE3JJKnJK
 ZWFV4g5BqhvJHp9gxvxEm2Q5/c8GrCBCfyCnxUprnH8JHgKPpp2Mz4KSPORlS7eT0bH8FN+tSZJ
 usWP9Tcmk19tiP+HFqJD6ZCohJJPUHxOO87GnX16d7q4wf7jHgFfmO1/LWJQ8PC34oflJOhi9JC
 hLVRAL3ExoOlPPUVznfvKmwKSmP2Cr48lLnvbM78buhVEkVixGrEVC1lCYovNLEAC++TU6VWMPD
 RoIp9RrJ/Y3/fcolrKnvjSUj5++YZQoT/di6BrWeOeZ7FwCgG2ZZMMat/UvQiFjq9WnqFa0u+PG
 YE8iHraJCUaMEPnEhp5wA0SdmvTteVbLRCZ6k6/CiwrnPXOFxOSNmymUJXw0/9BM6x5pskUUrB8
 7BKHn/TQGqTVztNv6y0LQ/QJYX5LWdsF6UDYElmIuvb7oYrp6064u44v/Rp9hY/bpSueiUkDA9A
 p5Qu/xdfUjU1D/gQBQbkZbfj0H0X6jsnMJw==
X-Received: by 2002:a05:600c:a51:b0:4bb:5f43:23bb with SMTP id
 5b1f17b1804b1-4bb88828173mr282616075e9.33.1795526945735; 
 Tue, 24 Nov 2026 05:29:05 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target-arm queue
Date: Tue, 24 Nov 2026 13:28:55 +0000
Message-ID: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi; here's a target-arm pullreq for rc2. All bug fixes, mostly arm
but a few in the net subsystem.

thanks
-- PMM

The following changes since commit 2bfbe39d0fff8af881cffe2bab9b615e77807c35:

  gitlab-ci: Switch the msys2 job to use ucrt (2026-11-23 09:13:18 -0800)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261124

for you to fetch changes up to c020bf46966ae4dbbf82efbc4c5f3435a2fda42f:

  hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register (2026-11-24 12:55:53 +0000)

----------------------------------------------------------------
target-arm queue:
 * net/checksum.c: Correct handling of IP header length
 * net/checksum: Correct handling of checksums when IP options present
 * hw/ssi/aspeed_smc: Correct minimum_version_id in vmstate
 * hw/net/rtl8139: Limit DMA transfers to plain memory
 * hw/arm/bcm2838: Route system timer interrupts to GIC
 * hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in EOImode 1
 * target/arm: Handle "PMU disabled" in migration validate functions
 * hw/watchdog/wdt_imx2: Fix migration when pretimeout-support not enabled
 * hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register

----------------------------------------------------------------
Fuad Tabba (1):
      hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in EOImode 1

Jayesh Agarwal (1):
      hw/arm/bcm2838: Route system timer interrupts to GIC

Peter Maydell (6):
      net/checksum.c: Correct handling of IP header length
      net/checksum: Correct handling of checksums when IP options present
      hw/ssi/aspeed_smc: Correct minimum_version_id in vmstate
      hw/net/rtl8139: Limit DMA transfers to plain memory
      target/arm: Handle "PMU disabled" in migration validate functions
      hw/watchdog/wdt_imx2: Fix migration when pretimeout-support not enabled

Zenghui Yu (1):
      hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register

 include/hw/arm/bcm2835_peripherals.h |  1 +
 include/hw/arm/bcm2838_peripherals.h |  4 ++
 include/net/checksum.h               |  2 +-
 hw/arm/bcm2835_peripherals.c         | 33 +++++++-----
 hw/arm/bcm2838.c                     |  7 +++
 hw/intc/arm_gicv3_cpuif.c            |  5 +-
 hw/intc/arm_gicv5.c                  |  2 +-
 hw/net/rtl8139.c                     | 98 ++++++++++++++++++++++--------------
 hw/ssi/aspeed_smc.c                  |  7 ++-
 hw/watchdog/wdt_imx2.c               | 28 +++++++++--
 net/checksum.c                       | 46 ++++++++++++-----
 target/arm/machine.c                 | 22 ++++++--
 12 files changed, 178 insertions(+), 77 deletions(-)

