Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983D60A2608
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QflmRBgA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5H3-0007Bs-9p; Thu, 19 Nov 2026 11:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5G6-0006vY-Ac
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:21 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5G4-000256-Fn
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:14 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2efe8f50697so10560775ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795106709; x=1795711509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P1jQ7cVFDYQ1j0YtNdbpZRsX9aY9kIeS4pewg/qGi9A=;
 b=QflmRBgA/1lt9vhrW5KgCH20pb4huYELVlFJoLAxGNzRM8BwzGkMddnQ69JUP94qwd
 2LhL9Zh+AaNXpsTgO94QGiazYLZzEcwHoSoMWEy7mPAytIDGL2RlO/yw+8QnkrYNPg3E
 pXZPhW+r/OUnOoQIUtWD2hyRuo0y44sYrovzcwzrCj1H/w52OPsffLQisCvq3iHYis4p
 5mr+G07IGT2K8stM+/Gtv3T/pSvHMf0ocDxgGdSAGq37A3M5aafTpa8MEqSl76wmpaWb
 Yfof2AOp0pd+jBDZrJAZK08xr9gth66M0LVINIxbZdTAzgR0YgTc7a6UmdWtaFkpQw3S
 w9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106709; x=1795711509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P1jQ7cVFDYQ1j0YtNdbpZRsX9aY9kIeS4pewg/qGi9A=;
 b=anLdXURJY9toaXzBvpZsgNoZq8SJ4OJcePYESUZfi/TgOUdMG4QQuLuGVL+eYfSEja
 qDH3EcymKZlqlVtxLggOT3DTmnyRsA9hZnprzCJhurTCf4RBAgQUF12lICDRoyBf+2U+
 MQ+fv9qZWnQkmKBfV8ENF7DdKd0Bz0WKmo3NCXOel8TfPemOsSAM1duGfz4lhiSCmVe6
 l5O3UqNXYegOzMEcdvzfGMo3BodJzy9uLfntOQd7mnQGEnjuzBE4zuWL2Cl+63wcZ5+q
 YZbt5VudAhsP5zr+b/4SjHalwTfE3qEm37xDLe3dM7YXlspJPynK58ZFOWsZyXcUbcPG
 Yp/Q==
X-Gm-Message-State: APuU4Z9qdMNXpwZXP+lZq+63O059+G549amG7W1uqcr8/mBiUW+3jfDK
 KWt7J8Jom1eY5Rny0RZKImQJ9FKX1mtCrtQao/S4Cn+Ku+3MAEdUkpTAMD2ThA==
X-Gm-Gg: AZFdTZfcn/SeSTYUZXDBP46YvVUrA/kda0fog3Qda4TMUVGZFBHuo7Qdf3grkSXtQW4
 24072eH8GDiBjs9/NzODAt331AcQBAzEN1JnzFWtP2fiMitRb1BFgrEaDIAUMngGumN79CXXHmr
 gZpgsBjdSf5CySlR+oikuYN26hssiv3Ui/hLKC4L6TV/isu+zPtTQezUdqhyH2H30WAUWcKUxDs
 La2feRrah1SbtD4XGpHvy1fCqoeH6WH4iM1G+M0W0EN02AFsf8mAtqqDOJcRBCTjXyY2pkj1GYf
 q1o6oUCn3BL2oIskh4JaissU355vhQm6RUyTQzi5d5JE6jHrXTDYJGEfeecPUjobjUSrRylKnGS
 oyTKvMd6fx3G5KO5OrhcfoQEqlhuPn3LSFTz8wBir/dBozxuHAx7in8U7D9TbUPXnWZ40R8FwnG
 Ps5VlYQQnrgCmC5oy5FSLZx3l3T17k0MvcHg7hdTkC9O/r5fG2pW66hSwkn7GRFS8ZrFyungP+f
 h4LlZ+3/3WQR1kCInVk+z6eLkD9NLUG8wWjUiWYwx4EmBzGsdNMT37Uc32QlvVurHWnuHsDdhzp
 wRyMdMN0tG9CB9KTEi07ZpTsQzUxhMItR7+iQTkevOchZ2MPPyuO
X-Received: by 2002:a17:903:b4f:b0:2ed:4b23:c417 with SMTP id
 d9443c01a7336-2f03f1d85a3mr3862595ad.11.1795106708578; 
 Thu, 19 Nov 2026 08:45:08 -0800 (PST)
Received: from fedora ([61.74.238.173]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f10e67csm2381365ad.53.2026.11.19.08.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:45:08 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 0/3] target/riscv: Cache TB flags in CPURISCVState
Date: Fri, 20 Nov 2026 01:44:35 +0900
Message-ID: <20261119164438.193579-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=suunj1331@gmail.com; helo=mail-pl1-x630.google.com
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

riscv_get_tb_cpu_state() recomputes TB flags on every lookup. Most of
the inputs change infrequently, at CSR writes, traps, privilege
changes or vsetvl. Cache the derived TB flags in CPURISCVState and
rebuild them when their inputs may change.  The design follows the
Arm hflags cache, commit e979972a6a ("target/arm: Rely on hflags
correct in cpu_get_tb_cpu_state") and its series [1].

Patch 1 extracts the flag computation. Patch 2 adds the cache and
its rebuild points. Patch 3 switches TB lookup to the cache and adds
a CONFIG_DEBUG_TCG check that reports the cached and recomputed
values and aborts on a mismatch.

In an RV64 virt Linux boot and power-off profile, the self overhead of
riscv_get_tb_cpu_state() in the vCPU thread dropped from 16.54% to
6.78%. Median boot time dropped from 5.69 s to 4.81 s (-15.5%)
compared with the base revision. See patch 3 for measurement details.

Runtime tests with --enable-debug-tcg

- RV64 virt Linux boot and power-off, covering M/S/U modes.
- KVM selftests inside the RV64 virt guest (ebreak_test and
  kvm_page_table_test with Sv39, Sv48 and Sv57 guests). These exercise
  HS/VS transitions, two-stage translation and writes to hstatus,
  vsstatus and hgatp.
- A vle8ff.v regression test that checks tail elements after a
  fault-only-first load reduces vl below VLMAX without a trap.
- Guest reboot and migration save/restore, exercising the reset and
  post-load hooks.
- The vle8ff.v test under riscv64-linux-user.

Build-tested riscv32-softmmu. Boot timings were measured with release
builds.

VU mode, M-mode accesses with MPRV+MPV, pointer masking and CFI were
reviewed but not exercised.

[1] https://lore.kernel.org/qemu-devel/20191023150057.25731-1-richard.henderson@linaro.org/

SeungJu Cheon (3):
  target/riscv: Split out riscv_compute_tb_flags
  target/riscv: Rebuild cached TB flags at state changes
  target/riscv: Rely on cached TB flags in riscv_get_tb_cpu_state

 target/riscv/cpu.c               |   1 +
 target/riscv/cpu.h               |  19 +++++
 target/riscv/machine.c           |   1 +
 target/riscv/tcg/cpu_helper.c    |   1 +
 target/riscv/tcg/csr.c           |   8 +-
 target/riscv/tcg/debug.c         |   2 +
 target/riscv/tcg/tcg-cpu.c       | 123 +++++++++++++++++++++++--------
 target/riscv/tcg/vector_helper.c |   2 +
 8 files changed, 124 insertions(+), 33 deletions(-)


base-commit: 08c9bbb825148dec9669f5184ecf18823bb6d631
-- 
2.52.0


