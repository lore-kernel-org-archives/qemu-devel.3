Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F255BC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0zwQ-0001lL-FM; Mon, 31 Aug 2026 07:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1x0zwO-0001ka-SH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:12:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1x0zwM-0003D6-OL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:12:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso3308055b3a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788174757; x=1788779557; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j2QBeZ0Yc1tu5HVLCpJH+WzPA5TiTAGRNRt9Bv8f2xY=;
 b=gLYpYEaAFx0MUtAiFTc7zzR24YZcYMVo9uHm6zzKo9AK2x3QTRYmQXQ+kO9a3EiUJt
 BjfpIbhz8u3Bk+kT2EdrZ2aoEhzf+Jh839/uQSfUv5g6NbVw5EKsHBH2dFw90C+HapRF
 vctZ2OJsgGjy2lIB7N2OzUozSoJr+kjrk3/V/u0bhXgWm8FU0KcfvBljpAlIJvgg4MlH
 rtX3FOQnQlTei6DNiq8E8Id6AbkolEXtZeNOxrXlTqgFbPzLsoBZuCL9MKYuplrNCqqI
 JgRAVTITB8rZI98Fjz2KoSMCXo0QAWMoPv1PBl+ZsZHmouz59qY79jaEeadUKrHbyfdm
 +fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788174757; x=1788779557;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j2QBeZ0Yc1tu5HVLCpJH+WzPA5TiTAGRNRt9Bv8f2xY=;
 b=g1MhQvYooC9HiaNeWo8nLIZBNZby9rnwfHsr4gI1tlaE/XIg0366z0gKrS5YDJ7Sv6
 3s/wxfrdqRO7SuLC7wyJnCGlx8Q2fjHo4MoMk38gfywk0fE2529vbW6kH/H/LY/pkI0l
 rI/D8U53PipmjCsAAUMMXYR3LTCIogCBRw3GZJTbWc4ncPQ8Jsdpn+mGqugXI5VIJg/X
 RSKiUIr0jJMFIT/CZR3oRe7E2ckfP74OBqbesZodzgreBs6UKkAIZkrwL43lTBRP/rSn
 gcuVPsd1OgBv8OqESswse+X0tCvopLsGqr/bM2lbCrHxjCqr7x55FxKn8k8FP0iRlV3m
 FZgQ==
X-Gm-Message-State: AFuF++kV6vo50Z66V3/G5pJbk2MBPr/AO0JLWgHZMHwMlSAezmBGMbhP
 bLlqlOdCNZ3/Ls2dpn+YnwUqmVwRUVoGTBuMMQdYAKdR2Kgi8O5kGusR
X-Gm-Gg: AR+sD10y3/rb+OzfJNsc3Xe9PM4TD/F5YpF/YHji3/0I0gTDNWpMzY36y/nS6KxbWPw
 WO2hYZs0xXMOR6wRSs2OQCLl5h+ZHUopK7zKFvT5/W9pKF1XSy5LWhPFVhCQ8RU1eKpTONGJ4Et
 1s+Q5//fsZz/t3sxjFG5jsOzwFoMzVPhPBSrLdfN0Zx1siK/rPpRR5yjK8Dd5ffjqlkL6xi7y2C
 hrFhC2Gstzng+r5bdIH1A3BFM9R9rFgn4w24gnKy/0LHbehScIS3ZwhNF0622UCR0jiqNPZO6gN
 TGpcHM+nRdwRNAhU4VlvU9CzXx+inCLX6bEylqkntz1GiYIN5n86U6YSdAmdGr4NH2BrniBz1Eg
 S0EqI6tZJh725avCiJcjsZhmaxr593ovlsJXc37AcWGcZIiW4N8AYir+9v3ihsoNAk03Yh2Tqsm
 rWSGw6egFkR2JLTXFKcufh+ZWuRIpUU84Bae2a+hWO0bGw0OBG22PoKsmTaSmbnaaIJO+YejI5Y
 YZBdSVTIrrFqfqbyFRXTu/xjA==
X-Received: by 2002:a05:6a00:2991:b0:851:92fe:504b with SMTP id
 d2e1a72fcca58-856274efd7bmr48685583b3a.7.1788174756841; 
 Mon, 31 Aug 2026 04:12:36 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8900:7ad7:8121:d841:db7e:846b:ea5e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a397d927sm3367329b3a.54.2026.08.31.04.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 04:12:36 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v4 0/3] hw/riscv: Add K230 DWC SSI Standard PIO support
Date: Mon, 31 Aug 2026 19:11:11 +0800
Message-Id: <20260831-t_v4_spi_patch-v4-0-370d416f26b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9hlWoC/x3MQQrCMBBA0auUWRtsY6jiVUTCNB3NLBLjTFqE0
 rsbXb7F/xsoCZPCtdtAaGXlV25whw5CxPwkw3Mz2N6O/eU0mOpX57WwL1hDNPN4dmFwzlpL0KI
 i9ODPf3i7N0+oZCbBHOJv86a0mKVoFcJ0TKiVBPb9C6D3F0aHAAAA
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x432.google.com
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

