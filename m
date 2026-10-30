Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F019606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=QJKaMP5p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdrv-00022d-H0; Fri, 30 Oct 2026 00:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdrt-00021P-SQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:29 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdrr-0004nY-RY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:29 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-369fc2e984fso36608eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793333125; x=1793937925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QuZcI3GqLHmnut7TC7mIxlV5/8ddg6G9Kx6CoZ5zWaw=;
 b=QJKaMP5pIaCjZwpQE5565grXHmm1odTNkEDUYXJxnhPj0b4sNM3CH3muN5bch5FZJT
 g+P/uXVeegJmW0U21WkVZVj5thpFXyed6w2NwfhT0TwHJitL9YJljZJ7IsiU4wwzhm/7
 Lnl044ZeVJgZMM2lF6LrLTlsJjd0YAcDvQoOL1/v6PHOJBq7aBkohiujSO7BUJ9T6Olv
 75+dPZE3SFfQZjyDetvcJy51el/TgsTN4LoJ6m/O4lBKpsntzxdWwpJPk4SUTvKQOL4c
 3XaUnIVp25HmjdgHhsKWwZ8YZ6neP6fkTTpAF6mA/6CMy5kLgB+KMsiUBaaSDgihWacj
 xOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333125; x=1793937925;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QuZcI3GqLHmnut7TC7mIxlV5/8ddg6G9Kx6CoZ5zWaw=;
 b=l1h0oSG9fP1PBwXS3TdZHrPshKBOT9JRh23qkrKiUcpSYiGSuCLhDpgyG2LaeXc7PV
 RIiyX/gCFXmWvXJSlRZ919uQYNUyocb/TyT7QIrDUFOiukX9MgTAun/TinNLnS1AIajl
 fXArpELjPnqYgy/6eqn+UIKaa54/WIuxz/37r8ajHnVDhTQ5n6Jtp5wILV4AkEcNs1Es
 Q1nQQTQcgXRYo3a+SRNWOh6+wczpD+YqRgA65N4p/Hh2+jutny3uMdhQzJFjOHH5EwoP
 LzDpKDNeiOv8XcOt+a4abawp/iOo+9V9F5kbvl8gh6VqiW20jsmP2VQ1iZrXOV3RMeWw
 IW/Q==
X-Gm-Message-State: AFq9FYLxznW4GCP7g8ZIH3D5g4WbUih01bQ/6EVrtOaq1hN5k+Gh0FKu
 nHxZCZvVVePc5XoCVenE8vNSpDO90IBT9blv/tBvHurXNwhANZRq2yIizRJSMh89ZbLA8ul2CqT
 rvBss8eo=
X-Gm-Gg: AYBFou048/TRKbK4aq42+6rx12MqKOy2T6wkF11gc0s5F19qj7vUBXKO9tQrKPC0KPm
 cQSavi4w69EdnLRhwXtZfMPq2JrA/VqU2NnnhxkH3baJBAfyrT2B0GDngFv8Ra9kOrcAOug/59c
 rE0AO8PfVx/pcogN5lW3zP7GS4Vhg0eXrb3bB65rECagKtvx75+tpFbUMcnaqgGI2LjNqqWwsID
 NQK3PZO9zFbuNg+8ELA0Mmz+b0c8mA4j6za534AgUTUezf6FC3EV2pgLtl1kh5OxkyHJKxXjGpI
 20TdZSWgLSIqPkenIuNr5RkhKZ5T1SSH8R3k7UKR+4aT2qYqZeUN1LLV3b40IDpxNxjKUWXLNVv
 CwHOup15SqnLQHO8qEc2O6fwpkdJO4vH4ueOS3Fwgea3DxS1fMXCUWFPl8hZXrn/N+W1hdv7Rd2
 Cv8cFZpsN/wgl549HT1bF7B9NLnJIsxWz6KjhlA6LRjMGuLiQDqLffRE/U9ox6og2gZv0JusO5H
 iG68lmDzxflcPSNfjmJH7S8YKzU3Qgps6Brv8vpuENZGrMzeERPCqcbZ42o5hrmxeJ3uWZG19Ua
 Qwrk09UnE4BkUaGBc0ordU/kl/QE4O0CCnlFZ5K7cMfgpmQpoNCM2171LNpHEyV6ONfXokIEEjx
 hVw==
