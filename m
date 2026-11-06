Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B8606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VALCkQM2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP9sM-0006GT-5a; Thu, 05 Nov 2026 21:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP9s0-00065u-Gz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:40:08 -0500
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP9rq-0005xS-IP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:39:54 -0500
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso345143c88.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 18:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793932787; x=1794537587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rDElrtS3FxbW665hmHl5LEpM/3wnbHHjEJFYYBAS/XQ=;
 b=VALCkQM2rJwWkMfUXE/AQleGnN9JY382QLCjRldV1BT8kS18UVKFYdPxVoXNM+QhLd
 X94WiNUcUwEWxyqlEmf9UeAPngGINDyPjrMewvMVoEMvNKVqvzbi7Z+3/84xPLSzYPM9
 JkGYLGwJ50hOfZUiLyH9/tmod0qpqKUw+/Cb00A3oq23gHgYnsDNUEbMeVwzYGvbn4Lj
 Mg5rW6RNf56BZtK8U9LdUej4wg0UXEKSolImN2Wi8JfC+kpAp1KViyogGHp7TeB/sb4Y
 lSg+VuT4905EqNilpD9OV7q23HSBynD2UjO62SxPB7jJq3EvmSE3ZNurqPHTjP7PCQD4
 cr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793932787; x=1794537587;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rDElrtS3FxbW665hmHl5LEpM/3wnbHHjEJFYYBAS/XQ=;
 b=SUcWX7u6hk4vb9FnsFX5VesWF+oGA0YvTAMh7QcbKGzzv4XvBJhTFKhduQNi4XkPNm
 KE5eZPDIrpEkqRx0a0nqpHZ7+2IPiewgKRaKw8UMq2zDmBx0KCQb467NxmQfWAMHI8FC
 PzdlREvcdBuDTl2Sl4qimQP+Vq4/qksuKhQBZDO3oSY7auckTJMz32+XdLHU0taS0slB
 UT7nWiHEqDoqHzvhDTbVGIzhory6Ofjw59YdqOOn9SlpU3hMsBi3lQOiTOfL9tDWGn64
 CDDUbRda0cr8dQWQhd7w0KEpSopI4Ob1dQKKTxNWZV1wwo8BEox/xgvQlC0PcJ7Tx6u3
 jSaw==
X-Gm-Message-State: APuU4Z9u5300Blmuz7jFpCpDvRa1egIvqTAEozqL+yGBfFLi2Ezuxx/E
 zDkZhHCxWXh3EobZyvVb+SHKHqT5EsF+uCUWxGZHcQ21D03jF/7VvinogHzwA1E9
X-Gm-Gg: AYBFou1hKYjsyEjVMgxZTuXrsW7HwiB50KximXa/zx5M9cKJcds4cE4aCSV2b7gdl37
 FVIHA0CXcHBCw1WIMpjMxGBCDc62a+E+WceUC+oJi32yAxEKcC6UGtNhjYA+Tarc5Ji4PqPtX8t
 F9cbD1KnBIyLFpmwlAtYH7mi8yGyhdYigKoieDohi4sFvzrPsT9Zs/6B0WcFGRUgfEFPi9jjqET
 iW7sCHiJiBYLLARFJbS/3MKBxA8npVuHAgugrQQQZxdssV9dnhMMDqS8nU+8t6CXC+m0XGIV50o
 arx+xeu8dpVCuxZO1ozvy7+Lzz/Ob/VIEJYMXCoJxL4V8VS1Ugz4IgXYuMRdUaC8/fjCy3VzPGU
 zl6j9aek5CXXjKiS+Z2NVDPBGtfWR1lTqhyUzOTEYWDESX56K9IB8hLGeYA0AXDj1LAKaQUVKsy
 3VtRZWcedm7ZCwnOtAIYA4skZSD9fuFDpOpx4WoWyAounKvYI8+GRdfemaqqTrEjkICerp7jTki
 gQwx8RAgulSXiXq/gA+jssft/BTVTrXQE3Ttag28U+O5MlnhFzDftZvW8XM5fD9tdKLR0uByjEa
 F41SjbM2cMghjpj8hcOBZmgEFEu62WlKJ/Oc3WeSgnmYYgnY
X-Received: by 2002:a05:7022:ea46:20b0:1b1:f02b:232c with SMTP id
 a92af1059eb24-1b25d36fb13mr1282756c88.29.1793932787307; 
 Thu, 05 Nov 2026 18:39:47 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b25e4efa6fsm1108318c88.20.2026.11.05.18.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 18:39:46 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 0/3] Register accel-$cpu_type for all targets
Date: Fri,  6 Nov 2026 10:39:32 +0800
Message-ID: <20261106023936.772-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A multi-target system binary links more than one target.
accel_cpu_register_type() creates the abstract parent accel-$cpu_type for each
target that has an AccelCPU subclass. ARM, i386, RISC-V, and PowerPC call it.
Other targets have no such subclass, and machine init skips a missing class.

test-multi-target already instantiates every QOM type, so this series adds no
parent check.

This is an alternative to gating accelerator CPU types with is_available. The
RISC-V TCG and KVM gates are reverted here as redundant.

v4: https://lore.kernel.org/qemu-devel/20261105183310.1614-1-luoyonggang@gmail.com/

Changes v4 -> v5:

- Drop test_accel_cpu_parent(). test_qom_types_are_unique() already instantiates
  every QOM type

Yonggang Luo (3):
  accel: register CPU parent only for AccelCPU subclasses
  Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
    targets"
  Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
    targets"

 accel/accel-common.c       | 6 ++----
 include/accel/accel-cpu.h  | 2 ++
 target/arm/cpu.c           | 2 ++
 target/i386/cpu.c          | 2 ++
 target/ppc/cpu_init.c      | 2 ++
 target/riscv/cpu.c         | 8 ++++++++
 target/riscv/kvm/kvm-cpu.c | 2 --
 target/riscv/tcg/tcg-cpu.c | 1 -
 8 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.55.0.windows.3


