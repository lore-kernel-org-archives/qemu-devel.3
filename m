Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2ABC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNcz-0001Xy-1P; Fri, 07 Aug 2026 12:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVE-0004HV-IJ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:28:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVD-0007MT-29
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:28:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d0407aedd6so39500115ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786116529; x=1786721329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t7IrLZE+c6b/cJnJeQ/13uPHw9OhEdbeAShTrrITKEI=;
 b=igynECLX+TF8kvmNowv1oFcHaSJnqopDl1lo8sh+ctsei2SiXqWa3BktknpA5N5vr5
 HHM+ByEv/RO7xEyUyNKUo0RM2Ves+8NIL4k+1V+IrmqE6WRlvoQcbAtW3QoVEWSVmrTx
 +NULbXHxhup1MryFuRUzA+R8X4GMC1wCcFXOR6z4Qsq0q29JE+bKlapgHSg32HsoyYXL
 d9XMZa5aWB3vVPjF00z0eIYHwOqerHA3SNheRRg3a7WfOV5S3+LUwakpChDooQ67Zd4n
 i3YTm5lV6uGT4k90revWerv/5CDdlWbvoOd0+2psqmffUyYsLDyHEsto+HfPfpme0yCV
 wTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116529; x=1786721329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t7IrLZE+c6b/cJnJeQ/13uPHw9OhEdbeAShTrrITKEI=;
 b=NXr9v1lMKOXZM7RQewHBo3bnh2TO2xlEGD2JpnomhHNAikUd2SFJv3QVFQnLHMGZqE
 bX47Ig6yLPVsZP0BLSF6XNhQ+9yWlY8OXky9SkvqbH86/zCX/SlTdPNIcEszl5V/KHRq
 vcn/oRWRYAqy2em6dKYFBHoU0hb9mY8tvOB+SZOvaeXM0CdWrGS89GxorQ2SYwFr6Jwl
 5F1H7nNgzg2J3kCVEy6/vbvYTUSQ5wOviPL9wceOXUYUM706HceIrStZ5gqO7xOHtAHe
 j0PPZQgtutu7iBHiguk/5DdhjWjQme7CWnrTIyPCPimSPa8sRM6DnYEz0fByBAYTLp2d
 HFEQ==
X-Gm-Message-State: AOJu0YzdyxBPEZVURc5+1XYXix6U5k0DC/d3YEpJRCPHSffmaimphLss
 /0rx8ZiVyoyQUr5AcQbzTwexRvYwW0paKcZa0qMgEc6gb+psUQ6tGGas
X-Gm-Gg: AR+sD12SmaQRzh6uQ1g0CzV/A5r9TvNJhnT+fsjBmg84MY7xFDQNMX1yUOk5rWknuz5
 l7vXPfWQ6HNQ+HDk2SY3eXcfkZfZcXdH+aBq6fKGlixaJd5LMATCtaEr5l1RcQNqi2S9UPnmqmT
 sgH0shMtsBR3TZuMAl5TccLJJU1vUmiOy+r56FfLZvUkZ6HicAyLZaCFPYm4qWXH/9QLNL46s+y
 sWAUg3RfrXJDWYJ8tL4UTJtDHmmK3+obQ4LJhjdUENVixHS4dUCewfnoBkT/6TlGe5EZaLgzar4
 X8OO3dmHJI4p0ZSoJfuT++1Ma9Wrv3JwypIq0iU6v5kQs0fJyqJLuQ4KoNj0RwDWBKwYVNm5zhq
 SpaKfJUqeghwSda0IG/0lvPcQZgrDM+hBbLJW3YRu+pvWihFOI6PuBHbKLa84MVBxWGNuQEkJQj
 InfyRU4cKEn2wbGeDaTZkUJIsrivuPsbRFNC8mi5iSxKMwDdWkBGZhhTvmta+uiAoNGrTlHatQ5
 sdgH2BUJUU=
X-Received: by 2002:a17:903:3248:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d0ca14c351mr308868855ad.0.1786116529257; 
 Fri, 07 Aug 2026 08:28:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2406:da14:1cf8:d800:471c:a879:4603:554f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccae6f8sm10953895ad.1.2026.08.07.08.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:28:48 -0700 (PDT)
From: Wang Zhongyu <wzy15515798875@gmail.com>
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 0/5] riscv: add K230 I2C controller support
Date: Fri,  7 Aug 2026 23:28:25 +0800
Message-ID: <20260807152830.6833-1-wzy15515798875@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=wzy15515798875@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 12:41:00 -0400
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

Hi all,

This series adds I2C controller support to the Kendryte K230
machine.

The first patch introduces a model of the DesignWare-based I2C
controller used by the K230. The second patch replaces the five
unimplemented I2C regions with controller instances and connects
them to the PLIC. The remaining patches add qtests for register,
reset, interrupt, abort, and transfer behavior, including transfers
with TMP105 and i2c-echo slave devices.

The model currently supports master-mode 7-bit transfers, the K230
TX and RX FIFO configuration and related register behavior,
interrupt status and masking, repeated START and STOP handling,
General Call writes, reset, and migration state.

DMA, 10-bit addressing, bus clear, Device ID transactions, and raw
START BYTE generation are not implemented.

Testing performed:

- riscv64-softmmu build
- K230 I2C qtests
- scripts/checkpatch.pl on the patch series
- K230 Linux boot and DesignWare I2C driver probe
- i2cdetect, i2cget, and i2cset transfers with an attached I2C
  slave device

Regards,
Wang Zhongyu

Wang Zhongyu (5):
  hw/i2c: add K230 I2C controller model
  hw/riscv: instantiate K230 I2C controllers
  tests/qtest: add K230 I2C controller tests
  tests/qtest: expand K230 I2C controller tests
  tests/qtest: test K230 I2C transfers with slave devices

 MAINTAINERS                 |    3 +
 docs/system/riscv/k230.rst  |    1 +
 hw/i2c/Kconfig              |    4 +
 hw/i2c/k230_i2c.c           | 1083 ++++++++++++++++++++++++++
 hw/i2c/meson.build          |    1 +
 hw/riscv/Kconfig            |    1 +
 hw/riscv/k230.c             |   36 +-
 include/hw/i2c/k230_i2c.h   |   72 ++
 include/hw/riscv/k230.h     |    8 +
 tests/qtest/k230-i2c-test.c | 1459 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |    2 +-
 11 files changed, 2654 insertions(+), 16 deletions(-)
 create mode 100644 hw/i2c/k230_i2c.c
 create mode 100644 include/hw/i2c/k230_i2c.h
 create mode 100644 tests/qtest/k230-i2c-test.c

-- 
2.43.0


