Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA161C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOex-0008Ov-E6; Fri, 09 Feb 2024 06:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd0-0006h7-TJ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:07 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcy-0000qg-CQ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:06 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so532038a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476462; x=1708081262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLRgqwjIVn0iuzCfsLW3wDkzvW40xNFmjWObr7B4NP4=;
 b=BhuSCDzAcE/W7sdJzxMfJHcsmne8wd8Emh+AwhXvbjdWm0FDSwlc1gnsC6y7KCRPk0
 YxJKSPucZnDgxm1irJ1T1otcgRbms5Nn4fhA2A0AsV4vod+lpGTnt7yRHfGquqbmXcj4
 7pzFvk9TE+RR6ZFjQ+zerrqaTNIdyEaZKE8udhzZjJrgYNfyDyg3DjWFobYTu/UlOALf
 cricOjIj21AvhmrES47M5wliG3ujc4wFj+oNELTbLkxkFEWy1O0AftasmV/o8/V7Vj+c
 HUXhr3cc48r4aUExprVBI+SSHo5d9zPAnir3sCqeHcTxtUU7b4dX3IbQ1ifpsQ4RECPK
 jPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476462; x=1708081262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLRgqwjIVn0iuzCfsLW3wDkzvW40xNFmjWObr7B4NP4=;
 b=IukSYtXAFR403d+mUu0FaaQQ9muaDs8MihMvzjKTGNA4x56fn38jQVgkuNFg0RzjYR
 JSVokD5Fc4f7O1O2xWw8c6MjbYtURlG9ZnMn0M4S2tXT4XpBH3PP8pNmKPVI9wJvrRs2
 nM4QzfgyY0XEl2NFuC7y4OEwHsrvcntP9WGP6A4xFJtgcGQItRWJJo9JFKTQWhq8CclA
 zdHXM6tTAPgZfYuwUqEnyNvjCsTQ6X9SvPU3cml/JEUQkkUSPvf5tirWy/xnhult9llX
 0845sg15o3nWquJHttFJqRgPduVUKZ2KK4vrE3o6TWp/Aeneujrih8DS1rWKmBeMB5F7
 +dyw==
X-Gm-Message-State: AOJu0Yw2GBMs/qDHSEZ/sRxNE/dER6SobPlEzzU3vSOrn1C+vD7BSf0w
 ZW6EhhIVIKXbbl6MOPq8PgQ/eeP/fZ+vJ2R3mpMed49NsJtfbVIs9MC53LTmCUccJw==
X-Google-Smtp-Source: AGHT+IHskMlx2M1H02Rptbk5d5PxAK1w0589ZIRrujn00bLA/o2pX/0ydt7AxdPqhFLy2beqlYQGpQ==
X-Received: by 2002:a05:6a20:e68c:b0:19e:b196:c8dc with SMTP id
 mz12-20020a056a20e68c00b0019eb196c8dcmr1387699pzb.20.1707476461896; 
 Fri, 09 Feb 2024 03:01:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWwm9ByLLbhKzOWcfWAhpdyWAAiBBcgTAsINo82PcK2MUGg/KDm4v1ZyylrgnhhsSOLHWUb1bhzKujORNNEXHM4DY0xTNxRDYuVMY+los1cPTc1TtfyoqJG8+yLA1NIzblUX1078L4Wr4pEd1/c0KwZJjuARJku
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 48/61] hw/riscv/virt.c: use g_autofree in virt_machine_init()
Date: Fri,  9 Feb 2024 20:58:00 +1000
Message-ID: <20240209105813.3590056-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Move 'soc_name' to the loop, and give it g_autofree, to avoid the manual
g_free().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240122221529.86562-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f8278df83f..710fbbda2c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1356,7 +1356,6 @@ static void virt_machine_init(MachineState *machine)
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    char *soc_name;
     DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
@@ -1376,6 +1375,8 @@ static void virt_machine_init(MachineState *machine)
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
+        g_autofree char *soc_name = g_strdup_printf("soc%d", i);
+
         if (!riscv_socket_check_hartids(machine, i)) {
             error_report("discontinuous hartids in socket%d", i);
             exit(1);
@@ -1393,10 +1394,8 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
 
-        soc_name = g_strdup_printf("soc%d", i);
         object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
                                 TYPE_RISCV_HART_ARRAY);
-        g_free(soc_name);
         object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
                                 machine->cpu_type, &error_abort);
         object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
-- 
2.43.0


