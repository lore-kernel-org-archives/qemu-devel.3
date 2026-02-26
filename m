Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66368FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjRO-0002U7-6D; Thu, 26 Feb 2026 17:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRK-0002Tg-Mk
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:34 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRH-0001rJ-Kp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso11334225e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143349; x=1772748149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1YCxApL5P6y/FNAwXBIxfEE53QyBoQHf9WRkCWMOkw4=;
 b=JiBBdJKxckam/A80GZ5r1lQlkb26uN/3LxLaOkgW9o1DBi/cNoahVE0irDt+JH5L8Y
 QCp85JvY2/U7gptKtm6pxZHS6oZW3xBPaqXBvuRuznTspnhQGf9DX3xWnUBTOrWk9Q5L
 BiHt8G/xlPaxk8LCF4Mp3LNpvHn80k+IMkkbGOFBGfjd5YMEW86a7/3UzJYMovh019ji
 LRcPdw3CQj+uBB+eN5nOhEmIh+ta7NnWa/bX46oEnhnbhFzFRi+fTQbOq0cyTzr5o07Y
 uTmmEaUKgSpVGVbauGWU7wwTg7m6O/Zn3tXAFYV2gsknYSKbQy1i/6Z4KrwGTL8M0h0K
 Klhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143349; x=1772748149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YCxApL5P6y/FNAwXBIxfEE53QyBoQHf9WRkCWMOkw4=;
 b=vTFZg4HpKwq3AxnMpWGd1fEHMEIPAI54mz4FsSo5NvOO9ARQz+689uSFzkdB2Lc47N
 1z2WBE5wvx5AeHWRofgIZnZWS/s5iPtMD8gLzsKg+xvfJEM3WQOZw88758cWbYtDv1s3
 eyShBlUcYqodn3W6AXssjxPCufCze+jvBdt8MEPYFFSMNvHFkW7KZl6clr4UNVDmfeWw
 /E4FlFYRJ+jYKLGgYE+uK0TXHQ/DO587njjtOGGLVIrIwrv6PPHc+0K5saR4+QgEALok
 l4W7gBnUiRBOJgGABkW7w9awfxkR9rZ8p31cPXo9F3J2JQ3n06vtpnhDL4rnLIsLPZMf
 wYEg==
X-Gm-Message-State: AOJu0Yz3fkOwtECNAiQVyfwsjB1a7kqbwTRBcLw0xpOtAz+bp92MZxoQ
 pvTH5fRuJRCegdprmoGLziHSl6jj0XzAksZuaVDNg6zc4FST0IHDu9hEeu2YjMKRFq8FpUUQtJE
 ys6gDPAQ=
X-Gm-Gg: ATEYQzwoPTUXwhMwNZKQc3s/2otEqUNPjMLVWBF5kjJ+3oDOlgRHsECXSXFFCqtK8Te
 v2nvtssnzB0p5KWljBbcPmBTekHAL5SWraTueFB//3K1yoQ/7PLG5++CBkAWfnbUdiSc6QrFKYO
 h7eyhzBOe7WhzSJ4rKXwdwzvcgnxZFzVAljHRhFEdgAGSanddSuhywkwYev/hJfulbWQ7dOa4y3
 lGNoKm7Bl0xgXPcWUcHjoZ2cztA/c3To2Di3ynUjJkPFXBr8TfHyzP/x8M7w15S07WKSs0nAPvk
 i9JZExjZqJiMcWaRItCT8UP5n5obzfeYsN2YrKWf5g2V2tzYzfwC4NctxUhn7Cg5vH+4OSqPISU
 XeqMSh3rHwexgq5/bHvTDzidoj2ARGvNvfZKB39AAwcwsTUs83l9TF9eUPh2OZiZWWheGmvuaSd
 4ZzGXel3sFazJVWBJ//bSobt/rH99S2/dJ8d8cFo0knK048djDxCTDzp2f9vMAcLvyr8k+L0V+
X-Received: by 2002:a05:600c:621b:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-483c9bb1e1fmr5713755e9.3.1772143348998; 
 Thu, 26 Feb 2026 14:02:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd702e7bsm192062865e9.5.2026.02.26.14.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:02:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/7] system/memory: Improve 'info mtree' readability
Date: Thu, 26 Feb 2026 23:02:18 +0100
Message-ID: <20260226220226.20164-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Cleaning dust, I had forgotten about this branch. In short,
it improves 'info mtree' readability of addresses.

Currently with Q35:

    address-space: I/O
      0000000000000000-000000000000ffff (prio 0, i/o): io
          0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
          0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
          0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
          0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
          0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
          0000000000000060-000000000000007f (prio 0, i/o): sm-tco
        0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
        0000000000000008-000000000000000f (prio 0, i/o): dma-cont
        0000000000000020-0000000000000021 (prio 0, i/o): pic
        0000000000000040-0000000000000043 (prio 0, i/o): pit
        ...
    memory-region: pc.ram
      0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
    memory-region: pc.bios
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
    memory-region: pci
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
    ...

With this series:

    address-space: I/O
      0000-ffff (prio 0, container): io
          0000-0003 (prio 0, i/o): acpi-evt
          0004-0005 (prio 0, i/o): acpi-cnt
          0008-000b (prio 0, i/o): acpi-tmr
          0020-002f (prio 0, i/o): acpi-gpe0
          0030-0037 (prio 0, i/o): acpi-smi
          0060-007f (prio 0, i/o): sm-tco
        0000-0007 (prio 0, i/o): dma-chan
        0008-000f (prio 0, i/o): dma-cont
        0020-0021 (prio 0, i/o): pic
        0040-0043 (prio 0, i/o): pit
        ...
    memory-region: pc.ram
      00000000-07ffffff (prio 0, ram): pc.ram
    memory-region: pc.bios
      fffc0000-ffffffff (prio 0, rom): pc.bios
    memory-region: pci
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
    ...

Philippe Mathieu-Daudé (7):
  stubs: Merge physmem.c within ram-block.c
  system/ramblock: Constify various RAMBlock arguments
  system/memory: Constify various MemoryRegion arguments
  system/memory: Have memory_region_type() correctly describe containers
  system/memory: Display address spaces starting at 0x0000.0000
  system/memory: Allow mtree_print_mr() to display distinct address
    width
  system/memory: Have 'info mtree' display addresses nicely

 include/system/memory.h   |  28 +++++-----
 include/system/ramblock.h |  26 ++++-----
 stubs/physmem.c           |  13 -----
 stubs/ram-block.c         |  17 ++++--
 system/memory.c           | 108 ++++++++++++++++++++++++--------------
 system/physmem.c          |  26 ++++-----
 stubs/meson.build         |   1 -
 7 files changed, 123 insertions(+), 96 deletions(-)
 delete mode 100644 stubs/physmem.c

-- 
2.52.0


