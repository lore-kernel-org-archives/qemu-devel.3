Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4F606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWI+0GCJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWV6S-0001Pa-89; Thu, 26 Nov 2026 03:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xWV6Q-0001Op-Dg
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:45:14 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xWV6O-0002iW-S4
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:45:14 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3b3a914e4c8so3777132a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 00:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795682711; x=1796287511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tQEWZ2gTIuJ9Fb+RJZ6OweiKtnXrWw/Ptuq8Rpu9lyU=;
 b=lWI+0GCJWVJ1ukcegp6Rc6kv17CrfyhY+mG+Fzmw4mf2aJ50FiHOS1ccBuct863eWv
 +oboC2tqazJwGB3whSoasdLiofaVbYLMuxHqF0zFsvS8XtD3868GLU/Dfh79SBvuS48n
 1t4T1CPlqc7v2JiJfgFrl9A28OntwQxVm+bDn/dYNNFuHOYoSA9LEekvy6vZr+4/o3Pk
 8jbENqJxrke6updyY3nOfyP3mS9FhrYchcNtav8EyxZjdDC9HPyT5Q5E33X9UVQ5AjU7
 XP3IrJlBznmp+9GtdnsFptPh3ItMjeQK+aiJ/ky4jK8txlx2rlWhNTX8uzukOJ59nEHe
 NxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795682711; x=1796287511;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tQEWZ2gTIuJ9Fb+RJZ6OweiKtnXrWw/Ptuq8Rpu9lyU=;
 b=Kk0+opO20qBllUz6oDMQ/Qq38x+30iHYGXB9RSCn+4ci68gddm4rKP1NomBSpyCkZ8
 VUcdcPqHibiKs+E2nWEt+Tqb1LPfpo2fiIRhGHlomB3fknIU6gip3W7uqHFG5yqAimOl
 81GqXZ/L/TX7ZcuDT75bnoanprmZKHD18p6MpoqGy00eJlB0TKFkVaPtwHayZsjfqRh1
 W1w9yCjtLaYV9XPKbR7QDuz+2m3TXzTD0/YBuqT9od0+zOI9pXgVlykgPUw5oo7Uc96n
 C8vKXne6NjgPkGqEean1bKMp0vmuiMdRt7sGJVaLeoEIFXs9g63EwIPHp5QV2VIZWY3p
 SS1g==
X-Gm-Message-State: APuU4Z88hdWM7paMc3HdXIGJonTPdMscU4RR5etpGPsK7v4s/S1GSU0+
 tQTw62gTQcDtyzH1pZtKdEtLTlqp44KUbRI3MOEx42PmRO7aepAnQlzzCamHRw==
X-Gm-Gg: AZFdTZfft69ZNuTvKRVjDo99oLF+OvxyK3uBRbl6XENazYd//rBCm93FgmHUZDwev/2
 3C2/khymC6QU0TukZ+vNBtxyGQi1KqOX23Gey3wMwNSc4Eazex4Scm1NRZTmF/YcbIRJhIlHyml
 6W7TGCeU94m9XMvJH+zghPBQZBu4cEHGLHoWZSGbonJIkKJhMbz5I4umvhx/3dYATXO2cnQWKL7
 nezD/K+3o1oAS2EeWqvhAsIvEKZw/QlwHx7ANcmk5ZX8ukC3HV8v00ah6KQrLGLjNa+TQNuaumv
 qygihYeumff1MXRQGqwkiJ1y4sGWLdmap4MADFbuls3S3l1eYP8NTRgNerjUi7uZcuTVvKX0CgR
 RvAQvTk/fr4HT2E+b5PyZNSbF1fukUGxAU2Q95GsHYVXLFnUUEBnSkI43nDCEf1CdCaYyR5E2NG
 /qKw1eRrF0y/JhstwTNwlxDjg/CfFHzRZdEM1kF920LdLiWFLR76nIcNdBPernzcIMslQCpMTbF
 egEMZc/wmhmaP2zFjezELKfDDErALiP3HQllMCP4zkj72/591F51v0BABI2Bs60/KJ2hvo/Dp7X
 J1/0Lnh3IxLK7hHLMWZ6YqYl4yD6lA0p/eJ73ZmaQA==
X-Received: by 2002:a17:90b:4d10:b0:3b3:ce10:7659 with SMTP id
 98e67ed59e1d1-3b41c7ac261mr19783220a91.5.1795682710539; 
 Thu, 26 Nov 2026 00:45:10 -0800 (PST)
Received: from DESKTOP-DFGP8OG.lan ([120.230.138.47])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d63728sm36939464a91.8.2026.11.26.00.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 00:45:09 -0800 (PST)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v7 0/3] hw/timer: add DesignWare APB timer
Date: Thu, 26 Nov 2026 16:44:50 +0800
Message-ID: <20261126084453.23021-1-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=rao232328@gmail.com; helo=mail-pj1-x102f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a generic DesignWare APB timer device model, and wire it up
for the K230 machine with num-timers=6 and a 50 MHz clock. Also
add qtest coverage for the timer behavior.

Changes since v6 (address Sashiko AI review, no functional changes):
- Rebase onto master (v11.2.0-rc2)
- Patch 2/3: explain why the K230 timer parameters (base address,
  6 channels, 50 MHz clock, PLIC IRQs 101-106) are used
- Patch 3/3: explain why the qtest scenarios are needed

Changes since v5:
- Rebase onto current master
- No functional changes

Changes since v4 (address review comments from Philippe Mathieu-Daude):
- Drop Clock framework mention from the commit message
- Cover the device in MAINTAINERS (device files in patch 1/3,
  test file in patch 3/3)
- Move trace calls to function entry
- Drop the addr mask; the MMIO region stays at 0x100 (the IP
  register implementation range; the SoC aperture is board-level)
- Hard-code comp-version (0x3231312A, "211*", IP component version)
- Use the Resettable API (phases.hold) instead of legacy reset
- Add unrealize to free per-channel ptimers
- Keep register offsets and bit definitions in the C file
- Drop private/public comments in the header
- Move K230 timer macros into k230.c

Changes in v5:
- Rename DW_APB_TIMER_CONTROL_INT to DW_APB_TIMER_CONTROL_INT_MASK
- Fix the K230 timer clock frequency from 6.25 MHz to 50 MHz
- Wrap the qtest commit message at about 70 characters per line
- Register both K230 qtests directly under CONFIG_K230

Testing:
- QEMU build passed in the Debian container
- tests/qtest/k230-dwapb-timer-test: 8/8 passed
- Linux guest boot tested with the DW APB timer driver

raoyi (3):
  hw/timer: add DesignWare APB timer model
  hw/riscv: add DesignWare APB timer to K230 board
  tests/qtest: add k230 dwapb timer test

 MAINTAINERS                         |   3 +
 hw/riscv/Kconfig                    |   1 +
 hw/riscv/k230.c                     |  33 ++-
 hw/timer/Kconfig                    |   4 +
 hw/timer/dw-apb-timer.c             | 376 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   8 +
 include/hw/riscv/k230.h             |   8 +
 include/hw/timer/dw-apb-timer.h     |  40 +++
 tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++
 tests/qtest/meson.build             |   3 +-
 11 files changed, 747 insertions(+), 4 deletions(-)
 create mode 100644 hw/timer/dw-apb-timer.c
 create mode 100644 include/hw/timer/dw-apb-timer.h
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

-- 
2.53.0


