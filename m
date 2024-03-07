Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF07C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4M6-0001S1-FN; Wed, 06 Mar 2024 22:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M4-0001RP-Ri
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:36 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M3-0005h9-2O
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:36 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7c8060a8489so22511339f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781812; x=1710386612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnskkX/gjRWt+FxpnLgMIRqQFGfGcaZlOIoSY38nl70=;
 b=WwM0Fu+oapuHo2qms3e75RKLxShHpbyLCdQOzyY0kCIAr2uEh5fsQVUZQHIS/VCkEW
 9Hu4Kt8YTCkdJRBnsefPCVJvKFGwqp9XrnS+Gt4prAaeOyQ3awTUnWiAz8SCUoAcaX4J
 exvvmWyKlrbX3Nxlmesl3aTvEQJVyIM6tqrx3K6qWI/tmUCflCnC1aPtrq20R9gH4m9k
 1b+ZSHj96bQcnoGz2jZ282zWmz9sn1Yi/x6SQa11bCUwnGorqVdTL1CR/jUF++/DD6Km
 CwW7yRc/1WMaZCGaclh24N4impRpoZN7AF+ehiZFgUj6OZBEyLgxvakCfK9y9e0VX4Ji
 edUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781812; x=1710386612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnskkX/gjRWt+FxpnLgMIRqQFGfGcaZlOIoSY38nl70=;
 b=DoVBAXWbOHInQS1+2YumFkeg+l2jBchlK4IYKh2WT+tlEA2u/KYiTIJSh84mTbr8bU
 VhhmtFMJxtT+jCSKvj6hMGcK0Jol69nE4v98PjwA7ruE8R1APy2YPgbyvPE+FE2xAlnb
 7CEf7UfOqs1Ngsn46GXBSzzOpL0nr72deqN/S7n0WOYtOOJpfikpDWPEMUunv6QH6WXf
 aZtXcEQc1UkqedHk6nZNayH0mhmezvj7kFB8hwd8ORbgPUB58+j2RxfIISy8FR5M0dxb
 /vTZikNG0wcFTWFsKhrJafEOhXA0oxYdw2DkEAFYNYHuui+uKnkOxkftHR5AO6g+T9W5
 YO/A==
X-Gm-Message-State: AOJu0Yzk/kM6Dzn1tb3nXmJJwG40JKP/oIp9ynyY4Eo7bO37AIALvsHg
 K9NCr87Chxl0MLv0dFKUibjX8dfRisFBJC+DZQiK9S+2//26uaRFhF6qsPpg6MU=
X-Google-Smtp-Source: AGHT+IF9I8+ld7Zj0CVkD+SdHCXFrx+PQ58nNxKYLdkEKoXCKzbwa9+rou/M+/JP5GOIpPfZ+U53Ww==
X-Received: by 2002:a05:6602:29b1:b0:7c8:5c0a:5e88 with SMTP id
 u17-20020a05660229b100b007c85c0a5e88mr10016887ios.9.1709781812459; 
 Wed, 06 Mar 2024 19:23:32 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:31 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 2/9] Hexagon (target/hexagon) Mark new_read_idx in trans
 functions
Date: Wed,  6 Mar 2024 20:23:20 -0700
Message-Id: <20240307032327.4799-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Check that the value matches opcode_reginfo

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h                   |  3 ++-
 target/hexagon/decode.c                 |  2 ++
 target/hexagon/mmvec/decode_ext_mmvec.c |  2 ++
 target/hexagon/gen_trans_funcs.py       | 15 ++++++++++-----
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 3e7a22c91e..36502bf056 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2022 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -39,6 +39,7 @@ struct Instruction {
     uint32_t slot:3;
     uint32_t which_extended:1;    /* If has an extender, which immediate */
     uint32_t new_value_producer_slot:4;
+    int32_t new_read_idx;
 
     bool part1;              /*
                               * cmp-jumps are split into two insns.
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index a40210ca1e..4595e30384 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -131,6 +131,8 @@ decode_fill_newvalue_regno(Packet *packet)
                 use_regidx = strchr(opcode_reginfo[use_opcode], 's') -
                     opcode_reginfo[use_opcode];
             }
+            g_assert(packet->insn[i].new_read_idx != -1 &&
+                     packet->insn[i].new_read_idx == use_regidx);
 
             /*
              * What's encoded at the N-field is the offset to who's producing
diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c b/target/hexagon/mmvec/decode_ext_mmvec.c
index 202d84c7c0..e9007f5d71 100644
--- a/target/hexagon/mmvec/decode_ext_mmvec.c
+++ b/target/hexagon/mmvec/decode_ext_mmvec.c
@@ -41,6 +41,8 @@ check_new_value(Packet *pkt)
             GET_ATTRIB(use_opcode, A_STORE)) {
             int use_regidx = strchr(opcode_reginfo[use_opcode], 's') -
                 opcode_reginfo[use_opcode];
+            g_assert(pkt->insn[i].new_read_idx != -1 &&
+                     pkt->insn[i].new_read_idx == use_regidx);
             /*
              * What's encoded at the N-field is the offset to who's producing
              * the value.
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 53e844a44b..8acecdb993 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -68,6 +68,7 @@ def mark_which_imm_extended(f, tag):
 ##         insn->regno[0] = args->Rd;
 ##         insn->regno[1] = args->Rs;
 ##         insn->regno[2] = args->Rt;
+##         insn->new_read_idx = -1;
 ##         return true;
 ##     }
 ##
@@ -84,14 +85,14 @@ def gen_trans_funcs(f):
                 insn->opcode = {tag};
         """))
 
-        regno = 0
-        for reg in regs:
-            reg_type = reg[0]
-            reg_id = reg[1]
+        new_read_idx = -1
+        for regno, (reg_type, reg_id, *_) in enumerate(regs):
+            reg = hex_common.get_register(tag, reg_type, reg_id)
             f.write(code_fmt(f"""\
                 insn->regno[{regno}] = args->{reg_type}{reg_id};
             """))
-            regno += 1
+            if reg.is_read() and reg.is_new():
+                new_read_idx = regno
 
         if len(imms) != 0:
             mark_which_imm_extended(f, tag)
@@ -112,6 +113,9 @@ def gen_trans_funcs(f):
                     insn->immed[{immno}] = args->{imm_type}{imm_letter};
                 """))
 
+        f.write(code_fmt(f"""\
+            insn->new_read_idx = {new_read_idx};
+        """))
         f.write(textwrap.dedent(f"""\
                 return true;
             {close_curly}
@@ -120,5 +124,6 @@ def gen_trans_funcs(f):
 
 if __name__ == "__main__":
     hex_common.read_semantics_file(sys.argv[1])
+    hex_common.init_registers()
     with open(sys.argv[2], "w") as f:
         gen_trans_funcs(f)
-- 
2.34.1


