Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2666070329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=FGrRUMUF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOguF-0006t5-Hz; Wed, 04 Nov 2026 14:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgu6-0006Gt-1a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:14 -0500
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgu4-0002hg-Hz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:13 -0500
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3550c917fd3so1610848eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821451; x=1794426251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SNutt+qYtfpwfxPL8boOG9dw1u9CAIyu7M5FLo74O0o=;
 b=FGrRUMUFWa1OGyt7LVGAXWzF3vvCJRCIi6qPAL2iVoJEvW7VjCT+NxYkZMBuMToMTH
 aaBoRiWZ2MJJjFva6j4U67bzHTiQPSFjyezcR6cBbjJIJPV1F6wW9zp0ScZF35MFVQGI
 fgKyFjmPIvo/HvADzOGraZTzTwm4Wmr4v9Q57qShOFowi+sm0mUJM3RbkrJ3s9WjUhb2
 uJzoZn0nRrbi8qzhJ/TAgYEaf1rMa19xXcfHZ5jKKFWCLfdpT+hv+9AjxyWbbG86i8EG
 aRpnHAejUDqDjnYe6Z3XtBfHZaF1UJ4MdQQ9ODNQyvnDsR43p2E10JF4d0x1iCp2xCLz
 Q8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821451; x=1794426251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SNutt+qYtfpwfxPL8boOG9dw1u9CAIyu7M5FLo74O0o=;
 b=G23KWmiT6FQCYZNewsM3UhI1iSTACxgD2abRsJDncmNc6OMHhB4Q6fqkjQIeZA03Nx
 wosTCSmspOzRL8tfI7fL9+7o13K8O4A5RBLxTN9Qd/IQABwHX6jo/iNkFZrZTAUFd+62
 8i4Ow9UerJiPTph6t5ZyWYcx5lEHP0KuhFLnUIJeRkk8I0JJdd+U4nvoVEbaYNVPqIqI
 WDS5K8nnKtbpNJGh9QmrvwPIZsZQ45+cQxKQwQb3tfWdNAl/0Rat4lKWi+xxEG1RzMIR
 Q3UBQ35gTW2QJY7O8/ZglgS88uZyueawktbNgasGJBH5M0xielfbvRTHnRCNFJM7rknb
 d3Sg==
X-Gm-Message-State: APuU4Z9pOcjZNRp+hvsDm+58qXzf6bV9hvhMCzMtDo1VFRnKHj00XYRS
 2eXbR1hPnDvVyhEmVLcp8IOCOddv4PhFRZSzzVSfuLTE4QPmkx03K2Lkxe3sSvZO7Sq8ZT2+HTJ
 TPNl/PEdWcg5cIOMz+5V8+REKVgqQOvxsWU9TWPaW9OF+yxmfT9lJtzndjQjPLOmOGqEDb6oZhR
 zs1U6vQx5tGR7waJUPlCUPkzJ/EvJoQyezafP9H7IoUQ==
X-Gm-Gg: AYBFou2n3lwLoMde5HvkB//K1XIKqoh8rmJEu8YP//IFo68X1NXcuPvYWm2WRN2FFbk
 VMER249ysWIzVllehy7JG/AmCFaFuEg1EptkrLU7fsMqDmWnUAnEKYCBaMY9zhtM9QdIZYbFTEX
 K5cOcAsABuVQaTPbbfPNz33Lk/4fcMgs3CbMg5wa91pl6aVFS9+y2aHQ3CQmp4zh77QJbzdW0HB
 lj6UBXWsFZpb8HN91kvtI+IVYoPhMTjWt8ZJ2hXSUQCPMc64oVfJMcp6LIzrdpKBHLyVwRPyp2N
 ARVdsUS2BDcVV89hZv8RBWvx4aAMuGI+WJ2c8TOrio6JYpmrMt+wW1gPX1ORZWliHDLwOwVG8hF
 c1yYtACthj4M8s7dcp2pyPh/Fv700XZTqgm9a3p3ISRV9bHXwvA3OkmvqTgI+59JYI/yv83EPz7
 ryJ6lfW5bf7h9RwZGUxT1ahi1BYa/4CqFl4u8o0Ipv17bRk24W6sQjYJTa9+z5UtTTvdt36tntB
 feD5mAebI27aOXMiMOFkHMh/bZ77jmDLDSu7hf4wUdVPEI+822k0Iok3ZzFZ80FEfwl1FV9On8f
 dXwiJYyzV5pSmVvqdF0RJT6uO/2OJjYAN+iYQsly5ePeqtp4i0MINLqtSQjHZSAv9njLSBzFcdS
 bdOi2PxQneMVBVfrKq21X9W7GlX7d
X-Received: by 2002:a05:7300:fe41:b0:36a:158e:f917 with SMTP id
 5a478bee46e88-36a42401999mr24584054eec.6.1793821450714; 
 Wed, 04 Nov 2026 11:44:10 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:44:10 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 37/38] disas/riscv: Support Zvfbdota32f extension
Date: Thu,  5 Nov 2026 03:41:52 +0800
Message-ID: <20261104194155.679241-38-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support to disassemble Zvfbdota32f instructions.
- vfbdota.vv

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv-op.c.inc | 1 +
 disas/riscv.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 58f6ddac35a..779fc26a27c 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -538,6 +538,7 @@ OP(vdivu_vv, "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vdivu_vx, "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vfadd_vf, "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
 OP(vfadd_vv, "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfbdota_vv, "vfbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
 OP(vfclass_v, "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
 OP(vfcvt_f_x_v, "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
 OP(vfcvt_f_xu_v, "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
diff --git a/disas/riscv.c b/disas/riscv.c
index a124cbb4bbe..8330ba34a30 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2647,6 +2647,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 36: return &op_vfwdota_vv;
                 case 38: return &op_vfqwdota_vv;
                 case 39: return &op_vfqwdota_alt_vv;
+                case 43: return &op_vfbdota_vv;
                 case 44: return &op_vfwbdota_vv;
                 case 46: return &op_vfqwbdota_vv;
                 case 47: return &op_vfqwbdota_alt_vv;
-- 
2.56.0


