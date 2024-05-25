Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30155C25B7C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfU-0002jL-5D; Sat, 25 May 2024 07:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfR-0002c9-9s
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfP-00048O-HQ
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=It018iaxeGCuxdfv9rBK6rIbGhk5sPnz7MmsFCaZFeM=;
 b=iLvV61gutHHdC5JZzzxxdZ2kTr6beX5fd375lkjPT8Gd55dglYQKr/d9lOnVntLschLuih
 HIyZzYSTcm/TqZYyHRRIBlWrtmlgUiGC6bOcIwy1+2VAQF2ZWuM3WVNVc5/NGqwV7+ey33
 ukDKbKAoQ4XLaN3rTpI0vWgmKD5lDdI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-KBTmR73-P36L8HN-7srY4g-1; Sat, 25 May 2024 07:34:25 -0400
X-MC-Unique: KBTmR73-P36L8HN-7srY4g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6266ffe72eso80921066b.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636864; x=1717241664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=It018iaxeGCuxdfv9rBK6rIbGhk5sPnz7MmsFCaZFeM=;
 b=EFNBftdl36SzujqVO23Z83/Lb/QGwp2G35qXXlUbQDeQ8E7GiypOEOsloVnX3aKwwh
 +PmNenRoLsuNLHA/kRT7uNLMzGcL53/uZs9Y/xJimQwW8TA01iiQsxjAynb7/zDdOi4A
 deaYMG65KO13mKG0QpEuDAdIyBbFw+kEGSH64xzZe5ojxzguWbxkbcNHCqcoyymhEc+l
 Pe24rPNbX6tcW4utN3Gg14dzE9XgsBm9yfK0m+BWc3/PgzFsa3avSfL7LWjtYw/+G5O+
 bNPIx2qJzvjNAJA2f75+9emEeCBJYreZBQxXRzSKvS8UPgQFQA7NKCzOXekhLE5VkmyG
 4qWQ==
X-Gm-Message-State: AOJu0Yz+mvj3PJMTi/arqN9DiY8DF5/dcBsC45Yo6y0tvD1+tkTLCVd5
 ol3S37D2uvHCF5TYtzkLFhCGMg/mk6XVLGFJEoJDMpsYy92v+bZ0jma0Kc64u0WcVw2Raua4mrh
 MN2Q3LpxAqgJ/Ohaihpzr+Fx3iEStQ78l/5yKlY8KuI3H3P73nO2kuMAaijfWWEBMD+eCWXe2D2
 tJIwiBQLdv8Bs2VmJL8MrsW7Dtqz+5PGIqUkeU
X-Received: by 2002:a17:906:39cf:b0:a5c:f73d:67b3 with SMTP id
 a640c23a62f3a-a6265010976mr329838766b.63.1716636863802; 
 Sat, 25 May 2024 04:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEX3rYQ+UkgMBwvNr1Rw67yoPlsF/6n+a4vX599PNJAKjKa9w660dQNvdi935R6vhvSnsKwg==
X-Received: by 2002:a17:906:39cf:b0:a5c:f73d:67b3 with SMTP id
 a640c23a62f3a-a6265010976mr329836866b.63.1716636863340; 
 Sat, 25 May 2024 04:34:23 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c9376edsm243631266b.59.2024.05.25.04.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/24] target/i386: use mo_stacksize more
Date: Sat, 25 May 2024 13:33:24 +0200
Message-ID: <20240525113332.1404158-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use mo_stacksize for all stack accesses, including when
a 64-bit code segment is impossible and the code is
therefore checking only for SS32(s).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2039ccf283a..2a20f9bafbb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2075,12 +2075,12 @@ static inline void gen_pop_update(DisasContext *s, MemOp ot)
 
 static inline void gen_stack_A0(DisasContext *s)
 {
-    gen_lea_v_seg(s, SS32(s) ? MO_32 : MO_16, cpu_regs[R_ESP], R_SS, -1);
+    gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
 }
 
 static void gen_pusha(DisasContext *s)
 {
-    MemOp s_ot = SS32(s) ? MO_32 : MO_16;
+    MemOp s_ot = mo_stacksize(s);
     MemOp d_ot = s->dflag;
     int size = 1 << d_ot;
     int i;
@@ -2096,7 +2096,7 @@ static void gen_pusha(DisasContext *s)
 
 static void gen_popa(DisasContext *s)
 {
-    MemOp s_ot = SS32(s) ? MO_32 : MO_16;
+    MemOp s_ot = mo_stacksize(s);
     MemOp d_ot = s->dflag;
     int size = 1 << d_ot;
     int i;
@@ -2118,7 +2118,7 @@ static void gen_popa(DisasContext *s)
 static void gen_enter(DisasContext *s, int esp_addend, int level)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
-    MemOp a_ot = CODE64(s) ? MO_64 : SS32(s) ? MO_32 : MO_16;
+    MemOp a_ot = mo_stacksize(s);
     int size = 1 << d_ot;
 
     /* Push BP; compute FrameTemp into T1.  */
-- 
2.45.1


