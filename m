Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BD606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWKspRSq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNCaL-0003n7-VV; Sat, 31 Oct 2026 13:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCaK-0003mj-4T
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:09:40 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCaI-0001Ua-Bj
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:09:39 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2993105c88.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793466576; x=1794071376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ua+SMK/D12kY5S4ua0C3rz2vp/YaC8hcZtPUp39RsRU=;
 b=yWKspRSqJBXoIBJRVG+EuCBmonmjj6qPTwtEOwz3stjA9BtByVxjx3MygrckpsGKB0
 Txkm0RQ47m0MwuidJd0/PO8zTZzNuuEhDAspE4M84WzJj0OQd+Yeo68RXVFfTyaskfPM
 EKyKbIZQhIVqr6+bLvZOrHC/ococ9F7QEtiw7fBQ+KrjqDE3/kywCv6vrM+BmLzmmmOn
 oV+3nQ2x3vHkqEDqAl07Lqrb/uESwFEKJCX3+vEvJ04gVb5VpkZe4lCaqpfaDD6IRmWS
 UXy3o37ma2PH4/FxCnMwyci3DPpj1iSb/AM5d0eXpC2naXZJWF3pMjBzes1VP1J/ZMqZ
 6zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793466576; x=1794071376;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ua+SMK/D12kY5S4ua0C3rz2vp/YaC8hcZtPUp39RsRU=;
 b=zoaRmk2znYKZfaoG6h9Ztrhk/EiyFlmGrIyA1/WyT3jYXR6pvDaMAUxbF5eBfNDinJ
 Ee8gA1A4czT5qALZBM6hRaPYS0tLoYLgxZtVImM5a6lNmCqwYk/YeqQunxlJO0jzoWk2
 GOUHX+Z8SBKoBMyIETjbd/K6+k5vNFEgF4IvFYQrB/0JvRWXzOJGUqNuBdHGzsqb2Umj
 locc4UEkCCzfFXhLjFgJbT04jXs1jhFgmfs0GAsb2n6gNQFgLiD+R1RKzS4Y51AFlakm
 2HYWuDLEWPODTnMGVtrsMRjYd7M+OBhjg7XMHTT7Ep6nxv20mM3Uxri4dd/hlc7Hj9IL
 NSEw==
X-Gm-Message-State: AFq9FYIowQNABeN4WDdgtFVzfexZ6qAUvxEGHyn5RPILm9EgUCVamVh+
 rsNbmmYozU73WNHEbX+acq3A4JlBI32MUTv4G4ctkXHQLESWhbK9tNfTGs49m9Wd
X-Gm-Gg: AYBFou02Kt6Mjb2PxMrunkVp8ebUE7Z4vMIajMeXSqd+O2rM8SFK+QvlkkGHElwj/Qk
 5KCyibrlrxsM879UQhZ3Q3ldq5H8jg39jv8bEZelL0L+ckQRzkXDNDcWJ3NhveKpuPu61dlZ7i0
 YYtrqDvUktEaUTn/MlRhmPr2cUwQr9xMrwu5I8KdGWlvnGU81qq032KJDzXfqhj9dGwkcKLx1IA
 XQa8tAt/lkAI6ekM3dq2H9u+4GPJTbFntRFkI1WIktA59GG68k3FztBXHKr5LLuxuqdRY/A7VC+
 xccWsg+KSR7B6z/NAb2p4R8NRI1tx4aQpCrDX/yWxnQ0tfOJcMNLTbDUeAkF+cjPvOAZVD9jwlZ
 Pl1ahz+g/RGHBfEL9P9A7igvJuB1fWy1ofGeX5flACVdnITz4TFsO2TjTCWZLVXhjBRzsjzCXuR
 2CiuFb24iv4fVtD2vugUHGgvfQt2Bcy5dTm06KTZKXhmA1+JxY+uA8IVrUIcVJVKPc6KbeQbpJU
 GS5kuFPcsW7S5wd8hOvzS3xz+LetaIO5hvkaX1L4D7nUh+wGNQjJGvsmcL+5q0/8MgYpRmjx1YZ
 bIUjIzgvsLGrisPhrtuNV11pT2+zaffLnTGshLN773fZgMPr
X-Received: by 2002:a05:7022:1301:b0:192:fd91:c569 with SMTP id
 a92af1059eb24-1ac5a0b8a8fmr7102800c88.11.1793466575782; 
 Sat, 31 Oct 2026 10:09:35 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854da78sm23749065c88.6.2026.10.31.10.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 10:09:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH v3 0/3] Register accel-$cpu_type for all targets
Date: Sun,  1 Nov 2026 01:09:22 +0800
Message-ID: <20261031170925.789-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122b.google.com
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

A multi-target system binary links more than one target, so each one needs an
accel-$cpu_type parent. accel-cpu-target.c registers that parent from a static
type_init. The name is "accel-" plus CPU_RESOLVING_TYPE. System targets for arm,
riscv, sh4, and xtensa share one CPU_RESOLVING_TYPE, so those bases build the
file once per TARGET_BASE_ARCH and link that object into every system target of
the base. User-mode and every other system target compile it once per target.
The constructor is static, so more than one copy can be linked.

test-multi-target checks that each target's accel parent exists after QOM init.

This is an alternative to gating accelerator CPU types with is_available. The
RISC-V TCG and KVM gates are reverted here as redundant.

v2: https://lore.kernel.org/qemu-devel/20261028063049.2530-1-luoyonggang@gmail.com/

Changes v2 -> v3:

- Drop accel_register_cpu_type() and the bool array keyed by SysEmuTarget.
  Register the parent from a static type_init in accel-cpu-target.c
- Build that file once per TARGET_BASE_ARCH for system targets that share
  CPU_RESOLVING_TYPE (arm, riscv, sh4, and xtensa), and link that one object
  into every system target of the base. v2 compiled accel-target.c once per
  target and skipped a second register
- Compile it once per target for user-mode and for every other system target.
  The static constructor lets a multi-target binary link those copies when the
  type names differ
- Check the accel parent from test_qom_types_are_unique(). v2 used a separate
  accel-cpu-parent-per-target test

Yonggang Luo (3):
  accel: register CPU parent once per target base arch
  Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
    targets"
  Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
    targets"

 accel/accel-common.c           | 15 ---------------
 accel/accel-cpu-target.c       | 27 +++++++++++++++++++++++++++
 meson.build                    | 32 ++++++++++++++++++++++++++++++++
 target/riscv/kvm/kvm-cpu.c     |  2 --
 target/riscv/tcg/tcg-cpu.c     |  1 -
 tests/unit/test-multi-target.c | 10 ++++++++++
 6 files changed, 69 insertions(+), 18 deletions(-)
 create mode 100644 accel/accel-cpu-target.c

-- 
2.55.0.windows.3


