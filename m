Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F60C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFL-0006Ud-RG; Fri, 24 Jan 2025 04:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFK-0006SQ-8n
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFF-0003eP-Hn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dp8dzrQlvVxyn9uMuLYOc0nw+zdKZDXrocgw0Gg9Ryw=;
 b=Tvr4b8A2rOXxtbb22BqTVLBPkWlC+4HTd5GLsHOGzgbFKlu72ssxyvocKJnSPrJIq0QfT2
 9Nv83fXaBdI2xmu6J0lecu7mBKJItTstCVzQ2b9GZjHrK9l82Hd96Fr7JDjc+qmeVw19Pk
 fV+uSjFpEbmAQSS9g/dUau01VJkXeok=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-fsS0SXd-OV2jkZt3HeVTjw-1; Fri, 24 Jan 2025 04:44:53 -0500
X-MC-Unique: fsS0SXd-OV2jkZt3HeVTjw-1
X-Mimecast-MFC-AGG-ID: fsS0SXd-OV2jkZt3HeVTjw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so742127f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711892; x=1738316692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dp8dzrQlvVxyn9uMuLYOc0nw+zdKZDXrocgw0Gg9Ryw=;
 b=saqdWwxaROy1kOBLQBO08PiSZZYP9PFrFxRpu3CiMmRUMt/x4KjbydBGKT0is80iif
 JfjMcBObVrrnawGonOxgq/pF32oya3pfPynrCZBcU2Fex+GPOOGilWi1huzlC+rGEq1S
 5bHrQbz6IUZ5WYh0Dv96cM4nKHJdt/u3OASwj+0sVkbl6wXjlgzaIW11NaHha4vFnJzk
 8IOD50vLIcgqn4k5rs5hXeA7xAtZVuIGYbiFROLCXdAiFrSRUv1V/C1BdP1MzoYSYMCx
 OTEuBXSYwspghI4a7q3Tq9gi7Wvyk3o2zaiI8HhaMhPUehVZ0ajnXf6QVtMzm+gfbcok
 u9aQ==
X-Gm-Message-State: AOJu0Yxf8NuHVk/Mt1p1gjbXoBxGVJtJpBJV/xxV1jcocooZUgX++X3/
 9oTMbaRM7b/PDNIvcC86avW1pHeW+AJbbMH3JffuN7DgeyeL6L68AoDJWZ10aVmJPrxQvizs7+Y
 +Aq/q2/75CThiUK4lPE/baWro/ibae54x8ADg3Q5ZwwnHYv+QJN0i3frp9Y21WhrncTQzegk7c0
 XPsS9QvU3ooyyTIszULieBPa1PBLrKXtYWix/lHlI=
X-Gm-Gg: ASbGncu2pj8AsR+kvXtG5gDlZLgeAXcjq4eDW1tQxd9jMo2/CnAHeS/x0y4dxp2lUWs
 ujwfxGjSFhHeKh0CV1MzRwa/Dhbglx5iAklGpVlcF7WtqyPSkdVbW2bk5fPUbgkUInGPXmjXBrd
 b4Kcf5nNXD2eDUn5Nkd+/9jC1oGEyUGyx/MwKC7PkMC6uBuTtw0DIW1Ornr6EtG1c3I/1Y6rmf3
 0alhKB1DAgFRE/xBWX4aK05bkIPY+P/XNWRR197uFcCvaxl5ZhKcTZeJaMlZJfpH+BBP3rVNA==
X-Received: by 2002:a05:6000:108d:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-38bf57a238bmr22440177f8f.43.1737711891871; 
 Fri, 24 Jan 2025 01:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1ZAwRz96FyomgKkPJM8Qfs7hP9qYVJPjSCgqS49j9rpkidvHYASsM5yZG1MmFhaSnZCmqMQ==
X-Received: by 2002:a05:6000:108d:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-38bf57a238bmr22440153f8f.43.1737711891431; 
 Fri, 24 Jan 2025 01:44:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1ca723sm2135160f8f.101.2025.01.24.01.44.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/48] target/i386: unify REP and REPZ/REPNZ generation
Date: Fri, 24 Jan 2025 10:43:58 +0100
Message-ID: <20250124094442.13207-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

It only differs in a single call to gen_jcc, so use a "bool" argument
to distinguish the two cases; do not duplicate code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-4-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 39 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a2101b5615e..877b5846114 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1310,14 +1310,18 @@ static void gen_outs(DisasContext *s, MemOp ot)
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
-/* Generate jumps to current or next instruction */
-static void gen_repz(DisasContext *s, MemOp ot,
-                     void (*fn)(DisasContext *s, MemOp ot))
+static void do_gen_rep(DisasContext *s, MemOp ot,
+                       void (*fn)(DisasContext *s, MemOp ot),
+                       bool is_repz_nz)
 {
     TCGLabel *l2;
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    if (is_repz_nz) {
+        int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
+        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
+    }
     /*
      * A loop would cause two single step exceptions if ECX = 1
      * before rep string_insn
@@ -1325,28 +1329,25 @@ static void gen_repz(DisasContext *s, MemOp ot,
     if (s->repz_opt) {
         gen_op_jz_ecx(s, l2);
     }
+    /*
+     * For CMPS/SCAS there is no need to set CC_OP_DYNAMIC: only one iteration
+     * is done at a time, so the translation block ends unconditionally after
+     * this instruction and there is no control flow junction.
+     */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 }
 
+static void gen_repz(DisasContext *s, MemOp ot,
+                     void (*fn)(DisasContext *s, MemOp ot))
+
+{
+    do_gen_rep(s, ot, fn, false);
+}
+
 static void gen_repz_nz(DisasContext *s, MemOp ot,
                         void (*fn)(DisasContext *s, MemOp ot))
 {
-    TCGLabel *l2;
-    int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
-
-    l2 = gen_jz_ecx_string(s);
-    fn(s, ot);
-    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-    gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
-    if (s->repz_opt) {
-        gen_op_jz_ecx(s, l2);
-    }
-    /*
-     * Only one iteration is done at a time, so the translation
-     * block ends unconditionally after this instruction and there
-     * is no control flow junction - no need to set CC_OP_DYNAMIC.
-     */
-    gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
+    do_gen_rep(s, ot, fn, true);
 }
 
 static void gen_helper_fp_arith_ST0_FT0(int op)
-- 
2.48.1


