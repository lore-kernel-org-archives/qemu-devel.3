Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11EBC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJJH-0004ky-Iy; Tue, 21 Jan 2025 13:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJD-0004Tu-Ek
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:07 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJA-0005MX-LS
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:07 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163b0c09afso109645405ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485343; x=1738090143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rvu1CgqxV7eAphnSN54+tDhlM3TA+qR/gcxjkFnEWjw=;
 b=LawOKZ8bYvT3S9S4oniFLOjamUu9VCrSOAdyl7RNzeR4BWeWqbnoNNLx+4kJSagZIW
 mK7A+9Sk6wkkkAGZ95SXomlC4X9CDmqIyFuwzc6q2jwfNVvownhiqCpLJqs890b0g4P6
 AonuO10IpvE+A7v+lcQufQeEmtD4WGIabUoO61vxHTvIoay3BL2iXmdDBOtQkj5YFqea
 H1F/DHmmhd3jBkhaDIq7KqwqYbrGX/UbW9sS7K8MYR7QwB+t1YTiEVptIktgvRpOhdtn
 Rx3N+qyeuS7W/EjYwhNp8/vj49HUhQ2eprhJLhKrlEtn4vhgKd83OkcYk/MNAv2k9sHZ
 At/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485343; x=1738090143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rvu1CgqxV7eAphnSN54+tDhlM3TA+qR/gcxjkFnEWjw=;
 b=uBdCRFVK/MEer2of4HNlx/t39M83OAWn2a+fnXkCQ2Ufw+VsApZS8sVyjd32naFNGQ
 WDoyBXmDkC/kVjNj5HWJr/aorBMDWEK5pUmN1m/VA7n/CQRn0OwyKeIkQQqFnNRlC6QQ
 x3VpO7YnoS82EzlxGb+yXg4BYkfONZBrJA3QMHVhHJUsKlAWLOWR1i6ftKyFhu96SSZC
 SPto7CJQRRYW+63PoRiL5BV+R3WcfebXrz9itR3flAK3PVtG7CSsUpusMgMY2GbdOta7
 m9hT0EUZRlzkSJlg8hl57j9qlAFzaojmDqP45g/DcJWC3bocwoQyCEpFLqzvC0EblsHH
 q5dw==
X-Gm-Message-State: AOJu0YyotD1xsdHIBrIbH4PF3/sZI6HzUzRml5TEvNbhLFK0uI1+oh5M
 XCiBI1YJ8ArgVNiKgX+ya0zEdYXYwt+3Sgi60DG9RDh8bHoJwyhdF/OfyVVfxcNtQjxipINB1pc
 w
X-Gm-Gg: ASbGncsvWmPw5xGBSLSWjAejhDZKxbxdR4Jkz0adyZIFxmRI+ZCR2A9UD11SxbEtQLN
 x8a23/SH8EsJDL0V1yBZUskFc/xFCORJCviMRtrBcBLflswQ4lBb8DRC/0SR4v7bFwb9okiW5fu
 Om0k5DqenjAWiWahn+TdcIxf93nl03P/MdlN76v9Y1mdsZq1ylMRroI6gL/Tdy129aWxkAv74Qc
 qSJcW/+ClHdRYXwnBvOtTDfoOFb7FqoAlMRUwKeuA9tav/tK3hZYeJvXsN/duAJeMbd17t6
X-Google-Smtp-Source: AGHT+IESP4i3tbzPGF4yXpQslSMUUd/AhTFYAxFzW9c0AJWvrEVtRb0L/dJKlBg3b8stpphikzKpZw==
X-Received: by 2002:a17:902:d501:b0:20c:9821:6998 with SMTP id
 d9443c01a7336-21c352c798emr324610145ad.10.1737485342075; 
 Tue, 21 Jan 2025 10:49:02 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba56asm81121865ad.98.2025.01.21.10.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:49:01 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/5] target/riscv/csr.c: fix deadcode in rmw_xiregi()
Date: Tue, 21 Jan 2025 15:48:45 -0300
Message-ID: <20250121184847.2109128-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Coverity found a DEADCODE issue in rmw_xiregi() claiming that we can't
reach 'RISCV_EXCP_VIRT_INSTRUCTION_FAULT' at the 'done' label:

 > 2652     done:
 >>>>      CID 1590357:  Control flow issues  (DEADCODE)
 >>>>      Execution cannot reach the expression "RISCV_EXCP_VIRT_INSTRUCTION_FAULT"
     inside this statement: "return (env->virt_enabled &...".
 > 2653         return (env->virt_enabled && virt) ?
 > 2654                 RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;

This happens because 'virt' is being set to 'false' and it will remain
as 'false' in any code path where 'done' will be called. The label can
be safely reduced to:

done:
     return RISCV_EXCP_ILLEGAL_INST;

And that will leave us with the following usage of a 'goto' skipping a
single 'return' to do another single 'return':

     } else {
        goto done;
     }

     return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);

done:
     return RISCV_EXCP_ILLEGAL_INST;

Which we will eliminate it and just do 'return RISCV_EXCP_ILLEGAL_INST'
instead.

Resolves: Coverity CID 1590357
Fixes: 5e33a20827 ("target/riscv: Support generic CSR indirect access")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e83c3b045..75f21ccabb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2621,7 +2621,6 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
 static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
                       target_ulong new_val, target_ulong wr_mask)
 {
-    bool virt = false;
     int ret = -EINVAL;
     target_ulong isel;
 
@@ -2642,16 +2641,11 @@ static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
     } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
                csrno != CSR_VSIREG4 - 1) {
         isel = env->vsiselect;
-        virt = true;
     } else {
-        goto done;
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
     return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
-
-done:
-    return (env->virt_enabled && virt) ?
-            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
 }
 
 static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
-- 
2.47.1


