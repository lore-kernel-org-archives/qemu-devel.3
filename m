Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CACC5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4M6-0001SR-US; Wed, 06 Mar 2024 22:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M5-0001Rm-DT
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:37 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M3-0005hL-QX
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:37 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7c8406e4745so19124339f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781814; x=1710386614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuAflH+os+yu0r/DJ/rQ7cJGHjxjAdD2yR1xW/PppVE=;
 b=GeIEYNPEtZ3TPW8ZH7eLTEIuzDSEmVT2YiECjzLR7AIqE85dEKy+z86GbfWFhXP+cG
 Z4oLNr5Zzx3SvIQCcjfXGP0AMBcRdq1+qWEVrAeL5seiC63WV+6l57wy8NWYRpLgOWBa
 nwXZ9DEB6HlG/mCqYIKoRcNn2ArBL81ssVJewLRXKgRoCR5J0MKl6KqG9xIumxZNg8Ct
 i4AgbS5Cztd+wyGm0x72KshX2S4EIAzj05RKw9aBFCt94VfKQvX36vNRihFykwPFJbc5
 hCvoaNm8U+Raz0lJzZ4noq3JQ5pnYOVEgdxOuiZV/TFAjp5xO9uESgGXXwskZqlZ4uf+
 hD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781814; x=1710386614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuAflH+os+yu0r/DJ/rQ7cJGHjxjAdD2yR1xW/PppVE=;
 b=kNYpcuqhhUvAx2hDs39Hu80O4NzTBLjSt9StIMU6SKX5Ugtmw6ayoH/l6+rnOUYvHe
 UNoCKTrjsTCPwudLHxNw2mehTIJcLqExTr1/gU7u+i/71bgxF0KSU5+O7O6p1Bz3NhgG
 V6wfAleA39AGTVvrr43quhNH2sPvzrq6wABqgmInGk7CL2K56ls53eyGpPAGOOvofaXJ
 1qAH9BGxnr7iDuiXmHaWHnEB8viN3qZ4oL+HUwNoy/XOkDPPIUvIR6dPZd7gQJbsYqbF
 /bIQEiTDevLIiYDVVyhml1BwM9UVqmMMY91Sbb/NgjBUUjl6OVCDRFMYw2FjG31Ii0MO
 EpTg==
X-Gm-Message-State: AOJu0Yy42o8phCabHSpN0ClmodCwJ64ZImhlz2w55/3TFowMjdcXxY4g
 /wiH4CxSxPLLGorMUj5WBKqZ3q1Ah+mc0BI7OOOnonC6/3ZF8zAdPNmaETPt8yM=
X-Google-Smtp-Source: AGHT+IGbspPuomrW2XwnZZm1g8AoGBUSSlCeJ7/Vrxmu/ZV+VkudxmUEgDCmLntFz7SJ57Dr6UwTGw==
X-Received: by 2002:a5d:9519:0:b0:7c8:5972:6e0e with SMTP id
 d25-20020a5d9519000000b007c859726e0emr10175058iom.15.1709781813866; 
 Wed, 06 Mar 2024 19:23:33 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:33 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/9] Hexagon (target/hexagon) Mark dest_idx in trans
 functions
Date: Wed,  6 Mar 2024 20:23:21 -0700
Message-Id: <20240307032327.4799-4-ltaylorsimpson@gmail.com>
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

Check that the value matches opcode_reginfo/opcode_wregs

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h                   | 1 +
 target/hexagon/decode.c                 | 2 ++
 target/hexagon/mmvec/decode_ext_mmvec.c | 2 ++
 target/hexagon/gen_trans_funcs.py       | 6 ++++++
 4 files changed, 11 insertions(+)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 36502bf056..a770379958 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -40,6 +40,7 @@ struct Instruction {
     uint32_t which_extended:1;    /* If has an extender, which immediate */
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
+    int32_t dest_idx;
 
     bool part1;              /*
                               * cmp-jumps are split into two insns.
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 4595e30384..a4d8500fea 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -184,6 +184,8 @@ decode_fill_newvalue_regno(Packet *packet)
 
             /* Now patch up the consumer with the register number */
             dst_idx = dststr - opcode_reginfo[def_opcode];
+            g_assert(packet->insn[def_idx].dest_idx != -1 &&
+                     packet->insn[def_idx].dest_idx == dst_idx);
             packet->insn[i].regno[use_regidx] =
                 packet->insn[def_idx].regno[dst_idx];
             /*
diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c b/target/hexagon/mmvec/decode_ext_mmvec.c
index e9007f5d71..c1320406df 100644
--- a/target/hexagon/mmvec/decode_ext_mmvec.c
+++ b/target/hexagon/mmvec/decode_ext_mmvec.c
@@ -86,6 +86,8 @@ check_new_value(Packet *pkt)
                     /* still not there, we have a bad packet */
                     g_assert_not_reached();
                 }
+                g_assert(pkt->insn[def_idx].dest_idx != -1 &&
+                         pkt->insn[def_idx].dest_idx == dststr - reginfo);
                 int def_regnum = pkt->insn[def_idx].regno[dststr - reginfo];
                 /* Now patch up the consumer with the register number */
                 pkt->insn[i].regno[use_regidx] = def_regnum ^ def_oreg;
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 8acecdb993..1201172dda 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -69,6 +69,7 @@ def mark_which_imm_extended(f, tag):
 ##         insn->regno[1] = args->Rs;
 ##         insn->regno[2] = args->Rt;
 ##         insn->new_read_idx = -1;
+##         insn->dest_idx = 0;
 ##         return true;
 ##     }
 ##
@@ -86,6 +87,7 @@ def gen_trans_funcs(f):
         """))
 
         new_read_idx = -1
+        dest_idx = -1
         for regno, (reg_type, reg_id, *_) in enumerate(regs):
             reg = hex_common.get_register(tag, reg_type, reg_id)
             f.write(code_fmt(f"""\
@@ -93,6 +95,9 @@ def gen_trans_funcs(f):
             """))
             if reg.is_read() and reg.is_new():
                 new_read_idx = regno
+            # dest_idx should be the first destination, so check for -1
+            if reg.is_written() and dest_idx == -1:
+                dest_idx = regno
 
         if len(imms) != 0:
             mark_which_imm_extended(f, tag)
@@ -115,6 +120,7 @@ def gen_trans_funcs(f):
 
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
+            insn->dest_idx = {dest_idx};
         """))
         f.write(textwrap.dedent(f"""\
                 return true;
-- 
2.34.1