Hi,

This series adds a reusable Standard PIO model for the Synopsys DWC SSI
controller. The K230 machine has three of these controllers; the later
patches wire them into the machine.

The first patch implements the Standard SPI register subset, configurable
cs and FIFOs, the four Standard PIO transfer modes, interrupts,
reset and migration, and RAZ/WI for the unsupported enhanced SPI, DMA and
XIP registers. The model follows the DWC CTRLR0 layout where TMOD is at
bits [11:10]; the DW APB SSI variant (TMOD at bits [9:8]) is not
supported. The second patch instantiates the three K230 DWC SSI
controllers and connects their nine interrupt outputs to the PLIC. The
third patch attaches a standard SPI NOR flash to spi0 cs 0.

Changes since v3:

* Squashed the patches: interrupt support into the model patch, PLIC
  routing into the instantiation patch, so each patch has one clear job.
* Added the REGISTER Kconfig dependency for DWC_SSI.
* Listed the DWC SSI files explicitly in MAINTAINERS.
* Made the MWCR MHS bit writable so guest writes are no longer silently
  dropped, with a matching qtest.
* Added DWC_SSI_PHASE_COUNT; the migration check now uses >= COUNT.
* Replaced imr-reset with the master-mode property, which derives the IMR
  reset value per instance; serial-slave is not modelled.
* Removed the redundant SPI_FRF clearing and added an unimplemented warning.
* Documented  the frame-width constraint: the m25p80 family is an 8-bit
  byte-protocol device and needs DFS=7 (the reset default selects an
  8-bit frame); frames wider than 8 bits are logged with a warning.
* TX-only now drains the FIFO synchronously on DR writes: no more 64-frame
  batching, no more reads of TXFLR/SR to make progress, and no asymmetry
  with the TR path.

Enhanced SPI, internal IDMA, HI_SYS and XIP remain separate follow-up
series. The DW APB SSI TMOD encoding is outside the scope of this series.

Testing:

* Built qemu-system-riscv64 and the K230 DWC SSI qtest target.
* Ran the K230 DWC SSI qtests, covering all Standard PIO modes, register
  contracts, interrupt and PLIC routing, TX-only synchronous draining and
  standard SPI NOR reads.
* checkpatch.pl: 0 errors, 0 warnings.
* U-Boot read/write against the attached flash via sf probe/read/write.
* U-Boot loaded Linux from SPI flash and booted it to the command line.
* Linux spi-mem polling-path read/write with the vendor driver.
* Linux spi-mem reads, and writes whose total frame count does not exceed
  the FIFO depth.

Note: 
	a spi-mem write larger than the FIFO depth fails with
"CS de-assertion on Tx" (-EIO) in the K230 SDK driver's native-CS path.
The model sends the whole FIFO at once when SER is enabled, so the
driver's refill loop sees TXFLR=0 and mistakes that for a dropped CS. In
this model, an empty FIFO simply means the transfer is done.
https://github.com/kendryte/k230_sdk/blob/v2.0/src/little/linux/drivers/spi/spi-dw-core-k230.c#L733-L742

References:

K230 Technical Reference Manual:

https://github.com/revyos/external-docs/blob/79b3a79072412ead81427e6755b4d9e6d9ded8d8/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf

Linux DWC SSI driver and binding:

https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/drivers/spi/spi-dw-core.c
https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/drivers/spi/spi-dw.h
https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

This series supersedes the previous v3 series:

https://lore.kernel.org/qemu-devel/20260808182956.290561-1-flamboyant.h.01@gmail.com/T/

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
Kangjie Huang (3):
      hw/ssi: Add Synopsys DWC SSI standard PIO controller
      hw/riscv/k230: Instantiate DWC SSI controllers and route IRQs to PLIC
      hw/riscv/k230: Attach a standard SPI NOR flash

 MAINTAINERS                     |    2 +
 docs/system/riscv/k230.rst      |    2 +
 hw/riscv/Kconfig                |    2 +
 hw/riscv/k230.c                 |  165 +++++-
 hw/ssi/Kconfig                  |    5 +
 hw/ssi/dwc_ssi.c                | 1108 +++++++++++++++++++++++++++++++++++++++
 hw/ssi/meson.build              |    1 +
 include/hw/riscv/k230.h         |    7 +
 include/hw/ssi/dwc_ssi.h        |   80 +++
 tests/qtest/k230-dwc-ssi-test.c |  720 +++++++++++++++++++++++++
 tests/qtest/meson.build         |    3 +-
 11 files changed, 2085 insertions(+), 10 deletions(-)
---
base-commit: 562bae590f194fb590beb5c65da44fc35ab9f64a
change-id: 20260831-t_v4_spi_patch-d674c144222e

Best regards,
-- 
Kangjie Huang <flamboyant.h.01@gmail.com>


