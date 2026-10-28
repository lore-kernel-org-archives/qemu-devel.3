Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF6606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=UHlJ8/aA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvK6-0007TT-2p; Wed, 28 Oct 2026 00:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvJk-0007SD-BM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:16 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvJf-0001bB-7t
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:14 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ac6971aaebso50897a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161869; x=1793766669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5AiXLe1uSjSSEiktgdW1fDZBZcpHxwP2+BRnaA/TmGU=;
 b=UHlJ8/aAbbMUjUvu13+UpjPDYy3owfnqoHkL4rTIXV2l1lKkJob/lO1iz27oKEpkaF
 9RZa32SXmhCAhlbQ6nV2/BJ0F1+9ucXt7Rfogj4VulDsQd6mufPfdxTeX7XAc2Sb6Su8
 Vbe/XIVK5ywqA8SIcqM/7kQpZ1vY4hNBBkco/KIeqcRGo2ntTpxcsH7ApUXzjBXvn4FI
 ABjAnH5+cJv2lT+XPNU8Hjnq5dddr3ktXkt/CUB/f1UXpsCapzIevM7SPmckG+7sOsTo
 GwB3Xrh86uT9cTSgrn7N9VpkrVdPsgjx2DuyhEWXKhmsL/C9qWMUSGsMnuhfEaBj4YNa
 jpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161869; x=1793766669;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5AiXLe1uSjSSEiktgdW1fDZBZcpHxwP2+BRnaA/TmGU=;
 b=JdcANu1uRKSh+cTBmsrHGgRH10s393/44YQfLBa+GwbvQaB51gUvEF0b1K9B19ln1M
 VzN4fDAorkZ2TNVQ7gT6PxVjS3U1kG1ALBrFKMr31t6yvcA6YKvpFhziQhdL2WikpP2Q
 AdEvlRduzhn3NrnZ4lAX+K8xZxyDXatLVd2ic5y6yydPCB5+rrdBfwg4WTL8kytHu5I0
 TmVd7DLQ8rQgi6lUfH5eqymoLcOc1V1Sy34fPt1xtz2TONH8In9LR5cVquTu1Z32BD0H
 m95rX6z6JgbY0yJItoRWoRlGAZ0FdhaWRy0vQVm8rtN1UGQxmb3e6AOo4HmVE5CA3ZzY
 tClw==
X-Gm-Message-State: AFq9FYK5UqnjmZ0UIJceOjG6AlFY3bQuXjuEgMnZOhDS3+NeKIArj8C9
 buELem6gbApvp0VHDZcgXbrQkUNV6Oi8Awret3XDHgHTLZH63FjnVsBPQoaYiK9lrVsu1v4QEps
 7C8c1jEY=
X-Gm-Gg: AYBFou1fiI+szV19rNXHjKAoCmcOhl+QfFsPh8RcTwsTRnLRAFCQSS8q6RVv0V1Ds2r
 028Q5FbiCLf8suSv0hJj1oY455gk9sVmYb/YKmhZ8pQmDBYZdOhfjSfi1svchVCeq8E0SHBaawR
 Cu+3EjZIqc2ThNRjkAZ1UBlq0zYc6rDS+Q/rPCqtPmjgdUaEL8fxqwNNTlZkltozOE6itPpXsWU
 5oXCbfMbxZ0agJpavU0ne8Bh0OsTlAmc3U7Fl3ynqstDccfknqGFmWRLciL3sSebx75wr5sUF/r
 0ugJpWRaGxaeAY87NEzvg2TuIgzv2pCnJlGQ/8Bl2InG4Zqbd/BWFMqoJfPSGR7552r6T0uPuO8
 IuVrkL+7zkhAx/SuvU8DJ1fzlb0fsPWjKF2ep5X3ZV6a8G8u29qjMTnxSVio+kiO2cxWpQb05EL
 c3va6WlTi1CvwsfzOgxgKR2/YRbRoyKd7JpYNNpyDKz5ZyLjFLbhZ81iDQArOoGU0C/cRxoae6N
 dYJ+ViEs6VmxTXFo2iXoOu0MB6D5nzKQ3kXgYlclXHv4WmfSRIWkeC2/meTDx4AtdpD5nnzgFON
 QPJ2Oswdtp6GvEvwFv2+DjzR0b4YIxbqyXBjMIEwJadBXghN0/EiGTNvUZyjv0obUJas95go/oE
 sOg==
X-Received: by 2002:a17:90b:5292:b0:3a7:a463:54bb with SMTP id
 98e67ed59e1d1-3ae582c72admr1628586a91.5.1793161869255; 
 Tue, 27 Oct 2026 21:31:09 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:31:08 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 00/10] Add the RCPU to Tenstorrent Atlantis
Date: Wed, 28 Oct 2026 14:30:49 +1000
Message-ID: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102d.google.com
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_SPF_HELO_TEMPERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Changes from v1:
- Include RCPU in smp cpu count
- Fix incorrect address map naming of PRCM_DDR and DDR_CTRL
- Drop valid_cpu_types enforcement

Portia Stephens (10):
  hw/riscv/atlantis: Update fdt functions to take generic parameters
  hw/riscv/atlantis: Move Ascalon into cluster struct
  hw/riscv/atlantis: Store Ascalon memory in cluster struct
  hw/riscv/atlantis: Create CPU cluster for Atlantis cpus
  target/riscv: Add Tenstorrent Real-time CPU
  hw/riscv/atlantis: Add the RCPU to the Atlantis SoC
  hw/riscv/atlantis: Back RCPU memory region by unimplemented device
  hw/riscv/atlantis: Load the RCPU bootrom
  tests/functional/riscv64: Add rcpu to tt-atlantis tests
  docs/atlantis: Update Atlantis documentation to include the RCPU

 MAINTAINERS                                  |   1 +
 docs/system/gdb.rst                          |   2 +
 docs/system/riscv/tt_atlantis.rst            |  40 ++
 hw/riscv/Kconfig                             |   2 +
 hw/riscv/tt_atlantis.c                       | 636 +++++++++++++++----
 include/hw/riscv/tt_atlantis.h               |  83 ++-
 target/riscv/cpu-qom.h                       |   1 +
 target/riscv/cpu.c                           |  28 +
 target/riscv/tcg/csr.h                       |   3 +
 target/riscv/tcg/meson.build                 |   1 +
 target/riscv/tcg/tt_csr.c                    |  58 ++
 tests/functional/riscv64/test_tt_atlantis.py |  10 +-
 12 files changed, 737 insertions(+), 128 deletions(-)
 create mode 100644 target/riscv/tcg/tt_csr.c

-- 
2.43.0


