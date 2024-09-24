Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AAECF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrX-0003y3-JR; Tue, 24 Sep 2024 18:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrV-0003os-Ao
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:25 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrT-0001cm-Mf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:25 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso4263486a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216302; x=1727821102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVVYNdYr/IVU0wUe8Y8R5LwF4iHWDDM93QqpDvdp/Uo=;
 b=IMhzUwlFdh6iRam3pVa0fHo6/HRY/sHq5Rv1mZ4PbZGrkm/rt6TSljj8t48MtAQPP5
 HoQndlNAnCy/gjUCIHIMXsMoq9umLTGF3mtUX4HAVBBsGJEPanOfufHDzm6rARSbnkbn
 7lDC0yHkBQLhd2h8Cn23UCGcVatvkqTSmM+OlexUHieYgezfTaaXPzgHPLcEkUDjNAX5
 zqJ8brX1/GWc9hksGlmmCo207KzMe4xh2otH1BwyfhnZhJe/AWqQmuPWDs8C/6bsAkdD
 Rl7Awnngr10mDrGnjfZ4KQ1EeaDIsrWCm7ROKFvNe496XCrHEW9ut9zH95So7O/5YFYP
 w84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216302; x=1727821102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVVYNdYr/IVU0wUe8Y8R5LwF4iHWDDM93QqpDvdp/Uo=;
 b=fZxvZo8lnYasWYzAx6e8UfIrnE4g4y8hMt21wOhgeB924OcoMEGwZ/nHmu7d2ZWfSy
 67VmYFpsmjnyp2C+DnqlrXGT2MGF522gmZsxVxWDPeTysSiYgrUEmKjrz7nnJlcVO/2l
 3aWk0qJcZn6PrQFTINRj3bt2nkCLqZu0Q3J7EHIluD4KYgzjtcFcB0MCEOoWAEsHU2t9
 c9qbYy3e6ZCXa28wcfM0S1f+/x38qIfXvLl9K8AeqKpfmA3NsF1drMuoGaPAxx0hGo3V
 dP8iMDGJxt5QVWF3tBSB/zwSxXbRILIKjDT1I93coh7eqnEu/hiQ8K41r73QjLjS8BBe
 fQUA==
X-Gm-Message-State: AOJu0YydJn5iDNR0TDMuH5GOmXb8/4OF3PaFZQ9kt8OhM4upTK+IIrcx
 aqVAWrjfLaNLPWiZ044F4bd8rnyAx4AXAu099oD9xffJXDm9E4RlE/gHcg==
X-Google-Smtp-Source: AGHT+IG/JFtlP3FMB2ZjIERqvKfz2oI8fvFMCcmlawKeIq16NeqFP6d+eUvmOzhqJ1leOc04AGAn5g==
X-Received: by 2002:a05:6a21:a34b:b0:1d2:e90a:f4ae with SMTP id
 adf61e73a8af0-1d4e0bd1346mr717823637.33.1727216302190; 
 Tue, 24 Sep 2024 15:18:22 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:21 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 07/47] target: riscv: Enable Bit Manip for OpenTitan Ibex CPU
Date: Wed, 25 Sep 2024 08:17:08 +1000
Message-ID: <20240924221751.2688389-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Alistair Francis <alistair23@gmail.com>

The OpenTitan Ibex CPU now supports the the Zba, Zbb, Zbc
and Zbs bit-manipulation sub-extensions ratified in
v.1.0.0 of the RISC-V Bit- Manipulation ISA Extension, so let's enable
them in QEMU as well.

1: https://github.com/lowRISC/opentitan/pull/9748

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240823003231.3522113-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0f8189bcf0..a1ca12077f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -680,6 +680,11 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
     cpu->cfg.ext_smepmp = true;
+
+    cpu->cfg.ext_zba = true;
+    cpu->cfg.ext_zbb = true;
+    cpu->cfg.ext_zbc = true;
+    cpu->cfg.ext_zbs = true;
 }
 
 static void rv32_imafcu_nommu_cpu_init(Object *obj)
-- 
2.46.1


