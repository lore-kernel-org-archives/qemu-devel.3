Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87AFCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdrX-00046V-9J; Fri, 02 Oct 2026 10:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdqt-00044b-SD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:09 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdqs-00085Q-8a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:07 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ed9866so52745185ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790949785; x=1791554585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lvy3IrBhamz9amZ2f3O3x+9agIBxUCBT8qgB7MqI9iY=;
 b=oUxUiyA2GiqZX1CrOZFZ/hKPbGCo2X8JBMTs/ffSTRg+qICiZXLZC8rZB4YLEZVHMf
 Z4p6xUGWGqX1p7NEl0FcyfEa4hAFT9edg4ZCNw3NK9eFgFTGfT0lCSXfhLYSDwJUT0V9
 8/oxkCw3KHj0w5QNs33ftJdZP3FbdveI8lj1Y1bOqazhiiOO1D6FZFnqg7OumCNyzOaW
 YvF6pnpg21OfSeq1SQxol9kI7moJAk5aYPnI1I536ARFOopWn3yqZ5Y9DsZhmPlRkedh
 lBe+RXvCxTTn6tlIfKLoaK+h5wn14le6+Ws7DouTV3r6sIgVPQNEoFJPzhHAP1pT54nH
 d6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949785; x=1791554585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lvy3IrBhamz9amZ2f3O3x+9agIBxUCBT8qgB7MqI9iY=;
 b=bf7wr18YfzQHN+kKWj+jnT8WUOf+gQnyO1nsooLKm4YVSBVfjJV6fF8kyba6jj3Fy2
 hFCOfKCSjTDWm75pju2akk3BZctLEVNQGcm3Tsn3hD8MXvB4kqeYlZyjBrfALQqPgVCk
 mhg2yLwHfy+oYCGap9Qgd7oGIMT2cT4AuoG2Nf8owYLxrJKhxJ5oZ3OSkdqI85fZ2/pr
 hbwR5gawOY27JGkoz2h7wHOV9QAwromOzCXSqex5m6+uxiG1VK2JGIdMXzIJ0sh98tau
 5FuxGz0EViuU8cWqDclvtRPgikDdJSDrqwGmAJniJDRE+u8RB+GUBCK3HkLQwN+eUZ77
 rerQ==
X-Gm-Message-State: AFq9FYLmSOB+yW3yfkB5zssUv17Kr0FUG8KVGaYSXejbmaD3RbhDHPBa
 sT3AmRRj2VwHuHt7atIRBwiBaTKeU2bdDHDGxG00NrCcAtFb0oI/veituUOTm7W+
X-Gm-Gg: AYBFou2C9x2Ir6dzatDhKFHZuw7vjA89LJYcYJIOwXKQmteDDFahMQ6bxHuh8DUa37S
 trQd4Hi3/lHxgukJiTiIRH8yu6X0MjfkyzqUoKZXM/6N5wE+p9gLizZyydnsI4CFYRrBiMOfvyL
 t3UbbVXrJEasLMbngWOHhZfoh0ctCEeTUK/Tu7x6Elk90I+KoTItYVj5zhVwXKx5tgbHdyA15ny
 tMvy/m3N/iowc7VnUcuGynsM2ruC+UFRNPQJdF5HuizUZhT91EChPA58rfJor56QD+QVngjJb1j
 gVEX5nJDQiMUu7WdFZVuT3nihum6aGlZL6STFXItloHrqb1LfljDDSxXXdoqP3nRHxd3fkAHPH3
 tibaG4HmpmGfIF+opwGX95EVLtoYCMPTeWVZNHCl1tOTn4lLCFVW5t7CX4peu3L00JaGuutK2Dz
 Fm8cNKPbA/GorPdmMe0J6lLUNiuiHF/iWcdnLDQAMSdomh4LeZaJiAZI03S6boLSnXtlPT5kZAh
 SvCkhmZuR4StyAgxgkmst9VsMU=
X-Received: by 2002:a17:902:d98c:b0:2e1:2f69:b6d4 with SMTP id
 d9443c01a7336-2e49b4e71c0mr26961905ad.15.1790949784618; 
 Fri, 02 Oct 2026 07:03:04 -0700 (PDT)
Received: from dt-VM.localdomain ([101.207.27.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f723a77sm7996165ad.71.2026.10.02.07.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:03:04 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 2/5] hw/misc: fix calculating input address overflow in
 k230_decomp_gzip
Date: Fri,  2 Oct 2026 22:02:42 +0800
Message-ID: <20261002140245.30214-3-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002140245.30214-1-dingtao0430@163.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use hwaddr for address calculations to avoid 32-bit overflow.

Resolves: Coverity CID 1685517

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index ac06cc1571..da4dc6f954 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -59,7 +59,7 @@ static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 
 static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
 {
-    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+    return (hwaddr) s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            K230_DECOMP_GZIP_SRAM_IN_BASE;
 }
 
-- 
2.43.0


