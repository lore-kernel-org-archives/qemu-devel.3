Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A84FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXh-0000Lk-MG; Tue, 07 Apr 2026 14:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wABUK-00042B-Qv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w9yD9-0007Gl-Uf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:38:49 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1570373a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775536726; x=1776141526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ND40BPJTg3yKXGUdF2X6Rw0O0iuW1QxrCnuohU7zMPY=;
 b=C1BAaok4MVbSc9Pa0nzcwYagUlUTfdzSL0Ip5MObwuywbf2EcDu8c4wQvg1qiAN1xh
 GmlNRv6jOg3eJVCZ5q/hMWWASatwNOCkVvtjjPnCA/EZr/C25LDpqnnhVDaoETqY27CH
 yO182h6K3bqX5lZUVoOW0J+CLn0m40qoLBArdiOupdZ7IEn2vCNVQiR+knkZdWVu/o3s
 ycBuEjaf3FtIU5bHsLYlSKTqXnYFABPUe5rUxsAPXfvaD9n0k+2zU3arKORDx81pOdwa
 A8TlQ/YLW0VPfNWaKNAlYem1sHdHC+XrZq6JKVs6jb3iFexcs9ti3Yw3nmZZElWaDy3l
 Wbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775536726; x=1776141526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ND40BPJTg3yKXGUdF2X6Rw0O0iuW1QxrCnuohU7zMPY=;
 b=Pm2BaEQfjNS9D35IkqUR6RhaSegHsnvrOEA1nl2QR0dWiYdDEiwhN2CUEPs28CaBo7
 oh78AUPCYrdr5Cz1gZ2a4uoEHpJCAEeTrWm62KI5gfsg/UPcPo7Y+etkZYRp49hChtIG
 gnM9vu+S2VXrhxMaFk7TW6FRgvsyqvvOT562QY1Xfzwxqs/Pcs5jt4wOmuSIsFMnmlqp
 bNf6IgQy7Oeb0zq8LfMhvlR0uQRbSsThreg8Ks353E6cNedtYctQuyOzEI4EEL75pGNM
 M34V+JOvbSQVe7VDOIFLiwsM7OufpXmeb5qc+hdJqwu0mbBsJxnbuPy/9kQ6Ie5O6XNE
 1caA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJAvUWXVxSD3takV/hc+BhvrsfOAlkYklFoh4CWrYH85Ng6dJKbq3cgbIHy4CRFrmjZsRWy3+zJZPc@nongnu.org
X-Gm-Message-State: AOJu0Yzh/icBjiix64hIPBWdejYZJl+6tPXtVpFQYwT9Up25iafS4oiA
 N9ImlMiWNF4ELNGILm5nbcWcMwrhNW1ekPvqUdflPypMr3wiuG+ckFOS
X-Gm-Gg: AeBDiesVK9OLJCIRv7fDyYr8i1PuimANUh25TI420JgOR80v//lJjtGqeE4QQ3bE1A0
 3YojPiZ5qOGWQOZFh4VTuebIajtJkn2fyQDhx6a2l2X/5BsxorTSSWJBKB020xrFgX7cEaRy/bz
 DPD7IBPUZ2AziD4MFThsddwO6I/a/JWW/yliguG2KU08tAWLxTQPluv3WxeKE2Wpd3tvJI0OyKZ
 HDnc2FUE5tKQ7ZOK/dZ4a/tiO22Wq/PT23WdO2ZiyBwIj0V0AkdPYYD5YkikzomxHnrPtNne3vP
 LOu7KbXY8WJLe8M7VGpBJKtBr/qDX3/VEMblNqfVdmp4I8NF338WK9IMCJmLjoV+HYYpAebowe/
 ax/ya0MRoUNisqOuwvnp9jrV1oincObPGNl4grcMIreF/0aY6IqTdhaGVBwNoqKGZ/+WOoZi9k+
 ybYWaUqXkULD7aDboI73ClvQTDdsaD2RvO/gRbEiG0
X-Received: by 2002:a05:6a20:3ca7:b0:398:9820:f6cc with SMTP id
 adf61e73a8af0-39f2f19f722mr16245662637.55.1775536725902; 
 Mon, 06 Apr 2026 21:38:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491fedsm15809963a12.8.2026.04.06.21.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 21:38:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/5] target/riscv: A collection of bug fixes
Date: Tue,  7 Apr 2026 14:36:09 +1000
Message-ID: <20260407043614.372871-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

This is a collection of patches to fix a few of the open RISC-V bugs [1].

1: https://gitlab.com/qemu-project/qemu/-/work_items?first_page_size=20&label_name%5B%5D=target%3A%20riscv&sort=created_date&state=opened

Alistair Francis (5):
  target/riscv: Generate access fault if sc comparison fails
  linux-user/strace: Add a wrapper for read and write
  target/riscv: Don't OR mip.SEIP when mvien is one
  hw/timer: ibex_timer: Update IRQs after writing CTRL
  target/riscv: Use ELEN for Fractional LMUL check

 target/riscv/helper.h                   |  3 +++
 hw/timer/ibex_timer.c                   |  1 +
 linux-user/strace.c                     | 14 ++++++++++++++
 target/riscv/csr.c                      |  8 ++++++++
 target/riscv/op_helper.c                | 14 ++++++++++++++
 target/riscv/vector_helper.c            |  9 ++++-----
 target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
 linux-user/strace.list                  |  4 ++--
 8 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.53.0


