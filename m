Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E770ACF9C41
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 15:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srfHg-00027f-Rg; Fri, 20 Sep 2024 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1srfHc-00025E-NJ; Fri, 20 Sep 2024 11:10:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1srfHZ-0003mw-9C; Fri, 20 Sep 2024 11:10:56 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MTiHb-1sNoBC3meL-00Tjyt; Fri, 20
 Sep 2024 17:10:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 0/6] linux-user: move all remaining archs to syscalltbl
Date: Fri, 20 Sep 2024 17:10:28 +0200
Message-ID: <20240920151034.859533-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yDFhCseNKeLebBiXSt0s78b3bOKlJYuFaKZgQwL6edeEjZUq1C8
 ezkkMZAoMkwXpeqEZO5HoQalhxRLLlR5KoTQ2MFfyj/p2BX5OpSjIvRt01l0bfVHfuEPF6L
 f+HYdMthmE9IFL708s2PSv7mQleCnFuk5gXYA84B6rluF5Yq0K2vWgLlboAXLJa+9Mn2X4m
 5R0JBExZcSd5LiHFJaFSQ==
UI-OutboundReport: notjunk:1;M01:P0:y/aFgsnxJZ8=;tA+ijoqTESaAn+UodafdfC8xScy
 cpKvRqW+amH80K0Dyg9BshNWfdS0W1T+Pt2pgUImUJXnmYfSH9uFh5j94G83ZxeisfunAbcJo
 Ja3SuJxVmfM6Lg0QdG7muhdOEk+NKBJy3IPiAtcUQFIJjzn+i3EHiwwQLK1TE9ON1tJWDYrX2
 eqNMb8KFkUOItcNEp/iStTU2IORA7cqUYky1IxlXPDbR4LGClA40LxXIt+SPqaHkf40M6j4On
 QC+00n6foS+uYSoFwvXUOuCkeiR1GBUNEu5OUJ2+VLn/Tq5/UGAHGnuFBLoiOSkaJ0pdlyZR+
 vXjCvBJ2FtPpncxAOQbP3+RbcjEtR6tdh0Q96eb8urzTElJADWP7WycRUd09fnCJyxpsScoE3
 2a6AXe6a+T9HJgf08vunSqTflWfVQRI28V0KlNi8BiZdIcNUQiuHWWxjtFfdMzEPs4PmSsmvc
 s2hcMmeH0Yhdd5wulSJoh+ZjyLlzee5d4Mfbk5g+LDMrJXngnGiX9QTBTeDX7IGCJ9FKJ6A9Y
 0AhLqiEN5gJUQPOTQ2butn6ibyTXj2H05kRBk9vIQApzRVMPRcj4AB1q5PHr7glCKqZZyZ8l0
 uy/FQCeTKKOROTYcMkOcVRNbeog+7vnvxZAPQHH9oJpzs6PGReJotRi0qTcaP0pgORTpBbbAq
 RbFKlx+C3+QHRrmDiIXnwhFnfxVvu038wMsmPcLqQVsaW5+c8dqAN2B/uTdFsody9EiTSuAtJ
 4UPOARnJCMPDaFRuN1F0KxZHTfNpP9p+Q==
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

linux v6.11 has moved all the remaining archs to syscalltbl,
update QEMU accordingly.

Remove scripts/gensyscalls.sh that is now useless.

Update headers to v6.11

Based-on: <20240918074256.720617-1-laurent@vivier.eu>

Laurent Vivier (6):
  linux-user,aarch64: move to syscalltbl file
  linux-user,openrisc: move to syscalltbl file
  linux-user,riscv: move to syscalltbl file
  linux-user,hexagon: move to syscalltbl file
  linux-user,loongarch: move to syscalltbl file
  linux-user: update syscall.tbl to Linux v6.11

 configs/targets/aarch64-linux-user.mak     |   2 +
 configs/targets/aarch64_be-linux-user.mak  |   2 +
 configs/targets/hexagon-linux-user.mak     |   2 +
 configs/targets/loongarch64-linux-user.mak |   2 +
 configs/targets/or1k-linux-user.mak        |   2 +
 configs/targets/riscv32-linux-user.mak     |   3 +
 configs/targets/riscv64-linux-user.mak     |   3 +
 linux-user/aarch64/meson.build             |   6 +
 linux-user/aarch64/syscall_64.tbl          | 405 +++++++++++++++++++++
 linux-user/aarch64/syscall_nr.h            | 331 +----------------
 linux-user/aarch64/syscallhdr.sh           |  28 ++
 linux-user/arm/syscall.tbl                 |   1 +
 linux-user/hexagon/meson.build             |   6 +
 linux-user/hexagon/syscall.tbl             | 405 +++++++++++++++++++++
 linux-user/hexagon/syscall_nr.h            | 348 ------------------
 linux-user/hexagon/syscallhdr.sh           |  28 ++
 linux-user/i386/syscall_32.tbl             |   7 +-
 linux-user/loongarch64/meson.build         |   7 +
 linux-user/loongarch64/syscall.tbl         | 405 +++++++++++++++++++++
 linux-user/loongarch64/syscall_nr.h        | 324 -----------------
 linux-user/loongarch64/syscallhdr.sh       |  28 ++
 linux-user/meson.build                     |   2 +
 linux-user/openrisc/meson.build            |   5 +
 linux-user/openrisc/syscall.tbl            | 405 +++++++++++++++++++++
 linux-user/openrisc/syscall_nr.h           | 350 ------------------
 linux-user/openrisc/syscallhdr.sh          |  28 ++
 linux-user/riscv/cpu_loop.c                |   2 +-
 linux-user/riscv/meson.build               |   6 +
 linux-user/riscv/syscall.tbl               | 405 +++++++++++++++++++++
 linux-user/riscv/syscall32_nr.h            | 325 -----------------
 linux-user/riscv/syscall64_nr.h            | 331 -----------------
 linux-user/riscv/syscall_nr.h              |  15 -
 linux-user/riscv/syscallhdr.sh             |  28 ++
 linux-user/syscall_defs.h                  |   7 +-
 linux-user/x86_64/syscall_64.tbl           |   8 +-
 scripts/gensyscalls.sh                     | 103 ------
 scripts/update-syscalltbl.sh               |   5 +
 37 files changed, 2231 insertions(+), 2139 deletions(-)
 create mode 100644 linux-user/aarch64/syscall_64.tbl
 create mode 100644 linux-user/aarch64/syscallhdr.sh
 create mode 100644 linux-user/hexagon/meson.build
 create mode 100644 linux-user/hexagon/syscall.tbl
 delete mode 100644 linux-user/hexagon/syscall_nr.h
 create mode 100644 linux-user/hexagon/syscallhdr.sh
 create mode 100644 linux-user/loongarch64/syscall.tbl
 delete mode 100644 linux-user/loongarch64/syscall_nr.h
 create mode 100644 linux-user/loongarch64/syscallhdr.sh
 create mode 100644 linux-user/openrisc/meson.build
 create mode 100644 linux-user/openrisc/syscall.tbl
 delete mode 100644 linux-user/openrisc/syscall_nr.h
 create mode 100644 linux-user/openrisc/syscallhdr.sh
 create mode 100644 linux-user/riscv/syscall.tbl
 delete mode 100644 linux-user/riscv/syscall32_nr.h
 delete mode 100644 linux-user/riscv/syscall64_nr.h
 delete mode 100644 linux-user/riscv/syscall_nr.h
 create mode 100644 linux-user/riscv/syscallhdr.sh
 delete mode 100755 scripts/gensyscalls.sh

-- 
2.46.0


