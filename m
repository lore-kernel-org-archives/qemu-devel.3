Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E13C36008
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGS-0005mr-KJ; Sun, 23 Mar 2025 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGQ-0005mc-F7
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGO-0002sR-NW
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:34 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so50947805ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751451; x=1743356251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9BW2dAXVXr0ySSoXg992bbAtIdIuEdH3iISj3g2uQDA=;
 b=PCjRxY2ScYX9t7qrLF3YI6TxHTDwN2JlgSDLoZ/cRWmq+aTBAaN73gxa+PlGQ5YZ5V
 2WISIzzIRPYYBkONNJvUgIq5t4FGCfeKLiHUbrKbVpz2d2qAA0kz4qauDmLPe/RCP+jN
 MQWal5P2mtp4xDm135YMkYQoQEVNRUAt45OP1b+M15PMBSc9pIDhDzXhORQMwoEvdRyc
 41OJNVVBu02cb8FX3hsvJT7L6EDZtzHVBqhHjisJbeFYWolG8JS24ahUPpu6xXmCbdXk
 hm3BOrGjEWtT+nTIrMikxJ+nHSi0PZLjbXEUp0f6EiAVeBhQi24oXNmcMFb2Qp37fqKS
 FRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751451; x=1743356251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BW2dAXVXr0ySSoXg992bbAtIdIuEdH3iISj3g2uQDA=;
 b=iUogVYNN+Q/1y+tmKb5WIMSClRoA6/4Mm+idxoYkzm590vawxtdxn2GxuoC+zaYuoC
 25kKZyFcisepLKS0rPYZTYBjAfDkoe6UkiVfVUUtNnU4z+XQjRqa4PZyRpO4MTejBShg
 dbN8GSf24epIJlgU+aM9ZSsusp75i8qLife9IdAZoZSDIjqJ8+w6FAv2CiiBIDL5GIe7
 zIPNhrb3A611OQDuDIbbA5FVUnTML1icbL+4UsyOltVZ4oKYQZuBkSkR/JBGi+us2bXW
 zZUuxPmGSQ9XivRXAg0qdte6nIqYh5OBbIH812q5FPImlVWgBBkHr/p/lRwq28hyUl3P
 wgIg==
X-Gm-Message-State: AOJu0YyR42JHxdmNuuutpQkBUzY0hsRpLRQBZCLoELMJrN12dfotWmcC
 AAab9d1Nr6LsV6CjePA61BOTA3TPUyAvWB0DG7SDbZhnhe/TF7hkw2cYwjpkbLzPJldsxdD1Dtr
 S
X-Gm-Gg: ASbGnctPe0E4X9OGtT/FyK5hrNztkSTYHrJAMgeHO2QOrOmUiPWOZKt1/Dc0AmKtNfs
 KBYnOJhT4RzTzzL5Jjc0TAadaug71dQYuja+N87IjHjt6cIobsGFTTHNMDDLCeGgPEPAmLE30aV
 6kT67pp3sej1HGE2F8LNTeqUfX9SJvW26zikHkPcXqk7GnTNzae0/vg2LPqTwNjpEsNMDxid3O0
 ZdTqK+5mcD/n88Gt0FalmGHjGUS28hY8U7x7SqUWmEdl9cKTiIdbfapHAC6NF+FeFwHxfvoAqVB
 bCvpNIH6QkuabJMldWvU0hn+BNVpPc7lOraZlA/IAPxEVpzf+W/w8mo+37RikC1wwJ8xBawHXp/
 fE/0XKo8B2lg=
X-Google-Smtp-Source: AGHT+IE7rpc++sC9o1GBacCIDCGtbP5z1DzrC/EBzxiaZmHJ5Ik9CDM92tbHoMJmq0opXDcI7mSNKw==
X-Received: by 2002:a17:902:d48d:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22780c54d63mr128993865ad.8.1742751451167; 
 Sun, 23 Mar 2025 10:37:31 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 00/17] target/avr: Increase page size
Date: Sun, 23 Mar 2025 10:37:12 -0700
Message-ID: <20250323173730.3213964-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For single-binary, we would really like to have a common
TARGET_PAGE_BITS_MIN.  A value of 10 will suffice for armv4
and will just fit required page flags and alignment.

AVR's use of TARGET_PAGE_BITS == 8 is unfortunate, and is due to
having memory mapped i/o in the first 256 or 512 bytes and sram
starting immediately afterward -- the softmmu page table mapping
really doesn't like mixed i/o and sram on the same page.

My solution is to bias the entire AVR address space up in the
QEMU address space.  This places sram at the start of the second
QEMU page, and the i/o immediately beforehand, at the end of
the first QEMU page.

Once the bias exists, we can choose any value we like.
Use this to select a larger page size, based on the size of sram.
This minimizes the number of pages required to span flash and sram.

There are also two bugs fixed in the avr disassembler.


r~


Richard Henderson (17):
  hw/core/cpu: Use size_t for memory_rw_debug len argument
  target/avr: Fix buffer read in avr_print_insn
  target/avr: Improve decode of LDS, STS
  target/avr: Remove OFFSET_CPU_REGISTERS
  target/avr: Move cpu register accesses into system memory
  target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
  target/avr: Use do_stb in avr_cpu_do_interrupt
  target/avr: Add offset-io cpu property
  target/avr: Introduce gen_data_{load,store}_raw
  target/avr: Update cpu_sp after push and pop
  target/avr: Implement CPUState.memory_rw_debug
  target/avr: Handle offset_io in helper.c
  target/avr: Handle offset_io in avr_cpu_realizefn
  hw/avr: Set offset_io and increase page size to 1k
  hw/avr: Pass mcu_type to class_base_init via .class_data
  hw/avr: Move AtmegaMcuClass to atmega.h
  target/avr: Enable TARGET_PAGE_BITS_VARY

 hw/avr/atmega.h           |  20 +++
 include/hw/core/cpu.h     |   2 +-
 target/avr/cpu-param.h    |  13 +-
 target/avr/cpu.h          |  11 +-
 target/avr/helper.h       |   3 -
 target/sparc/cpu.h        |   2 +-
 hw/avr/arduino.c          |  31 ++++-
 hw/avr/atmega.c           |  76 ++++++-----
 target/avr/cpu.c          |  49 +++++++
 target/avr/disas.c        |  21 ++-
 target/avr/helper.c       | 263 +++++++++++++++++---------------------
 target/avr/translate.c    | 106 +++++++++------
 target/sparc/mmu_helper.c |   2 +-
 target/avr/insn.decode    |   7 +-
 14 files changed, 346 insertions(+), 260 deletions(-)

-- 
2.43.0


