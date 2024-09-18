Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EE3CCD189
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 07:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpLE-0001GF-OK; Wed, 18 Sep 2024 03:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLC-0001Eo-F9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLA-0001lQ-1f
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:10 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MuDoR-1rz8rE2VxN-00v13H; Wed, 18
 Sep 2024 09:42:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/3] linux-user: Update syscall numbers
Date: Wed, 18 Sep 2024 09:42:53 +0200
Message-ID: <20240918074256.720617-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yC72yETysonw8mzsfz2f6FBqNqaxfQYgP9TYW1CWjdEb15Ukq0g
 p0h5WkTK3YD6kJu3is/XbWe+5uoBxaMdcJbJ52DAG0slOcjpzCrO4Q8swoXX7qgsIpnHEIx
 Qb0T4kBnnWdYzvfT7R2xFsP66CJa4DgVb46sVRE3jAzPbS98Kg12BxmVxz3BDwj9xKc4iy2
 g6dc6WbEE6Yiv4zvNprmw==
UI-OutboundReport: notjunk:1;M01:P0:sZRS+eDjaGg=;ZG2P58lQ+pFsgNC7ZIl5G2ghe+5
 ZMdJgHYQOtsq1DL36pxSsdCTs7BzUsc0+URXdymNOAPF1QFvg8zLEge1ZT2iQ7B5stQ+3IDPp
 WCYrDG89x/CcL+x6qQwwrF9HUUXQ6zMdtKZOLSR33VcZHNcyGrhxsbUNQ1fIWpmA92xdqalEg
 dXbx0SDJW239GgYNzTGWAeqsmPMwifs/r+/gyDRtPSoLQfCzX3CkImmIKcq9E9PPfZlewpfU6
 /7YRXLXnY9zuj+MYbYTWL5CrGqwKYnrxp4UjF3as82NCdPvDEzJafU1kXZVc5XhHBZFU7/iqy
 nfIABLqx2TRIyqBJfSl2Q6Oh0w3EUDeUK5tY4J0tHDqZgtHN7emgjJaVqEPT6vtr5XakPftrb
 TEQaTRONbN13JpDXJWiIedivMQIG2zdOX+lTDJaYZk+Oqt2Phn1R3hv9DVAMVdu77zmupPS4L
 HXW/uFeQKrvkL5kfWPwvZr6MUuXYF4+KFoQXcwD8NYAlOhsMenrjBVn/1GhPRvUK9+09ZcxkV
 Y2dn2wm4JUSh6nagquCRk5efZlkJMb+1QOMjXGUNH1NTbLDVM3SH96SRQOaxvUXaNgcWLqraV
 14aSwPjTXeirZd4TLtqj++4sIenxyG+trBBVa6vXIH4wa9VqCzixx5JbcvAyJmE2kJxVaqsuY
 kblXJgv9EJlT99cGQp8XBqMeTRw+cNhXx44yZ5RLL3GJMhRM0h/EwShMcA+QNIUMybh/rgTe4
 tb64qF4pQ7MWDI8Q94OfHU2bngrHY1ZkQ==
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
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

Run scripts/gensyscalls.sh, scripts/update-mips-syscall-args.sh
and scripts/update-syscalltbl.sh to update syscall numbers to
linux v6.10

Laurent Vivier (3):
  linux-user: update syscall_nr.h to Linux v6.10
  linux-user, mips: update syscall-args-o32.c.inc to Linux v6.10
  linux-user: update syscall.tbl to Linux v6.10

 linux-user/aarch64/syscall_nr.h        | 19 ++++++-
 linux-user/alpha/syscall.tbl           | 28 +++++++---
 linux-user/arm/syscall.tbl             | 24 +++++++--
 linux-user/hexagon/syscall_nr.h        | 20 +++++++-
 linux-user/hppa/syscall.tbl            | 41 ++++++++++-----
 linux-user/i386/syscall_32.tbl         | 28 +++++++---
 linux-user/loongarch64/syscall_nr.h    | 14 ++++-
 linux-user/m68k/syscall.tbl            | 22 ++++++--
 linux-user/microblaze/syscall.tbl      | 22 ++++++--
 linux-user/mips/syscall-args-o32.c.inc | 20 ++++++++
 linux-user/mips/syscall_o32.tbl        | 36 +++++++++----
 linux-user/mips64/syscall_n32.tbl      | 32 +++++++++---
 linux-user/mips64/syscall_n64.tbl      | 20 +++++++-
 linux-user/openrisc/syscall_nr.h       | 18 ++++++-
 linux-user/ppc/syscall.tbl             | 71 ++++++++++++++++++--------
 linux-user/riscv/syscall32_nr.h        | 23 +++++++--
 linux-user/riscv/syscall64_nr.h        | 23 +++++++--
 linux-user/s390x/syscall.tbl           | 34 ++++++++----
 linux-user/sh4/syscall.tbl             | 25 +++++++--
 linux-user/sparc/syscall.tbl           | 40 ++++++++++-----
 linux-user/x86_64/syscall_64.tbl       | 22 ++++++--
 linux-user/xtensa/syscall.tbl          | 22 ++++++--
 22 files changed, 486 insertions(+), 118 deletions(-)

-- 
2.46.0


