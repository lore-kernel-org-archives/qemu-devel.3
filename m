Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FF5D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RM-0006Lf-RA; Fri, 09 Jan 2026 01:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PG-0003bs-0o
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:36 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PC-0002pK-9F
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so46219765ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941728; x=1768546528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gvz1AYsSRlSRUOCAg+C90sh3yoen61XYkAWxcKLYGdM=;
 b=Bxdh0M228kRNr9QN9tpergqGGOmqrb+VC7iD1dJodiqp5rORoTeT1Qi7dT2sG4Y1iE
 966FH1TGD+lo67RjSSzJr9OZVVp8HYjFYkWfMTg4f0E4eMnJWK5fLGim188SCyViFUKG
 nuc3Oh5w2XU5UltwsNIeGuobvcooIrKSy0jxtsyIlx3ys5feb3FvFumo/9Dgd/jgv3h1
 ZTGuxjtIl5xJQzm3uKI1egblCpRWyYuP5r9rV2jvqHsYN1oAicac7juCRLQQKEA/EQBC
 STHHIbUaOPgWfJqcCar6uFpuUv2T4ciBsOI4riwpqUoT7dzg2Aol+T0u3fhhK8V6MpA5
 t/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941728; x=1768546528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gvz1AYsSRlSRUOCAg+C90sh3yoen61XYkAWxcKLYGdM=;
 b=kJnjTmRirQldbXR84dWDeqEusVghfB52a0seQRkaZLg5ln7OWoMPTSkwvjSdVJ4IpX
 t9rjv6VjtEYxakhkEkBWy2Bbvhmxtf0d9Th5OmKVmEK1C7wj36B98byFllBW0gyd7okn
 xDkIoIOHKt7FSSLLNWM/tpt01hxl012z9U3nHaY31HlZ1R+v9PMii9dixhUiyc9SYQJl
 KaCgiQ/3CNApvDmi0lxUICQHisO5yMzXxHsxd3mR4kQ+jfSNb8bWaRrEATxXxY9jaTIA
 gj6KuG4DEtSdfjh/0awyjcFl834K4kI9bJnMmaE1K/GNhJerZypvsid+T6XkLRIIGcs3
 nXuQ==
X-Gm-Message-State: AOJu0YzRZ653GxGTU1xQ5K2s5IHea4t9dCpBBybcwT7FitCUqrLQs13X
 SMKluuV8C65A8TkrciUX2nhkiKwQlv2+6Ewvv5pNEISYuiNXGBMvF/A04LdLVQ==
X-Gm-Gg: AY/fxX5LexlIBcc1qUJp5mtGUPs4G4w1xR0o73vNNKfob1IPXKzNpbDRyp3W5MGgD1v
 3akCurmJRaIXplYFHm0TJfTHozfuoseKFgLwSCWyu4FCvz1uLrZjzXAFzBHOU3DjbjccLjKK5M/
 H+GIhmNiOjZdWer3MERM6RDhtjwEFfoAx+MsoG0H+Xmlmnd8e0fAeXvYgd4jCt3eTY9fKUyBkXF
 zPNg5wX2s1TOMB5iuBERyhIgENahzyqcSzO6dtjvwIb/wyJwBIKxi1d894uejM477H+544ublIF
 vYCVF1HSuTjFVZX/eHB/Rnyp9Tgq5elWsWs0MCBSocq8JB9th6MkuAnMtkEqK/EjeVGPHA/O/yP
 TyeZw3fX/+FblJUcDENFixnxmYVuYymDAzKmIQ2xrWJHIrjAeRpDX+ft68AUNZ1E5dP+6rz7gA6
 sgxvwJVengADDGobswGKdjdcpQ9BHOEcV3spujj+58rGspQ80uXN36xZ2VTT1EkQr2SJIuUPPJp
 vWjfGFvTir2fpbYQehUIF0vmwOeYA==
X-Google-Smtp-Source: AGHT+IGfWNcVcK27vE9NhNytajMDpXnIrJwXehIU0uds09XgKtNnnl5tj7gk4kiDw6rG/taKjolg0w==
X-Received: by 2002:a17:903:24f:b0:2a3:ec72:f462 with SMTP id
 d9443c01a7336-2a3ee43921emr83572075ad.25.1767941728479; 
 Thu, 08 Jan 2026 22:55:28 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:27 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/34] target/riscv/cpu: print all FPU CSRs in
 riscv_cpu_dump_state()
Date: Fri,  9 Jan 2026 16:54:31 +1000
Message-ID: <20260109065459.19987-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're missing fflags and frm.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250623172119.997166-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c22c418625..063374be62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -594,6 +594,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
     if (flags & CPU_DUMP_FPU) {
+        riscv_dump_csr(env, CSR_FFLAGS, f);
+        riscv_dump_csr(env, CSR_FRM, f);
         riscv_dump_csr(env, CSR_FCSR, f);
 
         for (i = 0; i < 32; i++) {
-- 
2.52.0


