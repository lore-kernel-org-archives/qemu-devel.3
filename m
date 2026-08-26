Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7928DC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIaE-0006e6-UH; Wed, 26 Aug 2026 14:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIaD-0006cx-V2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:42:45 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIaB-00028F-P4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:42:45 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so1340581a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787769762; x=1788374562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EDfuXxnaswKOisJ/dMhJ0KYIusAj5P3ggFvMoxWCRM4=;
 b=TGc0gDJmHVT5vBB1X/jcBfjoIa+vor8oeY8OiBvgr599uIXpZOwSSy1Z+8MpfKfW+2
 m62u1jTxdQGkNl4BcPXmxgyyiKu1W4s5ByBUMCOp+iykDipy4ggrtIrLJrj9T7VbBR2g
 oJUV2qc8oiT8NMt61R3YkumhldTgUaZ0ECrJLAgsVG/epyoQC8Tl1QtryLhAk7hlCQU1
 mP3QU83cbso3XYGstB/SSQCDUCiaavbmyQKhhwhdCrS+1PQFYpsYYcyhcXQUJE8US2WJ
 Uk6WdX6LQtfF9M7cXRoKpZhw/FDY0tcZ5fzg67gY4uHbBYLaujIu3hhhCTgb7yh06swV
 Ra5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769762; x=1788374562;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EDfuXxnaswKOisJ/dMhJ0KYIusAj5P3ggFvMoxWCRM4=;
 b=rZVGqBj63KXiIv03Bxcg3us+iajLTNcM6zXD/Hi1hynzsVp/6TjaFiAri1QvTN6xU9
 gMppap2i+Q2xEr03GEg6+lgZwtWL0Ok+xc0wTSY7oKhMI3C4pXLytObzBgg47gv1XV5X
 2/714guk07FZFjLb+zoTQEKKETEI+DirD5PTbNddypesMR0d4Qy5KELMe25dy9VXER2/
 yaqATIBPtKr8hdCxA2Xqg6kBtlZY/bHnSCs5fHscYivWfBz6uL1igbWe6ryUGh+psXED
 YLNylZCY8+M8XrX9cZkU9F1n8gB3ERDX5AGPwYuN/LnjqPgNDZ6NCt22ZVrV23aT7ASx
 fh+w==
X-Gm-Message-State: AFuF++lKEz2Z0rWdBg/CtLuPtH2C8BIOG7KY7TfOK7TAYVWCuo7gL42k
 FC8Rg29Y5dPACQrbj95zfO5sjgwv1b86gT7KmQG+UF+UXeyplAnQArGy7A71+sdu
X-Gm-Gg: AR+sD13diJwCx86iHb9RYm/GDWyfayNeSQxfjA3aTcGdJ3qb5Q4buFjIBBtrzcrDGH9
 TnmaW5WxDZ5zRiRZG8t/UN86axsEzQ8YV0goquFY0/uHR4mIaLBDw+vBa3Wp+8y404Xdbiobmjl
 l6ajCxiHAzFDe4amHp4+KOj6UkBHUMDs0xC9CZciFqbH0QfrBb0veGZrFQ/TJ0liN23emal9y8P
 IGA2WAxCv7lADnFeMLNgKSNrT6lCAObagAANM7Hlq4Q8eRlvzO4aC9YqHxQClOUAWcbGeVe4AOO
 TFdakniwIlMTNJhiU00w4qq9fkioNaROiQTFzlzP7CmriNqx7noNUOy0Cf9kPTgFGYfSlEjs0t1
 qidXC6cDF5DViJcRBtqHRZJvt9wFh4h65kMOJElGb86QB8nsJ9lypHkTi3Sg03wTJnwyBPkNJRz
 Whh3uoIEKGoswov6VWvvXIFLMp544LkU1h3rDurAzJgqrPuqAkqHaHJy6/LEAWsB0fpZ4IRfmlA
 NI+uprCwgN3z/0yz7GOlw==
