Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C255C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFe-0006pV-V9; Fri, 24 Jan 2025 04:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFb-0006l8-Hs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFa-0003sT-0b
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xatIXaIYlV/CgS4ESCp0zEwFccHB44d7QBdN1/soCUc=;
 b=f375Fa+d+/j6pLnTQPJFjd1ljys2kTE221lhLdPpcVjjKCNQIjphF0FxqEoHWPvJz6/J36
 6NY2nJcWZy+rr4VAZw1w7+JPDl6ozaJv21QMZv013Lgu69SW/OuRx0abuVC0/e3A2XRY73
 +47q29FbqeEcVYdwQjmSyUu0Y0OoaXA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-oDdY2WblPZeHzolOYJm5Iw-1; Fri, 24 Jan 2025 04:45:13 -0500
X-MC-Unique: oDdY2WblPZeHzolOYJm5Iw-1
X-Mimecast-MFC-AGG-ID: oDdY2WblPZeHzolOYJm5Iw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so12960295e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711911; x=1738316711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xatIXaIYlV/CgS4ESCp0zEwFccHB44d7QBdN1/soCUc=;
 b=RqGWxkyrZK0a9FE+8UjC4oOlC4FUvC+dfMRWEaxtHitMT3VQXUAm2tVrRtXx3jKiH5
 ZAyz24lOp9lNsCNIWYeEJgifbVLVLvRfNoMYLq+MrmyV9quTCEG50H+VG/4fyXyUrNOT
 peVZjXxKh6VZ3NkpdGuil48/EGTzD1xHLwZgAIdtFDHgfoKXZ2AwWKqqKTfupU8uRlKs
 6RGaDooxpIF/EhnT8ak5cB3a9vqjlhADD/ywkVUkO53QfKqzSDfuGT/2OBQvXtED9OzM
 e5Kr+mnuSvxY9zR8CD6NWHyLenVwfnN5iUVo+Hzh1+FUXdFEDD9+xX66zYZByQBeaDqR
 oV3w==
X-Gm-Message-State: AOJu0YxBSJinTtR09Xwooys49E2mcmbaywikmndmczNiX/WPheNlj9zK
 pJ2dQb2wKfOFCCRNhS3PYPNLTKBPsihfKiBuhxmGL3BXh5iph85JHn5Eq9j/Kd42mJfJc+uOGGo
 S2130Z+j6D+N/X1DYDeiRoL94fL5xEz11t6kItHQbeU0KhEg8GbVP94iMWZ7xa0KIlxiTJmQcpc
 l4RALuLY2Kjixp0FTj1ecrxQXCwuPmWZgKzw3kybE=
X-Gm-Gg: ASbGncuvcSbEvJ3Qg5JYfFkkHHdXWzVrIYJxNSZvq1TnsNaLwQvhCgpunqlixGFy0kJ
 GeucJMLjobCrTEpPCULolDzMo5D4uVypbsdDY2qsXbBtT/lk0qsQAAhFfePeKMO2T1Dqe9W1Mw0
 IGAtb72QytbPMHMX/e8ChvNb7zgkF+osTsKapQaDLVFKdN1Hpfs47RhGEaGqM8wrmwvdgDkIDuc
 VHg1X2KmwaoH5jJVjNCnXSmj9W1nL3Ef3h5qEHsXXmqTtykHMiadNRfPZaL/ITWgV1PncSLKg==
X-Received: by 2002:a05:600c:1c16:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-438913bed1bmr256504785e9.3.1737711911521; 
 Fri, 24 Jan 2025 01:45:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsIm+Ym8NnzGGf6nf7UgSf5CGAEqY2xPvvmdHJFC1/4vDfx8svnz11aFZB96lXs2oWZYQkBw==
X-Received: by 2002:a05:600c:1c16:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-438913bed1bmr256504435e9.3.1737711911044; 
 Fri, 24 Jan 2025 01:45:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa479sm20684205e9.5.2025.01.24.01.45.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/48] target/i386: extract common bits of gen_repz/gen_repz_nz
Date: Fri, 24 Jan 2025 10:44:08 +0100
Message-ID: <20250124094442.13207-15-pbonzini@redhat.com>
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

Now that everything has been cleaned up, look at DF and prefixes
in a single function, and call that one from gen_repz and gen_repz_nz.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9f4d3ebbd95..9b2fde5eb28 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -688,14 +688,6 @@ static inline void gen_string_movl_A0_EDI(DisasContext *s)
     gen_lea_v_seg(s, cpu_regs[R_EDI], R_ES, -1);
 }
 
-static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
-{
-    TCGv dshift = tcg_temp_new();
-    tcg_gen_ld32s_tl(dshift, tcg_env, offsetof(CPUX86State, df));
-    tcg_gen_shli_tl(dshift, dshift, ot);
-    return dshift;
-};
-
 static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
 {
     if (size == MO_TL) {
@@ -1446,29 +1438,31 @@ static void do_gen_rep(DisasContext *s, MemOp ot, TCGv dshift,
     gen_jmp_rel_csize(s, 0, 1);
 }
 
-static void gen_repz(DisasContext *s, MemOp ot,
-                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
-
+static void do_gen_string(DisasContext *s, MemOp ot,
+                          void (*fn)(DisasContext *s, MemOp ot, TCGv dshift),
+                          bool is_repz_nz)
 {
-    TCGv dshift = gen_compute_Dshift(s, ot);
+    TCGv dshift = tcg_temp_new();
+    tcg_gen_ld32s_tl(dshift, tcg_env, offsetof(CPUX86State, df));
+    tcg_gen_shli_tl(dshift, dshift, ot);
 
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, dshift, fn, false);
+        do_gen_rep(s, ot, dshift, fn, is_repz_nz);
     } else {
         fn(s, ot, dshift);
     }
 }
 
+static void gen_repz(DisasContext *s, MemOp ot,
+                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
+{
+    do_gen_string(s, ot, fn, false);
+}
+
 static void gen_repz_nz(DisasContext *s, MemOp ot,
                         void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
 {
-    TCGv dshift = gen_compute_Dshift(s, ot);
-
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, dshift, fn, true);
-    } else {
-        fn(s, ot, dshift);
-    }
+    do_gen_string(s, ot, fn, true);
 }
 
 static void gen_helper_fp_arith_ST0_FT0(int op)
-- 
2.48.1


