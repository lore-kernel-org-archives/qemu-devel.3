Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86BAC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4ss-00007a-4g; Wed, 17 Jul 2024 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4sq-0008SM-Bj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:39:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4so-0007Qu-1L
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:39:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fbfb8e5e0cso48540445ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721223588; x=1721828388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nfs9IDqgQpVVigMZU11K8UdOmxP2QGM7nTxJBjJv74w=;
 b=h3hZhDEm8ps3HIcANJe0SMW043NsAhDZZgDAta6dcNhO/AD9Zy8r843UTUQs8tZ8n5
 GOtQjPkftk7aH0Sh/HXTofZgDJ+lXA9nXXYvu1QjEoP3B7dDkTNFUd+87YIRIaYd+gRd
 dHJD2aU4UJW8lJyFgmUk4Jj0TPXC+cvbLOHZXjWfoKsNoMAwMzKMb/cJjPwR7Oa5q8C0
 882C6yeKw2E8OI8ZeO4mXZqqLWWSdlUhEsp7MGd8q0TBtDMCq5JXHn2Q+2beEME+egkj
 yAVw75p05ZhM5+UXnVf0qvzlDBalNPsyZf0N/hR7kO1Jg5qvK44dykeB0lhQY08m3C44
 B6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223588; x=1721828388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nfs9IDqgQpVVigMZU11K8UdOmxP2QGM7nTxJBjJv74w=;
 b=GkL3mzVOxCS1gVE/bV5Hf6PK5vEOaZjm3ZoNjzWu0lJIN6AcMc4I928nJ5DkFEdRLQ
 4FnFaCtQoNINheJgKeWgEMaG4RJO94OsmPNo3HODXC49au/6mECuLVoL9qF6Mgv3by6l
 yQCz4r5jmeeCnEh2cXnPWzZGiAcOYFFrFC80pf5QQEpSElNJyccUT9Wlh1RvNKyVv/EZ
 EHX8hQJKFVaUA3knvDCoBOWw/MM8biTLPwZAvUeX8bl99Cqn7ACw4SsCfqjd03iTXCC1
 J39a8/dKAWcdwnr4WxxbYtZ/LC7v9P+xiUKnNCVzyOWqlf+T2s3r/gbQCzCLzSw2u37v
 VHaw==
X-Gm-Message-State: AOJu0YyybwOdOymUYoHdjauRI58z+9mZ/imPJlqIE5ixdOc0zG+Ci+/k
 fzgq6XTp4SG3kbVZNEAhcsl5Y2EXgjnGutkFpt3bY4927/jD/jvB/F6t2W9epsyfBa6UwbKW3jU
 TkQzDFzWhNDIKfUTtJ16mBEy4r2IPuzOEwineYF9cz1rAINeDLupa70ny31t1KIzF6nvGijgWe7
 7GAXT1PzRtXaDZ2+lgraR1Uzb6GGV4xXN7VRkgUA==
X-Google-Smtp-Source: AGHT+IE8pc+hJ9pD+Tt81iKqmPfRNNbZNqlasHOE/UP9cJmMOu7HUIy004Z4Qo7CKRfgVJ67kMIDCA==
X-Received: by 2002:a17:902:db01:b0:1fa:d3d:a68d with SMTP id
 d9443c01a7336-1fc4e17c7d9mr16685155ad.22.1721223588113; 
 Wed, 17 Jul 2024 06:39:48 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc5aa6esm74903495ad.299.2024.07.17.06.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:39:47 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v5 1/5] target/riscv: Set vdata.vm field for vector
 load/store whole register instructions
Date: Wed, 17 Jul 2024 21:39:32 +0800
Message-Id: <20240717133936.713642-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717133936.713642-1-max.chou@sifive.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x633.google.com
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

The vm field of the vector load/store whole register instruction's
encoding is 1.
The helper function of the vector load/store whole register instructions
may need the vdata.vm field to do some optimizations.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3a3896ba06c..14e10568bd7 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -770,6 +770,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v *a, uint8_t eew)
     /* Mask destination register are always tail-agnostic */
     data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
 
@@ -787,6 +788,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v *a, uint8_t eew)
     /* EMUL = 1, NFIELDS = 1 */
     data = FIELD_DP32(data, VDATA, LMUL, 0);
     data = FIELD_DP32(data, VDATA, NF, 1);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
 
@@ -1106,6 +1108,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     TCGv_i32 desc;
 
     uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     dest = tcg_temp_new_ptr();
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
-- 
2.34.1


