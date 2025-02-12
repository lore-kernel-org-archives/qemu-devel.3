Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEBDC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMh-0003R4-2o; Wed, 12 Feb 2025 16:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMd-00038X-91
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMX-0000X5-KL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso1260405e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396020; x=1740000820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHlPx97k0omNXrH33hQz/c43wvDFQ4n2O14NmM8FrcI=;
 b=s6SZy8FUtvfr6Q7fvKmjcbjTkXZ2Rbxf91H1dALlOFi+KlPnvgr9d6jRT1KyZzwOiR
 G6ddAU7EnjuYEBHV1gzai6dxI4JYBNG3O/1nBphW/YtUQSSkvuabKyjfkrTBqM3vrEEp
 aiLoGYnIOxN4z6hnNExo4GVnFmKChd3neWyBuBZSSW8biceGE9vJBExaubtS0690Ui3F
 Rd7oSX9xmSuRmnZw9PI+ZDNo8fMBB9R9epg9S4KRVcdL77vNqSeHlARGOPdU5nQMVXkL
 +hCmtl2tt8uoO6hAOJj25T9fz7YNlKULA8BXNw/bS455QZ2sKX3KpsR1IuKmxy/WxpRJ
 h73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396020; x=1740000820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHlPx97k0omNXrH33hQz/c43wvDFQ4n2O14NmM8FrcI=;
 b=uUvBfizP7CsB72gGG4QVSPX9E+Qztb/7k6kkVJwXHRM40vlZ+9t0rYdGwZ7VkX1awD
 n3JNU5NOQcbtYQ9l+4Y88C1h9gZTkYFzfyesYWv2mkd9sBaOYzoEaE911a4K4U5SGufy
 +aQoH9B8UV7oKz8+DThcyc6G/OEMd4oNvHRXQI28CBpKt7kRXFt4dahYPNbFhva57AHi
 gMgy+mt3BxuEdT7UbLonB9AXocH5MzDDbMzxBNIq9vABqobqLAj7RTDfsqLnhC9cuDrd
 XBRB2sYeD961N/FBJ2lGfYKydtSCuDUQGpp5uka+QTA3HOM7icgdwzKPLwcV+SpRZqpq
 EovA==
X-Gm-Message-State: AOJu0YxuY60PaFLCY2IPuCsXI1WeNkHnB71/J7+ZvB9JDTeYgYTgNlDH
 wgx0pWhvQhrbE2gVsAxRPicuFH1aFrUwEm/uxJsAdmQHvff4T0XGTvXYA7mgi2N9LTwOGqOLXcu
 dNfg=
X-Gm-Gg: ASbGnctC002mA8ai1j3I4z9GOVrl333UXkiLsmuLDJ2qvqCKKXps1h8Kvt5ZrgoO6MD
 IrAW2J3JRo1p0YsfoKUyh1EQQSk3RlQ+VbZaWsiqBdTUT0JIFtcizMulYgoJfo0FDRhALc1oXYF
 KUFeWUSZJW5ywtkSCAvrw0zZdfFg/ofEfwhHa7C+RnOzqfr36pL6xmWyafjuTw5T0aMcqjan8vO
 i4SWLYNggDwP7AhJtUFDaLslCINojaoKwjiOlFe9+N+LO5whq4/UtmS8oINgggDkc5HNHsSODfR
 nj2TFby3pGHxaBCZnli3wfkgper+6OGrwyKsCjQwQH8WXFLELmNOEgd3j7sw4YFzOQ==
X-Google-Smtp-Source: AGHT+IGpgEQoFVJwxJt2x4dbvkbL5PxSGgGYG4uENaNrJWQ4dg6tIuHWt20R/rSC4IFKXpw2z+J6zg==
X-Received: by 2002:a05:600c:a08e:b0:439:4cef:3510 with SMTP id
 5b1f17b1804b1-43960179c2cmr11007095e9.10.1739396018287; 
 Wed, 12 Feb 2025 13:33:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4491sm48613f8f.7.2025.02.12.13.33.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/19] qom: Have class_init() take a const data argument
Date: Wed, 12 Feb 2025 22:32:39 +0100
Message-ID: <20250212213249.45574-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Mechanical change using gsed, then style manually adapted
to pass checkpatch.pl script.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/qom.rst                            |  8 +-
 docs/devel/reset.rst                          |  2 +-
 docs/devel/virtio-backends.rst                |  2 +-
 hw/usb/hcd-uhci.h                             |  2 +-
 include/hw/boards.h                           |  2 +-
 include/hw/i386/pc.h                          |  5 +-
 include/hw/virtio/virtio-pci.h                |  2 +-
 include/qom/object.h                          |  4 +-
 target/arm/cpu.h                              |  2 +-
 target/ppc/cpu.h                              |  3 +-
 accel/hvf/hvf-accel-ops.c                     |  4 +-
 accel/kvm/kvm-accel-ops.c                     |  2 +-
 accel/kvm/kvm-all.c                           |  2 +-
 accel/qtest/qtest.c                           |  4 +-
 accel/tcg/tcg-accel-ops.c                     |  2 +-
 accel/tcg/tcg-all.c                           |  2 +-
 accel/xen/xen-all.c                           |  4 +-
 authz/list.c                                  |  2 +-
 authz/listfile.c                              |  2 +-
 authz/pamacct.c                               |  2 +-
 authz/simple.c                                |  2 +-
 backends/confidential-guest-support.c         |  3 +-
 backends/cryptodev-builtin.c                  |  2 +-
 backends/cryptodev-lkcf.c                     |  2 +-
 backends/cryptodev-vhost-user.c               |  2 +-
 backends/cryptodev.c                          |  2 +-
 backends/dbus-vmstate.c                       |  2 +-
 backends/host_iommu_device.c                  |  2 +-
 backends/hostmem-epc.c                        |  2 +-
 backends/hostmem-file.c                       |  2 +-
 backends/hostmem-memfd.c                      |  2 +-
 backends/hostmem-ram.c                        |  2 +-
 backends/hostmem-shm.c                        |  2 +-
 backends/hostmem.c                            |  2 +-
 backends/iommufd.c                            |  4 +-
 backends/rng-builtin.c                        |  2 +-
 backends/rng-egd.c                            |  2 +-
 backends/rng-random.c                         |  2 +-
 backends/rng.c                                |  2 +-
 backends/tpm/tpm_emulator.c                   |  2 +-
 backends/tpm/tpm_passthrough.c                |  2 +-
 backends/vhost-user.c                         |  2 +-
 block/throttle-groups.c                       |  3 +-
 chardev/baum.c                                |  2 +-
 chardev/char-console.c                        |  2 +-
 chardev/char-fd.c                             |  2 +-
 chardev/char-file.c                           |  2 +-
 chardev/char-hub.c                            |  2 +-
 chardev/char-mux.c                            |  2 +-
 chardev/char-null.c                           |  2 +-
 chardev/char-parallel.c                       |  2 +-
 chardev/char-pipe.c                           |  2 +-
 chardev/char-pty.c                            |  2 +-
 chardev/char-ringbuf.c                        |  2 +-
 chardev/char-serial.c                         |  2 +-
 chardev/char-socket.c                         |  2 +-
 chardev/char-stdio.c                          |  2 +-
 chardev/char-udp.c                            |  2 +-
 chardev/char-win-stdio.c                      |  2 +-
 chardev/char-win.c                            |  2 +-
 chardev/char.c                                |  2 +-
 chardev/msmouse.c                             |  2 +-
 chardev/spice.c                               |  6 +-
 chardev/testdev.c                             |  2 +-
 chardev/wctablet.c                            |  2 +-
 crypto/secret.c                               |  2 +-
 crypto/secret_common.c                        |  2 +-
 crypto/secret_keyring.c                       |  2 +-
 crypto/tls-cipher-suites.c                    |  3 +-
 crypto/tlscreds.c                             |  2 +-
 crypto/tlscredsanon.c                         |  2 +-
 crypto/tlscredspsk.c                          |  2 +-
 crypto/tlscredsx509.c                         |  2 +-
 event-loop-base.c                             |  3 +-
 gdbstub/system.c                              |  2 +-
 hw/9pfs/virtio-9p-device.c                    |  2 +-
 hw/acpi/erst.c                                |  2 +-
 hw/acpi/generic_event_device.c                |  2 +-
 hw/acpi/pci.c                                 |  4 +-
 hw/acpi/piix4.c                               |  2 +-
 hw/acpi/vmclock.c                             |  2 +-
 hw/acpi/vmgenid.c                             |  2 +-
 hw/adc/aspeed_adc.c                           | 10 +--
 hw/adc/npcm7xx_adc.c                          |  2 +-
 hw/adc/stm32f2xx_adc.c                        |  2 +-
 hw/adc/zynq-xadc.c                            |  2 +-
 hw/alpha/typhoon.c                            |  2 +-
 hw/arm/allwinner-a10.c                        |  2 +-
 hw/arm/allwinner-h3.c                         |  2 +-
 hw/arm/allwinner-r40.c                        |  2 +-
 hw/arm/armsse.c                               |  2 +-
 hw/arm/armv7m.c                               |  4 +-
 hw/arm/aspeed.c                               | 56 +++++++-----
 hw/arm/aspeed_ast10x0.c                       |  2 +-
 hw/arm/aspeed_ast2400.c                       |  4 +-
 hw/arm/aspeed_ast2600.c                       |  2 +-
 hw/arm/aspeed_ast27x0.c                       |  2 +-
 hw/arm/aspeed_soc_common.c                    |  2 +-
 hw/arm/b-l475e-iot01a.c                       |  2 +-
 hw/arm/bcm2835_peripherals.c                  |  2 +-
 hw/arm/bcm2836.c                              |  8 +-
 hw/arm/bcm2838.c                              |  2 +-
 hw/arm/bcm2838_peripherals.c                  |  2 +-
 hw/arm/collie.c                               |  2 +-
 hw/arm/digic.c                                |  2 +-
 hw/arm/exynos4210.c                           |  2 +-
 hw/arm/exynos4_boards.c                       |  4 +-
 hw/arm/fby35.c                                |  2 +-
 hw/arm/fsl-imx25.c                            |  2 +-
 hw/arm/fsl-imx31.c                            |  2 +-
 hw/arm/fsl-imx6.c                             |  2 +-
 hw/arm/fsl-imx6ul.c                           |  2 +-
 hw/arm/fsl-imx7.c                             |  2 +-
 hw/arm/highbank.c                             |  6 +-
 hw/arm/integratorcp.c                         |  6 +-
 hw/arm/microbit.c                             |  2 +-
 hw/arm/mps2-tz.c                              | 10 +--
 hw/arm/mps2.c                                 | 10 +--
 hw/arm/mps3r.c                                |  4 +-
 hw/arm/msf2-soc.c                             |  2 +-
 hw/arm/musca.c                                |  6 +-
 hw/arm/musicpal.c                             | 14 +--
 hw/arm/npcm7xx.c                              |  6 +-
 hw/arm/npcm7xx_boards.c                       | 12 +--
 hw/arm/nrf51_soc.c                            |  2 +-
 hw/arm/omap_sx1.c                             |  4 +-
 hw/arm/raspi.c                                | 10 +--
 hw/arm/raspi4b.c                              |  2 +-
 hw/arm/realview.c                             |  8 +-
 hw/arm/sbsa-ref.c                             |  2 +-
 hw/arm/smmu-common.c                          |  2 +-
 hw/arm/smmuv3.c                               |  4 +-
 hw/arm/stellaris.c                            | 10 +--
 hw/arm/stm32f100_soc.c                        |  2 +-
 hw/arm/stm32f205_soc.c                        |  2 +-
 hw/arm/stm32f405_soc.c                        |  2 +-
 hw/arm/stm32l4x5_soc.c                        |  8 +-
 hw/arm/strongarm.c                            | 13 +--
 hw/arm/versatilepb.c                          |  6 +-
 hw/arm/vexpress.c                             |  6 +-
 hw/arm/virt.c                                 |  4 +-
 hw/arm/xen-pvh.c                              |  2 +-
 hw/arm/xilinx_zynq.c                          |  2 +-
 hw/arm/xlnx-versal-virt.c                     |  2 +-
 hw/arm/xlnx-versal.c                          |  2 +-
 hw/arm/xlnx-zcu102.c                          |  2 +-
 hw/arm/xlnx-zynqmp.c                          |  2 +-
 hw/audio/ac97.c                               |  2 +-
 hw/audio/adlib.c                              |  2 +-
 hw/audio/asc.c                                |  2 +-
 hw/audio/cs4231.c                             |  2 +-
 hw/audio/cs4231a.c                            |  2 +-
 hw/audio/es1370.c                             |  2 +-
 hw/audio/gus.c                                |  2 +-
 hw/audio/hda-codec.c                          |  8 +-
 hw/audio/intel-hda.c                          |  8 +-
 hw/audio/marvell_88w8618.c                    |  2 +-
 hw/audio/pcspk.c                              |  2 +-
 hw/audio/pl041.c                              |  2 +-
 hw/audio/sb16.c                               |  2 +-
 hw/audio/via-ac97.c                           |  4 +-
 hw/audio/virtio-snd-pci.c                     |  2 +-
 hw/audio/virtio-snd.c                         |  2 +-
 hw/audio/wm8750.c                             |  2 +-
 hw/avr/arduino.c                              | 10 +--
 hw/avr/atmega.c                               | 10 +--
 hw/block/fdc-isa.c                            |  2 +-
 hw/block/fdc-sysbus.c                         |  6 +-
 hw/block/fdc.c                                |  2 +-
 hw/block/m25p80.c                             |  4 +-
 hw/block/nand.c                               |  2 +-
 hw/block/pflash_cfi01.c                       |  2 +-
 hw/block/pflash_cfi02.c                       |  2 +-
 hw/block/swim.c                               |  4 +-
 hw/block/vhost-user-blk.c                     |  2 +-
 hw/block/virtio-blk.c                         |  2 +-
 hw/block/xen-block.c                          |  6 +-
 hw/char/avr_usart.c                           |  2 +-
 hw/char/bcm2835_aux.c                         |  2 +-
 hw/char/cadence_uart.c                        |  2 +-
 hw/char/cmsdk-apb-uart.c                      |  2 +-
 hw/char/debugcon.c                            |  2 +-
 hw/char/digic-uart.c                          |  2 +-
 hw/char/diva-gsp.c                            |  4 +-
 hw/char/escc.c                                |  2 +-
 hw/char/exynos4210_uart.c                     |  2 +-
 hw/char/goldfish_tty.c                        |  2 +-
 hw/char/grlib_apbuart.c                       |  2 +-
 hw/char/ibex_uart.c                           |  2 +-
 hw/char/imx_serial.c                          |  2 +-
 hw/char/ipoctal232.c                          |  2 +-
 hw/char/mcf_uart.c                            |  2 +-
 hw/char/mchp_pfsoc_mmuart.c                   |  2 +-
 hw/char/nrf51_uart.c                          |  2 +-
 hw/char/parallel.c                            |  2 +-
 hw/char/pl011.c                               |  2 +-
 hw/char/renesas_sci.c                         |  2 +-
 hw/char/sclpconsole-lm.c                      |  2 +-
 hw/char/sclpconsole.c                         |  2 +-
 hw/char/serial-isa.c                          |  2 +-
 hw/char/serial-mm.c                           |  2 +-
 hw/char/serial-pci-multi.c                    |  6 +-
 hw/char/serial-pci.c                          |  2 +-
 hw/char/serial.c                              |  2 +-
 hw/char/sh_serial.c                           |  2 +-
 hw/char/shakti_uart.c                         |  2 +-
 hw/char/sifive_uart.c                         |  2 +-
 hw/char/spapr_vty.c                           |  2 +-
 hw/char/stm32f2xx_usart.c                     |  2 +-
 hw/char/stm32l4x5_usart.c                     |  9 +-
 hw/char/terminal3270.c                        |  2 +-
 hw/char/virtio-console.c                      |  4 +-
 hw/char/virtio-serial-bus.c                   |  6 +-
 hw/char/xen_console.c                         |  2 +-
 hw/char/xilinx_uartlite.c                     |  2 +-
 hw/core/bus.c                                 |  2 +-
 hw/core/clock.c                               |  2 +-
 hw/core/cpu-common.c                          |  2 +-
 hw/core/generic-loader.c                      |  2 +-
 hw/core/guest-loader.c                        |  2 +-
 hw/core/machine.c                             |  2 +-
 hw/core/or-irq.c                              |  2 +-
 hw/core/platform-bus.c                        |  2 +-
 hw/core/qdev.c                                |  2 +-
 hw/core/register.c                            |  2 +-
 hw/core/reset.c                               |  2 +-
 hw/core/resetcontainer.c                      |  3 +-
 hw/core/split-irq.c                           |  2 +-
 hw/core/sysbus.c                              |  4 +-
 hw/cpu/a15mpcore.c                            |  2 +-
 hw/cpu/a9mpcore.c                             |  2 +-
 hw/cpu/arm11mpcore.c                          |  2 +-
 hw/cpu/cluster.c                              |  2 +-
 hw/cpu/core.c                                 |  2 +-
 hw/cpu/realview_mpcore.c                      |  2 +-
 hw/cxl/switch-mailbox-cci.c                   |  2 +-
 hw/display/artist.c                           |  2 +-
 hw/display/ati.c                              |  2 +-
 hw/display/bcm2835_fb.c                       |  2 +-
 hw/display/bochs-display.c                    |  2 +-
 hw/display/cg3.c                              |  2 +-
 hw/display/cirrus_vga.c                       |  2 +-
 hw/display/cirrus_vga_isa.c                   |  2 +-
 hw/display/dm163.c                            |  2 +-
 hw/display/dpcd.c                             |  2 +-
 hw/display/exynos4210_fimd.c                  |  2 +-
 hw/display/g364fb.c                           |  2 +-
 hw/display/i2c-ddc.c                          |  2 +-
 hw/display/jazz_led.c                         |  2 +-
 hw/display/macfb.c                            |  4 +-
 hw/display/next-fb.c                          |  2 +-
 hw/display/pl110.c                            |  2 +-
 hw/display/qxl.c                              |  6 +-
 hw/display/ramfb-standalone.c                 |  2 +-
 hw/display/sii9022.c                          |  2 +-
 hw/display/sm501.c                            |  4 +-
 hw/display/ssd0303.c                          |  2 +-
 hw/display/ssd0323.c                          |  2 +-
 hw/display/tcx.c                              |  2 +-
 hw/display/vga-isa.c                          |  2 +-
 hw/display/vga-mmio.c                         |  2 +-
 hw/display/vga-pci.c                          |  6 +-
 hw/display/vhost-user-gpu.c                   |  2 +-
 hw/display/virtio-gpu-base.c                  |  2 +-
 hw/display/virtio-gpu-gl.c                    |  2 +-
 hw/display/virtio-gpu-pci.c                   |  2 +-
 hw/display/virtio-gpu-rutabaga.c              |  2 +-
 hw/display/virtio-gpu.c                       |  2 +-
 hw/display/virtio-vga.c                       |  2 +-
 hw/display/vmware_vga.c                       |  2 +-
 hw/display/xlnx_dp.c                          |  2 +-
 hw/dma/bcm2835_dma.c                          |  2 +-
 hw/dma/i82374.c                               |  2 +-
 hw/dma/i8257.c                                |  2 +-
 hw/dma/pl080.c                                |  2 +-
 hw/dma/pl330.c                                |  2 +-
 hw/dma/rc4030.c                               |  4 +-
 hw/dma/sifive_pdma.c                          |  2 +-
 hw/dma/sparc32_dma.c                          | 10 ++-
 hw/dma/xilinx_axidma.c                        |  5 +-
 hw/dma/xlnx-zdma.c                            |  2 +-
 hw/dma/xlnx-zynq-devcfg.c                     |  2 +-
 hw/dma/xlnx_csu_dma.c                         |  2 +-
 hw/dma/xlnx_dpdma.c                           |  2 +-
 hw/fsi/aspeed_apb2opb.c                       |  2 +-
 hw/fsi/cfam.c                                 |  2 +-
 hw/fsi/fsi-master.c                           |  2 +-
 hw/fsi/fsi.c                                  |  2 +-
 hw/fsi/lbus.c                                 |  2 +-
 hw/gpio/aspeed_gpio.c                         | 16 ++--
 hw/gpio/bcm2835_gpio.c                        |  2 +-
 hw/gpio/bcm2838_gpio.c                        |  2 +-
 hw/gpio/gpio_key.c                            |  2 +-
 hw/gpio/imx_gpio.c                            |  2 +-
 hw/gpio/mpc8xxx.c                             |  2 +-
 hw/gpio/npcm7xx_gpio.c                        |  2 +-
 hw/gpio/nrf51_gpio.c                          |  2 +-
 hw/gpio/omap_gpio.c                           |  2 +-
 hw/gpio/pca9552.c                             |  4 +-
 hw/gpio/pca9554.c                             |  2 +-
 hw/gpio/pcf8574.c                             |  2 +-
 hw/gpio/pl061.c                               |  2 +-
 hw/gpio/sifive_gpio.c                         |  2 +-
 hw/gpio/stm32l4x5_gpio.c                      |  2 +-
 hw/gpio/zaurus.c                              |  2 +-
 hw/hppa/machine.c                             |  4 +-
 hw/hyperv/hv-balloon.c                        |  2 +-
 hw/hyperv/hyperv.c                            |  2 +-
 hw/hyperv/hyperv_testdev.c                    |  2 +-
 hw/hyperv/syndbg.c                            |  2 +-
 hw/hyperv/vmbus.c                             |  6 +-
 hw/i2c/allwinner-i2c.c                        |  2 +-
 hw/i2c/aspeed_i2c.c                           | 17 ++--
 hw/i2c/bcm2835_i2c.c                          |  2 +-
 hw/i2c/bitbang_i2c.c                          |  2 +-
 hw/i2c/core.c                                 |  2 +-
 hw/i2c/exynos4210_i2c.c                       |  2 +-
 hw/i2c/i2c_mux_pca954x.c                      |  6 +-
 hw/i2c/imx_i2c.c                              |  2 +-
 hw/i2c/microbit_i2c.c                         |  2 +-
 hw/i2c/mpc_i2c.c                              |  2 +-
 hw/i2c/npcm7xx_smbus.c                        |  2 +-
 hw/i2c/omap_i2c.c                             |  2 +-
 hw/i2c/pmbus_device.c                         |  2 +-
 hw/i2c/ppc4xx_i2c.c                           |  2 +-
 hw/i2c/smbus_eeprom.c                         |  2 +-
 hw/i2c/smbus_ich9.c                           |  2 +-
 hw/i2c/smbus_slave.c                          |  2 +-
 hw/i386/amd_iommu.c                           |  7 +-
 hw/i386/intel_iommu.c                         |  4 +-
 hw/i386/kvm/apic.c                            |  2 +-
 hw/i386/kvm/clock.c                           |  2 +-
 hw/i386/kvm/i8254.c                           |  2 +-
 hw/i386/kvm/i8259.c                           |  2 +-
 hw/i386/kvm/ioapic.c                          |  2 +-
 hw/i386/kvm/xen_evtchn.c                      |  2 +-
 hw/i386/kvm/xen_gnttab.c                      |  2 +-
 hw/i386/kvm/xen_overlay.c                     |  2 +-
 hw/i386/kvm/xen_primary_console.c             |  2 +-
 hw/i386/kvm/xen_xenstore.c                    |  2 +-
 hw/i386/microvm.c                             |  2 +-
 hw/i386/nitro_enclave.c                       |  2 +-
 hw/i386/pc.c                                  |  2 +-
 hw/i386/port92.c                              |  2 +-
 hw/i386/sgx-epc.c                             |  2 +-
 hw/i386/vapic.c                               |  2 +-
 hw/i386/vmmouse.c                             |  2 +-
 hw/i386/vmport.c                              |  2 +-
 hw/i386/x86-iommu.c                           |  2 +-
 hw/i386/x86.c                                 |  2 +-
 hw/i386/xen/xen-pvh.c                         |  2 +-
 hw/i386/xen/xen_apic.c                        |  2 +-
 hw/i386/xen/xen_platform.c                    |  2 +-
 hw/i386/xen/xen_pvdevice.c                    |  2 +-
 hw/ide/ahci-allwinner.c                       |  2 +-
 hw/ide/ahci-sysbus.c                          |  2 +-
 hw/ide/cf.c                                   |  2 +-
 hw/ide/cmd646.c                               |  2 +-
 hw/ide/ich.c                                  |  2 +-
 hw/ide/ide-bus.c                              |  2 +-
 hw/ide/ide-dev.c                              |  6 +-
 hw/ide/isa.c                                  |  2 +-
 hw/ide/macio.c                                |  2 +-
 hw/ide/mmio.c                                 |  2 +-
 hw/ide/piix.c                                 |  4 +-
 hw/ide/sii3112.c                              |  2 +-
 hw/ide/via.c                                  |  2 +-
 hw/input/adb-kbd.c                            |  2 +-
 hw/input/adb-mouse.c                          |  2 +-
 hw/input/adb.c                                |  4 +-
 hw/input/lasips2.c                            |  8 +-
 hw/input/pckbd.c                              |  4 +-
 hw/input/pl050.c                              |  6 +-
 hw/input/ps2.c                                |  6 +-
 hw/input/stellaris_gamepad.c                  |  2 +-
 hw/input/virtio-input-hid.c                   |  6 +-
 hw/input/virtio-input-host.c                  |  2 +-
 hw/input/virtio-input.c                       |  2 +-
 hw/intc/allwinner-a10-pic.c                   |  2 +-
 hw/intc/apic.c                                |  2 +-
 hw/intc/apic_common.c                         |  2 +-
 hw/intc/arm_gic.c                             |  2 +-
 hw/intc/arm_gic_common.c                      |  2 +-
 hw/intc/arm_gic_kvm.c                         |  2 +-
 hw/intc/arm_gicv2m.c                          |  2 +-
 hw/intc/arm_gicv3.c                           |  2 +-
 hw/intc/arm_gicv3_common.c                    |  2 +-
 hw/intc/arm_gicv3_its.c                       |  2 +-
 hw/intc/arm_gicv3_its_common.c                |  2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |  2 +-
 hw/intc/arm_gicv3_kvm.c                       |  2 +-
 hw/intc/armv7m_nvic.c                         |  2 +-
 hw/intc/aspeed_intc.c                         |  4 +-
 hw/intc/aspeed_vic.c                          |  2 +-
 hw/intc/bcm2835_ic.c                          |  2 +-
 hw/intc/bcm2836_control.c                     |  2 +-
 hw/intc/exynos4210_combiner.c                 |  2 +-
 hw/intc/exynos4210_gic.c                      |  2 +-
 hw/intc/goldfish_pic.c                        |  2 +-
 hw/intc/grlib_irqmp.c                         |  2 +-
 hw/intc/heathrow_pic.c                        |  2 +-
 hw/intc/i8259.c                               |  2 +-
 hw/intc/i8259_common.c                        |  2 +-
 hw/intc/imx_avic.c                            |  2 +-
 hw/intc/imx_gpcv2.c                           |  2 +-
 hw/intc/ioapic.c                              |  2 +-
 hw/intc/ioapic_common.c                       |  2 +-
 hw/intc/loongarch_extioi.c                    |  2 +-
 hw/intc/loongarch_extioi_common.c             |  3 +-
 hw/intc/loongarch_ipi.c                       |  2 +-
 hw/intc/loongarch_pch_msi.c                   |  2 +-
 hw/intc/loongarch_pch_pic.c                   |  2 +-
 hw/intc/loongarch_pic_common.c                |  3 +-
 hw/intc/loongson_ipi.c                        |  2 +-
 hw/intc/loongson_ipi_common.c                 |  2 +-
 hw/intc/m68k_irqc.c                           |  2 +-
 hw/intc/mips_gic.c                            |  2 +-
 hw/intc/omap_intc.c                           |  2 +-
 hw/intc/ompic.c                               |  2 +-
 hw/intc/openpic.c                             |  2 +-
 hw/intc/openpic_kvm.c                         |  2 +-
 hw/intc/pl190.c                               |  2 +-
 hw/intc/pnv_xive.c                            |  2 +-
 hw/intc/pnv_xive2.c                           |  2 +-
 hw/intc/ppc-uic.c                             |  2 +-
 hw/intc/realview_gic.c                        |  2 +-
 hw/intc/riscv_aclint.c                        |  4 +-
 hw/intc/riscv_aplic.c                         |  2 +-
 hw/intc/riscv_imsic.c                         |  2 +-
 hw/intc/rx_icu.c                              |  2 +-
 hw/intc/s390_flic.c                           |  4 +-
 hw/intc/s390_flic_kvm.c                       |  2 +-
 hw/intc/sifive_plic.c                         |  2 +-
 hw/intc/slavio_intctl.c                       |  2 +-
 hw/intc/spapr_xive.c                          |  2 +-
 hw/intc/xics.c                                |  4 +-
 hw/intc/xics_pnv.c                            |  2 +-
 hw/intc/xics_spapr.c                          |  2 +-
 hw/intc/xilinx_intc.c                         |  2 +-
 hw/intc/xive.c                                |  8 +-
 hw/intc/xive2.c                               |  4 +-
 hw/intc/xlnx-pmu-iomod-intc.c                 |  2 +-
 hw/intc/xlnx-zynqmp-ipi.c                     |  2 +-
 hw/ipack/ipack.c                              |  2 +-
 hw/ipack/tpci200.c                            |  2 +-
 hw/ipmi/ipmi.c                                |  4 +-
 hw/ipmi/ipmi_bmc_extern.c                     |  2 +-
 hw/ipmi/ipmi_bmc_sim.c                        |  2 +-
 hw/ipmi/isa_ipmi_bt.c                         |  2 +-
 hw/ipmi/isa_ipmi_kcs.c                        |  2 +-
 hw/ipmi/pci_ipmi_bt.c                         |  2 +-
 hw/ipmi/pci_ipmi_kcs.c                        |  2 +-
 hw/ipmi/smbus_ipmi.c                          |  2 +-
 hw/isa/fdc37m81x-superio.c                    |  2 +-
 hw/isa/i82378.c                               |  2 +-
 hw/isa/isa-bus.c                              |  6 +-
 hw/isa/isa-superio.c                          |  2 +-
 hw/isa/lpc_ich9.c                             |  2 +-
 hw/isa/pc87312.c                              |  2 +-
 hw/isa/piix.c                                 |  6 +-
 hw/isa/smc37c669-superio.c                    |  2 +-
 hw/isa/vt82c686.c                             | 12 +--
 hw/loongarch/virt.c                           |  2 +-
 hw/m68k/mcf5206.c                             |  2 +-
 hw/m68k/mcf_intc.c                            |  2 +-
 hw/m68k/next-cube.c                           |  8 +-
 hw/m68k/next-kbd.c                            |  2 +-
 hw/m68k/q800-glue.c                           |  2 +-
 hw/m68k/q800.c                                |  2 +-
 hw/m68k/virt.c                                |  4 +-
 hw/mem/cxl_type3.c                            |  2 +-
 hw/mem/npcm7xx_mc.c                           |  2 +-
 hw/mem/nvdimm.c                               |  2 +-
 hw/mem/pc-dimm.c                              |  2 +-
 hw/mem/sparse-mem.c                           |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  3 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |  2 +-
 hw/mips/cps.c                                 |  2 +-
 hw/mips/jazz.c                                |  4 +-
 hw/mips/loongson3_virt.c                      |  2 +-
 hw/misc/a9scu.c                               |  2 +-
 hw/misc/allwinner-a10-ccm.c                   |  2 +-
 hw/misc/allwinner-a10-dramc.c                 |  2 +-
 hw/misc/allwinner-cpucfg.c                    |  2 +-
 hw/misc/allwinner-h3-ccu.c                    |  2 +-
 hw/misc/allwinner-h3-dramc.c                  |  2 +-
 hw/misc/allwinner-h3-sysctrl.c                |  3 +-
 hw/misc/allwinner-r40-ccu.c                   |  2 +-
 hw/misc/allwinner-r40-dramc.c                 |  2 +-
 hw/misc/allwinner-sid.c                       |  2 +-
 hw/misc/allwinner-sramc.c                     |  4 +-
 hw/misc/applesmc.c                            |  2 +-
 hw/misc/arm11scu.c                            |  2 +-
 hw/misc/arm_l2x0.c                            |  2 +-
 hw/misc/arm_sysctl.c                          |  2 +-
 hw/misc/armsse-cpu-pwrctrl.c                  |  2 +-
 hw/misc/armsse-cpuid.c                        |  2 +-
 hw/misc/armsse-mhu.c                          |  2 +-
 hw/misc/armv7m_ras.c                          |  2 +-
 hw/misc/aspeed_hace.c                         | 10 +--
 hw/misc/aspeed_i3c.c                          |  4 +-
 hw/misc/aspeed_lpc.c                          |  2 +-
 hw/misc/aspeed_peci.c                         |  2 +-
 hw/misc/aspeed_sbc.c                          |  4 +-
 hw/misc/aspeed_scu.c                          | 14 +--
 hw/misc/aspeed_sdmc.c                         | 10 +--
 hw/misc/aspeed_sli.c                          |  6 +-
 hw/misc/aspeed_xdma.c                         |  8 +-
 hw/misc/auxbus.c                              |  6 +-
 hw/misc/avr_power.c                           |  2 +-
 hw/misc/axp2xx.c                              |  6 +-
 hw/misc/bcm2835_cprman.c                      | 10 +--
 hw/misc/bcm2835_mbox.c                        |  2 +-
 hw/misc/bcm2835_mphi.c                        |  2 +-
 hw/misc/bcm2835_powermgt.c                    |  2 +-
 hw/misc/bcm2835_property.c                    |  2 +-
 hw/misc/bcm2835_rng.c                         |  2 +-
 hw/misc/bcm2835_thermal.c                     |  2 +-
 hw/misc/debugexit.c                           |  2 +-
 hw/misc/djmemc.c                              |  2 +-
 hw/misc/eccmemctl.c                           |  2 +-
 hw/misc/edu.c                                 |  2 +-
 hw/misc/empty_slot.c                          |  2 +-
 hw/misc/exynos4210_clk.c                      |  2 +-
 hw/misc/exynos4210_pmu.c                      |  2 +-
 hw/misc/exynos4210_rng.c                      |  2 +-
 hw/misc/grlib_ahb_apb_pnp.c                   |  4 +-
 hw/misc/i2c-echo.c                            |  2 +-
 hw/misc/imx25_ccm.c                           |  2 +-
 hw/misc/imx31_ccm.c                           |  2 +-
 hw/misc/imx6_ccm.c                            |  2 +-
 hw/misc/imx6_src.c                            |  2 +-
 hw/misc/imx6ul_ccm.c                          |  2 +-
 hw/misc/imx7_ccm.c                            |  4 +-
 hw/misc/imx7_gpr.c                            |  2 +-
 hw/misc/imx7_snvs.c                           |  2 +-
 hw/misc/imx7_src.c                            |  2 +-
 hw/misc/imx_rngc.c                            |  2 +-
 hw/misc/iosb.c                                |  2 +-
 hw/misc/iotkit-secctl.c                       |  2 +-
 hw/misc/iotkit-sysctl.c                       |  2 +-
 hw/misc/iotkit-sysinfo.c                      |  2 +-
 hw/misc/ivshmem-flat.c                        |  2 +-
 hw/misc/ivshmem-pci.c                         |  6 +-
 hw/misc/lasi.c                                |  2 +-
 hw/misc/led.c                                 |  2 +-
 hw/misc/mac_via.c                             |  4 +-
 hw/misc/macio/cuda.c                          |  4 +-
 hw/misc/macio/gpio.c                          |  2 +-
 hw/misc/macio/mac_dbdma.c                     |  2 +-
 hw/misc/macio/macio.c                         |  6 +-
 hw/misc/macio/pmu.c                           |  4 +-
 hw/misc/mchp_pfsoc_dmc.c                      |  5 +-
 hw/misc/mchp_pfsoc_ioscb.c                    |  2 +-
 hw/misc/mchp_pfsoc_sysreg.c                   |  2 +-
 hw/misc/mips_cmgcr.c                          |  2 +-
 hw/misc/mips_cpc.c                            |  2 +-
 hw/misc/mips_itu.c                            |  2 +-
 hw/misc/mos6522.c                             |  2 +-
 hw/misc/mps2-fpgaio.c                         |  2 +-
 hw/misc/mps2-scc.c                            |  2 +-
 hw/misc/msf2-sysreg.c                         |  2 +-
 hw/misc/npcm7xx_clk.c                         |  8 +-
 hw/misc/npcm7xx_gcr.c                         |  2 +-
 hw/misc/npcm7xx_mft.c                         |  2 +-
 hw/misc/npcm7xx_pwm.c                         |  2 +-
 hw/misc/npcm7xx_rng.c                         |  2 +-
 hw/misc/nrf51_rng.c                           |  2 +-
 hw/misc/pc-testdev.c                          |  2 +-
 hw/misc/pci-testdev.c                         |  2 +-
 hw/misc/pvpanic-isa.c                         |  2 +-
 hw/misc/pvpanic-pci.c                         |  2 +-
 hw/misc/sbsa_ec.c                             |  2 +-
 hw/misc/sifive_e_aon.c                        |  2 +-
 hw/misc/sifive_u_otp.c                        |  2 +-
 hw/misc/sifive_u_prci.c                       |  2 +-
 hw/misc/slavio_misc.c                         |  2 +-
 hw/misc/stm32_rcc.c                           |  2 +-
 hw/misc/stm32f2xx_syscfg.c                    |  2 +-
 hw/misc/stm32f4xx_exti.c                      |  2 +-
 hw/misc/stm32f4xx_syscfg.c                    |  2 +-
 hw/misc/stm32l4x5_exti.c                      |  2 +-
 hw/misc/stm32l4x5_rcc.c                       |  6 +-
 hw/misc/stm32l4x5_syscfg.c                    |  2 +-
 hw/misc/tz-mpc.c                              |  4 +-
 hw/misc/tz-msc.c                              |  2 +-
 hw/misc/tz-ppc.c                              |  2 +-
 hw/misc/unimp.c                               |  2 +-
 hw/misc/virt_ctrl.c                           |  2 +-
 hw/misc/vmcoreinfo.c                          |  2 +-
 hw/misc/xlnx-versal-cframe-reg.c              |  4 +-
 hw/misc/xlnx-versal-cfu.c                     |  6 +-
 hw/misc/xlnx-versal-crl.c                     |  2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c            |  3 +-
 hw/misc/xlnx-versal-trng.c                    |  2 +-
 hw/misc/xlnx-versal-xramc.c                   |  2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c                |  2 +-
 hw/misc/xlnx-zynqmp-crf.c                     |  2 +-
 hw/misc/zynq_slcr.c                           |  2 +-
 hw/net/allwinner-sun8i-emac.c                 |  3 +-
 hw/net/allwinner_emac.c                       |  2 +-
 hw/net/cadence_gem.c                          |  2 +-
 hw/net/can/can_kvaser_pci.c                   |  2 +-
 hw/net/can/can_mioe3680_pci.c                 |  2 +-
 hw/net/can/can_pcm3680_pci.c                  |  2 +-
 hw/net/can/ctucan_pci.c                       |  2 +-
 hw/net/can/xlnx-versal-canfd.c                |  2 +-
 hw/net/can/xlnx-zynqmp-can.c                  |  2 +-
 hw/net/dp8393x.c                              |  2 +-
 hw/net/e1000.c                                |  2 +-
 hw/net/e1000e.c                               |  2 +-
 hw/net/eepro100.c                             |  2 +-
 hw/net/fsl_etsec/etsec.c                      |  2 +-
 hw/net/ftgmac100.c                            |  4 +-
 hw/net/igb.c                                  |  2 +-
 hw/net/igbvf.c                                |  2 +-
 hw/net/imx_fec.c                              |  2 +-
 hw/net/lan9118.c                              |  2 +-
 hw/net/lan9118_phy.c                          |  2 +-
 hw/net/lance.c                                |  2 +-
 hw/net/lasi_i82596.c                          |  2 +-
 hw/net/mcf_fec.c                              |  2 +-
 hw/net/mipsnet.c                              |  2 +-
 hw/net/msf2-emac.c                            |  2 +-
 hw/net/mv88w8618_eth.c                        |  2 +-
 hw/net/ne2000-isa.c                           |  2 +-
 hw/net/ne2000-pci.c                           |  2 +-
 hw/net/npcm7xx_emc.c                          |  2 +-
 hw/net/npcm_gmac.c                            |  2 +-
 hw/net/opencores_eth.c                        |  2 +-
 hw/net/pcnet-pci.c                            |  2 +-
 hw/net/rocker/rocker.c                        |  2 +-
 hw/net/rtl8139.c                              |  2 +-
 hw/net/smc91c111.c                            |  2 +-
 hw/net/spapr_llan.c                           |  2 +-
 hw/net/stellaris_enet.c                       |  2 +-
 hw/net/sungem.c                               |  2 +-
 hw/net/sunhme.c                               |  2 +-
 hw/net/tulip.c                                |  2 +-
 hw/net/virtio-net.c                           |  2 +-
 hw/net/vmxnet3.c                              |  2 +-
 hw/net/xen_nic.c                              |  2 +-
 hw/net/xgmac.c                                |  2 +-
 hw/net/xilinx_axienet.c                       |  7 +-
 hw/net/xilinx_ethlite.c                       |  2 +-
 hw/nubus/mac-nubus-bridge.c                   |  2 +-
 hw/nubus/nubus-bridge.c                       |  2 +-
 hw/nubus/nubus-bus.c                          |  2 +-
 hw/nubus/nubus-device.c                       |  2 +-
 hw/nubus/nubus-virtio-mmio.c                  |  2 +-
 hw/nvme/ctrl.c                                |  2 +-
 hw/nvme/ns.c                                  |  2 +-
 hw/nvme/subsys.c                              |  2 +-
 hw/nvram/bcm2835_otp.c                        |  2 +-
 hw/nvram/ds1225y.c                            |  2 +-
 hw/nvram/eeprom_at24c.c                       |  2 +-
 hw/nvram/fw_cfg.c                             |  6 +-
 hw/nvram/mac_nvram.c                          |  2 +-
 hw/nvram/npcm7xx_otp.c                        |  6 +-
 hw/nvram/nrf51_nvm.c                          |  2 +-
 hw/nvram/spapr_nvram.c                        |  2 +-
 hw/nvram/xlnx-bbram.c                         |  2 +-
 hw/nvram/xlnx-efuse.c                         |  2 +-
 hw/nvram/xlnx-versal-efuse-cache.c            |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c             |  2 +-
 hw/nvram/xlnx-zynqmp-efuse.c                  |  2 +-
 hw/openrisc/openrisc_sim.c                    |  2 +-
 hw/openrisc/virt.c                            |  2 +-
 hw/pci-bridge/cxl_downstream.c                |  2 +-
 hw/pci-bridge/cxl_root_port.c                 |  2 +-
 hw/pci-bridge/cxl_upstream.c                  |  2 +-
 hw/pci-bridge/gen_pcie_root_port.c            |  2 +-
 hw/pci-bridge/i82801b11.c                     |  2 +-
 hw/pci-bridge/ioh3420.c                       |  2 +-
 hw/pci-bridge/pci_bridge_dev.c                |  4 +-
 hw/pci-bridge/pci_expander_bridge.c           | 12 +--
 hw/pci-bridge/pcie_pci_bridge.c               |  2 +-
 hw/pci-bridge/pcie_root_port.c                |  2 +-
 hw/pci-bridge/simba.c                         |  2 +-
 hw/pci-bridge/xio3130_downstream.c            |  2 +-
 hw/pci-bridge/xio3130_upstream.c              |  2 +-
 hw/pci-host/articia.c                         |  6 +-
 hw/pci-host/astro.c                           |  6 +-
 hw/pci-host/bonito.c                          |  4 +-
 hw/pci-host/designware.c                      |  6 +-
 hw/pci-host/dino.c                            |  2 +-
 hw/pci-host/gpex.c                            |  4 +-
 hw/pci-host/grackle.c                         |  4 +-
 hw/pci-host/gt64120.c                         |  4 +-
 hw/pci-host/i440fx.c                          |  4 +-
 hw/pci-host/mv64361.c                         |  6 +-
 hw/pci-host/pnv_phb.c                         |  4 +-
 hw/pci-host/pnv_phb3.c                        |  6 +-
 hw/pci-host/pnv_phb3_msi.c                    |  2 +-
 hw/pci-host/pnv_phb3_pbcq.c                   |  2 +-
 hw/pci-host/pnv_phb4.c                        |  6 +-
 hw/pci-host/pnv_phb4_pec.c                    |  4 +-
 hw/pci-host/ppc440_pcix.c                     |  2 +-
 hw/pci-host/ppc4xx_pci.c                      |  4 +-
 hw/pci-host/ppce500.c                         |  4 +-
 hw/pci-host/q35.c                             |  4 +-
 hw/pci-host/raven.c                           |  4 +-
 hw/pci-host/remote.c                          |  2 +-
 hw/pci-host/sabre.c                           |  4 +-
 hw/pci-host/sh_pci.c                          |  4 +-
 hw/pci-host/uninorth.c                        | 19 ++--
 hw/pci-host/versatile.c                       |  4 +-
 hw/pci-host/xen_igd_pt.c                      |  3 +-
 hw/pci-host/xilinx-pcie.c                     |  4 +-
 hw/pci/pci.c                                  |  6 +-
 hw/pci/pci_bridge.c                           |  2 +-
 hw/pci/pci_host.c                             |  2 +-
 hw/pci/pcie_port.c                            |  4 +-
 hw/ppc/e500plat.c                             |  2 +-
 hw/ppc/mac_newworld.c                         |  2 +-
 hw/ppc/mac_oldworld.c                         |  2 +-
 hw/ppc/mpc8544ds.c                            |  2 +-
 hw/ppc/pef.c                                  |  2 +-
 hw/ppc/pegasos2.c                             |  2 +-
 hw/ppc/pnv.c                                  | 25 +++---
 hw/ppc/pnv_adu.c                              |  2 +-
 hw/ppc/pnv_chiptod.c                          |  6 +-
 hw/ppc/pnv_core.c                             | 14 +--
 hw/ppc/pnv_homer.c                            |  8 +-
 hw/ppc/pnv_i2c.c                              |  2 +-
 hw/ppc/pnv_lpc.c                              |  8 +-
 hw/ppc/pnv_n1_chiplet.c                       |  2 +-
 hw/ppc/pnv_nest_pervasive.c                   |  2 +-
 hw/ppc/pnv_occ.c                              |  8 +-
 hw/ppc/pnv_pnor.c                             |  2 +-
 hw/ppc/pnv_psi.c                              |  8 +-
 hw/ppc/pnv_sbe.c                              |  6 +-
 hw/ppc/ppc405_boards.c                        |  6 +-
 hw/ppc/ppc405_uc.c                            | 16 ++--
 hw/ppc/ppc440_uc.c                            |  2 +-
 hw/ppc/ppc4xx_devs.c                          |  8 +-
 hw/ppc/ppc4xx_sdram.c                         |  4 +-
 hw/ppc/ppce500_spin.c                         |  2 +-
 hw/ppc/prep_systemio.c                        |  2 +-
 hw/ppc/rs6000_mc.c                            |  2 +-
 hw/ppc/spapr.c                                |  4 +-
 hw/ppc/spapr_cpu_core.c                       |  2 +-
 hw/ppc/spapr_drc.c                            | 16 ++--
 hw/ppc/spapr_iommu.c                          |  5 +-
 hw/ppc/spapr_nvdimm.c                         |  2 +-
 hw/ppc/spapr_pci.c                            |  2 +-
 hw/ppc/spapr_rng.c                            |  2 +-
 hw/ppc/spapr_rtc.c                            |  2 +-
 hw/ppc/spapr_tpm_proxy.c                      |  2 +-
 hw/ppc/spapr_vio.c                            |  6 +-
 hw/remote/machine.c                           |  2 +-
 hw/remote/proxy.c                             |  2 +-
 hw/remote/remote-obj.c                        |  2 +-
 hw/remote/vfio-user-obj.c                     |  2 +-
 hw/riscv/microchip_pfsoc.c                    |  5 +-
 hw/riscv/opentitan.c                          |  4 +-
 hw/riscv/riscv-iommu-pci.c                    |  2 +-
 hw/riscv/riscv-iommu-sys.c                    |  2 +-
 hw/riscv/riscv-iommu.c                        |  4 +-
 hw/riscv/riscv_hart.c                         |  2 +-
 hw/riscv/shakti_c.c                           |  4 +-
 hw/riscv/sifive_e.c                           |  4 +-
 hw/riscv/sifive_u.c                           |  4 +-
 hw/riscv/spike.c                              |  2 +-
 hw/riscv/virt.c                               |  2 +-
 hw/rtc/allwinner-rtc.c                        |  8 +-
 hw/rtc/aspeed_rtc.c                           |  2 +-
 hw/rtc/ds1338.c                               |  2 +-
 hw/rtc/exynos4210_rtc.c                       |  2 +-
 hw/rtc/goldfish_rtc.c                         |  2 +-
 hw/rtc/ls7a_rtc.c                             |  2 +-
 hw/rtc/m41t80.c                               |  2 +-
 hw/rtc/m48t59-isa.c                           |  4 +-
 hw/rtc/m48t59.c                               |  5 +-
 hw/rtc/mc146818rtc.c                          |  2 +-
 hw/rtc/pl031.c                                |  2 +-
 hw/rtc/sun4v-rtc.c                            |  2 +-
 hw/rtc/xlnx-zynqmp-rtc.c                      |  2 +-
 hw/rx/rx-gdbsim.c                             |  6 +-
 hw/rx/rx62n.c                                 |  6 +-
 hw/s390x/3270-ccw.c                           |  2 +-
 hw/s390x/ap-bridge.c                          |  4 +-
 hw/s390x/ap-device.c                          |  2 +-
 hw/s390x/ccw-device.c                         |  2 +-
 hw/s390x/css-bridge.c                         |  4 +-
 hw/s390x/event-facility.c                     |  4 +-
 hw/s390x/ipl.c                                |  2 +-
 hw/s390x/s390-ccw.c                           |  2 +-
 hw/s390x/s390-pci-bus.c                       |  7 +-
 hw/s390x/s390-skeys-kvm.c                     |  2 +-
 hw/s390x/s390-skeys.c                         |  4 +-
 hw/s390x/s390-stattrib-kvm.c                  |  2 +-
 hw/s390x/s390-stattrib.c                      |  4 +-
 hw/s390x/s390-virtio-ccw.c                    |  4 +-
 hw/s390x/sclp.c                               |  2 +-
 hw/s390x/sclpcpu.c                            |  2 +-
 hw/s390x/sclpquiesce.c                        |  2 +-
 hw/s390x/tod-kvm.c                            |  2 +-
 hw/s390x/tod-tcg.c                            |  2 +-
 hw/s390x/tod.c                                |  2 +-
 hw/s390x/vhost-scsi-ccw.c                     |  2 +-
 hw/s390x/vhost-user-fs-ccw.c                  |  2 +-
 hw/s390x/vhost-vsock-ccw.c                    |  2 +-
 hw/s390x/virtio-ccw-9p.c                      |  2 +-
 hw/s390x/virtio-ccw-balloon.c                 |  2 +-
 hw/s390x/virtio-ccw-blk.c                     |  2 +-
 hw/s390x/virtio-ccw-crypto.c                  |  2 +-
 hw/s390x/virtio-ccw-gpu.c                     |  2 +-
 hw/s390x/virtio-ccw-input.c                   |  2 +-
 hw/s390x/virtio-ccw-mem.c                     |  2 +-
 hw/s390x/virtio-ccw-net.c                     |  2 +-
 hw/s390x/virtio-ccw-rng.c                     |  2 +-
 hw/s390x/virtio-ccw-scsi.c                    |  2 +-
 hw/s390x/virtio-ccw-serial.c                  |  2 +-
 hw/s390x/virtio-ccw.c                         |  4 +-
 hw/scsi/esp-pci.c                             |  4 +-
 hw/scsi/esp.c                                 |  4 +-
 hw/scsi/lsi53c895a.c                          |  4 +-
 hw/scsi/megasas.c                             |  2 +-
 hw/scsi/mptsas.c                              |  2 +-
 hw/scsi/scsi-bus.c                            |  4 +-
 hw/scsi/scsi-disk.c                           |  8 +-
 hw/scsi/scsi-generic.c                        |  2 +-
 hw/scsi/spapr_vscsi.c                         |  2 +-
 hw/scsi/vhost-scsi.c                          |  2 +-
 hw/scsi/vhost-user-scsi.c                     |  2 +-
 hw/scsi/virtio-scsi.c                         |  4 +-
 hw/scsi/vmw_pvscsi.c                          |  2 +-
 hw/sd/allwinner-sdhost.c                      | 15 ++--
 hw/sd/aspeed_sdhci.c                          | 10 +--
 hw/sd/bcm2835_sdhost.c                        |  2 +-
 hw/sd/cadence_sdhci.c                         |  2 +-
 hw/sd/npcm7xx_sdhci.c                         |  2 +-
 hw/sd/omap_mmc.c                              |  2 +-
 hw/sd/pl181.c                                 |  4 +-
 hw/sd/sd.c                                    |  8 +-
 hw/sd/sdhci-pci.c                             |  2 +-
 hw/sd/sdhci.c                                 |  4 +-
 hw/sd/ssi-sd.c                                |  2 +-
 hw/sensor/adm1266.c                           |  2 +-
 hw/sensor/adm1272.c                           |  2 +-
 hw/sensor/dps310.c                            |  2 +-
 hw/sensor/emc141x.c                           |  4 +-
 hw/sensor/isl_pmbus_vr.c                      |  8 +-
 hw/sensor/lsm303dlhc_mag.c                    |  2 +-
 hw/sensor/max31785.c                          |  2 +-
 hw/sensor/max34451.c                          |  2 +-
 hw/sensor/tmp105.c                            |  2 +-
 hw/sensor/tmp421.c                            |  2 +-
 hw/sparc/sun4m.c                              | 28 +++---
 hw/sparc/sun4m_iommu.c                        |  5 +-
 hw/sparc64/niagara.c                          |  2 +-
 hw/sparc64/sun4u.c                            | 12 +--
 hw/sparc64/sun4u_iommu.c                      |  5 +-
 hw/ssi/allwinner-a10-spi.c                    |  2 +-
 hw/ssi/aspeed_smc.c                           | 36 ++++----
 hw/ssi/bcm2835_spi.c                          |  2 +-
 hw/ssi/ibex_spi_host.c                        |  2 +-
 hw/ssi/imx_spi.c                              |  2 +-
 hw/ssi/mss-spi.c                              |  2 +-
 hw/ssi/npcm7xx_fiu.c                          |  2 +-
 hw/ssi/npcm_pspi.c                            |  2 +-
 hw/ssi/pl022.c                                |  2 +-
 hw/ssi/pnv_spi.c                              |  2 +-
 hw/ssi/sifive_spi.c                           |  2 +-
 hw/ssi/ssi.c                                  |  4 +-
 hw/ssi/stm32f2xx_spi.c                        |  2 +-
 hw/ssi/xilinx_spi.c                           |  2 +-
 hw/ssi/xilinx_spips.c                         |  6 +-
 hw/ssi/xlnx-versal-ospi.c                     |  2 +-
 hw/timer/a9gtimer.c                           |  2 +-
 hw/timer/allwinner-a10-pit.c                  |  2 +-
 hw/timer/arm_mptimer.c                        |  2 +-
 hw/timer/arm_timer.c                          |  2 +-
 hw/timer/armv7m_systick.c                     |  2 +-
 hw/timer/aspeed_timer.c                       | 12 +--
 hw/timer/avr_timer16.c                        |  2 +-
 hw/timer/bcm2835_systmr.c                     |  2 +-
 hw/timer/cadence_ttc.c                        |  2 +-
 hw/timer/cmsdk-apb-dualtimer.c                |  2 +-
 hw/timer/cmsdk-apb-timer.c                    |  2 +-
 hw/timer/digic-timer.c                        |  2 +-
 hw/timer/exynos4210_mct.c                     |  2 +-
 hw/timer/exynos4210_pwm.c                     |  2 +-
 hw/timer/grlib_gptimer.c                      |  2 +-
 hw/timer/hpet.c                               |  2 +-
 hw/timer/i8254.c                              |  2 +-
 hw/timer/i8254_common.c                       |  2 +-
 hw/timer/ibex_timer.c                         |  2 +-
 hw/timer/imx_epit.c                           |  2 +-
 hw/timer/imx_gpt.c                            |  2 +-
 hw/timer/mss-timer.c                          |  2 +-
 hw/timer/npcm7xx_timer.c                      |  2 +-
 hw/timer/nrf51_timer.c                        |  2 +-
 hw/timer/pxa2xx_timer.c                       |  4 +-
 hw/timer/renesas_cmt.c                        |  2 +-
 hw/timer/renesas_tmr.c                        |  2 +-
 hw/timer/sifive_pwm.c                         |  2 +-
 hw/timer/slavio_timer.c                       |  2 +-
 hw/timer/sse-counter.c                        |  2 +-
 hw/timer/sse-timer.c                          |  2 +-
 hw/timer/stellaris-gptm.c                     |  2 +-
 hw/timer/stm32f2xx_timer.c                    |  2 +-
 hw/timer/xilinx_timer.c                       |  2 +-
 hw/tpm/tpm_crb.c                              |  2 +-
 hw/tpm/tpm_spapr.c                            |  2 +-
 hw/tpm/tpm_tis_i2c.c                          |  2 +-
 hw/tpm/tpm_tis_isa.c                          |  2 +-
 hw/tpm/tpm_tis_sysbus.c                       |  2 +-
 hw/tricore/tc27x_soc.c                        |  4 +-
 hw/tricore/triboard.c                         |  2 +-
 hw/tricore/tricore_testdevice.c               |  2 +-
 hw/ufs/lu.c                                   |  2 +-
 hw/ufs/ufs.c                                  |  4 +-
 hw/usb/bus.c                                  |  4 +-
 hw/usb/canokey.c                              |  2 +-
 hw/usb/ccid-card-emulated.c                   |  2 +-
 hw/usb/ccid-card-passthru.c                   |  2 +-
 hw/usb/chipidea.c                             |  2 +-
 hw/usb/dev-audio.c                            |  2 +-
 hw/usb/dev-hid.c                              |  8 +-
 hw/usb/dev-hub.c                              |  2 +-
 hw/usb/dev-mtp.c                              |  2 +-
 hw/usb/dev-network.c                          |  2 +-
 hw/usb/dev-serial.c                           |  6 +-
 hw/usb/dev-smartcard-reader.c                 |  4 +-
 hw/usb/dev-storage-bot.c                      |  2 +-
 hw/usb/dev-storage-classic.c                  |  2 +-
 hw/usb/dev-storage.c                          |  2 +-
 hw/usb/dev-uas.c                              |  2 +-
 hw/usb/dev-wacom.c                            |  2 +-
 hw/usb/hcd-dwc2.c                             |  2 +-
 hw/usb/hcd-dwc3.c                             |  2 +-
 hw/usb/hcd-ehci-pci.c                         |  4 +-
 hw/usb/hcd-ehci-sysbus.c                      | 16 ++--
 hw/usb/hcd-ohci-pci.c                         |  2 +-
 hw/usb/hcd-ohci-sysbus.c                      |  2 +-
 hw/usb/hcd-uhci.c                             |  4 +-
 hw/usb/hcd-xhci-nec.c                         |  2 +-
 hw/usb/hcd-xhci-pci.c                         |  4 +-
 hw/usb/hcd-xhci-sysbus.c                      |  2 +-
 hw/usb/hcd-xhci.c                             |  2 +-
 hw/usb/host-libusb.c                          |  2 +-
 hw/usb/imx-usb-phy.c                          |  2 +-
 hw/usb/redirect.c                             |  2 +-
 hw/usb/u2f-emulated.c                         |  2 +-
 hw/usb/u2f-passthru.c                         |  2 +-
 hw/usb/u2f.c                                  |  2 +-
 hw/usb/xlnx-usb-subsystem.c                   |  2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c           |  2 +-
 hw/vfio/amd-xgbe.c                            |  2 +-
 hw/vfio/ap.c                                  |  2 +-
 hw/vfio/calxeda-xgmac.c                       |  2 +-
 hw/vfio/ccw.c                                 |  2 +-
 hw/vfio/container.c                           |  4 +-
 hw/vfio/igd.c                                 |  3 +-
 hw/vfio/iommufd.c                             |  4 +-
 hw/vfio/pci.c                                 |  5 +-
 hw/vfio/platform.c                            |  2 +-
 hw/vfio/spapr.c                               |  2 +-
 hw/virtio/vdpa-dev-pci.c                      |  3 +-
 hw/virtio/vdpa-dev.c                          |  2 +-
 hw/virtio/vhost-scsi-pci.c                    |  2 +-
 hw/virtio/vhost-user-base.c                   |  2 +-
 hw/virtio/vhost-user-blk-pci.c                |  2 +-
 hw/virtio/vhost-user-device-pci.c             |  3 +-
 hw/virtio/vhost-user-device.c                 |  2 +-
 hw/virtio/vhost-user-fs-pci.c                 |  2 +-
 hw/virtio/vhost-user-fs.c                     |  2 +-
 hw/virtio/vhost-user-gpio-pci.c               |  2 +-
 hw/virtio/vhost-user-gpio.c                   |  2 +-
 hw/virtio/vhost-user-i2c-pci.c                |  2 +-
 hw/virtio/vhost-user-i2c.c                    |  2 +-
 hw/virtio/vhost-user-input.c                  |  2 +-
 hw/virtio/vhost-user-rng-pci.c                |  2 +-
 hw/virtio/vhost-user-rng.c                    |  2 +-
 hw/virtio/vhost-user-scmi-pci.c               |  2 +-
 hw/virtio/vhost-user-scmi.c                   |  2 +-
 hw/virtio/vhost-user-scsi-pci.c               |  2 +-
 hw/virtio/vhost-user-snd-pci.c                |  2 +-
 hw/virtio/vhost-user-snd.c                    |  2 +-
 hw/virtio/vhost-user-vsock-pci.c              |  3 +-
 hw/virtio/vhost-user-vsock.c                  |  2 +-
 hw/virtio/vhost-vsock-common.c                |  2 +-
 hw/virtio/vhost-vsock-pci.c                   |  2 +-
 hw/virtio/vhost-vsock.c                       |  2 +-
 hw/virtio/virtio-9p-pci.c                     |  2 +-
 hw/virtio/virtio-balloon-pci.c                |  2 +-
 hw/virtio/virtio-balloon.c                    |  2 +-
 hw/virtio/virtio-blk-pci.c                    |  2 +-
 hw/virtio/virtio-bus.c                        |  2 +-
 hw/virtio/virtio-crypto-pci.c                 |  2 +-
 hw/virtio/virtio-crypto.c                     |  2 +-
 hw/virtio/virtio-input-pci.c                  |  7 +-
 hw/virtio/virtio-iommu-pci.c                  |  2 +-
 hw/virtio/virtio-iommu.c                      |  4 +-
 hw/virtio/virtio-mem-pci.c                    |  2 +-
 hw/virtio/virtio-mem.c                        |  5 +-
 hw/virtio/virtio-mmio.c                       |  4 +-
 hw/virtio/virtio-net-pci.c                    |  2 +-
 hw/virtio/virtio-nsm-pci.c                    |  2 +-
 hw/virtio/virtio-nsm.c                        |  2 +-
 hw/virtio/virtio-pci.c                        |  8 +-
 hw/virtio/virtio-pmem-pci.c                   |  2 +-
 hw/virtio/virtio-pmem.c                       |  2 +-
 hw/virtio/virtio-rng-pci.c                    |  2 +-
 hw/virtio/virtio-rng.c                        |  2 +-
 hw/virtio/virtio-scsi-pci.c                   |  2 +-
 hw/virtio/virtio-serial-pci.c                 |  2 +-
 hw/virtio/virtio.c                            |  2 +-
 hw/watchdog/allwinner-wdt.c                   |  6 +-
 hw/watchdog/cmsdk-apb-watchdog.c              |  2 +-
 hw/watchdog/sbsa_gwdt.c                       |  2 +-
 hw/watchdog/spapr_watchdog.c                  |  2 +-
 hw/watchdog/wdt_aspeed.c                      | 12 +--
 hw/watchdog/wdt_diag288.c                     |  2 +-
 hw/watchdog/wdt_i6300esb.c                    |  2 +-
 hw/watchdog/wdt_ib700.c                       |  2 +-
 hw/watchdog/wdt_imx2.c                        |  2 +-
 hw/xen/xen-bus.c                              |  4 +-
 hw/xen/xen-legacy-backend.c                   |  4 +-
 hw/xen/xen-pvh-common.c                       |  2 +-
 hw/xen/xen_pt.c                               |  2 +-
 hw/xen/xen_pt_graphics.c                      |  2 +-
 hw/xtensa/xtfpga.c                            | 16 ++--
 io/channel-buffer.c                           |  2 +-
 io/channel-command.c                          |  2 +-
 io/channel-file.c                             |  2 +-
 io/channel-null.c                             |  2 +-
 io/channel-socket.c                           |  2 +-
 io/channel-tls.c                              |  2 +-
 io/channel-websock.c                          |  2 +-
 iothread.c                                    |  2 +-
 migration/channel-block.c                     |  2 +-
 migration/migration.c                         |  2 +-
 migration/rdma.c                              |  2 +-
 net/can/can_core.c                            |  2 +-
 net/can/can_host.c                            |  2 +-
 net/can/can_socketcan.c                       |  2 +-
 net/colo-compare.c                            |  2 +-
 net/dump.c                                    |  2 +-
 net/filter-buffer.c                           |  2 +-
 net/filter-mirror.c                           |  4 +-
 net/filter-replay.c                           |  2 +-
 net/filter-rewriter.c                         |  2 +-
 net/filter.c                                  |  2 +-
 qom/object.c                                  |  4 +-
 scsi/pr-manager-helper.c                      |  2 +-
 system/qtest.c                                |  2 +-
 target/alpha/cpu.c                            |  2 +-
 target/arm/cpu.c                              |  4 +-
 target/arm/cpu64.c                            |  4 +-
 target/arm/tcg/cpu-v7m.c                      |  2 +-
 target/avr/cpu.c                              |  2 +-
 target/hexagon/cpu.c                          |  2 +-
 target/hppa/cpu.c                             |  2 +-
 target/i386/confidential-guest.c              |  2 +-
 target/i386/cpu.c                             |  8 +-
 target/i386/host-cpu.c                        |  2 +-
 target/i386/hvf/hvf-cpu.c                     |  2 +-
 target/i386/kvm/kvm-cpu.c                     |  2 +-
 target/i386/nvmm/nvmm-accel-ops.c             |  2 +-
 target/i386/nvmm/nvmm-all.c                   |  2 +-
 target/i386/sev.c                             |  6 +-
 target/i386/tcg/tcg-cpu.c                     |  2 +-
 target/i386/whpx/whpx-accel-ops.c             |  2 +-
 target/i386/whpx/whpx-all.c                   |  2 +-
 target/i386/whpx/whpx-apic.c                  |  2 +-
 target/loongarch/cpu.c                        |  6 +-
 target/m68k/cpu.c                             |  6 +-
 target/microblaze/cpu.c                       |  2 +-
 target/mips/cpu.c                             |  4 +-
 target/openrisc/cpu.c                         |  2 +-
 target/ppc/cpu-models.c                       |  2 +-
 target/ppc/cpu_init.c                         | 90 +++++++++----------
 target/ppc/kvm.c                              |  4 +-
 target/riscv/cpu.c                            |  4 +-
 target/riscv/kvm/kvm-cpu.c                    |  2 +-
 target/riscv/tcg/tcg-cpu.c                    |  2 +-
 target/rx/cpu.c                               |  2 +-
 target/s390x/cpu.c                            |  2 +-
 target/s390x/cpu_models.c                     | 10 +--
 target/s390x/kvm/pv.c                         |  2 +-
 target/sh4/cpu.c                              |  8 +-
 target/sparc/cpu.c                            |  4 +-
 target/tricore/cpu.c                          |  2 +-
 target/xtensa/cpu.c                           |  2 +-
 target/xtensa/helper.c                        |  2 +-
 tests/unit/check-qom-interface.c              |  2 +-
 tests/unit/check-qom-proplist.c               |  6 +-
 tests/unit/test-qdev-global-props.c           |  8 +-
 tests/unit/test-smp-parse.c                   | 23 ++---
 ui/console-vc.c                               |  6 +-
 ui/console.c                                  |  4 +-
 ui/dbus-chardev.c                             |  2 +-
 ui/dbus.c                                     |  4 +-
 ui/gtk.c                                      |  2 +-
 ui/input-barrier.c                            |  2 +-
 ui/input-linux.c                              |  2 +-
 ui/spice-app.c                                |  2 +-
 ui/vdagent.c                                  |  2 +-
 util/main-loop.c                              |  2 +-
 util/thread-context.c                         |  2 +-
 hw/display/apple-gfx-mmio.m                   |  2 +-
 hw/display/apple-gfx-pci.m                    |  2 +-
 rust/qemu-api/src/qom.rs                      |  2 +-
 .../codeconverter/qom_type_info.py            |  3 +-
 1107 files changed, 1751 insertions(+), 1688 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 0889ca949c1..5870745ba27 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -147,7 +147,7 @@ to introduce an overridden virtual function:
 
    #include "qdev.h"
 
-   void my_device_class_init(ObjectClass *klass, void *class_data)
+   void my_device_class_init(ObjectClass *klass, const void *class_data)
    {
        DeviceClass *dc = DEVICE_CLASS(klass);
        dc->reset = my_device_reset;
@@ -249,7 +249,7 @@ class, which someone might choose to change at some point.
        // do something
    }
 
-   static void my_class_init(ObjectClass *oc, void *data)
+   static void my_class_init(ObjectClass *oc, const void *data)
    {
        MyClass *mc = MY_CLASS(oc);
 
@@ -279,7 +279,7 @@ class, which someone might choose to change at some point.
        // do something else here
    }
 
-   static void derived_class_init(ObjectClass *oc, void *data)
+   static void derived_class_init(ObjectClass *oc, const void *data)
    {
        MyClass *mc = MY_CLASS(oc);
        DerivedClass *dc = DERIVED_CLASS(oc);
@@ -363,7 +363,7 @@ This is equivalent to the following:
    :caption: Expansion from defining a simple type
 
    static void my_device_finalize(Object *obj);
-   static void my_device_class_init(ObjectClass *oc, void *data);
+   static void my_device_class_init(ObjectClass *oc, const void *data);
    static void my_device_init(Object *obj);
 
    static const TypeInfo my_device_info = {
diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index adefd59ef97..4dbbe4c7d62 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -211,7 +211,7 @@ in reset.
         ResettablePhases parent_phases;
     } MyDevClass;
 
-    static void mydev_class_init(ObjectClass *class, void *data)
+    static void mydev_class_init(ObjectClass *class, const void *data)
     {
         MyDevClass *myclass = MYDEV_CLASS(class);
         ResettableClass *rc = RESETTABLE_CLASS(class);
diff --git a/docs/devel/virtio-backends.rst b/docs/devel/virtio-backends.rst
index 679d7544b8e..ebddc3b9f51 100644
--- a/docs/devel/virtio-backends.rst
+++ b/docs/devel/virtio-backends.rst
@@ -119,7 +119,7 @@ manually instantiated:
       qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
   }
 
-  static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
+  static void virtio_blk_pci_class_init(ObjectClass *klass, const void *data)
   {
       DeviceClass *dc = DEVICE_CLASS(klass);
       VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h
index 6d26b94e929..14269336cac 100644
--- a/hw/usb/hcd-uhci.h
+++ b/hw/usb/hcd-uhci.h
@@ -88,7 +88,7 @@ typedef struct UHCIInfo {
     bool       notuser; /* disallow user_creatable */
 } UHCIInfo;
 
-void uhci_data_class_init(ObjectClass *klass, void *data);
+void uhci_data_class_init(ObjectClass *klass, const void *data);
 void usb_uhci_common_realize(PCIDevice *dev, Error **errp);
 
 #define TYPE_PIIX3_USB_UHCI "piix3-usb-uhci"
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e1f41b2a533..d038bd59575 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -742,7 +742,7 @@ struct MachineState {
     } while (0)
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
-    static void machine_initfn##_class_init(ObjectClass *oc, void *data) \
+    static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         machine_initfn(mc); \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f8..14e92c4229c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -303,7 +303,8 @@ extern GlobalProperty pc_compat_2_4[];
 extern const size_t pc_compat_2_4_len;
 
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
-    static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
+    static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
+                                                 const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         optsfn(mc); \
@@ -328,7 +329,7 @@ extern const size_t pc_compat_2_4_len;
     } \
     static void MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__)( \
         ObjectClass *oc, \
-        void *data) \
+        const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 971c5fabd44..567a9b0a9da 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -255,7 +255,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     size_t class_size;
     void (*instance_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
-    void (*class_init)(ObjectClass *klass, void *data);
+    void (*class_init)(ObjectClass *klass, const void *data);
     InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 7bb14ca7067..2fb86f00a68 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -280,7 +280,7 @@ struct Object
     static void \
     module_obj_name##_finalize(Object *obj); \
     static void \
-    module_obj_name##_class_init(ObjectClass *oc, void *data); \
+    module_obj_name##_class_init(ObjectClass *oc, const void *data); \
     static void \
     module_obj_name##_init(Object *obj); \
     \
@@ -486,7 +486,7 @@ struct TypeInfo
     bool abstract;
     size_t class_size;
 
-    void (*class_init)(ObjectClass *klass, void *data);
+    void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
     void *class_data;
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c2d2d99b462..e1011790192 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1120,7 +1120,7 @@ typedef struct ARMCPUInfo {
     const char *name;
     const char *deprecation_note;
     void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
+    void (*class_init)(ObjectClass *oc, const void *data);
 } ARMCPUInfo;
 
 /**
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b8b4c05172..d8ef1e6e4d7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3040,7 +3040,8 @@ static inline int check_attn_none(CPUPPCState *env)
 
 #define POWERPC_FAMILY(_name)                                               \
     static void                                                             \
-    glue(glue(ppc_, _name), _cpu_family_class_init)(ObjectClass *, void *); \
+    glue(glue(ppc_, _name), _cpu_family_class_init)(ObjectClass *,          \
+                                                    const void *);          \
                                                                             \
     static const TypeInfo                                                   \
     glue(glue(ppc_, _name), _cpu_family_type_info) = {                      \
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 945ba720513..ec535db44f6 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -354,7 +354,7 @@ static inline int hvf_gdbstub_sstep_flags(void)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
-static void hvf_accel_class_init(ObjectClass *oc, void *data)
+static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "HVF";
@@ -577,7 +577,7 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
-static void hvf_accel_ops_class_init(ObjectClass *oc, void *data)
+static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index a81e8f3b03b..c2640008f26 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -89,7 +89,7 @@ static int kvm_update_guest_debug_ops(CPUState *cpu)
 }
 #endif
 
-static void kvm_accel_ops_class_init(ObjectClass *oc, void *data)
+static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433c..6aede1bc269 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3957,7 +3957,7 @@ static int kvm_gdbstub_sstep_flags(void)
     return kvm_sstep_flags;
 }
 
-static void kvm_accel_class_init(ObjectClass *oc, void *data)
+static void kvm_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index ad7e3441a5a..37680731f62 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -41,7 +41,7 @@ static int qtest_init_accel(MachineState *ms)
     return 0;
 }
 
-static void qtest_accel_class_init(ObjectClass *oc, void *data)
+static void qtest_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "QTest";
@@ -58,7 +58,7 @@ static const TypeInfo qtest_accel_type = {
 };
 module_obj(TYPE_QTEST_ACCEL);
 
-static void qtest_accel_ops_class_init(ObjectClass *oc, void *data)
+static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b2..58946e7ee6a 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -223,7 +223,7 @@ static void tcg_accel_ops_init(AccelOpsClass *ops)
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
 }
 
-static void tcg_accel_ops_class_init(ObjectClass *oc, void *data)
+static void tcg_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 95adaacee82..0614edf2a5b 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -228,7 +228,7 @@ static int tcg_gdbstub_supported_sstep_flags(void)
     }
 }
 
-static void tcg_accel_class_init(ObjectClass *oc, void *data)
+static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 852e9fbe5fe..4f8028cf11d 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -115,7 +115,7 @@ static int xen_init(MachineState *ms)
     return 0;
 }
 
-static void xen_accel_class_init(ObjectClass *oc, void *data)
+static void xen_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     static GlobalProperty compat[] = {
@@ -146,7 +146,7 @@ static const TypeInfo xen_accel_type = {
     .class_init = xen_accel_class_init,
 };
 
-static void xen_accel_ops_class_init(ObjectClass *oc, void *data)
+static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/authz/list.c b/authz/list.c
index 0e17eed8974..bbd99f2b7fc 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -116,7 +116,7 @@ qauthz_list_finalize(Object *obj)
 
 
 static void
-qauthz_list_class_init(ObjectClass *oc, void *data)
+qauthz_list_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
 
diff --git a/authz/listfile.c b/authz/listfile.c
index d31d9103f77..b58d4ebd1d8 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -220,7 +220,7 @@ qauthz_list_file_finalize(Object *obj)
 
 
 static void
-qauthz_list_file_class_init(ObjectClass *oc, void *data)
+qauthz_list_file_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
diff --git a/authz/pamacct.c b/authz/pamacct.c
index c862d9ff39b..07b8aad4972 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -103,7 +103,7 @@ qauthz_pam_finalize(Object *obj)
 
 
 static void
-qauthz_pam_class_init(ObjectClass *oc, void *data)
+qauthz_pam_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
diff --git a/authz/simple.c b/authz/simple.c
index 0597dcd8ea5..f6985b840ea 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -78,7 +78,7 @@ qauthz_simple_complete(UserCreatable *uc, Error **errp)
 
 
 static void
-qauthz_simple_class_init(ObjectClass *oc, void *data)
+qauthz_simple_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 1cd9bed505d..8ff7bfa8570 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -20,7 +20,8 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             CONFIDENTIAL_GUEST_SUPPORT,
                             OBJECT)
 
-static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
+static void confidential_guest_support_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
 }
 
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 764cee43119..0414c01e06d 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -608,7 +608,7 @@ static void cryptodev_builtin_cleanup(
 }
 
 static void
-cryptodev_builtin_class_init(ObjectClass *oc, void *data)
+cryptodev_builtin_class_init(ObjectClass *oc, const void *data)
 {
     CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_CLASS(oc);
 
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 41cf24b7379..05353954de6 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -616,7 +616,7 @@ static int cryptodev_lkcf_close_session(CryptoDevBackend *backend,
     return 0;
 }
 
-static void cryptodev_lkcf_class_init(ObjectClass *oc, void *data)
+static void cryptodev_lkcf_class_init(ObjectClass *oc, const void *data)
 {
     CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_CLASS(oc);
 
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 3295c6198a7..cb04e68b022 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -393,7 +393,7 @@ static void cryptodev_vhost_user_finalize(Object *obj)
 }
 
 static void
-cryptodev_vhost_user_class_init(ObjectClass *oc, void *data)
+cryptodev_vhost_user_class_init(ObjectClass *oc, const void *data)
 {
     CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_CLASS(oc);
 
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 1187b08dacf..51bbe5ce40f 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -608,7 +608,7 @@ static void cryptodev_backend_schemas_cb(StatsSchemaList **result,
 }
 
 static void
-cryptodev_backend_class_init(ObjectClass *oc, void *data)
+cryptodev_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index be6c4d8e0ae..8c2deef43d4 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -485,7 +485,7 @@ dbus_vmstate_get_id(VMStateIf *vmif)
 }
 
 static void
-dbus_vmstate_class_init(ObjectClass *oc, void *data)
+dbus_vmstate_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     VMStateIfClass *vc = VMSTATE_IF_CLASS(oc);
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
index cea76c6925c..f6965e4027b 100644
--- a/backends/host_iommu_device.c
+++ b/backends/host_iommu_device.c
@@ -17,7 +17,7 @@ OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
                             HOST_IOMMU_DEVICE,
                             OBJECT)
 
-static void host_iommu_device_class_init(ObjectClass *oc, void *data)
+static void host_iommu_device_class_init(ObjectClass *oc, const void *data)
 {
 }
 
diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index 1fa2d031e49..ab20b182331 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -50,7 +50,7 @@ static void sgx_epc_backend_instance_init(Object *obj)
     m->dump = false;
 }
 
-static void sgx_epc_backend_class_init(ObjectClass *oc, void *data)
+static void sgx_epc_backend_class_init(ObjectClass *oc, const void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
 
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 691a8278196..8e3219c0617 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -270,7 +270,7 @@ static void file_backend_unparent(Object *obj)
 }
 
 static void
-file_backend_class_init(ObjectClass *oc, void *data)
+file_backend_class_init(ObjectClass *oc, const void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
 
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 85daa1432c4..923239f9cf6 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -133,7 +133,7 @@ memfd_backend_instance_init(Object *obj)
 }
 
 static void
-memfd_backend_class_init(ObjectClass *oc, void *data)
+memfd_backend_class_init(ObjectClass *oc, const void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
 
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 868ae6ca80a..062b1abb116 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -37,7 +37,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 }
 
 static void
-ram_backend_class_init(ObjectClass *oc, void *data)
+ram_backend_class_init(ObjectClass *oc, const void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
 
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index f67ad2740b5..f66211a2ec9 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -69,7 +69,7 @@ shm_backend_instance_init(Object *obj)
 }
 
 static void
-shm_backend_class_init(ObjectClass *oc, void *data)
+shm_backend_class_init(ObjectClass *oc, const void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index bceca1a8d9f..195f37fa443 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -501,7 +501,7 @@ host_memory_backend_set_use_canonical_path(Object *obj, bool value,
 }
 
 static void
-host_memory_backend_class_init(ObjectClass *oc, void *data)
+host_memory_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 7b4fc8ec460..53566beb8a5 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -64,7 +64,7 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
     return !be->users;
 }
 
-static void iommufd_backend_class_init(ObjectClass *oc, void *data)
+static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
@@ -329,7 +329,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
-static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
+static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
index 4cfa7e578bc..41b7bfaa27f 100644
--- a/backends/rng-builtin.c
+++ b/backends/rng-builtin.c
@@ -55,7 +55,7 @@ static void rng_builtin_finalize(Object *obj)
     qemu_bh_delete(s->bh);
 }
 
-static void rng_builtin_class_init(ObjectClass *klass, void *data)
+static void rng_builtin_class_init(ObjectClass *klass, const void *data)
 {
     RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
 
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 82da46365d3..9fd3393ede2 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -143,7 +143,7 @@ static void rng_egd_finalize(Object *obj)
     g_free(s->chr_name);
 }
 
-static void rng_egd_class_init(ObjectClass *klass, void *data)
+static void rng_egd_class_init(ObjectClass *klass, const void *data)
 {
     RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
 
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 3ce6cc9b4af..820bf48c9b4 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -121,7 +121,7 @@ static void rng_random_finalize(Object *obj)
     g_free(s->filename);
 }
 
-static void rng_random_class_init(ObjectClass *klass, void *data)
+static void rng_random_class_init(ObjectClass *klass, const void *data)
 {
     RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
 
diff --git a/backends/rng.c b/backends/rng.c
index 1f6fb106aea..b3480d27a12 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -99,7 +99,7 @@ static void rng_backend_finalize(Object *obj)
     rng_backend_free_requests(s);
 }
 
-static void rng_backend_class_init(ObjectClass *oc, void *data)
+static void rng_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 00fe015a94e..43d350e895d 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -1056,7 +1056,7 @@ static void tpm_emulator_inst_finalize(Object *obj)
     vmstate_unregister(NULL, &vmstate_tpm_emulator, obj);
 }
 
-static void tpm_emulator_class_init(ObjectClass *klass, void *data)
+static void tpm_emulator_class_init(ObjectClass *klass, const void *data)
 {
     TPMBackendClass *tbc = TPM_BACKEND_CLASS(klass);
 
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 09a6abf02d2..b7c7074c2aa 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -364,7 +364,7 @@ static void tpm_passthrough_inst_finalize(Object *obj)
     qapi_free_TPMPassthroughOptions(tpm_pt->options);
 }
 
-static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
+static void tpm_passthrough_class_init(ObjectClass *klass, const void *data)
 {
     TPMBackendClass *tbc = TPM_BACKEND_CLASS(klass);
 
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index d0e4d71a633..94274a619d5 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -163,7 +163,7 @@ static char *get_chardev(Object *obj, Error **errp)
     return NULL;
 }
 
-static void vhost_user_backend_class_init(ObjectClass *oc, void *data)
+static void vhost_user_backend_class_init(ObjectClass *oc, const void *data)
 {
     object_class_property_add_str(oc, "chardev", get_chardev, set_chardev);
 }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 32553b39e39..a72765e847e 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -934,7 +934,8 @@ static bool throttle_group_can_be_deleted(UserCreatable *uc)
     return OBJECT(uc)->ref == 1;
 }
 
-static void throttle_group_obj_class_init(ObjectClass *klass, void *class_data)
+static void throttle_group_obj_class_init(ObjectClass *klass,
+                                          const void *class_data)
 {
     size_t i = 0;
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
diff --git a/chardev/baum.c b/chardev/baum.c
index a1d9784d92d..f3e8cd27f06 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -668,7 +668,7 @@ static void baum_chr_open(Chardev *chr,
     qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
 }
 
-static void char_braille_class_init(ObjectClass *oc, void *data)
+static void char_braille_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-console.c b/chardev/char-console.c
index 6c4ce5dbce7..7e1bf642ebd 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -34,7 +34,7 @@ static void qemu_chr_open_win_con(Chardev *chr,
     win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
 }
 
-static void char_console_class_init(ObjectClass *oc, void *data)
+static void char_console_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index d2c49233598..23bfe3c0b1c 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -238,7 +238,7 @@ void qemu_chr_open_fd(Chardev *chr,
     }
 }
 
-static void char_fd_class_init(ObjectClass *oc, void *data)
+static void char_fd_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 263e6da5636..a9e8c5e0d7f 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -123,7 +123,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
     file->append = qemu_opt_get_bool(opts, "append", false);
 }
 
-static void char_file_class_init(ObjectClass *oc, void *data)
+static void char_file_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index 3a4aae32897..16ffee2017a 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -272,7 +272,7 @@ static void qemu_chr_parse_hub(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
-static void char_hub_class_init(ObjectClass *oc, void *data)
+static void char_hub_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index d5f7e1a9cf5..6b36290e2c4 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -447,7 +447,7 @@ void resume_mux_open(void)
                          chardev_options_parsed_cb, NULL);
 }
 
-static void char_mux_class_init(ObjectClass *oc, void *data)
+static void char_mux_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-null.c b/chardev/char-null.c
index 1c6a2900f9b..89cb85da792 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -34,7 +34,7 @@ static void null_chr_open(Chardev *chr,
     *be_opened = false;
 }
 
-static void char_null_class_init(ObjectClass *oc, void *data)
+static void char_null_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 78697d7522d..62a44b2f969 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -270,7 +270,7 @@ static void qemu_chr_parse_parallel(QemuOpts *opts, ChardevBackend *backend,
     parallel->device = g_strdup(device);
 }
 
-static void char_parallel_class_init(ObjectClass *oc, void *data)
+static void char_parallel_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 5ad30bcc599..3d1b0ce2d2e 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -171,7 +171,7 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
     dev->device = g_strdup(device);
 }
 
-static void char_pipe_class_init(ObjectClass *oc, void *data)
+static void char_pipe_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 6a2c1dc13a3..c28554e6e02 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -390,7 +390,7 @@ static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
     pty->path = g_strdup(path);
 }
 
-static void char_pty_class_init(ObjectClass *oc, void *data)
+static void char_pty_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index d40d21d3cf7..98aadb6acfb 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -223,7 +223,7 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
-static void char_ringbuf_class_init(ObjectClass *oc, void *data)
+static void char_ringbuf_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 4b0b83d5b45..0a68b4b4e0b 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -298,7 +298,7 @@ static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backend,
     serial->device = g_strdup(device);
 }
 
-static void char_serial_class_init(ObjectClass *oc, void *data)
+static void char_serial_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 91496ceda90..d6efe20403b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1577,7 +1577,7 @@ char_socket_get_connected(Object *obj, Error **errp)
     return s->state == TCP_CHARDEV_STATE_CONNECTED;
 }
 
-static void char_socket_class_init(ObjectClass *oc, void *data)
+static void char_socket_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index b960ddd4e4c..48db8d2f30f 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -136,7 +136,7 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend,
     stdio->signal = qemu_opt_get_bool(opts, "signal", true);
 }
 
-static void char_stdio_class_init(ObjectClass *oc, void *data)
+static void char_stdio_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 3d9a2d5e772..572fab0ad13 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -219,7 +219,7 @@ static void qmp_chardev_open_udp(Chardev *chr,
     *be_opened = false;
 }
 
-static void char_udp_class_init(ObjectClass *oc, void *data)
+static void char_udp_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 13325ca967c..fb802a00b13 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -256,7 +256,7 @@ static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
     return len - len1;
 }
 
-static void char_win_stdio_class_init(ObjectClass *oc, void *data)
+static void char_win_stdio_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char-win.c b/chardev/char-win.c
index d4fb44c4dcc..fef45e83aad 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -220,7 +220,7 @@ void win_chr_set_file(Chardev *chr, HANDLE file, bool keep_open)
     s->file = file;
 }
 
-static void char_win_class_init(ObjectClass *oc, void *data)
+static void char_win_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/char.c b/chardev/char.c
index 5a9e9762adc..bbebd246c3a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -295,7 +295,7 @@ static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static void char_class_init(ObjectClass *oc, void *data)
+static void char_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 2279694cfab..1a55755d397 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -267,7 +267,7 @@ static void msmouse_chr_open(Chardev *chr,
     fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
 }
 
-static void char_msmouse_class_init(ObjectClass *oc, void *data)
+static void char_msmouse_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/spice.c b/chardev/spice.c
index e843d961a78..db53b49da26 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -347,7 +347,7 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
     spiceport->fqdn = g_strdup(name);
 }
 
-static void char_spice_class_init(ObjectClass *oc, void *data)
+static void char_spice_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
@@ -366,7 +366,7 @@ static const TypeInfo char_spice_type_info = {
 };
 module_obj(TYPE_CHARDEV_SPICE);
 
-static void char_spicevmc_class_init(ObjectClass *oc, void *data)
+static void char_spicevmc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
@@ -382,7 +382,7 @@ static const TypeInfo char_spicevmc_type_info = {
 };
 module_obj(TYPE_CHARDEV_SPICEVMC);
 
-static void char_spiceport_class_init(ObjectClass *oc, void *data)
+static void char_spiceport_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/testdev.c b/chardev/testdev.c
index a92caca3c33..e91f4e8343a 100644
--- a/chardev/testdev.c
+++ b/chardev/testdev.c
@@ -110,7 +110,7 @@ static int testdev_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return orig_len;
 }
 
-static void char_testdev_class_init(ObjectClass *oc, void *data)
+static void char_testdev_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index f4008bf35b7..0dc6ef08f59 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -342,7 +342,7 @@ static void wctablet_chr_open(Chardev *chr,
                                              &wctablet_handler);
 }
 
-static void wctablet_chr_class_init(ObjectClass *oc, void *data)
+static void wctablet_chr_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/crypto/secret.c b/crypto/secret.c
index 44eaff16f60..61a4584286c 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -117,7 +117,7 @@ qcrypto_secret_finalize(Object *obj)
 }
 
 static void
-qcrypto_secret_class_init(ObjectClass *oc, void *data)
+qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 {
     QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
     sic->load_data = qcrypto_secret_load_data;
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index dbda9989403..2399ce412be 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -263,7 +263,7 @@ qcrypto_secret_finalize(Object *obj)
 }
 
 static void
-qcrypto_secret_class_init(ObjectClass *oc, void *data)
+qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 1b7edec84a0..78d7f09b3b9 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -103,7 +103,7 @@ qcrypto_secret_prop_get_key(Object *obj, Visitor *v,
 
 
 static void
-qcrypto_secret_keyring_class_init(ObjectClass *oc, void *data)
+qcrypto_secret_keyring_class_init(ObjectClass *oc, const void *data)
 {
     QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
     sic->load_data = qcrypto_secret_keyring_load_data;
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index d0df4badc0f..e546cc7c0e6 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -102,7 +102,8 @@ static GByteArray *qcrypto_tls_cipher_suites_fw_cfg_gen_data(Object *obj,
                                               errp);
 }
 
-static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
+static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc,
+                                                 const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 084ce0d51ae..9e59594d673 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -223,7 +223,7 @@ qcrypto_tls_creds_prop_get_endpoint(Object *obj,
 
 
 static void
-qcrypto_tls_creds_class_init(ObjectClass *oc, void *data)
+qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
 {
     object_class_property_add_bool(oc, "verify-peer",
                                    qcrypto_tls_creds_prop_get_verify,
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 476cf89c963..0e2d133821f 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -137,7 +137,7 @@ qcrypto_tls_creds_anon_finalize(Object *obj)
 
 
 static void
-qcrypto_tls_creds_anon_class_init(ObjectClass *oc, void *data)
+qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index aa270d7988b..287c2a3c96c 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -236,7 +236,7 @@ qcrypto_tls_creds_psk_prop_get_username(Object *obj,
 }
 
 static void
-qcrypto_tls_creds_psk_class_init(ObjectClass *oc, void *data)
+qcrypto_tls_creds_psk_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 24ec5849222..143993f5393 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -802,7 +802,7 @@ qcrypto_tls_creds_x509_finalize(Object *obj)
 
 
 static void
-qcrypto_tls_creds_x509_class_init(ObjectClass *oc, void *data)
+qcrypto_tls_creds_x509_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     QCryptoTLSCredsClass *ctcc = QCRYPTO_TLS_CREDS_CLASS(oc);
diff --git a/event-loop-base.c b/event-loop-base.c
index 0cfb1c94962..10b669ffc73 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -99,7 +99,8 @@ static bool event_loop_base_can_be_deleted(UserCreatable *uc)
     return true;
 }
 
-static void event_loop_base_class_init(ObjectClass *klass, void *class_data)
+static void event_loop_base_class_init(ObjectClass *klass,
+                                       const void *class_data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
     ucc->complete = event_loop_base_complete;
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8ce79fa88cf..7de28e555d7 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -239,7 +239,7 @@ static void gdb_monitor_open(Chardev *chr, ChardevBackend *backend,
     *be_opened = false;
 }
 
-static void char_gdb_class_init(ObjectClass *oc, void *data)
+static void char_gdb_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index bb2843da0f6..81b91e47c63 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -248,7 +248,7 @@ static const Property virtio_9p_properties[] = {
     DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
 };
 
-static void virtio_9p_class_init(ObjectClass *klass, void *data)
+static void virtio_9p_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index ec64f928935..621c82f019f 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -1018,7 +1018,7 @@ static const Property erst_properties[] = {
                      default_record_size, ERST_RECORD_SIZE),
 };
 
-static void erst_class_init(ObjectClass *klass, void *data)
+static void erst_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index c85d97ca377..f589e79a2bb 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -469,7 +469,7 @@ static void acpi_ged_initfn(Object *obj)
     sysbus_init_mmio(sbd, &ged_st->regs);
 }
 
-static void acpi_ged_class_init(ObjectClass *class, void *data)
+static void acpi_ged_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index f88f450af38..d511a850295 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -133,7 +133,7 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
     ms->numa_state->nodes[gi->node].has_gi = true;
 }
 
-static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
 {
     object_class_property_add_str(oc, "pci-dev", NULL,
         acpi_generic_initiator_set_pci_device);
@@ -247,7 +247,7 @@ static void acpi_generic_port_set_node(Object *obj, Visitor *v,
     gp->node = value;
 }
 
-static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
 {
     object_class_property_add_str(oc, "pci-bus", NULL,
         acpi_generic_port_set_pci_bus);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6d023e595b6..5860e8408bd 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -619,7 +619,7 @@ static const Property piix4_pm_properties[] = {
                       not_migrate_acpi_index, false),
 };
 
-static void piix4_pm_class_init(ObjectClass *klass, void *data)
+static void piix4_pm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
index 7387e5c9cad..c582c0c1f83 100644
--- a/hw/acpi/vmclock.c
+++ b/hw/acpi/vmclock.c
@@ -154,7 +154,7 @@ static void vmclock_realize(DeviceState *dev, Error **errp)
     vmclock_update_guest(vms);
 }
 
-static void vmclock_device_class_init(ObjectClass *klass, void *data)
+static void vmclock_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 008768e0366..fac3d6d97e7 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -218,7 +218,7 @@ static const Property vmgenid_device_properties[] = {
     DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
 };
 
-static void vmgenid_device_class_init(ObjectClass *klass, void *data)
+static void vmgenid_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 1cc554f1793..3e820cae1e3 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -291,7 +291,7 @@ static const Property aspeed_adc_engine_properties[] = {
     DEFINE_PROP_UINT32("nr-channels", AspeedADCEngineState, nr_channels, 0),
 };
 
-static void aspeed_adc_engine_class_init(ObjectClass *klass, void *data)
+static void aspeed_adc_engine_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -369,7 +369,7 @@ static void aspeed_adc_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void aspeed_adc_class_init(ObjectClass *klass, void *data)
+static void aspeed_adc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedADCClass *aac = ASPEED_ADC_CLASS(klass);
@@ -379,7 +379,7 @@ static void aspeed_adc_class_init(ObjectClass *klass, void *data)
     aac->nr_engines = 1;
 }
 
-static void aspeed_2600_adc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_adc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedADCClass *aac = ASPEED_ADC_CLASS(klass);
@@ -388,7 +388,7 @@ static void aspeed_2600_adc_class_init(ObjectClass *klass, void *data)
     aac->nr_engines = 2;
 }
 
-static void aspeed_1030_adc_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_adc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedADCClass *aac = ASPEED_ADC_CLASS(klass);
@@ -397,7 +397,7 @@ static void aspeed_1030_adc_class_init(ObjectClass *klass, void *data)
     aac->nr_engines = 2;
 }
 
-static void aspeed_2700_adc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_adc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedADCClass *aac = ASPEED_ADC_CLASS(klass);
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 0a83d28605e..ddb219d4562 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -271,7 +271,7 @@ static const Property npcm7xx_timer_properties[] = {
     DEFINE_PROP_UINT32("iref", NPCM7xxADCState, iref, NPCM7XX_ADC_DEFAULT_IREF),
 };
 
-static void npcm7xx_adc_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index e3b21f90779..a490ae640d9 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -284,7 +284,7 @@ static void stm32f2xx_adc_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-static void stm32f2xx_adc_class_init(ObjectClass *klass, void *data)
+static void stm32f2xx_adc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/adc/zynq-xadc.c b/hw/adc/zynq-xadc.c
index 26d9a7b9a5b..748a51ba78b 100644
--- a/hw/adc/zynq-xadc.c
+++ b/hw/adc/zynq-xadc.c
@@ -281,7 +281,7 @@ static const VMStateDescription vmstate_zynq_xadc = {
     }
 };
 
-static void zynq_xadc_class_init(ObjectClass *klass, void *data)
+static void zynq_xadc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index e8711ae16a3..c7e30e60426 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -934,7 +934,7 @@ static const TypeInfo typhoon_pcihost_info = {
 };
 
 static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,
-                                                   void *data)
+                                                   const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index a829913f1b5..08a56f7d3ed 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -208,7 +208,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0, AW_A10_WDT_BASE, 1);
 }
 
-static void aw_a10_class_init(ObjectClass *oc, void *data)
+static void aw_a10_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 2efced3f66a..25d621e489d 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -466,7 +466,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void allwinner_h3_class_init(ObjectClass *oc, void *data)
+static void allwinner_h3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 47b3180f0ec..c00e97d626f 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -539,7 +539,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void allwinner_r40_class_init(ObjectClass *oc, void *data)
+static void allwinner_r40_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index ffd732f8068..d65a46b8d8d 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1691,7 +1691,7 @@ static void armsse_reset(DeviceState *dev)
     s->nsccfg = 0;
 }
 
-static void armsse_class_init(ObjectClass *klass, void *data)
+static void armsse_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(klass);
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 98a69846119..a4cca5ca465 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -565,7 +565,7 @@ static const VMStateDescription vmstate_armv7m = {
     }
 };
 
-static void armv7m_class_init(ObjectClass *klass, void *data)
+static void armv7m_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -636,7 +636,7 @@ static const Property bitband_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void bitband_class_init(ObjectClass *klass, void *data)
+static void bitband_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d9418e2b9f2..a133407798a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1225,7 +1225,7 @@ static void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
                                           "Set or unset boot from EMMC");
 }
 
-static void aspeed_machine_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1241,7 +1241,8 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_props_init(oc);
 }
 
-static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
+                                               const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1257,7 +1258,8 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1274,7 +1276,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
 }
 
 static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
-                                                        void *data)
+                                                        const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1292,7 +1294,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
 }
 
 static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
-                                                            void *data)
+                                                            const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1309,7 +1311,8 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1325,7 +1328,8 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
+                                                 const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1342,7 +1346,8 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_romulus_class_init(ObjectClass *oc,
+                                              const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1358,7 +1363,8 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
+                                                const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1375,7 +1381,8 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
+                                                 const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1391,7 +1398,8 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1407,7 +1415,8 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1428,7 +1437,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     aspeed_machine_ast2600_class_emmc_init(oc);
 };
 
-static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1445,7 +1454,8 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
+                                               const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1462,7 +1472,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1483,7 +1493,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
 
 #define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
-static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1504,7 +1514,8 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
 
 #define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
-static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
+                                                const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1548,7 +1559,7 @@ static void fby35_reset(MachineState *state, ResetType type)
     object_property_set_bool(OBJECT(gpio), "gpioB5", false, &error_fatal);
 }
 
-static void aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_fby35_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1625,7 +1636,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 }
 
 static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
-                                                          void *data)
+                                                          const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1654,7 +1665,8 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
                             TYPE_TMP105, 0x4d);
 }
 
-static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1675,7 +1687,7 @@ static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
 #endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
-                                                     void *data)
+                                                     const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1694,7 +1706,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
 };
 
 static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
-                                                    void *data)
+                                                    const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e76c7100a1d..ff9686551f9 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -415,7 +415,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_JTAG1], 0x20);
 }
 
-static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
+static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 8784b6e7930..54b459ee361 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -502,7 +502,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
 }
 
-static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
+static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("arm926"),
@@ -531,7 +531,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     sc->get_irq      = aspeed_soc_ast2400_get_irq;
 }
 
-static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
+static void aspeed_soc_ast2500_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("arm1176"),
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 07210483bb2..811303b7ff9 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -653,7 +653,7 @@ static bool aspeed_soc_ast2600_boot_from_emmc(AspeedSoCState *s)
     return !!(hw_strap1 & SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC);
 }
 
-static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
+static void aspeed_soc_ast2600_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 2d0c99f1591..7912bafaff7 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -740,7 +740,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("ast2700.io", 0x0, 0x4000000);
 }
 
-static void aspeed_soc_ast2700_class_init(ObjectClass *oc, void *data)
+static void aspeed_soc_ast2700_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a35"),
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 1ddcb26c1ed..1c4ac93a0ff 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -146,7 +146,7 @@ static const Property aspeed_soc_properties[] = {
                      MemoryRegion *),
 };
 
-static void aspeed_soc_class_init(ObjectClass *oc, void *data)
+static void aspeed_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index c9a5209216c..34ed2e0851b 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -110,7 +110,7 @@ static void bl475e_init(MachineState *machine)
     }
 }
 
-static void bl475e_machine_init(ObjectClass *oc, void *data)
+static void bl475e_machine_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char *machine_valid_cpu_types[] = {
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index adc9730c2ed..8a1e72dfab2 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -520,7 +520,7 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
-static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
+static void bcm2835_peripherals_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     BCMSocPeripheralBaseClass *bc = BCM_SOC_PERIPHERALS_BASE_CLASS(oc);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 95e16806fa1..cd61ba15054 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -163,7 +163,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void bcm283x_base_class_init(ObjectClass *oc, void *data)
+static void bcm283x_base_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -171,7 +171,7 @@ static void bcm283x_base_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
-static void bcm2835_class_init(ObjectClass *oc, void *data)
+static void bcm2835_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
@@ -182,7 +182,7 @@ static void bcm2835_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2835_realize;
 };
 
-static void bcm2836_class_init(ObjectClass *oc, void *data)
+static void bcm2836_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
@@ -196,7 +196,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
 };
 
 #ifdef TARGET_AARCH64
-static void bcm2837_class_init(ObjectClass *oc, void *data)
+static void bcm2837_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index ddb7c5f757a..22aa754613c 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -233,7 +233,7 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_pass_gpios(DEVICE(&s->gic), DEVICE(&s->peripherals), NULL);
 }
 
-static void bcm2838_class_init(ObjectClass *oc, void *data)
+static void bcm2838_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     BCM283XBaseClass *bc_base = BCM283X_BASE_CLASS(oc);
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index e28bef4a37d..812b5b8480c 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -196,7 +196,7 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s_base, &s->asb, "bcm2838-asb", BRDG_OFFSET, 0x24);
 }
 
-static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
+static void bcm2838_peripherals_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_CLASS(oc);
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index eaa5c52d45a..135a57ad6d2 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -69,7 +69,7 @@ static void collie_init(MachineState *machine)
     arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
 }
 
-static void collie_machine_class_init(ObjectClass *oc, void *data)
+static void collie_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 5836619d9fe..d831bc974d2 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -79,7 +79,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sbd, 0, DIGIC_UART_BASE);
 }
 
-static void digic_class_init(ObjectClass *oc, void *data)
+static void digic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index dd0edc81d5c..5888c13f6a1 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -837,7 +837,7 @@ static void exynos4210_init(Object *obj)
                             TYPE_EXYNOS4210_COMBINER);
 }
 
-static void exynos4210_class_init(ObjectClass *klass, void *data)
+static void exynos4210_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 2410e2a28e8..c9ac0011604 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -154,7 +154,7 @@ static const char * const valid_cpu_types[] = {
     NULL
 };
 
-static void nuri_class_init(ObjectClass *oc, void *data)
+static void nuri_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -173,7 +173,7 @@ static const TypeInfo nuri_type = {
     .class_init = nuri_class_init,
 };
 
-static void smdkc210_class_init(ObjectClass *oc, void *data)
+static void smdkc210_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 83d08e578b7..75686fbf5de 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -162,7 +162,7 @@ static void fby35_instance_init(Object *obj)
     FBY35(obj)->mmio_exec = false;
 }
 
-static void fby35_class_init(ObjectClass *oc, void *data)
+static void fby35_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 5359a6d8d3b..6fa2edfc4a5 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -313,7 +313,7 @@ static const Property fsl_imx25_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX25State, phy_num, 0),
 };
 
-static void fsl_imx25_class_init(ObjectClass *oc, void *data)
+static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 9de0f2148f6..67342209e0b 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -218,7 +218,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->iram_alias);
 }
 
-static void fsl_imx31_class_init(ObjectClass *oc, void *data)
+static void fsl_imx31_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index dc86338b3a5..2e5592e164b 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -486,7 +486,7 @@ static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
 };
 
-static void fsl_imx6_class_init(ObjectClass *oc, void *data)
+static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 34c4aa15cd0..f1b4be9cb1a 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -717,7 +717,7 @@ static const Property fsl_imx6ul_properties[] = {
                      true),
 };
 
-static void fsl_imx6ul_class_init(ObjectClass *oc, void *data)
+static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 3374018cde0..ee77c59df91 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -750,7 +750,7 @@ static const Property fsl_imx7_properties[] = {
                      true),
 };
 
-static void fsl_imx7_class_init(ObjectClass *oc, void *data)
+static void fsl_imx7_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 495704d9726..b21828a6675 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -139,7 +139,7 @@ static void highbank_regs_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static void highbank_regs_class_init(ObjectClass *klass, void *data)
+static void highbank_regs_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -341,7 +341,7 @@ static void midway_init(MachineState *machine)
     calxeda_init(machine, CALXEDA_MIDWAY);
 }
 
-static void highbank_class_init(ObjectClass *oc, void *data)
+static void highbank_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a9"),
@@ -365,7 +365,7 @@ static const TypeInfo highbank_type = {
     .class_init = highbank_class_init,
 };
 
-static void midway_class_init(ObjectClass *oc, void *data)
+static void midway_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a15"),
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 4e1b8627d32..567f0c14400 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -698,7 +698,7 @@ static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
 };
 
-static void core_class_init(ObjectClass *klass, void *data)
+static void core_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -707,14 +707,14 @@ static void core_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_integratorcm;
 }
 
-static void icp_pic_class_init(ObjectClass *klass, void *data)
+static void icp_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_icp_pic;
 }
 
-static void icp_control_class_init(ObjectClass *klass, void *data)
+static void icp_control_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 3f56fb45ce1..ee52326df9c 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -60,7 +60,7 @@ static void microbit_init(MachineState *machine)
                        0, s->nrf51.flash_size);
 }
 
-static void microbit_machine_class_init(ObjectClass *oc, void *data)
+static void microbit_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 13ed868b6b9..609abe9db65 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1267,7 +1267,7 @@ static void mps2_machine_reset(MachineState *machine, ResetType type)
     qemu_devices_reset(type);
 }
 
-static void mps2tz_class_init(ObjectClass *oc, void *data)
+static void mps2tz_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(oc);
@@ -1304,7 +1304,7 @@ static void mps2tz_set_default_ram_info(MPS2TZMachineClass *mmc)
     g_assert_not_reached();
 }
 
-static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
+static void mps2tz_an505_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
@@ -1338,7 +1338,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     mps2tz_set_default_ram_info(mmc);
 }
 
-static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
+static void mps2tz_an521_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
@@ -1372,7 +1372,7 @@ static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
     mps2tz_set_default_ram_info(mmc);
 }
 
-static void mps3tz_an524_class_init(ObjectClass *oc, void *data)
+static void mps3tz_an524_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
@@ -1411,7 +1411,7 @@ static void mps3tz_an524_class_init(ObjectClass *oc, void *data)
                                           "are BRAM (default) and QSPI.");
 }
 
-static void mps3tz_an547_class_init(ObjectClass *oc, void *data)
+static void mps3tz_an547_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 3f8db0cab60..aa7dbde4505 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -464,7 +464,7 @@ static void mps2_common_init(MachineState *machine)
                        0, 0x400000);
 }
 
-static void mps2_class_init(ObjectClass *oc, void *data)
+static void mps2_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -474,7 +474,7 @@ static void mps2_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "mps.ram";
 }
 
-static void mps2_an385_class_init(ObjectClass *oc, void *data)
+static void mps2_an385_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
@@ -493,7 +493,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->has_block_ram = true;
 }
 
-static void mps2_an386_class_init(ObjectClass *oc, void *data)
+static void mps2_an386_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
@@ -512,7 +512,7 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
     mmc->has_block_ram = true;
 }
 
-static void mps2_an500_class_init(ObjectClass *oc, void *data)
+static void mps2_an500_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
@@ -531,7 +531,7 @@ static void mps2_an500_class_init(ObjectClass *oc, void *data)
     mmc->has_block_ram = false;
 }
 
-static void mps2_an511_class_init(ObjectClass *oc, void *data)
+static void mps2_an511_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 1bddb5e822f..f5f306ba0c9 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -583,14 +583,14 @@ static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
     g_assert_not_reached();
 }
 
-static void mps3r_class_init(ObjectClass *oc, void *data)
+static void mps3r_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->init = mps3r_common_init;
 }
 
-static void mps3r_an536_class_init(ObjectClass *oc, void *data)
+static void mps3r_an536_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS3RMachineClass *mmc = MPS3R_MACHINE_CLASS(oc);
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index e8a5b231bab..9a53485fd81 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -236,7 +236,7 @@ static const Property m2sxxx_soc_properties[] = {
     DEFINE_PROP_UINT8("apb1div", MSF2State, apb1div, 2),
 };
 
-static void m2sxxx_soc_class_init(ObjectClass *klass, void *data)
+static void m2sxxx_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index e9c092abc3d..0fd2261f32f 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -594,7 +594,7 @@ static void musca_init(MachineState *machine)
                        0, 0x2000000);
 }
 
-static void musca_class_init(ObjectClass *oc, void *data)
+static void musca_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -609,7 +609,7 @@ static void musca_class_init(ObjectClass *oc, void *data)
     mc->init = musca_init;
 }
 
-static void musca_a_class_init(ObjectClass *oc, void *data)
+static void musca_a_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
@@ -623,7 +623,7 @@ static void musca_a_class_init(ObjectClass *oc, void *data)
     mmc->num_mpcs = ARRAY_SIZE(a_mpc_info);
 }
 
-static void musca_b1_class_init(ObjectClass *oc, void *data)
+static void musca_b1_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 48a32c24079..329b162eb20 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -286,7 +286,7 @@ static const VMStateDescription musicpal_lcd_vmsd = {
     }
 };
 
-static void musicpal_lcd_class_init(ObjectClass *klass, void *data)
+static void musicpal_lcd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -407,7 +407,7 @@ static const VMStateDescription mv88w8618_pic_vmsd = {
     }
 };
 
-static void mv88w8618_pic_class_init(ObjectClass *klass, void *data)
+static void mv88w8618_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -601,7 +601,7 @@ static const VMStateDescription mv88w8618_pit_vmsd = {
     }
 };
 
-static void mv88w8618_pit_class_init(ObjectClass *klass, void *data)
+static void mv88w8618_pit_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -687,7 +687,7 @@ static const VMStateDescription mv88w8618_flashcfg_vmsd = {
     }
 };
 
-static void mv88w8618_flashcfg_class_init(ObjectClass *klass, void *data)
+static void mv88w8618_flashcfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1026,7 +1026,7 @@ static const VMStateDescription musicpal_gpio_vmsd = {
     }
 };
 
-static void musicpal_gpio_class_init(ObjectClass *klass, void *data)
+static void musicpal_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1171,7 +1171,7 @@ static const VMStateDescription musicpal_key_vmsd = {
     }
 };
 
-static void musicpal_key_class_init(ObjectClass *klass, void *data)
+static void musicpal_key_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1348,7 +1348,7 @@ static void musicpal_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE("musicpal", musicpal_machine_init)
 
-static void mv88w8618_wlan_class_init(ObjectClass *klass, void *data)
+static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 386b2c35e9b..eec69eeb256 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -815,7 +815,7 @@ static const Property npcm7xx_properties[] = {
                      MemoryRegion *),
 };
 
-static void npcm7xx_class_init(ObjectClass *oc, void *data)
+static void npcm7xx_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -824,7 +824,7 @@ static void npcm7xx_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, npcm7xx_properties);
 }
 
-static void npcm730_class_init(ObjectClass *oc, void *data)
+static void npcm730_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxClass *nc = NPCM7XX_CLASS(oc);
 
@@ -833,7 +833,7 @@ static void npcm730_class_init(ObjectClass *oc, void *data)
     nc->num_cpus = 2;
 }
 
-static void npcm750_class_init(ObjectClass *oc, void *data)
+static void npcm750_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxClass *nc = NPCM7XX_CLASS(oc);
 
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 7727e0dc4bb..c28441b15b8 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -453,7 +453,7 @@ static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type)
     mc->default_cpus = mc->min_cpus = mc->max_cpus = sc->num_cpus;
 }
 
-static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
+static void npcm7xx_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -472,7 +472,7 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
  * Schematics:
  * https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-poleg/evaluation-board/board_deliverables/NPCM750x_EB_ver.A1.1_COMPLETE.pdf
  */
-static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
+static void npcm750_evb_machine_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -484,7 +484,7 @@ static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 512 * MiB;
 };
 
-static void gsj_machine_class_init(ObjectClass *oc, void *data)
+static void gsj_machine_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -496,7 +496,7 @@ static void gsj_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 512 * MiB;
 };
 
-static void gbs_bmc_machine_class_init(ObjectClass *oc, void *data)
+static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -508,7 +508,7 @@ static void gbs_bmc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
 }
 
-static void kudo_bmc_machine_class_init(ObjectClass *oc, void *data)
+static void kudo_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -520,7 +520,7 @@ static void kudo_bmc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
 };
 
-static void mori_bmc_machine_class_init(ObjectClass *oc, void *data)
+static void mori_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index dee06ab5654..d8cc3214ed6 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -216,7 +216,7 @@ static const Property nrf51_soc_properties[] = {
                        NRF51822_FLASH_SIZE),
 };
 
-static void nrf51_soc_class_init(ObjectClass *klass, void *data)
+static void nrf51_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 623ebd66395..0472e868e31 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -206,7 +206,7 @@ static void sx1_init_v2(MachineState *machine)
     sx1_init(machine, 2);
 }
 
-static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
+static void sx1_machine_v2_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -224,7 +224,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .class_init = sx1_machine_v2_class_init,
 };
 
-static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
+static void sx1_machine_v1_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a7a662f40db..37da6bd05c6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -337,7 +337,7 @@ static void raspi_machine_class_init(MachineClass *mc,
     mc->init = raspi_machine_init;
 };
 
-static void raspi0_machine_class_init(ObjectClass *oc, void *data)
+static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
@@ -346,7 +346,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
+static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
@@ -355,7 +355,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
+static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
@@ -365,7 +365,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
 };
 
 #ifdef TARGET_AARCH64
-static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
+static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
@@ -374,7 +374,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
+static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 1264e0d6eed..62770d61d5d 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -107,7 +107,7 @@ static void raspi4b_machine_init(MachineState *machine)
     raspi_base_machine_init(machine, &soc->parent_obj);
 }
 
-static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
+static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 9900a98f3b8..06b6e85f56d 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -406,7 +406,7 @@ static void realview_pbx_a9_init(MachineState *machine)
     realview_init(machine, BOARD_PBX_A9);
 }
 
-static void realview_eb_class_init(ObjectClass *oc, void *data)
+static void realview_eb_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -425,7 +425,7 @@ static const TypeInfo realview_eb_type = {
     .class_init = realview_eb_class_init,
 };
 
-static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
+static void realview_eb_mpcore_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -445,7 +445,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .class_init = realview_eb_mpcore_class_init,
 };
 
-static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
+static void realview_pb_a8_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -463,7 +463,7 @@ static const TypeInfo realview_pb_a8_type = {
     .class_init = realview_pb_a8_class_init,
 };
 
-static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
+static void realview_pbx_a9_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e720de30641..0bc1679537a 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -878,7 +878,7 @@ static void sbsa_ref_instance_init(Object *obj)
     sbsa_flash_create(sms);
 }
 
-static void sbsa_ref_class_init(ObjectClass *oc, void *data)
+static void sbsa_ref_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index dd74c2e5583..68a2d55b719 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -940,7 +940,7 @@ static const Property smmu_dev_properties[] = {
                      TYPE_PCI_BUS, PCIBus *),
 };
 
-static void smmu_base_class_init(ObjectClass *klass, void *data)
+static void smmu_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c0cf5df0f6e..de8324227cb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1992,7 +1992,7 @@ static void smmuv3_instance_init(Object *obj)
     /* Nothing much to do here as of now */
 }
 
-static void smmuv3_class_init(ObjectClass *klass, void *data)
+static void smmuv3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -2039,7 +2039,7 @@ static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
 }
 
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
-                                                  void *data)
+                                                  const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 47c1cfa0485..57ef40784a6 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1413,7 +1413,7 @@ static void lm3s6965evb_init(MachineState *machine)
  * Stellaris LM3S811 Evaluation Board Schematics:
  * https://www.ti.com/lit/ug/symlink/spmu030.pdf
  */
-static void lm3s811evb_class_init(ObjectClass *oc, void *data)
+static void lm3s811evb_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -1433,7 +1433,7 @@ static const TypeInfo lm3s811evb_type = {
  * Stellaris: LM3S6965 Evaluation Board Schematics:
  * https://www.ti.com/lit/ug/symlink/spmu029.pdf
  */
-static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
+static void lm3s6965evb_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -1457,7 +1457,7 @@ static void stellaris_machine_init(void)
 
 type_init(stellaris_machine_init)
 
-static void stellaris_i2c_class_init(ObjectClass *klass, void *data)
+static void stellaris_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1476,7 +1476,7 @@ static const TypeInfo stellaris_i2c_info = {
     .class_init    = stellaris_i2c_class_init,
 };
 
-static void stellaris_adc_class_init(ObjectClass *klass, void *data)
+static void stellaris_adc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1493,7 +1493,7 @@ static const TypeInfo stellaris_adc_info = {
     .class_init    = stellaris_adc_class_init,
 };
 
-static void stellaris_sys_class_init(ObjectClass *klass, void *data)
+static void stellaris_sys_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index 53b56364525..3408217d909 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -181,7 +181,7 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("CRC",       0x40023000, 0x400);
 }
 
-static void stm32f100_soc_class_init(ObjectClass *klass, void *data)
+static void stm32f100_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 47a54e592be..e71ddbf0f4a 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -202,7 +202,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 }
 
-static void stm32f205_soc_class_init(ObjectClass *klass, void *data)
+static void stm32f205_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 18d8824f29d..736827e1e80 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -298,7 +298,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("RNG",         0x50060800, 0x400);
 }
 
-static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
+static void stm32f405_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index dbf75329f7d..75683873b26 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -435,7 +435,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("QUADSPI",   0xA0001000, 0x400);
 }
 
-static void stm32l4x5_soc_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_soc_class_init(ObjectClass *klass, const void *data)
 {
 
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -446,21 +446,21 @@ static void stm32l4x5_soc_class_init(ObjectClass *klass, void *data)
     /* No vmstate or reset required: device has no internal state */
 }
 
-static void stm32l4x5xc_soc_class_init(ObjectClass *oc, void *data)
+static void stm32l4x5xc_soc_class_init(ObjectClass *oc, const void *data)
 {
     Stm32l4x5SocClass *ssc = STM32L4X5_SOC_CLASS(oc);
 
     ssc->flash_size = 256 * KiB;
 }
 
-static void stm32l4x5xe_soc_class_init(ObjectClass *oc, void *data)
+static void stm32l4x5xe_soc_class_init(ObjectClass *oc, const void *data)
 {
     Stm32l4x5SocClass *ssc = STM32L4X5_SOC_CLASS(oc);
 
     ssc->flash_size = 512 * KiB;
 }
 
-static void stm32l4x5xg_soc_class_init(ObjectClass *oc, void *data)
+static void stm32l4x5xg_soc_class_init(ObjectClass *oc, const void *data)
 {
     Stm32l4x5SocClass *ssc = STM32L4X5_SOC_CLASS(oc);
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index a31f4b4c65c..229c98ddd90 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -215,7 +215,7 @@ static const VMStateDescription vmstate_strongarm_pic_regs = {
     },
 };
 
-static void strongarm_pic_class_init(ObjectClass *klass, void *data)
+static void strongarm_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -448,7 +448,8 @@ static const VMStateDescription vmstate_strongarm_rtc_regs = {
     },
 };
 
-static void strongarm_rtc_sysbus_class_init(ObjectClass *klass, void *data)
+static void strongarm_rtc_sysbus_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -693,7 +694,7 @@ static const VMStateDescription vmstate_strongarm_gpio_regs = {
     },
 };
 
-static void strongarm_gpio_class_init(ObjectClass *klass, void *data)
+static void strongarm_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -865,7 +866,7 @@ static const VMStateDescription vmstate_strongarm_ppc_regs = {
     },
 };
 
-static void strongarm_ppc_class_init(ObjectClass *klass, void *data)
+static void strongarm_ppc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1336,7 +1337,7 @@ static const Property strongarm_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", StrongARMUARTState, chr),
 };
 
-static void strongarm_uart_class_init(ObjectClass *klass, void *data)
+static void strongarm_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1589,7 +1590,7 @@ static const VMStateDescription vmstate_strongarm_ssp_regs = {
     },
 };
 
-static void strongarm_ssp_class_init(ObjectClass *klass, void *data)
+static void strongarm_ssp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index bc4522989ec..ea873732ee5 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -409,7 +409,7 @@ static void vab_init(MachineState *machine)
     versatile_init(machine, 0x25e);
 }
 
-static void versatilepb_class_init(ObjectClass *oc, void *data)
+static void versatilepb_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -429,7 +429,7 @@ static const TypeInfo versatilepb_type = {
     .class_init = versatilepb_class_init,
 };
 
-static void versatileab_class_init(ObjectClass *oc, void *data)
+static void versatileab_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -457,7 +457,7 @@ static void versatile_machine_init(void)
 
 type_init(versatile_machine_init)
 
-static void vpb_sic_class_init(ObjectClass *klass, void *data)
+static void vpb_sic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index b886d16c023..744653f29b4 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -774,7 +774,7 @@ static void vexpress_a9_instance_init(Object *obj)
     vms->virt = false;
 }
 
-static void vexpress_class_init(ObjectClass *oc, void *data)
+static void vexpress_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -792,7 +792,7 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
                                           "Security Extensions (TrustZone)");
 }
 
-static void vexpress_a9_class_init(ObjectClass *oc, void *data)
+static void vexpress_a9_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a9"),
@@ -807,7 +807,7 @@ static void vexpress_a9_class_init(ObjectClass *oc, void *data)
     vmc->daughterboard = &a9_daughterboard;
 }
 
-static void vexpress_a15_class_init(ObjectClass *oc, void *data)
+static void vexpress_a15_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a15"),
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a5a9666e91..03ce6dcff4a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -105,7 +105,7 @@ static void arm_virt_compat_set(MachineClass *mc)
 #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
     static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
         ObjectClass *oc, \
-        void *data) \
+        const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         arm_virt_compat_set(mc); \
@@ -3079,7 +3079,7 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
-static void virt_machine_class_init(ObjectClass *oc, void *data)
+static void virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index d1509bd235d..4b26bcff7a5 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -49,7 +49,7 @@ static void xen_pvh_set_pci_intx_irq(void *opaque, int intx_irq, int level)
     }
 }
 
-static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
+static void xen_arm_machine_class_init(ObjectClass *oc, const void *data)
 {
     XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8477b828745..a46a9b08254 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -452,7 +452,7 @@ static void zynq_init(MachineState *machine)
     arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
 }
 
-static void zynq_machine_class_init(ObjectClass *oc, void *data)
+static void zynq_machine_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a9"),
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 1401d37959e..290bc309a3c 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -808,7 +808,7 @@ static void versal_virt_machine_finalize(Object *obj)
     g_free(s->ospi_model);
 }
 
-static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
+static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 278545a3f7b..12ff2c7c47a 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -977,7 +977,7 @@ static const Property versal_properties[] = {
                       TYPE_CAN_BUS, CanBusState *),
 };
 
-static void versal_class_init(ObjectClass *klass, void *data)
+static void versal_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 70fb444bbd9..0e6d276c626 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -267,7 +267,7 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
                              0);
 }
 
-static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
+static void xlnx_zcu102_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index bd5b0dd5e76..c36f9f8168d 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -869,7 +869,7 @@ static const Property xlnx_zynqmp_props[] = {
                      CanBusState *),
 };
 
-static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
+static void xlnx_zynqmp_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 05c573776ed..7454cc60deb 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1328,7 +1328,7 @@ static const Property ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
 };
 
-static void ac97_class_init(ObjectClass *klass, void *data)
+static void ac97_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 8c9767b5372..1f29a7e319d 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -303,7 +303,7 @@ static const Property adlib_properties[] = {
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
 };
 
-static void adlib_class_initfn (ObjectClass *klass, void *data)
+static void adlib_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS (klass);
 
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index cc205bf063e..e4d3fbdd527 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -700,7 +700,7 @@ static const Property asc_properties[] = {
     DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
 };
 
-static void asc_class_init(ObjectClass *oc, void *data)
+static void asc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 8321f89c882..97cceb44d86 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -160,7 +160,7 @@ static void cs4231_init(Object *obj)
     sysbus_init_irq(dev, &s->irq);
 }
 
-static void cs4231_class_init(ObjectClass *klass, void *data)
+static void cs4231_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 5a9be80ba3b..06b44da8690 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -696,7 +696,7 @@ static const Property cs4231a_properties[] = {
     DEFINE_PROP_UINT32 ("dma",     CSState, dma,  3),
 };
 
-static void cs4231a_class_initfn (ObjectClass *klass, void *data)
+static void cs4231a_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS (klass);
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 75f71e5d78e..322b7798149 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -872,7 +872,7 @@ static const Property es1370_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
 };
 
-static void es1370_class_init (ObjectClass *klass, void *data)
+static void es1370_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS (klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index e718c1183e8..87e86348937 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -298,7 +298,7 @@ static const Property gus_properties[] = {
     DEFINE_PROP_UINT32 ("dma",     GUSState, emu.gusdma,  3),
 };
 
-static void gus_class_initfn (ObjectClass *klass, void *data)
+static void gus_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS (klass);
 
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 6f3a8f691bf..66edad280f2 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -900,7 +900,7 @@ static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
     hda_audio_init(hda, desc, errp);
 }
 
-static void hda_audio_base_class_init(ObjectClass *klass, void *data)
+static void hda_audio_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     HDACodecDeviceClass *k = HDA_CODEC_DEVICE_CLASS(klass);
@@ -922,7 +922,7 @@ static const TypeInfo hda_audio_info = {
     .abstract      = true,
 };
 
-static void hda_audio_output_class_init(ObjectClass *klass, void *data)
+static void hda_audio_output_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     HDACodecDeviceClass *k = HDA_CODEC_DEVICE_CLASS(klass);
@@ -937,7 +937,7 @@ static const TypeInfo hda_audio_output_info = {
     .class_init    = hda_audio_output_class_init,
 };
 
-static void hda_audio_duplex_class_init(ObjectClass *klass, void *data)
+static void hda_audio_duplex_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     HDACodecDeviceClass *k = HDA_CODEC_DEVICE_CLASS(klass);
@@ -952,7 +952,7 @@ static const TypeInfo hda_audio_duplex_info = {
     .class_init    = hda_audio_duplex_class_init,
 };
 
-static void hda_audio_micro_class_init(ObjectClass *klass, void *data)
+static void hda_audio_micro_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     HDACodecDeviceClass *k = HDA_CODEC_DEVICE_CLASS(klass);
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 3214992ddc5..2f1b08e9c1c 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1220,7 +1220,7 @@ static const Property intel_hda_properties[] = {
     DEFINE_PROP_BOOL("old_msi_addr", IntelHDAState, old_msi_addr, false),
 };
 
-static void intel_hda_class_init(ObjectClass *klass, void *data)
+static void intel_hda_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1234,7 +1234,7 @@ static void intel_hda_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, intel_hda_properties);
 }
 
-static void intel_hda_class_init_ich6(ObjectClass *klass, void *data)
+static void intel_hda_class_init_ich6(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1245,7 +1245,7 @@ static void intel_hda_class_init_ich6(ObjectClass *klass, void *data)
     dc->desc = "Intel HD Audio Controller (ich6)";
 }
 
-static void intel_hda_class_init_ich9(ObjectClass *klass, void *data)
+static void intel_hda_class_init_ich9(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1280,7 +1280,7 @@ static const TypeInfo intel_hda_info_ich9 = {
     .class_init    = intel_hda_class_init_ich9,
 };
 
-static void hda_codec_device_class_init(ObjectClass *klass, void *data)
+static void hda_codec_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = hda_codec_dev_realize;
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 28f9af320de..6d3ebbb0c82 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -287,7 +287,7 @@ static const VMStateDescription mv88w8618_audio_vmsd = {
     }
 };
 
-static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
+static void mv88w8618_audio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 17be1855474..a419161b5b1 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -221,7 +221,7 @@ static const Property pcspk_properties[] = {
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
 };
 
-static void pcspk_class_initfn(ObjectClass *klass, void *data)
+static void pcspk_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index f771d725fa6..5d9d6c1178b 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -632,7 +632,7 @@ static const Property pl041_device_properties[] = {
                        DEFAULT_FIFO_DEPTH),
 };
 
-static void pl041_device_class_init(ObjectClass *klass, void *data)
+static void pl041_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 0c661b4947b..19fd3b90205 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1449,7 +1449,7 @@ static const Property sb16_properties[] = {
     DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
 };
 
-static void sb16_class_initfn (ObjectClass *klass, void *data)
+static void sb16_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS (klass);
 
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 4e115e011e8..5feef663d8c 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -463,7 +463,7 @@ static const Property via_ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ViaAC97State, card),
 };
 
-static void via_ac97_class_init(ObjectClass *klass, void *data)
+static void via_ac97_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -501,7 +501,7 @@ static void via_mc97_realize(PCIDevice *pci_dev, Error **errp)
     pci_set_long(pci_dev->config + PCI_INTERRUPT_PIN, 0x03);
 }
 
-static void via_mc97_class_init(ObjectClass *klass, void *data)
+static void via_mc97_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index 74d93f4e9c9..9eb00073920 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -42,7 +42,7 @@ static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_snd_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 0b47741f013..eca3319e59f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1361,7 +1361,7 @@ static void virtio_snd_reset(VirtIODevice *vdev)
     }
 }
 
-static void virtio_snd_class_init(ObjectClass *klass, void *data)
+static void virtio_snd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 8d381dbc658..2846b55fe2a 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -710,7 +710,7 @@ static const Property wm8750_properties[] = {
     DEFINE_AUDIO_PROPERTIES(WM8750State, card),
 };
 
-static void wm8750_class_init(ObjectClass *klass, void *data)
+static void wm8750_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 48ef478346e..e166ca18e11 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -56,7 +56,7 @@ static void arduino_machine_init(MachineState *machine)
     }
 }
 
-static void arduino_machine_class_init(ObjectClass *oc, void *data)
+static void arduino_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -69,7 +69,7 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
 }
 
-static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
+static void arduino_duemilanove_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
@@ -84,7 +84,7 @@ static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
-static void arduino_uno_class_init(ObjectClass *oc, void *data)
+static void arduino_uno_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
@@ -99,7 +99,7 @@ static void arduino_uno_class_init(ObjectClass *oc, void *data)
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
-static void arduino_mega_class_init(ObjectClass *oc, void *data)
+static void arduino_mega_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
@@ -114,7 +114,7 @@ static void arduino_mega_class_init(ObjectClass *oc, void *data)
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
-static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
+static void arduino_mega2560_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index f6844bf118e..3de35d80778 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -360,7 +360,7 @@ static const Property atmega_props[] = {
                        xtal_freq_hz, 0),
 };
 
-static void atmega_class_init(ObjectClass *oc, void *data)
+static void atmega_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -370,7 +370,7 @@ static void atmega_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
-static void atmega168_class_init(ObjectClass *oc, void *data)
+static void atmega168_class_init(ObjectClass *oc, const void *data)
 {
     AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
 
@@ -385,7 +385,7 @@ static void atmega168_class_init(ObjectClass *oc, void *data)
     amc->dev = dev168_328;
 };
 
-static void atmega328_class_init(ObjectClass *oc, void *data)
+static void atmega328_class_init(ObjectClass *oc, const void *data)
 {
     AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
 
@@ -400,7 +400,7 @@ static void atmega328_class_init(ObjectClass *oc, void *data)
     amc->dev = dev168_328;
 };
 
-static void atmega1280_class_init(ObjectClass *oc, void *data)
+static void atmega1280_class_init(ObjectClass *oc, const void *data)
 {
     AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
 
@@ -415,7 +415,7 @@ static void atmega1280_class_init(ObjectClass *oc, void *data)
     amc->dev = dev1280_2560;
 };
 
-static void atmega2560_class_init(ObjectClass *oc, void *data)
+static void atmega2560_class_init(ObjectClass *oc, const void *data)
 {
     AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
 
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index a10c24aab10..1d32a66d3b7 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -298,7 +298,7 @@ static const Property isa_fdc_properties[] = {
                         FloppyDriveType),
 };
 
-static void isabus_fdc_class_init(ObjectClass *klass, void *data)
+static void isabus_fdc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 381b492aec9..496120e3687 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -176,7 +176,7 @@ static const VMStateDescription vmstate_sysbus_fdc = {
     }
 };
 
-static void sysbus_fdc_common_class_init(ObjectClass *klass, void *data)
+static void sysbus_fdc_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -208,7 +208,7 @@ static const Property sysbus_fdc_properties[] = {
                         FloppyDriveType),
 };
 
-static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
+static void sysbus_fdc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -231,7 +231,7 @@ static const Property sun4m_fdc_properties[] = {
                         FloppyDriveType),
 };
 
-static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
+static void sun4m_fdc_class_init(ObjectClass *klass, const void *data)
 {
     FDCtrlSysBusClass *sbdc = SYSBUS_FDC_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2df941d3f4f..d0f08c7be54 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -553,7 +553,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     fd_revalidate(drive);
 }
 
-static void floppy_drive_class_init(ObjectClass *klass, void *data)
+static void floppy_drive_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = floppy_drive_realize;
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b84c6afb327..236fa798c34 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -528,7 +528,7 @@ struct Flash {
 
 struct M25P80Class {
     SSIPeripheralClass parent_class;
-    FlashPartInfo *pi;
+    const FlashPartInfo *pi;
 };
 
 OBJECT_DECLARE_TYPE(Flash, M25P80Class, M25P80)
@@ -1857,7 +1857,7 @@ static const VMStateDescription vmstate_m25p80 = {
     }
 };
 
-static void m25p80_class_init(ObjectClass *klass, void *data)
+static void m25p80_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
diff --git a/hw/block/nand.c b/hw/block/nand.c
index e98c55b729c..c80bf78fe58 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -451,7 +451,7 @@ static const Property nand_properties[] = {
     DEFINE_PROP_DRIVE("drive", NANDFlashState, blk),
 };
 
-static void nand_class_init(ObjectClass *klass, void *data)
+static void nand_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index b5ea927f360..168101d8dfe 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -934,7 +934,7 @@ static const Property pflash_cfi01_properties[] = {
                      old_multiple_chip_handling, false),
 };
 
-static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
+static void pflash_cfi01_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 315a53629a0..3244b699b98 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -968,7 +968,7 @@ static void pflash_cfi02_unrealize(DeviceState *dev)
     g_free(pfl->sector_erase_map);
 }
 
-static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
+static void pflash_cfi02_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 4645468dcf0..ad047362f88 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -253,7 +253,7 @@ static void swim_drive_realize(DeviceState *qdev, Error **errp)
     blk_set_dev_ops(drive->blk, &swim_block_ops, drive);
 }
 
-static void swim_drive_class_init(ObjectClass *klass, void *data)
+static void swim_drive_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = swim_drive_realize;
@@ -550,7 +550,7 @@ static const VMStateDescription vmstate_sysbus_swim = {
     }
 };
 
-static void sysbus_swim_class_init(ObjectClass *oc, void *data)
+static void sysbus_swim_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index ae42327cf8d..4bb5ed299e7 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -583,7 +583,7 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
 };
 
-static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
+static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a1829e3abdf..724409c8a8e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -2002,7 +2002,7 @@ static const Property virtio_blk_properties[] = {
                      conf.x_enable_wce_if_config_wce, true),
 };
 
-static void virtio_blk_class_init(ObjectClass *klass, void *data)
+static void virtio_blk_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 6c26052561a..05dd8d3181b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -677,7 +677,7 @@ static const Property xen_block_props[] = {
                      TYPE_IOTHREAD, IOThread *),
 };
 
-static void xen_block_class_init(ObjectClass *class, void *data)
+static void xen_block_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
@@ -722,7 +722,7 @@ static void xen_disk_realize(XenBlockDevice *blockdev, Error **errp)
     blockdev->info = blk_supports_write_perm(conf->blk) ? 0 : VDISK_READONLY;
 }
 
-static void xen_disk_class_init(ObjectClass *class, void *data)
+static void xen_disk_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);
@@ -769,7 +769,7 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
     blockdev->info = VDISK_READONLY | VDISK_CDROM;
 }
 
-static void xen_cdrom_class_init(ObjectClass *class, void *data)
+static void xen_cdrom_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index e8012cae3ad..fae15217e9f 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -295,7 +295,7 @@ static void avr_usart_realize(DeviceState *dev, Error **errp)
     avr_usart_reset(dev);
 }
 
-static void avr_usart_class_init(ObjectClass *klass, void *data)
+static void avr_usart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 73ad5934067..f51ddd39cf2 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -294,7 +294,7 @@ static const Property bcm2835_aux_props[] = {
     DEFINE_PROP_CHR("chardev", BCM2835AuxState, chr),
 };
 
-static void bcm2835_aux_class_init(ObjectClass *oc, void *data)
+static void bcm2835_aux_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index ebd846a083b..0dfa356b6d0 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -621,7 +621,7 @@ static const Property cadence_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
 };
 
-static void cadence_uart_class_init(ObjectClass *klass, void *data)
+static void cadence_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 0506500215f..32090f3516f 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -382,7 +382,7 @@ static const Property cmsdk_apb_uart_properties[] = {
     DEFINE_PROP_UINT32("pclk-frq", CMSDKAPBUART, pclk_frq, 0),
 };
 
-static void cmsdk_apb_uart_class_init(ObjectClass *klass, void *data)
+static void cmsdk_apb_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 1bc3bf85fea..bf44aaf9e4a 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -120,7 +120,7 @@ static const Property debugcon_isa_properties[] = {
     DEFINE_PROP_UINT32("readback", ISADebugconState, state.readback, 0xe9),
 };
 
-static void debugcon_isa_class_initfn(ObjectClass *klass, void *data)
+static void debugcon_isa_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index b0b0714e0f7..0f6af51bb7b 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -176,7 +176,7 @@ static const Property digic_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", DigicUartState, chr),
 };
 
-static void digic_uart_class_init(ObjectClass *klass, void *data)
+static void digic_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index ecec1f7bb11..9a623d680b3 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -183,7 +183,7 @@ static const Property diva_serial_properties[] = {
                                     PCI_DEVICE_ID_HP_DIVA_TOSCA1),
 };
 
-static void diva_serial_class_initfn(ObjectClass *klass, void *data)
+static void diva_serial_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
@@ -242,7 +242,7 @@ static void diva_aux_exit(PCIDevice *dev)
     qemu_free_irq(pci->irq);
 }
 
-static void diva_aux_class_initfn(ObjectClass *klass, void *data)
+static void diva_aux_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
diff --git a/hw/char/escc.c b/hw/char/escc.c
index a5fdd8f6986..afe4ca483e7 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -1101,7 +1101,7 @@ static const Property escc_properties[] = {
     DEFINE_PROP_STRING("chnA-sunkbd-layout", ESCCState, chn[1].sunkbd_layout),
 };
 
-static void escc_class_init(ObjectClass *klass, void *data)
+static void escc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index a1a9a12cafe..6521b4cedd9 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -711,7 +711,7 @@ static const Property exynos4210_uart_properties[] = {
     DEFINE_PROP_UINT32("tx-size", Exynos4210UartState, tx.size, 16),
 };
 
-static void exynos4210_uart_class_init(ObjectClass *klass, void *data)
+static void exynos4210_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 73745611419..6dd38da6cac 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -256,7 +256,7 @@ static void goldfish_tty_instance_init(Object *obj)
     sysbus_init_irq(dev, &s->irq);
 }
 
-static void goldfish_tty_class_init(ObjectClass *oc, void *data)
+static void goldfish_tty_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index db6bcdad41b..81c26e33899 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -281,7 +281,7 @@ static const Property grlib_apbuart_properties[] = {
     DEFINE_PROP_CHR("chrdev", UART, chr),
 };
 
-static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
+static void grlib_apbuart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 392375ad551..d6f0d18c777 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -542,7 +542,7 @@ static void ibex_uart_realize(DeviceState *dev, Error **errp)
                              s, NULL, true);
 }
 
-static void ibex_uart_class_init(ObjectClass *klass, void *data)
+static void ibex_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 38b4865157e..55a5d5bb7d4 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -463,7 +463,7 @@ static const Property imx_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", IMXSerialState, chr),
 };
 
-static void imx_serial_class_init(ObjectClass *klass, void *data)
+static void imx_serial_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index a2879977fb3..752c6c818ab 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -569,7 +569,7 @@ static const Property ipoctal_properties[] = {
     DEFINE_PROP_CHR("chardev7", IPOctalState, ch[7].dev),
 };
 
-static void ipoctal_class_init(ObjectClass *klass, void *data)
+static void ipoctal_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IPackDeviceClass *ic = IPACK_DEVICE_CLASS(klass);
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 980a12fcb7d..8611433b280 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -316,7 +316,7 @@ static const Property mcf_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", mcf_uart_state, chr),
 };
 
-static void mcf_uart_class_init(ObjectClass *oc, void *data)
+static void mcf_uart_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
index 3c3224c05d9..6149f9d2047 100644
--- a/hw/char/mchp_pfsoc_mmuart.c
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -121,7 +121,7 @@ static const VMStateDescription mchp_pfsoc_mmuart_vmstate = {
     }
 };
 
-static void mchp_pfsoc_mmuart_class_init(ObjectClass *oc, void *data)
+static void mchp_pfsoc_mmuart_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 82a61ee95f2..41d423446f3 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -308,7 +308,7 @@ static const Property nrf51_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", NRF51UARTState, chr),
 };
 
-static void nrf51_uart_class_init(ObjectClass *klass, void *data)
+static void nrf51_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index e1651d52a49..217ddaf2e3e 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -610,7 +610,7 @@ static const Property parallel_isa_properties[] = {
     DEFINE_PROP_CHR("chardev",  ISAParallelState, state.chr),
 };
 
-static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
+static void parallel_isa_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 06ce851044d..1b9e7b91ef4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -654,7 +654,7 @@ static void pl011_reset(DeviceState *dev)
     pl011_reset_tx_fifo(s);
 }
 
-static void pl011_class_init(ObjectClass *oc, void *data)
+static void pl011_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index ea944949320..b9d0ed1c89b 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -324,7 +324,7 @@ static const Property rsci_properties[] = {
     DEFINE_PROP_CHR("chardev", RSCIState, chr),
 };
 
-static void rsci_class_init(ObjectClass *klass, void *data)
+static void rsci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index ddb9a726d5a..e9580aacba8 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -339,7 +339,7 @@ static const Property console_properties[] = {
     DEFINE_PROP_BOOL("echo", SCLPConsoleLM, echo, true),
 };
 
-static void console_class_init(ObjectClass *klass, void *data)
+static void console_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *ec = SCLP_EVENT_CLASS(klass);
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 01233b933d8..95e3045178e 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -255,7 +255,7 @@ static const Property console_properties[] = {
     DEFINE_PROP_CHR("chardev", SCLPConsole, chr),
 };
 
-static void console_class_init(ObjectClass *klass, void *data)
+static void console_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *ec = SCLP_EVENT_CLASS(klass);
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 3d913891dcb..fe7fb1625b5 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -119,7 +119,7 @@ static const Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
 };
 
-static void serial_isa_class_initfn(ObjectClass *klass, void *data)
+static void serial_isa_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 6338e7c0ba8..13aba780ec5 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -134,7 +134,7 @@ static const Property serial_mm_properties[] = {
     DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_ENDIAN),
 };
 
-static void serial_mm_class_init(ObjectClass *oc, void *data)
+static void serial_mm_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 718ae251317..ee1c0f7dc4f 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -144,7 +144,8 @@ static const Property multi_4x_serial_pci_properties[] = {
     DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
 };
 
-static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
+static void multi_2x_serial_pci_class_initfn(ObjectClass *klass,
+                                             const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
@@ -159,7 +160,8 @@ static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
-static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *data)
+static void multi_4x_serial_pci_class_initfn(ObjectClass *klass,
+                                             const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 6659cef5d4b..bd38c7428c6 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -85,7 +85,7 @@ static const Property serial_pci_properties[] = {
     DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
 };
 
-static void serial_pci_class_initfn(ObjectClass *klass, void *data)
+static void serial_pci_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 70044e14a0f..03fec3fe75b 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -970,7 +970,7 @@ static const Property serial_properties[] = {
     DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
 };
 
-static void serial_class_init(ObjectClass *klass, void* data)
+static void serial_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 247aeb071ac..12ae9bd24d2 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -452,7 +452,7 @@ static const Property sh_serial_properties[] = {
     DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
 };
 
-static void sh_serial_class_init(ObjectClass *oc, void *data)
+static void sh_serial_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 09975d9d349..6e216edb0fc 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -161,7 +161,7 @@ static const Property shakti_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", ShaktiUartState, chr),
 };
 
-static void shakti_uart_class_init(ObjectClass *klass, void *data)
+static void shakti_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     device_class_set_legacy_reset(dc, shakti_uart_reset);
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 4bc5767284b..4acbdfa5f77 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -323,7 +323,7 @@ static const VMStateDescription vmstate_sifive_uart = {
 };
 
 
-static void sifive_uart_class_init(ObjectClass *oc, void *data)
+static void sifive_uart_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 6451d010ac7..fc8ea604f8d 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -182,7 +182,7 @@ static const VMStateDescription vmstate_spapr_vty = {
     },
 };
 
-static void spapr_vty_class_init(ObjectClass *klass, void *data)
+static void spapr_vty_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 87882daa715..45c30643a74 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -220,7 +220,7 @@ static void stm32f2xx_usart_realize(DeviceState *dev, Error **errp)
                              s, NULL, true);
 }
 
-static void stm32f2xx_usart_class_init(ObjectClass *klass, void *data)
+static void stm32f2xx_usart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index bcc310bd97b..afbe4bab29d 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -594,7 +594,8 @@ static void stm32l4x5_usart_base_realize(DeviceState *dev, Error **errp)
                              s, NULL, true);
 }
 
-static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_usart_base_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -605,21 +606,21 @@ static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_stm32l4x5_usart_base;
 }
 
-static void stm32l4x5_usart_class_init(ObjectClass *oc, void *data)
+static void stm32l4x5_usart_class_init(ObjectClass *oc, const void *data)
 {
     Stm32l4x5UsartBaseClass *subc = STM32L4X5_USART_BASE_CLASS(oc);
 
     subc->type = STM32L4x5_USART;
 }
 
-static void stm32l4x5_uart_class_init(ObjectClass *oc, void *data)
+static void stm32l4x5_uart_class_init(ObjectClass *oc, const void *data)
 {
     Stm32l4x5UsartBaseClass *subc = STM32L4X5_USART_BASE_CLASS(oc);
 
     subc->type = STM32L4x5_UART;
 }
 
-static void stm32l4x5_lpuart_class_init(ObjectClass *oc, void *data)
+static void stm32l4x5_lpuart_class_init(ObjectClass *oc, const void *data)
 {
     Stm32l4x5UsartBaseClass *subc = STM32L4X5_USART_BASE_CLASS(oc);
 
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 04ee26dcbd3..d950c172921 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -292,7 +292,7 @@ static const VMStateDescription terminal3270_vmstate = {
     .unmigratable = 1,
 };
 
-static void terminal_class_init(ObjectClass *klass, void *data)
+static void terminal_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     EmulatedCcw3270Class *ck = EMULATED_CCW_3270_CLASS(klass);
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index aa6d611a475..0932a3572b7 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -261,7 +261,7 @@ static void virtconsole_unrealize(DeviceState *dev)
     }
 }
 
-static void virtconsole_class_init(ObjectClass *klass, void *data)
+static void virtconsole_class_init(ObjectClass *klass, const void *data)
 {
     VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_CLASS(klass);
 
@@ -278,7 +278,7 @@ static const Property virtserialport_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtConsole, chr),
 };
 
-static void virtserialport_class_init(ObjectClass *klass, void *data)
+static void virtserialport_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_CLASS(klass);
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index b6d2743a9c6..00572873d28 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -840,7 +840,7 @@ static const Property virtser_props[] = {
     DEFINE_PROP_STRING("name", VirtIOSerialPort, name),
 };
 
-static void virtser_bus_class_init(ObjectClass *klass, void *data)
+static void virtser_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     k->print_dev = virtser_bus_dev_print;
@@ -1092,7 +1092,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
     QLIST_INSERT_HEAD(&vserdevices.devices, vser, next);
 }
 
-static void virtio_serial_port_class_init(ObjectClass *klass, void *data)
+static void virtio_serial_port_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
@@ -1159,7 +1159,7 @@ static const Property virtio_serial_properties[] = {
                       VIRTIO_CONSOLE_F_EMERG_WRITE, true),
 };
 
-static void virtio_serial_class_init(ObjectClass *klass, void *data)
+static void virtio_serial_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index d03c188d1d5..9c34a554bfa 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -492,7 +492,7 @@ static const Property xen_console_properties[] = {
     DEFINE_PROP_INT32("idx", XenConsole, dev, -1),
 };
 
-static void xen_console_class_init(ObjectClass *class, void *data)
+static void xen_console_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 56955e0d74a..ec3b89dc189 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -229,7 +229,7 @@ static void xilinx_uartlite_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-static void xilinx_uartlite_class_init(ObjectClass *klass, void *data)
+static void xilinx_uartlite_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/core/bus.c b/hw/core/bus.c
index b9d89495cdf..c3b431a014b 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -232,7 +232,7 @@ static char *default_bus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
 
-static void bus_class_init(ObjectClass *class, void *data)
+static void bus_class_init(ObjectClass *class, const void *data)
 {
     BusClass *bc = BUS_CLASS(class);
     ResettableClass *rc = RESETTABLE_CLASS(class);
diff --git a/hw/core/clock.c b/hw/core/clock.c
index a81f888e62a..9c906761e19 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -206,7 +206,7 @@ static void clock_finalizefn(Object *obj)
     g_free(clk->canonical_path);
 }
 
-static void clock_class_init(ObjectClass *klass, void *data)
+static void clock_class_init(ObjectClass *klass, const void *data)
 {
     klass->unparent = clock_unparent;
 }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cb79566cc51..2a12bd25702 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -298,7 +298,7 @@ static int64_t cpu_common_get_arch_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
-static void cpu_common_class_init(ObjectClass *klass, void *data)
+static void cpu_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index d9f5c2e8325..ee77bdc6ff5 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -185,7 +185,7 @@ static const Property generic_loader_props[] = {
     DEFINE_PROP_STRING("file", GenericLoaderState, file),
 };
 
-static void generic_loader_class_init(ObjectClass *klass, void *data)
+static void generic_loader_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 76271df9f57..3db89d7a2e1 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -118,7 +118,7 @@ static const Property guest_loader_props[] = {
     DEFINE_PROP_STRING("initrd", GuestLoaderState, initrd),
 };
 
-static void guest_loader_class_init(ObjectClass *klass, void *data)
+static void guest_loader_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7bdde9286c2..39866fc37a8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1093,7 +1093,7 @@ out:
     return r;
 }
 
-static void machine_class_init(ObjectClass *oc, void *data)
+static void machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 4d0d3cabf1e..3942c709939 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -119,7 +119,7 @@ static const Property or_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", OrIRQState, num_lines, 1),
 };
 
-static void or_irq_class_init(ObjectClass *klass, void *data)
+static void or_irq_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 1d00c4d36d0..6950063de4f 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -209,7 +209,7 @@ static const Property platform_bus_properties[] = {
     DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
 };
 
-static void platform_bus_class_init(ObjectClass *klass, void *data)
+static void platform_bus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1e0f47cc848..4a3760c101e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -731,7 +731,7 @@ device_vmstate_if_get_id(VMStateIf *obj)
     return qdev_get_dev_path(dev);
 }
 
-static void device_class_init(ObjectClass *class, void *data)
+static void device_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     VMStateIfClass *vc = VMSTATE_IF_CLASS(class);
diff --git a/hw/core/register.c b/hw/core/register.c
index 95b0150c0aa..8f63d9f227c 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -319,7 +319,7 @@ void register_finalize_block(RegisterInfoArray *r_array)
     g_free(r_array);
 }
 
-static void register_class_init(ObjectClass *oc, void *data)
+static void register_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 8a3e0e518f0..65f82fa43d9 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -84,7 +84,7 @@ static void legacy_reset_finalize(Object *obj)
 {
 }
 
-static void legacy_reset_class_init(ObjectClass *klass, void *data)
+static void legacy_reset_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
index e4ece68e83a..5ff17002e75 100644
--- a/hw/core/resetcontainer.c
+++ b/hw/core/resetcontainer.c
@@ -68,7 +68,8 @@ static void resettable_container_finalize(Object *obj)
 {
 }
 
-static void resettable_container_class_init(ObjectClass *klass, void *data)
+static void resettable_container_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index fc12274811b..f8b48750c5b 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -63,7 +63,7 @@ static const Property split_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", SplitIRQ, num_lines, 1),
 };
 
-static void split_irq_class_init(ObjectClass *klass, void *data)
+static void split_irq_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9355849ff0a..8cc8ee47a98 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -72,7 +72,7 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque)
 }
 
 
-static void system_bus_class_init(ObjectClass *klass, void *data)
+static void system_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
@@ -288,7 +288,7 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(qdev_fw_name(dev));
 }
 
-static void sysbus_device_class_init(ObjectClass *klass, void *data)
+static void sysbus_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = sysbus_device_realize;
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index d24ab0a6ab2..5c76290c917 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -155,7 +155,7 @@ static const Property a15mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 160),
 };
 
-static void a15mp_priv_class_init(ObjectClass *klass, void *data)
+static void a15mp_priv_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 25416c5032b..47415092318 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -169,7 +169,7 @@ static const Property a9mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
 };
 
-static void a9mp_priv_class_init(ObjectClass *klass, void *data)
+static void a9mp_priv_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index b56bee6d543..01772e7f77b 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -144,7 +144,7 @@ static const Property mpcore_priv_properties[] = {
     DEFINE_PROP_UINT32("num-irq", ARM11MPCorePriveState, num_irq, 64),
 };
 
-static void mpcore_priv_class_init(ObjectClass *klass, void *data)
+static void mpcore_priv_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 9da5221f88b..ef3b3d1e940 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -72,7 +72,7 @@ static void cpu_cluster_realize(DeviceState *dev, Error **errp)
     assert(cbdata.cpu_count > 0);
 }
 
-static void cpu_cluster_class_init(ObjectClass *klass, void *data)
+static void cpu_cluster_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 495a5c30ffe..5cb2e9a7f54 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -77,7 +77,7 @@ static void cpu_core_instance_init(Object *obj)
     }
 }
 
-static void cpu_core_class_init(ObjectClass *oc, void *data)
+static void cpu_core_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index b1408886184..099b71a9ef2 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -107,7 +107,7 @@ static void mpcore_rirq_init(Object *obj)
     }
 }
 
-static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
+static void mpcore_rirq_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 65cdac6cc13..c57bf555f97 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -70,7 +70,7 @@ static const Property cxl_switch_cci_props[] = {
                      target, TYPE_CXL_USP, PCIDevice *),
 };
 
-static void cswmbcci_class_init(ObjectClass *oc, void *data)
+static void cswmbcci_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/display/artist.c b/hw/display/artist.c
index f24c1d83dd1..3fafc8a222b 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1487,7 +1487,7 @@ static void artist_reset(DeviceState *qdev)
 {
 }
 
-static void artist_class_init(ObjectClass *klass, void *data)
+static void artist_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 864fa4fc2ce..4e88d099431 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1049,7 +1049,7 @@ static const Property ati_vga_properties[] = {
     DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
 };
 
-static void ati_vga_class_init(ObjectClass *klass, void *data)
+static void ati_vga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index a5bded5156a..820e67ac8bb 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -442,7 +442,7 @@ static const Property bcm2835_fb_props[] = {
                        initial_config.alpha, 2), /* alpha ignored */
 };
 
-static void bcm2835_fb_class_init(ObjectClass *klass, void *data)
+static void bcm2835_fb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 086f7a0f06c..1d329fc9cce 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -351,7 +351,7 @@ static const Property bochs_display_properties[] = {
     DEFINE_EDID_PROPERTIES(BochsDisplayState, edid_info),
 };
 
-static void bochs_display_class_init(ObjectClass *klass, void *data)
+static void bochs_display_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 3f971d875f8..daeef152174 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -368,7 +368,7 @@ static const Property cg3_properties[] = {
     DEFINE_PROP_UINT16("depth",        CG3State, depth,     -1),
 };
 
-static void cg3_class_init(ObjectClass *klass, void *data)
+static void cg3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 76124d3656e..4e5ae04af0f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2991,7 +2991,7 @@ static const Property pci_vga_cirrus_properties[] = {
                      cirrus_vga.vga.global_vmstate, false),
 };
 
-static void cirrus_vga_class_init(ObjectClass *klass, void *data)
+static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 60b7fd20f1e..4b55c48eff8 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -76,7 +76,7 @@ static const Property isa_cirrus_vga_properties[] = {
                      cirrus_vga.enable_blitter, true),
 };
 
-static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
+static void isa_cirrus_vga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index 75a91f62bd3..7af0cc27485 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -325,7 +325,7 @@ static void dm163_realize(DeviceState *dev, Error **errp)
                         RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
 }
 
-static void dm163_class_init(ObjectClass *klass, void *data)
+static void dm163_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 108faf7887b..a157dc64e76 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -141,7 +141,7 @@ static const VMStateDescription vmstate_dpcd = {
     }
 };
 
-static void dpcd_class_init(ObjectClass *oc, void *data)
+static void dpcd_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 04c864a3084..c61e0280a7c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1958,7 +1958,7 @@ static void exynos4210_fimd_realize(DeviceState *dev, Error **errp)
     s->console = graphic_console_init(dev, 0, &exynos4210_fimd_ops, s);
 }
 
-static void exynos4210_fimd_class_init(ObjectClass *klass, void *data)
+static void exynos4210_fimd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 30b5ea67f26..a6ddc21d3e4 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -526,7 +526,7 @@ static const VMStateDescription vmstate_g364fb_sysbus = {
     }
 };
 
-static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
+static void g364fb_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index d8ab9eee405..2adfc1a1472 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -99,7 +99,7 @@ static const Property i2c_ddc_properties[] = {
     DEFINE_EDID_PROPERTIES(I2CDDCState, edid_info),
 };
 
-static void i2c_ddc_class_init(ObjectClass *oc, void *data)
+static void i2c_ddc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 1448488d063..90e82b58be2 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -294,7 +294,7 @@ static void jazz_led_reset(DeviceState *d)
     qemu_console_resize(s->con, 60, 80);
 }
 
-static void jazz_led_class_init(ObjectClass *klass, void *data)
+static void jazz_led_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index e83fc863be5..c2f5c9300e8 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -794,7 +794,7 @@ static const VMStateDescription vmstate_macfb_nubus = {
     }
 };
 
-static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
+static void macfb_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -805,7 +805,7 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, macfb_sysbus_properties);
 }
 
-static void macfb_nubus_class_init(ObjectClass *klass, void *data)
+static void macfb_nubus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     MacfbNubusDeviceClass *ndc = NUBUS_MACFB_CLASS(klass);
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
index 8446ff3c00e..ec81b766a7e 100644
--- a/hw/display/next-fb.c
+++ b/hw/display/next-fb.c
@@ -119,7 +119,7 @@ static void nextfb_realize(DeviceState *dev, Error **errp)
     qemu_console_resize(s->con, s->cols, s->rows);
 }
 
-static void nextfb_class_init(ObjectClass *oc, void *data)
+static void nextfb_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 4d4f477b943..09c3c59e0ed 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -580,7 +580,7 @@ static void pl111_init(Object *obj)
     s->version = VERSION_PL111;
 }
 
-static void pl110_class_init(ObjectClass *klass, void *data)
+static void pl110_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 2efdc77e613..0e4612d55aa 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2477,7 +2477,7 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmstate, false),
 };
 
-static void qxl_pci_class_init(ObjectClass *klass, void *data)
+static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -2502,7 +2502,7 @@ static const TypeInfo qxl_pci_type_info = {
     },
 };
 
-static void qxl_primary_class_init(ObjectClass *klass, void *data)
+static void qxl_primary_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -2522,7 +2522,7 @@ static const TypeInfo qxl_primary_info = {
 module_obj("qxl-vga");
 module_kconfig(QXL);
 
-static void qxl_secondary_class_init(ObjectClass *klass, void *data)
+static void qxl_secondary_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 6c35028965d..d4fe60fcce6 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -64,7 +64,7 @@ static const Property ramfb_properties[] = {
     DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
 };
 
-static void ramfb_class_initfn(ObjectClass *klass, void *data)
+static void ramfb_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 16f8cb487cd..d00d3e9fc54 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -167,7 +167,7 @@ static void sii9022_realize(DeviceState *dev, Error **errp)
     i2c_slave_create_simple(bus, TYPE_I2CDDC, 0x50);
 }
 
-static void sii9022_class_init(ObjectClass *klass, void *data)
+static void sii9022_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 09edcf86f8e..dcff1e978ed 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2077,7 +2077,7 @@ static const VMStateDescription vmstate_sm501_sysbus = {
      }
 };
 
-static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
+static void sm501_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -2167,7 +2167,7 @@ static const VMStateDescription vmstate_sm501_pci = {
      }
 };
 
-static void sm501_pci_class_init(ObjectClass *klass, void *data)
+static void sm501_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index e292cff44ea..87781438cd5 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -311,7 +311,7 @@ static void ssd0303_realize(DeviceState *dev, Error **errp)
     qemu_console_resize(s->con, 96 * MAGNIFY, 16 * MAGNIFY);
 }
 
-static void ssd0303_class_init(ObjectClass *klass, void *data)
+static void ssd0303_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index 96cf0dc662b..af5ff4fecdc 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -361,7 +361,7 @@ static void ssd0323_realize(SSIPeripheral *d, Error **errp)
     qdev_init_gpio_in(dev, ssd0323_cd, 1);
 }
 
-static void ssd0323_class_init(ObjectClass *klass, void *data)
+static void ssd0323_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 2cfc1e8f01d..190af38138f 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -886,7 +886,7 @@ static const Property tcx_properties[] = {
     DEFINE_PROP_UINT16("depth",    TCXState, depth,     -1),
 };
 
-static void tcx_class_init(ObjectClass *klass, void *data)
+static void tcx_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 2920628f780..3618913b3b7 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -92,7 +92,7 @@ static const Property vga_isa_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", ISAVGAState, state.vram_size_mb, 8),
 };
 
-static void vga_isa_class_initfn(ObjectClass *klass, void *data)
+static void vga_isa_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index 1e0c2dbf748..33263856b76 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -116,7 +116,7 @@ static const Property vga_mmio_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", VGAMmioState, vga.vram_size_mb, 8),
 };
 
-static void vga_mmio_class_initfn(ObjectClass *klass, void *data)
+static void vga_mmio_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index dd084c20b16..a8601972740 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -350,7 +350,7 @@ static const Property secondary_pci_properties[] = {
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
 };
 
-static void vga_pci_class_init(ObjectClass *klass, void *data)
+static void vga_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -376,7 +376,7 @@ static const TypeInfo vga_pci_type_info = {
     },
 };
 
-static void vga_class_init(ObjectClass *klass, void *data)
+static void vga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -392,7 +392,7 @@ static void vga_class_init(ObjectClass *klass, void *data)
                                    vga_get_big_endian_fb, vga_set_big_endian_fb);
 }
 
-static void secondary_class_init(ObjectClass *klass, void *data)
+static void secondary_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 2aed6243f6c..06c4e7e1904 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -658,7 +658,7 @@ static const Property vhost_user_gpu_properties[] = {
 };
 
 static void
-vhost_user_gpu_class_init(ObjectClass *klass, void *data)
+vhost_user_gpu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7827536ac46..4c588332457 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -263,7 +263,7 @@ virtio_gpu_base_device_unrealize(DeviceState *qdev)
 }
 
 static void
-virtio_gpu_base_class_init(ObjectClass *klass, void *data)
+virtio_gpu_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 683fad3bf8a..c06a078fb36 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -182,7 +182,7 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     g_array_unref(g->capset_ids);
 }
 
-static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
+static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 6d789701a3c..c0d71b6254c 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -57,7 +57,7 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 }
 
-static void virtio_gpu_pci_base_class_init(ObjectClass *klass, void *data)
+static void virtio_gpu_pci_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index f6eb29472e8..ed5ae52acbe 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1110,7 +1110,7 @@ static const Property virtio_gpu_rutabaga_properties[] = {
     DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
 };
 
-static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
+static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 11a7a857502..0a1a625b0ea 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1684,7 +1684,7 @@ static const Property virtio_gpu_properties[] = {
     DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
 };
 
-static void virtio_gpu_class_init(ObjectClass *klass, void *data)
+static void virtio_gpu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index fefbdb61e17..40e60f70fcd 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -213,7 +213,7 @@ static const Property virtio_vga_base_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
 };
 
-static void virtio_vga_base_class_init(ObjectClass *klass, void *data)
+static void virtio_vga_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 2dd661e3c13..7777deb17d0 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1339,7 +1339,7 @@ static const Property vga_vmware_properties[] = {
                      chip.vga.global_vmstate, false),
 };
 
-static void vmsvga_class_init(ObjectClass *klass, void *data)
+static void vmsvga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 1272da0133a..7c980ee6423 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1391,7 +1391,7 @@ static const Property xlnx_dp_device_properties[] = {
     DEFINE_AUDIO_PROPERTIES(XlnxDPState, aud_card),
 };
 
-static void xlnx_dp_class_init(ObjectClass *oc, void *data)
+static void xlnx_dp_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 9b2fca2c7c1..a2771ddcb52 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -385,7 +385,7 @@ static void bcm2835_dma_realize(DeviceState *dev, Error **errp)
     bcm2835_dma_reset(dev);
 }
 
-static void bcm2835_dma_class_init(ObjectClass *klass, void *data)
+static void bcm2835_dma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 9652d47adcd..375654f9b79 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -143,7 +143,7 @@ static const Property i82374_properties[] = {
     DEFINE_PROP_UINT32("iobase", I82374State, iobase, 0x400),
 };
 
-static void i82374_class_init(ObjectClass *klass, void *data)
+static void i82374_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 74c38d2ee84..1d67e505364 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -592,7 +592,7 @@ static const Property i8257_properties[] = {
     DEFINE_PROP_INT32("dshift", I8257State, dshift, 0),
 };
 
-static void i8257_class_init(ObjectClass *klass, void *data)
+static void i8257_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IsaDmaClass *idc = ISADMA_CLASS(klass);
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 8a9b073b249..277d9343223 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -413,7 +413,7 @@ static const Property pl080_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void pl080_class_init(ObjectClass *oc, void *data)
+static void pl080_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 545aa44e457..a570bb08ec4 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1671,7 +1671,7 @@ static const Property pl330_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void pl330_class_init(ObjectClass *klass, void *data)
+static void pl330_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5bf54347ed4..bb66ecd8ba9 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -701,7 +701,7 @@ static void rc4030_unrealize(DeviceState *dev)
     object_unparent(OBJECT(&s->dma_mr));
 }
 
-static void rc4030_class_init(ObjectClass *klass, void *class_data)
+static void rc4030_class_init(ObjectClass *klass, const void *class_data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -720,7 +720,7 @@ static const TypeInfo rc4030_info = {
 };
 
 static void rc4030_iommu_memory_region_class_init(ObjectClass *klass,
-                                                  void *data)
+                                                  const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 25b3d6a155a..a3d80061e64 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -465,7 +465,7 @@ static void sifive_pdma_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void sifive_pdma_class_init(ObjectClass *klass, void *data)
+static void sifive_pdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 280b7475212..60c23b69e5c 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -274,7 +274,7 @@ static void sparc32_dma_device_init(Object *obj)
     qdev_init_gpio_out(dev, s->gpio, 2);
 }
 
-static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
+static void sparc32_dma_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -316,7 +316,8 @@ static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(sysbus), &error_fatal);
 }
 
-static void sparc32_espdma_device_class_init(ObjectClass *klass, void *data)
+static void sparc32_espdma_device_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -351,7 +352,8 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
 }
 
-static void sparc32_ledma_device_class_init(ObjectClass *klass, void *data)
+static void sparc32_ledma_device_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -426,7 +428,7 @@ static void sparc32_dma_init(Object *obj)
                             TYPE_SPARC32_LEDMA_DEVICE);
 }
 
-static void sparc32_dma_class_init(ObjectClass *klass, void *data)
+static void sparc32_dma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 22fe35751ac..bf1b523ac88 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -621,7 +621,7 @@ static const Property axidma_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void axidma_class_init(ObjectClass *klass, void *data)
+static void axidma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -639,7 +639,8 @@ static StreamSinkClass xilinx_axidma_control_stream_class = {
     .push = xilinx_axidma_control_stream_push,
 };
 
-static void xilinx_axidma_stream_class_init(ObjectClass *klass, void *data)
+static void xilinx_axidma_stream_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
 
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index bb27cb2e644..0c075e7d0d1 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -816,7 +816,7 @@ static const Property zdma_props[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void zdma_class_init(ObjectClass *klass, void *data)
+static void zdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 0fd0d23f578..26845713ee5 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -380,7 +380,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void xlnx_zynq_devcfg_class_init(ObjectClass *klass, void *data)
+static void xlnx_zynq_devcfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 1afaa0bf516..6943c927d07 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -712,7 +712,7 @@ static const Property xlnx_csu_dma_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void xlnx_csu_dma_class_init(ObjectClass *klass, void *data)
+static void xlnx_csu_dma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 2657808d379..3d88ccc8da9 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -593,7 +593,7 @@ static void xlnx_dpdma_reset(DeviceState *dev)
     }
 }
 
-static void xlnx_dpdma_class_init(ObjectClass *oc, void *data)
+static void xlnx_dpdma_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index 0e2cc143f10..172ba16b0c0 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -320,7 +320,7 @@ static void fsi_aspeed_apb2opb_reset(DeviceState *dev)
     memcpy(s->regs, aspeed_apb2opb_reset, ASPEED_APB2OPB_NR_REGS);
 }
 
-static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, void *data)
+static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
index c62f0f78dee..e2145c5934b 100644
--- a/hw/fsi/cfam.c
+++ b/hw/fsi/cfam.c
@@ -145,7 +145,7 @@ static void fsi_cfam_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&cfam->lbus.mr, 0, &fsi_dev->iomem);
 }
 
-static void fsi_cfam_class_init(ObjectClass *klass, void *data)
+static void fsi_cfam_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->bus_type = TYPE_FSI_BUS;
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index 50fb1cd4672..083a5507abc 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -144,7 +144,7 @@ static void fsi_master_reset(DeviceState *dev)
     s->regs[FSI_MVER] = 0xe0050101;
 }
 
-static void fsi_master_class_init(ObjectClass *klass, void *data)
+static void fsi_master_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/fsi/fsi.c b/hw/fsi/fsi.c
index 83ddb17ae63..6c52d5e745e 100644
--- a/hw/fsi/fsi.c
+++ b/hw/fsi/fsi.c
@@ -76,7 +76,7 @@ static void fsi_slave_init(Object *o)
                           s, TYPE_FSI_SLAVE, 0x400);
 }
 
-static void fsi_slave_class_init(ObjectClass *klass, void *data)
+static void fsi_slave_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
index 4f87b28a228..8ec7f5fd780 100644
--- a/hw/fsi/lbus.c
+++ b/hw/fsi/lbus.c
@@ -91,7 +91,7 @@ static void fsi_scratchpad_reset(DeviceState *dev)
     memset(s->regs, 0, sizeof(s->regs));
 }
 
-static void fsi_scratchpad_class_init(ObjectClass *klass, void *data)
+static void fsi_scratchpad_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index a5b3f454e80..69632c9f3a1 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1478,7 +1478,7 @@ static const VMStateDescription vmstate_aspeed_gpio = {
    }
 };
 
-static void aspeed_gpio_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1488,7 +1488,7 @@ static void aspeed_gpio_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_aspeed_gpio;
 }
 
-static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, const void *data)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
 
@@ -1501,7 +1501,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
     agc->reg_ops = &aspeed_gpio_ops;
 }
 
-static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_2500_class_init(ObjectClass *klass, const void *data)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
 
@@ -1514,7 +1514,8 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
     agc->reg_ops = &aspeed_gpio_ops;
 }
 
-static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass,
+                                                const void *data)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
 
@@ -1527,7 +1528,8 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
     agc->reg_ops = &aspeed_gpio_ops;
 }
 
-static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass,
+                                                const void *data)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
 
@@ -1540,7 +1542,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
     agc->reg_ops = &aspeed_gpio_ops;
 }
 
-static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_1030_class_init(ObjectClass *klass, const void *data)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
 
@@ -1553,7 +1555,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
     agc->reg_ops = &aspeed_gpio_ops;
 }
 
-static void aspeed_gpio_2700_class_init(ObjectClass *klass, void *data)
+static void aspeed_gpio_2700_class_init(ObjectClass *klass, const void *data)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
 
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 5a5f1df5e80..dfb5d5cb578 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -319,7 +319,7 @@ static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
     s->sdbus_sdhost = SD_BUS(obj);
 }
 
-static void bcm2835_gpio_class_init(ObjectClass *klass, void *data)
+static void bcm2835_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 0a1739fc468..bd7fe4f04e0 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -365,7 +365,7 @@ static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
     s->sdbus_sdhost = SD_BUS(obj);
 }
 
-static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
+static void bcm2838_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index 2fcab9ead60..40c028bed9e 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -85,7 +85,7 @@ static void gpio_key_realize(DeviceState *dev, Error **errp)
     s->timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, gpio_key_timer_expired, s);
 }
 
-static void gpio_key_class_init(ObjectClass *klass, void *data)
+static void gpio_key_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 549a281ed79..aa4e600cee3 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -323,7 +323,7 @@ static void imx_gpio_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
-static void imx_gpio_class_init(ObjectClass *klass, void *data)
+static void imx_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index a3c1d2fbf4c..257497af584 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -199,7 +199,7 @@ static void mpc8xxx_gpio_initfn(Object *obj)
     qdev_init_gpio_out(dev, s->out, 32);
 }
 
-static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
+static void mpc8xxx_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 23e67424c9f..d44bdef0d90 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -397,7 +397,7 @@ static const Property npcm7xx_gpio_properties[] = {
     DEFINE_PROP_UINT32("reset-odsc", NPCM7xxGPIOState, reset_odsc, 0),
 };
 
-static void npcm7xx_gpio_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_gpio_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *reset = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index d08c254e369..d94c0c47da2 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -304,7 +304,7 @@ static void nrf51_gpio_init(Object *obj)
     qdev_init_gpio_out_named(DEVICE(s), &s->detect, "detect", 1);
 }
 
-static void nrf51_gpio_class_init(ObjectClass *klass, void *data)
+static void nrf51_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 8a9f14ba152..61ea7862afe 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -229,7 +229,7 @@ static const Property omap_gpio_properties[] = {
     DEFINE_PROP_INT32("mpu_model", Omap1GpioState, mpu_model, 0),
 };
 
-static void omap_gpio_class_init(ObjectClass *klass, void *data)
+static void omap_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 1ac0cf6c464..d65c0a2e90f 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -432,7 +432,7 @@ static const Property pca955x_properties[] = {
     DEFINE_PROP_STRING("description", PCA955xState, description),
 };
 
-static void pca955x_class_init(ObjectClass *klass, void *data)
+static void pca955x_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
@@ -454,7 +454,7 @@ static const TypeInfo pca955x_info = {
     .abstract      = true,
 };
 
-static void pca9552_class_init(ObjectClass *oc, void *data)
+static void pca9552_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index fe03bb4b5e2..f74a562477f 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -295,7 +295,7 @@ static const Property pca9554_properties[] = {
     DEFINE_PROP_STRING("description", PCA9554State, description),
 };
 
-static void pca9554_class_init(ObjectClass *klass, void *data)
+static void pca9554_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
index 208efe69ea5..274b44bb616 100644
--- a/hw/gpio/pcf8574.c
+++ b/hw/gpio/pcf8574.c
@@ -138,7 +138,7 @@ static void pcf8574_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out_named(dev, &s->intrq, "nINT", 1);
 }
 
-static void pcf8574_class_init(ObjectClass *klass, void *data)
+static void pcf8574_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass   *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k  = I2C_SLAVE_CLASS(klass);
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 60ce4a7f628..807a20b078e 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -567,7 +567,7 @@ static const Property pl061_props[] = {
     DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
 };
 
-static void pl061_class_init(ObjectClass *klass, void *data)
+static void pl061_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 0d5206ae6b5..5831647b4d0 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -370,7 +370,7 @@ static void sifive_gpio_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(DEVICE(s), s->output, s->ngpio);
 }
 
-static void sifive_gpio_class_init(ObjectClass *klass, void *data)
+static void sifive_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index f69fc1db4f5..414ce830390 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -454,7 +454,7 @@ static const Property stm32l4x5_gpio_properties[] = {
     DEFINE_PROP_UINT32("pupd-reset", Stm32l4x5GpioState, pupdr_reset, 0),
 };
 
-static void stm32l4x5_gpio_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 7342440b958..b8d27f59738 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -243,7 +243,7 @@ static const VMStateDescription vmstate_scoop_regs = {
     },
 };
 
-static void scoop_sysbus_class_init(ObjectClass *klass, void *data)
+static void scoop_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c5f247633eb..37f6cb6346b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -682,7 +682,7 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
-static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
+static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         TYPE_HPPA_CPU,
@@ -718,7 +718,7 @@ static const TypeInfo HP_B160L_machine_init_typeinfo = {
     },
 };
 
-static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
+static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         TYPE_HPPA64_CPU,
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 6f33c3e7413..9d6f28f07e8 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1743,7 +1743,7 @@ static const Property hv_balloon_properties[] = {
     DEFINE_PROP_UINT64(HV_BALLOON_ADDR_PROP, HvBalloon, addr, 0),
 };
 
-static void hv_balloon_class_init(ObjectClass *klass, void *data)
+static void hv_balloon_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VMBusDeviceClass *vdc = VMBUS_DEVICE_CLASS(klass);
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 831e04f2142..c203f19541d 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -133,7 +133,7 @@ static void synic_reset(DeviceState *dev)
     assert(QLIST_EMPTY(&synic->sint_routes));
 }
 
-static void synic_class_init(ObjectClass *klass, void *data)
+static void synic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index a630ca70476..2d4a63693b8 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -303,7 +303,7 @@ static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
     memory_region_add_subregion(io, 0x3000, &dev->sint_control);
 }
 
-static void hv_test_dev_class_init(ObjectClass *klass, void *data)
+static void hv_test_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index d3e39170772..667b9e9e47b 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -372,7 +372,7 @@ static const Property hv_syndbg_properties[] = {
     DEFINE_PROP_BOOL("use_hcalls", HvSynDbg, use_hcalls, false),
 };
 
-static void hv_syndbg_class_init(ObjectClass *klass, void *data)
+static void hv_syndbg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 12a7dc43128..49f33c378cc 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2351,7 +2351,7 @@ static const Property vmbus_dev_props[] = {
 };
 
 
-static void vmbus_dev_class_init(ObjectClass *klass, void *data)
+static void vmbus_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *kdev = DEVICE_CLASS(klass);
     device_class_set_props(kdev, vmbus_dev_props);
@@ -2469,7 +2469,7 @@ static char *vmbus_get_fw_dev_path(DeviceState *dev)
     return g_strdup_printf("%s@%s", qdev_fw_name(dev), uuid);
 }
 
-static void vmbus_class_init(ObjectClass *klass, void *data)
+static void vmbus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -2656,7 +2656,7 @@ static const Property vmbus_bridge_props[] = {
     DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
 };
 
-static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
+static void vmbus_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     SysBusDeviceClass *sk = SYS_BUS_DEVICE_CLASS(klass);
diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index 16f1d6d40e7..41c721d48fb 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -438,7 +438,7 @@ static void allwinner_i2c_realize(DeviceState *dev, Error **errp)
     s->bus = i2c_init_bus(dev, "i2c");
 }
 
-static void allwinner_i2c_class_init(ObjectClass *klass, void *data)
+static void allwinner_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a8fbb9f44a1..83fb906bdc7 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1263,7 +1263,7 @@ static const Property aspeed_i2c_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
+static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1390,7 +1390,8 @@ static void aspeed_i2c_bus_slave_send_async(I2CSlave *slave, uint8_t data)
     aspeed_i2c_bus_raise_interrupt(bus);
 }
 
-static void aspeed_i2c_bus_slave_class_init(ObjectClass *klass, void *data)
+static void aspeed_i2c_bus_slave_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
@@ -1451,7 +1452,7 @@ static const Property aspeed_i2c_bus_properties[] = {
                      AspeedI2CState *),
 };
 
-static void aspeed_i2c_bus_class_init(ObjectClass *klass, void *data)
+static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1483,7 +1484,7 @@ static uint8_t *aspeed_2400_i2c_bus_pool_base(AspeedI2CBus *bus)
     return &pool_page[ARRAY_FIELD_EX32(bus->regs, I2CD_POOL_CTRL, OFFSET)];
 }
 
-static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
@@ -1517,7 +1518,7 @@ static uint8_t *aspeed_2500_i2c_bus_pool_base(AspeedI2CBus *bus)
     return bus->pool;
 }
 
-static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
@@ -1547,7 +1548,7 @@ static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
     return bus->irq;
 }
 
-static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
@@ -1571,7 +1572,7 @@ static const TypeInfo aspeed_2600_i2c_info = {
     .class_init = aspeed_2600_i2c_class_init,
 };
 
-static void aspeed_1030_i2c_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
@@ -1595,7 +1596,7 @@ static const TypeInfo aspeed_1030_i2c_info = {
     .class_init = aspeed_1030_i2c_class_init,
 };
 
-static void aspeed_2700_i2c_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index 67bfdef3b40..be11cca2a93 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -258,7 +258,7 @@ static const VMStateDescription vmstate_bcm2835_i2c = {
     }
 };
 
-static void bcm2835_i2c_class_init(ObjectClass *klass, void *data)
+static void bcm2835_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index de5f5aacf54..e020f314e2a 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -222,7 +222,7 @@ static void gpio_i2c_init(Object *obj)
     qdev_init_gpio_out(dev, &s->out, 1);
 }
 
-static void gpio_i2c_class_init(ObjectClass *klass, void *data)
+static void gpio_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 26bb18514a9..4b6345b5889 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -401,7 +401,7 @@ static bool i2c_slave_match(I2CSlave *candidate, uint8_t address,
     return false;
 }
 
-static void i2c_slave_class_init(ObjectClass *klass, void *data)
+static void i2c_slave_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index b1d00096eea..9d0c1cdaa8a 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -309,7 +309,7 @@ static void exynos4210_i2c_init(Object *obj)
     s->bus = i2c_init_bus(dev, "i2c");
 }
 
-static void exynos4210_i2c_class_init(ObjectClass *klass, void *data)
+static void exynos4210_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index 779cc4e66ed..a8ef640cd25 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -172,13 +172,13 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
     return pca954x->bus[channel];
 }
 
-static void pca9546_class_init(ObjectClass *klass, void *data)
+static void pca9546_class_init(ObjectClass *klass, const void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
     s->nchans = PCA9546_CHANNEL_COUNT;
 }
 
-static void pca9548_class_init(ObjectClass *klass, void *data)
+static void pca9548_class_init(ObjectClass *klass, const void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
     s->nchans = PCA9548_CHANNEL_COUNT;
@@ -215,7 +215,7 @@ static const Property pca954x_props[] = {
     DEFINE_PROP_STRING("name", Pca954xState, name),
 };
 
-static void pca954x_class_init(ObjectClass *klass, void *data)
+static void pca954x_class_init(ObjectClass *klass, const void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index d62213b9e0f..91f84c2ad7d 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -297,7 +297,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
     s->bus = i2c_init_bus(dev, NULL);
 }
 
-static void imx_i2c_class_init(ObjectClass *klass, void *data)
+static void imx_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 06fbd18a780..2291d6370e2 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -105,7 +105,7 @@ static void microbit_i2c_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void microbit_i2c_class_init(ObjectClass *klass, void *data)
+static void microbit_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 913d044ac1b..25f91b7bc82 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -334,7 +334,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error **errp)
     i2c->bus = i2c_init_bus(dev, "i2c");
 }
 
-static void mpc_i2c_class_init(ObjectClass *klass, void *data)
+static void mpc_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/npcm7xx_smbus.c b/hw/i2c/npcm7xx_smbus.c
index 22d68fc67dd..179852a4fd9 100644
--- a/hw/i2c/npcm7xx_smbus.c
+++ b/hw/i2c/npcm7xx_smbus.c
@@ -1075,7 +1075,7 @@ static const VMStateDescription vmstate_npcm7xx_smbus = {
     },
 };
 
-static void npcm7xx_smbus_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_smbus_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index a641db23480..2e45266e74b 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -515,7 +515,7 @@ static const Property omap_i2c_properties[] = {
     DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
 };
 
-static void omap_i2c_class_init(ObjectClass *klass, void *data)
+static void omap_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index ba1d2fd7160..853dc4b4342 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1902,7 +1902,7 @@ static void pmbus_device_finalize(Object *obj)
     g_free(pmdev->pages);
 }
 
-static void pmbus_device_class_init(ObjectClass *klass, void *data)
+static void pmbus_device_class_init(ObjectClass *klass, const void *data)
 {
     SMBusDeviceClass *k = SMBUS_DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 7b124a7e337..09d4c49d657 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -354,7 +354,7 @@ static void ppc4xx_i2c_init(Object *o)
     bitbang_i2c_init(&s->bitbang, s->bus);
 }
 
-static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
+static void ppc4xx_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index e3e96d4a2d6..0a1088fbb0a 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -137,7 +137,7 @@ static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
+static void smbus_eeprom_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 208f263ac5b..f1fca30fea5 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -118,7 +118,7 @@ static void build_ich9_smb_aml(AcpiDevAmlIf *adev, Aml *scope)
     qbus_build_aml(bus, scope);
 }
 
-static void ich9_smb_class_init(ObjectClass *klass, void *data)
+static void ich9_smb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 9f9afc25a40..cfb61c879e0 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -201,7 +201,7 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
-static void smbus_device_class_init(ObjectClass *klass, void *data)
+static void smbus_device_class_init(ObjectClass *klass, const void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6b13ce894b1..a6654cfa8af 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1677,7 +1677,7 @@ static void amdvi_sysbus_instance_init(Object *klass)
     object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
 }
 
-static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
+static void amdvi_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *dc_class = X86_IOMMU_DEVICE_CLASS(klass);
@@ -1702,7 +1702,7 @@ static const TypeInfo amdvi_sysbus = {
     .class_init = amdvi_sysbus_class_init
 };
 
-static void amdvi_pci_class_init(ObjectClass *klass, void *data)
+static void amdvi_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1726,7 +1726,8 @@ static const TypeInfo amdvi_pci = {
     },
 };
 
-static void amdvi_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+static void amdvi_iommu_memory_region_class_init(ObjectClass *klass,
+                                                 const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f366c223d0e..f7398478003 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4860,7 +4860,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
-static void vtd_class_init(ObjectClass *klass, void *data)
+static void vtd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
@@ -4885,7 +4885,7 @@ static const TypeInfo vtd_info = {
 };
 
 static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
-                                                     void *data)
+                                               const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 75751060009..39035db0422 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -240,7 +240,7 @@ static void kvm_apic_unrealize(DeviceState *dev)
 {
 }
 
-static void kvm_apic_class_init(ObjectClass *klass, void *data)
+static void kvm_apic_class_init(ObjectClass *klass, const void *data)
 {
     APICCommonClass *k = APIC_COMMON_CLASS(klass);
 
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 17443552e91..f56382717f7 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -309,7 +309,7 @@ static const Property kvmclock_properties[] = {
                       mach_use_reliable_get_clock, true),
 };
 
-static void kvmclock_class_init(ObjectClass *klass, void *data)
+static void kvmclock_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 3b92771c79f..14b78f30a83 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -292,7 +292,7 @@ static const Property kvm_pit_properties[] = {
                                lost_tick_policy, LOST_TICK_POLICY_DELAY),
 };
 
-static void kvm_pit_class_init(ObjectClass *klass, void *data)
+static void kvm_pit_class_init(ObjectClass *klass, const void *data)
 {
     KVMPITClass *kpc = KVM_PIT_CLASS(klass);
     PITCommonClass *k = PIT_COMMON_CLASS(klass);
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 272c04df0b7..8a72d6e4dd3 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -139,7 +139,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
     return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
 }
 
-static void kvm_i8259_class_init(ObjectClass *klass, void *data)
+static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
     PICCommonClass *k = PIC_COMMON_CLASS(klass);
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 5419e191b57..693ee978a12 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -137,7 +137,7 @@ static const Property kvm_ioapic_properties[] = {
     DEFINE_PROP_UINT32("gsi_base", KVMIOAPICState, kvm_gsi_base, 0),
 };
 
-static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
+static void kvm_ioapic_class_init(ObjectClass *klass, const void *data)
 {
     IOAPICCommonClass *k = IOAPIC_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 9b8b092bc20..9f77e604451 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -271,7 +271,7 @@ static const VMStateDescription xen_evtchn_vmstate = {
     }
 };
 
-static void xen_evtchn_class_init(ObjectClass *klass, void *data)
+static void xen_evtchn_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 7b843a72b14..9404ad026b8 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -135,7 +135,7 @@ static const VMStateDescription xen_gnttab_vmstate = {
     }
 };
 
-static void xen_gnttab_class_init(ObjectClass *klass, void *data)
+static void xen_gnttab_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index db9aa7942d4..6195344859f 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -151,7 +151,7 @@ static void xen_overlay_reset(DeviceState *dev)
     kvm_xen_soft_reset();
 }
 
-static void xen_overlay_class_init(ObjectClass *klass, void *data)
+static void xen_overlay_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index 8ad2363d18e..6e9d6417c3e 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -67,7 +67,7 @@ static void xen_primary_console_realize(DeviceState *dev, Error **errp)
     xen_primary_console_singleton = s;
 }
 
-static void xen_primary_console_class_init(ObjectClass *klass, void *data)
+static void xen_primary_console_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 17802aa33d2..672fff61485 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -261,7 +261,7 @@ static const VMStateDescription xen_xenstore_vmstate = {
     }
 };
 
-static void xen_xenstore_class_init(ObjectClass *klass, void *data)
+static void xen_xenstore_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe5..a0e39673c9e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -635,7 +635,7 @@ GlobalProperty microvm_properties[] = {
     { "pcie-root-port", "io-reserve", "0" },
 };
 
-static void microvm_class_init(ObjectClass *oc, void *data)
+static void microvm_class_init(ObjectClass *oc, const void *data)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index a058608afcb..e65099dfe5a 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -294,7 +294,7 @@ static void nitro_enclave_set_parent_id(Object *obj, const char *value,
     nems->parent_id = g_strdup(value);
 }
 
-static void nitro_enclave_class_init(ObjectClass *oc, void *data)
+static void nitro_enclave_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0eb52d315bb..a20ca1e54fb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1762,7 +1762,7 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
     return true;
 }
 
-static void pc_machine_class_init(ObjectClass *oc, void *data)
+static void pc_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
index 1ba3f328871..39b6f3178fe 100644
--- a/hw/i386/port92.c
+++ b/hw/i386/port92.c
@@ -97,7 +97,7 @@ static void port92_realizefn(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &s->io, 0x92);
 }
 
-static void port92_class_initfn(ObjectClass *klass, void *data)
+static void port92_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index 875e1c5c33b..d5590cd0b53 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -147,7 +147,7 @@ static void sgx_epc_md_fill_device_info(const MemoryDeviceState *md,
     info->type = MEMORY_DEVICE_INFO_KIND_SGX_EPC;
 }
 
-static void sgx_epc_class_init(ObjectClass *oc, void *data)
+static void sgx_epc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 14de9b7a820..7913b3273a4 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -846,7 +846,7 @@ static const VMStateDescription vmstate_vapic = {
     }
 };
 
-static void vapic_class_init(ObjectClass *klass, void *data)
+static void vapic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 3e07d125128..3896159b055 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -321,7 +321,7 @@ static const Property vmmouse_properties[] = {
     DEFINE_PROP_LINK("i8042", VMMouseState, i8042, TYPE_I8042, ISAKBDState *),
 };
 
-static void vmmouse_class_initfn(ObjectClass *klass, void *data)
+static void vmmouse_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 2f19b970b50..6d93457c526 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -286,7 +286,7 @@ static const Property vmport_properties[] = {
     DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
 };
 
-static void vmport_class_initfn(ObjectClass *klass, void *data)
+static void vmport_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index fed34b2fcfa..2aea64fce93 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -132,7 +132,7 @@ static const Property x86_iommu_properties[] = {
     DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
 };
 
-static void x86_iommu_class_init(ObjectClass *klass, void *data)
+static void x86_iommu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = x86_iommu_realize;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 69bfc00b9a5..c8e2551b2b4 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -372,7 +372,7 @@ static void x86_machine_initfn(Object *obj)
     x86ms->above_4g_mem_start = 4 * GiB;
 }
 
-static void x86_machine_class_init(ObjectClass *oc, void *data)
+static void x86_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 33c10279763..721d7488ea6 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -75,7 +75,7 @@ static void xen_pvh_set_pci_intx_irq(void *opaque, int irq, int level)
     }
 }
 
-static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
+static void xen_pvh_machine_class_init(ObjectClass *oc, const void *data)
 {
     XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index a94e9005cbe..f30398fa4ae 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -76,7 +76,7 @@ static void xen_send_msi(MSIMessage *msi)
     xen_hvm_inject_msi(msi->address, msi->data);
 }
 
-static void xen_apic_class_init(ObjectClass *klass, void *data)
+static void xen_apic_class_init(ObjectClass *klass, const void *data)
 {
     APICCommonClass *k = APIC_COMMON_CLASS(klass);
 
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index dd648a2ee94..7c0d345f964 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -581,7 +581,7 @@ static void platform_reset(DeviceState *dev)
     platform_fixed_ioport_reset(s);
 }
 
-static void xen_platform_class_init(ObjectClass *klass, void *data)
+static void xen_platform_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 9453da97bd9..65868bd5e59 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -122,7 +122,7 @@ static const Property xen_pv_props[] = {
     DEFINE_PROP_UINT32("size", XenPVDevice, size, 0x400000),
 };
 
-static void xen_pv_class_init(ObjectClass *klass, void *data)
+static void xen_pv_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 575be36fc5c..bc7a116a89a 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -103,7 +103,7 @@ static const VMStateDescription vmstate_allwinner_ahci = {
     }
 };
 
-static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
+static void allwinner_ahci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
index 03a5bd42d07..52dbcf819dc 100644
--- a/hw/ide/ahci-sysbus.c
+++ b/hw/ide/ahci-sysbus.c
@@ -66,7 +66,7 @@ static const Property sysbus_ahci_properties[] = {
     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
 };
 
-static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
+static void sysbus_ahci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ide/cf.c b/hw/ide/cf.c
index cfb4394f80d..f87cd413b68 100644
--- a/hw/ide/cf.c
+++ b/hw/ide/cf.c
@@ -31,7 +31,7 @@ static const Property ide_cf_properties[] = {
                 IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
 };
 
-static void ide_cf_class_init(ObjectClass *klass, void *data)
+static void ide_cf_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 8e568e4c357..2a59516a9dd 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -317,7 +317,7 @@ static const Property cmd646_ide_properties[] = {
     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
 };
 
-static void cmd646_ide_class_init(ObjectClass *klass, void *data)
+static void cmd646_ide_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index a83128465f2..f2773ab4621 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -175,7 +175,7 @@ static void pci_ich9_uninit(PCIDevice *dev)
     ahci_uninit(&d->ahci);
 }
 
-static void ich_ahci_class_init(ObjectClass *klass, void *data)
+static void ich_ahci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
index 437502b5b4f..b24e4d17b48 100644
--- a/hw/ide/ide-bus.c
+++ b/hw/ide/ide-bus.c
@@ -29,7 +29,7 @@
 static char *idebus_get_fw_dev_path(DeviceState *dev);
 static void idebus_unrealize(BusState *qdev);
 
-static void ide_bus_class_init(ObjectClass *klass, void *data)
+static void ide_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 26f0517019e..5d478588c61 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -198,7 +198,7 @@ static const Property ide_hd_properties[] = {
     DEFINE_PROP_UINT16("rotation_rate", IDEDrive, dev.rotation_rate, 0),
 };
 
-static void ide_hd_class_init(ObjectClass *klass, void *data)
+static void ide_hd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
@@ -220,7 +220,7 @@ static const Property ide_cd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
 };
 
-static void ide_cd_class_init(ObjectClass *klass, void *data)
+static void ide_cd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
@@ -238,7 +238,7 @@ static const TypeInfo ide_cd_info = {
     .class_init    = ide_cd_class_init,
 };
 
-static void ide_device_class_init(ObjectClass *klass, void *data)
+static void ide_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = ide_qdev_realize;
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 4863ad8080d..5f418413c18 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -107,7 +107,7 @@ static const Property isa_ide_properties[] = {
     DEFINE_PROP_UINT32("irq",     ISAIDEState, irqnum,  14),
 };
 
-static void isa_ide_class_initfn(ObjectClass *klass, void *data)
+static void isa_ide_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 5fe764b49b5..dbdb00eb3de 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -464,7 +464,7 @@ static const Property macio_ide_properties[] = {
     DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
 };
 
-static void macio_ide_class_init(ObjectClass *oc, void *data)
+static void macio_ide_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 13f16170ff2..699874db785 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -145,7 +145,7 @@ static const Property mmio_ide_properties[] = {
     DEFINE_PROP_UINT32("shift", MMIOIDEState, shift, 0),
 };
 
-static void mmio_ide_class_init(ObjectClass *oc, void *data)
+static void mmio_ide_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 818ff60d6f9..a0f2709c697 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -178,7 +178,7 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
 }
 
 /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
-static void piix3_ide_class_init(ObjectClass *klass, void *data)
+static void piix3_ide_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -201,7 +201,7 @@ static const TypeInfo piix3_ide_info = {
 };
 
 /* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
-static void piix4_ide_class_init(ObjectClass *klass, void *data)
+static void piix4_ide_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index ce8a1e4cba3..9b28c691fd7 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -290,7 +290,7 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void sii3112_pci_class_init(ObjectClass *klass, void *data)
+static void sii3112_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pd = PCI_DEVICE_CLASS(klass);
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 89fd28f646c..dedc2674c00 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -245,7 +245,7 @@ static void via_ide_exitfn(PCIDevice *dev)
     }
 }
 
-static void via_ide_class_init(ObjectClass *klass, void *data)
+static void via_ide_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 3649d03ef22..507557deecc 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -375,7 +375,7 @@ static void adb_kbd_initfn(Object *obj)
     d->devaddr = ADB_DEVID_KEYBOARD;
 }
 
-static void adb_kbd_class_init(ObjectClass *oc, void *data)
+static void adb_kbd_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 77b280d2420..373ef3f953c 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -287,7 +287,7 @@ static void adb_mouse_initfn(Object *obj)
     d->devaddr = ADB_DEVID_MOUSE;
 }
 
-static void adb_mouse_class_init(ObjectClass *oc, void *data)
+static void adb_mouse_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
diff --git a/hw/input/adb.c b/hw/input/adb.c
index aff7130fd0f..bcb11edca35 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -259,7 +259,7 @@ static void adb_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_adb_bus, adb_bus);
 }
 
-static void adb_bus_class_init(ObjectClass *klass, void *data)
+static void adb_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -299,7 +299,7 @@ static void adb_device_realizefn(DeviceState *dev, Error **errp)
     bus->devices[bus->nb_devices++] = d;
 }
 
-static void adb_device_class_init(ObjectClass *oc, void *data)
+static void adb_device_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index d9f8c36778d..511a921aa58 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -306,7 +306,7 @@ static void lasips2_init(Object *obj)
                             "lasips2-port-input-irq", 2);
 }
 
-static void lasips2_class_init(ObjectClass *klass, void *data)
+static void lasips2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -347,7 +347,7 @@ static void lasips2_port_init(Object *obj)
                             "ps2-input-irq", 1);
 }
 
-static void lasips2_port_class_init(ObjectClass *klass, void *data)
+static void lasips2_port_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -397,7 +397,7 @@ static void lasips2_kbd_port_init(Object *obj)
     lp->lasips2 = container_of(s, LASIPS2State, kbd_port);
 }
 
-static void lasips2_kbd_port_class_init(ObjectClass *klass, void *data)
+static void lasips2_kbd_port_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
@@ -447,7 +447,7 @@ static void lasips2_mouse_port_init(Object *obj)
     lp->lasips2 = container_of(s, LASIPS2State, mouse_port);
 }
 
-static void lasips2_mouse_port_class_init(ObjectClass *klass, void *data)
+static void lasips2_mouse_port_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index fa0c549eb99..83930dd50c0 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -750,7 +750,7 @@ static const VMStateDescription vmstate_kbd_mmio = {
     }
 };
 
-static void i8042_mmio_class_init(ObjectClass *klass, void *data)
+static void i8042_mmio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -939,7 +939,7 @@ static const Property i8042_properties[] = {
     DEFINE_PROP_UINT8("mouse-irq", ISAKBDState, mouse_irq, 12),
 };
 
-static void i8042_class_initfn(ObjectClass *klass, void *data)
+static void i8042_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index 6519e260ed5..c5f4a3fa843 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -203,7 +203,7 @@ static void pl050_mouse_init(Object *obj)
     object_initialize_child(obj, "mouse", &s->mouse, TYPE_PS2_MOUSE_DEVICE);
 }
 
-static void pl050_kbd_class_init(ObjectClass *oc, void *data)
+static void pl050_kbd_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PL050DeviceClass *pdc = PL050_CLASS(oc);
@@ -220,7 +220,7 @@ static const TypeInfo pl050_kbd_info = {
     .class_init    = pl050_kbd_class_init,
 };
 
-static void pl050_mouse_class_init(ObjectClass *oc, void *data)
+static void pl050_mouse_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PL050DeviceClass *pdc = PL050_CLASS(oc);
@@ -249,7 +249,7 @@ static void pl050_init(Object *obj)
     qdev_init_gpio_in_named(DEVICE(obj), pl050_set_irq, "ps2-input-irq", 1);
 }
 
-static void pl050_class_init(ObjectClass *oc, void *data)
+static void pl050_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 6a41b024c80..7f7b1fce2e5 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1254,7 +1254,7 @@ static void ps2_mouse_realize(DeviceState *dev, Error **errp)
     qemu_input_handler_register(dev, &ps2_mouse_handler);
 }
 
-static void ps2_kbd_class_init(ObjectClass *klass, void *data)
+static void ps2_kbd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1273,7 +1273,7 @@ static const TypeInfo ps2_kbd_info = {
     .class_init    = ps2_kbd_class_init
 };
 
-static void ps2_mouse_class_init(ObjectClass *klass, void *data)
+static void ps2_mouse_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1299,7 +1299,7 @@ static void ps2_init(Object *obj)
     qdev_init_gpio_out(DEVICE(obj), &s->irq, 1);
 }
 
-static void ps2_class_init(ObjectClass *klass, void *data)
+static void ps2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 98382a0e153..fec1161c9c1 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -82,7 +82,7 @@ static const Property stellaris_gamepad_properties[] = {
                       keycodes, qdev_prop_uint32, uint32_t),
 };
 
-static void stellaris_gamepad_class_init(ObjectClass *klass, void *data)
+static void stellaris_gamepad_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 812faaef8fe..d986c3c16e3 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -242,7 +242,7 @@ static const Property virtio_input_hid_properties[] = {
     DEFINE_PROP_UINT32("head", VirtIOInputHID, head, 0),
 };
 
-static void virtio_input_hid_class_init(ObjectClass *klass, void *data)
+static void virtio_input_hid_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOInputClass *vic = VIRTIO_INPUT_CLASS(klass);
@@ -383,7 +383,7 @@ static const Property virtio_mouse_properties[] = {
     DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
 };
 
-static void virtio_mouse_class_init(ObjectClass *klass, void *data)
+static void virtio_mouse_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -507,7 +507,7 @@ static const Property virtio_tablet_properties[] = {
     DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
 };
 
-static void virtio_tablet_class_init(ObjectClass *klass, void *data)
+static void virtio_tablet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 8bfb17f3c43..d33fd911f8f 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -225,7 +225,7 @@ static const Property virtio_input_host_properties[] = {
     DEFINE_PROP_STRING("evdev", VirtIOInputHost, evdev),
 };
 
-static void virtio_input_host_class_init(ObjectClass *klass, void *data)
+static void virtio_input_host_class_init(ObjectClass *klass, const void *data)
 {
     VirtIOInputClass *vic = VIRTIO_INPUT_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 1394d99c6b4..1818cbddc7c 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -304,7 +304,7 @@ static const Property virtio_input_properties[] = {
     DEFINE_PROP_STRING("serial", VirtIOInput, serial),
 };
 
-static void virtio_input_class_init(ObjectClass *klass, void *data)
+static void virtio_input_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index c0f30092cd6..340ef4a3cb3 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -187,7 +187,7 @@ static void aw_a10_pic_reset(DeviceState *d)
     }
 }
 
-static void aw_a10_pic_class_init(ObjectClass *klass, void *data)
+static void aw_a10_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index d1d343d4216..30d47bf6483 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -1177,7 +1177,7 @@ static void apic_unrealize(DeviceState *dev)
     local_apics[s->initial_apic_id] = NULL;
 }
 
-static void apic_class_init(ObjectClass *klass, void *data)
+static void apic_class_init(ObjectClass *klass, const void *data)
 {
     APICCommonClass *k = APIC_COMMON_CLASS(klass);
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 2a3e878c4da..37a7a7019d3 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -466,7 +466,7 @@ static void apic_common_initfn(Object *obj)
                         apic_common_set_id, NULL, NULL);
 }
 
-static void apic_common_class_init(ObjectClass *klass, void *data)
+static void apic_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 3581ff8e8a2..d18bef40fcc 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2162,7 +2162,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
 
 }
 
-static void arm_gic_class_init(ObjectClass *klass, void *data)
+static void arm_gic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ARMGICClass *agc = ARM_GIC_CLASS(klass);
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 5ac56e33898..f61d1c1fe60 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -362,7 +362,7 @@ static const Property arm_gic_common_properties[] = {
     DEFINE_PROP_UINT32("num-priority-bits", GICState, n_prio_bits, 8),
 };
 
-static void arm_gic_common_class_init(ObjectClass *klass, void *data)
+static void arm_gic_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 40adb028654..1e9232f47c8 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -584,7 +584,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void kvm_arm_gic_class_init(ObjectClass *klass, void *data)
+static void kvm_arm_gic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 3a8c62698c8..cef06882216 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -175,7 +175,7 @@ static const Property gicv2m_properties[] = {
     DEFINE_PROP_UINT32("num-spi", ARMGICv2mState, num_spi, 64),
 };
 
-static void gicv2m_class_init(ObjectClass *klass, void *data)
+static void gicv2m_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 58e18fff54f..6059ce926a6 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -452,7 +452,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     gicv3_init_cpuif(s);
 }
 
-static void arm_gicv3_class_init(ObjectClass *klass, void *data)
+static void arm_gicv3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 76b2283c928..dd86a50300a 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -623,7 +623,7 @@ static const Property arm_gicv3_common_properties[] = {
                      MemoryRegion *),
 };
 
-static void arm_gicv3_common_class_init(ObjectClass *klass, void *data)
+static void arm_gicv3_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 936368c901d..577b4454057 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -2007,7 +2007,7 @@ static const Property gicv3_its_props[] = {
                      GICv3State *),
 };
 
-static void gicv3_its_class_init(ObjectClass *klass, void *data)
+static void gicv3_its_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 70dbee83a65..e946e3fb87b 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -135,7 +135,7 @@ static void gicv3_its_common_reset_hold(Object *obj, ResetType type)
     memset(&s->baser, 0, sizeof(s->baser));
 }
 
-static void gicv3_its_common_class_init(ObjectClass *klass, void *data)
+static void gicv3_its_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index e1989745601..9812d508597 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -239,7 +239,7 @@ static const Property kvm_arm_its_props[] = {
                      GICv3State *),
 };
 
-static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
+static void kvm_arm_its_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 8e17cab2a0f..3be3bf6c28d 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -893,7 +893,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
+static void kvm_arm_gicv3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5fd07609824..c42624bd02c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2730,7 +2730,7 @@ static void armv7m_nvic_instance_init(Object *obj)
     qdev_init_gpio_in_named(dev, nvic_nmi_trigger, "NMI", 1);
 }
 
-static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
+static void armv7m_nvic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 126b711b943..2f965bbce98 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -316,7 +316,7 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void aspeed_intc_class_init(ObjectClass *klass, void *data)
+static void aspeed_intc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -336,7 +336,7 @@ static const TypeInfo aspeed_intc_info = {
     .abstract = true,
 };
 
-static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_intc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 55fe51a6675..7120088454c 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -339,7 +339,7 @@ static const VMStateDescription vmstate_aspeed_vic = {
     }
 };
 
-static void aspeed_vic_class_init(ObjectClass *klass, void *data)
+static void aspeed_vic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = aspeed_vic_realize;
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 4a42fcf60dd..55e0a5a503b 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -219,7 +219,7 @@ static const VMStateDescription vmstate_bcm2835_ic = {
     }
 };
 
-static void bcm2835_ic_class_init(ObjectClass *klass, void *data)
+static void bcm2835_ic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 197a0e2ccf7..1c028536696 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -384,7 +384,7 @@ static const VMStateDescription vmstate_bcm2836_control = {
     }
 };
 
-static void bcm2836_control_class_init(ObjectClass *klass, void *data)
+static void bcm2836_control_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 6ddbcd4c6df..ebbe23436f4 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -329,7 +329,7 @@ static const Property exynos4210_combiner_properties[] = {
     DEFINE_PROP_UINT32("external", Exynos4210CombinerState, external, 0),
 };
 
-static void exynos4210_combiner_class_init(ObjectClass *klass, void *data)
+static void exynos4210_combiner_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 01a53936d3a..7e2d79d00cd 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -115,7 +115,7 @@ static const Property exynos4210_gic_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", Exynos4210GicState, num_cpu, 1),
 };
 
-static void exynos4210_gic_class_init(ObjectClass *klass, void *data)
+static void exynos4210_gic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index aa5162c18fd..b80538cdeba 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -185,7 +185,7 @@ static const Property goldfish_pic_properties[] = {
     DEFINE_PROP_UINT8("index", GoldfishPICState, idx, 0),
 };
 
-static void goldfish_pic_class_init(ObjectClass *oc, void *data)
+static void goldfish_pic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 95cdb411d2c..e0f26466ba3 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -380,7 +380,7 @@ static const Property grlib_irqmp_properties[] = {
     DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
 };
 
-static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
+static void grlib_irqmp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 729498f1dfe..447e8c25d8d 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -184,7 +184,7 @@ static void heathrow_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mem);
 }
 
-static void heathrow_class_init(ObjectClass *oc, void *data)
+static void heathrow_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index d88b20f40b1..2359dd82534 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -436,7 +436,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
     return irq_set;
 }
 
-static void i8259_class_init(ObjectClass *klass, void *data)
+static void i8259_class_init(ObjectClass *klass, const void *data)
 {
     PICClass *k = PIC_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index c77ff683bb8..4a92e0da908 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -200,7 +200,7 @@ static const Property pic_properties_common[] = {
     DEFINE_PROP_BIT("master", PICCommonState, master,  0, false),
 };
 
-static void pic_common_class_init(ObjectClass *klass, void *data)
+static void pic_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index e1c9ce769dc..09c3bfac0b6 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -341,7 +341,7 @@ static void imx_avic_init(Object *obj)
 }
 
 
-static void imx_avic_class_init(ObjectClass *klass, void *data)
+static void imx_avic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index 9e5cf28371f..58d286c1cfc 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -102,7 +102,7 @@ static const VMStateDescription vmstate_imx_gpcv2 = {
     },
 };
 
-static void imx_gpcv2_class_init(ObjectClass *klass, void *data)
+static void imx_gpcv2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 8cd1d85e06a..133bef852d1 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -480,7 +480,7 @@ static const Property ioapic_properties[] = {
     DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
 };
 
-static void ioapic_class_init(ObjectClass *klass, void *data)
+static void ioapic_class_init(ObjectClass *klass, const void *data)
 {
     IOAPICCommonClass *k = IOAPIC_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 769896353a4..b0381c7990d 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -197,7 +197,7 @@ static const VMStateDescription vmstate_ioapic_common = {
     }
 };
 
-static void ioapic_common_class_init(ObjectClass *klass, void *data)
+static void ioapic_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index f3055ec4d26..2e6dfc2ec7f 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -407,7 +407,7 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
+static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_CLASS(klass);
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index fd56253d10b..9479eb51efd 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -99,7 +99,8 @@ static const Property extioi_properties[] = {
                     features, EXTIOI_HAS_VIRT_EXTENSION, 0),
 };
 
-static void loongarch_extioi_common_class_init(ObjectClass *klass, void *data)
+static void loongarch_extioi_common_class_init(ObjectClass *klass,
+                                               const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 5376f1e0840..4c3944a4015 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -76,7 +76,7 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
+static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
     LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index 66b5c1e660e..48d977c04b3 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -88,7 +88,7 @@ static const Property loongarch_msi_properties[] = {
     DEFINE_PROP_UINT32("msi_irq_num",  LoongArchPCHMSI, irq_num, 0),
 };
 
-static void loongarch_pch_msi_class_init(ObjectClass *klass, void *data)
+static void loongarch_pch_msi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index acd75ccb0c0..6c2b6de3f00 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -404,7 +404,7 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 
 }
 
-static void loongarch_pic_class_init(ObjectClass *klass, void *data)
+static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
index e7f541db4b5..fdb250c4186 100644
--- a/hw/intc/loongarch_pic_common.c
+++ b/hw/intc/loongarch_pic_common.c
@@ -71,7 +71,8 @@ static const VMStateDescription vmstate_loongarch_pic_common = {
     }
 };
 
-static void loongarch_pic_common_class_init(ObjectClass *klass, void *data)
+static void loongarch_pic_common_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index d2268a27f87..fbc73e8b001 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -101,7 +101,7 @@ static const Property loongson_ipi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
 };
 
-static void loongson_ipi_class_init(ObjectClass *klass, void *data)
+static void loongson_ipi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index f5ab5024c01..f32661c40f6 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -303,7 +303,7 @@ static const VMStateDescription vmstate_loongson_ipi_common = {
     }
 };
 
-static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
+static void loongson_ipi_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index a82b80f5c6f..215e1a6ed5b 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -90,7 +90,7 @@ static const Property m68k_irqc_properties[] = {
                      TYPE_M68K_CPU, ArchCPU *),
 };
 
-static void m68k_irqc_class_init(ObjectClass *oc, void *data)
+static void m68k_irqc_class_init(ObjectClass *oc, const void *data)
  {
     DeviceClass *dc = DEVICE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 5e3cbeabece..9795bef29ae 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -443,7 +443,7 @@ static const Property mips_gic_properties[] = {
     DEFINE_PROP_UINT32("num-irq", MIPSGICState, num_irq, 256),
 };
 
-static void mips_gic_class_init(ObjectClass *klass, void *data)
+static void mips_gic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 095a3d504f4..9e8737be338 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -379,7 +379,7 @@ static const Property omap_intc_properties[] = {
     DEFINE_PROP_UINT32("size", OMAPIntcState, size, 0x100),
 };
 
-static void omap_intc_class_init(ObjectClass *klass, void *data)
+static void omap_intc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 42af4567c66..7f18346a089 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -155,7 +155,7 @@ static const VMStateDescription vmstate_or1k_ompic = {
     }
 };
 
-static void or1k_ompic_class_init(ObjectClass *klass, void *data)
+static void or1k_ompic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 78a82d0d30a..87733eb7c30 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1611,7 +1611,7 @@ static const Property openpic_properties[] = {
     DEFINE_PROP_UINT32("nb_cpus", OpenPICState, nb_cpus, 1),
 };
 
-static void openpic_class_init(ObjectClass *oc, void *data)
+static void openpic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 9cdaa97004e..673ea9ca055 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -267,7 +267,7 @@ static const Property kvm_openpic_properties[] = {
                        OPENPIC_MODEL_FSL_MPIC_20),
 };
 
-static void kvm_openpic_class_init(ObjectClass *oc, void *data)
+static void kvm_openpic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index a5e2d763153..838c21c4a02 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -273,7 +273,7 @@ static const VMStateDescription vmstate_pl190 = {
     }
 };
 
-static void pl190_class_init(ObjectClass *klass, void *data)
+static void pl190_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index b755ddf0ffa..b67c2ed6c7e 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -2068,7 +2068,7 @@ static const Property pnv_xive_properties[] = {
     DEFINE_PROP_LINK("chip", PnvXive, chip, TYPE_PNV_CHIP, PnvChip *),
 };
 
-static void pnv_xive_class_init(ObjectClass *klass, void *data)
+static void pnv_xive_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 9ed759417e0..8c9bcd40b92 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2400,7 +2400,7 @@ static int pnv_xive2_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
-static void pnv_xive2_class_init(ObjectClass *klass, void *data)
+static void pnv_xive2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index 7de4bf9885c..bc4dc90ade1 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -281,7 +281,7 @@ static const VMStateDescription ppc_uic_vmstate = {
     },
 };
 
-static void ppc_uic_class_init(ObjectClass *klass, void *data)
+static void ppc_uic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 9b12116b2af..63e25c2a781 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -63,7 +63,7 @@ static void realview_gic_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", 1);
 }
 
-static void realview_gic_class_init(ObjectClass *oc, void *data)
+static void realview_gic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index db374a7c2d2..b0139f03f59 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -328,7 +328,7 @@ static const VMStateDescription vmstate_riscv_mtimer = {
         }
 };
 
-static void riscv_aclint_mtimer_class_init(ObjectClass *klass, void *data)
+static void riscv_aclint_mtimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = riscv_aclint_mtimer_realize;
@@ -509,7 +509,7 @@ static void riscv_aclint_swi_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void riscv_aclint_swi_class_init(ObjectClass *klass, void *data)
+static void riscv_aclint_swi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = riscv_aclint_swi_realize;
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 48666491158..79f7f8b0030 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -993,7 +993,7 @@ static const VMStateDescription vmstate_riscv_aplic = {
         }
 };
 
-static void riscv_aplic_class_init(ObjectClass *klass, void *data)
+static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index dc8162c0a7c..5feefd973c9 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -413,7 +413,7 @@ static const VMStateDescription vmstate_riscv_imsic = {
         }
 };
 
-static void riscv_imsic_class_init(ObjectClass *klass, void *data)
+static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index ca13c5fb37b..f8615527b75 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -368,7 +368,7 @@ static const Property rxicu_properties[] = {
                       qdev_prop_uint8, uint8_t),
 };
 
-static void rxicu_class_init(ObjectClass *klass, void *data)
+static void rxicu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index c20f4c10750..f6711725dc8 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -450,7 +450,7 @@ static const Property qemu_s390_flic_properties[] = {
                      migrate_all_state, true),
 };
 
-static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
+static void qemu_s390_flic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
@@ -482,7 +482,7 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
     fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
 }
 
-static void s390_flic_class_init(ObjectClass *oc, void *data)
+static void s390_flic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 10aaafbb312..f833a3996a6 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -670,7 +670,7 @@ static void kvm_s390_flic_reset(DeviceState *dev)
     flic_enable_pfault(flic);
 }
 
-static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
+static void kvm_s390_flic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index a5b0f6ef1bc..3160b216fdc 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -446,7 +446,7 @@ static const Property sifive_plic_properties[] = {
     DEFINE_PROP_UINT32("aperture-size", SiFivePLICState, aperture_size, 0),
 };
 
-static void sifive_plic_class_init(ObjectClass *klass, void *data)
+static void sifive_plic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index f83709a8576..5776055a8b4 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -441,7 +441,7 @@ static void slavio_intctl_init(Object *obj)
     }
 }
 
-static void slavio_intctl_class_init(ObjectClass *klass, void *data)
+static void slavio_intctl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a764c0bb575..fad03dbfbe8 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -809,7 +809,7 @@ static bool spapr_xive_in_kernel_xptr(const XivePresenter *xptr)
     return spapr_xive_in_kernel(SPAPR_XIVE(xptr));
 }
 
-static void spapr_xive_class_init(ObjectClass *klass, void *data)
+static void spapr_xive_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XiveRouterClass *xrc = XIVE_ROUTER_CLASS(klass);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 9c1b7bbe9e3..d9a199e8834 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -350,7 +350,7 @@ static const Property icp_properties[] = {
     DEFINE_PROP_LINK(ICP_PROP_CPU, ICPState, cs, TYPE_CPU, CPUState *),
 };
 
-static void icp_class_init(ObjectClass *klass, void *data)
+static void icp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -681,7 +681,7 @@ static const Property ics_properties[] = {
                      XICSFabric *),
 };
 
-static void ics_class_init(ObjectClass *klass, void *data)
+static void ics_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 753c067f172..ff602d9a346 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -176,7 +176,7 @@ static void pnv_icp_realize(DeviceState *dev, Error **errp)
                           icp, "icp-thread", 0x1000);
 }
 
-static void pnv_icp_class_init(ObjectClass *klass, void *data)
+static void pnv_icp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ICPStateClass *icpc = ICP_CLASS(klass);
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index a0d97bdefed..9e465fb8f3b 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -436,7 +436,7 @@ static void xics_spapr_deactivate(SpaprInterruptController *intc)
     }
 }
 
-static void ics_spapr_class_init(ObjectClass *klass, void *data)
+static void ics_spapr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ICSStateClass *isc = ICS_CLASS(klass);
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6930f83907a..f1ed3398c52 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -184,7 +184,7 @@ static const Property xilinx_intc_properties[] = {
     DEFINE_PROP_UINT32("kind-of-intr", XpsIntc, c_kind_of_intr, 0),
 };
 
-static void xilinx_intc_class_init(ObjectClass *klass, void *data)
+static void xilinx_intc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 139cfdf9bfa..a91d71d108e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -933,7 +933,7 @@ static const Property xive_tctx_properties[] = {
                      XivePresenter *),
 };
 
-static void xive_tctx_class_init(ObjectClass *klass, void *data)
+static void xive_tctx_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1415,7 +1415,7 @@ static const Property xive_source_properties[] = {
                      XiveNotifier *),
 };
 
-static void xive_source_class_init(ObjectClass *klass, void *data)
+static void xive_source_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -2005,7 +2005,7 @@ static const Property xive_router_properties[] = {
                      TYPE_XIVE_FABRIC, XiveFabric *),
 };
 
-static void xive_router_class_init(ObjectClass *klass, void *data)
+static void xive_router_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
@@ -2174,7 +2174,7 @@ static const Property xive_end_source_properties[] = {
                      XiveRouter *),
 };
 
-static void xive_end_source_class_init(ObjectClass *klass, void *data)
+static void xive_end_source_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index fc5aed33158..cf37aa2e4a7 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1033,7 +1033,7 @@ static const Property xive2_router_properties[] = {
                      TYPE_XIVE_FABRIC, XiveFabric *),
 };
 
-static void xive2_router_class_init(ObjectClass *klass, void *data)
+static void xive2_router_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
@@ -1248,7 +1248,7 @@ static const Property xive2_end_source_properties[] = {
                      Xive2Router *),
 };
 
-static void xive2_end_source_class_init(ObjectClass *klass, void *data)
+static void xive2_end_source_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index ccdab244b3a..9200585e325 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -531,7 +531,7 @@ static const VMStateDescription vmstate_xlnx_pmu_io_intc = {
     }
 };
 
-static void xlnx_pmu_io_intc_class_init(ObjectClass *klass, void *data)
+static void xlnx_pmu_io_intc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index 72413772981..610cd0e3164 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -355,7 +355,7 @@ static const VMStateDescription vmstate_zynqmp_pmu_ipi = {
     }
 };
 
-static void xlnx_zynqmp_ipi_class_init(ObjectClass *klass, void *data)
+static void xlnx_zynqmp_ipi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index b6defae6025..ab602bff734 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -74,7 +74,7 @@ static const Property ipack_device_props[] = {
     DEFINE_PROP_INT32("slot", IPackDevice, slot, -1),
 };
 
-static void ipack_device_class_init(ObjectClass *klass, void *data)
+static void ipack_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 470a4203ae4..f6993330d23 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -629,7 +629,7 @@ static const VMStateDescription vmstate_tpci200 = {
     }
 };
 
-static void tpci200_class_init(ObjectClass *klass, void *data)
+static void tpci200_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index fdeaa5269f7..b91e487e1b8 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -78,7 +78,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
     }
 }
 
-static void ipmi_interface_class_init(ObjectClass *class, void *data)
+static void ipmi_interface_class_init(ObjectClass *class, const void *data)
 {
     IPMIInterfaceClass *ik = IPMI_INTERFACE_CLASS(class);
 
@@ -112,7 +112,7 @@ static const Property ipmi_bmc_properties[] = {
     DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
 };
 
-static void bmc_class_init(ObjectClass *oc, void *data)
+static void bmc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index d015500254a..e14978b2576 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -519,7 +519,7 @@ static const Property ipmi_bmc_extern_properties[] = {
     DEFINE_PROP_CHR("chardev", IPMIBmcExtern, chr),
 };
 
-static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
+static void ipmi_bmc_extern_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIBmcClass *bk = IPMI_BMC_CLASS(oc);
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac71201..df2aca088d0 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2205,7 +2205,7 @@ static const Property ipmi_sim_properties[] = {
     DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
 };
 
-static void ipmi_sim_class_init(ObjectClass *oc, void *data)
+static void ipmi_sim_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIBmcClass *bk = IPMI_BMC_CLASS(oc);
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a1b66d5ee82..f7f7abcca89 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -140,7 +140,7 @@ static const Property ipmi_isa_properties[] = {
     DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
 };
 
-static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
+static void isa_ipmi_bt_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index d9ebdd5371f..67969ca0636 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -147,7 +147,7 @@ static const Property ipmi_isa_properties[] = {
     DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
 };
 
-static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
+static void isa_ipmi_kcs_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index afeea6f3031..78d81420089 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -108,7 +108,7 @@ static void *pci_ipmi_bt_get_backend_data(IPMIInterface *ii)
     return &pik->bt;
 }
 
-static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
+static void pci_ipmi_bt_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
index 05ba97ec58f..40127de393e 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -108,7 +108,7 @@ static void *pci_ipmi_kcs_get_backend_data(IPMIInterface *ii)
     return &pik->kcs;
 }
 
-static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
+static void pci_ipmi_kcs_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index 56865df7dbd..7345844a3a9 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -351,7 +351,7 @@ static void smbus_ipmi_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
     info->uuid = sid->uuid;
 }
 
-static void smbus_ipmi_class_init(ObjectClass *oc, void *data)
+static void smbus_ipmi_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
diff --git a/hw/isa/fdc37m81x-superio.c b/hw/isa/fdc37m81x-superio.c
index 55e91fbca17..c2a38f04b11 100644
--- a/hw/isa/fdc37m81x-superio.c
+++ b/hw/isa/fdc37m81x-superio.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/superio.h"
 
-static void fdc37m81x_class_init(ObjectClass *klass, void *data)
+static void fdc37m81x_class_init(ObjectClass *klass, const void *data)
 {
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index cbaa152a899..26c8ec4f77a 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -122,7 +122,7 @@ static void i82378_init(Object *obj)
     qdev_init_gpio_in(dev, i82378_request_pic_irq, 16);
 }
 
-static void i82378_class_init(ObjectClass *klass, void *data)
+static void i82378_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 2599c1219a5..6c9802eb7ac 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -29,7 +29,7 @@ static ISABus *isabus;
 
 static char *isabus_get_fw_dev_path(DeviceState *dev);
 
-static void isa_bus_class_init(ObjectClass *klass, void *data)
+static void isa_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
@@ -205,7 +205,7 @@ ISADevice *isa_vga_init(ISABus *bus)
     }
 }
 
-static void isabus_bridge_class_init(ObjectClass *klass, void *data)
+static void isabus_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -220,7 +220,7 @@ static const TypeInfo isabus_bridge_info = {
     .class_init    = isabus_bridge_class_init,
 };
 
-static void isa_device_class_init(ObjectClass *klass, void *data)
+static void isa_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_type = TYPE_ISA_BUS;
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 4260da547c6..2853485977c 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -172,7 +172,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void isa_superio_class_init(ObjectClass *oc, void *data)
+static void isa_superio_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index dcb0ac28483..d3e623b1e88 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -875,7 +875,7 @@ static void build_ich9_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
     qbus_build_aml(bus, scope);
 }
 
-static void ich9_lpc_class_init(ObjectClass *klass, void *data)
+static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 5f5868442ab..388da8f5900 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -332,7 +332,7 @@ static const Property pc87312_properties[] = {
     DEFINE_PROP_UINT8("config", PC87312State, config, 1),
 };
 
-static void pc87312_class_init(ObjectClass *klass, void *data)
+static void pc87312_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 7fc9e3ec9de..2c6e76f97cc 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -417,7 +417,7 @@ static const Property pci_piix_props[] = {
     DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
 };
 
-static void pci_piix_class_init(ObjectClass *klass, void *data)
+static void pci_piix_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -464,7 +464,7 @@ static void piix3_init(Object *obj)
     object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
 }
 
-static void piix3_class_init(ObjectClass *klass, void *data)
+static void piix3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -494,7 +494,7 @@ static void piix4_init(Object *obj)
     object_initialize_child(obj, "ide", &s->ide, TYPE_PIIX4_IDE);
 }
 
-static void piix4_class_init(ObjectClass *klass, void *data)
+static void piix4_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index d2e58c9a895..0ec63f520c5 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -58,7 +58,7 @@ static unsigned int get_fdc_dma(ISASuperIODevice *sio, uint8_t index)
     return 2;
 }
 
-static void smc37c669_class_init(ObjectClass *klass, void *data)
+static void smc37c669_class_init(ObjectClass *klass, const void *data)
 {
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 43bd67eeef2..80366aaf647 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -220,7 +220,7 @@ typedef struct via_pm_init_info {
     uint16_t device_id;
 } ViaPMInitInfo;
 
-static void via_pm_class_init(ObjectClass *klass, void *data)
+static void via_pm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -337,7 +337,7 @@ static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t data)
     isa_fdc_set_enabled(s->superio.floppy, data & BIT(4));
 }
 
-static void via_superio_class_init(ObjectClass *klass, void *data)
+static void via_superio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
@@ -456,7 +456,7 @@ static void vt82c686b_superio_init(Object *obj)
     VIA_SUPERIO(obj)->io_ops = &vt82c686b_superio_cfg_ops;
 }
 
-static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
+static void vt82c686b_superio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
@@ -565,7 +565,7 @@ static void vt8231_superio_init(Object *obj)
     VIA_SUPERIO(obj)->io_ops = &vt8231_superio_cfg_ops;
 }
 
-static void vt8231_superio_class_init(ObjectClass *klass, void *data)
+static void vt8231_superio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
@@ -833,7 +833,7 @@ static void vt82c686b_init(Object *obj)
     object_initialize_child(obj, "pm", &s->pm, TYPE_VT82C686B_PM);
 }
 
-static void vt82c686b_class_init(ObjectClass *klass, void *data)
+static void vt82c686b_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -898,7 +898,7 @@ static void vt8231_init(Object *obj)
     object_initialize_child(obj, "pm", &s->pm, TYPE_VT8231_PM);
 }
 
-static void vt8231_class_init(ObjectClass *klass, void *data)
+static void vt8231_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 63fa0f4e32a..9c3ede6e74c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1456,7 +1456,7 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
     }
 }
 
-static void virt_class_init(ObjectClass *oc, void *data)
+static void virt_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index c22e615f7a8..a25e782403f 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -605,7 +605,7 @@ static const Property mcf5206_mbar_properties[] = {
                      TYPE_M68K_CPU, M68kCPU *),
 };
 
-static void mcf5206_mbar_class_init(ObjectClass *oc, void *data)
+static void mcf5206_mbar_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 7b9213947df..e3055b841e8 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -182,7 +182,7 @@ static const Property mcf_intc_properties[] = {
                      TYPE_M68K_CPU, M68kCPU *),
 };
 
-static void mcf_intc_class_init(ObjectClass *oc, void *data)
+static void mcf_intc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0570e4a76f1..186baaaac58 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -793,7 +793,7 @@ static const VMStateDescription next_scsi_vmstate = {
     },
 };
 
-static void next_scsi_class_init(ObjectClass *klass, void *data)
+static void next_scsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1064,7 +1064,7 @@ static const VMStateDescription next_rtc_vmstate = {
     },
 };
 
-static void next_rtc_class_init(ObjectClass *klass, void *data)
+static void next_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1228,7 +1228,7 @@ static const VMStateDescription next_pc_vmstate = {
     },
 };
 
-static void next_pc_class_init(ObjectClass *klass, void *data)
+static void next_pc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1348,7 +1348,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x02000000, &m->dmamem);
 }
 
-static void next_machine_class_init(ObjectClass *oc, void *data)
+static void next_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 68b17786b2d..2bec945acfb 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -312,7 +312,7 @@ static const VMStateDescription nextkbd_vmstate = {
     .unmigratable = 1,    /* TODO: Implement this when m68k CPU is migratable */
 };
 
-static void nextkbd_class_init(ObjectClass *oc, void *data)
+static void nextkbd_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 168665b3829..b428e7c833e 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -228,7 +228,7 @@ static void glue_init(Object *obj)
     s->nmi_release = timer_new_ms(QEMU_CLOCK_VIRTUAL, glue_nmi_release, s);
 }
 
-static void glue_class_init(ObjectClass *klass, void *data)
+static void glue_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index aeed4c8ddb8..88e304c548d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -728,7 +728,7 @@ static GlobalProperty hw_compat_q800[] = {
 };
 static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
 
-static void q800_machine_class_init(ObjectClass *oc, void *data)
+static void q800_machine_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
         M68K_CPU_TYPE_NAME("m68040"),
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index d967bdd7438..05d5334adf6 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -309,7 +309,7 @@ static void virt_init(MachineState *machine)
     }
 }
 
-static void virt_machine_class_init(ObjectClass *oc, void *data)
+static void virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "QEMU M68K Virtual Machine";
@@ -338,7 +338,7 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
     static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
         ObjectClass *oc, \
-        void *data) \
+        const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a345..b98c068476d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2128,7 +2128,7 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     }
 }
 
-static void ct3_class_init(ObjectClass *oc, void *data)
+static void ct3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/mem/npcm7xx_mc.c b/hw/mem/npcm7xx_mc.c
index abc5af56208..07fc108e0a9 100644
--- a/hw/mem/npcm7xx_mc.c
+++ b/hw/mem/npcm7xx_mc.c
@@ -65,7 +65,7 @@ static void npcm7xx_mc_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
 }
 
-static void npcm7xx_mc_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_mc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index c05007ab21d..23ab143ef8e 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -250,7 +250,7 @@ static const Property nvdimm_properties[] = {
     DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
 };
 
-static void nvdimm_class_init(ObjectClass *oc, void *data)
+static void nvdimm_class_init(ObjectClass *oc, const void *data)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 799a618c1cc..6f68171442f 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -276,7 +276,7 @@ static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
     }
 }
 
-static void pc_dimm_class_init(ObjectClass *oc, void *data)
+static void pc_dimm_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 6a9a591370a..ed8fd70ac08 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -137,7 +137,7 @@ static void sparse_mem_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->mmio);
 }
 
-static void sparse_mem_class_init(ObjectClass *klass, void *data)
+static void sparse_mem_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2c0d8c34cd2..9c5059ee245 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -135,7 +135,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
                            NULL);
 }
 
-static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
+static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
+                                                    const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index bdbf7328bf4..254672901e8 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -121,7 +121,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
+static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 0d8cbdc8924..2a3ba3f58d2 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -173,7 +173,7 @@ static const Property mips_cps_properties[] = {
     DEFINE_PROP_BOOL("cpu-big-endian", MIPSCPSState, cpu_is_bigendian, false),
 };
 
-static void mips_cps_class_init(ObjectClass *klass, void *data)
+static void mips_cps_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c89610639a9..8a7df89c515 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -415,7 +415,7 @@ void mips_pica61_init(MachineState *machine)
     mips_jazz_init(machine, JAZZ_PICA61);
 }
 
-static void mips_magnum_class_init(ObjectClass *oc, void *data)
+static void mips_magnum_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -432,7 +432,7 @@ static const TypeInfo mips_magnum_type = {
     .class_init = mips_magnum_class_init,
 };
 
-static void mips_pica61_class_init(ObjectClass *oc, void *data)
+static void mips_pica61_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 831fddb1bd7..c35ab09027a 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -667,7 +667,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     loongson3_virt_devices_init(machine, liointc);
 }
 
-static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
+static void loongson3v_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 088d4adb0d5..bb00ae29692 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -127,7 +127,7 @@ static const Property a9_scu_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9SCUState, num_cpu, 1),
 };
 
-static void a9_scu_class_init(ObjectClass *klass, void *data)
+static void a9_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-a10-ccm.c b/hw/misc/allwinner-a10-ccm.c
index 575b0189524..0d590679cae 100644
--- a/hw/misc/allwinner-a10-ccm.c
+++ b/hw/misc/allwinner-a10-ccm.c
@@ -199,7 +199,7 @@ static const VMStateDescription allwinner_a10_ccm_vmstate = {
     }
 };
 
-static void allwinner_a10_ccm_class_init(ObjectClass *klass, void *data)
+static void allwinner_a10_ccm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/allwinner-a10-dramc.c b/hw/misc/allwinner-a10-dramc.c
index a7c58fa6d06..495ba87cd08 100644
--- a/hw/misc/allwinner-a10-dramc.c
+++ b/hw/misc/allwinner-a10-dramc.c
@@ -154,7 +154,7 @@ static const VMStateDescription allwinner_a10_dramc_vmstate = {
     }
 };
 
-static void allwinner_a10_dramc_class_init(ObjectClass *klass, void *data)
+static void allwinner_a10_dramc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index 022f63ddf34..6a1ad553184 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -258,7 +258,7 @@ static const VMStateDescription allwinner_cpucfg_vmstate = {
     }
 };
 
-static void allwinner_cpucfg_class_init(ObjectClass *klass, void *data)
+static void allwinner_cpucfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
index 92e579a9918..5e58e11c9c7 100644
--- a/hw/misc/allwinner-h3-ccu.c
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -218,7 +218,7 @@ static const VMStateDescription allwinner_h3_ccu_vmstate = {
     }
 };
 
-static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data)
+static void allwinner_h3_ccu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 13bba26d0e4..efdb37607b5 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -331,7 +331,7 @@ static const VMStateDescription allwinner_h3_dramc_vmstate = {
     }
 };
 
-static void allwinner_h3_dramc_class_init(ObjectClass *klass, void *data)
+static void allwinner_h3_dramc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-h3-sysctrl.c b/hw/misc/allwinner-h3-sysctrl.c
index 40059e8cb0c..8ae232ff0bb 100644
--- a/hw/misc/allwinner-h3-sysctrl.c
+++ b/hw/misc/allwinner-h3-sysctrl.c
@@ -116,7 +116,8 @@ static const VMStateDescription allwinner_h3_sysctrl_vmstate = {
     }
 };
 
-static void allwinner_h3_sysctrl_class_init(ObjectClass *klass, void *data)
+static void allwinner_h3_sysctrl_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index 005a15b2dae..93ad6507d4b 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -185,7 +185,7 @@ static const VMStateDescription allwinner_r40_ccu_vmstate = {
     }
 };
 
-static void allwinner_r40_ccu_class_init(ObjectClass *klass, void *data)
+static void allwinner_r40_ccu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 97c3664e3a3..ca46341dfd6 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -484,7 +484,7 @@ static const VMStateDescription allwinner_r40_dramc_vmstate = {
     }
 };
 
-static void allwinner_r40_dramc_class_init(ObjectClass *klass, void *data)
+static void allwinner_r40_dramc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 042b747f30b..2fd1917f56c 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -143,7 +143,7 @@ static const VMStateDescription allwinner_sid_vmstate = {
     }
 };
 
-static void allwinner_sid_class_init(ObjectClass *klass, void *data)
+static void allwinner_sid_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index a20b0b4c5cb..e400583f966 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -135,7 +135,7 @@ static void allwinner_sramc_reset(DeviceState *dev)
     }
 }
 
-static void allwinner_sramc_class_init(ObjectClass *klass, void *data)
+static void allwinner_sramc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -163,7 +163,7 @@ static const TypeInfo allwinner_sramc_info = {
     .class_init    = allwinner_sramc_class_init,
 };
 
-static void allwinner_r40_sramc_class_init(ObjectClass *klass, void *data)
+static void allwinner_r40_sramc_class_init(ObjectClass *klass, const void *data)
 {
     AwSRAMCClass *sc = AW_SRAMC_CLASS(klass);
 
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 97ea842d60c..d83a81b60d3 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -375,7 +375,7 @@ static void build_applesmc_aml(AcpiDevAmlIf *adev, Aml *scope)
     aml_append(scope, dev);
 }
 
-static void qdev_applesmc_class_init(ObjectClass *klass, void *data)
+static void qdev_applesmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 02493cec31b..2ad4fd1d21d 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -79,7 +79,7 @@ static const Property arm11_scu_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARM11SCUState, num_cpu, 1),
 };
 
-static void arm11_scu_class_init(ObjectClass *oc, void *data)
+static void arm11_scu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index 39b4642da7d..8b4b61eed00 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -177,7 +177,7 @@ static const Property l2x0_properties[] = {
     DEFINE_PROP_UINT32("cache-type", L2x0State, cache_type, 0x1c100100),
 };
 
-static void l2x0_class_init(ObjectClass *klass, void *data)
+static void l2x0_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 01663407eca..0f4e37cd474 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -634,7 +634,7 @@ static const Property arm_sysctl_properties[] = {
                       db_clock_reset, qdev_prop_uint32, uint32_t),
 };
 
-static void arm_sysctl_class_init(ObjectClass *klass, void *data)
+static void arm_sysctl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/armsse-cpu-pwrctrl.c b/hw/misc/armsse-cpu-pwrctrl.c
index 2d3a0ac29ce..66e9218f277 100644
--- a/hw/misc/armsse-cpu-pwrctrl.c
+++ b/hw/misc/armsse-cpu-pwrctrl.c
@@ -125,7 +125,7 @@ static void pwrctrl_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void pwrctrl_class_init(ObjectClass *klass, void *data)
+static void pwrctrl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 58cb37333f0..a57764d731f 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -106,7 +106,7 @@ static void armsse_cpuid_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void armsse_cpuid_class_init(ObjectClass *klass, void *data)
+static void armsse_cpuid_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 91c49108b00..d5d307a186c 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -176,7 +176,7 @@ static void armsse_mhu_init(Object *obj)
     sysbus_init_irq(sbd, &s->cpu1irq);
 }
 
-static void armsse_mhu_class_init(ObjectClass *klass, void *data)
+static void armsse_mhu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/armv7m_ras.c b/hw/misc/armv7m_ras.c
index de24922c944..7bf5acd0a54 100644
--- a/hw/misc/armv7m_ras.c
+++ b/hw/misc/armv7m_ras.c
@@ -72,7 +72,7 @@ static void armv7m_ras_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void armv7m_ras_class_init(ObjectClass *klass, void *data)
+static void armv7m_ras_class_init(ObjectClass *klass, const void *data)
 {
     /* This device has no state: no need for vmstate or reset */
 }
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index e3f7df2e862..1ebda4f10a7 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -454,7 +454,7 @@ static const VMStateDescription vmstate_aspeed_hace = {
     }
 };
 
-static void aspeed_hace_class_init(ObjectClass *klass, void *data)
+static void aspeed_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -472,7 +472,7 @@ static const TypeInfo aspeed_hace_info = {
     .class_size = sizeof(AspeedHACEClass)
 };
 
-static void aspeed_ast2400_hace_class_init(ObjectClass *klass, void *data)
+static void aspeed_ast2400_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedHACEClass *ahc = ASPEED_HACE_CLASS(klass);
@@ -491,7 +491,7 @@ static const TypeInfo aspeed_ast2400_hace_info = {
     .class_init = aspeed_ast2400_hace_class_init,
 };
 
-static void aspeed_ast2500_hace_class_init(ObjectClass *klass, void *data)
+static void aspeed_ast2500_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedHACEClass *ahc = ASPEED_HACE_CLASS(klass);
@@ -510,7 +510,7 @@ static const TypeInfo aspeed_ast2500_hace_info = {
     .class_init = aspeed_ast2500_hace_class_init,
 };
 
-static void aspeed_ast2600_hace_class_init(ObjectClass *klass, void *data)
+static void aspeed_ast2600_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedHACEClass *ahc = ASPEED_HACE_CLASS(klass);
@@ -529,7 +529,7 @@ static const TypeInfo aspeed_ast2600_hace_info = {
     .class_init = aspeed_ast2600_hace_class_init,
 };
 
-static void aspeed_ast1030_hace_class_init(ObjectClass *klass, void *data)
+static void aspeed_ast1030_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedHACEClass *ahc = ASPEED_HACE_CLASS(klass);
diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index ab39c6435b5..3bef1c84dd1 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -327,7 +327,7 @@ static const Property aspeed_i3c_device_properties[] = {
     DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),
 };
 
-static void aspeed_i3c_device_class_init(ObjectClass *klass, void *data)
+static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -356,7 +356,7 @@ static const VMStateDescription vmstate_aspeed_i3c = {
     }
 };
 
-static void aspeed_i3c_class_init(ObjectClass *klass, void *data)
+static void aspeed_i3c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 228d250dc03..78406dae248 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -458,7 +458,7 @@ static const Property aspeed_lpc_properties[] = {
     DEFINE_PROP_UINT32("hicr7", AspeedLPCState, hicr7, 0),
 };
 
-static void aspeed_lpc_class_init(ObjectClass *klass, void *data)
+static void aspeed_lpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/aspeed_peci.c b/hw/misc/aspeed_peci.c
index 9025b35f836..a7a449a9236 100644
--- a/hw/misc/aspeed_peci.c
+++ b/hw/misc/aspeed_peci.c
@@ -130,7 +130,7 @@ static void aspeed_peci_reset(DeviceState *dev)
     memset(s->regs, 0, sizeof(s->regs));
 }
 
-static void aspeed_peci_class_init(ObjectClass *klass, void *data)
+static void aspeed_peci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index e4a6bd15818..a7d101ba71f 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -141,7 +141,7 @@ static const Property aspeed_sbc_properties[] = {
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
 };
 
-static void aspeed_sbc_class_init(ObjectClass *klass, void *data)
+static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -159,7 +159,7 @@ static const TypeInfo aspeed_sbc_info = {
     .class_size = sizeof(AspeedSBCClass)
 };
 
-static void aspeed_ast2600_sbc_class_init(ObjectClass *klass, void *data)
+static void aspeed_ast2600_sbc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index bac1441b061..7fb1b5a51b0 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -609,7 +609,7 @@ static const Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
 };
 
-static void aspeed_scu_class_init(ObjectClass *klass, void *data)
+static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = aspeed_scu_realize;
@@ -628,7 +628,7 @@ static const TypeInfo aspeed_scu_info = {
     .abstract      = true,
 };
 
-static void aspeed_2400_scu_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
@@ -650,7 +650,7 @@ static const TypeInfo aspeed_2400_scu_info = {
     .class_init = aspeed_2400_scu_class_init,
 };
 
-static void aspeed_2500_scu_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
@@ -824,7 +824,7 @@ static void aspeed_ast2600_scu_reset(DeviceState *dev)
     s->regs[PROT_KEY] = s->hw_prot_key;
 }
 
-static void aspeed_2600_scu_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
@@ -940,7 +940,7 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
 }
 
-static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
@@ -1054,7 +1054,7 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCUIO_CLK_DUTY_MEAS_RST]   = 0x0c9100d2,
 };
 
-static void aspeed_2700_scuio_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
@@ -1112,7 +1112,7 @@ static void aspeed_ast1030_scu_reset(DeviceState *dev)
     s->regs[PROT_KEY] = s->hw_prot_key;
 }
 
-static void aspeed_1030_scu_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f359640a9a5..f04d9930dd7 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -299,7 +299,7 @@ static const Property aspeed_sdmc_properties[] = {
     DEFINE_PROP_BOOL("unlocked", AspeedSDMCState, unlocked, false),
 };
 
-static void aspeed_sdmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = aspeed_sdmc_realize;
@@ -380,7 +380,7 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
 static const uint64_t
 aspeed_2400_ram_sizes[] = { 64 * MiB, 128 * MiB, 256 * MiB, 512 * MiB, 0};
 
-static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
@@ -448,7 +448,7 @@ static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
 static const uint64_t
 aspeed_2500_ram_sizes[] = { 128 * MiB, 256 * MiB, 512 * MiB, 1024 * MiB, 0};
 
-static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
@@ -542,7 +542,7 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
 static const uint64_t
 aspeed_2600_ram_sizes[] = { 256 * MiB, 512 * MiB, 1024 * MiB, 2048 * MiB, 0};
 
-static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
@@ -670,7 +670,7 @@ static const uint64_t
     aspeed_2700_ram_sizes[] = { 256 * MiB, 512 * MiB, 1024 * MiB,
                                 2048 * MiB, 4096 * MiB, 8192 * MiB, 0};
 
-static void aspeed_2700_sdmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
diff --git a/hw/misc/aspeed_sli.c b/hw/misc/aspeed_sli.c
index fe720ead509..c51484035e0 100644
--- a/hw/misc/aspeed_sli.c
+++ b/hw/misc/aspeed_sli.c
@@ -124,7 +124,7 @@ static void aspeed_sliio_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void aspeed_sli_class_init(ObjectClass *klass, void *data)
+static void aspeed_sli_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -140,14 +140,14 @@ static const TypeInfo aspeed_sli_info = {
     .abstract      = true,
 };
 
-static void aspeed_2700_sli_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_sli_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "AST2700 SLI Controller";
 }
 
-static void aspeed_2700_sliio_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_sliio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 1dd32f72f45..cc03c422b0e 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -150,7 +150,7 @@ static const VMStateDescription aspeed_xdma_vmstate = {
     },
 };
 
-static void aspeed_2600_xdma_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_xdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedXDMAClass *axc = ASPEED_XDMA_CLASS(klass);
@@ -173,7 +173,7 @@ static const TypeInfo aspeed_2600_xdma_info = {
     .class_init = aspeed_2600_xdma_class_init,
 };
 
-static void aspeed_2500_xdma_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_xdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedXDMAClass *axc = ASPEED_XDMA_CLASS(klass);
@@ -195,7 +195,7 @@ static const TypeInfo aspeed_2500_xdma_info = {
     .class_init = aspeed_2500_xdma_class_init,
 };
 
-static void aspeed_2400_xdma_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_xdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedXDMAClass *axc = ASPEED_XDMA_CLASS(klass);
@@ -217,7 +217,7 @@ static const TypeInfo aspeed_2400_xdma_info = {
     .class_init = aspeed_2400_xdma_class_init,
 };
 
-static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
+static void aspeed_xdma_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
 
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 28d50d9d097..877f3456062 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -50,7 +50,7 @@ static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge);
 
 /* aux-bus implementation (internal not public) */
-static void aux_bus_class_init(ObjectClass *klass, void *data)
+static void aux_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
@@ -256,7 +256,7 @@ struct AUXTOI2CState {
     I2CBus *i2c_bus;
 };
 
-static void aux_bridge_class_init(ObjectClass *oc, void *data)
+static void aux_bridge_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -311,7 +311,7 @@ void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio)
     aux_slave->mmio = mmio;
 }
 
-static void aux_slave_class_init(ObjectClass *klass, void *data)
+static void aux_slave_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index ac7b96f53e3..411f016c997 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -90,7 +90,7 @@ static void avr_mask_init(Object *dev)
     s->val = 0x00;
 }
 
-static void avr_mask_class_init(ObjectClass *klass, void *data)
+static void avr_mask_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c
index af646878cd2..46d17712dde 100644
--- a/hw/misc/axp2xx.c
+++ b/hw/misc/axp2xx.c
@@ -225,7 +225,7 @@ static const VMStateDescription vmstate_axp2xx = {
     }
 };
 
-static void axp2xx_class_init(ObjectClass *oc, void *data)
+static void axp2xx_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
@@ -247,7 +247,7 @@ static const TypeInfo axp2xx_info = {
     .abstract = true,
 };
 
-static void axp209_class_init(ObjectClass *oc, void *data)
+static void axp209_class_init(ObjectClass *oc, const void *data)
 {
     AXP2xxClass *sc = AXP2XX_CLASS(oc);
 
@@ -260,7 +260,7 @@ static const TypeInfo axp209_info = {
     .class_init = axp209_class_init
 };
 
-static void axp221_class_init(ObjectClass *oc, void *data)
+static void axp221_class_init(ObjectClass *oc, const void *data)
 {
     AXP2xxClass *sc = AXP2XX_CLASS(oc);
 
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index aa14cd931f5..9321080ce8f 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -131,7 +131,7 @@ static const VMStateDescription pll_vmstate = {
     }
 };
 
-static void pll_class_init(ObjectClass *klass, void *data)
+static void pll_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -235,7 +235,7 @@ static const VMStateDescription pll_channel_vmstate = {
     }
 };
 
-static void pll_channel_class_init(ObjectClass *klass, void *data)
+static void pll_channel_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -356,7 +356,7 @@ static const VMStateDescription clock_mux_vmstate = {
     }
 };
 
-static void clock_mux_class_init(ObjectClass *klass, void *data)
+static void clock_mux_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -411,7 +411,7 @@ static const VMStateDescription dsi0hsck_mux_vmstate = {
     }
 };
 
-static void dsi0hsck_mux_class_init(ObjectClass *klass, void *data)
+static void dsi0hsck_mux_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -782,7 +782,7 @@ static const Property cprman_properties[] = {
     DEFINE_PROP_UINT32("xosc-freq-hz", BCM2835CprmanState, xosc_freq, 19200000),
 };
 
-static void cprman_class_init(ObjectClass *klass, void *data)
+static void cprman_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index ed6dbea1917..603eaaa710d 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -314,7 +314,7 @@ static void bcm2835_mbox_realize(DeviceState *dev, Error **errp)
     bcm2835_mbox_reset(dev);
 }
 
-static void bcm2835_mbox_class_init(ObjectClass *klass, void *data)
+static void bcm2835_mbox_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
index 7309cf22fc7..55d79e7e876 100644
--- a/hw/misc/bcm2835_mphi.c
+++ b/hw/misc/bcm2835_mphi.c
@@ -166,7 +166,7 @@ const VMStateDescription vmstate_mphi_state = {
     }
 };
 
-static void mphi_class_init(ObjectClass *klass, void *data)
+static void mphi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index e4e9bae3745..3ec7abad0e0 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -136,7 +136,7 @@ static void bcm2835_powermgt_reset(DeviceState *dev)
     s->wdog = 0x00000000;
 }
 
-static void bcm2835_powermgt_class_init(ObjectClass *klass, void *data)
+static void bcm2835_powermgt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 2bae64b64c6..a21c6a541c0 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -556,7 +556,7 @@ static const Property bcm2835_property_props[] = {
     DEFINE_PROP_STRING("command-line", BCM2835PropertyState, command_line),
 };
 
-static void bcm2835_property_class_init(ObjectClass *klass, void *data)
+static void bcm2835_property_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index 06f40817df6..e4d2c224c88 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -123,7 +123,7 @@ static void bcm2835_rng_reset(DeviceState *dev)
     s->rng_status = 0;
 }
 
-static void bcm2835_rng_class_init(ObjectClass *klass, void *data)
+static void bcm2835_rng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index 1c1b0671cc0..33bfc91c7aa 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -113,7 +113,7 @@ static const VMStateDescription bcm2835_thermal_vmstate = {
     }
 };
 
-static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
+static void bcm2835_thermal_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 577b8844946..04a9fc31223 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -61,7 +61,7 @@ static const Property debug_exit_properties[] = {
     DEFINE_PROP_UINT32("iosize", ISADebugExitState, iosize, 0x02),
 };
 
-static void debug_exit_class_initfn(ObjectClass *klass, void *data)
+static void debug_exit_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
index 96d5efb5e3a..c5b09f551b0 100644
--- a/hw/misc/djmemc.c
+++ b/hw/misc/djmemc.c
@@ -113,7 +113,7 @@ static const VMStateDescription vmstate_djmemc = {
     }
 };
 
-static void djmemc_class_init(ObjectClass *oc, void *data)
+static void djmemc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index d7452c4cc8a..81fc536131c 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -329,7 +329,7 @@ static const Property ecc_properties[] = {
     DEFINE_PROP_UINT32("version", ECCState, version, -1),
 };
 
-static void ecc_class_init(ObjectClass *klass, void *data)
+static void ecc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 504178b4a22..a6e0786b6f1 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -415,7 +415,7 @@ static void edu_instance_init(Object *obj)
                                    &edu->dma_mask, OBJ_PROP_FLAG_READWRITE);
 }
 
-static void edu_class_init(ObjectClass *class, void *data)
+static void edu_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 221ea7cb54d..239d7603207 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -84,7 +84,7 @@ static const Property empty_slot_properties[] = {
     DEFINE_PROP_STRING("name", EmptySlot, name),
 };
 
-static void empty_slot_class_init(ObjectClass *klass, void *data)
+static void empty_slot_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index 886d10bbab5..fdf5bdd6034 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -141,7 +141,7 @@ static const VMStateDescription exynos4210_clk_vmstate = {
     }
 };
 
-static void exynos4210_clk_class_init(ObjectClass *klass, void *data)
+static void exynos4210_clk_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index d44aac3af5c..a86ec9aba85 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -498,7 +498,7 @@ static const VMStateDescription exynos4210_pmu_vmstate = {
     }
 };
 
-static void exynos4210_pmu_class_init(ObjectClass *klass, void *data)
+static void exynos4210_pmu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index a741cf176b7..2d0ebc457bc 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -255,7 +255,7 @@ static const VMStateDescription exynos4210_rng_vmstate = {
     }
 };
 
-static void exynos4210_rng_class_init(ObjectClass *klass, void *data)
+static void exynos4210_rng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 5b05f158592..cdca00ad542 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -168,7 +168,7 @@ static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &ahb_pnp->iomem);
 }
 
-static void grlib_ahb_pnp_class_init(ObjectClass *klass, void *data)
+static void grlib_ahb_pnp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -280,7 +280,7 @@ static void grlib_apb_pnp_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &apb_pnp->iomem);
 }
 
-static void grlib_apb_pnp_class_init(ObjectClass *klass, void *data)
+static void grlib_apb_pnp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 65d10029dc7..0f906fa60ef 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -147,7 +147,7 @@ static void i2c_echo_realize(DeviceState *dev, Error **errp)
     return;
 }
 
-static void i2c_echo_class_init(ObjectClass *oc, void *data)
+static void i2c_echo_class_init(ObjectClass *oc, const void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index 9654d23f195..a6665d55353 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -292,7 +292,7 @@ static void imx25_ccm_init(Object *obj)
     sysbus_init_mmio(sd, &s->iomem);
 }
 
-static void imx25_ccm_class_init(ObjectClass *klass, void *data)
+static void imx25_ccm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 93130b24e5e..339458e8596 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -319,7 +319,7 @@ static void imx31_ccm_init(Object *obj)
     sysbus_init_mmio(sd, &s->iomem);
 }
 
-static void imx31_ccm_class_init(ObjectClass *klass, void *data)
+static void imx31_ccm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc  = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 7d522ed7c5f..a10b67d3961 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -741,7 +741,7 @@ static void imx6_ccm_init(Object *obj)
     sysbus_init_mmio(sd, &s->container);
 }
 
-static void imx6_ccm_class_init(ObjectClass *klass, void *data)
+static void imx6_ccm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 06cc46292ed..8d2c4175e4e 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -273,7 +273,7 @@ static void imx6_src_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
-static void imx6_src_class_init(ObjectClass *klass, void *data)
+static void imx6_src_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index c836dfe494c..7f3ae61710c 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -904,7 +904,7 @@ static void imx6ul_ccm_init(Object *obj)
     sysbus_init_mmio(sd, &s->container);
 }
 
-static void imx6ul_ccm_class_init(ObjectClass *klass, void *data)
+static void imx6ul_ccm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index c3ecfd78c19..c061a584e46 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -262,7 +262,7 @@ static uint32_t imx7_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     return freq;
 }
 
-static void imx7_ccm_class_init(ObjectClass *klass, void *data)
+static void imx7_ccm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
@@ -293,7 +293,7 @@ static const VMStateDescription vmstate_imx7_analog = {
     },
 };
 
-static void imx7_analog_class_init(ObjectClass *klass, void *data)
+static void imx7_analog_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index b03341a2eba..e12b4962730 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -102,7 +102,7 @@ static void imx7_gpr_init(Object *obj)
     sysbus_init_mmio(sd, &s->mmio);
 }
 
-static void imx7_gpr_class_init(ObjectClass *klass, void *data)
+static void imx7_gpr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index c8a096bc137..6a8733d23d7 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -143,7 +143,7 @@ static void imx7_snvs_init(Object *obj)
         qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
 }
 
-static void imx7_snvs_class_init(ObjectClass *klass, void *data)
+static void imx7_snvs_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index 35341c68198..df0b0a69057 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -251,7 +251,7 @@ static void imx7_src_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
-static void imx7_src_class_init(ObjectClass *klass, void *data)
+static void imx7_src_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
index 0cbf28db5dd..630f6cb54b5 100644
--- a/hw/misc/imx_rngc.c
+++ b/hw/misc/imx_rngc.c
@@ -254,7 +254,7 @@ static const VMStateDescription vmstate_imx_rngc = {
     }
 };
 
-static void imx_rngc_class_init(ObjectClass *klass, void *data)
+static void imx_rngc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
index 31927eaedb4..96221e1ee5a 100644
--- a/hw/misc/iosb.c
+++ b/hw/misc/iosb.c
@@ -111,7 +111,7 @@ static const VMStateDescription vmstate_iosb = {
     }
 };
 
-static void iosb_class_init(ObjectClass *oc, void *data)
+static void iosb_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 04ced3559c2..afd9ab48df7 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -818,7 +818,7 @@ static const Property iotkit_secctl_props[] = {
     DEFINE_PROP_UINT32("sse-version", IoTKitSecCtl, sse_version, 0),
 };
 
-static void iotkit_secctl_class_init(ObjectClass *klass, void *data)
+static void iotkit_secctl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index c654af2e884..d70e51ab2ec 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -844,7 +844,7 @@ static const Property iotkit_sysctl_props[] = {
                        0x10000000),
 };
 
-static void iotkit_sysctl_class_init(ObjectClass *klass, void *data)
+static void iotkit_sysctl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 75260f7fabb..57405cb7e17 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -158,7 +158,7 @@ static void iotkit_sysinfo_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void iotkit_sysinfo_class_init(ObjectClass *klass, void *data)
+static void iotkit_sysinfo_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 40309a8ff38..7cf9075a847 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -433,7 +433,7 @@ static const Property ivshmem_flat_props[] = {
     DEFINE_PROP_UINT32("shmem-size", IvshmemFTState, shmem_size, 4 * MiB),
 };
 
-static void ivshmem_flat_class_init(ObjectClass *klass, void *data)
+static void ivshmem_flat_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 900d523334c..2844b6f9099 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -979,7 +979,7 @@ static int ivshmem_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void ivshmem_common_class_init(ObjectClass *klass, void *data)
+static void ivshmem_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1044,7 +1044,7 @@ static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
     ivshmem_common_realize(dev, errp);
 }
 
-static void ivshmem_plain_class_init(ObjectClass *klass, void *data)
+static void ivshmem_plain_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1103,7 +1103,7 @@ static void ivshmem_doorbell_realize(PCIDevice *dev, Error **errp)
     ivshmem_common_realize(dev, errp);
 }
 
-static void ivshmem_doorbell_class_init(ObjectClass *klass, void *data)
+static void ivshmem_doorbell_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 24d20ffcb8d..9f758c6a863 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -263,7 +263,7 @@ static void lasi_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), lasi_set_irq, LASI_IRQS);
 }
 
-static void lasi_class_init(ObjectClass *klass, void *data)
+static void lasi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 9364d9945ec..f7f709072af 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -107,7 +107,7 @@ static const Property led_properties[] = {
     DEFINE_PROP_BOOL("gpio-active-high", LEDState, gpio_active_high, true),
 };
 
-static void led_class_init(ObjectClass *klass, void *data)
+static void led_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 03b1feda505..63552dc088e 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1326,7 +1326,7 @@ static const Property mos6522_q800_via1_properties[] = {
     DEFINE_PROP_DRIVE("drive", MOS6522Q800VIA1State, blk),
 };
 
-static void mos6522_q800_via1_class_init(ObjectClass *oc, void *data)
+static void mos6522_q800_via1_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
@@ -1415,7 +1415,7 @@ static const VMStateDescription vmstate_q800_via2 = {
     }
 };
 
-static void mos6522_q800_via2_class_init(ObjectClass *oc, void *data)
+static void mos6522_q800_via2_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 34731ae560a..bcd00c9bb1b 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -558,7 +558,7 @@ static const Property cuda_properties[] = {
     DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0),
 };
 
-static void cuda_class_init(ObjectClass *oc, void *data)
+static void cuda_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -598,7 +598,7 @@ static void mos6522_cuda_reset_hold(Object *obj, ResetType type)
     ms->timers[1].frequency = (SCALE_US * 6000) / 4700;
 }
 
-static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
+static void mos6522_cuda_class_init(ObjectClass *oc, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(oc);
     MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 7cad62819a0..1b4e386b0d8 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -189,7 +189,7 @@ static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp)
     macio_set_gpio(MACIO_GPIO(n), 9, false);
 }
 
-static void macio_gpio_class_init(ObjectClass *oc, void *data)
+static void macio_gpio_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index de0f934f7d0..b2b42dd5622 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -917,7 +917,7 @@ static void mac_dbdma_realize(DeviceState *dev, Error **errp)
     s->bh = qemu_bh_new_guarded(DBDMA_run_bh, s, &dev->mem_reentrancy_guard);
 }
 
-static void mac_dbdma_class_init(ObjectClass *oc, void *data)
+static void mac_dbdma_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 194b152effe..b0418db49ea 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -385,7 +385,7 @@ static const VMStateDescription vmstate_macio_oldworld = {
     }
 };
 
-static void macio_oldworld_class_init(ObjectClass *oc, void *data)
+static void macio_oldworld_class_init(ObjectClass *oc, const void *data)
 {
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -410,7 +410,7 @@ static const Property macio_newworld_properties[] = {
     DEFINE_PROP_BOOL("has-adb", NewWorldMacIOState, has_adb, false),
 };
 
-static void macio_newworld_class_init(ObjectClass *oc, void *data)
+static void macio_newworld_class_init(ObjectClass *oc, const void *data)
 {
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -425,7 +425,7 @@ static const Property macio_properties[] = {
     DEFINE_PROP_UINT64("frequency", MacIOState, frequency, 0),
 };
 
-static void macio_class_init(ObjectClass *klass, void *data)
+static void macio_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 73190559a83..37349139948 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -764,7 +764,7 @@ static const Property pmu_properties[] = {
     DEFINE_PROP_BOOL("has-adb", PMUState, has_adb, true),
 };
 
-static void pmu_class_init(ObjectClass *oc, void *data)
+static void pmu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -808,7 +808,7 @@ static void mos6522_pmu_reset_hold(Object *obj, ResetType type)
     s->last_b = ms->b = TACK | TREQ;
 }
 
-static void mos6522_pmu_class_init(ObjectClass *oc, void *data)
+static void mos6522_pmu_class_init(ObjectClass *oc, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(oc);
     MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
diff --git a/hw/misc/mchp_pfsoc_dmc.c b/hw/misc/mchp_pfsoc_dmc.c
index 43d8e970abc..599f845f459 100644
--- a/hw/misc/mchp_pfsoc_dmc.c
+++ b/hw/misc/mchp_pfsoc_dmc.c
@@ -110,7 +110,8 @@ static void mchp_pfsoc_ddr_sgmii_phy_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sgmii_phy);
 }
 
-static void mchp_pfsoc_ddr_sgmii_phy_class_init(ObjectClass *klass, void *data)
+static void mchp_pfsoc_ddr_sgmii_phy_class_init(ObjectClass *klass,
+                                                const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -192,7 +193,7 @@ static void mchp_pfsoc_ddr_cfg_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->cfg);
 }
 
-static void mchp_pfsoc_ddr_cfg_class_init(ObjectClass *klass, void *data)
+static void mchp_pfsoc_ddr_cfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index a71d134295a..10fc7ea2a95 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -292,7 +292,7 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
 
-static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, void *data)
+static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index 7876fe0c5ba..bfa78d3d2fa 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -85,7 +85,7 @@ static void mchp_pfsoc_sysreg_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
 
-static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, void *data)
+static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 95f19912b46..5484b739674 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -229,7 +229,7 @@ static void mips_gcr_realize(DeviceState *dev, Error **errp)
     s->vps = g_new(MIPSGCRVPState, s->num_vps);
 }
 
-static void mips_gcr_class_init(ObjectClass *klass, void *data)
+static void mips_gcr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     device_class_set_props(dc, mips_gcr_properties);
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 772b8c0017d..c7311edc3fd 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -168,7 +168,7 @@ static const Property mips_cpc_properties[] = {
     DEFINE_PROP_UINT64("vp-start-running", MIPSCPCState, vp_start_running, 0x1),
 };
 
-static void mips_cpc_class_init(ObjectClass *klass, void *data)
+static void mips_cpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 2d126ebaf85..fc17385cde7 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -540,7 +540,7 @@ static const Property mips_itu_properties[] = {
                       ITC_SEMAPH_NUM_MAX),
 };
 
-static void mips_itu_class_init(ObjectClass *klass, void *data)
+static void mips_itu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 0b8f6a4cb4c..8dd6b82ac5f 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -700,7 +700,7 @@ static const Property mos6522_properties[] = {
     DEFINE_PROP_UINT64("frequency", MOS6522State, frequency, 0),
 };
 
-static void mos6522_class_init(ObjectClass *oc, void *data)
+static void mos6522_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     ResettableClass *rc = RESETTABLE_CLASS(oc);
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index d07568248d6..f76c915ced9 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -328,7 +328,7 @@ static const Property mps2_fpgaio_properties[] = {
     DEFINE_PROP_BOOL("has-dbgctrl", MPS2FPGAIO, has_dbgctrl, false),
 };
 
-static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
+static void mps2_fpgaio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 5f8d6bca43b..a9a5d4a535b 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -474,7 +474,7 @@ static const Property mps2_scc_properties[] = {
                       qdev_prop_uint32, uint32_t),
 };
 
-static void mps2_scc_class_init(ObjectClass *klass, void *data)
+static void mps2_scc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 20009adbd95..ce0ad50c1be 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -136,7 +136,7 @@ static void msf2_sysreg_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
+static void msf2_sysreg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index 46f907b61c2..bd4bba76a99 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -1009,7 +1009,7 @@ static const VMStateDescription vmstate_npcm7xx_clk = {
     },
 };
 
-static void npcm7xx_clk_pll_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_clk_pll_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1017,7 +1017,7 @@ static void npcm7xx_clk_pll_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_npcm7xx_clk_pll;
 }
 
-static void npcm7xx_clk_sel_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_clk_sel_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1025,7 +1025,7 @@ static void npcm7xx_clk_sel_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_npcm7xx_clk_sel;
 }
 
-static void npcm7xx_clk_divider_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_clk_divider_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1033,7 +1033,7 @@ static void npcm7xx_clk_divider_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_npcm7xx_clk_divider;
 }
 
-static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_clk_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
index 07464a4dc93..c0c2a0b3edc 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm7xx_gcr.c
@@ -234,7 +234,7 @@ static const Property npcm7xx_gcr_properties[] = {
     DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
 };
 
-static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_gcr_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index e565cac05d8..b35e971fe53 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -515,7 +515,7 @@ static const VMStateDescription vmstate_npcm7xx_mft = {
     },
 };
 
-static void npcm7xx_mft_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_mft_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index f7f77e30a22..2de18d09b82 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -543,7 +543,7 @@ static const VMStateDescription vmstate_npcm7xx_pwm_module = {
     },
 };
 
-static void npcm7xx_pwm_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_pwm_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/npcm7xx_rng.c b/hw/misc/npcm7xx_rng.c
index 7f7e5eca626..7d47a1caa07 100644
--- a/hw/misc/npcm7xx_rng.c
+++ b/hw/misc/npcm7xx_rng.c
@@ -158,7 +158,7 @@ static const VMStateDescription vmstate_npcm7xx_rng = {
     },
 };
 
-static void npcm7xx_rng_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_rng_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 1e67acdf234..8cd7ffe3f55 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -240,7 +240,7 @@ static const VMStateDescription vmstate_rng = {
     }
 };
 
-static void nrf51_rng_class_init(ObjectClass *klass, void *data)
+static void nrf51_rng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index e3896518694..67c486f347c 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -193,7 +193,7 @@ static void testdev_realizefn(DeviceState *d, Error **errp)
     memory_region_add_subregion(mem, 0xff000000, &dev->iomem);
 }
 
-static void testdev_class_init(ObjectClass *klass, void *data)
+static void testdev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index f6718a7c37d..0ea26451f1f 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -323,7 +323,7 @@ static const Property pci_testdev_properties[] = {
     DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
 };
 
-static void pci_testdev_class_init(ObjectClass *klass, void *data)
+static void pci_testdev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index c3713dc5c47..55522ee56cb 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -104,7 +104,7 @@ static const Property pvpanic_isa_properties[] = {
                       PVPANIC_EVENTS),
 };
 
-static void pvpanic_isa_class_init(ObjectClass *klass, void *data)
+static void pvpanic_isa_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index e5f0788ec0e..51ebf661076 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -58,7 +58,7 @@ static const Property pvpanic_pci_properties[] = {
                       PVPANIC_EVENTS),
 };
 
-static void pvpanic_pci_class_init(ObjectClass *klass, void *data)
+static void pvpanic_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
diff --git a/hw/misc/sbsa_ec.c b/hw/misc/sbsa_ec.c
index a1e813691e4..dfee1af5ad2 100644
--- a/hw/misc/sbsa_ec.c
+++ b/hw/misc/sbsa_ec.c
@@ -73,7 +73,7 @@ static void sbsa_ec_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static void sbsa_ec_class_init(ObjectClass *klass, void *data)
+static void sbsa_ec_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 17a522ccf9b..6eef38d622a 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -294,7 +294,7 @@ static const Property sifive_e_aon_properties[] = {
                        SIFIVE_E_LFCLK_DEFAULT_FREQ),
 };
 
-static void sifive_e_aon_class_init(ObjectClass *oc, void *data)
+static void sifive_e_aon_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index d6df867fbd7..1ebed2fd8b4 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -270,7 +270,7 @@ static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
     memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
 
-static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
+static void sifive_u_otp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
index cafe6a66f4e..6e75cb6d0d5 100644
--- a/hw/misc/sifive_u_prci.c
+++ b/hw/misc/sifive_u_prci.c
@@ -146,7 +146,7 @@ static void sifive_u_prci_reset(DeviceState *dev)
     s->coreclksel = SIFIVE_U_PRCI_CORECLKSEL_HFCLK;
 }
 
-static void sifive_u_prci_class_init(ObjectClass *klass, void *data)
+static void sifive_u_prci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index dace6d28ccb..a034df3592f 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -483,7 +483,7 @@ static void slavio_misc_init(Object *obj)
     qdev_init_gpio_in(dev, slavio_set_power_fail, 1);
 }
 
-static void slavio_misc_class_init(ObjectClass *klass, void *data)
+static void slavio_misc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 26672b5b24a..94e8dae441c 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -138,7 +138,7 @@ static const VMStateDescription vmstate_stm32_rcc = {
     }
 };
 
-static void stm32_rcc_class_init(ObjectClass *klass, void *data)
+static void stm32_rcc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 6c7b722274a..d285896ea76 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -138,7 +138,7 @@ static void stm32f2xx_syscfg_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-static void stm32f2xx_syscfg_class_init(ObjectClass *klass, void *data)
+static void stm32f2xx_syscfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
index efd996df94e..0688e6e73ec 100644
--- a/hw/misc/stm32f4xx_exti.c
+++ b/hw/misc/stm32f4xx_exti.c
@@ -164,7 +164,7 @@ static const VMStateDescription vmstate_stm32f4xx_exti = {
     }
 };
 
-static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
+static void stm32f4xx_exti_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index 7d0f3eb5f5b..addfb031e88 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -147,7 +147,7 @@ static const VMStateDescription vmstate_stm32f4xx_syscfg = {
     }
 };
 
-static void stm32f4xx_syscfg_class_init(ObjectClass *klass, void *data)
+static void stm32f4xx_syscfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index e281841dcf4..9c002164c82 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -271,7 +271,7 @@ static const VMStateDescription vmstate_stm32l4x5_exti = {
     }
 };
 
-static void stm32l4x5_exti_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_exti_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index fd8466dff34..fb4ef15067c 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -141,7 +141,7 @@ static const VMStateDescription clock_mux_vmstate = {
     }
 };
 
-static void clock_mux_class_init(ObjectClass *klass, void *data)
+static void clock_mux_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -293,7 +293,7 @@ static const VMStateDescription pll_vmstate = {
     }
 };
 
-static void pll_class_init(ObjectClass *klass, void *data)
+static void pll_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -1435,7 +1435,7 @@ static const Property stm32l4x5_rcc_properties[] = {
         sai2_extclk_frequency, 0),
 };
 
-static void stm32l4x5_rcc_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_rcc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index a947a9e036b..4e21756e0b4 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -259,7 +259,7 @@ static const VMStateDescription vmstate_stm32l4x5_syscfg = {
     }
 };
 
-static void stm32l4x5_syscfg_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_syscfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 6d827d21dc2..a158d4a2944 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -592,7 +592,7 @@ static const Property tz_mpc_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void tz_mpc_class_init(ObjectClass *klass, void *data)
+static void tz_mpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -611,7 +611,7 @@ static const TypeInfo tz_mpc_info = {
 };
 
 static void tz_mpc_iommu_memory_region_class_init(ObjectClass *klass,
-                                                  void *data)
+                                                  const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 505df4e1902..af0cc5d4718 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -285,7 +285,7 @@ static const Property tz_msc_properties[] = {
                      TYPE_IDAU_INTERFACE, IDAUInterface *),
 };
 
-static void tz_msc_class_init(ObjectClass *klass, void *data)
+static void tz_msc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 1daa54c5e69..e4235a846d4 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -325,7 +325,7 @@ static const Property tz_ppc_properties[] = {
     DEFINE_PORT(15),
 };
 
-static void tz_ppc_class_init(ObjectClass *klass, void *data)
+static void tz_ppc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 257282a3a9d..4370c14ef16 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -75,7 +75,7 @@ static const Property unimp_properties[] = {
     DEFINE_PROP_STRING("name", UnimplementedDeviceState, name),
 };
 
-static void unimp_class_init(ObjectClass *klass, void *data)
+static void unimp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index a210a5924c9..9f16093ca2c 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -125,7 +125,7 @@ static void virt_ctrl_instance_init(Object *obj)
     sysbus_init_irq(dev, &s->irq);
 }
 
-static void virt_ctrl_class_init(ObjectClass *oc, void *data)
+static void virt_ctrl_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index b0145fa5044..9c2e9005ad3 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -83,7 +83,7 @@ static const VMStateDescription vmstate_vmcoreinfo = {
     },
 };
 
-static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
+static void vmcoreinfo_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 8db0f7e6589..e28d569ebef 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -803,7 +803,7 @@ static const Property cframe_bcast_regs_props[] = {
                      TYPE_XLNX_CFI_IF, XlnxCfiIf *),
 };
 
-static void cframe_reg_class_init(ObjectClass *klass, void *data)
+static void cframe_reg_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -817,7 +817,7 @@ static void cframe_reg_class_init(ObjectClass *klass, void *data)
     xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
 }
 
-static void cframe_bcast_reg_class_init(ObjectClass *klass, void *data)
+static void cframe_bcast_reg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 26d06e2557d..02e4fed05b9 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -496,7 +496,7 @@ static const VMStateDescription vmstate_cfu_sfr = {
     }
 };
 
-static void cfu_apb_class_init(ObjectClass *klass, void *data)
+static void cfu_apb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -505,7 +505,7 @@ static void cfu_apb_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, cfu_props);
 }
 
-static void cfu_fdro_class_init(ObjectClass *klass, void *data)
+static void cfu_fdro_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -516,7 +516,7 @@ static void cfu_fdro_class_init(ObjectClass *klass, void *data)
     rc->phases.enter = cfu_fdro_reset_enter;
 }
 
-static void cfu_sfr_class_init(ObjectClass *klass, void *data)
+static void cfu_sfr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index f143900d5b4..08ff2fcc24f 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -394,7 +394,7 @@ static const VMStateDescription vmstate_crl = {
     }
 };
 
-static void crl_class_init(ObjectClass *klass, void *data)
+static void crl_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index e469c04d763..d76df468d49 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -1419,7 +1419,8 @@ static const VMStateDescription vmstate_pmc_iou_slcr = {
     }
 };
 
-static void xlnx_versal_pmc_iou_slcr_class_init(ObjectClass *klass, void *data)
+static void xlnx_versal_pmc_iou_slcr_class_init(ObjectClass *klass,
+                                                const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index dbd9b58a4ec..e122e417c35 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -682,7 +682,7 @@ static const VMStateDescription vmstate_trng = {
     }
 };
 
-static void trng_class_init(ObjectClass *klass, void *data)
+static void trng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index d1e76be027c..07370b80c0d 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -222,7 +222,7 @@ static const Property xram_ctrl_properties[] = {
     DEFINE_PROP_UINT64("size", XlnxXramCtrl, cfg.size, 1 * MiB),
 };
 
-static void xram_ctrl_class_init(ObjectClass *klass, void *data)
+static void xram_ctrl_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 87e4a140679..e85da32d99c 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -224,7 +224,7 @@ static const VMStateDescription vmstate_zynqmp_apu = {
     }
 };
 
-static void zynqmp_apu_class_init(ObjectClass *klass, void *data)
+static void zynqmp_apu_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index e5aba56f691..cccca0e814e 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -239,7 +239,7 @@ static const VMStateDescription vmstate_crf = {
     }
 };
 
-static void crf_class_init(ObjectClass *klass, void *data)
+static void crf_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index a766bab1825..010387beec4 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -627,7 +627,7 @@ static const Property zynq_slcr_props[] = {
     DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
 };
 
-static void zynq_slcr_class_init(ObjectClass *klass, void *data)
+static void zynq_slcr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index ff44554e957..134e6bd0cc0 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -875,7 +875,8 @@ static const VMStateDescription vmstate_aw_emac = {
     }
 };
 
-static void allwinner_sun8i_emac_class_init(ObjectClass *klass, void *data)
+static void allwinner_sun8i_emac_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 3eb9e09dc5c..6dce3f04683 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -514,7 +514,7 @@ static const VMStateDescription vmstate_aw_emac = {
     }
 };
 
-static void aw_emac_class_init(ObjectClass *klass, void *data)
+static void aw_emac_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 80fbbacc1e7..50025d5a6f2 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1817,7 +1817,7 @@ static const Property gem_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void gem_class_init(ObjectClass *klass, void *data)
+static void gem_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 9e363d532f5..c0bb598baef 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -282,7 +282,7 @@ static void kvaser_pci_instance_init(Object *obj)
                              0);
 }
 
-static void kvaser_pci_class_init(ObjectClass *klass, void *data)
+static void kvaser_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 580f099e00a..9aac70dccd3 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -223,7 +223,7 @@ static void mioe3680_pci_instance_init(Object *obj)
                              0);
 }
 
-static void mioe3680_pci_class_init(ObjectClass *klass, void *data)
+static void mioe3680_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 3195b79954a..b305f7e9b7d 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -224,7 +224,7 @@ static void pcm3680i_pci_instance_init(Object *obj)
                              0);
 }
 
-static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
+static void pcm3680i_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index a8c77b91943..0dee9b59d10 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -237,7 +237,7 @@ static void ctucan_pci_instance_init(Object *obj)
 #endif
 }
 
-static void ctucan_pci_class_init(ObjectClass *klass, void *data)
+static void ctucan_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index dc242e92155..39071800136 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -2054,7 +2054,7 @@ static const Property canfd_core_properties[] = {
                      CanBusState *),
 };
 
-static void canfd_class_init(ObjectClass *klass, void *data)
+static void canfd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 9fbdeea368f..ca9edd4a5b8 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -1176,7 +1176,7 @@ static const Property xlnx_zynqmp_can_properties[] = {
                      CanBusState *),
 };
 
-static void xlnx_zynqmp_can_class_init(ObjectClass *klass, void *data)
+static void xlnx_zynqmp_can_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index c80ddb12e38..d49032059bb 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -939,7 +939,7 @@ static const Property dp8393x_properties[] = {
     DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
 };
 
-static void dp8393x_class_init(ObjectClass *klass, void *data)
+static void dp8393x_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 3d0b2277039..d49730f4ad4 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1694,7 +1694,7 @@ typedef struct E1000Info {
     uint16_t   phy_id2;
 } E1000Info;
 
-static void e1000_class_init(ObjectClass *klass, void *data)
+static void e1000_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index f637853073e..5e58f39235e 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -674,7 +674,7 @@ static const Property e1000e_properties[] = {
     DEFINE_PROP_BOOL("migrate-timadj", E1000EState, timadj, true),
 };
 
-static void e1000e_class_init(ObjectClass *class, void *data)
+static void e1000e_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     ResettableClass *rc = RESETTABLE_CLASS(class);
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 6d853229aec..02a4e787f67 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2062,7 +2062,7 @@ static const Property e100_properties[] = {
     DEFINE_NIC_PROPERTIES(EEPRO100State, conf),
 };
 
-static void eepro100_class_init(ObjectClass *klass, void *data)
+static void eepro100_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 781b9003954..e26ba431def 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -418,7 +418,7 @@ static const Property etsec_properties[] = {
     DEFINE_NIC_PROPERTIES(eTSEC, conf),
 };
 
-static void etsec_class_init(ObjectClass *klass, void *data)
+static void etsec_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 1f524d7a01e..c41ce889cf1 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1260,7 +1260,7 @@ static const Property ftgmac100_properties[] = {
     DEFINE_PROP_BOOL("dma64", FTGMAC100State, dma64, false),
 };
 
-static void ftgmac100_class_init(ObjectClass *klass, void *data)
+static void ftgmac100_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1419,7 +1419,7 @@ static const Property aspeed_mii_properties[] = {
                      FTGMAC100State *),
 };
 
-static void aspeed_mii_class_init(ObjectClass *klass, void *data)
+static void aspeed_mii_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 4d93ce629f9..61e7ea7896b 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -596,7 +596,7 @@ static const Property igb_properties[] = {
     DEFINE_PROP_BOOL("x-pcie-flr-init", IGBState, has_flr, true),
 };
 
-static void igb_class_init(ObjectClass *class, void *data)
+static void igb_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     ResettableClass *rc = RESETTABLE_CLASS(class);
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 21a97d4d61d..91e7ccf931b 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -299,7 +299,7 @@ static void igbvf_pci_uninit(PCIDevice *dev)
     msix_uninit(dev, &s->msix, &s->msix);
 }
 
-static void igbvf_class_init(ObjectClass *class, void *data)
+static void igbvf_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 0f0afda58ae..5c8c441c1e5 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1231,7 +1231,7 @@ static const Property imx_eth_properties[] = {
                      IMXFECState *),
 };
 
-static void imx_eth_class_init(ObjectClass *klass, void *data)
+static void imx_eth_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index afee68c7db6..6dda1e5c940 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1309,7 +1309,7 @@ static const Property lan9118_properties[] = {
     DEFINE_PROP_UINT32("mode_16bit", lan9118_state, mode_16bit, 0),
 };
 
-static void lan9118_class_init(ObjectClass *klass, void *data)
+static void lan9118_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index 5c53a4a1e3f..4c4e03df115 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -200,7 +200,7 @@ static const VMStateDescription vmstate_lan9118_phy = {
     }
 };
 
-static void lan9118_phy_class_init(ObjectClass *klass, void *data)
+static void lan9118_phy_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 15492382f9c..dfb855c23a4 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -143,7 +143,7 @@ static const Property lance_properties[] = {
     DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
 };
 
-static void lance_class_init(ObjectClass *klass, void *data)
+static void lance_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index cad01f53518..9e1dd215467 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -162,7 +162,7 @@ static const Property lasi_82596_properties[] = {
     DEFINE_NIC_PROPERTIES(SysBusI82596State, state.conf),
 };
 
-static void lasi_82596_class_init(ObjectClass *klass, void *data)
+static void lasi_82596_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index d5572a81d3f..ae128fa3114 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -664,7 +664,7 @@ static const Property mcf_fec_properties[] = {
     DEFINE_NIC_PROPERTIES(mcf_fec_state, conf),
 };
 
-static void mcf_fec_class_init(ObjectClass *oc, void *data)
+static void mcf_fec_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 8852b6f3a12..583aa1c7de6 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -270,7 +270,7 @@ static const Property mipsnet_properties[] = {
     DEFINE_NIC_PROPERTIES(MIPSnetState, conf),
 };
 
-static void mipsnet_class_init(ObjectClass *klass, void *data)
+static void mipsnet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 80f75f19ddf..59045973ab9 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -565,7 +565,7 @@ static const VMStateDescription vmstate_msf2_emac = {
     }
 };
 
-static void msf2_emac_class_init(ObjectClass *klass, void *data)
+static void msf2_emac_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index 5a9d14bef62..6f08846c81c 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -377,7 +377,7 @@ static const Property mv88w8618_eth_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void mv88w8618_eth_class_init(ObjectClass *klass, void *data)
+static void mv88w8618_eth_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 20973651f32..673c785abc9 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -85,7 +85,7 @@ static const Property ne2000_isa_properties[] = {
     DEFINE_NIC_PROPERTIES(ISANE2000State, ne2000.c),
 };
 
-static void isa_ne2000_class_initfn(ObjectClass *klass, void *data)
+static void isa_ne2000_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 6840d0e7206..2153973af43 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -100,7 +100,7 @@ static const Property ne2000_properties[] = {
     DEFINE_NIC_PROPERTIES(PCINE2000State, ne2000.c),
 };
 
-static void ne2000_class_init(ObjectClass *klass, void *data)
+static void ne2000_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index e06f6526297..9ba35e2c819 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -849,7 +849,7 @@ static const Property npcm7xx_emc_properties[] = {
     DEFINE_NIC_PROPERTIES(NPCM7xxEMCState, conf),
 };
 
-static void npcm7xx_emc_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_emc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index e1fb3837725..a4341125809 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -916,7 +916,7 @@ static const Property npcm_gmac_properties[] = {
     DEFINE_NIC_PROPERTIES(NPCMGMACState, conf),
 };
 
-static void npcm_gmac_class_init(ObjectClass *klass, void *data)
+static void npcm_gmac_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 54daab7b04c..7e955c01322 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -747,7 +747,7 @@ static const Property open_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(OpenEthState, conf),
 };
 
-static void open_eth_class_init(ObjectClass *klass, void *data)
+static void open_eth_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index b314ea7d6d6..429c2171803 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -256,7 +256,7 @@ static const Property pcnet_properties[] = {
     DEFINE_NIC_PROPERTIES(PCIPCNetState, state.conf),
 };
 
-static void pcnet_class_init(ObjectClass *klass, void *data)
+static void pcnet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index aa5d87fbc5a..3d307f4ab15 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1475,7 +1475,7 @@ static const VMStateDescription rocker_vmsd = {
     .unmigratable = 1,
 };
 
-static void rocker_class_init(ObjectClass *klass, void *data)
+static void rocker_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 135ab57160c..ad812954cf8 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3414,7 +3414,7 @@ static const Property rtl8139_properties[] = {
     DEFINE_NIC_PROPERTIES(RTL8139State, conf),
 };
 
-static void rtl8139_class_init(ObjectClass *klass, void *data)
+static void rtl8139_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index b18d5c23c39..c5c50b085ee 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -792,7 +792,7 @@ static const Property smc91c111_properties[] = {
     DEFINE_NIC_PROPERTIES(smc91c111_state, conf),
 };
 
-static void smc91c111_class_init(ObjectClass *klass, void *data)
+static void smc91c111_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 13fc6565f09..f6f217d6320 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -848,7 +848,7 @@ static const VMStateDescription vmstate_spapr_llan = {
     }
 };
 
-static void spapr_vlan_class_init(ObjectClass *klass, void *data)
+static void spapr_vlan_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index a420732d48f..2fc51e1e16d 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -501,7 +501,7 @@ static const Property stellaris_enet_properties[] = {
     DEFINE_NIC_PROPERTIES(stellaris_enet_state, conf),
 };
 
-static void stellaris_enet_class_init(ObjectClass *klass, void *data)
+static void stellaris_enet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 12a9a9df46a..123d08ee8e3 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1454,7 +1454,7 @@ static const VMStateDescription vmstate_sungem = {
     }
 };
 
-static void sungem_class_init(ObjectClass *klass, void *data)
+static void sungem_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index fa234d0da12..46c9f5020b1 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -937,7 +937,7 @@ static const VMStateDescription vmstate_hme = {
     }
 };
 
-static void sunhme_class_init(ObjectClass *klass, void *data)
+static void sunhme_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index a0646bb84c3..fb3366d8ee3 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1011,7 +1011,7 @@ static const Property tulip_properties[] = {
     DEFINE_NIC_PROPERTIES(TULIPState, c),
 };
 
-static void tulip_class_init(ObjectClass *klass, void *data)
+static void tulip_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d847429b1c3..a85f4818323 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4148,7 +4148,7 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_HOST_USO, true),
 };
 
-static void virtio_net_class_init(ObjectClass *klass, void *data)
+static void virtio_net_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 7abed664690..702a0ac78dc 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2492,7 +2492,7 @@ static void vmxnet3_realize(DeviceState *qdev, Error **errp)
     vc->parent_dc_realize(qdev, errp);
 }
 
-static void vmxnet3_class_init(ObjectClass *class, void *data)
+static void vmxnet3_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index c48691207df..34c6a1d0b08 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -559,7 +559,7 @@ static const Property xen_netdev_properties[] = {
     DEFINE_PROP_INT32("idx", XenNetDev, dev, -1),
 };
 
-static void xen_netdev_class_init(ObjectClass *class, void *data)
+static void xen_netdev_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index e3cc4c60ebd..9c87c4e70fd 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -418,7 +418,7 @@ static const Property xgmac_properties[] = {
     DEFINE_NIC_PROPERTIES(XgmacState, conf),
 };
 
-static void xgmac_enet_class_init(ObjectClass *klass, void *data)
+static void xgmac_enet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 457952af196..e45bc048e05 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1007,7 +1007,7 @@ static const Property xilinx_enet_properties[] = {
                      tx_control_dev, TYPE_STREAM_SINK, StreamSink *),
 };
 
-static void xilinx_enet_class_init(ObjectClass *klass, void *data)
+static void xilinx_enet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1017,14 +1017,15 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
 }
 
 static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
-                                                  void *data)
+                                                  const void *data)
 {
     StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
 
     ssc->push = xilinx_axienet_control_stream_push;
 }
 
-static void xilinx_enet_data_stream_class_init(ObjectClass *klass, void *data)
+static void xilinx_enet_data_stream_class_init(ObjectClass *klass,
+                                               const void *data)
 {
     StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
 
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 14bf2b2e17a..279932dbb94 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -368,7 +368,7 @@ static const Property xilinx_ethlite_properties[] = {
     DEFINE_NIC_PROPERTIES(XlnxXpsEthLite, conf),
 };
 
-static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
+static void xilinx_ethlite_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nubus/mac-nubus-bridge.c b/hw/nubus/mac-nubus-bridge.c
index a0da5a8b2fa..0dac8d19b37 100644
--- a/hw/nubus/mac-nubus-bridge.c
+++ b/hw/nubus/mac-nubus-bridge.c
@@ -40,7 +40,7 @@ static void mac_nubus_bridge_init(Object *obj)
     sysbus_init_mmio(sbd, &s->slot_alias);
 }
 
-static void mac_nubus_bridge_class_init(ObjectClass *klass, void *data)
+static void mac_nubus_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
index 8fe43627237..fb14402c4fc 100644
--- a/hw/nubus/nubus-bridge.c
+++ b/hw/nubus/nubus-bridge.c
@@ -28,7 +28,7 @@ static const Property nubus_bridge_properties[] = {
                        bus.slot_available_mask, 0xffff),
 };
 
-static void nubus_bridge_class_init(ObjectClass *klass, void *data)
+static void nubus_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nubus/nubus-bus.c b/hw/nubus/nubus-bus.c
index 07c279bde5c..44820f13a85 100644
--- a/hw/nubus/nubus-bus.c
+++ b/hw/nubus/nubus-bus.c
@@ -162,7 +162,7 @@ static bool nubus_check_address(BusState *bus, DeviceState *dev, Error **errp)
     return true;
 }
 
-static void nubus_class_init(ObjectClass *oc, void *data)
+static void nubus_class_init(ObjectClass *oc, const void *data)
 {
     BusClass *bc = BUS_CLASS(oc);
 
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 6755c3dc438..7797e61c7fc 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -112,7 +112,7 @@ static const Property nubus_device_properties[] = {
     DEFINE_PROP_STRING("romfile", NubusDevice, romfile),
 };
 
-static void nubus_device_class_init(ObjectClass *oc, void *data)
+static void nubus_device_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
index 7a98731c451..63aeca5b122 100644
--- a/hw/nubus/nubus-virtio-mmio.c
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -81,7 +81,7 @@ static void nubus_virtio_mmio_init(Object *obj)
                             "pic-input-irq", 1);
 }
 
-static void nubus_virtio_mmio_class_init(ObjectClass *oc, void *data)
+static void nubus_virtio_mmio_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_CLASS(oc);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 68903d1d706..a49f1ea9cfe 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9059,7 +9059,7 @@ static const VMStateDescription nvme_vmstate = {
     .unmigratable = 1,
 };
 
-static void nvme_class_init(ObjectClass *oc, void *data)
+static void nvme_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 410df295919..a9233f8d0c4 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -836,7 +836,7 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
 };
 
-static void nvme_ns_class_init(ObjectClass *oc, void *data)
+static void nvme_ns_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 2ae56f12a59..8d037c2515c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -225,7 +225,7 @@ static const Property nvme_subsystem_props[] = {
     DEFINE_PROP_UINT16("fdp.nruh", NvmeSubsystem, params.fdp.nruh, 0),
 };
 
-static void nvme_subsys_class_init(ObjectClass *oc, void *data)
+static void nvme_subsys_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/nvram/bcm2835_otp.c b/hw/nvram/bcm2835_otp.c
index c4aed28472b..6816b534178 100644
--- a/hw/nvram/bcm2835_otp.c
+++ b/hw/nvram/bcm2835_otp.c
@@ -164,7 +164,7 @@ static const VMStateDescription vmstate_bcm2835_otp = {
     }
 };
 
-static void bcm2835_otp_class_init(ObjectClass *klass, void *data)
+static void bcm2835_otp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 6b2aa8c7d26..dbfd0d2e536 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -147,7 +147,7 @@ static const Property nvram_sysbus_properties[] = {
     DEFINE_PROP_STRING("filename", SysBusNvRamState, nvram.filename),
 };
 
-static void nvram_sysbus_class_init(ObjectClass *klass, void *data)
+static void nvram_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index a40cc5dd15a..02e0f664674 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -242,7 +242,7 @@ static const Property at24c_eeprom_props[] = {
 };
 
 static
-void at24c_eeprom_class_init(ObjectClass *klass, void *data)
+void at24c_eeprom_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index a757939cfb7..871d0b4d226 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1228,7 +1228,7 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
     fw_cfg_add_bytes(fw_cfg, data_key, data, size);
 }
 
-static void fw_cfg_class_init(ObjectClass *klass, void *data)
+static void fw_cfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1303,7 +1303,7 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
     fw_cfg_common_realize(dev, errp);
 }
 
-static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
+static void fw_cfg_io_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1364,7 +1364,7 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
     fw_cfg_common_realize(dev, errp);
 }
 
-static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
+static void fw_cfg_mem_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 0d82e5a128f..66526a22914 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -140,7 +140,7 @@ static const Property macio_nvram_properties[] = {
     DEFINE_PROP_DRIVE("drive", MacIONVRAMState, blk),
 };
 
-static void macio_nvram_class_init(ObjectClass *oc, void *data)
+static void macio_nvram_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/nvram/npcm7xx_otp.c b/hw/nvram/npcm7xx_otp.c
index f00ebfa931e..1fb752b20f4 100644
--- a/hw/nvram/npcm7xx_otp.c
+++ b/hw/nvram/npcm7xx_otp.c
@@ -391,7 +391,7 @@ static const VMStateDescription vmstate_npcm7xx_otp = {
     },
 };
 
-static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_otp_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -403,14 +403,14 @@ static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
     rc->phases.enter = npcm7xx_otp_enter_reset;
 }
 
-static void npcm7xx_key_storage_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_key_storage_class_init(ObjectClass *klass, const void *data)
 {
     NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
 
     oc->mmio_ops = &npcm7xx_key_storage_ops;
 }
 
-static void npcm7xx_fuse_array_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_fuse_array_class_init(ObjectClass *klass, const void *data)
 {
     NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
 
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 2ed40788582..23cc9fe9b3d 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -370,7 +370,7 @@ static const VMStateDescription vmstate_nvm = {
     }
 };
 
-static void nrf51_nvm_class_init(ObjectClass *klass, void *data)
+static void nrf51_nvm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index a45827f6aac..d0ac4e5735f 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -257,7 +257,7 @@ static const Property spapr_nvram_properties[] = {
     DEFINE_PROP_DRIVE("drive", SpaprNvram, blk),
 };
 
-static void spapr_nvram_class_init(ObjectClass *klass, void *data)
+static void spapr_nvram_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 0e8552ce656..b01475784e0 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -525,7 +525,7 @@ static const Property bbram_ctrl_props[] = {
     DEFINE_PROP_UINT32("crc-zpads", XlnxBBRam, crc_zpads, 1),
 };
 
-static void bbram_ctrl_class_init(ObjectClass *klass, void *data)
+static void bbram_ctrl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index e2e8311a48c..d0332c1a883 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -274,7 +274,7 @@ static const Property efuse_properties[] = {
                       qdev_prop_uint32, uint32_t),
 };
 
-static void efuse_class_init(ObjectClass *klass, void *data)
+static void efuse_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nvram/xlnx-versal-efuse-cache.c b/hw/nvram/xlnx-versal-efuse-cache.c
index 2fb599422ca..d4ec96a6264 100644
--- a/hw/nvram/xlnx-versal-efuse-cache.c
+++ b/hw/nvram/xlnx-versal-efuse-cache.c
@@ -89,7 +89,7 @@ static const Property efuse_cache_props[] = {
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
 };
 
-static void efuse_cache_class_init(ObjectClass *klass, void *data)
+static void efuse_cache_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 3246eb3ca6e..0d0e7925ccf 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -752,7 +752,7 @@ static const Property efuse_ctrl_props[] = {
                       extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),
 };
 
-static void efuse_ctrl_class_init(ObjectClass *klass, void *data)
+static void efuse_ctrl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 15024daf4fc..5a218c32e84 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -839,7 +839,7 @@ static const Property zynqmp_efuse_props[] = {
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
 };
 
-static void zynqmp_efuse_class_init(ObjectClass *klass, void *data)
+static void zynqmp_efuse_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e0da4067ba3..0b70121e187 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -359,7 +359,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 }
 
-static void openrisc_sim_machine_init(ObjectClass *oc, void *data)
+static void openrisc_sim_machine_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 7b60bf85094..283b2537211 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -545,7 +545,7 @@ static void openrisc_virt_init(MachineState *machine)
     }
 }
 
-static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
+static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index e337f1ac501..ab3b550a889 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -219,7 +219,7 @@ static const Property cxl_dsp_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
 };
 
-static void cxl_dsp_class_init(ObjectClass *oc, void *data)
+static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index c0037f2cfbf..8b1e149e9ba 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -262,7 +262,7 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
     cxl_rp_dvsec_write_config(d, address, val, len);
 }
 
-static void cxl_root_port_class_init(ObjectClass *oc, void *data)
+static void cxl_root_port_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc        = DEVICE_CLASS(oc);
     PCIDeviceClass *k      = PCI_DEVICE_CLASS(oc);
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 28b109c49af..822a8285554 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -371,7 +371,7 @@ static const Property cxl_upstream_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
 };
 
-static void cxl_upstream_class_init(ObjectClass *oc, void *data)
+static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 3c0b41ef1a5..d9078e783bf 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -147,7 +147,7 @@ static const Property gen_rp_props[] = {
                                 width, PCIE_LINK_WIDTH_32),
 };
 
-static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
+static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 00d2fbd7cf1..f2b294aee27 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -87,7 +87,7 @@ static const VMStateDescription i82801b11_bridge_dev_vmstate = {
     }
 };
 
-static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
+static void i82801b11_bridge_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index be752a4bda5..bba640f495b 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -96,7 +96,7 @@ static const VMStateDescription vmstate_ioh3420 = {
     }
 };
 
-static void ioh3420_class_init(ObjectClass *klass, void *data)
+static void ioh3420_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 0a91a8ae6c4..4ac07e82567 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -240,7 +240,7 @@ void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
     shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
 }
 
-static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
+static void pci_bridge_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -280,7 +280,7 @@ static const TypeInfo pci_bridge_dev_info = {
  * different pci id, so we can match it easily in the guest for
  * automagic multiseat configuration.  See docs/multiseat.txt for more.
  */
-static void pci_bridge_dev_seat_class_init(ObjectClass *klass, void *data)
+static void pci_bridge_dev_seat_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3396ab4bdd3..1e2e394ee8a 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -92,7 +92,7 @@ static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &uid, errp);
 }
 
-static void pxb_bus_class_init(ObjectClass *class, void *data)
+static void pxb_bus_class_init(ObjectClass *class, const void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
@@ -169,7 +169,7 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
     return NULL;
 }
 
-static void pxb_host_class_init(ObjectClass *class, void *data)
+static void pxb_host_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(class);
@@ -224,7 +224,7 @@ void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
     cxl_state->next_mr_idx++;
 }
 
-static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
+static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
@@ -427,7 +427,7 @@ static const Property pxb_dev_properties[] = {
     DEFINE_PROP_BOOL("bypass_iommu", PXBDev, bypass_iommu, false),
 };
 
-static void pxb_dev_class_init(ObjectClass *klass, void *data)
+static void pxb_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -465,7 +465,7 @@ static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
     pxb_dev_realize_common(dev, PCIE, errp);
 }
 
-static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
+static void pxb_pcie_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -510,7 +510,7 @@ static const Property pxb_cxl_dev_properties[] = {
     DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
 };
 
-static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
+static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc   = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index fd4514a595c..bb81bccb185 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -138,7 +138,7 @@ static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
         }
 };
 
-static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
+static void pcie_pci_bridge_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index dd40b366bfa..512c2ab305c 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -167,7 +167,7 @@ static void rp_instance_post_init(Object *obj)
     }
 }
 
-static void rp_class_init(ObjectClass *klass, void *data)
+static void rp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index 5fe090df6cf..c7565d9e946 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -66,7 +66,7 @@ static void simba_pci_bridge_realize(PCIDevice *dev, Error **errp)
     pci_bridge_update_mappings(PCI_BRIDGE(br));
 }
 
-static void simba_pci_bridge_class_init(ObjectClass *klass, void *data)
+static void simba_pci_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index d4e94f26571..d85c23fe4a8 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -153,7 +153,7 @@ static const VMStateDescription vmstate_xio3130_downstream = {
     }
 };
 
-static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
+static void xio3130_downstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index fb1547b74ab..d7a27158124 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -123,7 +123,7 @@ static const VMStateDescription vmstate_xio3130_upstream = {
     }
 };
 
-static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
+static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index f3fcc49f812..043fb85e840 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -195,7 +195,7 @@ static void articia_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
-static void articia_class_init(ObjectClass *klass, void *data)
+static void articia_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -228,7 +228,7 @@ static void articia_pci_host_cfg_write(PCIDevice *d, uint32_t addr,
     }
 }
 
-static void articia_pci_host_class_init(ObjectClass *klass, void *data)
+static void articia_pci_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -246,7 +246,7 @@ static void articia_pci_host_class_init(ObjectClass *klass, void *data)
 
 /* TYPE_ARTICIA_PCI_BRIDGE */
 
-static void articia_pci_bridge_class_init(ObjectClass *klass, void *data)
+static void articia_pci_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 039cc3ad01d..c364fa15daf 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -481,7 +481,7 @@ static const VMStateDescription vmstate_elroy = {
     }
 };
 
-static void elroy_pcihost_class_init(ObjectClass *klass, void *data)
+static void elroy_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -908,7 +908,7 @@ static void astro_realize(DeviceState *obj, Error **errp)
     }
 }
 
-static void astro_class_init(ObjectClass *klass, void *data)
+static void astro_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -931,7 +931,7 @@ static const TypeInfo astro_chip_info = {
 };
 
 static void astro_iommu_memory_region_class_init(ObjectClass *klass,
-                                                   void *data)
+                                                 const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 49669148923..4508cdd21ae 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -757,7 +757,7 @@ PCIBus *bonito_init(qemu_irq *pic)
     return phb->bus;
 }
 
-static void bonito_pci_class_init(ObjectClass *klass, void *data)
+static void bonito_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -789,7 +789,7 @@ static const TypeInfo bonito_pci_info = {
     },
 };
 
-static void bonito_host_class_init(ObjectClass *klass, void *data)
+static void bonito_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 3e8c36e6a76..70759cab149 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -590,7 +590,8 @@ static const VMStateDescription vmstate_designware_pcie_root = {
     }
 };
 
-static void designware_pcie_root_class_init(ObjectClass *klass, void *data)
+static void designware_pcie_root_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -730,7 +731,8 @@ static const VMStateDescription vmstate_designware_pcie_host = {
     }
 };
 
-static void designware_pcie_host_class_init(ObjectClass *klass, void *data)
+static void designware_pcie_host_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 58fdbf7bc90..11b353be2ea 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -497,7 +497,7 @@ static const Property dino_pcihost_properties[] = {
                      MemoryRegion *),
 };
 
-static void dino_pcihost_class_init(ObjectClass *klass, void *data)
+static void dino_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 9fcedd7fc58..7dcac4ee3c4 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -192,7 +192,7 @@ static const Property gpex_host_properties[] = {
     DEFINE_PROP_UINT8("num-irqs", GPEXHost, num_irqs, PCI_NUM_PINS),
 };
 
-static void gpex_host_class_init(ObjectClass *klass, void *data)
+static void gpex_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
@@ -237,7 +237,7 @@ static const VMStateDescription vmstate_gpex_root = {
     }
 };
 
-static void gpex_root_class_init(ObjectClass *klass, void *data)
+static void gpex_root_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 84e5ee8c6ef..b48d44623dd 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -94,7 +94,7 @@ static void grackle_pci_realize(PCIDevice *d, Error **errp)
     d->config[PCI_CLASS_PROG] = 0x01;
 }
 
-static void grackle_pci_class_init(ObjectClass *klass, void *data)
+static void grackle_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -133,7 +133,7 @@ static const Property grackle_properties[] = {
     DEFINE_PROP_UINT32("ofw-addr", GrackleState, ofw_addr, -1),
 };
 
-static void grackle_class_init(ObjectClass *klass, void *data)
+static void grackle_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index d5c13a89b68..bd74b6e8714 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1244,7 +1244,7 @@ static void gt64120_pci_reset_hold(Object *obj, ResetType type)
     pci_set_byte(d->config + 0x3d, 0x01);
 }
 
-static void gt64120_pci_class_init(ObjectClass *klass, void *data)
+static void gt64120_pci_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1279,7 +1279,7 @@ static const Property gt64120_properties[] = {
                      cpu_little_endian, false),
 };
 
-static void gt64120_class_init(ObjectClass *klass, void *data)
+static void gt64120_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 1e69691c6d1..fcc9f3818a4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -315,7 +315,7 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
     i440fx_update_memory_mappings(f);
 }
 
-static void i440fx_class_init(ObjectClass *klass, void *data)
+static void i440fx_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -364,7 +364,7 @@ static const Property i440fx_props[] = {
     DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
 };
 
-static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
+static void i440fx_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 9c41c155fb4..591186f41ff 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -26,7 +26,7 @@
 
 #define TYPE_MV64361_PCI_BRIDGE "mv64361-pcibridge"
 
-static void mv64361_pcibridge_class_init(ObjectClass *klass, void *data)
+static void mv64361_pcibridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -102,7 +102,7 @@ static const Property mv64361_pcihost_props[] = {
     DEFINE_PROP_UINT8("index", MV64361PCIState, index, 0),
 };
 
-static void mv64361_pcihost_class_init(ObjectClass *klass, void *data)
+static void mv64361_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -923,7 +923,7 @@ static void mv64361_reset(DeviceState *dev)
     set_mem_windows(s, 0xfbfff);
 }
 
-static void mv64361_class_init(ObjectClass *klass, void *data)
+static void mv64361_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 6c1e76fbbb6..4b0ced79b08 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -194,7 +194,7 @@ static const Property pnv_phb_properties[] = {
                      PnvPhb4PecState *),
 };
 
-static void pnv_phb_class_init(ObjectClass *klass, void *data)
+static void pnv_phb_class_init(ObjectClass *klass, const void *data)
 {
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -304,7 +304,7 @@ static const Property pnv_phb_root_port_properties[] = {
     DEFINE_PROP_UINT32("version", PnvPHBRootPort, version, 0),
 };
 
-static void pnv_phb_root_port_class_init(ObjectClass *klass, void *data)
+static void pnv_phb_root_port_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 82884e1e929..a4335f44f22 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -888,7 +888,7 @@ DECLARE_INSTANCE_CHECKER(IOMMUMemoryRegion, PNV_PHB3_IOMMU_MEMORY_REGION,
                          TYPE_PNV_PHB3_IOMMU_MEMORY_REGION)
 
 static void pnv_phb3_iommu_memory_region_class_init(ObjectClass *klass,
-                                                    void *data)
+                                                    const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
@@ -1097,7 +1097,7 @@ static const Property pnv_phb3_properties[] = {
     DEFINE_PROP_LINK("phb-base", PnvPHB3, phb_base, TYPE_PNV_PHB, PnvPHB *),
 };
 
-static void pnv_phb3_class_init(ObjectClass *klass, void *data)
+static void pnv_phb3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1149,7 +1149,7 @@ static void pnv_phb3_root_bus_set_prop(Object *obj, Visitor *v,
     }
 }
 
-static void pnv_phb3_root_bus_class_init(ObjectClass *klass, void *data)
+static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 81986644b14..3a83311faff 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -284,7 +284,7 @@ static void phb3_msi_instance_init(Object *obj)
     ics->offset = 0;
 }
 
-static void phb3_msi_class_init(ObjectClass *klass, void *data)
+static void phb3_msi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ICSStateClass *isc = ICS_CLASS(klass);
diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
index 82f70efa431..4e24b1449d0 100644
--- a/hw/pci-host/pnv_phb3_pbcq.c
+++ b/hw/pci-host/pnv_phb3_pbcq.c
@@ -337,7 +337,7 @@ static void phb3_pbcq_instance_init(Object *obj)
                              OBJ_PROP_LINK_STRONG);
 }
 
-static void pnv_pbcq_class_init(ObjectClass *klass, void *data)
+static void pnv_pbcq_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 178c73f519b..feb812dc1a9 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1362,7 +1362,7 @@ DECLARE_INSTANCE_CHECKER(IOMMUMemoryRegion, PNV_PHB4_IOMMU_MEMORY_REGION,
                          TYPE_PNV_PHB4_IOMMU_MEMORY_REGION)
 
 static void pnv_phb4_iommu_memory_region_class_init(ObjectClass *klass,
-                                                    void *data)
+                                                    const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
@@ -1696,7 +1696,7 @@ static const Property pnv_phb4_properties[] = {
     DEFINE_PROP_LINK("phb-base", PnvPHB4, phb_base, TYPE_PNV_PHB, PnvPHB *),
 };
 
-static void pnv_phb4_class_init(ObjectClass *klass, void *data)
+static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XiveNotifierClass *xfc = XIVE_NOTIFIER_CLASS(klass);
@@ -1761,7 +1761,7 @@ static void pnv_phb4_root_bus_set_prop(Object *obj, Visitor *v,
     }
 }
 
-static void pnv_phb4_root_bus_class_init(ObjectClass *klass, void *data)
+static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index a156839caf5..a4e5e8c226c 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -307,7 +307,7 @@ static uint32_t pnv_pec_xscom_nest_base(PnvPhb4PecState *pec)
  */
 static const uint32_t pnv_pec_num_phbs[] = { 1, 2, 3 };
 
-static void pnv_pec_class_init(ObjectClass *klass, void *data)
+static void pnv_pec_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
@@ -367,7 +367,7 @@ static uint32_t pnv_phb5_pec_xscom_nest_base(PnvPhb4PecState *pec)
  */
 static const uint32_t pnv_phb5_pec_num_stacks[] = { 3, 3 };
 
-static void pnv_phb5_pec_class_init(ObjectClass *klass, void *data)
+static void pnv_phb5_pec_class_init(ObjectClass *klass, const void *data)
 {
     PnvPhb4PecClass *pecc = PNV_PHB4_PEC_CLASS(klass);
     static const char compat[] = "ibm,power10-pbcq";
diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index 07924bce28a..744b85e49cc 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -519,7 +519,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
+static void ppc440_pcix_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index 292cb308ba9..dcc4b78660c 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -349,7 +349,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(ppc4xx_pci_reset, s);
 }
 
-static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data)
+static void ppc4xx_host_bridge_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -376,7 +376,7 @@ static const TypeInfo ppc4xx_host_bridge_info = {
     },
 };
 
-static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
+static void ppc4xx_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 9b905d1971d..2f6354c931e 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -490,7 +490,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
 }
 
-static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
+static void e500_host_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -512,7 +512,7 @@ static const Property pcihost_properties[] = {
     DEFINE_PROP_UINT32("first_pin_irq", PPCE500PCIState, first_pin_irq, 0x1),
 };
 
-static void e500_pcihost_class_init(ObjectClass *klass, void *data)
+static void e500_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 06be3d77cb9..c2a71108f2e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -184,7 +184,7 @@ static const Property q35_host_props[] = {
     DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
 };
 
-static void q35_host_class_init(ObjectClass *klass, void *data)
+static void q35_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
@@ -667,7 +667,7 @@ static const Property mch_props[] = {
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
 };
 
-static void mch_class_init(ObjectClass *klass, void *data)
+static void mch_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index e3d8d206b73..3f158838a0a 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -392,7 +392,7 @@ static const VMStateDescription vmstate_raven = {
     },
 };
 
-static void raven_class_init(ObjectClass *klass, void *data)
+static void raven_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -431,7 +431,7 @@ static const Property raven_pcihost_properties[] = {
                      false),
 };
 
-static void raven_pcihost_class_init(ObjectClass *klass, void *data)
+static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index bfb25ef6af8..3b9c042065a 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -46,7 +46,7 @@ static void remote_pcihost_realize(DeviceState *dev, Error **errp)
                                 0, TYPE_PCIE_BUS);
 }
 
-static void remote_pcihost_class_init(ObjectClass *klass, void *data)
+static void remote_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index be6641de15e..f7086086f9a 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -456,7 +456,7 @@ static void sabre_pci_realize(PCIDevice *d, Error **errp)
                  PCI_STATUS_DEVSEL_MEDIUM);
 }
 
-static void sabre_pci_class_init(ObjectClass *klass, void *data)
+static void sabre_pci_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -497,7 +497,7 @@ static const Property sabre_properties[] = {
     DEFINE_PROP_UINT64("mem-base", SabreState, mem_base, 0),
 };
 
-static void sabre_class_init(ObjectClass *klass, void *data)
+static void sabre_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 4edebced5eb..52bff66d6a1 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -153,7 +153,7 @@ static void sh_pcic_pci_realize(PCIDevice *d, Error **errp)
                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
 }
 
-static void sh_pcic_pci_class_init(ObjectClass *klass, void *data)
+static void sh_pcic_pci_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -168,7 +168,7 @@ static void sh_pcic_pci_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static void sh_pcic_host_class_init(ObjectClass *klass, void *data)
+static void sh_pcic_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 37e2461bbbf..7cb37e01d8f 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -311,7 +311,7 @@ static void unin_internal_pci_host_realize(PCIDevice *d, Error **errp)
     d->config[PCI_CAPABILITY_LIST] = 0x00;
 }
 
-static void unin_main_pci_host_class_init(ObjectClass *klass, void *data)
+static void unin_main_pci_host_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -339,7 +339,7 @@ static const TypeInfo unin_main_pci_host_info = {
     },
 };
 
-static void u3_agp_pci_host_class_init(ObjectClass *klass, void *data)
+static void u3_agp_pci_host_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -367,7 +367,7 @@ static const TypeInfo u3_agp_pci_host_info = {
     },
 };
 
-static void unin_agp_pci_host_class_init(ObjectClass *klass, void *data)
+static void unin_agp_pci_host_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -395,7 +395,8 @@ static const TypeInfo unin_agp_pci_host_info = {
     },
 };
 
-static void unin_internal_pci_host_class_init(ObjectClass *klass, void *data)
+static void unin_internal_pci_host_class_init(ObjectClass *klass,
+                                              const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -427,7 +428,7 @@ static const Property pci_unin_main_pci_host_props[] = {
     DEFINE_PROP_UINT32("ofw-addr", UNINHostState, ofw_addr, -1),
 };
 
-static void pci_unin_main_class_init(ObjectClass *klass, void *data)
+static void pci_unin_main_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
@@ -447,7 +448,7 @@ static const TypeInfo pci_unin_main_info = {
     .class_init    = pci_unin_main_class_init,
 };
 
-static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
+static void pci_u3_agp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -463,7 +464,7 @@ static const TypeInfo pci_u3_agp_info = {
     .class_init    = pci_u3_agp_class_init,
 };
 
-static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
+static void pci_unin_agp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -479,7 +480,7 @@ static const TypeInfo pci_unin_agp_info = {
     .class_init    = pci_unin_agp_class_init,
 };
 
-static void pci_unin_internal_class_init(ObjectClass *klass, void *data)
+static void pci_unin_internal_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -535,7 +536,7 @@ static void unin_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mem);
 }
 
-static void unin_class_init(ObjectClass *klass, void *data)
+static void unin_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index c3fbf4cbf94..10bb89f528f 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -471,7 +471,7 @@ static void versatile_pci_host_realize(PCIDevice *d, Error **errp)
     pci_set_byte(d->config + PCI_LATENCY_TIMER, 0x10);
 }
 
-static void versatile_pci_host_class_init(ObjectClass *klass, void *data)
+static void versatile_pci_host_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -503,7 +503,7 @@ static const Property pci_vpb_properties[] = {
                       PCI_VPB_IRQMAP_ASSUME_OK),
 };
 
-static void pci_vpb_class_init(ObjectClass *klass, void *data)
+static void pci_vpb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
index d094b675d6d..5dd17ef236f 100644
--- a/hw/pci-host/xen_igd_pt.c
+++ b/hw/pci-host/xen_igd_pt.c
@@ -95,7 +95,8 @@ static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
+static void igd_passthrough_i440fx_class_init(ObjectClass *klass,
+                                              const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 18688485f48..70e9b2b9810 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -165,7 +165,7 @@ static const Property xilinx_pcie_host_props[] = {
     DEFINE_PROP_BOOL("link_up", XilinxPCIEHost, link_up, true),
 };
 
-static void xilinx_pcie_host_class_init(ObjectClass *klass, void *data)
+static void xilinx_pcie_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
@@ -286,7 +286,7 @@ static void xilinx_pcie_root_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
+static void xilinx_pcie_root_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 00f50e6f2cc..e9e0524f5c3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -261,7 +261,7 @@ static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
     return byte_array;
 }
 
-static void pci_bus_class_init(ObjectClass *klass, void *data)
+static void pci_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     PCIBusClass *pbc = PCI_BUS_CLASS(klass);
@@ -309,7 +309,7 @@ static const TypeInfo conventional_pci_interface_info = {
     .parent        = TYPE_INTERFACE,
 };
 
-static void pcie_bus_class_init(ObjectClass *klass, void *data)
+static void pcie_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
@@ -2698,7 +2698,7 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev)
     return pci_get_bus(dev)->address_space_io;
 }
 
-static void pci_device_class_init(ObjectClass *klass, void *data)
+static void pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index aee4dd7d1f6..0fe66e8b12d 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -482,7 +482,7 @@ static const Property pci_bridge_properties[] = {
                      pcie_writeable_slt_bug, false),
 };
 
-static void pci_bridge_class_init(ObjectClass *klass, void *data)
+static void pci_bridge_class_init(ObjectClass *klass, const void *data)
 {
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
     DeviceClass *k = DEVICE_CLASS(klass);
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 80f91f409f9..abe83bbab89 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -246,7 +246,7 @@ static const Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
 };
 
-static void pci_host_class_init(ObjectClass *klass, void *data)
+static void pci_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     device_class_set_props(dc, pci_host_properties_common);
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index c73db30e989..8629b3aafd6 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -118,7 +118,7 @@ static const Property pcie_port_props[] = {
                        PCIE_AER_LOG_MAX_DEFAULT),
 };
 
-static void pcie_port_class_init(ObjectClass *oc, void *data)
+static void pcie_port_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -211,7 +211,7 @@ static const Property pcie_slot_props[] = {
                      hide_native_hotplug_cap, false),
 };
 
-static void pcie_slot_class_init(ObjectClass *oc, void *data)
+static void pcie_slot_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 70a80333733..cd594eeb3ed 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -68,7 +68,7 @@ HotplugHandler *e500plat_machine_get_hotpug_handler(MachineState *machine,
 
 #define TYPE_E500PLAT_MACHINE  MACHINE_TYPE_NAME("ppce500")
 
-static void e500plat_machine_class_init(ObjectClass *oc, void *data)
+static void e500plat_machine_class_init(ObjectClass *oc, const void *data)
 {
     PPCE500MachineClass *pmc = PPCE500_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab482..dc4bd85544a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -567,7 +567,7 @@ static int core99_kvm_type(MachineState *machine, const char *arg)
     return 2;
 }
 
-static void core99_machine_class_init(ObjectClass *oc, void *data)
+static void core99_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0dbcea035c3..3906fb724e6 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -406,7 +406,7 @@ static int heathrow_kvm_type(MachineState *machine, const char *arg)
     return 2;
 }
 
-static void heathrow_class_init(ObjectClass *oc, void *data)
+static void heathrow_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index d74af766eed..97fb0f35ba9 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -37,7 +37,7 @@ static void mpc8544ds_init(MachineState *machine)
     ppce500_init(machine);
 }
 
-static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
+static void mpc8544ds_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PPCE500MachineClass *pmc = PPCE500_MACHINE_CLASS(oc);
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index 8b2d726e008..254f5707876 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -128,7 +128,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(PefGuest,
                                    { TYPE_USER_CREATABLE },
                                    { NULL })
 
-static void pef_guest_class_init(ObjectClass *oc, void *data)
+static void pef_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index b057672e829..dac1f11c225 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -589,7 +589,7 @@ static bool pegasos2_setprop(MachineState *ms, const char *path,
     return true;
 }
 
-static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
+static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71b..6d95e24dd2b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1602,7 +1602,7 @@ static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t addr)
     return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
 }
 
-static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
+static void pnv_chip_power8e_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
@@ -1626,7 +1626,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
+static void pnv_chip_power8_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
@@ -1650,7 +1650,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
+static void pnv_chip_power8nvl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
@@ -1933,7 +1933,7 @@ static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
     return addr >> 3;
 }
 
-static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_chip_power9_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
@@ -2274,7 +2274,7 @@ static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
     return addr >> 3;
 }
 
-static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_chip_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
@@ -2433,7 +2433,7 @@ static const Property pnv_chip_properties[] = {
     DEFINE_PROP_BOOL("lpar-per-core", PnvChip, lpar_per_core, false),
 };
 
-static void pnv_chip_class_init(ObjectClass *klass, void *data)
+static void pnv_chip_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -2678,7 +2678,7 @@ static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
     }
 }
 
-static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_power8_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     XICSFabricClass *xic = XICS_FABRIC_CLASS(oc);
@@ -2707,7 +2707,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
-static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_power9_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
@@ -2746,7 +2746,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
                               "Use 1 LPAR per core mode");
 }
 
-static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_p10_common_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
@@ -2775,7 +2775,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
-static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_power10_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -2800,7 +2800,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
                               "Use 1 LPAR per core mode");
 }
 
-static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
+                                               const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
@@ -2865,7 +2866,7 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
-static void pnv_machine_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     InterruptStatsProviderClass *ispc = INTERRUPT_STATS_PROVIDER_CLASS(oc);
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index d09a167466b..f9620806ec7 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -189,7 +189,7 @@ static const Property pnv_adu_properties[] = {
     DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
 };
 
-static void pnv_adu_class_init(ObjectClass *klass, void *data)
+static void pnv_adu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index c8987ae67a2..4ca511a4dee 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -456,7 +456,7 @@ static const Property pnv_chiptod_properties[] = {
     DEFINE_PROP_LINK("chip", PnvChipTOD , chip, TYPE_PNV_CHIP, PnvChip *),
 };
 
-static void pnv_chiptod_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_chiptod_power9_class_init(ObjectClass *klass, const void *data)
 {
     PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -492,7 +492,7 @@ static int pnv_chiptod_power10_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
 }
 
-static void pnv_chiptod_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_chiptod_power10_class_init(ObjectClass *klass, const void *data)
 {
     PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -555,7 +555,7 @@ static void pnv_chiptod_unrealize(DeviceState *dev)
     qemu_unregister_reset(pnv_chiptod_reset, chiptod);
 }
 
-static void pnv_chiptod_class_init(ObjectClass *klass, void *data)
+static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 99d9644ee38..700b1501bd3 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -445,7 +445,7 @@ static const Property pnv_core_properties[] = {
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
 };
 
-static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
+static void pnv_core_power8_class_init(ObjectClass *oc, const void *data)
 {
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
@@ -453,7 +453,7 @@ static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
     pcc->xscom_size = PNV_XSCOM_EX_SIZE;
 }
 
-static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
+static void pnv_core_power9_class_init(ObjectClass *oc, const void *data)
 {
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
@@ -461,7 +461,7 @@ static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
     pcc->xscom_size = PNV_XSCOM_EX_SIZE;
 }
 
-static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
+static void pnv_core_power10_class_init(ObjectClass *oc, const void *data)
 {
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
@@ -469,7 +469,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
     pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
 }
 
-static void pnv_core_class_init(ObjectClass *oc, void *data)
+static void pnv_core_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -696,7 +696,7 @@ static const Property pnv_quad_properties[] = {
     DEFINE_PROP_UINT32("quad-id", PnvQuad, quad_id, 0),
 };
 
-static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
+static void pnv_quad_power9_class_init(ObjectClass *oc, const void *data)
 {
     PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -707,7 +707,7 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
     pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
 }
 
-static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
+static void pnv_quad_power10_class_init(ObjectClass *oc, const void *data)
 {
     PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -721,7 +721,7 @@ static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
     pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;
 }
 
-static void pnv_quad_class_init(ObjectClass *oc, void *data)
+static void pnv_quad_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index a1d83c8149d..cadf9108eae 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -172,7 +172,7 @@ static const MemoryRegionOps pnv_homer_power8_pba_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_homer_power8_class_init(ObjectClass *klass, void *data)
+static void pnv_homer_power8_class_init(ObjectClass *klass, const void *data)
 {
     PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
 
@@ -315,7 +315,7 @@ static const MemoryRegionOps pnv_homer_power9_pba_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_homer_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_homer_power9_class_init(ObjectClass *klass, const void *data)
 {
     PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
 
@@ -378,7 +378,7 @@ static const MemoryRegionOps pnv_homer_power10_pba_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_homer_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_homer_power10_class_init(ObjectClass *klass, const void *data)
 {
     PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
 
@@ -416,7 +416,7 @@ static const Property pnv_homer_properties[] = {
     DEFINE_PROP_LINK("chip", PnvHomer, chip, TYPE_PNV_CHIP, PnvChip *),
 };
 
-static void pnv_homer_class_init(ObjectClass *klass, void *data)
+static void pnv_homer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 8d35f452a2a..b2f372c8743 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -549,7 +549,7 @@ static const Property pnv_i2c_properties[] = {
     DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
 };
 
-static void pnv_i2c_class_init(ObjectClass *klass, void *data)
+static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 0480a60f3f7..84079443738 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -703,7 +703,7 @@ static void pnv_lpc_power8_realize(DeviceState *dev, Error **errp)
                           PNV_XSCOM_LPC_SIZE);
 }
 
-static void pnv_lpc_power8_class_init(ObjectClass *klass, void *data)
+static void pnv_lpc_power8_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
@@ -749,7 +749,7 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out_named(dev, lpc->psi_irq_serirq, "SERIRQ", 4);
 }
 
-static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_lpc_power9_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvLpcClass *plc = PNV_LPC_CLASS(klass);
@@ -766,7 +766,7 @@ static const TypeInfo pnv_lpc_power9_info = {
     .class_init    = pnv_lpc_power9_class_init,
 };
 
-static void pnv_lpc_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_lpc_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -832,7 +832,7 @@ static const Property pnv_lpc_properties[] = {
     DEFINE_PROP_BOOL("psi-serirq", PnvLpcController, psi_has_serirq, false),
 };
 
-static void pnv_lpc_class_init(ObjectClass *klass, void *data)
+static void pnv_lpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_n1_chiplet.c b/hw/ppc/pnv_n1_chiplet.c
index 03ff9fbad0d..05e3fd6f731 100644
--- a/hw/ppc/pnv_n1_chiplet.c
+++ b/hw/ppc/pnv_n1_chiplet.c
@@ -136,7 +136,7 @@ static void pnv_n1_chiplet_realize(DeviceState *dev, Error **errp)
                           PNV10_XSCOM_N1_PB_SCOM_ES_SIZE);
 }
 
-static void pnv_n1_chiplet_class_init(ObjectClass *klass, void *data)
+static void pnv_n1_chiplet_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
index 780fa69dde7..b5182d54fa1 100644
--- a/hw/ppc/pnv_nest_pervasive.c
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -181,7 +181,7 @@ static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
                           PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
 }
 
-static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data)
+static void pnv_nest_pervasive_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 48123ceae17..8bd2db56843 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -162,7 +162,7 @@ const MemoryRegionOps pnv_occ_sram_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
+static void pnv_occ_power8_class_init(ObjectClass *klass, const void *data)
 {
     PnvOCCClass *poc = PNV_OCC_CLASS(klass);
 
@@ -232,7 +232,7 @@ static const MemoryRegionOps pnv_occ_power9_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_occ_power9_class_init(ObjectClass *klass, const void *data)
 {
     PnvOCCClass *poc = PNV_OCC_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -249,7 +249,7 @@ static const TypeInfo pnv_occ_power9_type_info = {
     .class_init    = pnv_occ_power9_class_init,
 };
 
-static void pnv_occ_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_occ_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -281,7 +281,7 @@ static void pnv_occ_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, &occ->psi_irq, 1);
 }
 
-static void pnv_occ_class_init(ObjectClass *klass, void *data)
+static void pnv_occ_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index 863e2e70aca..165424c8feb 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -117,7 +117,7 @@ static const Property pnv_pnor_properties[] = {
     DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
 };
 
-static void pnv_pnor_class_init(ObjectClass *klass, void *data)
+static void pnv_pnor_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 1fe11dde501..5eed22252df 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -557,7 +557,7 @@ static const Property pnv_psi_properties[] = {
     DEFINE_PROP_UINT64("fsp-bar", PnvPsi, fsp_bar, 0),
 };
 
-static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
+static void pnv_psi_power8_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
@@ -887,7 +887,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     pnv_psi_realize(dev, errp);
 }
 
-static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_psi_power9_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
@@ -919,7 +919,7 @@ static const TypeInfo pnv_psi_power9_info = {
     },
 };
 
-static void pnv_psi_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
@@ -939,7 +939,7 @@ static const TypeInfo pnv_psi_power10_info = {
     .class_init    = pnv_psi_power10_class_init,
 };
 
-static void pnv_psi_class_init(ObjectClass *klass, void *data)
+static void pnv_psi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 74cee4eea7a..34dc013d47b 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -331,7 +331,7 @@ static const MemoryRegionOps pnv_sbe_power9_xscom_mbox_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_sbe_power9_class_init(ObjectClass *klass, void *data)
+static void pnv_sbe_power9_class_init(ObjectClass *klass, const void *data)
 {
     PnvSBEClass *psc = PNV_SBE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -350,7 +350,7 @@ static const TypeInfo pnv_sbe_power9_type_info = {
     .class_init    = pnv_sbe_power9_class_init,
 };
 
-static void pnv_sbe_power10_class_init(ObjectClass *klass, void *data)
+static void pnv_sbe_power10_class_init(ObjectClass *klass, const void *data)
 {
     PnvSBEClass *psc = PNV_SBE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -386,7 +386,7 @@ static void pnv_sbe_realize(DeviceState *dev, Error **errp)
     sbe->timer = timer_new_us(QEMU_CLOCK_VIRTUAL, sbe_timer, sbe);
 }
 
-static void pnv_sbe_class_init(ObjectClass *klass, void *data)
+static void pnv_sbe_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 969cac345ac..53e18906c99 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -342,7 +342,7 @@ static void ppc405_init(MachineState *machine)
     }
 }
 
-static void ppc405_machine_class_init(ObjectClass *oc, void *data)
+static void ppc405_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -452,7 +452,7 @@ static void ref405ep_fpga_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-static void ref405ep_fpga_class_init(ObjectClass *oc, void *data)
+static void ref405ep_fpga_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -496,7 +496,7 @@ static void ref405ep_init(MachineState *machine)
     sysbus_mmio_map(s, 0, PPC405EP_NVRAM_BASE);
 }
 
-static void ref405ep_class_init(ObjectClass *oc, void *data)
+static void ref405ep_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 8250824a1a2..73af4c54246 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -114,7 +114,7 @@ static void ppc405_pob_realize(DeviceState *dev, Error **errp)
     ppc4xx_dcr_register(dcr, POB0_BESR1, pob, &dcr_read_pob, &dcr_write_pob);
 }
 
-static void ppc405_pob_class_init(ObjectClass *oc, void *data)
+static void ppc405_pob_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -191,7 +191,7 @@ static void ppc405_opba_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io);
 }
 
-static void ppc405_opba_class_init(ObjectClass *oc, void *data)
+static void ppc405_opba_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -297,7 +297,7 @@ static void ppc405_dma_realize(DeviceState *dev, Error **errp)
     ppc4xx_dcr_register(dcr, DMA0_POL, dma, &dcr_read_dma, &dcr_write_dma);
 }
 
-static void ppc405_dma_class_init(ObjectClass *oc, void *data)
+static void ppc405_dma_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -336,7 +336,7 @@ static void ppc405_gpio_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io);
 }
 
-static void ppc405_gpio_class_init(ObjectClass *oc, void *data)
+static void ppc405_gpio_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -487,7 +487,7 @@ static void ppc405_ocm_realize(DeviceState *dev, Error **errp)
     ppc4xx_dcr_register(dcr, OCM0_DSACNTL, ocm, &dcr_read_ocm, &dcr_write_ocm);
 }
 
-static void ppc405_ocm_class_init(ObjectClass *oc, void *data)
+static void ppc405_ocm_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -721,7 +721,7 @@ static void ppc405_gpt_finalize(Object *obj)
     }
 }
 
-static void ppc405_gpt_class_init(ObjectClass *oc, void *data)
+static void ppc405_gpt_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -969,7 +969,7 @@ static const Property ppc405_cpc_properties[] = {
     DEFINE_PROP_UINT32("sys-clk", Ppc405CpcState, sysclk, 0),
 };
 
-static void ppc405_cpc_class_init(ObjectClass *oc, void *data)
+static void ppc405_cpc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -1158,7 +1158,7 @@ static void ppc405_soc_realize(DeviceState *dev, Error **errp)
     /* Uses UIC IRQs 9, 15, 17 */
 }
 
-static void ppc405_soc_class_init(ObjectClass *oc, void *data)
+static void ppc405_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 9da30a1724c..89e3fae08d7 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1027,7 +1027,7 @@ static const Property ppc460ex_pcie_props[] = {
                      PowerPCCPU *),
 };
 
-static void ppc460ex_pcie_class_init(ObjectClass *klass, void *data)
+static void ppc460ex_pcie_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 9ce97775109..f36c519c8bf 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -236,7 +236,7 @@ static const Property ppc4xx_mal_properties[] = {
     DEFINE_PROP_UINT8("rxc-num", Ppc4xxMalState, rxcnum, 0),
 };
 
-static void ppc4xx_mal_class_init(ObjectClass *oc, void *data)
+static void ppc4xx_mal_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -326,7 +326,7 @@ static void ppc405_plb_realize(DeviceState *dev, Error **errp)
     ppc4xx_dcr_register(dcr, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_plb);
 }
 
-static void ppc405_plb_class_init(ObjectClass *oc, void *data)
+static void ppc405_plb_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -512,7 +512,7 @@ static void ppc405_ebc_realize(DeviceState *dev, Error **errp)
     ppc4xx_dcr_register(dcr, EBC0_CFGDATA, ebc, &dcr_read_ebc, &dcr_write_ebc);
 }
 
-static void ppc405_ebc_class_init(ObjectClass *oc, void *data)
+static void ppc405_ebc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -543,7 +543,7 @@ static const Property ppc4xx_dcr_properties[] = {
                      PowerPCCPU *),
 };
 
-static void ppc4xx_dcr_class_init(ObjectClass *oc, void *data)
+static void ppc4xx_dcr_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index 562bff8d53e..21c8b951f76 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -431,7 +431,7 @@ static const Property ppc4xx_sdram_ddr_props[] = {
     DEFINE_PROP_UINT32("nbanks", Ppc4xxSdramDdrState, nbanks, 4),
 };
 
-static void ppc4xx_sdram_ddr_class_init(ObjectClass *oc, void *data)
+static void ppc4xx_sdram_ddr_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -715,7 +715,7 @@ static const Property ppc4xx_sdram_ddr2_props[] = {
     DEFINE_PROP_UINT32("nbanks", Ppc4xxSdramDdr2State, nbanks, 4),
 };
 
-static void ppc4xx_sdram_ddr2_class_init(ObjectClass *oc, void *data)
+static void ppc4xx_sdram_ddr2_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index baab74c4ed0..2310f62a91e 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -175,7 +175,7 @@ static void ppce500_spin_initfn(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static void ppce500_spin_class_init(ObjectClass *klass, void *data)
+static void ppce500_spin_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index b1f2e130f03..1d366a0f21f 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -290,7 +290,7 @@ static const Property prep_systemio_properties[] = {
     DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
 };
 
-static void prep_systemio_class_initfn(ObjectClass *klass, void *data)
+static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 0e5d53b8b69..9a2ace55942 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -212,7 +212,7 @@ static const Property rs6000mc_properties[] = {
     DEFINE_PROP_BOOL("auto-configure", RS6000MCState, autoconfigure, true),
 };
 
-static void rs6000mc_class_initfn(ObjectClass *klass, void *data)
+static void rs6000mc_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f3a4b4235d4..bb31dc96a80 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4562,7 +4562,7 @@ static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
     }
 }
 
-static void spapr_machine_class_init(ObjectClass *oc, void *data)
+static void spapr_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(oc);
@@ -4705,7 +4705,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE_IMPL(latest, ...)                       \
     static void MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__)(     \
         ObjectClass *oc,                                             \
-        void *data)                                                  \
+        const void *data)                                            \
     {                                                                \
         MachineClass *mc = MACHINE_CLASS(oc);                        \
         MACHINE_VER_SYM(class_options, spapr, __VA_ARGS__)(mc);      \
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9e0e0648a72..c1964d3dc8a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -365,7 +365,7 @@ static const Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", SpaprCpuCore, node_id, CPU_UNSET_NUMA_NODE_ID),
 };
 
-static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
+static void spapr_cpu_core_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     SpaprCpuCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 549b652c206..d2044b4fb52 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -589,7 +589,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
     drc->state = drck->empty_state;
 }
 
-static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
+static void spapr_dr_connector_class_init(ObjectClass *k, const void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
 
@@ -665,7 +665,7 @@ static void unrealize_physical(DeviceState *d)
     qemu_unregister_reset(drc_physical_reset, drcp);
 }
 
-static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
+static void spapr_drc_physical_class_init(ObjectClass *k, const void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
@@ -679,7 +679,7 @@ static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
     drck->empty_state = SPAPR_DRC_STATE_PHYSICAL_POWERON;
 }
 
-static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
+static void spapr_drc_logical_class_init(ObjectClass *k, const void *data)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
@@ -690,7 +690,7 @@ static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
     drck->empty_state = SPAPR_DRC_STATE_LOGICAL_UNUSABLE;
 }
 
-static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
+static void spapr_drc_cpu_class_init(ObjectClass *k, const void *data)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
@@ -701,7 +701,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_core_dt_populate;
 }
 
-static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
+static void spapr_drc_pci_class_init(ObjectClass *k, const void *data)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
@@ -712,7 +712,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_pci_dt_populate;
 }
 
-static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
+static void spapr_drc_lmb_class_init(ObjectClass *k, const void *data)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
@@ -723,7 +723,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_lmb_dt_populate;
 }
 
-static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
+static void spapr_drc_phb_class_init(ObjectClass *k, const void *data)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
@@ -734,7 +734,7 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_phb_dt_populate;
 }
 
-static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
+static void spapr_drc_pmem_class_init(ObjectClass *k, const void *data)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index db3a14c1dfd..c2432a0c00c 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -668,7 +668,7 @@ int spapr_tcet_dma_dt(void *fdt, int node_off, const char *propname,
                         tcet->liobn, 0, tcet->nb_table << tcet->page_shift);
 }
 
-static void spapr_tce_table_class_init(ObjectClass *klass, void *data)
+static void spapr_tce_table_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = spapr_tce_table_realize;
@@ -693,7 +693,8 @@ static const TypeInfo spapr_tce_table_info = {
     .class_init = spapr_tce_table_class_init,
 };
 
-static void spapr_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+static void spapr_iommu_memory_region_class_init(ObjectClass *klass,
+                                                 const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 6f875d73b25..4be0ed00b16 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -890,7 +890,7 @@ static const Property spapr_nvdimm_properties[] = {
 };
 #endif
 
-static void spapr_nvdimm_class_init(ObjectClass *oc, void *data)
+static void spapr_nvdimm_class_init(ObjectClass *oc, const void *data)
 {
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 904227d9aa1..a2f7e731623 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2159,7 +2159,7 @@ static const char *spapr_phb_root_bus_path(PCIHostState *host_bridge,
     return sphb->dtbusname;
 }
 
-static void spapr_phb_class_init(ObjectClass *klass, void *data)
+static void spapr_phb_class_init(ObjectClass *klass, const void *data)
 {
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 95def5b1e52..6fec6070370 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -136,7 +136,7 @@ static const Property spapr_rng_properties[] = {
                      RngBackend *),
 };
 
-static void spapr_rng_class_init(ObjectClass *oc, void *data)
+static void spapr_rng_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 46fbc789001..1f7d2d8f898 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -163,7 +163,7 @@ static const VMStateDescription vmstate_spapr_rtc = {
     },
 };
 
-static void spapr_rtc_class_init(ObjectClass *oc, void *data)
+static void spapr_rtc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index ceaa0acaa18..862eeaa50a3 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -149,7 +149,7 @@ static const Property spapr_tpm_proxy_properties[] = {
     DEFINE_PROP_STRING("host-path", SpaprTpmProxy, host_path),
 };
 
-static void spapr_tpm_proxy_class_init(ObjectClass *k, void *data)
+static void spapr_tpm_proxy_class_init(ObjectClass *k, const void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
 
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 09243c183bb..7759436a4f5 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -50,7 +50,7 @@ static char *spapr_vio_get_dev_name(DeviceState *qdev)
     return g_strdup_printf("%s@%x", pc->dt_name, dev->reg);
 }
 
-static void spapr_vio_bus_class_init(ObjectClass *klass, void *data)
+static void spapr_vio_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
@@ -599,7 +599,7 @@ SpaprVioBus *spapr_vio_bus_init(void)
     return bus;
 }
 
-static void spapr_vio_bridge_class_init(ObjectClass *klass, void *data)
+static void spapr_vio_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -631,7 +631,7 @@ const VMStateDescription vmstate_spapr_vio = {
     },
 };
 
-static void vio_spapr_device_class_init(ObjectClass *klass, void *data)
+static void vio_spapr_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = spapr_vio_busdev_realize;
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fdc6c441bbd..dadc5ce3307 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -121,7 +121,7 @@ static void remote_machine_dev_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void remote_machine_class_init(ObjectClass *oc, void *data)
+static void remote_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 96d831a579d..d2de48c9e37 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -195,7 +195,7 @@ static const Property proxy_properties[] = {
     DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
 };
 
-static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+static void pci_proxy_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 2f25f92dcd0..75f8d6df8a1 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -163,7 +163,7 @@ static void remote_object_finalize(Object *obj)
     g_free(o->devid);
 }
 
-static void remote_object_class_init(ObjectClass *klass, void *data)
+static void remote_object_class_init(ObjectClass *klass, const void *data)
 {
     RemoteObjectClass *k = REMOTE_OBJECT_CLASS(klass);
 
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 9e5ff6d87a9..23f339936a2 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -917,7 +917,7 @@ static void vfu_object_finalize(Object *obj)
     }
 }
 
-static void vfu_object_class_init(ObjectClass *klass, void *data)
+static void vfu_object_class_init(ObjectClass *klass, const void *data)
 {
     VfuObjectClass *k = VFU_OBJECT_CLASS(klass);
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ec7e2e42264..a667eb83a42 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -479,7 +479,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 qspi_xip_mem);
 }
 
-static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
+static void microchip_pfsoc_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -639,7 +639,8 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     }
 }
 
-static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
+static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
+                                                    const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index b9e56235d87..a421faa5c17 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -111,7 +111,7 @@ static void opentitan_machine_init(MachineState *machine)
     }
 }
 
-static void opentitan_machine_class_init(ObjectClass *oc, void *data)
+static void opentitan_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -312,7 +312,7 @@ static const Property lowrisc_ibex_soc_props[] = {
     DEFINE_PROP_UINT32("resetvec", LowRISCIbexSoCState, resetvec, 0x20000400),
 };
 
-static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
+static void lowrisc_ibex_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 12451869e41..4e0e3cc5be5 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -183,7 +183,7 @@ static void riscv_iommu_pci_reset_hold(Object *obj, ResetType type)
     trace_riscv_iommu_pci_reset_hold(type);
 }
 
-static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
+static void riscv_iommu_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 65b24fb07de..be2e3944dc7 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -227,7 +227,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
     trace_riscv_iommu_sys_reset_hold(type);
 }
 
-static void riscv_iommu_sys_class_init(ObjectClass *klass, void *data)
+static void riscv_iommu_sys_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e7568ca227a..96d6a4d42e2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2413,7 +2413,7 @@ static const Property riscv_iommu_properties[] = {
         TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void riscv_iommu_class_init(ObjectClass *klass, void* data)
+static void riscv_iommu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -2554,7 +2554,7 @@ static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
     return 1 << as->iommu->pid_bits;
 }
 
-static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
+static void riscv_iommu_memory_region_init(ObjectClass *klass, const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index a55d1566687..ac6539bd3eb 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -160,7 +160,7 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void riscv_harts_class_init(ObjectClass *klass, void *data)
+static void riscv_harts_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index e2242b97d0c..280e68f2fa3 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -71,7 +71,7 @@ static void shakti_c_machine_instance_init(Object *obj)
 {
 }
 
-static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
+static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(klass);
     static const char * const valid_cpu_types[] = {
@@ -142,7 +142,7 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
         shakti_c_memmap[SHAKTI_C_ROM].base, &sss->rom);
 }
 
-static void shakti_c_soc_class_init(ObjectClass *klass, void *data)
+static void shakti_c_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = shakti_c_soc_state_realize;
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 73d3b74281c..7baed1958e0 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -143,7 +143,7 @@ static void sifive_e_machine_instance_init(Object *obj)
     s->revb = false;
 }
 
-static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
+static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -284,7 +284,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         &s->xip_mem);
 }
 
-static void sifive_e_soc_class_init(ObjectClass *oc, void *data)
+static void sifive_e_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9a20bcbf7fb..a68f781a323 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -713,7 +713,7 @@ static void sifive_u_machine_instance_init(Object *obj)
     object_property_set_description(obj, "serial", "Board serial number");
 }
 
-static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
+static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -945,7 +945,7 @@ static const Property sifive_u_soc_props[] = {
     DEFINE_PROP_STRING("cpu-type", SiFiveUSoCState, cpu_type),
 };
 
-static void sifive_u_soc_class_init(ObjectClass *oc, void *data)
+static void sifive_u_soc_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 74a20016f14..641aae8c019 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -342,7 +342,7 @@ static void spike_machine_instance_init(Object *obj)
 {
 }
 
-static void spike_machine_class_init(ObjectClass *oc, void *data)
+static void spike_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 241389d72f8..1744ed8c73c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1907,7 +1907,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_machine_class_init(ObjectClass *oc, void *data)
+static void virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index a19e4310bb1..23d0f9fe988 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -315,7 +315,7 @@ static const Property allwinner_rtc_properties[] = {
     DEFINE_PROP_INT32("base-year", AwRtcState, base_year, 0),
 };
 
-static void allwinner_rtc_class_init(ObjectClass *klass, void *data)
+static void allwinner_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -330,7 +330,7 @@ static void allwinner_rtc_sun4i_init(Object *obj)
     s->base_year = 2010;
 }
 
-static void allwinner_rtc_sun4i_class_init(ObjectClass *klass, void *data)
+static void allwinner_rtc_sun4i_class_init(ObjectClass *klass, const void *data)
 {
     AwRtcClass *arc = AW_RTC_CLASS(klass);
 
@@ -346,7 +346,7 @@ static void allwinner_rtc_sun6i_init(Object *obj)
     s->base_year = 1970;
 }
 
-static void allwinner_rtc_sun6i_class_init(ObjectClass *klass, void *data)
+static void allwinner_rtc_sun6i_class_init(ObjectClass *klass, const void *data)
 {
     AwRtcClass *arc = AW_RTC_CLASS(klass);
 
@@ -362,7 +362,7 @@ static void allwinner_rtc_sun7i_init(Object *obj)
     s->base_year = 1970;
 }
 
-static void allwinner_rtc_sun7i_class_init(ObjectClass *klass, void *data)
+static void allwinner_rtc_sun7i_class_init(ObjectClass *klass, const void *data)
 {
     AwRtcClass *arc = AW_RTC_CLASS(klass);
     allwinner_rtc_sun4i_class_init(klass, arc);
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index fbdeb0781f3..c4feea23a0b 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -156,7 +156,7 @@ static void aspeed_rtc_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
+static void aspeed_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 8dd17fdc07c..5f1ee2e410a 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -220,7 +220,7 @@ static void ds1338_reset(DeviceState *dev)
     s->addr_byte = false;
 }
 
-static void ds1338_class_init(ObjectClass *klass, void *data)
+static void ds1338_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index aa1b3cd1151..624b4f61a85 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -592,7 +592,7 @@ static void exynos4210_rtc_finalize(Object *obj)
     ptimer_free(s->ptimer_1Hz);
 }
 
-static void exynos4210_rtc_class_init(ObjectClass *klass, void *data)
+static void exynos4210_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index fa1d9051f4a..9509b323a9a 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -291,7 +291,7 @@ static const Property goldfish_rtc_properties[] = {
                       false),
 };
 
-static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
+static void goldfish_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index fce23a3dbe8..10097b2db75 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -464,7 +464,7 @@ static const VMStateDescription vmstate_ls7a_rtc = {
     }
 };
 
-static void ls7a_rtc_class_init(ObjectClass *klass, void *data)
+static void ls7a_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->vmsd = &vmstate_ls7a_rtc;
diff --git a/hw/rtc/m41t80.c b/hw/rtc/m41t80.c
index 96006956798..c631ec3ea1d 100644
--- a/hw/rtc/m41t80.c
+++ b/hw/rtc/m41t80.c
@@ -94,7 +94,7 @@ static int m41t80_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static void m41t80_class_init(ObjectClass *klass, void *data)
+static void m41t80_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 9c3855a3ef1..4a7c0af9f04 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -113,7 +113,7 @@ static void m48t59_isa_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void m48txx_isa_class_init(ObjectClass *klass, void *data)
+static void m48txx_isa_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     NvramClass *nc = NVRAM_CLASS(klass);
@@ -126,7 +126,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
     nc->toggle_lock = m48txx_isa_toggle_lock;
 }
 
-static void m48txx_isa_concrete_class_init(ObjectClass *klass, void *data)
+static void m48txx_isa_concrete_class_init(ObjectClass *klass, const void *data)
 {
     M48txxISADeviceClass *u = M48TXX_ISA_CLASS(klass);
     const M48txxInfo *info = data;
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 3fb2f27d9d1..821472a680e 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -622,7 +622,7 @@ static const Property m48t59_sysbus_properties[] = {
     DEFINE_PROP_INT32("base-year", M48txxSysBusState, state.base_year, 0),
 };
 
-static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
+static void m48txx_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     NvramClass *nc = NVRAM_CLASS(klass);
@@ -636,7 +636,8 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
     nc->toggle_lock = m48txx_sysbus_toggle_lock;
 }
 
-static void m48txx_sysbus_concrete_class_init(ObjectClass *klass, void *data)
+static void m48txx_sysbus_concrete_class_init(ObjectClass *klass,
+                                              const void *data)
 {
     M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_CLASS(klass);
     const M48txxInfo *info = data;
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index e322fc2ffb9..93b632bdf4a 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -1018,7 +1018,7 @@ static void rtc_build_aml(AcpiDevAmlIf *adev, Aml *scope)
     aml_append(scope, dev);
 }
 
-static void rtc_class_initfn(ObjectClass *klass, void *data)
+static void rtc_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index ed439bd3ada..e545b9dfd64 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -332,7 +332,7 @@ static const Property pl031_properties[] = {
                      PL031State, migrate_tick_offset, true),
 };
 
-static void pl031_class_init(ObjectClass *klass, void *data)
+static void pl031_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index ffcc0aa25d9..29e24ef6bed 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -75,7 +75,7 @@ static void sun4v_rtc_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void sun4v_rtc_class_init(ObjectClass *klass, void *data)
+static void sun4v_rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index b596b608c5b..500982a8011 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -251,7 +251,7 @@ static const VMStateDescription vmstate_rtc = {
     }
 };
 
-static void rtc_class_init(ObjectClass *klass, void *data)
+static void rtc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 88c8f12c101..d9bfcd6ac3b 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -158,7 +158,7 @@ static void rx_gdbsim_init(MachineState *machine)
     }
 }
 
-static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
+static void rx_gdbsim_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -168,7 +168,7 @@ static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "ext-sdram";
 }
 
-static void rx62n7_class_init(ObjectClass *oc, void *data)
+static void rx62n7_class_init(ObjectClass *oc, const void *data)
 {
     RxGdbSimMachineClass *rxc = RX_GDBSIM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -178,7 +178,7 @@ static void rx62n7_class_init(ObjectClass *oc, void *data)
     mc->desc = "gdb simulator (R5F562N7 MCU and external RAM)";
 };
 
-static void rx62n8_class_init(ObjectClass *oc, void *data)
+static void rx62n8_class_init(ObjectClass *oc, const void *data)
 {
     RxGdbSimMachineClass *rxc = RX_GDBSIM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index e6bac4f053e..a2a243afa41 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -264,7 +264,7 @@ static const Property rx62n_properties[] = {
     DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
 };
 
-static void rx62n_class_init(ObjectClass *klass, void *data)
+static void rx62n_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -272,7 +272,7 @@ static void rx62n_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, rx62n_properties);
 }
 
-static void r5f562n7_class_init(ObjectClass *oc, void *data)
+static void r5f562n7_class_init(ObjectClass *oc, const void *data)
 {
     RX62NClass *rxc = RX62N_MCU_CLASS(oc);
 
@@ -281,7 +281,7 @@ static void r5f562n7_class_init(ObjectClass *oc, void *data)
     rxc->data_flash_size = 32 * KiB;
 };
 
-static void r5f562n8_class_init(ObjectClass *oc, void *data)
+static void r5f562n8_class_init(ObjectClass *oc, const void *data)
 {
     RX62NClass *rxc = RX62N_MCU_CLASS(oc);
 
diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 3a8930dfd15..3f0d384fd80 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -150,7 +150,7 @@ out_err:
     g_free(sch);
 }
 
-static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
+static void emulated_ccw_3270_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index ef8fa2b15be..4aa7d5a90db 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -22,7 +22,7 @@ static char *ap_bus_get_dev_path(DeviceState *dev)
     return g_strdup_printf("/1");
 }
 
-static void ap_bus_class_init(ObjectClass *oc, void *data)
+static void ap_bus_class_init(ObjectClass *oc, const void *data)
 {
     BusClass *k = BUS_CLASS(oc);
 
@@ -61,7 +61,7 @@ void s390_init_ap(void)
     qbus_set_hotplug_handler(bus, OBJECT(dev));
  }
 
-static void ap_bridge_class_init(ObjectClass *oc, void *data)
+static void ap_bridge_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
index 237d1f19c50..733104403e5 100644
--- a/hw/s390x/ap-device.c
+++ b/hw/s390x/ap-device.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "hw/s390x/ap-device.h"
 
-static void ap_class_init(ObjectClass *klass, void *data)
+static void ap_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 494faebb5a8..1fcbbe65060 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -94,7 +94,7 @@ static void ccw_device_reset_hold(Object *obj, ResetType type)
     css_reset_sch(ccw_dev->sch);
 }
 
-static void ccw_device_class_init(ObjectClass *klass, void *data)
+static void ccw_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c48d5571b55..9d91e5a5fec 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -70,7 +70,7 @@ static char *virtual_css_bus_get_dev_path(DeviceState *dev)
     return g_strdup_printf("/%02x.%1x.%04x", sch->cssid, sch->ssid, sch->devno);
 }
 
-static void virtual_css_bus_class_init(ObjectClass *klass, void *data)
+static void virtual_css_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -117,7 +117,7 @@ static bool prop_get_true(Object *obj, Error **errp)
     return true;
 }
 
-static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
+static void virtual_css_bridge_class_init(ObjectClass *klass, const void *data)
 {
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 2b0332c20e2..1afe3645730 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -460,7 +460,7 @@ static void reset_event_facility(DeviceState *dev)
     sdev->receive_mask = 0;
 }
 
-static void init_event_facility_class(ObjectClass *klass, void *data)
+static void init_event_facility_class(ObjectClass *klass, const void *data)
 {
     SysBusDeviceClass *sbdc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(sbdc);
@@ -497,7 +497,7 @@ static void event_realize(DeviceState *qdev, Error **errp)
     }
 }
 
-static void event_class_init(ObjectClass *klass, void *data)
+static void event_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ce6f6078d74..716a6b78694 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -736,7 +736,7 @@ static void s390_ipl_reset(DeviceState *dev)
     }
 }
 
-static void s390_ipl_class_init(ObjectClass *klass, void *data)
+static void s390_ipl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 909475f0481..10c81a4c893 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -175,7 +175,7 @@ static void s390_ccw_instance_init(Object *obj)
                                   "/disk@0,0", DEVICE(obj));
 }
 
-static void s390_ccw_class_init(ObjectClass *klass, void *data)
+static void s390_ccw_class_init(ObjectClass *klass, const void *data)
 {
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eead269cc28..3edc3493a46 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1318,7 +1318,7 @@ static void s390_pcihost_reset(DeviceState *dev)
     pci_for_each_device_under_bus(bus, s390_pci_enumerate_bridge, s);
 }
 
-static void s390_pcihost_class_init(ObjectClass *klass, void *data)
+static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
@@ -1499,7 +1499,7 @@ static const VMStateDescription s390_pci_device_vmstate = {
     .unmigratable = 1,
 };
 
-static void s390_pci_device_class_init(ObjectClass *klass, void *data)
+static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1525,7 +1525,8 @@ static const TypeInfo s390_pci_iommu_info = {
     .instance_size = sizeof(S390PCIIOMMU),
 };
 
-static void s390_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+static void s390_iommu_memory_region_class_init(ObjectClass *klass,
+                                                const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
index 0215e94388e..f3056d6d25c 100644
--- a/hw/s390x/s390-skeys-kvm.c
+++ b/hw/s390x/s390-skeys-kvm.c
@@ -52,7 +52,7 @@ static int kvm_s390_skeys_set(S390SKeysState *ss, uint64_t start_gfn,
     return kvm_vm_ioctl(kvm_state, KVM_S390_SET_SKEYS, &args);
 }
 
-static void kvm_s390_skeys_class_init(ObjectClass *oc, void *data)
+static void kvm_s390_skeys_class_init(ObjectClass *oc, const void *data)
 {
     S390SKeysClass *skeyclass = S390_SKEYS_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 811d892122b..3775cae5e25 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -302,7 +302,7 @@ static int qemu_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
     return 0;
 }
 
-static void qemu_s390_skeys_class_init(ObjectClass *oc, void *data)
+static void qemu_s390_skeys_class_init(ObjectClass *oc, const void *data)
 {
     S390SKeysClass *skeyclass = S390_SKEYS_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -472,7 +472,7 @@ static void s390_skeys_realize(DeviceState *dev, Error **errp)
     register_savevm_live(TYPE_S390_SKEYS, 0, 1, &savevm_s390_storage_keys, ss);
 }
 
-static void s390_skeys_class_init(ObjectClass *oc, void *data)
+static void s390_skeys_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 2a8e31718bf..c2c7b843b2b 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -188,7 +188,7 @@ static int kvm_s390_stattrib_get_active(S390StAttribState *sa)
     return kvm_s390_cmma_active() && sa->migration_enabled;
 }
 
-static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
+static void kvm_s390_stattrib_class_init(ObjectClass *oc, const void *data)
 {
     S390StAttribClass *sac = S390_STATTRIB_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index be07c28c6e5..b7da68f3546 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -307,7 +307,7 @@ static int qemu_s390_get_active(S390StAttribState *sa)
     return sa->migration_enabled;
 }
 
-static void qemu_s390_stattrib_class_init(ObjectClass *oc, void *data)
+static void qemu_s390_stattrib_class_init(ObjectClass *oc, const void *data)
 {
     S390StAttribClass *sa_cl = S390_STATTRIB_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -364,7 +364,7 @@ static const Property s390_stattrib_props[] = {
     DEFINE_PROP_BOOL("migration-enabled", S390StAttribState, migration_enabled, true),
 };
 
-static void s390_stattrib_class_init(ObjectClass *oc, void *data)
+static void s390_stattrib_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d9e683c5b49..74848d34710 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -803,7 +803,7 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
 }
 
-static void ccw_machine_class_init(ObjectClass *oc, void *data)
+static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
@@ -889,7 +889,7 @@ static const TypeInfo ccw_machine_info = {
     }                                                                         \
     static void MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__)(                \
         ObjectClass *oc,                                                      \
-        void *data)                                                           \
+        const void *data)                                                     \
     {                                                                         \
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 5945c9b1d82..9718564fa42 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -424,7 +424,7 @@ static void sclp_init(Object *obj)
     sclp_memory_init(sclp);
 }
 
-static void sclp_class_init(ObjectClass *oc, void *data)
+static void sclp_class_init(ObjectClass *oc, const void *data)
 {
     SCLPDeviceClass *sc = SCLP_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index a178a9dd4c8..4b6ebfed469 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -73,7 +73,7 @@ static int read_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr,
     return 1;
 }
 
-static void sclp_cpu_class_init(ObjectClass *oc, void *data)
+static void sclp_cpu_class_init(ObjectClass *oc, const void *data)
 {
     SCLPEventClass *k = SCLP_EVENT_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 7bb5aad5208..da4c8f3e369 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -112,7 +112,7 @@ static void quiesce_reset(DeviceState *dev)
    event->event_pending = false;
 }
 
-static void quiesce_class_init(ObjectClass *klass, void *data)
+static void quiesce_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
index 5da9037e0cb..c9b8896b638 100644
--- a/hw/s390x/tod-kvm.c
+++ b/hw/s390x/tod-kvm.c
@@ -133,7 +133,7 @@ static void kvm_s390_tod_realize(DeviceState *dev, Error **errp)
     qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
 }
 
-static void kvm_s390_tod_class_init(ObjectClass *oc, void *data)
+static void kvm_s390_tod_class_init(ObjectClass *oc, const void *data)
 {
     S390TODClass *tdc = S390_TOD_CLASS(oc);
 
diff --git a/hw/s390x/tod-tcg.c b/hw/s390x/tod-tcg.c
index 3b3ef8843ed..0cc96624e1b 100644
--- a/hw/s390x/tod-tcg.c
+++ b/hw/s390x/tod-tcg.c
@@ -52,7 +52,7 @@ static void qemu_s390_tod_set(S390TODState *td, const S390TOD *tod,
     }
 }
 
-static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
+static void qemu_s390_tod_class_init(ObjectClass *oc, const void *data)
 {
     S390TODClass *tdc = S390_TOD_CLASS(oc);
 
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index 6afbb23fc7e..3f913cc88ab 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -111,7 +111,7 @@ static void s390_tod_realize(DeviceState *dev, Error **errp)
     register_savevm_live("todclock", 0, 1, &savevm_tod, td);
 }
 
-static void s390_tod_class_init(ObjectClass *oc, void *data)
+static void s390_tod_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/s390x/vhost-scsi-ccw.c b/hw/s390x/vhost-scsi-ccw.c
index e6bf0c55bc2..8341b23a95c 100644
--- a/hw/s390x/vhost-scsi-ccw.c
+++ b/hw/s390x/vhost-scsi-ccw.c
@@ -46,7 +46,7 @@ static const Property vhost_ccw_scsi_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
+static void vhost_ccw_scsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
index 6a9654d77b4..cc1b8227fc0 100644
--- a/hw/s390x/vhost-user-fs-ccw.c
+++ b/hw/s390x/vhost-user-fs-ccw.c
@@ -48,7 +48,7 @@ static void vhost_user_fs_ccw_instance_init(Object *obj)
                                 TYPE_VHOST_USER_FS);
 }
 
-static void vhost_user_fs_ccw_class_init(ObjectClass *klass, void *data)
+static void vhost_user_fs_ccw_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 875ccf3485e..552e9e86a4b 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -35,7 +35,7 @@ static void vhost_vsock_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
 }
 
-static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
+static void vhost_vsock_ccw_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index 287ae2ba767..72bf6ec80c8 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -48,7 +48,7 @@ static const Property virtio_ccw_9p_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_9p_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 1180efaf6d5..399b40f366e 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -53,7 +53,7 @@ static const Property virtio_ccw_balloon_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_balloon_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index db9d442ffb5..7d8c4a75ced 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -51,7 +51,7 @@ static const Property virtio_ccw_blk_properties[] = {
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
 };
 
-static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_blk_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index b693f87c70e..75e714603b1 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -51,7 +51,7 @@ static const Property virtio_ccw_crypto_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_crypto_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index a6b14c25d97..edb6a47d376 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -49,7 +49,7 @@ static const Property virtio_ccw_gpu_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_gpu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 6ca10d58eeb..2250d8cf981 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -50,7 +50,7 @@ static const Property virtio_ccw_input_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_input_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index 90fd89f0156..daa485d189f 100644
--- a/hw/s390x/virtio-ccw-mem.c
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -160,7 +160,7 @@ static const Property virtio_ccw_mem_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_mem_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_mem_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index 80a5581baf8..a7d4afbeb9e 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -54,7 +54,7 @@ static const Property virtio_ccw_net_properties[] = {
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
 };
 
-static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_net_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index ccd124ee917..3263287d45a 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -50,7 +50,7 @@ static const Property virtio_ccw_rng_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_rng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index bfcea3cfe78..06b4c6c4a5a 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -60,7 +60,7 @@ static const Property virtio_ccw_scsi_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_scsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 59743d1e256..0dac590c080 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -60,7 +60,7 @@ static const Property virtio_ccw_serial_properties[] = {
                        VIRTIO_CCW_MAX_REV),
 };
 
-static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_serial_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 43f3b162c83..ebf8c6716ad 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1228,7 +1228,7 @@ static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
     virtio_ccw_stop_ioeventfd(_dev);
 }
 
-static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(dc);
@@ -1262,7 +1262,7 @@ static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
     qbus_init(bus, bus_size, TYPE_VIRTIO_CCW_BUS, qdev, virtio_bus_name);
 }
 
-static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
+static void virtio_ccw_bus_class_init(ObjectClass *klass, const void *data)
 {
     VirtioBusClass *k = VIRTIO_BUS_CLASS(klass);
     BusClass *bus_class = BUS_CLASS(klass);
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index fe4e045a6f5..74e9af0b5d8 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -427,7 +427,7 @@ static void esp_pci_init(Object *obj)
     object_initialize_child(obj, "esp", &pci->esp, TYPE_ESP);
 }
 
-static void esp_pci_class_init(ObjectClass *klass, void *data)
+static void esp_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -557,7 +557,7 @@ static void dc390_scsi_realize(PCIDevice *dev, Error **errp)
     contents[EE_CHKSUM2] = chksum >> 8;
 }
 
-static void dc390_class_init(ObjectClass *klass, void *data)
+static void dc390_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ac841dc32e7..4a30c77c8b3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1571,7 +1571,7 @@ static const VMStateDescription vmstate_sysbus_esp_scsi = {
     }
 };
 
-static void sysbus_esp_class_init(ObjectClass *klass, void *data)
+static void sysbus_esp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1597,7 +1597,7 @@ static void esp_init(Object *obj)
     fifo8_create(&s->cmdfifo, ESP_CMDFIFO_SZ);
 }
 
-static void esp_class_init(ObjectClass *klass, void *data)
+static void esp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d85e384ad63..81da262289c 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2375,7 +2375,7 @@ static void lsi_scsi_exit(PCIDevice *dev)
     timer_del(s->scripts_timer);
 }
 
-static void lsi_class_init(ObjectClass *klass, void *data)
+static void lsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -2402,7 +2402,7 @@ static const TypeInfo lsi_info = {
     },
 };
 
-static void lsi53c810_class_init(ObjectClass *klass, void *data)
+static void lsi53c810_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9f3b30e6ce2..cfa5516b96c 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2528,7 +2528,7 @@ static struct MegasasInfo megasas_devices[] = {
     }
 };
 
-static void megasas_class_init(ObjectClass *oc, void *data)
+static void megasas_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index ba7a7d07707..17f73ce3816 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1416,7 +1416,7 @@ static const Property mptsas_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", MPTSASState, msi, ON_OFF_AUTO_AUTO),
 };
 
-static void mptsas1068_class_init(ObjectClass *oc, void *data)
+static void mptsas1068_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 7d4546800fa..d7d0ef8f21f 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1949,7 +1949,7 @@ static const Property scsi_props[] = {
     DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
 };
 
-static void scsi_device_class_init(ObjectClass *klass, void *data)
+static void scsi_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
@@ -1979,7 +1979,7 @@ static const TypeInfo scsi_device_type_info = {
     .instance_init = scsi_dev_instance_init,
 };
 
-static void scsi_bus_class_init(ObjectClass *klass, void *data)
+static void scsi_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7f738b4841..913cd9b2162 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3174,7 +3174,7 @@ static void scsi_property_add_specifics(DeviceClass *dc)
     }
 }
 
-static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
+static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
@@ -3244,7 +3244,7 @@ static const VMStateDescription vmstate_scsi_disk_state = {
     }
 };
 
-static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
+static void scsi_hd_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
@@ -3286,7 +3286,7 @@ static const Property scsi_cd_properties[] = {
                     SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
 };
 
-static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
+static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
@@ -3323,7 +3323,7 @@ static const Property scsi_block_properties[] = {
                        DEFAULT_IO_TIMEOUT),
 };
 
-static void scsi_block_class_initfn(ObjectClass *klass, void *data)
+static void scsi_block_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 6566720064b..9e380a2109e 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -786,7 +786,7 @@ static int scsi_generic_parse_cdb(SCSIDevice *dev, SCSICommand *cmd,
     return scsi_bus_parse_cdb(dev, cmd, buf, buf_len, hba_private);
 }
 
-static void scsi_generic_class_initfn(ObjectClass *klass, void *data)
+static void scsi_generic_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 6962194eaac..20f70fb2729 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1267,7 +1267,7 @@ static const VMStateDescription vmstate_spapr_vscsi = {
     },
 };
 
-static void spapr_vscsi_class_init(ObjectClass *klass, void *data)
+static void spapr_vscsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 8039d13fd95..6a7bb5949ad 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -364,7 +364,7 @@ static const Property vhost_scsi_properties[] = {
                      conf.worker_per_virtqueue, false),
 };
 
-static void vhost_scsi_class_init(ObjectClass *klass, void *data)
+static void vhost_scsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index adb41b9816b..807a58ecf4c 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -386,7 +386,7 @@ static const VMStateDescription vmstate_vhost_scsi = {
     },
 };
 
-static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
+static void vhost_user_scsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 7d094e18810..8490a4dc711 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1311,7 +1311,7 @@ static const VMStateDescription vmstate_virtio_scsi = {
     },
 };
 
-static void virtio_scsi_common_class_init(ObjectClass *klass, void *data)
+static void virtio_scsi_common_class_init(ObjectClass *klass, const void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1320,7 +1320,7 @@ static void virtio_scsi_common_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static void virtio_scsi_class_init(ObjectClass *klass, void *data)
+static void virtio_scsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index f07e377cb88..a8ea57ffad3 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1317,7 +1317,7 @@ static void pvscsi_realize(DeviceState *qdev, Error **errp)
     pvs_c->parent_dc_realize(qdev, errp);
 }
 
-static void pvscsi_class_init(ObjectClass *klass, void *data)
+static void pvscsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index ee5c5c78a81..d6489467709 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -888,14 +888,15 @@ static void allwinner_sdhost_reset(DeviceState *dev)
     }
 }
 
-static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void *data)
+static void allwinner_sdhost_bus_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
 
     sbc->set_inserted = allwinner_sdhost_set_inserted;
 }
 
-static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
+static void allwinner_sdhost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -905,7 +906,8 @@ static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, allwinner_sdhost_properties);
 }
 
-static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, void *data)
+static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass,
+                                              const void *data)
 {
     AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
     sc->max_desc_size = 8 * KiB;
@@ -913,7 +915,8 @@ static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, void *data)
     sc->can_calibrate = false;
 }
 
-static void allwinner_sdhost_sun5i_class_init(ObjectClass *klass, void *data)
+static void allwinner_sdhost_sun5i_class_init(ObjectClass *klass,
+                                              const void *data)
 {
     AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
     sc->max_desc_size = 64 * KiB;
@@ -922,7 +925,7 @@ static void allwinner_sdhost_sun5i_class_init(ObjectClass *klass, void *data)
 }
 
 static void allwinner_sdhost_sun50i_a64_class_init(ObjectClass *klass,
-                                                   void *data)
+                                                   const void *data)
 {
     AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
     sc->max_desc_size = 64 * KiB;
@@ -931,7 +934,7 @@ static void allwinner_sdhost_sun50i_a64_class_init(ObjectClass *klass,
 }
 
 static void allwinner_sdhost_sun50i_a64_emmc_class_init(ObjectClass *klass,
-                                                        void *data)
+                                                        const void *data)
 {
     AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
     sc->max_desc_size = 8 * KiB;
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 12cbbae5e77..fc38ad39ce1 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -208,7 +208,7 @@ static const Property aspeed_sdhci_properties[] = {
     DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
 };
 
-static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
+static void aspeed_sdhci_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
 
@@ -218,7 +218,7 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
     device_class_set_props(dc, aspeed_sdhci_properties);
 }
 
-static void aspeed_2400_sdhci_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_sdhci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
@@ -227,7 +227,7 @@ static void aspeed_2400_sdhci_class_init(ObjectClass *klass, void *data)
     asc->capareg = 0x0000000001e80080;
 }
 
-static void aspeed_2500_sdhci_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_sdhci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
@@ -236,7 +236,7 @@ static void aspeed_2500_sdhci_class_init(ObjectClass *klass, void *data)
     asc->capareg = 0x0000000001e80080;
 }
 
-static void aspeed_2600_sdhci_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_sdhci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
@@ -245,7 +245,7 @@ static void aspeed_2600_sdhci_class_init(ObjectClass *klass, void *data)
     asc->capareg = 0x0000000701f80080;
 }
 
-static void aspeed_2700_sdhci_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_sdhci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 0724949d0cf..29debdf59e4 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -428,7 +428,7 @@ static void bcm2835_sdhost_reset(DeviceState *dev)
     s->fifo_len = 0;
 }
 
-static void bcm2835_sdhost_class_init(ObjectClass *klass, void *data)
+static void bcm2835_sdhost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index ad9daa20ed9..d576855a1a8 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -165,7 +165,7 @@ static const VMStateDescription vmstate_cadence_sdhci = {
     },
 };
 
-static void cadence_sdhci_class_init(ObjectClass *classp, void *data)
+static void cadence_sdhci_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
 
diff --git a/hw/sd/npcm7xx_sdhci.c b/hw/sd/npcm7xx_sdhci.c
index 99028c1a2ca..0233d7bd4d3 100644
--- a/hw/sd/npcm7xx_sdhci.c
+++ b/hw/sd/npcm7xx_sdhci.c
@@ -149,7 +149,7 @@ static const VMStateDescription vmstate_npcm7xx_sdhci = {
     },
 };
 
-static void npcm7xx_sdhci_class_init(ObjectClass *classp, void *data)
+static void npcm7xx_sdhci_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
 
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index bbe7b971bbe..b7648d41cc5 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -612,7 +612,7 @@ static void omap_mmc_initfn(Object *obj)
     qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(obj), "sd-bus");
 }
 
-static void omap_mmc_class_init(ObjectClass *oc, void *data)
+static void omap_mmc_class_init(ObjectClass *oc, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(oc);
 
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 03d2ae7d21f..b8fc9f86f13 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -509,7 +509,7 @@ static void pl181_init(Object *obj)
     qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_PL181_BUS, dev, "sd-bus");
 }
 
-static void pl181_class_init(ObjectClass *klass, void *data)
+static void pl181_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
@@ -519,7 +519,7 @@ static void pl181_class_init(ObjectClass *klass, void *data)
     k->user_creatable = false;
 }
 
-static void pl181_bus_class_init(ObjectClass *klass, void *data)
+static void pl181_bus_class_init(ObjectClass *klass, const void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e541c57f8c3..c275fdda2d0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2751,7 +2751,7 @@ static const Property emmc_properties[] = {
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
 };
 
-static void sdmmc_common_class_init(ObjectClass *klass, void *data)
+static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
@@ -2774,7 +2774,7 @@ static void sdmmc_common_class_init(ObjectClass *klass, void *data)
     sc->get_readonly = sd_get_readonly;
 }
 
-static void sd_class_init(ObjectClass *klass, void *data)
+static void sd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
@@ -2793,7 +2793,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
  * board to ensure that ssi transfers only occur when the chip select
  * is asserted.
  */
-static void sd_spi_class_init(ObjectClass *klass, void *data)
+static void sd_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
@@ -2802,7 +2802,7 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
     sc->proto = &sd_proto_spi;
 }
 
-static void emmc_class_init(ObjectClass *klass, void *data)
+static void emmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 5268c0dee50..4c2944df01c 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -52,7 +52,7 @@ static void sdhci_pci_exit(PCIDevice *dev)
     sdhci_uninitfn(s);
 }
 
-static void sdhci_pci_class_init(ObjectClass *klass, void *data)
+static void sdhci_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1f45a77566c..c84f957cd83 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1616,7 +1616,7 @@ static void sdhci_sysbus_unrealize(DeviceState *dev)
     }
 }
 
-static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
+static void sdhci_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1629,7 +1629,7 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 
 /* --- qdev bus master --- */
 
-static void sdhci_bus_class_init(ObjectClass *klass, void *data)
+static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
 
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index c4a58da0abc..6c90a86ab41 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -389,7 +389,7 @@ static void ssi_sd_reset(DeviceState *dev)
     s->stopping = 0;
 }
 
-static void ssi_sd_class_init(ObjectClass *klass, void *data)
+static void ssi_sd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 25b87a72961..9017ce6116c 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -223,7 +223,7 @@ static void adm1266_init(Object *obj)
     }
 }
 
-static void adm1266_class_init(ObjectClass *klass, void *data)
+static void adm1266_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 3fc1e5d0ad9..0c739aa0d85 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -511,7 +511,7 @@ static void adm1272_init(Object *obj)
 
 }
 
-static void adm1272_class_init(ObjectClass *klass, void *data)
+static void adm1272_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/sensor/dps310.c b/hw/sensor/dps310.c
index 6966a53248b..bcf615423ae 100644
--- a/hw/sensor/dps310.c
+++ b/hw/sensor/dps310.c
@@ -197,7 +197,7 @@ static const VMStateDescription vmstate_dps310 = {
     }
 };
 
-static void dps310_class_init(ObjectClass *klass, void *data)
+static void dps310_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index 33c1bd330fd..7b2ce383a12 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -277,7 +277,7 @@ static void emc141x_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_emc141x;
 }
 
-static void emc1413_class_init(ObjectClass *klass, void *data)
+static void emc1413_class_init(ObjectClass *klass, const void *data)
 {
     EMC141XClass *ec = EMC141X_CLASS(klass);
 
@@ -286,7 +286,7 @@ static void emc1413_class_init(ObjectClass *klass, void *data)
     ec->sensors_count = 3;
 }
 
-static void emc1414_class_init(ObjectClass *klass, void *data)
+static void emc1414_class_init(ObjectClass *klass, const void *data)
 {
     EMC141XClass *ec = EMC141X_CLASS(klass);
 
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index c60282cfe77..e8d29b08ff3 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -242,7 +242,7 @@ static void isl_pmbus_vr_class_init(ObjectClass *klass, const void *data,
     k->device_num_pages = pages;
 }
 
-static void isl69260_class_init(ObjectClass *klass, void *data)
+static void isl69260_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -251,7 +251,7 @@ static void isl69260_class_init(ObjectClass *klass, void *data)
     isl_pmbus_vr_class_init(klass, data, 2);
 }
 
-static void raa228000_class_init(ObjectClass *klass, void *data)
+static void raa228000_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -260,7 +260,7 @@ static void raa228000_class_init(ObjectClass *klass, void *data)
     isl_pmbus_vr_class_init(klass, data, 1);
 }
 
-static void raa229004_class_init(ObjectClass *klass, void *data)
+static void raa229004_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -269,7 +269,7 @@ static void raa229004_class_init(ObjectClass *klass, void *data)
     isl_pmbus_vr_class_init(klass, data, 2);
 }
 
-static void isl69259_class_init(ObjectClass *klass, void *data)
+static void isl69259_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index 04471539b59..f9e501da840 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -530,7 +530,7 @@ static void lsm303dlhc_mag_initfn(Object *obj)
 /*
  * Set the virtual method pointers (bus state change, tx/rx, etc.).
  */
-static void lsm303dlhc_mag_class_init(ObjectClass *klass, void *data)
+static void lsm303dlhc_mag_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/max31785.c b/hw/sensor/max31785.c
index 3577a7c2180..c75581455a2 100644
--- a/hw/sensor/max31785.c
+++ b/hw/sensor/max31785.c
@@ -544,7 +544,7 @@ static void max31785_init(Object *obj)
     }
 }
 
-static void max31785_class_init(ObjectClass *klass, void *data)
+static void max31785_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index 93b53f3db2f..a369d2b5319 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -746,7 +746,7 @@ static void max34451_init(Object *obj)
 
 }
 
-static void max34451_class_init(ObjectClass *klass, void *data)
+static void max34451_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index ef2824f3e1b..f5b61109e36 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -313,7 +313,7 @@ static void tmp105_initfn(Object *obj)
                         tmp105_set_temperature, NULL, NULL);
 }
 
-static void tmp105_class_init(ObjectClass *klass, void *data)
+static void tmp105_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 007f7cd018b..263bfa1bbda 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -337,7 +337,7 @@ static void tmp421_realize(DeviceState *dev, Error **errp)
     tmp421_reset(&s->i2c);
 }
 
-static void tmp421_class_init(ObjectClass *klass, void *data)
+static void tmp421_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a48d3622c5a..228acf7c341 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -601,7 +601,7 @@ static void idreg_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->mem);
 }
 
-static void idreg_class_init(ObjectClass *oc, void *data)
+static void idreg_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -651,7 +651,7 @@ static void afx_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->mem);
 }
 
-static void afx_class_init(ObjectClass *oc, void *data)
+static void afx_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -733,7 +733,7 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static void prom_class_init(ObjectClass *klass, void *data)
+static void prom_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -777,7 +777,7 @@ static void ram_initfn(Object *obj)
                                     "Valid value is ID of a hostmem backend");
 }
 
-static void ram_class_init(ObjectClass *klass, void *data)
+static void ram_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1104,7 +1104,7 @@ enum {
     ss600mp_id,
 };
 
-static void sun4m_machine_class_init(ObjectClass *oc, void *data)
+static void sun4m_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -1115,7 +1115,7 @@ static void sun4m_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "sun4m.ram";
 }
 
-static void ss5_class_init(ObjectClass *oc, void *data)
+static void ss5_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1152,7 +1152,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &ss5_hwdef;
 }
 
-static void ss10_class_init(ObjectClass *oc, void *data)
+static void ss10_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1187,7 +1187,7 @@ static void ss10_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &ss10_hwdef;
 }
 
-static void ss600mp_class_init(ObjectClass *oc, void *data)
+static void ss600mp_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1220,7 +1220,7 @@ static void ss600mp_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &ss600mp_hwdef;
 }
 
-static void ss20_class_init(ObjectClass *oc, void *data)
+static void ss20_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1271,7 +1271,7 @@ static void ss20_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &ss20_hwdef;
 }
 
-static void voyager_class_init(ObjectClass *oc, void *data)
+static void voyager_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1303,7 +1303,7 @@ static void voyager_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &voyager_hwdef;
 }
 
-static void ss_lx_class_init(ObjectClass *oc, void *data)
+static void ss_lx_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1336,7 +1336,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &ss_lx_hwdef;
 }
 
-static void ss4_class_init(ObjectClass *oc, void *data)
+static void ss4_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1369,7 +1369,7 @@ static void ss4_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &ss4_hwdef;
 }
 
-static void scls_class_init(ObjectClass *oc, void *data)
+static void scls_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
@@ -1401,7 +1401,7 @@ static void scls_class_init(ObjectClass *oc, void *data)
     smc->hwdef = &scls_hwdef;
 }
 
-static void sbook_class_init(ObjectClass *oc, void *data)
+static void sbook_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     Sun4mMachineClass *smc = SUN4M_MACHINE_CLASS(mc);
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 5a4c1f5e3bd..b9f5c741127 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -372,7 +372,7 @@ static const Property iommu_properties[] = {
     DEFINE_PROP_UINT32("version", IOMMUState, version, 0),
 };
 
-static void iommu_class_init(ObjectClass *klass, void *data)
+static void iommu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -389,7 +389,8 @@ static const TypeInfo iommu_info = {
     .class_init    = iommu_class_init,
 };
 
-static void sun4m_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+static void sun4m_iommu_memory_region_class_init(ObjectClass *klass,
+                                                 const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 805ba6b1e3d..1ffe92060ad 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -157,7 +157,7 @@ static void niagara_init(MachineState *machine)
     sun4v_rtc_init(NIAGARA_RTC_BASE);
 }
 
-static void niagara_class_init(ObjectClass *oc, void *data)
+static void niagara_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8ab5cf0461f..0794c1fbff0 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -272,7 +272,7 @@ static void power_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &d->power_mmio);
 }
 
-static void power_class_init(ObjectClass *klass, void *data)
+static void power_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -379,7 +379,7 @@ static const Property ebus_properties[] = {
                        console_serial_base, 0),
 };
 
-static void ebus_class_init(ObjectClass *klass, void *data)
+static void ebus_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -470,7 +470,7 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static void prom_class_init(ObjectClass *klass, void *data)
+static void prom_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -530,7 +530,7 @@ static const Property ram_properties[] = {
     DEFINE_PROP_UINT64("size", RamDevice, size, 0),
 };
 
-static void ram_class_init(ObjectClass *klass, void *data)
+static void ram_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -793,7 +793,7 @@ static GlobalProperty hw_compat_sparc64[] = {
 };
 static const size_t hw_compat_sparc64_len = G_N_ELEMENTS(hw_compat_sparc64);
 
-static void sun4u_class_init(ObjectClass *oc, void *data)
+static void sun4u_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
@@ -823,7 +823,7 @@ static const TypeInfo sun4u_type = {
     },
 };
 
-static void sun4v_class_init(ObjectClass *oc, void *data)
+static void sun4v_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index eba811af0cc..ac47527a6ab 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -305,7 +305,7 @@ static void iommu_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void iommu_class_init(ObjectClass *klass, void *data)
+static void iommu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -320,7 +320,8 @@ static const TypeInfo iommu_info = {
     .class_init    = iommu_class_init,
 };
 
-static void sun4u_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+static void sun4u_iommu_memory_region_class_init(ObjectClass *klass,
+                                                 const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
index 3eb50b44ac5..9aa5f159169 100644
--- a/hw/ssi/allwinner-a10-spi.c
+++ b/hw/ssi/allwinner-a10-spi.c
@@ -535,7 +535,7 @@ static void allwinner_a10_spi_realize(DeviceState *dev, Error **errp)
     fifo8_create(&s->rx_fifo, AW_A10_SPI_FIFO_SIZE);
 }
 
-static void allwinner_a10_spi_class_init(ObjectClass *klass, void *data)
+static void allwinner_a10_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index faef1a8e5b8..0d38f95c7a3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1294,7 +1294,7 @@ static const Property aspeed_smc_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
-static void aspeed_smc_class_init(ObjectClass *klass, void *data)
+static void aspeed_smc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1341,7 +1341,7 @@ static const Property aspeed_smc_flash_properties[] = {
                      AspeedSMCState *),
 };
 
-static void aspeed_smc_flash_class_init(ObjectClass *klass, void *data)
+static void aspeed_smc_flash_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -1383,7 +1383,7 @@ static const AspeedSegments aspeed_2400_smc_segments[] = {
     { 0x10000000, 32 * MiB },
 };
 
-static void aspeed_2400_smc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_smc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1429,7 +1429,7 @@ static const AspeedSegments aspeed_2400_fmc_segments[] = {
     { 0x2A000000, 32 * MiB }
 };
 
-static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_fmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1473,7 +1473,7 @@ static int aspeed_2400_spi1_addr_width(const AspeedSMCState *s)
     return s->regs[R_SPI_CTRL0] & CTRL_AST2400_SPI_4BYTE ? 4 : 3;
 }
 
-static void aspeed_2400_spi1_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_spi1_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1515,7 +1515,7 @@ static const AspeedSegments aspeed_2500_fmc_segments[] = {
     { 0x2A000000,  32 * MiB },
 };
 
-static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_fmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1555,7 +1555,7 @@ static const AspeedSegments aspeed_2500_spi1_segments[] = {
     { 0x32000000, 96 * MiB }, /* end address is readonly */
 };
 
-static void aspeed_2500_spi1_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_spi1_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1591,7 +1591,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[] = {
     { 0x3A000000, 96 * MiB }, /* end address is readonly */
 };
 
-static void aspeed_2500_spi2_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_spi2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1674,7 +1674,7 @@ static const AspeedSegments aspeed_2600_fmc_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_fmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1715,7 +1715,7 @@ static const AspeedSegments aspeed_2600_spi1_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_spi1_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1756,7 +1756,7 @@ static const AspeedSegments aspeed_2600_spi2_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_spi2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1839,7 +1839,7 @@ static const AspeedSegments aspeed_1030_fmc_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_fmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1879,7 +1879,7 @@ static const AspeedSegments aspeed_1030_spi1_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_spi1_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -1917,7 +1917,7 @@ static const AspeedSegments aspeed_1030_spi2_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_spi2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -2022,7 +2022,7 @@ static const AspeedSegments aspeed_2700_fmc_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2700_fmc_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -2064,7 +2064,7 @@ static const AspeedSegments aspeed_2700_spi0_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2700_spi0_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_spi0_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -2104,7 +2104,7 @@ static const AspeedSegments aspeed_2700_spi1_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2700_spi1_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_spi1_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
@@ -2144,7 +2144,7 @@ static const AspeedSegments aspeed_2700_spi2_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
-static void aspeed_2700_spi2_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_spi2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
index ebd8809f7cc..bf8ba35e04c 100644
--- a/hw/ssi/bcm2835_spi.c
+++ b/hw/ssi/bcm2835_spi.c
@@ -264,7 +264,7 @@ static const VMStateDescription vmstate_bcm2835_spi = {
     }
 };
 
-static void bcm2835_spi_class_init(ObjectClass *klass, void *data)
+static void bcm2835_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 46c7b633c26..6a29835885e 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -623,7 +623,7 @@ static void ibex_spi_host_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-static void ibex_spi_host_class_init(ObjectClass *klass, void *data)
+static void ibex_spi_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = ibex_spi_host_realize;
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 2e317879b47..1312f588d2e 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -475,7 +475,7 @@ static void imx_spi_realize(DeviceState *dev, Error **errp)
     fifo32_create(&s->rx_fifo, ECSPI_FIFO_SIZE);
 }
 
-static void imx_spi_class_init(ObjectClass *klass, void *data)
+static void imx_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 340adcdd3f6..fd7ba7eeb04 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -398,7 +398,7 @@ static const VMStateDescription vmstate_mss_spi = {
     }
 };
 
-static void mss_spi_class_init(ObjectClass *klass, void *data)
+static void mss_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 21fc4890383..c4f5f9b05c7 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -545,7 +545,7 @@ static const Property npcm7xx_fiu_properties[] = {
     DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
 };
 
-static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_fiu_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/ssi/npcm_pspi.c b/hw/ssi/npcm_pspi.c
index 41a53235303..a31dcc050e8 100644
--- a/hw/ssi/npcm_pspi.c
+++ b/hw/ssi/npcm_pspi.c
@@ -199,7 +199,7 @@ static const VMStateDescription vmstate_npcm_pspi = {
 };
 
 
-static void npcm_pspi_class_init(ObjectClass *klass, void *data)
+static void npcm_pspi_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 53c9c225ad8..1dc0bcbcc04 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -292,7 +292,7 @@ static void pl022_realize(DeviceState *dev, Error **errp)
     s->ssi = ssi_create_bus(dev, "ssi");
 }
 
-static void pl022_class_init(ObjectClass *klass, void *data)
+static void pl022_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 15e25bd1be3..9575cb88fd5 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1237,7 +1237,7 @@ static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
-static void pnv_spi_class_init(ObjectClass *klass, void *data)
+static void pnv_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 76f8654f412..3e01fef61cd 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -332,7 +332,7 @@ static const Property sifive_spi_properties[] = {
     DEFINE_PROP_UINT32("num-cs", SiFiveSPIState, num_cs, 1),
 };
 
-static void sifive_spi_class_init(ObjectClass *klass, void *data)
+static void sifive_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 872c4e8036e..d0de640fe64 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -55,7 +55,7 @@ static bool ssi_bus_check_address(BusState *b, DeviceState *dev, Error **errp)
     return true;
 }
 
-static void ssi_bus_class_init(ObjectClass *klass, void *data)
+static void ssi_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
@@ -112,7 +112,7 @@ static const Property ssi_peripheral_properties[] = {
     DEFINE_PROP_UINT8("cs", SSIPeripheral, cs_index, 0),
 };
 
-static void ssi_peripheral_class_init(ObjectClass *klass, void *data)
+static void ssi_peripheral_class_init(ObjectClass *klass, const void *data)
 {
     SSIPeripheralClass *ssc = SSI_PERIPHERAL_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index ea9b74a4094..871d57324d1 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -202,7 +202,7 @@ static void stm32f2xx_spi_init(Object *obj)
     s->ssi = ssi_create_bus(dev, "ssi");
 }
 
-static void stm32f2xx_spi_class_init(ObjectClass *klass, void *data)
+static void stm32f2xx_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index fd1ff12eb1d..8aca891bbcd 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -365,7 +365,7 @@ static const Property xilinx_spi_properties[] = {
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
 };
 
-static void xilinx_spi_class_init(ObjectClass *klass, void *data)
+static void xilinx_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 60d092039f1..a79f3b8e494 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1430,7 +1430,7 @@ static const Property xilinx_spips_properties[] = {
     DEFINE_PROP_UINT8("num-txrx-bytes", XilinxSPIPS, num_txrx_bytes, 1),
 };
 
-static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
+static void xilinx_qspips_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
@@ -1442,7 +1442,7 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
     xsc->tx_fifo_size = TXFF_A_Q;
 }
 
-static void xilinx_spips_class_init(ObjectClass *klass, void *data)
+static void xilinx_spips_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
@@ -1458,7 +1458,7 @@ static void xilinx_spips_class_init(ObjectClass *klass, void *data)
     xsc->tx_fifo_size = TXFF_A;
 }
 
-static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
+static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 9e96c9b69af..56d51ce0e30 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1831,7 +1831,7 @@ static const Property xlnx_versal_ospi_properties[] = {
                      ind_write_disabled, false),
 };
 
-static void xlnx_versal_ospi_class_init(ObjectClass *klass, void *data)
+static void xlnx_versal_ospi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 9835c354832..690140f5a6c 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -377,7 +377,7 @@ static const Property a9_gtimer_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
 };
 
-static void a9_gtimer_class_init(ObjectClass *klass, void *data)
+static void a9_gtimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ddaf2128c2d..541cb0217f4 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -288,7 +288,7 @@ static void a10_pit_finalize(Object *obj)
     }
 }
 
-static void a10_pit_class_init(ObjectClass *klass, void *data)
+static void a10_pit_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 803dad1e8a6..7cc5915e9ec 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -304,7 +304,7 @@ static const Property arm_mptimer_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
 };
 
-static void arm_mptimer_class_init(ObjectClass *klass, void *data)
+static void arm_mptimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 1213b77aa09..56638ff5cdc 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -392,7 +392,7 @@ static const Property sp804_properties[] = {
     DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
 };
 
-static void sp804_class_init(ObjectClass *klass, void *data)
+static void sp804_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index a07febd1d1e..7e4ddcd4058 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -285,7 +285,7 @@ static const VMStateDescription vmstate_systick = {
     }
 };
 
-static void systick_class_init(ObjectClass *klass, void *data)
+static void systick_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index ecda49574e2..57db03512f4 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -895,7 +895,7 @@ static const Property aspeed_timer_properties[] = {
                      AspeedSCUState *),
 };
 
-static void timer_class_init(ObjectClass *klass, void *data)
+static void timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -915,7 +915,7 @@ static const TypeInfo aspeed_timer_info = {
     .abstract   = true,
 };
 
-static void aspeed_2400_timer_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
@@ -931,7 +931,7 @@ static const TypeInfo aspeed_2400_timer_info = {
     .class_init = aspeed_2400_timer_class_init,
 };
 
-static void aspeed_2500_timer_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
@@ -947,7 +947,7 @@ static const TypeInfo aspeed_2500_timer_info = {
     .class_init = aspeed_2500_timer_class_init,
 };
 
-static void aspeed_2600_timer_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
@@ -963,7 +963,7 @@ static const TypeInfo aspeed_2600_timer_info = {
     .class_init = aspeed_2600_timer_class_init,
 };
 
-static void aspeed_1030_timer_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
@@ -979,7 +979,7 @@ static const TypeInfo aspeed_1030_timer_info = {
     .class_init = aspeed_1030_timer_class_init,
 };
 
-static void aspeed_2700_timer_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 96baf9cf605..012d8290018 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -595,7 +595,7 @@ static void avr_timer16_realize(DeviceState *dev, Error **errp)
     s->enabled = true;
 }
 
-static void avr_timer16_class_init(ObjectClass *klass, void *data)
+static void avr_timer16_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 2f0fee33420..7929aaa882a 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -154,7 +154,7 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     }
 };
 
-static void bcm2835_systmr_class_init(ObjectClass *klass, void *data)
+static void bcm2835_systmr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 54dbd4c5646..9c7ba168768 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -451,7 +451,7 @@ static const VMStateDescription vmstate_cadence_ttc = {
     }
 };
 
-static void cadence_ttc_class_init(ObjectClass *klass, void *data)
+static void cadence_ttc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 2ecd8dfe3c7..34c550a3f98 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -534,7 +534,7 @@ static const VMStateDescription cmsdk_apb_dualtimer_vmstate = {
     }
 };
 
-static void cmsdk_apb_dualtimer_class_init(ObjectClass *klass, void *data)
+static void cmsdk_apb_dualtimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 16d0b2170ef..4095267b4aa 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -261,7 +261,7 @@ static const VMStateDescription cmsdk_apb_timer_vmstate = {
     }
 };
 
-static void cmsdk_apb_timer_class_init(ObjectClass *klass, void *data)
+static void cmsdk_apb_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 00c32978d29..355138d3547 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -161,7 +161,7 @@ static void digic_timer_finalize(Object *obj)
     ptimer_free(s->ptimer);
 }
 
-static void digic_timer_class_init(ObjectClass *klass, void *class_data)
+static void digic_timer_class_init(ObjectClass *klass, const void *class_data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 5c6e139b202..bb0f9c8b9a6 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1546,7 +1546,7 @@ static void exynos4210_mct_finalize(Object *obj)
     }
 }
 
-static void exynos4210_mct_class_init(ObjectClass *klass, void *data)
+static void exynos4210_mct_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 703d1d2b4ad..69f737a8e6f 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -420,7 +420,7 @@ static void exynos4210_pwm_finalize(Object *obj)
     }
 }
 
-static void exynos4210_pwm_class_init(ObjectClass *klass, void *data)
+static void exynos4210_pwm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index f0802b6eb6d..0e06fa09e99 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -409,7 +409,7 @@ static const Property grlib_gptimer_properties[] = {
     DEFINE_PROP_UINT32("nr-timers", GPTimerUnit, nr_timers, 2),
 };
 
-static void grlib_gptimer_class_init(ObjectClass *klass, void *data)
+static void grlib_gptimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1c8c6c69ef5..dede01ea336 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -752,7 +752,7 @@ static const Property hpet_device_properties[] = {
     DEFINE_PROP_BOOL("hpet-offset-saved", HPETState, hpet_offset_saved, true),
 };
 
-static void hpet_device_class_init(ObjectClass *klass, void *data)
+static void hpet_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 058fc61ce99..4b25c487f79 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -350,7 +350,7 @@ static void pit_realizefn(DeviceState *dev, Error **errp)
     pc->parent_realize(dev, errp);
 }
 
-static void pit_class_initfn(ObjectClass *klass, void *data)
+static void pit_class_initfn(ObjectClass *klass, const void *data)
 {
     PITClass *pc = PIT_CLASS(klass);
     PITCommonClass *k = PIT_COMMON_CLASS(klass);
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 29105afcc33..ad091594cde 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -242,7 +242,7 @@ static const Property pit_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
 };
 
-static void pit_common_class_init(ObjectClass *klass, void *data)
+static void pit_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index 3ebc8700973..c7320ef30fa 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -286,7 +286,7 @@ static void ibex_timer_realize(DeviceState *dev, Error **errp)
 }
 
 
-static void ibex_timer_class_init(ObjectClass *klass, void *data)
+static void ibex_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index f40ab166973..6123321c352 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -427,7 +427,7 @@ static void imx_epit_dev_reset(DeviceState *dev)
     imx_epit_reset(s, true);
 }
 
-static void imx_epit_class_init(ObjectClass *klass, void *data)
+static void imx_epit_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc  = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 11eca9fa4df..9c3d939a4f3 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -507,7 +507,7 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
     s->timer = ptimer_init(imx_gpt_timeout, s, PTIMER_POLICY_LEGACY);
 }
 
-static void imx_gpt_class_init(ObjectClass *klass, void *data)
+static void imx_gpt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 594da64eae6..2ce821178b6 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -285,7 +285,7 @@ static const Property mss_timer_properties[] = {
                       100 * 1000000),
 };
 
-static void mss_timer_class_init(ObjectClass *klass, void *data)
+static void mss_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index c55ba022353..6a116ad54b7 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -689,7 +689,7 @@ static const VMStateDescription vmstate_npcm7xx_timer_ctrl = {
     },
 };
 
-static void npcm7xx_timer_class_init(ObjectClass *klass, void *data)
+static void npcm7xx_timer_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 11ad8b575e4..e228fdebc34 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -383,7 +383,7 @@ static const Property nrf51_timer_properties[] = {
     DEFINE_PROP_UINT8("id", NRF51TimerState, id, 0),
 };
 
-static void nrf51_timer_class_init(ObjectClass *klass, void *data)
+static void nrf51_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 9e4dd0fd9fb..7a94366b0f8 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -555,7 +555,7 @@ static const Property pxa25x_timer_dev_properties[] = {
                     PXA2XX_TIMER_HAVE_TM4, false),
 };
 
-static void pxa25x_timer_dev_class_init(ObjectClass *klass, void *data)
+static void pxa25x_timer_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -570,7 +570,7 @@ static const TypeInfo pxa25x_timer_dev_info = {
     .class_init    = pxa25x_timer_dev_class_init,
 };
 
-static void pxa2xx_timer_class_init(ObjectClass *oc, void *data)
+static void pxa2xx_timer_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 93e7f58cc20..cdff7f47f16 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -257,7 +257,7 @@ static const Property rcmt_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
 };
 
-static void rcmt_class_init(ObjectClass *klass, void *data)
+static void rcmt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 884349c2cc2..95707f2b8c5 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -467,7 +467,7 @@ static const Property rtmr_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
 };
 
-static void rtmr_class_init(ObjectClass *klass, void *data)
+static void rtmr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index fc796e9bc30..e85e389f7a5 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -441,7 +441,7 @@ static void sifive_pwm_realize(DeviceState *dev, Error **errp)
                   sifive_pwm_interrupt_3, s);
 }
 
-static void sifive_pwm_class_init(ObjectClass *klass, void *data)
+static void sifive_pwm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 65b24e4f06b..3e071fbdb4c 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -424,7 +424,7 @@ static const Property slavio_timer_properties[] = {
     DEFINE_PROP_UINT32("num_cpus",  SLAVIO_TIMERState, num_cpus,  0),
 };
 
-static void slavio_timer_class_init(ObjectClass *klass, void *data)
+static void slavio_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index f17064abe35..31f77acf61e 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -448,7 +448,7 @@ static const VMStateDescription sse_counter_vmstate = {
     }
 };
 
-static void sse_counter_class_init(ObjectClass *klass, void *data)
+static void sse_counter_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index e106739ea9c..866d5eef8af 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -444,7 +444,7 @@ static const Property sse_timer_properties[] = {
     DEFINE_PROP_LINK("counter", SSETimer, counter, TYPE_SSE_COUNTER, SSECounter *),
 };
 
-static void sse_timer_class_init(ObjectClass *klass, void *data)
+static void sse_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/stellaris-gptm.c b/hw/timer/stellaris-gptm.c
index f28958cefca..d97b2f8309c 100644
--- a/hw/timer/stellaris-gptm.c
+++ b/hw/timer/stellaris-gptm.c
@@ -308,7 +308,7 @@ static void stellaris_gptm_realize(DeviceState *dev, Error **errp)
     s->timer[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opaque[1]);
 }
 
-static void stellaris_gptm_class_init(ObjectClass *klass, void *data)
+static void stellaris_gptm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 4707190d6a2..be844e7f5a3 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -320,7 +320,7 @@ static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt, s);
 }
 
-static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
+static void stm32f2xx_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 6595cf5f517..c096ac6a069 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -251,7 +251,7 @@ static const Property xilinx_timer_properties[] = {
     DEFINE_PROP_UINT8("one-timer-only", XpsTimerState, one_timer_only, 0),
 };
 
-static void xilinx_timer_class_init(ObjectClass *klass, void *data)
+static void xilinx_timer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 6cdeb72df0d..8a3dd32fbeb 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -315,7 +315,7 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void tpm_crb_class_init(ObjectClass *klass, void *data)
+static void tpm_crb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 9a031e1e75c..1cad9a88ead 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -387,7 +387,7 @@ static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
     s->buffer = g_malloc(TPM_SPAPR_BUFFER_MAX);
 }
 
-static void tpm_spapr_class_init(ObjectClass *klass, void *data)
+static void tpm_spapr_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 504328e3b0d..2c28028b54f 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -530,7 +530,7 @@ static void tpm_tis_i2c_reset(DeviceState *dev)
     return tpm_tis_reset(s);
 }
 
-static void tpm_tis_i2c_class_init(ObjectClass *klass, void *data)
+static void tpm_tis_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 876cb02cb51..c0098a26e80 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -166,7 +166,7 @@ static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
     aml_append(scope, dev);
 }
 
-static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
+static void tpm_tis_isa_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index ee0bfe9538e..862556c3a64 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -124,7 +124,7 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
     }
 }
 
-static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
+static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index 81bb16d89b6..f3b84980e52 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -201,14 +201,14 @@ static void tc27x_soc_init(Object *obj)
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
 }
 
-static void tc27x_soc_class_init(ObjectClass *klass, void *data)
+static void tc27x_soc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = tc27x_soc_realize;
 }
 
-static void tc277d_soc_class_init(ObjectClass *oc, void *data)
+static void tc277d_soc_class_init(ObjectClass *oc, const void *data)
 {
     TC27XSoCClass *sc = TC27X_SOC_CLASS(oc);
 
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index f5baa8ccbb3..cb45b01d2d2 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -65,7 +65,7 @@ static void triboard_machine_init(MachineState *machine)
 }
 
 static void triboard_machine_tc277d_class_init(ObjectClass *oc,
-        void *data)
+                                               const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     TriBoardMachineClass *amc = TRIBOARD_MACHINE_CLASS(oc);
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index d2da74e3846..e8daf952982 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -58,7 +58,7 @@ static void tricore_testdevice_init(Object *obj)
                           "tricore_testdevice", 0x4);
 }
 
-static void tricore_testdevice_class_init(ObjectClass *klass, void *data)
+static void tricore_testdevice_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 1c3794b2d46..57b307ea560 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -419,7 +419,7 @@ static void ufs_lu_unrealize(DeviceState *dev)
     }
 }
 
-static void ufs_lu_class_init(ObjectClass *oc, void *data)
+static void ufs_lu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 428fe927ad0..24dcdc7ee36 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1765,7 +1765,7 @@ static const VMStateDescription ufs_vmstate = {
     .unmigratable = 1,
 };
 
-static void ufs_class_init(ObjectClass *oc, void *data)
+static void ufs_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
@@ -1801,7 +1801,7 @@ static char *ufs_bus_get_dev_path(DeviceState *dev)
     return qdev_get_dev_path(bus->parent);
 }
 
-static void ufs_bus_class_init(ObjectClass *class, void *data)
+static void ufs_bus_class_init(ObjectClass *class, const void *data)
 {
     BusClass *bc = BUS_CLASS(class);
     bc->get_dev_path = ufs_bus_get_dev_path;
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index f45b82c776d..d8446cf50e6 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -26,7 +26,7 @@ static const Property usb_props[] = {
     DEFINE_PROP_STRING("pcap", USBDevice, pcap_filename),
 };
 
-static void usb_bus_class_init(ObjectClass *klass, void *data)
+static void usb_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
@@ -713,7 +713,7 @@ static void usb_device_instance_init(Object *obj)
     }
 }
 
-static void usb_device_class_init(ObjectClass *klass, void *data)
+static void usb_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_type = TYPE_USB_BUS;
diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index e2d66179e0b..cbefbb5daf8 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -300,7 +300,7 @@ static const Property canokey_properties[] = {
     DEFINE_PROP_STRING("file", CanoKeyState, file),
 };
 
-static void canokey_class_init(ObjectClass *klass, void *data)
+static void canokey_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index b1e330f21d7..c21cefd82d2 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -591,7 +591,7 @@ static const Property emulated_card_properties[] = {
     DEFINE_PROP_UINT8("debug", EmulatedState, debug, 0),
 };
 
-static void emulated_class_initfn(ObjectClass *klass, void *data)
+static void emulated_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index bf81485f876..1eea21a7337 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -393,7 +393,7 @@ static const Property passthru_card_properties[] = {
     DEFINE_PROP_UINT8("debug", PassthruState, debug, 0),
 };
 
-static void passthru_class_initfn(ObjectClass *klass, void *data)
+static void passthru_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
diff --git a/hw/usb/chipidea.c b/hw/usb/chipidea.c
index b1c85404d6f..250c2b3bca9 100644
--- a/hw/usb/chipidea.c
+++ b/hw/usb/chipidea.c
@@ -144,7 +144,7 @@ static void chipidea_init(Object *obj)
     }
 }
 
-static void chipidea_class_init(ObjectClass *klass, void *data)
+static void chipidea_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(klass);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 40f031252a7..26af709f314 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -997,7 +997,7 @@ static const Property usb_audio_properties[] = {
     DEFINE_PROP_BOOL("multi", USBAudioState, multi, false),
 };
 
-static void usb_audio_class_init(ObjectClass *klass, void *data)
+static void usb_audio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *k = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index accdd460e3b..54d064e54e1 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -774,7 +774,7 @@ static const VMStateDescription vmstate_usb_kbd = {
     }
 };
 
-static void usb_hid_class_initfn(ObjectClass *klass, void *data)
+static void usb_hid_class_initfn(ObjectClass *klass, const void *data)
 {
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
 
@@ -799,7 +799,7 @@ static const Property usb_tablet_properties[] = {
         DEFINE_PROP_UINT32("head", USBHIDState, head, 0),
 };
 
-static void usb_tablet_class_initfn(ObjectClass *klass, void *data)
+static void usb_tablet_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
@@ -821,7 +821,7 @@ static const Property usb_mouse_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
 };
 
-static void usb_mouse_class_initfn(ObjectClass *klass, void *data)
+static void usb_mouse_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
@@ -844,7 +844,7 @@ static const Property usb_keyboard_properties[] = {
         DEFINE_PROP_STRING("display", USBHIDState, display),
 };
 
-static void usb_keyboard_class_initfn(ObjectClass *klass, void *data)
+static void usb_keyboard_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 3880e2aca8e..a19350d9c42 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -670,7 +670,7 @@ static const Property usb_hub_properties[] = {
     DEFINE_PROP_BOOL("port-power", USBHubState, port_power, false),
 };
 
-static void usb_hub_class_initfn(ObjectClass *klass, void *data)
+static void usb_hub_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 326c92a43d0..cfb9f4d84cc 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2084,7 +2084,7 @@ static const Property mtp_properties[] = {
     DEFINE_PROP_BOOL("readonly", MTPState, readonly, true),
 };
 
-static void usb_mtp_class_initfn(ObjectClass *klass, void *data)
+static void usb_mtp_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index a87a0ffb955..81cc09dcac9 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1411,7 +1411,7 @@ static const Property net_properties[] = {
     DEFINE_NIC_PROPERTIES(USBNetState, conf),
 };
 
-static void usb_net_class_initfn(ObjectClass *klass, void *data)
+static void usb_net_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index aa50a92e26f..bef1382da06 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -639,7 +639,7 @@ static const Property serial_properties[] = {
     DEFINE_PROP_BOOL("always-plugged", USBSerialState, always_plugged, false),
 };
 
-static void usb_serial_dev_class_init(ObjectClass *klass, void *data)
+static void usb_serial_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
@@ -660,7 +660,7 @@ static const TypeInfo usb_serial_dev_type_info = {
     .class_init = usb_serial_dev_class_init,
 };
 
-static void usb_serial_class_initfn(ObjectClass *klass, void *data)
+static void usb_serial_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
@@ -680,7 +680,7 @@ static const Property braille_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
 };
 
-static void usb_braille_class_initfn(ObjectClass *klass, void *data)
+static void usb_braille_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 73deb3ce839..1bb4332238f 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1434,7 +1434,7 @@ static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
 };
 
-static void ccid_class_initfn(ObjectClass *klass, void *data)
+static void ccid_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
@@ -1465,7 +1465,7 @@ static const TypeInfo ccid_info = {
     }
 };
 
-static void ccid_card_class_init(ObjectClass *klass, void *data)
+static void ccid_card_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_type = TYPE_CCID_BUS;
diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index 1e5c5c711f5..df6ab7f656b 100644
--- a/hw/usb/dev-storage-bot.c
+++ b/hw/usb/dev-storage-bot.c
@@ -40,7 +40,7 @@ static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
     usb_msd_handle_reset(dev);
 }
 
-static void usb_msd_class_bot_initfn(ObjectClass *klass, void *data)
+static void usb_msd_class_bot_initfn(ObjectClass *klass, const void *data)
 {
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
 
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 56ef39da2e6..dabe1563593 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -74,7 +74,7 @@ static const Property msd_properties[] = {
     DEFINE_PROP_BOOL("commandlog", MSDState, commandlog, false),
 };
 
-static void usb_msd_class_storage_initfn(ObjectClass *klass, void *data)
+static void usb_msd_class_storage_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 4f1e8b7f6cb..b13fe345c45 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -585,7 +585,7 @@ static const VMStateDescription vmstate_usb_msd = {
     }
 };
 
-static void usb_msd_class_initfn_common(ObjectClass *klass, void *data)
+static void usb_msd_class_initfn_common(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 44e30013d73..acfc38cb062 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -957,7 +957,7 @@ static const Property uas_properties[] = {
     DEFINE_PROP_UINT32("log-scsi-req", UASDevice, requestlog, 0),
 };
 
-static void usb_uas_class_initfn(ObjectClass *klass, void *data)
+static void usb_uas_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 7177c17f031..f4b71a21472 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -420,7 +420,7 @@ static const VMStateDescription vmstate_usb_wacom = {
     .unmigratable = 1,
 };
 
-static void usb_wacom_class_init(ObjectClass *klass, void *data)
+static void usb_wacom_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index e8152719f8e..83864505bb8 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1452,7 +1452,7 @@ static const Property dwc2_usb_properties[] = {
     DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),
 };
 
-static void dwc2_class_init(ObjectClass *klass, void *data)
+static void dwc2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     DWC2Class *c = DWC2_USB_CLASS(klass);
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 9ce9ba0b046..c2c12e29afc 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -661,7 +661,7 @@ static const Property usb_dwc3_properties[] = {
                        0x12345678),
 };
 
-static void usb_dwc3_class_init(ObjectClass *klass, void *data)
+static void usb_dwc3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index e00316721ac..73122aa7971 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -150,7 +150,7 @@ static const VMStateDescription vmstate_ehci_pci = {
     }
 };
 
-static void ehci_class_init(ObjectClass *klass, void *data)
+static void ehci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -178,7 +178,7 @@ static const TypeInfo ehci_pci_type_info = {
     },
 };
 
-static void ehci_data_class_init(ObjectClass *klass, void *data)
+static void ehci_data_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 768c3dd797f..0449f5fa6d6 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -80,7 +80,7 @@ static void ehci_sysbus_finalize(Object *obj)
     usb_ehci_finalize(s);
 }
 
-static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
+static void ehci_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(klass);
@@ -95,7 +95,7 @@ static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static void ehci_platform_class_init(ObjectClass *oc, void *data)
+static void ehci_platform_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -105,7 +105,7 @@ static void ehci_platform_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
+static void ehci_exynos4210_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -115,7 +115,7 @@ static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
+static void ehci_aw_h3_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -125,7 +125,7 @@ static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
+static void ehci_npcm7xx_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -137,7 +137,7 @@ static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
+static void ehci_tegra2_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -154,7 +154,7 @@ static void ehci_ppc4xx_init(Object *o)
     s->ehci.companion_enable = true;
 }
 
-static void ehci_ppc4xx_class_init(ObjectClass *oc, void *data)
+static void ehci_ppc4xx_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -220,7 +220,7 @@ static void fusbh200_ehci_init(Object *obj)
                                 &f->mem_vendor);
 }
 
-static void fusbh200_ehci_class_init(ObjectClass *oc, void *data)
+static void fusbh200_ehci_class_init(ObjectClass *oc, const void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index b3684a2ef6b..3c82525a1e4 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -126,7 +126,7 @@ static const VMStateDescription vmstate_ohci = {
     }
 };
 
-static void ohci_pci_class_init(ObjectClass *klass, void *data)
+static void ohci_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 15311949b39..3fc6cce44b0 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -64,7 +64,7 @@ static const Property ohci_sysbus_properties[] = {
     DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
 };
 
-static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
+static void ohci_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 0561a6d801a..2b1aee1f21f 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1260,7 +1260,7 @@ static const Property uhci_properties_standalone[] = {
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
 };
 
-static void uhci_class_init(ObjectClass *klass, void *data)
+static void uhci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -1284,7 +1284,7 @@ static const TypeInfo uhci_pci_type_info = {
     },
 };
 
-void uhci_data_class_init(ObjectClass *klass, void *data)
+void uhci_data_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 1df518baf59..9e0fea26f40 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -50,7 +50,7 @@ static void nec_xhci_instance_init(Object *obj)
     pci->xhci.numslots = nec->slots;
 }
 
-static void nec_xhci_class_init(ObjectClass *klass, void *data)
+static void nec_xhci_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 49642aab58e..cc5c4e600e0 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -203,7 +203,7 @@ static const Property xhci_pci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
 };
 
-static void xhci_class_init(ObjectClass *klass, void *data)
+static void xhci_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -231,7 +231,7 @@ static const TypeInfo xhci_pci_info = {
     },
 };
 
-static void qemu_xhci_class_init(ObjectClass *klass, void *data)
+static void qemu_xhci_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index ce433223963..244698e5f2b 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -96,7 +96,7 @@ static const VMStateDescription vmstate_xhci_sysbus = {
     }
 };
 
-static void xhci_sysbus_class_init(ObjectClass *klass, void *data)
+static void xhci_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 00d5bc37792..32c665c4c4a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3637,7 +3637,7 @@ static const Property xhci_properties[] = {
                      DeviceState *),
 };
 
-static void xhci_class_init(ObjectClass *klass, void *data)
+static void xhci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c3d642c9d37..b74670ae256 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1781,7 +1781,7 @@ static const Property usb_host_dev_properties[] = {
                      suppress_remote_wake, true),
 };
 
-static void usb_host_class_initfn(ObjectClass *klass, void *data)
+static void usb_host_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/imx-usb-phy.c b/hw/usb/imx-usb-phy.c
index f519250567d..c25566d0fae 100644
--- a/hw/usb/imx-usb-phy.c
+++ b/hw/usb/imx-usb-phy.c
@@ -214,7 +214,7 @@ static void imx_usbphy_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-static void imx_usbphy_class_init(ObjectClass *klass, void *data)
+static void imx_usbphy_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index f3a83b3f4c9..f516ff42a11 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2582,7 +2582,7 @@ static const Property usbredir_properties[] = {
                      suppress_remote_wake, true),
 };
 
-static void usbredir_class_initfn(ObjectClass *klass, void *data)
+static void usbredir_class_initfn(ObjectClass *klass, const void *data)
 {
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index e1dd19ee92b..ace5eceadd9 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -377,7 +377,7 @@ static const Property u2f_emulated_properties[] = {
     DEFINE_PROP_STRING("counter", U2FEmulatedState, counter),
 };
 
-static void u2f_emulated_class_init(ObjectClass *klass, void *data)
+static void u2f_emulated_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     U2FKeyClass *kc = U2F_KEY_CLASS(klass);
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index 8df5215a1fa..fa8d9cdda89 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -520,7 +520,7 @@ static const Property u2f_passthru_properties[] = {
     DEFINE_PROP_STRING("hidraw", U2FPassthruState, hidraw),
 };
 
-static void u2f_passthru_class_init(ObjectClass *klass, void *data)
+static void u2f_passthru_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     U2FKeyClass *kc = U2F_KEY_CLASS(klass);
diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index 1fb59cf404f..b051a999d3a 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -317,7 +317,7 @@ const VMStateDescription vmstate_u2f_key = {
     }
 };
 
-static void u2f_key_class_init(ObjectClass *klass, void *data)
+static void u2f_key_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
diff --git a/hw/usb/xlnx-usb-subsystem.c b/hw/usb/xlnx-usb-subsystem.c
index d8deeb6ced5..98967ef49f1 100644
--- a/hw/usb/xlnx-usb-subsystem.c
+++ b/hw/usb/xlnx-usb-subsystem.c
@@ -69,7 +69,7 @@ static void versal_usb2_init(Object *obj)
     object_property_add_alias(obj, "dma", OBJECT(&s->dwc3.sysbus_xhci), "dma");
 }
 
-static void versal_usb2_class_init(ObjectClass *klass, void *data)
+static void versal_usb2_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/usb/xlnx-versal-usb2-ctrl-regs.c b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
index 66c793a6021..4114672d4f4 100644
--- a/hw/usb/xlnx-versal-usb2-ctrl-regs.c
+++ b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
@@ -202,7 +202,7 @@ static const VMStateDescription vmstate_usb2_ctrl_regs = {
     }
 };
 
-static void usb2_ctrl_regs_class_init(ObjectClass *klass, void *data)
+static void usb2_ctrl_regs_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 96bd608b8dd..f3bc7d98c79 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -32,7 +32,7 @@ static const VMStateDescription vfio_platform_amd_xgbe_vmstate = {
     .unmigratable = 1,
 };
 
-static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
+static void vfio_amd_xgbe_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VFIOAmdXgbeDeviceClass *vcxc =
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 30b08ad375d..80e08c02063 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -241,7 +241,7 @@ static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
-static void vfio_ap_class_init(ObjectClass *klass, void *data)
+static void vfio_ap_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 87c382e7361..c1404889e65 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -32,7 +32,7 @@ static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate = {
     .unmigratable = 1,
 };
 
-static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
+static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VFIOCalxedaXgmacDeviceClass *vcxc =
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 67bc137f9be..8583b8cbaa8 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -697,7 +697,7 @@ static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
-static void vfio_ccw_class_init(ObjectClass *klass, void *data)
+static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4ebb5268088..faeaf8afaba 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1123,7 +1123,7 @@ out_single:
     return ret;
 }
 
-static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
+static void vfio_iommu_legacy_class_init(ObjectClass *klass, const void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
@@ -1187,7 +1187,7 @@ static void vfio_iommu_legacy_instance_init(Object *obj)
     QLIST_INIT(&container->group_list);
 }
 
-static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
+static void hiod_legacy_vfio_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0740a5dd8cc..ebeceaadcd9 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -248,7 +248,8 @@ static void vfio_pci_igd_lpc_bridge_realize(PCIDevice *pdev, Error **errp)
     }
 }
 
-static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
+static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass,
+                                               const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3490a8f1eb8..902b69997ec 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -786,7 +786,7 @@ out_single:
     return ret;
 }
 
-static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
+static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
@@ -846,7 +846,7 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 }
 
 
-static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
+static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9a55e7b7732..5f3d7d044f3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3417,7 +3417,7 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
-static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
+static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -3455,7 +3455,8 @@ static const Property vfio_pci_dev_nohotplug_properties[] = {
                             ON_OFF_AUTO_AUTO),
 };
 
-static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
+static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
+                                              const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 1070a2113a1..d3f6afd2dac 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -658,7 +658,7 @@ static void vfio_platform_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
-static void vfio_platform_class_init(ObjectClass *klass, void *data)
+static void vfio_platform_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index ad4c499eafe..0df9add322f 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -536,7 +536,7 @@ listener_unregister_exit:
     return false;
 }
 
-static void vfio_iommu_spapr_class_init(ObjectClass *klass, void *data)
+static void vfio_iommu_spapr_class_init(ObjectClass *klass, const void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
diff --git a/hw/virtio/vdpa-dev-pci.c b/hw/virtio/vdpa-dev-pci.c
index 787926801a1..30681121465 100644
--- a/hw/virtio/vdpa-dev-pci.c
+++ b/hw/virtio/vdpa-dev-pci.c
@@ -70,7 +70,8 @@ vhost_vdpa_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(DEVICE(&dev->vdev), BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_vdpa_device_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_vdpa_device_pci_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index a7e73b1c992..dd8837ce4e9 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -353,7 +353,7 @@ static const VMStateDescription vmstate_vhost_vdpa_device = {
     },
 };
 
-static void vhost_vdpa_device_class_init(ObjectClass *klass, void *data)
+static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 3778f6131ef..7399acef8e2 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -61,7 +61,7 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_scsi_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_scsi_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 2bc3423326e..77143320a23 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -348,7 +348,7 @@ static void vub_device_unrealize(DeviceState *dev)
     do_vhost_user_cleanup(vdev, vub);
 }
 
-static void vub_class_init(ObjectClass *klass, void *data)
+static void vub_class_init(ObjectClass *klass, const void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 1767ef2c9c9..904369f5a3d 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -65,7 +65,7 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_blk_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index efaf55d3dd4..f10bac874e7 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -31,7 +31,8 @@ static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_device_pci_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 86eba138b4e..3939bdf7552 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -37,7 +37,7 @@ static const Property vud_properties[] = {
     DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
 };
 
-static void vud_class_init(ObjectClass *klass, void *data)
+static void vud_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 116eaab9071..1490c118bca 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -47,7 +47,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_fs_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_fs_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 3f00d79ed01..315931dbefa 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -419,7 +419,7 @@ static void vuf_instance_init(Object *obj)
                                   "/filesystem@0", DEVICE(obj));
 }
 
-static void vuf_class_init(ObjectClass *klass, void *data)
+static void vuf_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-gpio-pci.c b/hw/virtio/vhost-user-gpio-pci.c
index b3028a24a19..9b165b54f8f 100644
--- a/hw/virtio/vhost-user-gpio-pci.c
+++ b/hw/virtio/vhost-user-gpio-pci.c
@@ -32,7 +32,7 @@ static void vhost_user_gpio_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_gpio_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_gpio_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index 4a08814904d..a7fd49b10a3 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -36,7 +36,7 @@ static const VMStateDescription vu_gpio_vmstate = {
     .unmigratable = 1,
 };
 
-static void vu_gpio_class_init(ObjectClass *klass, void *data)
+static void vu_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-i2c-pci.c b/hw/virtio/vhost-user-i2c-pci.c
index 00ac10941fa..692cd66fde6 100644
--- a/hw/virtio/vhost-user-i2c-pci.c
+++ b/hw/virtio/vhost-user-i2c-pci.c
@@ -32,7 +32,7 @@ static void vhost_user_i2c_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_i2c_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_i2c_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index 1c7cde503c3..ae007fe97d9 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -36,7 +36,7 @@ static const VMStateDescription vu_i2c_vmstate = {
     .unmigratable = 1,
 };
 
-static void vu_i2c_class_init(ObjectClass *klass, void *data)
+static void vu_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 917405329f2..5cfc5bbb564 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -30,7 +30,7 @@ static const VMStateDescription vmstate_vhost_input = {
     .unmigratable = 1,
 };
 
-static void vhost_input_class_init(ObjectClass *klass, void *data)
+static void vhost_input_class_init(ObjectClass *klass, const void *data)
 {
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-rng-pci.c b/hw/virtio/vhost-user-rng-pci.c
index a4e690148d6..9f45fc6f355 100644
--- a/hw/virtio/vhost-user-rng-pci.c
+++ b/hw/virtio/vhost-user-rng-pci.c
@@ -40,7 +40,7 @@ static void vhost_user_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_rng_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_rng_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 5aa432e5e1a..61dadcda054 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -37,7 +37,7 @@ static void vu_rng_base_realize(DeviceState *dev, Error **errp)
     vubs->parent_realize(dev, errp);
 }
 
-static void vu_rng_class_init(ObjectClass *klass, void *data)
+static void vu_rng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-scmi-pci.c b/hw/virtio/vhost-user-scmi-pci.c
index 7f53af7fced..0ab56a50bb3 100644
--- a/hw/virtio/vhost-user-scmi-pci.c
+++ b/hw/virtio/vhost-user-scmi-pci.c
@@ -31,7 +31,7 @@ static void vhost_user_scmi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_scmi_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_scmi_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 410a936ca74..5a341b5381c 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -281,7 +281,7 @@ static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
 };
 
-static void vu_scmi_class_init(ObjectClass *klass, void *data)
+static void vu_scmi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 4a4128d961b..994e51a37bb 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -67,7 +67,7 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_scsi_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
index 0cb86b7d85d..f5015fb6c4e 100644
--- a/hw/virtio/vhost-user-snd-pci.c
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -33,7 +33,7 @@ static void vhost_user_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_snd_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_snd_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 8610370af80..bdbd0956dc2 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -38,7 +38,7 @@ static void vu_snd_base_realize(DeviceState *dev, Error **errp)
     vubs->parent_realize(dev, errp);
 }
 
-static void vu_snd_class_init(ObjectClass *klass, void *data)
+static void vu_snd_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index f730a05e781..adb877b6e05 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -46,7 +46,8 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_user_vsock_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_user_vsock_pci_class_init(ObjectClass *klass,
+                                            const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 293273080b4..63d572ce3da 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -152,7 +152,7 @@ static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
 };
 
-static void vuv_class_init(ObjectClass *klass, void *data)
+static void vuv_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 9ac587d20c1..4b4fbb45ccd 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -290,7 +290,7 @@ static const Property vhost_vsock_common_properties[] = {
                             ON_OFF_AUTO_AUTO),
 };
 
-static void vhost_vsock_common_class_init(ObjectClass *klass, void *data)
+static void vhost_vsock_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 6c618ee9083..0022a713d43 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -56,7 +56,7 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void vhost_vsock_pci_class_init(ObjectClass *klass, void *data)
+static void vhost_vsock_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 940b30fa27c..b73dc723c29 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -210,7 +210,7 @@ static const Property vhost_vsock_properties[] = {
     DEFINE_PROP_STRING("vhostfd", VHostVSock, conf.vhostfd),
 };
 
-static void vhost_vsock_class_init(ObjectClass *klass, void *data)
+static void vhost_vsock_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index aa1dce8f284..594742ff656 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -49,7 +49,7 @@ static const Property virtio_9p_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
 };
 
-static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_9p_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index db7e1cb4753..96e88b6b86d 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -55,7 +55,7 @@ static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_balloon_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ad05768dedc..3829cf980f0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1034,7 +1034,7 @@ static const Property virtio_balloon_properties[] = {
                      IOThread *),
 };
 
-static void virtio_balloon_class_init(ObjectClass *klass, void *data)
+static void virtio_balloon_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index fc06cec6566..fd33bbd7e83 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -63,7 +63,7 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_blk_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 896feb37a1c..1a963a71e9a 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -348,7 +348,7 @@ bool virtio_bus_device_iommu_enabled(VirtIODevice *vdev)
     return klass->iommu_enabled(qbus->parent);
 }
 
-static void virtio_bus_class_init(ObjectClass *klass, void *data)
+static void virtio_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *bus_class = BUS_CLASS(klass);
     bus_class->get_dev_path = virtio_bus_get_dev_path;
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 8699481375d..868abc03a9e 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -59,7 +59,7 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 }
 
-static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_crypto_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index a1b3c90618a..e24d6914b63 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1264,7 +1264,7 @@ static struct vhost_dev *virtio_crypto_get_vhost(VirtIODevice *vdev)
     return &vhost_crypto->dev;
 }
 
-static void virtio_crypto_class_init(ObjectClass *klass, void *data)
+static void virtio_crypto_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 9e3c1067776..3be5358b4cd 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -50,7 +50,7 @@ static void virtio_input_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_input_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_input_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
@@ -63,7 +63,8 @@ static void virtio_input_pci_class_init(ObjectClass *klass, void *data)
     pcidev_k->class_id = PCI_CLASS_INPUT_OTHER;
 }
 
-static void virtio_input_hid_kbd_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_input_hid_kbd_pci_class_init(ObjectClass *klass,
+                                                const void *data)
 {
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
@@ -71,7 +72,7 @@ static void virtio_input_hid_kbd_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static void virtio_input_hid_mouse_pci_class_init(ObjectClass *klass,
-                                                  void *data)
+                                                  const void *data)
 {
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 97e03ce803b..8123c6f83a3 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -73,7 +73,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_iommu_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index f41104a9523..cf800881538 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1664,7 +1664,7 @@ static const Property virtio_iommu_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
 };
 
-static void virtio_iommu_class_init(ObjectClass *klass, void *data)
+static void virtio_iommu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
@@ -1684,7 +1684,7 @@ static void virtio_iommu_class_init(ObjectClass *klass, void *data)
 }
 
 static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
-                                                  void *data)
+                                                  const void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 6cc5f0fd3b8..f592eb1a784 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -163,7 +163,7 @@ static const Property virtio_mem_pci_class_properties[] = {
                        DEV_NVECTORS_UNSPECIFIED),
 };
 
-static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_mem_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b1a003736b0..9fc05a11da0 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1867,7 +1867,7 @@ static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
     }
 }
 
-static void virtio_mem_class_init(ObjectClass *klass, void *data)
+static void virtio_mem_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
@@ -1959,7 +1959,8 @@ static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
     virtio_mem_unplug_all(vmem);
 }
 
-static void virtio_mem_system_reset_class_init(ObjectClass *klass, void *data)
+static void virtio_mem_system_reset_class_init(ObjectClass *klass,
+                                               const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 029817139bd..532c67107ba 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -784,7 +784,7 @@ static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
     sysbus_init_mmio(sbd, &proxy->iomem);
 }
 
-static void virtio_mmio_class_init(ObjectClass *klass, void *data)
+static void virtio_mmio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -855,7 +855,7 @@ static void virtio_mmio_vmstate_change(DeviceState *d, bool running)
     }
 }
 
-static void virtio_mmio_bus_class_init(ObjectClass *klass, void *data)
+static void virtio_mmio_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *bus_class = BUS_CLASS(klass);
     VirtioBusClass *k = VIRTIO_BUS_CLASS(klass);
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e18953ad674..8cf9788bc3e 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -63,7 +63,7 @@ static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-nsm-pci.c b/hw/virtio/virtio-nsm-pci.c
index dca797315a4..ec243963e1e 100644
--- a/hw/virtio/virtio-nsm-pci.c
+++ b/hw/virtio/virtio-nsm-pci.c
@@ -40,7 +40,7 @@ static void virtio_nsm_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 }
 
-static void virtio_nsm_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_nsm_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index 098e1aeac6e..492279e974d 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1709,7 +1709,7 @@ static const Property virtio_nsm_properties[] = {
     DEFINE_PROP_STRING("module-id", VirtIONSM, module_id),
 };
 
-static void virtio_nsm_class_init(ObjectClass *klass, void *data)
+static void virtio_nsm_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c773a9130c7..acb49a6a330 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2402,7 +2402,7 @@ static int virtio_pci_sync_config(DeviceState *dev, Error **errp)
     return qdev_sync_config(DEVICE(vdev), errp);
 }
 
-static void virtio_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -2436,7 +2436,7 @@ static const Property virtio_pci_generic_properties[] = {
     DEFINE_PROP_BOOL("disable-modern", VirtIOPCIProxy, disable_modern, false),
 };
 
-static void virtio_pci_base_class_init(ObjectClass *klass, void *data)
+static void virtio_pci_base_class_init(ObjectClass *klass, const void *data)
 {
     const VirtioPCIDeviceTypeInfo *t = data;
     if (t->class_init) {
@@ -2444,7 +2444,7 @@ static void virtio_pci_base_class_init(ObjectClass *klass, void *data)
     }
 }
 
-static void virtio_pci_generic_class_init(ObjectClass *klass, void *data)
+static void virtio_pci_generic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -2589,7 +2589,7 @@ static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
     qbus_init(bus, bus_size, TYPE_VIRTIO_PCI_BUS, qdev, virtio_bus_name);
 }
 
-static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
+static void virtio_pci_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *bus_class = BUS_CLASS(klass);
     VirtioBusClass *k = VIRTIO_BUS_CLASS(klass);
diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
index cfe7f3b67ca..babd91c21f0 100644
--- a/hw/virtio/virtio-pmem-pci.c
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -80,7 +80,7 @@ static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
     info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
 }
 
-static void virtio_pmem_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_pmem_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index adb3268bd46..3416ea1827c 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -161,7 +161,7 @@ static const Property virtio_pmem_properties[] = {
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
 };
 
-static void virtio_pmem_class_init(ObjectClass *klass, void *data)
+static void virtio_pmem_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index a94ff767b2d..39b600356ea 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -53,7 +53,7 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 }
 
-static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_rng_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index a515fc5cd9b..dcb3c71d6ae 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -260,7 +260,7 @@ static const Property virtio_rng_properties[] = {
     DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND, RngBackend *),
 };
 
-static void virtio_rng_class_init(ObjectClass *klass, void *data)
+static void virtio_rng_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index d44fd2fffbe..af877592070 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -72,7 +72,7 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static void virtio_scsi_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_scsi_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index b5b77eb2661..3f212ffe52f 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -76,7 +76,7 @@ static const Property virtio_serial_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
 };
 
-static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_serial_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce374..a8756ed32cb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4140,7 +4140,7 @@ void virtio_device_release_ioeventfd(VirtIODevice *vdev)
     virtio_bus_release_ioeventfd(vbus);
 }
 
-static void virtio_device_class_init(ObjectClass *klass, void *data)
+static void virtio_device_class_init(ObjectClass *klass, const void *data)
 {
     /* Set the default value here. */
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index 1bfec41ff8b..71e5eaa0833 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -348,7 +348,7 @@ static void allwinner_wdt_realize(DeviceState *dev, Error **errp)
     ptimer_transaction_commit(s->timer);
 }
 
-static void allwinner_wdt_class_init(ObjectClass *klass, void *data)
+static void allwinner_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -358,7 +358,7 @@ static void allwinner_wdt_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &allwinner_wdt_vmstate;
 }
 
-static void allwinner_wdt_sun4i_class_init(ObjectClass *klass, void *data)
+static void allwinner_wdt_sun4i_class_init(ObjectClass *klass, const void *data)
 {
     AwWdtClass *awc = AW_WDT_CLASS(klass);
 
@@ -371,7 +371,7 @@ static void allwinner_wdt_sun4i_class_init(ObjectClass *klass, void *data)
     awc->get_intv_value = allwinner_wdt_sun4i_get_intv_value;
 }
 
-static void allwinner_wdt_sun6i_class_init(ObjectClass *klass, void *data)
+static void allwinner_wdt_sun6i_class_init(ObjectClass *klass, const void *data)
 {
     AwWdtClass *awc = AW_WDT_CLASS(klass);
 
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index a52121dc44f..6a8d07ca569 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -394,7 +394,7 @@ static const VMStateDescription cmsdk_apb_watchdog_vmstate = {
     }
 };
 
-static void cmsdk_apb_watchdog_class_init(ObjectClass *klass, void *data)
+static void cmsdk_apb_watchdog_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 65ac42a1870..92bca90d65b 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -272,7 +272,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
                        62500000),
 };
 
-static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
+static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 2bb1d3c5325..5b3f50de3a1 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -249,7 +249,7 @@ static void spapr_wdt_realize(DeviceState *dev, Error **errp)
                                   &w->leave_others, OBJ_PROP_FLAG_READ);
 }
 
-static void spapr_wdt_class_init(ObjectClass *oc, void *data)
+static void spapr_wdt_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index d94b83c1093..318894c12b2 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -308,7 +308,7 @@ static const Property aspeed_wdt_properties[] = {
                      AspeedSCUState *),
 };
 
-static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
+static void aspeed_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -330,7 +330,7 @@ static const TypeInfo aspeed_wdt_info = {
     .abstract      = true,
 };
 
-static void aspeed_2400_wdt_class_init(ObjectClass *klass, void *data)
+static void aspeed_2400_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
@@ -367,7 +367,7 @@ static void aspeed_2500_wdt_reset_pulse(AspeedWDTState *s, uint32_t property)
     }
 }
 
-static void aspeed_2500_wdt_class_init(ObjectClass *klass, void *data)
+static void aspeed_2500_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
@@ -390,7 +390,7 @@ static const TypeInfo aspeed_2500_wdt_info = {
     .class_init = aspeed_2500_wdt_class_init,
 };
 
-static void aspeed_2600_wdt_class_init(ObjectClass *klass, void *data)
+static void aspeed_2600_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
@@ -413,7 +413,7 @@ static const TypeInfo aspeed_2600_wdt_info = {
     .class_init = aspeed_2600_wdt_class_init,
 };
 
-static void aspeed_1030_wdt_class_init(ObjectClass *klass, void *data)
+static void aspeed_1030_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
@@ -436,7 +436,7 @@ static const TypeInfo aspeed_1030_wdt_info = {
     .class_init = aspeed_1030_wdt_class_init,
 };
 
-static void aspeed_2700_wdt_class_init(ObjectClass *klass, void *data)
+static void aspeed_2700_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 39f2894f216..1275353e8e5 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -108,7 +108,7 @@ static void wdt_diag288_unrealize(DeviceState *dev)
     timer_free(diag288->timer);
 }
 
-static void wdt_diag288_class_init(ObjectClass *klass, void *data)
+static void wdt_diag288_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     DIAG288Class *diag288 = DIAG288_CLASS(klass);
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index aa1d0866c89..1536e1fe032 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -457,7 +457,7 @@ static void i6300esb_exit(PCIDevice *dev)
     timer_free(d->timer);
 }
 
-static void i6300esb_class_init(ObjectClass *klass, void *data)
+static void i6300esb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index 23519e058e3..51a26a4cbbc 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -128,7 +128,7 @@ static void wdt_ib700_reset(DeviceState *dev)
     timer_del(s->timer);
 }
 
-static void wdt_ib700_class_init(ObjectClass *klass, void *data)
+static void wdt_ib700_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 18e40bd4664..10151a15d08 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -286,7 +286,7 @@ static const Property imx2_wdt_properties[] = {
                      false),
 };
 
-static void imx2_wdt_class_init(ObjectClass *klass, void *data)
+static void imx2_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 8260f1e1bbf..435e03a1e72 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -380,7 +380,7 @@ static void xen_bus_unplug_request(HotplugHandler *hotplug,
     xen_device_unplug(xendev, errp);
 }
 
-static void xen_bus_class_init(ObjectClass *class, void *data)
+static void xen_bus_class_init(ObjectClass *class, const void *data)
 {
     BusClass *bus_class = BUS_CLASS(class);
     HotplugHandlerClass *hotplug_class = HOTPLUG_HANDLER_CLASS(class);
@@ -1107,7 +1107,7 @@ static const Property xen_device_props[] = {
                        DOMID_INVALID),
 };
 
-static void xen_device_class_init(ObjectClass *class, void *data)
+static void xen_device_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
 
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 118c571b3a7..938dd8fb28f 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -635,7 +635,7 @@ int xen_be_bind_evtchn(struct XenLegacyDevice *xendev)
 }
 
 
-static void xendev_class_init(ObjectClass *klass, void *data)
+static void xendev_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -652,7 +652,7 @@ static const TypeInfo xendev_type_info = {
     .instance_size = sizeof(struct XenLegacyDevice),
 };
 
-static void xen_sysbus_class_init(ObjectClass *klass, void *data)
+static void xen_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 9c21fa858d3..8d6c3813f6c 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -370,7 +370,7 @@ do {                                                                      \
 #endif
 }
 
-static void xen_pvh_class_init(ObjectClass *oc, void *data)
+static void xen_pvh_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index e2bd4c7d411..d9f1ddd25c6 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -987,7 +987,7 @@ static void xen_igd_clear_slot(DeviceState *qdev, Error **errp)
     xpdc->pci_qdev_realize(qdev, errp);
 }
 
-static void xen_pci_passthrough_class_init(ObjectClass *klass, void *data)
+static void xen_pci_passthrough_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 6c2e3f4840f..264851ece36 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -347,7 +347,7 @@ static const IGDDeviceIDInfo igd_combo_id_infos[] = {
     {0x162D, 0x9cc3, 0x03}, /* BDWGT3SRVR, BDWM_w7 */
 };
 
-static void isa_bridge_class_init(ObjectClass *klass, void *data)
+static void isa_bridge_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3f3677f1c9a..7c5132e31ec 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -585,7 +585,7 @@ static void xtfpga_kc705_nommu_init(MachineState *machine)
     xtfpga_init(&kc705_board, machine);
 }
 
-static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
+static void xtfpga_lx60_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -602,7 +602,7 @@ static const TypeInfo xtfpga_lx60_type = {
     .class_init = xtfpga_lx60_class_init,
 };
 
-static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
+static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -619,7 +619,7 @@ static const TypeInfo xtfpga_lx60_nommu_type = {
     .class_init = xtfpga_lx60_nommu_class_init,
 };
 
-static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
+static void xtfpga_lx200_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -636,7 +636,7 @@ static const TypeInfo xtfpga_lx200_type = {
     .class_init = xtfpga_lx200_class_init,
 };
 
-static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
+static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -653,7 +653,7 @@ static const TypeInfo xtfpga_lx200_nommu_type = {
     .class_init = xtfpga_lx200_nommu_class_init,
 };
 
-static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
+static void xtfpga_ml605_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -670,7 +670,7 @@ static const TypeInfo xtfpga_ml605_type = {
     .class_init = xtfpga_ml605_class_init,
 };
 
-static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
+static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -687,7 +687,7 @@ static const TypeInfo xtfpga_ml605_nommu_type = {
     .class_init = xtfpga_ml605_nommu_class_init,
 };
 
-static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
+static void xtfpga_kc705_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -704,7 +704,7 @@ static const TypeInfo xtfpga_kc705_type = {
     .class_init = xtfpga_kc705_class_init,
 };
 
-static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
+static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 8096180f855..189fa67ac21 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -225,7 +225,7 @@ static GSource *qio_channel_buffer_create_watch(QIOChannel *ioc,
 
 
 static void qio_channel_buffer_class_init(ObjectClass *klass,
-                                          void *class_data G_GNUC_UNUSED)
+                                          const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/io/channel-command.c b/io/channel-command.c
index 6d5f64e146d..8966dd3a2ba 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -358,7 +358,7 @@ static GSource *qio_channel_command_create_watch(QIOChannel *ioc,
 
 
 static void qio_channel_command_class_init(ObjectClass *klass,
-                                           void *class_data G_GNUC_UNUSED)
+                                           const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/io/channel-file.c b/io/channel-file.c
index 2ea8d083600..ca3f180cc2f 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -290,7 +290,7 @@ static GSource *qio_channel_file_create_watch(QIOChannel *ioc,
 }
 
 static void qio_channel_file_class_init(ObjectClass *klass,
-                                        void *class_data G_GNUC_UNUSED)
+                                        const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/io/channel-null.c b/io/channel-null.c
index ef995863483..49f1c80a54e 100644
--- a/io/channel-null.c
+++ b/io/channel-null.c
@@ -207,7 +207,7 @@ qio_channel_null_create_watch(QIOChannel *ioc,
 
 static void
 qio_channel_null_class_init(ObjectClass *klass,
-                            void *class_data G_GNUC_UNUSED)
+                            const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066ec..088b49ffdb0 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -949,7 +949,7 @@ static GSource *qio_channel_socket_create_watch(QIOChannel *ioc,
 }
 
 static void qio_channel_socket_class_init(ObjectClass *klass,
-                                          void *class_data G_GNUC_UNUSED)
+                                          const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index aab630e5ae3..455c530dd0e 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -475,7 +475,7 @@ qio_channel_tls_get_session(QIOChannelTLS *ioc)
 }
 
 static void qio_channel_tls_class_init(ObjectClass *klass,
-                                       void *class_data G_GNUC_UNUSED)
+                                       const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 55192b770a3..08ddb274f0c 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -1308,7 +1308,7 @@ static GSource *qio_channel_websock_create_watch(QIOChannel *ioc,
 }
 
 static void qio_channel_websock_class_init(ObjectClass *klass,
-                                           void *class_data G_GNUC_UNUSED)
+                                           const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/iothread.c b/iothread.c
index 589bcd35523..8810376dcea 100644
--- a/iothread.c
+++ b/iothread.c
@@ -292,7 +292,7 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
     }
 }
 
-static void iothread_class_init(ObjectClass *klass, void *class_data)
+static void iothread_class_init(ObjectClass *klass, const void *class_data)
 {
     EventLoopBaseClass *bc = EVENT_LOOP_BASE_CLASS(klass);
 
diff --git a/migration/channel-block.c b/migration/channel-block.c
index fff8d870942..dd99c3c7a16 100644
--- a/migration/channel-block.c
+++ b/migration/channel-block.c
@@ -170,7 +170,7 @@ qio_channel_block_set_aio_fd_handler(QIOChannel *ioc,
 
 static void
 qio_channel_block_class_init(ObjectClass *klass,
-                             void *class_data G_GNUC_UNUSED)
+                             const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/migration/migration.c b/migration/migration.c
index 396928513ab..0382d4c5ea8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3954,7 +3954,7 @@ fail:
     migrate_fd_cleanup(s);
 }
 
-static void migration_class_init(ObjectClass *klass, void *data)
+static void migration_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 855753c6719..2944f2c9db8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3985,7 +3985,7 @@ static void qio_channel_rdma_finalize(Object *obj)
 }
 
 static void qio_channel_rdma_class_init(ObjectClass *klass,
-                                        void *class_data G_GNUC_UNUSED)
+                                        const void *class_data G_GNUC_UNUSED)
 {
     QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
 
diff --git a/net/can/can_core.c b/net/can/can_core.c
index 0115d787941..e16e15c036e 100644
--- a/net/can/can_core.c
+++ b/net/can/can_core.c
@@ -149,7 +149,7 @@ static bool can_bus_can_be_deleted(UserCreatable *uc)
 }
 
 static void can_bus_class_init(ObjectClass *klass,
-                                void *class_data G_GNUC_UNUSED)
+                               const void *class_data G_GNUC_UNUSED)
 {
     UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
 
diff --git a/net/can/can_host.c b/net/can/can_host.c
index b2fe553f91a..ca5fcf1ea12 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -72,7 +72,7 @@ static void can_host_complete(UserCreatable *uc, Error **errp)
 }
 
 static void can_host_class_init(ObjectClass *klass,
-                                void *class_data G_GNUC_UNUSED)
+                                const void *class_data G_GNUC_UNUSED)
 {
     UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
 
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index c1a1ad05636..8a57ae07178 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -308,7 +308,7 @@ static void can_host_socketcan_instance_init(Object *obj)
 }
 
 static void can_host_socketcan_class_init(ObjectClass *klass,
-                                          void *class_data G_GNUC_UNUSED)
+                                          const void *class_data G_GNUC_UNUSED)
 {
     CanHostClass *chc = CAN_HOST_CLASS(klass);
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 165610bfe24..7e5f6e09dba 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1354,7 +1354,7 @@ static void colo_flush_packets(void *opaque, void *user_data)
     }
 }
 
-static void colo_compare_class_init(ObjectClass *oc, void *data)
+static void colo_compare_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/net/dump.c b/net/dump.c
index 140215aa105..581234b7751 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -234,7 +234,7 @@ static void filter_dump_instance_finalize(Object *obj)
     g_free(nfds->filename);
 }
 
-static void filter_dump_class_init(ObjectClass *oc, void *data)
+static void filter_dump_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 283dc9cbe6b..a36be31dc8e 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -172,7 +172,7 @@ static void filter_buffer_set_interval(Object *obj, Visitor *v,
     s->interval = value;
 }
 
-static void filter_buffer_class_init(ObjectClass *oc, void *data)
+static void filter_buffer_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 34a63b5dbbf..27734c91a71 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -410,7 +410,7 @@ static void filter_redirector_set_vnet_hdr(Object *obj,
     s->vnet_hdr = value;
 }
 
-static void filter_mirror_class_init(ObjectClass *oc, void *data)
+static void filter_mirror_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
@@ -425,7 +425,7 @@ static void filter_mirror_class_init(ObjectClass *oc, void *data)
     nfc->receive_iov = filter_mirror_receive_iov;
 }
 
-static void filter_redirector_class_init(ObjectClass *oc, void *data)
+static void filter_redirector_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
diff --git a/net/filter-replay.c b/net/filter-replay.c
index 81b71afe357..451663c5a56 100644
--- a/net/filter-replay.c
+++ b/net/filter-replay.c
@@ -65,7 +65,7 @@ static void filter_replay_instance_finalize(Object *obj)
     replay_unregister_net(nfrs->rns);
 }
 
-static void filter_replay_class_init(ObjectClass *oc, void *data)
+static void filter_replay_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index c18c4c20190..cdf85aa5eed 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -411,7 +411,7 @@ static void filter_rewriter_init(Object *obj)
     s->failover_mode = FAILOVER_MODE_OFF;
 }
 
-static void colo_rewriter_class_init(ObjectClass *oc, void *data)
+static void colo_rewriter_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
diff --git a/net/filter.c b/net/filter.c
index 33359087711..03b3c793f76 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -333,7 +333,7 @@ static void default_handle_event(NetFilterState *nf, int event, Error **errp)
     }
 }
 
-static void netfilter_class_init(ObjectClass *oc, void *data)
+static void netfilter_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
diff --git a/qom/object.c b/qom/object.c
index dfd59502d11..06d7367032e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -54,7 +54,7 @@ struct TypeImpl
     size_t instance_size;
     size_t instance_align;
 
-    void (*class_init)(ObjectClass *klass, void *data);
+    void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
 
     void *class_data;
@@ -2891,7 +2891,7 @@ void object_class_property_set_description(ObjectClass *klass,
     op->description = g_strdup(description);
 }
 
-static void object_class_init(ObjectClass *klass, void *data)
+static void object_class_init(ObjectClass *klass, const void *data)
 {
     object_class_property_add_str(klass, "type", object_get_type,
                                   NULL);
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 3be52a98d58..6b86f01b01f 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -300,7 +300,7 @@ static void pr_manager_helper_instance_init(Object *obj)
 }
 
 static void pr_manager_helper_class_init(ObjectClass *klass,
-                                         void *class_data G_GNUC_UNUSED)
+                                         const void *class_data G_GNUC_UNUSED)
 {
     PRManagerClass *prmgr_klass = PR_MANAGER_CLASS(klass);
     UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
diff --git a/system/qtest.c b/system/qtest.c
index 12152efbcd3..7a8b9ff2a76 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -994,7 +994,7 @@ static char *qtest_get_chardev(Object *obj, Error **errp)
     return g_strdup(q->chr_name);
 }
 
-static void qtest_class_init(ObjectClass *oc, void *data)
+static void qtest_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e1b898e5755..31acc9910c5 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -241,7 +241,7 @@ static const TCGCPUOps alpha_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void alpha_cpu_class_init(ObjectClass *oc, void *data)
+static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32dc7c1e692..fbcd9274843 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2708,7 +2708,7 @@ static const TCGCPUOps arm_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
-static void arm_cpu_class_init(ObjectClass *oc, void *data)
+static void arm_cpu_class_init(ObjectClass *oc, const void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(acc);
@@ -2751,7 +2751,7 @@ static void arm_cpu_instance_init(Object *obj)
     arm_cpu_post_init(obj);
 }
 
-static void cpu_register_class_init(ObjectClass *oc, void *data)
+static void cpu_register_class_init(ObjectClass *oc, const void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(acc);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8188ede5cc8..1184c92b4c0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -818,7 +818,7 @@ static const gchar *aarch64_gdb_arch_name(CPUState *cs)
     return "aarch64";
 }
 
-static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
+static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
 
@@ -842,7 +842,7 @@ static void aarch64_cpu_instance_init(Object *obj)
     arm_cpu_post_init(obj);
 }
 
-static void cpu_register_class_init(ObjectClass *oc, void *data)
+static void cpu_register_class_init(ObjectClass *oc, const void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 03acdf83e00..eeee68404c4 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -255,7 +255,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void arm_v7m_class_init(ObjectClass *oc, void *data)
+static void arm_v7m_class_init(ObjectClass *oc, const void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a126ff3222..7747781de31 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -216,7 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .do_interrupt = avr_cpu_do_interrupt,
 };
 
-static void avr_cpu_class_init(ObjectClass *oc, void *data)
+static void avr_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0b7fc98f6ce..a565f8c46b8 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -330,7 +330,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .restore_state_to_opc = hexagon_restore_state_to_opc,
 };
 
-static void hexagon_cpu_class_init(ObjectClass *c, void *data)
+static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
 {
     HexagonCPUClass *mcc = HEXAGON_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5655677431c..623199d57b5 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -263,7 +263,7 @@ static const TCGCPUOps hppa_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void hppa_cpu_class_init(ObjectClass *oc, void *data)
+static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/i386/confidential-guest.c b/target/i386/confidential-guest.c
index b3727845adc..cfb71bf0349 100644
--- a/target/i386/confidential-guest.c
+++ b/target/i386/confidential-guest.c
@@ -20,7 +20,7 @@ OBJECT_DEFINE_ABSTRACT_TYPE(X86ConfidentialGuest,
                             X86_CONFIDENTIAL_GUEST,
                             CONFIDENTIAL_GUEST_SUPPORT)
 
-static void x86_confidential_guest_class_init(ObjectClass *oc, void *data)
+static void x86_confidential_guest_class_init(ObjectClass *oc, const void *data)
 {
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4b2da45366b..38626b66f50 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5562,7 +5562,7 @@ static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
     x86_cpu_realizefn(dev, errp);
 }
 
-static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
+static void max_x86_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
@@ -6561,7 +6561,7 @@ static const gchar *x86_gdb_arch_name(CPUState *cs)
 #endif
 }
 
-static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
+static void x86_cpu_cpudef_class_init(ObjectClass *oc, const void *data)
 {
     const X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
@@ -8711,7 +8711,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
 };
 #endif
 
-static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
+static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
@@ -8809,7 +8809,7 @@ static const TypeInfo x86_cpu_type_info = {
 };
 
 /* "base" CPU model, used by query-cpu-model-expansion */
-static void x86_cpu_base_class_init(ObjectClass *oc, void *data)
+static void x86_cpu_base_class_init(ObjectClass *oc, const void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
 
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 3e4e85e729c..96c2cf1d94a 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -159,7 +159,7 @@ void host_cpu_max_instance_init(X86CPU *cpu)
                             &error_abort);
 }
 
-static void host_cpu_class_init(ObjectClass *oc, void *data)
+static void host_cpu_class_init(ObjectClass *oc, const void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
 
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 560b5a05940..dfde53201f4 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -74,7 +74,7 @@ static void hvf_cpu_instance_init(CPUState *cs)
     hvf_cpu_xsave_init();
 }
 
-static void hvf_cpu_accel_class_init(ObjectClass *oc, void *data)
+static void hvf_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 1bda403f88b..520fadb58df 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -223,7 +223,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
     kvm_cpu_xsave_init();
 }
 
-static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index e7b56662fee..eb337b64320 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -80,7 +80,7 @@ static void nvmm_kick_vcpu_thread(CPUState *cpu)
     cpus_kick_thread(cpu);
 }
 
-static void nvmm_accel_ops_class_init(ObjectClass *oc, void *data)
+static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 04e5f7e6371..9d7987d9381 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1200,7 +1200,7 @@ nvmm_enabled(void)
 }
 
 static void
-nvmm_accel_class_init(ObjectClass *oc, void *data)
+nvmm_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "NVMM";
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0e1dbb6959e..f44cc1d2153 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2045,7 +2045,7 @@ static void sev_common_set_kernel_hashes(Object *obj, bool value, Error **errp)
 }
 
 static void
-sev_common_class_init(ObjectClass *oc, void *data)
+sev_common_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
 
@@ -2140,7 +2140,7 @@ static void sev_guest_set_legacy_vm_type(Object *obj, Visitor *v,
 }
 
 static void
-sev_guest_class_init(ObjectClass *oc, void *data)
+sev_guest_class_init(ObjectClass *oc, const void *data)
 {
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
@@ -2394,7 +2394,7 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
 }
 
 static void
-sev_snp_guest_class_init(ObjectClass *oc, void *data)
+sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 14ee038079a..afa19b4d478 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -181,7 +181,7 @@ static void x86_tcg_cpu_instance_init(CPUState *cs)
     x86_tcg_cpu_xsave_init();
 }
 
-static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
+static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index ab2e014c9ea..6ca442ba345 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -82,7 +82,7 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
     return !whpx_apic_in_platform();
 }
 
-static void whpx_accel_ops_class_init(ObjectClass *oc, void *data)
+static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 41fb8c5a4e5..d824e2824b0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2709,7 +2709,7 @@ bool whpx_apic_in_platform(void) {
     return whpx_global.apic_in_platform;
 }
 
-static void whpx_accel_class_init(ObjectClass *oc, void *data)
+static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "WHPX";
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 4245ab68a27..ada72854e3e 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -252,7 +252,7 @@ static void whpx_apic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
-static void whpx_apic_class_init(ObjectClass *klass, void *data)
+static void whpx_apic_class_init(ObjectClass *klass, const void *data)
 {
     APICCommonClass *k = APIC_COMMON_CLASS(klass);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e91f4a5239c..c9d1b8337ac 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -909,7 +909,7 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
 }
 #endif
 
-static void loongarch_cpu_class_init(ObjectClass *c, void *data)
+static void loongarch_cpu_class_init(ObjectClass *c, const void *data)
 {
     LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -947,7 +947,7 @@ static const gchar *loongarch32_gdb_arch_name(CPUState *cs)
     return "loongarch32";
 }
 
-static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
+static void loongarch32_cpu_class_init(ObjectClass *c, const void *data)
 {
     CPUClass *cc = CPU_CLASS(c);
 
@@ -960,7 +960,7 @@ static const gchar *loongarch64_gdb_arch_name(CPUState *cs)
     return "loongarch64";
 }
 
-static void loongarch64_cpu_class_init(ObjectClass *c, void *data)
+static void loongarch64_cpu_class_init(ObjectClass *c, const void *data)
 {
     CPUClass *cc = CPU_CLASS(c);
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf58045..361acaad063 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -563,7 +563,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void m68k_cpu_class_init(ObjectClass *c, void *data)
+static void m68k_cpu_class_init(ObjectClass *c, const void *data)
 {
     M68kCPUClass *mcc = M68K_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -592,7 +592,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->tcg_ops = &m68k_tcg_ops;
 }
 
-static void m68k_cpu_class_init_cf_core(ObjectClass *c, void *data)
+static void m68k_cpu_class_init_cf_core(ObjectClass *c, const void *data)
 {
     CPUClass *cc = CPU_CLASS(c);
 
@@ -607,7 +607,7 @@ static void m68k_cpu_class_init_cf_core(ObjectClass *c, void *data)
         .class_init = m68k_cpu_class_init_cf_core    \
     }
 
-static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
+static void m68k_cpu_class_init_m68k_core(ObjectClass *c, const void *data)
 {
     CPUClass *cc = CPU_CLASS(c);
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f114789abd8..65ce46f9433 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -437,7 +437,7 @@ static const TCGCPUOps mb_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void mb_cpu_class_init(ObjectClass *oc, void *data)
+static void mb_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47cd7cfdcef..9a45adb3ec5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -563,7 +563,7 @@ static const TCGCPUOps mips_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
-static void mips_cpu_class_init(ObjectClass *c, void *data)
+static void mips_cpu_class_init(ObjectClass *c, const void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -606,7 +606,7 @@ static const TypeInfo mips_cpu_type_info = {
     .class_init = mips_cpu_class_init,
 };
 
-static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
+static void mips_cpu_cpudef_class_init(ObjectClass *oc, const void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
     mcc->cpu_def = data;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b7bab0d7abf..0507edd759d 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -248,7 +248,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
+static void openrisc_cpu_class_init(ObjectClass *oc, const void *data)
 {
     OpenRISCCPUClass *occ = OPENRISC_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(occ);
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index ece34817818..ea86ea202ab 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -35,7 +35,7 @@
 #define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
     static void                                                             \
     glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
-    (ObjectClass *oc, void *data)                                           \
+    (ObjectClass *oc, const void *data)                                     \
     {                                                                       \
         DeviceClass *dc = DEVICE_CLASS(oc);                                 \
         PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8e49051254b..864741e85ec 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2155,7 +2155,7 @@ static void init_proc_405(CPUPPCState *env)
     SET_WDT_PERIOD(16, 20, 24, 28);
 }
 
-POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(405)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2223,7 +2223,7 @@ static void init_proc_440EP(CPUPPCState *env)
     SET_WDT_PERIOD(20, 24, 28, 32);
 }
 
-POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(440EP)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2262,7 +2262,7 @@ POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-POWERPC_FAMILY(460EX)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(460EX)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2317,7 +2317,7 @@ static void init_proc_440GP(CPUPPCState *env)
     SET_WDT_PERIOD(20, 24, 28, 32);
 }
 
-POWERPC_FAMILY(440GP)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(440GP)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2387,7 +2387,7 @@ static void init_proc_440x5(CPUPPCState *env)
     SET_WDT_PERIOD(20, 24, 28, 32);
 }
 
-POWERPC_FAMILY(440x5)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(440x5)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2423,7 +2423,7 @@ POWERPC_FAMILY(440x5)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-POWERPC_FAMILY(440x5wDFPU)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(440x5wDFPU)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2472,7 +2472,7 @@ static void init_proc_MPC5xx(CPUPPCState *env)
     /* XXX: TODO: allocate internal IRQ controller */
 }
 
-POWERPC_FAMILY(MPC5xx)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(MPC5xx)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2515,7 +2515,7 @@ static void init_proc_MPC8xx(CPUPPCState *env)
     /* XXX: TODO: allocate internal IRQ controller */
 }
 
-POWERPC_FAMILY(MPC8xx)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(MPC8xx)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2566,7 +2566,7 @@ static void init_proc_G2(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(G2)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2605,7 +2605,7 @@ POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-POWERPC_FAMILY(G2LE)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(G2LE)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2748,7 +2748,7 @@ static void init_proc_e200(CPUPPCState *env)
     /* XXX: TODO: allocate internal IRQ controller */
 }
 
-POWERPC_FAMILY(e200)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e200)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3036,7 +3036,7 @@ static void init_proc_e500v1(CPUPPCState *env)
     init_proc_e500(env, fsl_e500v1);
 }
 
-POWERPC_FAMILY(e500v1)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e500v1)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3080,7 +3080,7 @@ static void init_proc_e500v2(CPUPPCState *env)
     init_proc_e500(env, fsl_e500v2);
 }
 
-POWERPC_FAMILY(e500v2)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e500v2)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3124,7 +3124,7 @@ static void init_proc_e500mc(CPUPPCState *env)
     init_proc_e500(env, fsl_e500mc);
 }
 
-POWERPC_FAMILY(e500mc)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e500mc)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3171,7 +3171,7 @@ static void init_proc_e5500(CPUPPCState *env)
     init_proc_e500(env, fsl_e5500);
 }
 
-POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3220,7 +3220,7 @@ static void init_proc_e6500(CPUPPCState *env)
     init_proc_e500(env, fsl_e6500);
 }
 
-POWERPC_FAMILY(e6500)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3283,7 +3283,7 @@ static void init_proc_603(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(603)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3323,7 +3323,7 @@ POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-POWERPC_FAMILY(603E)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(603E)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3369,7 +3369,7 @@ static void init_proc_e300(CPUPPCState *env)
     register_e300_sprs(env);
 }
 
-POWERPC_FAMILY(e300)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e300)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3425,7 +3425,7 @@ static void init_proc_604(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(604)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(604)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3471,7 +3471,7 @@ static void init_proc_604E(CPUPPCState *env)
     register_604e_sprs(env);
 }
 
-POWERPC_FAMILY(604E)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(604E)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3528,7 +3528,7 @@ static void init_proc_740(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(740)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(740)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3594,7 +3594,7 @@ static void init_proc_750(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(750)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(750)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3741,7 +3741,7 @@ static void init_proc_750cl(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(750cl)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3849,7 +3849,7 @@ static void init_proc_750cx(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(750cx)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(750cx)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3922,7 +3922,7 @@ static void init_proc_750fx(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(750fx)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(750fx)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -3995,7 +3995,7 @@ static void init_proc_750gx(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(750gx)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(750gx)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4055,7 +4055,7 @@ static void init_proc_745(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(745)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(745)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4101,7 +4101,7 @@ static void init_proc_755(CPUPPCState *env)
     register_755_sprs(env);
 }
 
-POWERPC_FAMILY(755)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(755)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4168,7 +4168,7 @@ static void init_proc_7400(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7400)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7400)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4248,7 +4248,7 @@ static void init_proc_7410(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7410)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7410)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4349,7 +4349,7 @@ static void init_proc_7440(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7440)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7440)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4472,7 +4472,7 @@ static void init_proc_7450(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7450)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7450)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4602,7 +4602,7 @@ static void init_proc_7445(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7445)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7445)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4734,7 +4734,7 @@ static void init_proc_7455(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7455)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7455)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -4886,7 +4886,7 @@ static void init_proc_7457(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(7457)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(7457)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -5021,7 +5021,7 @@ static void init_proc_e600(CPUPPCState *env)
     ppc6xx_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(e600)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -5966,7 +5966,7 @@ static void init_proc_970(CPUPPCState *env)
     ppc970_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(970)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -6041,7 +6041,7 @@ static void init_proc_power5plus(CPUPPCState *env)
     ppc970_irq_init(env_archcpu(env));
 }
 
-POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(POWER5P)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -6147,7 +6147,7 @@ static bool ppc_pvr_match_power7(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     return true;
 }
 
-POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(POWER7)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -6311,7 +6311,7 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     return true;
 }
 
-POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -6509,7 +6509,7 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     return false;
 }
 
-POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(POWER9)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -6606,7 +6606,7 @@ static bool ppc_pvr_match_power10(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     return false;
 }
 
-POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(POWER10)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -6666,7 +6666,7 @@ static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     return false;
 }
 
-POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
+POWERPC_FAMILY(POWER11)(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -7452,7 +7452,7 @@ static const TCGCPUOps ppc_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
-static void ppc_cpu_class_init(ObjectClass *oc, void *data)
+static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 966c2c65723..6e10aae4ee3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2372,7 +2372,7 @@ static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
     return true;
 }
 
-static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
+static void kvmppc_host_cpu_class_init(ObjectClass *oc, const void *data)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
     uint32_t dcache_size = kvmppc_read_int_cpu_dt("d-cache-size");
@@ -2993,7 +2993,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
 
-static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fe1b23a297..fbed389a81a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2919,7 +2919,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
+static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -2951,7 +2951,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-static void riscv_cpu_class_init(ObjectClass *c, void *data)
+static void riscv_cpu_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce7793594..b011693f397 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1964,7 +1964,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
-static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0a137281de1..5e88e7beb02 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1492,7 +1492,7 @@ static void riscv_tcg_cpu_class_init(CPUClass *cc)
     cc->init_accel_cpu = riscv_tcg_cpu_init_ops;
 }
 
-static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
+static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 8c50c7a1bc8..a050b819354 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -208,7 +208,7 @@ static const TCGCPUOps rx_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void rx_cpu_class_init(ObjectClass *klass, void *data)
+static void rx_cpu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CPUClass *cc = CPU_CLASS(klass);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 97d41c23de7..5d51ce19e93 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -379,7 +379,7 @@ static const TCGCPUOps s390_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
-static void s390_cpu_class_init(ObjectClass *oc, void *data)
+static void s390_cpu_class_init(ObjectClass *oc, const void *data)
 {
     S390CPUClass *scc = S390_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(scc);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 93a05e43d79..972a99236f0 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -920,7 +920,7 @@ void s390_cpu_model_class_register_props(ObjectClass *oc)
 }
 
 #ifdef CONFIG_KVM
-static void s390_host_cpu_model_class_init(ObjectClass *oc, void *data)
+static void s390_host_cpu_model_class_init(ObjectClass *oc, const void *data)
 {
     S390CPUClass *xcc = S390_CPU_CLASS(oc);
 
@@ -929,7 +929,7 @@ static void s390_host_cpu_model_class_init(ObjectClass *oc, void *data)
 }
 #endif
 
-static void s390_base_cpu_model_class_init(ObjectClass *oc, void *data)
+static void s390_base_cpu_model_class_init(ObjectClass *oc, const void *data)
 {
     S390CPUClass *xcc = S390_CPU_CLASS(oc);
 
@@ -940,7 +940,7 @@ static void s390_base_cpu_model_class_init(ObjectClass *oc, void *data)
     xcc->desc = xcc->cpu_def->desc;
 }
 
-static void s390_cpu_model_class_init(ObjectClass *oc, void *data)
+static void s390_cpu_model_class_init(ObjectClass *oc, const void *data)
 {
     S390CPUClass *xcc = S390_CPU_CLASS(oc);
 
@@ -950,7 +950,7 @@ static void s390_cpu_model_class_init(ObjectClass *oc, void *data)
     xcc->desc = xcc->cpu_def->desc;
 }
 
-static void s390_qemu_cpu_model_class_init(ObjectClass *oc, void *data)
+static void s390_qemu_cpu_model_class_init(ObjectClass *oc, const void *data)
 {
     S390CPUClass *xcc = S390_CPU_CLASS(oc);
 
@@ -959,7 +959,7 @@ static void s390_qemu_cpu_model_class_init(ObjectClass *oc, void *data)
                                 qemu_hw_version());
 }
 
-static void s390_max_cpu_model_class_init(ObjectClass *oc, void *data)
+static void s390_max_cpu_model_class_init(ObjectClass *oc, const void *data)
 {
     S390CPUClass *xcc = S390_CPU_CLASS(oc);
 
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index b191a4a68a2..fe0a72c416e 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -367,7 +367,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(S390PVGuest,
                                    { TYPE_USER_CREATABLE },
                                    { NULL })
 
-static void s390_pv_guest_class_init(ObjectClass *oc, void *data)
+static void s390_pv_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 24a22724c61..4c50b5d2912 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -166,7 +166,7 @@ static void sh7750r_cpu_initfn(Object *obj)
     env->features = SH_FEATURE_BCR3_AND_BCR4;
 }
 
-static void sh7750r_class_init(ObjectClass *oc, void *data)
+static void sh7750r_class_init(ObjectClass *oc, const void *data)
 {
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
@@ -183,7 +183,7 @@ static void sh7751r_cpu_initfn(Object *obj)
     env->features = SH_FEATURE_BCR3_AND_BCR4;
 }
 
-static void sh7751r_class_init(ObjectClass *oc, void *data)
+static void sh7751r_class_init(ObjectClass *oc, const void *data)
 {
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
@@ -200,7 +200,7 @@ static void sh7785_cpu_initfn(Object *obj)
     env->features = SH_FEATURE_SH4A;
 }
 
-static void sh7785_class_init(ObjectClass *oc, void *data)
+static void sh7785_class_init(ObjectClass *oc, const void *data)
 {
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
@@ -265,7 +265,7 @@ static const TCGCPUOps superh_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void superh_cpu_class_init(ObjectClass *oc, void *data)
+static void superh_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fbd38ec334a..f46600249bd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1011,7 +1011,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
-static void sparc_cpu_class_init(ObjectClass *oc, void *data)
+static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
 {
     SPARCCPUClass *scc = SPARC_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
@@ -1061,7 +1061,7 @@ static const TypeInfo sparc_cpu_type_info = {
     .class_init = sparc_cpu_class_init,
 };
 
-static void sparc_cpu_cpudef_class_init(ObjectClass *oc, void *data)
+static void sparc_cpu_cpudef_class_init(ObjectClass *oc, const void *data)
 {
     SPARCCPUClass *scc = SPARC_CPU_CLASS(oc);
     scc->cpu_def = data;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 95202fadbfd..89e41a31586 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -180,7 +180,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .cpu_exec_halt = tricore_cpu_has_work,
 };
 
-static void tricore_cpu_class_init(ObjectClass *c, void *data)
+static void tricore_cpu_class_init(ObjectClass *c, const void *data)
 {
     TriCoreCPUClass *mcc = TRICORE_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4eb699d1f45..9e1ed75ba7d 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -247,7 +247,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
+static void xtensa_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f64699b116d..75bb00ee246 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -169,7 +169,7 @@ static void xtensa_finalize_config(XtensaConfig *config)
     }
 }
 
-static void xtensa_core_class_init(ObjectClass *oc, void *data)
+static void xtensa_core_class_init(ObjectClass *oc, const void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index c99be97ed8b..4e1c4d67297 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -38,7 +38,7 @@ static const TypeInfo test_if_info = {
 
 #define PATTERN 0xFAFBFCFD
 
-static void test_class_init(ObjectClass *oc, void *data)
+static void test_class_init(ObjectClass *oc, const void *data)
 {
     TestIfClass *tc = TEST_IF_CLASS(oc);
 
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 13d632cfed4..f1de1618f60 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -135,7 +135,7 @@ static void dummy_init(Object *obj)
 }
 
 
-static void dummy_class_init(ObjectClass *cls, void *data)
+static void dummy_class_init(ObjectClass *cls, const void *data)
 {
     object_class_property_add_str(cls, "sv",
                                   dummy_get_sv,
@@ -264,7 +264,7 @@ static void dummy_dev_unparent(Object *obj)
     object_unparent(OBJECT(dev->bus));
 }
 
-static void dummy_dev_class_init(ObjectClass *klass, void *opaque)
+static void dummy_dev_class_init(ObjectClass *klass, const void *opaque)
 {
     klass->unparent = dummy_dev_unparent;
 }
@@ -288,7 +288,7 @@ static void dummy_bus_unparent(Object *obj)
     object_unparent(OBJECT(bus->backend));
 }
 
-static void dummy_bus_class_init(ObjectClass *klass, void *opaque)
+static void dummy_bus_class_init(ObjectClass *klass, const void *opaque)
 {
     klass->unparent = dummy_bus_unparent;
 }
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 6f6a306788f..33062762a67 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -51,7 +51,7 @@ static const Property static_props[] = {
     DEFINE_PROP_UINT32("prop2", MyType, prop2, PROP_DEFAULT),
 };
 
-static void static_prop_class_init(ObjectClass *oc, void *data)
+static void static_prop_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -177,7 +177,7 @@ static void dynamic_instance_init(Object *obj)
                         NULL, NULL);
 }
 
-static void dynamic_class_init(ObjectClass *oc, void *data)
+static void dynamic_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -193,7 +193,7 @@ static const TypeInfo dynamic_prop_type = {
     .class_init = dynamic_class_init,
 };
 
-static void hotplug_class_init(ObjectClass *oc, void *data)
+static void hotplug_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -209,7 +209,7 @@ static const TypeInfo hotplug_type = {
     .class_init = hotplug_class_init,
 };
 
-static void nohotplug_class_init(ObjectClass *oc, void *data)
+static void nohotplug_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index f9bccb56abc..326045ecbb3 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -924,7 +924,7 @@ static void unsupported_params_init(const MachineClass *mc, SMPTestData *data)
     }
 }
 
-static void machine_base_class_init(ObjectClass *oc, void *data)
+static void machine_base_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -934,7 +934,8 @@ static void machine_base_class_init(ObjectClass *oc, void *data)
     mc->name = g_strdup(SMP_MACHINE_NAME);
 }
 
-static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
+static void machine_generic_invalid_class_init(ObjectClass *oc,
+                                               const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -943,21 +944,22 @@ static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = MAX_CPUS - 1;
 }
 
-static void machine_with_modules_class_init(ObjectClass *oc, void *data)
+static void machine_with_modules_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->smp_props.modules_supported = true;
 }
 
-static void machine_with_dies_class_init(ObjectClass *oc, void *data)
+static void machine_with_dies_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->smp_props.dies_supported = true;
 }
 
-static void machine_with_modules_dies_class_init(ObjectClass *oc, void *data)
+static void machine_with_modules_dies_class_init(ObjectClass *oc,
+                                                 const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -965,28 +967,29 @@ static void machine_with_modules_dies_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
 }
 
-static void machine_with_clusters_class_init(ObjectClass *oc, void *data)
+static void machine_with_clusters_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->smp_props.clusters_supported = true;
 }
 
-static void machine_with_books_class_init(ObjectClass *oc, void *data)
+static void machine_with_books_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->smp_props.books_supported = true;
 }
 
-static void machine_with_drawers_class_init(ObjectClass *oc, void *data)
+static void machine_with_drawers_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->smp_props.drawers_supported = true;
 }
 
-static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
+static void machine_with_drawers_books_class_init(ObjectClass *oc,
+                                                  const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -994,7 +997,7 @@ static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
     mc->smp_props.books_supported = true;
 }
 
-static void machine_full_topo_class_init(ObjectClass *oc, void *data)
+static void machine_full_topo_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index fe20579832a..8d27cdb4db9 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -906,7 +906,7 @@ qemu_text_console_finalize(Object *obj)
 }
 
 static void
-qemu_text_console_class_init(ObjectClass *oc, void *data)
+qemu_text_console_class_init(ObjectClass *oc, const void *data)
 {
     if (!cursor_timer) {
         cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
@@ -935,7 +935,7 @@ qemu_fixed_text_console_finalize(Object *obj)
 }
 
 static void
-qemu_fixed_text_console_class_init(ObjectClass *oc, void *data)
+qemu_fixed_text_console_class_init(ObjectClass *oc, const void *data)
 {
 }
 
@@ -1051,7 +1051,7 @@ static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
     }
 }
 
-static void char_vc_class_init(ObjectClass *oc, void *data)
+static void char_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/ui/console.c b/ui/console.c
index 914ed2cc76b..3291c4b88f2 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -401,7 +401,7 @@ qemu_console_finalize(Object *obj)
 }
 
 static void
-qemu_console_class_init(ObjectClass *oc, void *data)
+qemu_console_class_init(ObjectClass *oc, const void *data)
 {
 }
 
@@ -437,7 +437,7 @@ qemu_graphic_console_prop_get_head(Object *obj, Visitor *v, const char *name,
 }
 
 static void
-qemu_graphic_console_class_init(ObjectClass *oc, void *data)
+qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
 {
     object_class_property_add_link(oc, "device", TYPE_DEVICE,
                                    offsetof(QemuGraphicConsole, device),
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index bf061cbc930..d05dddaf81b 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -269,7 +269,7 @@ dbus_chr_parse(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static void
-char_dbus_class_init(ObjectClass *oc, void *data)
+char_dbus_class_init(ObjectClass *oc, const void *data)
 {
     DBusChardevClass *klass = DBUS_CHARDEV_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
diff --git a/ui/dbus.c b/ui/dbus.c
index 2eb03aa2471..0c0f86eaa6f 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -404,7 +404,7 @@ set_gl_mode(Object *o, int val, Error **errp)
 }
 
 static void
-dbus_display_class_init(ObjectClass *oc, void *data)
+dbus_display_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
@@ -453,7 +453,7 @@ dbus_vc_parse(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static void
-dbus_vc_class_init(ObjectClass *oc, void *data)
+dbus_vc_class_init(ObjectClass *oc, const void *data)
 {
     DBusVCClass *klass = DBUS_VC_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
diff --git a/ui/gtk.c b/ui/gtk.c
index c0237431489..474318201da 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1879,7 +1879,7 @@ static void gd_vc_open(Chardev *chr,
     *be_opened = false;
 }
 
-static void char_gd_vc_class_init(ObjectClass *oc, void *data)
+static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index c86e5d67eb3..9dce31ea9a7 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -696,7 +696,7 @@ static void input_barrier_instance_init(Object *obj)
     ib->height = 1080;
 }
 
-static void input_barrier_class_init(ObjectClass *oc, void *data)
+static void input_barrier_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 381148ea994..b940198bfe2 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -495,7 +495,7 @@ static void input_linux_instance_init(Object *obj)
 {
 }
 
-static void input_linux_class_init(ObjectClass *oc, void *data)
+static void input_linux_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 91e258a621d..24f78f305c4 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -101,7 +101,7 @@ static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
     /* fqdn is dealt with in vc_chr_open() */
 }
 
-static void char_vc_class_init(ObjectClass *oc, void *data)
+static void char_vc_class_init(ObjectClass *oc, const void *data)
 {
     VCChardevClass *vc = CHARDEV_VC_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 724eff972f9..04513ded298 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -905,7 +905,7 @@ static void vdagent_chr_parse(QemuOpts *opts, ChardevBackend *backend,
 
 /* ------------------------------------------------------------------ */
 
-static void vdagent_chr_class_init(ObjectClass *oc, void *data)
+static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
diff --git a/util/main-loop.c b/util/main-loop.c
index acad8c2e6cd..11913a03e79 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -220,7 +220,7 @@ static bool main_loop_can_be_deleted(EventLoopBase *base)
     return false;
 }
 
-static void main_loop_class_init(ObjectClass *oc, void *class_data)
+static void main_loop_class_init(ObjectClass *oc, const void *class_data)
 {
     EventLoopBaseClass *bc = EVENT_LOOP_BASE_CLASS(oc);
 
diff --git a/util/thread-context.c b/util/thread-context.c
index 2bc7883b9e0..95228a3d4f6 100644
--- a/util/thread-context.c
+++ b/util/thread-context.c
@@ -273,7 +273,7 @@ static void thread_context_instance_complete(UserCreatable *uc, Error **errp)
     }
 }
 
-static void thread_context_class_init(ObjectClass *oc, void *data)
+static void thread_context_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index b2e0e7a30fa..b0b6e2993eb 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -261,7 +261,7 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
                       qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
 };
 
-static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
+static void apple_gfx_mmio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index b939bb9b233..2f0d24f7fee 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -121,7 +121,7 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
                       qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
 };
 
-static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
+static void apple_gfx_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pci = PCI_DEVICE_CLASS(klass);
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f3d43e066ef..b39dba829d4 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -173,7 +173,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
 
 unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
     klass: *mut ObjectClass,
-    _data: *mut c_void,
+    _data: *const c_void,
 ) {
     let mut klass = NonNull::new(klass)
         .unwrap()
diff --git a/scripts/codeconverter/codeconverter/qom_type_info.py b/scripts/codeconverter/codeconverter/qom_type_info.py
index f92c3a4730e..22a25560760 100644
--- a/scripts/codeconverter/codeconverter/qom_type_info.py
+++ b/scripts/codeconverter/codeconverter/qom_type_info.py
@@ -798,7 +798,8 @@ def gen_patches(self) -> Iterable[Patch]:
 #
 #
 #            if 'class_init' not in fields:
-#                yield self.prepend(('static void %s_class_init(ObjectClass *oc, void *data)\n'
+#                yield self.prepend(('static void %s_class_init(ObjectClass *oc,\n'
+#                                                              'const void *data)\n'
 #                                    '{\n'
 #                                    '}\n\n') % (ids.lowercase))
 #                yield self.append_field('class_init', ids.lowercase+'_class_init')
-- 
2.47.1


