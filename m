Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BA2C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOyR-0004Xv-4G; Tue, 23 Jul 2024 19:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxw-0002Ko-0l
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:45 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxp-0007xu-Mj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:42 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-70b2421471aso710069a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777431; x=1722382231;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T3wPalTrTfAP9mml+0G2G5CLa2ONQtu46tPm2ADYEhI=;
 b=L9PzayC7WPYgjkmkxrFLf0By50EzcySZ4L+p5WMiWvUsDkZUeWRAji3UaXVZ7eVHZ2
 3I29EOU180h9yboF4sB5x0rqB9Sgum+PqOv+pZhINW8iKBTLuhv+jNdyDTA9+hQLrfht
 Js0cgQap5xOHueONuB9WeSo8Nu6+OMOGFVSz2EAK68358FyWmtxlL/39oSXLwek6qvkd
 Ok9S8kAIGdIwE541K5HTmcDcDojzbyA4dmDYrlDXllkajRcDZaKAmZdz0gyBdxbtBwmO
 paBtj/IMYQt4DLXhHAgNZz6bynWS56Y1RF4GXe4yS7hIF70/sbmtRYlrUZXR8qW6jy4J
 lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777431; x=1722382231;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3wPalTrTfAP9mml+0G2G5CLa2ONQtu46tPm2ADYEhI=;
 b=JzioIzfnr8B6WMP3iMWo8BT5lkHfjW8r+6Aje3TIEf/eKmf+w41ilDe576oGhmONDv
 YP8Yn0SgCCtKMB7J0XjmJsiHRQUMxS5hYiDU66D2TMrniRBpBZ7op+cwZ/8U1PAiTRaS
 eVy9R1iAnmtmeqF6zFNL9SVVSc1vlRxxTqH3rpSa4L/nnnUUIg5JqwfncDHChvp+eqkm
 oB52i62bVP41eyAUtNgk0wRr5ihC/SWsvE+k6Y6gpcDHWGf0U9DN2f/h5R3DFEe+Gp20
 VRu2Emj+mQ2E61s3NWXZnazLq+DSReYfzk11vp5yi5Tr4DCiGPAExHRMrmMdbaeZtusU
 sXjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlwlsQhj0AIozzqXoNMjoXwg9KYWiowmzDW6SQcrjfHr//7Z+dXyF2J7upso/9FP6KGblNiF0IV/gHjzb0L08YZN+ggyk=
X-Gm-Message-State: AOJu0YwiBbmyzOtcQg7vECRsZI+cE6awrz+R8KPPW8tdWVq6bZOJLuyr
 rsXb/zAEt03HtfBCoTKn6aLtUMwKzUnkSwngnlrxzYQsvT2A7baZngWgDmMcmTsKIZisaicdjeu
 g
X-Google-Smtp-Source: AGHT+IElPfelTOZkDhOJa8WCZlRLBE3szMwqKi995ymecoVThCSkNwjVSzUy6QXR71erWMs2QkDt/w==
X-Received: by 2002:a17:90a:4b48:b0:2cd:3445:f87b with SMTP id
 98e67ed59e1d1-2cdb51afd8amr605297a91.29.1721777431556; 
 Tue, 23 Jul 2024 16:30:31 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:31 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:07 -0700
Subject: [PATCH v2 10/13] target/riscv: Enable sscofpmf for bare cpu by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-10-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Sscofpmf has been supported on virt machine for a long time. It is
required to enable profiling on virt machines. Let's enable it
by default for ease of usage.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1731dc461376..393d1d67120e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -494,6 +494,7 @@ static void rv64_base_cpu_init(Object *obj)
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
+    cpu->cfg.ext_sscofpmf = true;
 #endif
 }
 

-- 
2.34.1


