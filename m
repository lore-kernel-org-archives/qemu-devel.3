Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FFCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMm-0001U5-Ep; Thu, 21 May 2026 20:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMa-0001ST-Oh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMZ-0003Cv-6e
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bea7176c72so8592035ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408218; x=1780013018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVDuaf0uiJPSEZc00jK7jWeRO5ExDmx6hQRMkeQfRZQ=;
 b=buPem7awAKc0S/woG+w9nVbxsfQBd+tQoh3tNaFecXIcQujllPymzW2alK3UNG0L5w
 1kXFgWm1pylT09+aPC0b7jdben72816Psoufs8iBo4yh58OdCpHo28RYBLV69ofVdFT2
 OLO2lkVvGkHRdoDlMxisEOQ1OYgGjT9D1Peb//1RuH59ON0kdODvTUhyrq3kIr+loDv0
 u3hmPAksOduOtiqOTLqreHuCOgMQng12IFe8oX1qGmvXZg3KyIfjgviqO7wESBbAXcWX
 VoeYQZyrB0fVIO7QxLdDKeplInu7W6bDNO8ucAilZn82HxQDHMiPuZjkR/QJuU/h6767
 jh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408218; x=1780013018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RVDuaf0uiJPSEZc00jK7jWeRO5ExDmx6hQRMkeQfRZQ=;
 b=Xh7czsZRORtUnm01o4oG1oRytQaY5OYHSa9ejl44m7uv4e9SCRzpNCVEviOEDAawVm
 /+qO25zD3IKss/MrNvhhbXgeyP8Y66nr6bx6jNfpNmQ6AZvDttJU0N+J0XTOuKAZaX7Y
 HK9okijjbm7ydCmgBcD/bjQVY68fRQeQ9tKY4cEhF3IDSNCFfLaFsBLZ/vRskT96bazc
 unhQpSJIW9sK+hsYl8A2ExJLLQ1jO5ql0UvlJnluHBs9rZoMi0jKj8V9/m89ZihcihOF
 ZfxnS0HG8Ydj/TBuH7ZKnUIkMXus3GsLa8YVxV9LMpNXWqm4JeoyE+LGZuZiszNq9qD5
 Iu5w==
X-Gm-Message-State: AOJu0YyZcW8TVL2lOR8T6aBnqKCljr0F8faP4QFUCdoE6BGbnKCWygQR
 4X52qnFcnOFEJ1oZLWfB+He3Dl/n/LMEcFmsjFgQw8LLXmBhp+BF6N/VpTljt/gM
X-Gm-Gg: Acq92OHV4OF3cLGj40Q/df0/BA2if1ziJFgXhPlFGVN/xcyqwUbcf+17vFWwJts7qP4
 evsObWmPVzNxwUdBTRan0CX4uzZ8eIdKVjubAobbd8kCd7nJa7yQoRpXdxw+7LwdJaMw675OnL3
 I8bsKV6LLJReHRbREy6qYUuWbbuKNpTLBX8ONUOd8TcZEE1BjzGBcR4vbLrQLLSRed3wSXQ8mOf
 gJuYc3HsYXT0Qqmxx3ZESHkJE1T1I6jLKNgxyEZTIsL9q1RPh1er6NzgnpwkaKclndGevJc90MX
 Ev47NPbdLZwGGA21w1W8mWV2kqs9vv1B0T+xWv8b1CBTUp3JJKt2dpLqNp/ffQ0hZ+sllasPnFN
 1M2tDhRJPAYcs3UwF14vff1dQEVD25MAZ+8QXa98Ivxg5ioN6os/t9FbYjvxhSQRtRhAG58NJFg
 Bu5IOsHRODdRAnnLHUvEcFrzyfrzOScExISyw6C4VGGA==
X-Received: by 2002:a17:902:f60f:b0:2b0:5795:9ead with SMTP id
 d9443c01a7336-2beb02cb6bamr11475155ad.0.1779408217720; 
 Thu, 21 May 2026 17:03:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 01/48] target/riscv: Remove spike as default machine
Date: Fri, 22 May 2026 10:02:37 +1000
Message-ID: <20260522000324.23255-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

In QEMU 10.0 we deprecated the default spike machine, let's finally
remove spike as the default and require users to specify the machine.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260430052218.771358-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst       | 18 ------------------
 docs/about/removed-features.rst | 14 ++++++++++++++
 hw/riscv/spike.c                |  1 -
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 95bf761329..7771b98b72 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -243,24 +243,6 @@ better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
 
-RISC-V default machine option (since 10.0)
-''''''''''''''''''''''''''''''''''''''''''
-
-RISC-V defines ``spike`` as the default machine if no machine option is
-given in the command line.  This happens because ``spike`` is the first
-RISC-V machine implemented in QEMU and setting it as default was
-convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
-and having ``spike`` as a default is no longer justified.  This default
-will also promote situations where users think they're running ``virt``
-(the most used RISC-V machine type in 10.0) when in fact they're
-running ``spike``.
-
-Removing the default machine option forces users to always set the machine
-they want to use and avoids confusion.  Existing users of the ``spike``
-machine must ensure that they're setting the ``spike`` machine in the
-command line (``-M spike``).
-
-
 Backend options
 ---------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 2021e85f56..d1bea4d75b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1229,6 +1229,20 @@ firmware is available to boot it. It can be replaced by the
 ``ast2700fc``, another multi-SoC machine based on the newer AST2700
 SoCs which are excepted to receive better support in the future.
 
+RISC-V default machine (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''
+
+RISC-V used to define ``spike`` as the default machine if no machine option
+was given via the command line.  This happend because ``spike`` was the first
+RISC-V machine implemented in QEMU and setting it as default was
+convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
+and having ``spike`` as a default is no longer justified.
+
+The default machine option has been removed, forcing users to always set the
+machine they want to use to avoid confusion.  Existing users of the ``spike``
+machine must ensure that they're setting the ``spike`` machine in the
+command line (``-M spike``).
+
 linux-user mode CPUs
 --------------------
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 35c696f891..87fe0f242f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -341,7 +341,6 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V Spike board";
     mc->init = spike_board_init;
     mc->max_cpus = SPIKE_CPUS_MAX;
-    mc->is_default = true;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
-- 
2.53.0


