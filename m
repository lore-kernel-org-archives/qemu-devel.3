Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0E7D3A697
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5s8I-0002CG-Mz; Tue, 29 Oct 2024 15:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t5s8F-0002BW-4P
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:44:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t5s8C-0006CG-6v
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:43:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so1386415e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1730231034; x=1730835834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rJLm/XAb8yOr4N+S2bheoCtQzw134Ip3Ok40vt1qGY=;
 b=Hu/MPVLo6Bxtyk371VwYtj/kryt7rMQrF1v2TNJxd/1HlnLXmSgRJDBabjt2dXIqfQ
 3L3b/FlMAsS7bB8BfDaCmzsXWUJD9TaQ4/f337LgSWuRrHl9JTlEW3v4Ty2eA8MYZLFv
 Bc0GnA6R5Xtf6GVWW1h8W5G2dojVtTfX9c5RTYVhDw0o0sfMthweaIXNfUQtCd/WWWxM
 zreY5UA0IaNvRB2qAHVta0trWuZC/dgIOdEj0el5aC7+Z/odM+BNvQCMSmjhEJUuEF6n
 oJKZAE3DLYCMv7dROeM9LYO6RDTbOF/PSFx7B/0mw3RWwqYOwWVCRWnXSlzcBTNvdj3V
 Mb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730231034; x=1730835834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rJLm/XAb8yOr4N+S2bheoCtQzw134Ip3Ok40vt1qGY=;
 b=RnqU+LsVSpOfdvJJj5i4314UQayz0E6q9VBOUU9R0KXxWQrvqPi1yMrTzaQ5nNsJHs
 LjyOV6IuRXGKuzxPXfStKJ2q1Z8oe9Vmd3TUxgl1cnT95XWaKQGAX8AqdPezLmSbtnOA
 iVzCjuoi2hLqThYGfVjfvFPtBMJLJAXsmkC4b4XoCEKl3Lmxn5srrZCsf+hB0Pb2wvyG
 BzXFQSHNfeh0j437djDNQWJ7gv5jepkK+fsbHtvS6luKrNgHSWr1hRyWw/N9B4FGrOh0
 XJt/j626oMn91ziXUs5LwX5IENnIyxYrzzKEFA+g5rwKcNBUD2sby5BWjsAu0qDNEYf+
 5QxQ==
X-Gm-Message-State: AOJu0Yw0pRlac4bs2c54CqmhGGwGQh+WsvLg6cXokA4Mvi5Z53Eo5sN/
 Y0/f62wjDLEYWMjW72w8gIsSuCRy0D9LWYM8sAAQBYfH7fGm9tSljLy6md0/A++fKbsl1g7QAgD
 Gtm7ozg==
X-Google-Smtp-Source: AGHT+IHkf1ixYia027E2rMURxHDFVPudOfNIAN/e6Z4LP3E3dQB35wRqfvg1QUaNUrz+vRSGD0SJSQ==
X-Received: by 2002:a05:600c:4ec7:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-431b55a3b11mr29275595e9.0.1730231034472; 
 Tue, 29 Oct 2024 12:43:54 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:2972:f115:541a:90f8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573551sm154348445e9.6.2024.10.29.12.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:43:54 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC v4 1/2] target/riscv: rvv: reduce the overhead for simple RISC-V
 vector unit-stride loads and stores
Date: Tue, 29 Oct 2024 19:43:47 +0000
Message-ID: <20241029194348.59574-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029194348.59574-1-paolo.savini@embecosm.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x331.google.com
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

This patch improves the performance of the emulation of the RVV unit-stride
loads and stores in the following cases:

- when the data being loaded/stored per iteration amounts to 8 bytes or less.
- when the vector length is 16 bytes (VLEN=128) and there's no grouping of the
  vector registers (LMUL=1).

The optimization consists of avoiding the overhead of probing the RAM of the
host machine and doing a loop load/store on the input data grouped in chunks
of as many bytes as possible (8,4,2,1 bytes).

Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>

Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
---
 target/riscv/vector_helper.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4479726acf..75c24653f0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -635,6 +635,53 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
+#if defined(CONFIG_USER_ONLY) && !HOST_BIG_ENDIAN
+    /* For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
+     * better performance by doing a simple simulation of the load/store
+     * without the overhead of prodding the host RAM */
+    if ((nf == 1) && ((evl << log2_esz) <= 8 ||
+	((vext_lmul(desc) == 0) && (simd_maxsz(desc) == 16)))) {
+
+	uint32_t evl_b = evl << log2_esz;
+
+        for (uint32_t j = env->vstart; j < evl_b;) {
+	    addr = base + j;
+            if ((evl_b - j) >= 8) {
+                if (is_load)
+                    lde_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 8;
+            }
+            else if ((evl_b - j) >= 4) {
+                if (is_load)
+                    lde_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 4;
+            }
+            else if ((evl_b - j) >= 2) {
+                if (is_load)
+                    lde_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 2;
+            }
+            else {
+                if (is_load)
+                    lde_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 1;
+            }
+        }
+
+        env->vstart = 0;
+        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        return;
+    }
+#endif
+
     vext_cont_ldst_elements(&info, base, env->vreg, env->vstart, evl, desc,
                             log2_esz, false);
     /* Probe the page(s).  Exit with exception for any invalid page. */
-- 
2.34.1


