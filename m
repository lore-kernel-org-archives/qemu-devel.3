Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9542AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehPq-0001bt-Jd; Mon, 26 Feb 2024 15:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPo-0001bE-Vw
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:33 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPn-0007zS-2X
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:32 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so2686305b6e.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978648; x=1709583448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34hyOq9fT2wY/9uJL975rSySKZ4ZdVHzRHf6WhirkXw=;
 b=CYbgfOBa374bDvWsey0snO37YHu/6zF5sC2oeVjXU+G/McgbCueSFd7g73DxBQqR94
 UI9Wkk+3tfE2g9vdR96nW6a4nXSMdcZwswTpzQ8JylO6i8Oa0Erdf+gzuG1s4rKwo4ab
 TBpqXrrNeKFKGBamVR15oZkV6bQryQomnl0xWPCZd3jUpEKG5wVVDjfCp42P8JPGbvMc
 nGpD4N2JKPqSgeoopwbU8Z4/gmRdGjeTb9GFD5UKLOiZwgLiFYCKXSW+ClcryL8kjADI
 8j88n3JGJndH/inHk1+cdzwHxlRO9yb10RgsYZqBvHdNnXHnjrqxWQbBXraXxQNo1D6i
 6d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978648; x=1709583448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34hyOq9fT2wY/9uJL975rSySKZ4ZdVHzRHf6WhirkXw=;
 b=OKlfnp4yOGxivsWHz7/D67ppJQUWXWCDRJhE5WIpL+QnZltqJHLaFAV+ZwCmyXwEIj
 3drtPSMbCvgV6ILZ41+wOkYhWpm2BfR7ocdWpcuMvJnJC2gUQi4hnUtSEbB4IDnXDVQv
 qa8QDjMFvjYTXQlHGeTVHeqqZw+tZa6u9wspCsY8+laj2R4SEPNY29U7+0l+1wJ7dYAQ
 qZ52cZf8q3oXw4CnOBN8PiTNZysZw1iDFa7TmXITs7NFQ0fraNioWrOkpk2O4XBD/6Pc
 //bLYhIc3t6+BcaE4/bZqdbh8WcQ5Y1MwiGkcWW5ZyxvuVyi7wQK/Qzf4muq5BsgeZnB
 SGFw==
X-Gm-Message-State: AOJu0Yw/kF/+8H9a/emgipfI8EADYg06cC7n/yhXKt9aB8AllM5dDEZt
 czEURhbq0Pljt8ri5SZ6EvJOWdG3a+5a5/ZSzvvlBQyoMXSdRX5X3bfnI41Rq5c=
X-Google-Smtp-Source: AGHT+IFMnfcuz/BXJtpbev/b7IA7y65QBd6hv40SImK1PfsehBx87OTUNsQ85p/oxW3H9HrvbTYHhQ==
X-Received: by 2002:a05:6808:11c1:b0:3c1:78b0:9ce1 with SMTP id
 p1-20020a05680811c100b003c178b09ce1mr264941oiv.13.1708978648442; 
 Mon, 26 Feb 2024 12:17:28 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:27 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 2/9] Hexagon (target/hexagon) Mark new_read_idx in trans
 functions
Date: Mon, 26 Feb 2024 13:17:15 -0700
Message-Id: <20240226201722.391879-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x230.google.com
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
index 53e844a44b..79475b2946 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -84,14 +84,15 @@ def gen_trans_funcs(f):
                 insn->opcode = {tag};
         """))
 
-        regno = 0
-        for reg in regs:
-            reg_type = reg[0]
-            reg_id = reg[1]
+        new_read_idx = -1
+        for regno, regstruct in enumerate(regs):
+            reg_type, reg_id, _, _ = regstruct
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


