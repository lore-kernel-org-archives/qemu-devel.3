Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE2BCCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC53y-0003qP-T0; Thu, 23 Oct 2025 19:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC53x-0003pw-K0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:45 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC53w-000748-5M
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:45 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b6cf07258e8so1001741a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263382; x=1761868182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZLyqH7Fvcg+HojmfroD3Z/4L2yTHzsWHg7CTJ36+8Y=;
 b=SYW2mC9WfyT8zFIFDgtCUaawRMlf2Nrv0OrQU5nSkdH9SRevVQUQQVjAHBt7I1eR/J
 WlklP39MAnsNYE/mmNUQXIHvzAHVnXS7RU0tjfg3cHWO/iSZKa9/rdaBokES7zcikARt
 7k43F5PSU5JaFs23ojI7I773M7lC75vQ9Qql4u4a6O4+H5y+m+UON9u9Lk17oSQOQJfX
 14BX244JYSTgq2C1uQcZ8Tnb84iyOuV6nSks07vJRwjM1ouuEQS/wHOr8YJg2xjvHFtU
 BuIHtJCGNQUPpPYUuTv69WvyOyYlrV5nceik/1Ku8Qlh3LDXjW2JnesJIp6mqncFkxnJ
 y1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263382; x=1761868182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZLyqH7Fvcg+HojmfroD3Z/4L2yTHzsWHg7CTJ36+8Y=;
 b=YOSA0LviftLImizt3hl4OhVIBlBocVEGi63nNghV/y13tk5WVAYU2EpMIDFkUZ5J7s
 MXkuHqV9ubu0stIEVSAcZyObtBpOCzoktRzv3uObOF88SFpgyn5q0tstE+2g+/FncJhk
 Z43U/N9SVB48kNCS87fMHjXwtw+g3ueje78zGVNWa9GhMS+RmGkFQpjug2dgdSXNK9Nb
 WMoYFYBwXQF/EVsp+jKX4a8K6wRA+DhNP0HCtzU56da+ADrH71MCdFqeIIxKV6GcVoQF
 UXygscsx/mo271z8lpcHuMTsQ4E1NNAXiQatXNJ/tZCByB6zmZ6u0M+eWdpALSDOl7om
 2unQ==
X-Gm-Message-State: AOJu0Yzsb3auiaJW9KS7il9q6NQ10aCYDQ9Iks8Ve/WiN1uowkZIoOQK
 cTcIAPTD6pZICpnqhhjmWnR9okFZX2BylEQqwXxlstFf0z3DBnR/zETTatY3Mw==
X-Gm-Gg: ASbGncuYG5eYc8N60Xatsa2G+iMgRPlXFiP/Co4+iRPITsHoRjUz05huE1CEkChVKhR
 MWg2BunAUn43r/hXeW9dEPZMrV0Ii4ms2/fcpR+ixE3DyZA9X3GwvUEH/31CRU2rmFPg8ESE7qO
 t/dmoING74GiQLEr0k3phXOM6SCJJXs1dfjy+lElMTS7fIX5wq5he8Nr2oxL3p7PJXK0MN7sdGf
 Wua5SjjrtigmE+B+36RMCAL3j6EruxzuXiOoH+lKF8CQVWAH9ZSXtMXyALc8YiELScI73CtRAim
 hpuIsTdsS5y0lDs0B9xUHW+xwGiYzg9E8d96Fdn5nWQHdiTONI79NmjKdArkVsSWZWFYxkDeXaC
 0fyfETJcaecR88kXE3oIJvyIo/h0Eb5g1c4ocNtQh1ihxF1voJQl9xyLCxVuDBNQL+8F3lWzRCo
 GnjwoI4LO0j+oM3dxz2cm7XH6uiJ61aFkxMJdi0KzKdRDah6q4QsxnNpigfED3E3fM7OLvXo2Nw
 PblW7m8AggmDc6ojW8=
X-Google-Smtp-Source: AGHT+IENP9Mqj9caalooQAmmJliO2qoezCOuMLziy9RjYav52zqUybv00HCLj42TaPA/+MN7M3jmxQ==
X-Received: by 2002:a17:902:e88e:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-290c9cf35cdmr94912055ad.10.1761263382016; 
 Thu, 23 Oct 2025 16:49:42 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zejun Zhao <jelly.zhao.42@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL v2 01/25] hw/riscv: Correct mmu-type property of sifive_u harts
 in device tree
Date: Fri, 24 Oct 2025 09:49:03 +1000
Message-ID: <20251023234927.1864284-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zejun Zhao <jelly.zhao.42@gmail.com>

Correct mmu-type property of sifive_u harts from Sv48 to Sv39 in 64-bit
mode since it's the only supported SATP mode.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d69f942cfb..3e1ed209ca 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -176,7 +176,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             if (is_32_bit) {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
             } else {
-                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv39");
             }
             riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
         } else {
-- 
2.51.0


