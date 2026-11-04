Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5038606B390
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=PUHnanJB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtC-0002qe-H9; Wed, 04 Nov 2026 14:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsw-0002Zq-UR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:03 -0500
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsv-0002Sb-B6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:02 -0500
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-3282db206d3so2089596eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821379; x=1794426179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cwvRn9AQqLZTwdydkldOoO+I3sh0PMkOoD8zxlRNQ0I=;
 b=PUHnanJBFumWT5+ahkZmmtYSp1S+HrGX+pFUiPgw1gOM53kQB7LnJhbhbt7auBoncH
 Wuc3p0x80MDXBi5ei3ePVL2ltcxSccB1atS+yov+QthTmLXjOyUzOi0Gr6E88Tkx2DuV
 aUgeUBfWAfTiRR2oPzmZDdRvqhMaP3ShElnLuDkHWwnOOHSjoIwK5IQiYv4ukKlO2L1J
 gN5bwrCoicK3cjYVSTwBAg5yeaEecgjHWxD9abbrE5oOEpAmfEmnW3swFgWw8UC6QcWj
 yjzujQNEv2eGN/ohAjGFSXq/6olpGbIlPNFUvvNxhqm35Gi301S3OxuvKOKcpLtYrb1D
 B9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821379; x=1794426179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cwvRn9AQqLZTwdydkldOoO+I3sh0PMkOoD8zxlRNQ0I=;
 b=x6gBrg8Yzz0wmF3bvtKmcstnkfxuTvx0OyeR7Jm23KTq8FsB6qIW7I13GPeV+wMD5l
 QpbPVsxSIyrUNHsPrn1rQrmCCbzv4GE0vwzZ9AUXrjIssmEQAmjF7g47PCG7N7RncnEd
 iMUFzFS+fqMsEAbU3zTuCWJ57SyXSvtbLOtrjPeUx+0oviFr6+lmwHVsN7J+WmsMwrfi
 j4cAluA7+yda9DHZpK3hLtElj3Q7ttX5ktzIMChGKqRta+7iDOsKK/BS9hGr2wAz1NJi
 A2UuYeUp9DqIXGypdkb6iSWGOILbDXYKIZJe2YU7LC6CFhK5S81Y2g4GEr1dbUiQExmG
 QekQ==
X-Gm-Message-State: APuU4Z+FFNdQeX3yzM3b2+oTiEhLZuXwOm3eM/SMWIfn7A7tfy0WOXAC
 95TVXSEBGyabnR64Dfhdrze2QItZLLS5cmbY21dX/cPwhINr83IlNOVYMXx4CC2oQdhc+enmYZT
 3zRDWYRGrFs+2CmsqLqCgAhB37ifbq3mR49qkN4wKNDpyd1KT33WW+DJ2WNyOUVueU9orrH6s0o
 /AfuH3SfRUsrpIuxu3HgNkNodCKcfDbixc2mQBwLQcIA==
X-Gm-Gg: AYBFou2XRT2SecQhA09JB/Pi63hycYk99RXHof8jDWvBnLyECrrkhSUQ5toVrOQu0LX
 ROT2F9sVpT+D7Src/FFheRoZ2Mc9m9gv22oBW2nrzOk8ju0EenJxC+byVKDaHDMJ9gzvzPEpOdk
 ZCjFCcMBWA//7Jwv1PQF7wiPQdSJqHtCfKCoSupzvJ37Jp6TW5wGGBx7E/3RiSpImA/c/o4164X
 th6dP2UHtWsln3gJzTyILCYwIzg4KzO0KYHo4VgsMrXQl2Kyw8a8pRFXJXno4FDrhT3LKtrqmbI
 O+6A+UeIHzjvspHpjmrY34EcwFKOKkz/HdFtctasTSfgV5D8As6ec8BGz4K6ivPKUqDr19efeBa
 Zh5Z7RTWsz9MvnxvVKLDLVppU1zQWMgy9m38tZwySpUNOJv3gaJJMSyBbvRLXFioq+USoz7WXGh
 w6/fYK5GDflBV3LSU1cjsUig3zhpljAJop049+YkhtDXkPe8lHvo01S8P2E8jDN9lgs5dzzMCpn
 MiMW7KayxU+xPNp1nCv6XzGvVgy5c95SMNoXTsUHVtPHVFbDJ6N0Hpbvf5WUkxh70019CornHoZ
 xFUxzqyeh7+RB/accMFc2zyhUaVOZs1FBhGlvzueOd4yaP/rZKSQhTuJiR9GBye0mpbPVOQ7gBL
 yrHvmJi48iHSgpp+vRWgy+loqGJVS
X-Received: by 2002:a05:7300:a8f:b0:368:4c93:544e with SMTP id
 5a478bee46e88-36a422084d2mr25971797eec.1.1793821378294; 
 Wed, 04 Nov 2026 11:42:58 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:58 -0800 (PST)
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
Subject: [RFC PATCH 14/38] disas/riscv: Support Zvfwdota16bf extension
Date: Thu,  5 Nov 2026 03:41:29 +0800
Message-ID: <20261104194155.679241-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1331.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add disassembler support for the vfwdota.vv instruction from the
Zvfwdota16bf extension.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv-op.c.inc | 1 +
 disas/riscv.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index ec767ccbf8b..aeb9423f130 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -614,6 +614,7 @@ OP(vfwcvt_rtz_xu_f_v, "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
 OP(vfwcvt_x_f_v, "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
 OP(vfwcvt_xu_f_v, "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
 OP(vfwcvtbf16_f_f_v, "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwdota_vv, "vfwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vfwmacc_vf, "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
 OP(vfwmacc_vv, "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
 OP(vfwmaccbf16_vf, "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
diff --git a/disas/riscv.c b/disas/riscv.c
index 2acded0c915..62feb4c653e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2640,6 +2640,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 39: return &op_vqwdotas_vv;
                 }
             }
+            if (((inst >> 12) & 0b111) == 1 &&
+                ((inst >> 26) & 0b111111) == 36) {
+                return &op_vfwdota_vv;
+            }
             if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
                 switch ((inst >> 26) & 0b111111) {
                 case 32: return &op_vsm3me_vv;
-- 
2.56.0