X-Received: by 2002:a17:90b:4410:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-3966d45505cmr16802506a91.14.1787769762099; 
 Wed, 26 Aug 2026 11:42:42 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm17681846eec.6.2026.08.26.11.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:42:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bibo Mao <maobibo@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 00/13] single-binary: link ARM and RISC-V into qemu-system
Date: Thu, 27 Aug 2026 02:42:14 +0800
Message-ID: <20260826184229.1145-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series produces one qemu-system binary that can run ARM (32 and 64)
and RISC-V (32 and 64). It follows Pierrick Bouvier's merged series
"single-binary: implement dynamic filtering for machine types":

  https://patchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com/

That work added TYPE_TARGET_SPECIFIC so machines can be filtered per
target in one process. This series uniquifies remaining per-target C
symbols and QOM names, selects TargetInfo at runtime, and links ARM
plus RISC-V into qemu-system.

A combined link cannot keep C symbols or QOM type names that were unique
only because each qemu-system-$arch was a separate binary. The first
patches remove those collisions:

- TYPE_ACCEL_CPU is a single abstract accel-cpu parent, registered once
  next to TYPE_ACCEL. Leaf names still encode the CPU type so
  accel_init_cpu_interfaces() can look up "<accel>-accel-"
  CPU_RESOLVING_TYPE.
- ARM and RISC-V virt QOM names become arm-virt and riscv-virt. The
  boards keep -machine virt via machine_class_set_name() after the
  selected target is applied. Latest ARM virt still sets mc->alias.
- virt ACPI helpers and RISC-V TCG crc32/crc32c/wfi helpers get an arch
  prefix so the combined link does not need meson -D name mangling.
  LoongArch virt_acpi_setup is renamed in the same pass.

Target selection then has to work with more than one TargetInfo in the
process:

- Parse -target before TargetInfo is fixed. The token is target_name
  (arm, aarch64, riscv32, riscv64). When -target is omitted, infer it
  from the program basename (qemu-system-aarch64, strip .exe).
  qemu-system with no arch suffix always requires -target; there is
  no unique-TargetInfo fallback. Use -target ? to list names.
- Combined binaries cannot keep one global C symbol per arch for
  query-cpu-definitions, dump notes, or Angel semihosting. Those
  handlers move onto a process-wide TargetCpuOps table.

The last patch still builds qemu-system-$TARGET. qemu-system is extra,
from the union of ARM and RISC-V Kconfig plus aarch64/riscv64 arch
objects. Do not replace the per-target binaries with symlinks to
qemu-system. Do not add qemu-systemw on Windows: a GUI twin of the
combined binary would keep QEMU exporting data from the .exe into
DLLs, and those data exports cannot be delay-loaded (qdev_prop_array
and other qdev_prop_*). That would block enabling modules globally
on Windows.

Examples:

  qemu-system -target aarch64 -M virt ...
  qemu-system-riscv64 -M virt ...

A combined binary named qemu-system with no arch suffix always
requires -target. A missing or unknown name fails and points at
-target ?.

Changes v1 -> v2:
- Drop little- and big-endian TargetInfo variants from this series.
  v1 registered target-info-<name>-le and -be, selected is_default from
  TARGET_BIG_ENDIAN, and accepted -target tokens such as aarch64-le.
  v2 keeps one TargetInfo per target_name. Endian variants are later
  work, not required to link ARM and RISC-V into qemu-system.
- -target help/? lists target_name only. Unknown names point at
  -target ? rather than printing the list and exit(1).
- qemu-system with no arch suffix always requires -target. v1 could
  still pick a unique TargetInfo when only one was registered.
- Keep qemu-system-$TARGET; qemu-system is an extra binary. v1
  described installing per-arch names as symlinks to qemu-system.
- Do not build qemu-systemw for the combined binary. A Windows GUI
  twin would keep using exe symbols from DLLs, and data exports
  cannot be delay-loaded (qdev_prop_array / qdev_prop_*), which
  would block enabling modules globally on Windows.

