Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742C3C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdwr-0001LE-KU; Tue, 04 Mar 2025 20:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwp-0001Jo-Lo
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:23 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwo-0008KV-4Z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:23 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2239f8646f6so64289125ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139600; x=1741744400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHDgly9sQszED10pugyis6zMJVVAhpUJBdFueBMt+lA=;
 b=hCEztbZyMBZf/kZVf4yh8aEITdE2lXCYfFwCQVosM0Uh8ihlhEaCOvh50PJR+X5F0c
 Ot1j1/kD9r1K7YC0vYXVEinkS0ETKki0OWdrdrTZ0BP6fFoxGkiqxFbAoyZrts6cbjFc
 iUOC1nWlkgHHvE2Orx2qP2AWTtwMYNo8L92J0iEFJ/HbCSOB3U/IErZHPBBWHMDPUPXB
 cO1pcPgQIFdbaKlKDTopjqJf7XxlfkTU7uryxc5ue1KsUiGS6iE3P2ctm0Fx+Qxa1gm+
 xjorH37SRN4qs0rChAqj8WFLutp5Avd7uHKEpvLQ2iAGCuxlGibb1JjnBunQ7BisYCem
 od+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139600; x=1741744400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHDgly9sQszED10pugyis6zMJVVAhpUJBdFueBMt+lA=;
 b=Lpiul8tADAag0w1/OqJ81cEdfI5TP42ryKP0PrGOQj9DnRpEJQuxX925FeuRn/brlK
 azZMTbhIaZDrOm3c3KEr9u9f4xwT3ViG5bWIivqnrTvg1w6tPZ6F84jD+JCbgYv7t8e7
 Bd+ORDU892t80zUfcUn0P48ZGWbObxXprYKUb1nQRZLuP2RZOO1l/+mktAXjmNLUHTtT
 SLVevnzDk8PecE0Ek8Y9u132VgMSV8vWmlxCjOotQuBxuqzC2sGV4P1kHIu3QPSEC3V+
 uJBRWYpbHnwOh+UO+Hq04CP/fw/d3RThdmANS/4ppSkgfqVs97zsLtjwqMrtVo+uiNwI
 FPDA==
X-Gm-Message-State: AOJu0Yy1pcSLsf4t+SwFdd00OZQt8svvtH2KJDbw7SKt0OCXocoxQsf+
 pNG+BPMNKV4BNSX9jIyY0dfBQeowLt5S4ixTqhL7sw6niBdg9JveNj4Ch/e9Lic=
X-Gm-Gg: ASbGncslqnbxmDH5RUW2eTqIO+qZFVRas1CUIwRVTFMjj29yuuBzvdEWDqRh+D/AE2D
 fy2w/8p15E7A7riETViQDtCI7i+kpwtdYxbI2KTLt0h44TCjFOwVZFa3mV4062LUa1Vk0PXwitX
 fhUtkYtM3tS89LIYC0WV6WeeMZsjzllxCREicK5qwGRne7/Qd83v9faEqJeJid53vBjZj6IPGRX
 nQhpGrqVUh8ap6YROAs6IYHp5BiRkKLH76dAYSkJC7NXCU/37ewGmjjmXRPfvcXS/BuAncL4wSK
 QlbK5nRQRdeBQoieVOWIPjowLQv8gBbbVwXHvWmZfh9iF8h4r1eoWhyPI7ABsoQHNXwkp1/Eoia
 MoyiVD+8B4tkhHUoZcOdjfIB10kziSSYBe7dFK7RHdp+4ztspVbA=
X-Google-Smtp-Source: AGHT+IFWpBZSRWeiQauEvQ8u+vKdi6hibUxVmecoB/J52REhMH3YqUTXaW9rlV5ZdkTHeQbgBw93mw==
X-Received: by 2002:a17:902:f693:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-223f1d10941mr22187645ad.43.1741139599959; 
 Tue, 04 Mar 2025 17:53:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:19 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/59] target/riscv/csr.c: fix 'ret' deadcode in rmw_xireg()
Date: Wed,  5 Mar 2025 11:52:10 +1000
Message-ID: <20250305015307.1463560-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250121184847.2109128-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.48.1


