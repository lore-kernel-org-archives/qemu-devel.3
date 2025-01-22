Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC7C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXNZ-0004Se-NY; Wed, 22 Jan 2025 04:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taXNX-0004S5-Fu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taXNV-0008NZ-1j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737539426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dtc3Ox/ontWjg0HYJ+gaI1jw6anh4D7muIdCb554eMQ=;
 b=X/2BlPg6Yyo/0TPFXIA6whqiQqEA9c4nkBvupp0YnzomHzr9JpQaujY6aHY2SzZnJ3ao46
 m6DU8uM6M0BMSfjMrgRn9dVS15SJ7R9MIIxCaUQQkVBimLKxbj1CXeB1peUSFfwLtTX1iC
 koqUmB1aejteiXuV0QSRn2dL6sQh8d8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-mCyT0tvdNiaBSgfRkY7oJg-1; Wed, 22 Jan 2025 04:50:24 -0500
X-MC-Unique: mCyT0tvdNiaBSgfRkY7oJg-1
X-Mimecast-MFC-AGG-ID: mCyT0tvdNiaBSgfRkY7oJg
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab2e44dc9b8so75023466b.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737539423; x=1738144223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dtc3Ox/ontWjg0HYJ+gaI1jw6anh4D7muIdCb554eMQ=;
 b=SpGJ7H+xNLd8oSCIIqu4GutpRhqx6rzo+Gm1m4fcxMlcVI/GI2QzHGIYRVhUcfuNbT
 4nTnZBnZ8Z8dnqmcDqKdRWTps5or38bcQWOhWq6YuvjMXgIKyCFEvTVjZWgo6hcCO1Bd
 LN77vmTTDHRNlvlk9bWVcmnG31yGYqdSbYvAkXXL2XUJ8K+vvCRa4aQRIfzVP+xX+GPk
 NRlZ18sfr/MOtYdSzvCJoRGavXuVRtzm9DvQa5I6RgyYwpGmz9GBHPL5rsp5favkuxG3
 oO3/n9HB29CcO+H5AhWL6rLW92QZTfvweifm6ujF/n6zDKStj5iS/MUT0i7VbBdIF9I/
 PCEw==
X-Gm-Message-State: AOJu0YyegbuPwDRC2J0vt/0Yxl8gD50jCnU9G31lSsnb+enSf2QRsqQl
 oHwH+V8E0C8iIjislBkaWiVEMoHf6rabx7vsR1lwTKz4ez/r/r1ejdQZicbOF0HcXsu3wUBYk3r
 C/q8mAXSb8xLu50Oq/MKArzUGr761BF5dqpC9Tt1KhQhQIfvjNy2yLKac8IDgfSUS8tyS0gT8cM
 kIGioBEpq1w3hC7A0fqyOC8UhqH3CETSzaC1Nx8Qo=
X-Gm-Gg: ASbGncuNudUB0k50l6N4+gbqBhXybUmwJEf3U1y3OJVmx+T3S2qT2mNJt6vvJ7sro99
 wQOqpGdx4iHVqPQQZ8KB0NIGpTOLym6RaGdebyEKEDPooI12fb4tacje+MV5TCJ7S8L6X6ElZry
 7j+cA0oHdGo6wzPKQ9XRdN0utQGpaPbOtfR+brrhA0suFX21I8iASCvqerRPHhM0bFz0tQA1cju
 no2Vic7/Vt209zhatYOKyE8PhyAY05IIgKFuC6KlVf3uDfahaQ/cYREcNbXiupz42NpyFIJVTI=
X-Received: by 2002:a17:907:971b:b0:aab:ef03:6d46 with SMTP id
 a640c23a62f3a-ab38cbabdc5mr1600860466b.4.1737539422962; 
 Wed, 22 Jan 2025 01:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiM4T89Nreh2V8mPKDjAjrD7uKSFb6ueocQOZCoEmrwKq4/H/ptKmQVcOl4aCNsnNcN9m4xg==
X-Received: by 2002:a17:907:971b:b0:aab:ef03:6d46 with SMTP id
 a640c23a62f3a-ab38cbabdc5mr1600859466b.4.1737539422534; 
 Wed, 22 Jan 2025 01:50:22 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223fesm890107466b.105.2025.01.22.01.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 01:50:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: extract common bits of gen_repz/gen_repz_nz
Date: Wed, 22 Jan 2025 10:50:18 +0100
Message-ID: <20250122095018.2471009-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122095018.2471009-1-pbonzini@redhat.com>
References: <20250122095018.2471009-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3d8a0a8071f..a8935f487aa 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -695,14 +695,6 @@ static inline void gen_string_movl_A0_EDI(DisasContext *s)
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
@@ -1453,29 +1445,31 @@ static void do_gen_rep(DisasContext *s, MemOp ot, TCGv dshift,
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
2.47.1


