Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BE9D1D879
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jkc-00012G-HR; Tue, 15 Oct 2024 11:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjw-0000ZI-Ql
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:47 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jju-0000lj-PA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e18293a5efso3805787a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007136; x=1729611936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QllJIAKdtcEv9cjfy79RaL0PjX8KiZ5Hky2rfsQ2CVs=;
 b=jRo+660Fcc4T94JesVWlyrX0qHX9aSlKg+7M+Kog27MRgXebx3AahZ4mzSROR1X9/a
 +B1yHpbfO6OF2bli1mO0ZEMyxLu6PNkBZbNiIUoczWN2Kex9h75v6s/EDeGVuG34RP0L
 WxAVns0QPMyeOCp4IxrTy+a1rmjWOY2OdXSKM41KIcWYzaZVrP0HEbUMiKeezP+IIDWY
 0jBBijD6ICdEtU4I8QzDaCAiQqeEk7EG8+Vq9zKUwdBCzOk1ERWIyYEUUzIupmKRqTvb
 5CWdzsu+BU/SarYCAXXJqkARqWc+HjTzyvMDAnVwfJvPd87u9hCuUJjHFdaa3kCM7Cky
 1DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007136; x=1729611936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QllJIAKdtcEv9cjfy79RaL0PjX8KiZ5Hky2rfsQ2CVs=;
 b=m/AKkCPcpkVVOEp/id4u4WVDauRSI4gqybmZfECGR7K5Fh7PNCEtF5dO4S/RxElhDv
 7t9Altd7G9RG/dnIh6/sgMqNTprg7dwshmJDjUtR6e4lt9i+3UnEMOWNVNMvrl/d0uBz
 +nl6cYRKBUpS+iypSmw3JabaoaEjX7DfT9DvP6AK1WN27JqvTPvHN6zoNC8S/cNlq7Fq
 2Jrv8lKnkBiwwF71/wzzqkiek6gwO8/onvNQ5WxGdJ7Zu0/P9rFFkZJ8XdXlaYVKD1RP
 2RA5bGqTFBxBH5Zrnk91KPVfMsywKEiwMbPuyEldmyG6kTm0PpdlR1pDlVOTw/CBXEFv
 2iOw==
X-Gm-Message-State: AOJu0Yxl/T20rklenr7g6OE+x3m8xNzR5mQbH0IC7UV+l90unLu3wysf
 3hPTG4NgMajHV04s0X5VOyzyu3DHxZhQORg7cZeY9CvBYZ8U+isg4w4dOak1CoOCwjfWNG9+yMu
 j
X-Google-Smtp-Source: AGHT+IGoiM3T7PO4dBDPTAumqjeRvoJ/C3ysODdyeGfz8ofQdxoecEGHWQH5+MR87b5qgCo6YVKk1g==
X-Received: by 2002:a17:90b:4a46:b0:2e2:bf7f:3369 with SMTP id
 98e67ed59e1d1-2e3ab7c7935mr738147a91.5.1729007136172; 
 Tue, 15 Oct 2024 08:45:36 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392e8e40dsm1961107a91.3.2024.10.15.08.45.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/33] target/alpha: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:16 -0300
Message-ID: <20241015154443.71763-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Alpha architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/alpha/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-7-philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index bf5091c2a6e..1a7e2dd9202 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -59,7 +59,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong tmp = ldq_p(mem_buf);
+    target_ulong tmp = ldq_le_p(mem_buf);
     CPU_DoubleU d;
 
     switch (n) {
-- 
2.45.2


