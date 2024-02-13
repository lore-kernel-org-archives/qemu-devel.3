Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A123C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyHt-0000s0-17; Tue, 13 Feb 2024 14:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyHq-0000pz-Qo
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:46 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyHp-0001od-7z
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:46 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d76671e5a4so38829945ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851863; x=1708456663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHIAZI9o1OCE/syn5pPgOS3SyjRfI90qPN8Z11/8n7g=;
 b=cAXxMTf5LimL1DDllbKGnyv/p9RWIhjN6WBfrDxXpJv/JOiRw+QQPy4mEdKZWjft+g
 hI5umoRxjD3NEaMWh2D+HgRKJzonKeI6vWDxEoXgmaWiBm5TwNtE6B9+MoyW1S/R0LTm
 VWTHmmz1Y5A/jA1CVFJRNwhcATXj8GvUNhaRTyWGgrwGJnKrOkI8XkstoT4j76m1+vkz
 oOv1F/+43DOOo4xf/7gDyHsBWNJg2G5p5nSrYAUNCD7XszsPJQTLFTsvAVp9rBQ91gTr
 U/L7laeO0TtRl7OX0o3QRxaUsT5EkzwJlPC3UulHAydGdDQvRdUr1W2MeOBIUve5Lf4v
 jp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851863; x=1708456663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHIAZI9o1OCE/syn5pPgOS3SyjRfI90qPN8Z11/8n7g=;
 b=LxfGMiJKYiBLM+HIq+Q8pRe3yfT1DHGvYxhHJtGCAAQIz2QFA16C5KJ4W7rULz31F5
 iJJXL7s16n9jaH+d6iG5YseSNViMOOoLdD5a9hnlvCDUJWKog5s8E+Z1AoQcTJ/DcHj6
 TbBP4a9coVkEebyPST19fGjzewgTJLGB/zV1CuG+RvUAwjGhSrlQBtM1Iq4284JEDjKN
 KKczXyQg0jh4gC9UGF5G3wClxKWcHEQ4ZRt+Oh3FZWN3JhpZMIfCW9qSjUunx1s9QMkU
 rbXFAnqXoW6LbYFBYe8cNveSSlymKl8OocUcUQmgMqF0QCJ74Nm8Wv0zOcRsZphTeGpi
 VEYA==
X-Gm-Message-State: AOJu0YzZP9lRpmmVpYgObKQmjB6ir8I57gZfjo2mPamBAoigY8YP0y9a
 CaRcI1+nVQsYbNosPNw0NApY+WMZsbhoYF12vs7yzOOQZN9SRSA8uG44h/eLX+X6YjMWM3nMH87
 6
X-Google-Smtp-Source: AGHT+IEKBQ+kAL2F+iB+LdmA16ho/2qukqsm6OR+ulOfofv/XiY03gHl6Q4gPDvt0LKVpyd45KknCA==
X-Received: by 2002:a17:902:f68b:b0:1d9:9f86:3c77 with SMTP id
 l11-20020a170902f68b00b001d99f863c77mr549830plg.14.1707851863127; 
 Tue, 13 Feb 2024 11:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU26pHfczMl7awKCV8mDW/RWNGtX2FceqidnD5E77EoTMYUlRd5R1AyE44XvUTQMJ/L+QIiqkn9z58539zi/VlmPu1w0JQO2xQ0PiotRIY24fo2QkFtb+60hwmbrZbXSQ6h4TPVs7GBP7F42Y9uz62PWT4hd3CmuJO5PDveO5Jy06Ttf6X3kVhASNEAwTnQLJHODQli7ZxRmkDZuuNu/66cEnBLqjh6vO0XBafzlKuu+Hnqt2Z4duRp6pvQqQBgwNbI4p77zyW/0DDgraF/jsW37R+pDdHxCz4OjGBOJPo7nTv55Hxu7PWJSxSaXVE6m5X0lzKnUxrjxLAwjUVMX1KpuAr8F16VL4kjLf8BiJyCJxfXsBJK8K8it/2WMZdzmb4APSz/8MkKr9Lj
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:17:42 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/6] libqos, riscv: libqos fixes, add riscv machine
Date: Tue, 13 Feb 2024 16:17:30 -0300
Message-ID: <20240213191736.733334-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

This series adds a RISC-V 'virt' libqos machine. It's copied from the
existing ARM machine in arm-virt-machine.c.

Due to the increase of test coverage I found out 2 bugs in the virtio
layer of libqos. Patch 1 is a bug related to unintialized guest pages
from guest_alloc() being used, patch 2 is an error in an offset of a
struct. My educated guess on why other boards don't fail these tests
is that either their guest pages happens to be zeroed or happens to have
a certain value that doesn't affect the tests. 

Patches 3, 4 and 5 are changes in the RISC-V 'virt' machine required to
make all tests pass.

Patch 6 adds the RISC-V virt machine nodes. As I said, it's a declared
copy of arm-virt-machine.c with extra steps. One of them is to edit the
attributes of the generic-pcihost liqos driver to fit RISC-V needs,
since some of its attributes (ecam, pio_base and so on) are hardcoded to
the values that the ARM 'virt' machine uses. If desired, we can change
generic-pcihost to be more flexible and not hardcode any machine/arch
specific value.
 

Alex: I'm CCing you because I noticed that you reviewed bug fixes in
libqos/virtio in the past, figured you have some expertise to share
here.


Patches based on master.


Daniel Henrique Barboza (6):
  libqos/virtio.c: init all elems in qvring_indirect_desc_setup()
  libqos/virtio.c: fix 'avail_event' offset in qvring_init()
  hw/riscv/virt.c: create '/soc/pci@...' fdt node earlier
  hw/riscv/virt.c: add virtio-iommu-pci hotplug support
  hw/riscv/virt.c: make aclint compatible with 'qtest' accel
  tests/libqos: add riscv/virt machine nodes

 hw/riscv/virt.c                         |  97 ++++++++++++-----
 tests/qtest/libqos/meson.build          |   1 +
 tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
 tests/qtest/libqos/virtio.c             |  27 +++--
 4 files changed, 228 insertions(+), 34 deletions(-)
 create mode 100644 tests/qtest/libqos/riscv-virt-machine.c

-- 
2.43.0