Based-on: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>

Yonggang Luo (13):
  accel: use a shared TYPE_ACCEL_CPU parent
  hw/riscv/virt: register TYPE_TARGET_SPECIFIC
  hw/arm/virt: register TYPE_TARGET_SPECIFIC on the abstract parent
  machine: allow -M name to differ from QOM type
  hw/riscv/virt: use unique QOM name
  hw/arm/virt: use unique QOM name
  hw/arm/virt: prefix ACPI helpers with arm_virt_
  hw/riscv/virt: prefix ACPI helpers with riscv_virt_
  hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
  target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
  system/vl: add new option -target
  target-info: dispatch CPU QMP, dump, and arm/riscv semihosting
  meson: build single binary

 MAINTAINERS                                   |  1 -
 accel/accel-common.c                          | 21 ++---
 hw/arm/virt-acpi-build.c                      |  4 +-
 hw/arm/virt.c                                 | 17 ++--
 hw/core/cpu-system.c                          | 23 ++++++
 hw/core/machine-qmp-cmds.c                    | 26 +++++++
 hw/core/machine.c                             |  6 ++
 hw/loongarch/virt-acpi-build.c                |  6 +-
 hw/loongarch/virt.c                           |  2 +-
 hw/riscv/virt-acpi-build.c                    |  2 +-
 hw/riscv/virt.c                               | 12 ++-
 include/accel/accel-cpu-target.h              |  3 +-
 include/accel/accel-cpu.h                     |  2 +
 include/hw/arm/virt.h                         |  6 +-
 include/hw/core/boards.h                      | 12 ++-
 include/hw/loongarch/virt.h                   |  2 +-
 include/hw/riscv/virt.h                       |  6 +-
 include/qemu/target-info-qom.h                | 42 +++++++++-
 include/semihosting/common-semi.h             | 56 ++++++++++++--
 meson.build                                   | 69 ++++++++++++++++-
 meson_options.txt                             |  2 +
 qemu-options.hx                               |  8 ++
 scripts/meson-buildoptions.sh                 |  3 +
 stubs/dump.c                                  | 27 -------
 stubs/meson.build                             |  2 -
 stubs/qmp-cpu.c                               | 21 -----
 system/vl.c                                   | 44 ++++++++---
 target-info-qom.c                             | 77 +++++++++++++++++--
 target-info.c                                 | 32 ++++++++
 target/arm/arch_dump.c                        |  8 +-
 target/arm/arm-qmp-cmds.c                     | 15 +++-
 target/arm/common-semi-target.c               | 23 ++++--
 target/arm/meson.build                        |  7 +-
 target/i386/arch_dump.c                       |  8 +-
 target/i386/cpu-system.c                      | 12 ++-
 target/i386/cpu.c                             |  6 +-
 target/loongarch/arch_dump.c                  |  8 +-
 target/loongarch/loongarch-qmp-cmds.c         | 15 +++-
 target/mips/system/mips-qmp-cmds.c            | 15 ++--
 target/ppc/arch_dump.c                        |  8 +-
 target/ppc/ppc-qmp-cmds.c                     | 15 ++--
 target/riscv/arch_dump.c                      |  8 +-
 target/riscv/common-semi-target.c             | 25 ++++--
 target/riscv/helper.h                         |  6 +-
 target/riscv/meson.build                      |  4 +-
 target/riscv/riscv-qmp-cmds.c                 | 15 +++-
 target/riscv/tcg/bitmanip_helper.c            |  4 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +-
 target/riscv/tcg/op_helper.c                  |  2 +-
 target/s390x/arch_dump.c                      |  8 +-
 target/s390x/cpu_models_system.c              | 15 +++-
 tests/qtest/fuzz/fuzz.c                       |  2 +-
 53 files changed, 562 insertions(+), 207 deletions(-)
 delete mode 100644 stubs/dump.c
 delete mode 100644 stubs/qmp-cpu.c

-- 
2.52.0.windows.1


