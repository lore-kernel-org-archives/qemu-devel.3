Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQ1UXvtK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxBk-0001Eg-LC; Wed, 28 Oct 2026 02:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBf-0001Dy-4m
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:04 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBd-0004pX-4I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:02 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-19305bcb72cso588393c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793169059; x=1793773859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o6tXL+ImRRSfDk6n5/hpFOIYAWNEev/ofebksvYzQHU=;
 b=oQ1UXvtKFkbnggySqkKwiTOotAEraityFpKIyAACbCtv97v5Cg1KQTm4uXNbWB8ySS
 XGx3bSCgqeXGEYsFnUCQNkc2u0yrPsl8HryAPH5W7cIPTpTtzGtH3sk6y1w/d/568zAG
 As5QitPfTJW/2OQ7dq6CCFuRhWNGEuC3CxpBJjY2GmDs9CORG5+OU9fD12Iv/OZ14PSR
 Budup4aGbN+pxSulgUq2GHzTksmJlqCmIIiBmGjMOrwp/jpckuLFsFmR2gs9FrQEyLy1
 LfHRfZxFmH19SV8TmuCJ7XComGJ9YUyVwvg6qNA7gXf4O7F+Sn3xE9dobh5294XHkUkQ
 HkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793169059; x=1793773859;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o6tXL+ImRRSfDk6n5/hpFOIYAWNEev/ofebksvYzQHU=;
 b=utKblrR8WcP3GZ+ttoVNXmwyo41zN2bZjMwCm+Q9HO1XcFHEtqR3EEcNMMHIvtjaMv
 ytbhbxYh7aN1iNJLr9oMGDhfGkkhtsU/Hc0U01OQwkIvTtEcBARXKn6K3F2S/FviyTuP
 J951Bn7tSKCdGFV5PDrM66+XtV9ZayyMEzFunofINDtTbVb+X3Jai47LuLEnItTS7x7T
 dLnIcvh7gMQxpavsHNpCpCevA1EwJui9r6mB70ttYo4OU4SxCgLEHX+f6IPoPrg8+7QC
 dDhsCrw84VjD0tiPk9inTGrdoq7yOSmuyej2twO39F7h3+9kH8TyeFPaYPnGEgD/7gXH
 yVUA==
X-Gm-Message-State: AFq9FYJde+xWDMiB1O6L4lLTBCc+K1j2JnB5acN5rT12VKaBJC0vmMdL
 GGvfhHPdu1MlwCcf5XKW+99GDHGCsbv9MvrWZ70AbM5ku+rx6oyxLnFFYJC6DDwM
X-Gm-Gg: AYBFou3b8qSA4V85lGsKic0KQFwPI4L4V0vw6Fju0+viWFnnEMK865YeIBG6QtEPek9
 C29WelMZGJ94qrlCZ0cNpFCnKhfYUSxwq286EPATcurNhZUWPFJH0CzKdhGD760nwuBlLs843NS
 72J7bcr8whBGH8k332Ur+A1EtjWKfoIVrUzyxibVwwPghOFZBxm2mC+388bs4kauGOn8NrlrxSH
 sWsCD136l/DaDM/UqhEF6rX/Z6K7lEh/ksZH7dUpz9yWys3IDxG2qqKMy5xJHoAYd+HMTV0Q4wJ
 B1BiajrbZaE9/QpTQkZc+RC4YecaB+Y5p44rSzWeP7yeabaiyVw38FFzZA8xqJm0zJZnlwadOKy
 EpESou3Tg0FkDMIaEuFPBx5Th276BYbh3w+vmxEVpXhRX3vIHxjPWHQu47GDLufHQa05fH+wL/m
 C1198tSyVgfrLaceowkGQjesZ9bvRlbqXqXkzwnFuNiF5OcXtSpxP73a0CbBhYt5O2/boqFUqBd
 IZnGcIgTI+9wYmSR67dfCkJKSL7YjZECp1ioYdED6icJN5lKiyadLYMBUGW88sXSZlNWqnLmICy
 WwN1HOu4W6uU9NZ9494M/jWJvFC+F/Na3RSzj4aqLjX0ycxT
X-Received: by 2002:a05:7022:7f17:b0:143:2967:c0b1 with SMTP id
 a92af1059eb24-1a6ce9bb5ffmr2140536c88.25.1793169057788; 
 Tue, 27 Oct 2026 23:30:57 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm4512584c88.14.2026.10.27.23.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 23:30:56 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 0/3] Register accel-$cpu_type for all targets
Date: Wed, 28 Oct 2026 14:30:45 +0800
Message-ID: <20261028063049.2530-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
accel-$cpu_type parent. accel-target.c is compiled once per target and calls
accel_register_cpu_type() with that target's SysEmuTarget and
CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which arch
already registered. Targets that share one CPU_RESOLVING_TYPE reuse the parent
from the earlier arch.

linux-user still contains a single target and does not expose a target list in
QOM, so it registers one accel-$cpu_type parent.

test-multi-target checks that each target's accel parent exists after QOM init.

This is an alternative to gating accelerator CPU types with is_available. The
RISC-V TCG and KVM gates are reverted here as redundant.

Changes v1 -> v2:

- Drop the cached QOM target list. v1 walked that list in
  accel_system_register_types() and registered one accel-$cpu_type per distinct
  cpu_type
- Compile accel-target.c once per target and call accel_register_cpu_type() with
  that target's SysEmuTarget and CPU_RESOLVING_TYPE. Targets that share one
  CPU_RESOLVING_TYPE reuse the parent from the earlier arch
- Register the linux-user parent from that same per-target file. v1 kept a
  type_init in accel-user.c that called target_cpu_type()
- Revert the RISC-V TCG and KVM is_available gates, now that every linked target
  registers its parent

Yonggang Luo (3):
  accel: register CPU parent for each target
  Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
    targets"
  Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
    targets"

 accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
 accel/accel-internal.h         |  2 ++
 accel/accel-target.c           | 21 +++++++++++++++++++++
 accel/meson.build              |  1 +
 target/riscv/kvm/kvm-cpu.c     |  2 --
 target/riscv/tcg/tcg-cpu.c     |  1 -
 tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
 7 files changed, 74 insertions(+), 6 deletions(-)
 create mode 100644 accel/accel-target.c

-- 
2.55.0.windows.3


