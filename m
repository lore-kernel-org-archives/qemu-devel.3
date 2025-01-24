Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1843C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFQ-0006Wi-Vf; Fri, 24 Jan 2025 04:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFP-0006W2-7B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFN-0003qe-A3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBevoGoFcg9Wd4iiTpRW0rHaDELMzFnRDJIXacwfsdU=;
 b=VJePcRwPgzwsmbBL//v/KrqodU55wgM1HgE0+ahWQPXJcIogXMe3zfQvvg9VYjbNuYu8FM
 FtTFHaf+RrCygBQ3l5xFw4fJCympq6BxP4FytPxrpITLM3qFPNbjlg1NppGCGIbNF69l81
 2ARURjDOfOgvspn5uLCQJ4ALVLi3fZg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-cGnTO2R-MlyG0IEuuftqmg-1; Fri, 24 Jan 2025 04:45:01 -0500
X-MC-Unique: cGnTO2R-MlyG0IEuuftqmg-1
X-Mimecast-MFC-AGG-ID: cGnTO2R-MlyG0IEuuftqmg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38c24ac3415so1500725f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711900; x=1738316700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBevoGoFcg9Wd4iiTpRW0rHaDELMzFnRDJIXacwfsdU=;
 b=kj2DSyQQyaPQuW58LrY/UQwLPQ7kWumRdizBlfrvjq6154C0C1VyQI9gA+malwQ1+h
 XniMqxo8trBHxQRK/5rDQJUn7MGL4iCBaKsNIQXRNtUVJBtVb2BDKdh4Om8gbUDUJiLB
 RM9DGRiCHR+FHuyBls3KsSxVVIoyEm0/YnA4yt/MwUL8Pd2HEVzSHUt1p6M1uxQT+sL3
 n+Qeji8fTAyiPl5DcMp8r+xj3xdseeNLz9cUH76fJXd149FWFvx/m8qPfmbbr2eBpWC6
 dE4qQp2YcA8DuZ5BlpBsyPwDEeOW0dzwMZSXLGFkneg5UlsUW0/PrjCAt3my8S3jDEXm
 MQBg==
X-Gm-Message-State: AOJu0YxHlvwcVOjb6gzTk7oF51LV3qHCY1ikpO1Nv53HmFOQZCJQMqrs
 sUYyjeVhMvsGfjlUUjZfO5djLruKYnnq7feKPzSCKMbSii0R8ppLkues53azgMk6dV9L9+JX421
 VXC9R4+R4wzat3LF22f0N0gRL7VzLNnPvh9O2AfTk7RPj7KluGKPYSKm0YA+UW76G3ZOBhzUaZm
 nX1tE5yrABAvDFSnLzxtzBYgipWA8CCLRF/7MdS/Q=
X-Gm-Gg: ASbGnctPzaj7szY4Qx06Jn19PrO/SSAbpyqiS/io5Q1x8/a6/c/1zVZHnT46kRk9Lhc
 8VBbv2yvT1Q91DwWtRh55NMEIN7vlYAPy/vBMfosy4XCBorbjDFb4FHnUn1tqeQIxxCCoUD7dAt
 404gJPJmdeeZowGGZ5Pzzt48naIm+0v4u8ej1hiZJUxMXkgWLS0RFaMo5Lp3we6NjxX3xV9pEC0
 i/zwGQixX0dI1HLfuVjwomZRP+2yfKmOLBrbUDwSfTr/M4OT4xkDImuRQvHroIvICtrJUETXQ==
X-Received: by 2002:a5d:59ab:0:b0:386:605:77e with SMTP id
 ffacd0b85a97d-38bf57beaebmr30842937f8f.49.1737711899645; 
 Fri, 24 Jan 2025 01:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGupPXe6hHHo51ER4hJGbbh5egb8AnEQVVr6m9rE9XQTJUnUwc1W1oJgvSQM1+C7VmOYvL7Iw==
X-Received: by 2002:a5d:59ab:0:b0:386:605:77e with SMTP id
 ffacd0b85a97d-38bf57beaebmr30842818f8f.49.1737711897663; 
 Fri, 24 Jan 2025 01:44:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1761f4sm2171855f8f.20.2025.01.24.01.44.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/48] target/i386: tcg: move gen_set/reset_* earlier in the
 file
Date: Fri, 24 Jan 2025 10:44:01 +0100
Message-ID: <20250124094442.13207-8-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow using them in the code that translates REP/REPZ, without
forward declarations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-7-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 80 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ee536234398..6347de446a4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -725,6 +725,46 @@ static inline void gen_op_jnz_ecx(DisasContext *s, TCGLabel *label1)
     gen_op_j_ecx(s, TCG_COND_NE, label1);
 }
 
+static void gen_set_hflag(DisasContext *s, uint32_t mask)
+{
+    if ((s->flags & mask) == 0) {
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        tcg_gen_ori_i32(t, t, mask);
+        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        s->flags |= mask;
+    }
+}
+
+static void gen_reset_hflag(DisasContext *s, uint32_t mask)
+{
+    if (s->flags & mask) {
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        tcg_gen_andi_i32(t, t, ~mask);
+        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        s->flags &= ~mask;
+    }
+}
+
+static void gen_set_eflags(DisasContext *s, target_ulong mask)
+{
+    TCGv t = tcg_temp_new();
+
+    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_ori_tl(t, t, mask);
+    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+}
+
+static void gen_reset_eflags(DisasContext *s, target_ulong mask)
+{
+    TCGv t = tcg_temp_new();
+
+    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_andi_tl(t, t, ~mask);
+    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+}
+
 static void gen_helper_in_func(MemOp ot, TCGv v, TCGv_i32 n)
 {
     switch (ot) {
@@ -2084,46 +2124,6 @@ static void gen_interrupt(DisasContext *s, uint8_t intno)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_set_hflag(DisasContext *s, uint32_t mask)
-{
-    if ((s->flags & mask) == 0) {
-        TCGv_i32 t = tcg_temp_new_i32();
-        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        tcg_gen_ori_i32(t, t, mask);
-        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        s->flags |= mask;
-    }
-}
-
-static void gen_reset_hflag(DisasContext *s, uint32_t mask)
-{
-    if (s->flags & mask) {
-        TCGv_i32 t = tcg_temp_new_i32();
-        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        tcg_gen_andi_i32(t, t, ~mask);
-        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        s->flags &= ~mask;
-    }
-}
-
-static void gen_set_eflags(DisasContext *s, target_ulong mask)
-{
-    TCGv t = tcg_temp_new();
-
-    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-    tcg_gen_ori_tl(t, t, mask);
-    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-}
-
-static void gen_reset_eflags(DisasContext *s, target_ulong mask)
-{
-    TCGv t = tcg_temp_new();
-
-    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-    tcg_gen_andi_tl(t, t, ~mask);
-    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-}
-
 /* Clear BND registers during legacy branches.  */
 static void gen_bnd_jmp(DisasContext *s)
 {
-- 
2.48.1