X-Received: by 2002:a05:7300:e9d7:10b0:36a:1452:8da9 with SMTP id
 5a478bee46e88-36a4231f759mr3297818eec.1.1793333124527; 
 Thu, 29 Oct 2026 21:05:24 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm2957687eec.5.2026.10.29.21.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:05:24 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 0/9] Add the RCPU to Tenstorrent Atlantis
Date: Fri, 30 Oct 2026 14:05:06 +1000
Message-ID: <20261030040516.853444-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Atlantis includes a 32-bit RISC-V core (RCPU) used for boot, low-level
control, and ongoing system management [1]. This series is the first step in
adding the RCPU to the tt-atlantis machine. The RCPU shares access to most
peripherals with the Ascalon cores. However, the RCPU has a different memory view.
This requires a different memory map and a private memory container that the
SoC aliases the shared devices into, at the addresses the RCPU expects.

On hardware, the RCPU is responsible for loading images from the boot medium
into DRAM and releasing the Ascalon cores from reset, via the CPL. This
functionality is not implemented in these changes. The images for the Ascalon
cores continue to be loaded directly into DRAM via command line arguments and
the Ascalon cores start executing at reset.

With these changes, running tt-atlantis with rcpu=on will create a separate
CPUCluster with the RCPU, giving gdb two inferiors. If no bootrom is provided,
the RCPU hart will be held powered off. With a bootrom provided,
via tt-atlantis,rcpu=on,bootrom=, the RCPU will execute the image and console
output is on the second command line serial. This series does not provide a
binary to test on the RCPU, it is in active development and not publicly
available. The QEMU tests are updated to test booting of the Ascalon cores with
and without the RCPU modeled. The machine properties related to the cpus, smp
count and cpu-type, apply to the Ascalon cluster. The RCPU is an auxiliary
core and is not configurable.

See docs/system/riscv/tt_atlantis.rst for usage.

[1] https://github.com/tenstorrent/atlantis-soc-docs/blob/main/data_sheet/atl_soc_data_sheet.pdf

Changes from v2:
- Add marchid for RCPU. Use it to check predicate for RCPU CSRs
- Disable user_creatable for cluster devices. This really upset the review bots.
- Use generic create_unimplemented_devices, squash
 "Back RCPU memory region by unimplemented device" into previous patch, it is
 only a single line change now.
- Change default for rcpu to disabled to ensure no change to default smp behavior

Changes from v1:
- Include RCPU in smp cpu count
- Fix incorrect address map naming of PRCM_DDR and DDR_CTRL
- Drop valid_cpu_types enforcement

Portia Stephens (9):
  hw/riscv/atlantis: Update fdt functions to take generic parameters
  hw/riscv/atlantis: Move Ascalon into cluster struct
  hw/riscv/atlantis: Store Ascalon memory in cluster struct
  hw/riscv/atlantis: Create CPU cluster for Atlantis cpus
  target/riscv: Add Tenstorrent Real-time CPU
  hw/riscv/atlantis: Add the RCPU to the Atlantis SoC
  hw/riscv/atlantis: Load the RCPU bootrom
  tests/functional/riscv64: Add rcpu to tt-atlantis tests
  docs/atlantis: Update Atlantis documentation to include the RCPU

 MAINTAINERS                                  |   1 +
 docs/system/gdb.rst                          |   2 +
 docs/system/riscv/tt_atlantis.rst            |  46 +-
 hw/riscv/Kconfig                             |   2 +
 hw/riscv/tt_atlantis.c                       | 635 +++++++++++++++----
 include/hw/riscv/tt_atlantis.h               |  76 ++-
 target/riscv/cpu-qom.h                       |   1 +
 target/riscv/cpu.c                           |  33 +
 target/riscv/tcg/csr.h                       |   3 +
 target/riscv/tcg/meson.build                 |   1 +
 target/riscv/tcg/tt_csr.c                    |  63 ++
 tests/functional/riscv64/test_tt_atlantis.py |  10 +-
 12 files changed, 743 insertions(+), 130 deletions(-)
 create mode 100644 target/riscv/tcg/tt_csr.c

-- 
2.43.0


