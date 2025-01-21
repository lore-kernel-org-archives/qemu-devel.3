Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F2C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJJC-0004Nl-Px; Tue, 21 Jan 2025 13:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJA-0004J1-Cj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:05 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJ8-0005Lf-Da
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:03 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso97277105ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485340; x=1738090140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7p6XN2M1MHDl+uW3Q8gV1olbYzbSDmoR29h4KhBMQc=;
 b=Ik+7h1TjTvfHqJrzrQmdPA/q7PFJzbPaw7Eql9kxBaYXRZC21JW9QDSfHJblvosq2X
 z+kJxtNhqIR2jNuisuWhC/xdLWy3jh277Rh6JkwFA8ATDbqWPYeTuJaU+aFvrhZnDh+0
 CJoQREkdsGPrnWOBGtot9BgIn4AfxldwRRiZ9WF5eTxtEGqjot/qkAwKm8FzQLuZd5Lc
 jsScc+7WKMzRLSRG/Fmdy9EdxlHWeteZfpqSF+mIaGpxtyCyk3AqAT+/5osR/po09qRs
 O16L9Jw5aDkxnbUBR4gzcf1f8mmnNc1if/Ev7Y44e2nWubhLUDO6S9nlzEiXatTwrTfj
 PXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485340; x=1738090140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7p6XN2M1MHDl+uW3Q8gV1olbYzbSDmoR29h4KhBMQc=;
 b=GG+i/CqIUAzYVUQKQc2IBx3PjG80jjS07kFnE/hWgD6EhIh9/Bjq9HS7spDPSRgHOq
 kR/geR/NqmJuqAEdDaGFb8LVOkv2uCROmlFu8fKF/0VxIYOyYzPJD0DZJl5ibHrVMMjz
 QFKnN0LFiXQ9eB6IRI2Hy4VGpztZL9MmFNuDIMwyxZ1V+7tDAVg2FzSOBcxIBUpdu2Tb
 N4yyw8RkOJIB3hd4cIUmZJ91dwSDcMargW/MnJ+GKFB4bPW6lx9MD8WCpi+EARkT/kby
 ElRkZGR54AyMaPeydTeI4SX4o5socXg0j2EQt/tDVr/3dWHVPn0hNvXd80yfElseygxc
 kpDw==
X-Gm-Message-State: AOJu0YyTBcNqxtBcfSAPVqJY7GSkCxGMT+kpONBUnJnLT7inPKiOE8bO
 doH6YACC2AgDdc9VFUvT7xASPTHPdbaDgNke4m4V58VafD2F+xFb9TKjzYWw42D2bbdhLPrU3lx
 1
X-Gm-Gg: ASbGncug48RRacjq2qa1uok9haRubBN2gX+dKr3HkrmK4RSdS7/rK0oYN2KH9J2enxU
 SGFeV3GyoQFad+qDX0kcQAbkQccZzhfaS1Oyb2AiFucEwXhXTThuf3SKeTmxfLLOhD8psAAdGDB
 XYUusLWyjUf8jQtdzwyWI4ei2eaYIgASlCGeDY1MmNtOWzSpKDnXkhm4HDWn37Kf8GGG1JObsSL
 1W2iT12+X0Pf/kex+WBG4GghPrZxZwf8gG9XMPkDj/bcX0k9GfZ+nP4OR+jlGzrnUx7wFr9
X-Google-Smtp-Source: AGHT+IGjZINNCRqYFGKCPRTPV2ftktRkwXOddQC1o0pW7jBlTkWZL76wtIGdjPotYqX8nqo/7itOSg==
X-Received: by 2002:a17:902:da87:b0:216:501e:e314 with SMTP id
 d9443c01a7336-21c3540d181mr266638255ad.20.1737485339030; 
 Tue, 21 Jan 2025 10:48:59 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba56asm81121865ad.98.2025.01.21.10.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:48:58 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/5] target/riscv/csr.c: fix 'ret' deadcode in rmw_xireg()
Date: Tue, 21 Jan 2025 15:48:44 -0300
Message-ID: <20250121184847.2109128-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

Coverity found a second DEADCODE issue in rmw_xireg() claiming that we can't
reach 'RISCV_EXCP_NONE' at the 'done' label:

 > 2706     done:
 > 2707         if (ret) {
 > 2708             return (env->virt_enabled && virt) ?
 > 2709                    RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
 > 2710         }
 >>>>      CID 1590356:  Control flow issues  (DEADCODE)
 >>>>      Execution cannot reach this statement: "return RISCV_EXCP_NONE;".
 > 2711         return RISCV_EXCP_NONE;

Our label is now reduced after fixing another deadcode in the previous
patch but the problem reported here still remains:

 done:
    if (ret) {
        return RISCV_EXCP_ILLEGAL_INST;
    }
    return RISCV_EXCP_NONE;

This happens because 'ret' changes only once at the start of the
function:

    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
    if (ret != RISCV_EXCP_NONE) {
        return ret;
    }

So it's a guarantee that ret will be RISCV_EXCP_NONE (-1) if we ever
reach the label, i.e. "if (ret)" will always be true, and  the label can
be even further reduced to:

done:
    return RISCV_EXCP_ILLEGAL_INST;

To make a better use of the label, remove the 'else' from the
xiselect_aia_range() chain and let it fall-through to the 'done' label
since they are now both returning RISCV_EXCP_ILLEGAL_INST.

Resolves: Coverity CID 1590356
Fixes: dc0280723d ("target/riscv: Decouple AIA processing from xiselect and xireg")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ab209d0cda..0e83c3b045 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2697,15 +2697,10 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
     } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
                riscv_cpu_cfg(env)->ext_sscsrind) {
         return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
-    } else {
-        return RISCV_EXCP_ILLEGAL_INST;
     }
 
 done:
-    if (ret) {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-    return RISCV_EXCP_NONE;
+    return RISCV_EXCP_ILLEGAL_INST;
 }
 
 static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
-- 
2.47.1


