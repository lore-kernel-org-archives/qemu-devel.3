Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0767606A31F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=o+1XUzYJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKaTb-0001Cr-KZ; Sat, 24 Oct 2026 08:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1xKaTX-00018i-QM; Sat, 24 Oct 2026 08:03:51 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1xKaTU-0001Nh-5C; Sat, 24 Oct 2026 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1792843420;
 bh=bSTUf12jIOEpUM1ARMOh9wsYFn9C6yfTw90L8MHsrGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=o+1XUzYJxuV/9drktKTl/Ulg3aJo1Wmnq8gxy+V9iDqw1bv1BSTqdMzFjAdAq8e1p
 20l0TbM8Skn2OcBq7mjgD3FLoLoiA2TOAE1arihD1albLlesaxwlTQIQpxWo+4XW4N
 COCCDJsChQ4PZD6pOmEUdAWfX2D3Jn8RMuyaAqYY=
Received: from ubuntu-vm.. ([122.9.98.96])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 8F108B2; Sat, 24 Oct 2026 20:02:15 +0800
X-QQ-mid: xmsmtpt1792843349tj0k7zfbn
Message-ID: <tencent_BF29702C3097A727E3F9206043AE923DB207@qq.com>
X-QQ-XMAILINFO: MzpMAmlo719gtJ8BoWdoOZ+3Hevo0UL1BJVS6aUW7MRS+cKKBr3yMyndj9FM8T
 EsDPCe71ULTOfu+/QgcrqAE2vC1YvcvvniRVxg3UvucrtMqMvOoV+fnJV9ge4qViE54MQmRMbfmy
 HixohF9Kpc5AtLuhisE9l9lPc1awHzTc6m1yLYBB5J35mJbgNSODPV3MqrGThp/x/6eVC7/qsC/2
 gHv7eOqVKwBdZKOmzl1YV87Bxz5FgolIhVzBJgRJUUCAzE5mI5n4/NzeuNHjiLQrPn8vhS1Ys6jB
 21kbRuypNMlUooC13oeaXB5pA3SSz+DWG8VfWHnuCbQI0Vvnl7oOVB8FrECZjipzfKhI5IUokhLF
 bGZciDMYrE07++vRO4UmKxq4fac9TJSVbwwwTby5UNPQC/fl/8lsaJrqheAXqy0+yCQXrqwMuftB
 e3eQ9fQbGGeAfM6WStq/vms99x15LlVQ/dKiaNBrosAiquY1vaVYL4wyDtrUuaYgUiaO6eEIw5DK
 1YM34EQf97SkSoMNUxVKAmAziXPG9bFp8BBYos8aOJlog2r2fV26GBXkZKEdtJpjsUz24WYPSp8P
 cYuc9QBwkAIi2ojzss43NzE3LMhusbcUoAeLf/rufew3kkCoV/6DIoGyT+bxcIGlSaBcjFBxkfjV
 HoLI+smcTj0cBfeyZhSs3xSzjOxGYARNT4Uf30v+fuzvkHi8Vu49cPdaRubYvwnC5kvQX6cTca7t
 HIbLKnjcGQmo0sR4sgoRjT82CXn3U93z/wevhFvSRitriSoIqWN2LYjcFJY+qMIm1briZv8aNcim
 zBJ0ueuVDsb5GPrPXJHBAdBppYQ2JFkemYx7e8RqJUoYJCXC4R9zuGhOpewG26KaRF+JQ50gzUqr
 o5zNuHhxYs+7/xDbzUa3JDky1sJasrvCeG9lQSOEdbX9rx1kOIN28XLcgTy4gtTCfnjCdwsgh4FD
 t9ajni8iAZsGuU+gKiXKxn4xtAeUDpQVwxHS5SMMmp0ORhvKmAp8LzzAEutx0V7v+rLaIQBq5rEv
 SPeQm03Q0L6bRrAaeB8TepvXWNzu3JkA/lwibTDDI4+lCWVGchfj1I+IkLQ7pj5B4N5dbj6yNUHA
 FczeJzJCf4UTDeZK+h6yKtg2jZEA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: GavinQin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 GavinQin <qinzhengxiang@foxmail.com>
Subject: [PATCH 3/3] target/riscv: Honor Zama16b for Zalasr accesses
Date: Sat, 24 Oct 2026 12:02:11 +0000
X-OQ-MSGID: <20261024120211.236223-3-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
References: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.50;
 envelope-from=qinzhengxiang@foxmail.com; helo=xmbghk7.mail.qq.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Zalasr loads and stores unconditionally request MO_ALIGN. Adding
MO_ATOM_WITHIN16 therefore does not relax their natural alignment
requirement when Zama16b is enabled.

Select MO_ATOM_WITHIN16 when Zama16b is enabled and retain MO_ALIGN
otherwise. Preserve the existing acquire and release barriers.

Signed-off-by: GavinQin <qinzhengxiang@foxmail.com>
---
 target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
index 79b0b2c63b..5bbd06a346 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
@@ -29,8 +29,12 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | ctx->mo_endianness;
-    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
+    memop |= ctx->mo_endianness;
+    if (ctx->cfg_ptr->ext_zama16b) {
+        memop |= MO_ATOM_WITHIN16;
+    } else {
+        memop |= MO_ALIGN;
+    }
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, dest);
@@ -79,8 +83,12 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | ctx->mo_endianness;
-    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
+    memop |= ctx->mo_endianness;
+    if (ctx->cfg_ptr->ext_zama16b) {
+        memop |= MO_ATOM_WITHIN16;
+    } else {
+        memop |= MO_ALIGN;
+    }
 
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
-- 
2.34.1


