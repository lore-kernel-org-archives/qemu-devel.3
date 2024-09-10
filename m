Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8DBECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsth-0003fO-Er; Tue, 10 Sep 2024 00:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snstf-0003dm-Pi; Tue, 10 Sep 2024 00:54:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snste-0002wS-23; Tue, 10 Sep 2024 00:54:35 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20688fbaeafso50896955ad.0; 
 Mon, 09 Sep 2024 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725944072; x=1726548872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Fe294WC/5uKlHEu+QVa1aJq+8IttCa1kwVBvjFgIXk=;
 b=bryUEx7xhUY+3jhUNKaipbxQwdSh00js3w4rOkK7uxUtY4QjLXMssQt++2Q+VGR+jJ
 kiy6Lq5PMan+/D6KksAGEssbDOfaJfl32uf+ZblCcuwgB7VuH7XbW0HjDO1N9YN+NegT
 K0ug4AJ8K/DJzfmvVgPbvJYjeNxddUUCg/U7sXpjJBTJCXH2iEm7Zm8d3V2Pstz4223T
 RUkdJyWFMg0c6++7UZvSSs9hX5HblY4FI/ZsroS/ADoN675EfgS98fafmEkkI1vTbfxc
 vGmXVKyRcFujYCo+cE0sZtze2DgHdguTiqdh4KKVd/oukgMVaaxOqBjeJnGs/2qUqo0j
 mU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725944072; x=1726548872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Fe294WC/5uKlHEu+QVa1aJq+8IttCa1kwVBvjFgIXk=;
 b=N9TNTQ9CYrQrJIIOLwIW4OB0PRM2fouiVtWF8bTxKuJQmduscRdAaYf6I9GqrZ6w/3
 6qB7V+bfj1qruHfPUaZuVbT2VImbt3v7I29Xh38bTtIKYiTJMm7jioGyV8Q/BXUGaGHA
 pUtx0KRTRK7PA4H4ug3f3nR+uRYmMMhS+Ix8vGu+p3n/8ZOf3Zz5A5N/8C8mX18omgiH
 FzGvueeKW+F/U2BC4UVRFqBL0LmEH41X+pBmvwcJdFHeNe8cp/tas0NQSEBgIyZsxk26
 5IuL8ZkU3enTmAPhdhX5tjIj/AFQ6f8dCg1mWPNRo5MJMwK0BBn56lPpcD/dM6YJaonY
 MbZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG5y3IjIJPL0NcHWda7SFt3x/AgOvK97Lqh3pZ10HUw20flHSf1u47brck2pqHuRZleA3uPDIY7PmC@nongnu.org
X-Gm-Message-State: AOJu0YwmxLCOVeHiCxc8gVA/znz5jSrhjvRrdwJWM5Vi+QbZVsOrtLTL
 HnVGTKR4+whHyDhMZMBFwQcdV3v+eHkpUnmQPUNerV+GNRidCZrVNKExxw==
X-Google-Smtp-Source: AGHT+IFzO+4hEQjOhBLJ0jhwTMonMlGWzr96q6cRW8FG7EeLaZ8vBjwl+xL3h1hqHBnHpih3681YjQ==
X-Received: by 2002:a17:902:d4c4:b0:206:f065:f45d with SMTP id
 d9443c01a7336-206f065f520mr149918335ad.31.1725944071585; 
 Mon, 09 Sep 2024 21:54:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e352d8sm40944425ad.72.2024.09.09.21.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 21:54:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 0/2] riscv: char: Avoid dropped charecters
Date: Tue, 10 Sep 2024 14:54:17 +1000
Message-ID: <20240910045419.1252277-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

This series fixes: https://gitlab.com/qemu-project/qemu/-/issues/2114

This converts the RISC-V charecter device callers of qemu_chr_fe_write()
to either use qemu_chr_fe_write_all() or to call qemu_chr_fe_write() async
and act on the return value.

v4:
 - Drop the unused char_tx_time
 - Update the migration in vmstate_sifive_uart
v3:
 - Fixup spelling
v2:
 - Use Fifo8 for the Sifive UART instead of a custom FIFO

Alistair Francis (2):
  hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
  hw/char: sifive_uart: Print uart characters async

 include/hw/char/sifive_uart.h | 16 +++++-
 hw/char/riscv_htif.c          | 12 ++++-
 hw/char/sifive_uart.c         | 94 ++++++++++++++++++++++++++++++++---
 3 files changed, 112 insertions(+), 10 deletions(-)

-- 
2.46.0


