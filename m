Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9619FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTl-0006Ep-Tj; Mon, 12 May 2025 15:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTH-0005U1-L8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTG-0007VZ-1h
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iibwwyi5W0D6zz6AXlnAP/ozqACug8CvhufUCjgPp3w=;
 b=C8rldAt45HQ0k7gZ4D0VonWXYotGN4CGT9PAPrMkgP3ooIezs9iWDH9nrkoFoHCpGVz5bW
 nyx7EZLnwBQwauFbHjcR0bahbB9seSaw1MyA2yf/tblzwWOFZm/d90uChHLwB+ED8q/ijT
 7Bd9ma8Ac0wDTtdQ2bSWodx4JlXwWkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-mYxN9ryvOZKWJxRjrcrdFA-1; Mon, 12 May 2025 15:05:47 -0400
X-MC-Unique: mYxN9ryvOZKWJxRjrcrdFA-1
X-Mimecast-MFC-AGG-ID: mYxN9ryvOZKWJxRjrcrdFA_1747076747
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a1f7204d72so1917369f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076746; x=1747681546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iibwwyi5W0D6zz6AXlnAP/ozqACug8CvhufUCjgPp3w=;
 b=M47Ieho6iL/jI8RqBOSC38qCmcC/pyGGsLuUvMm4PGBnAhuI8+t2BWjGfneNA3/0RN
 AUvbwKVHZvEJkgGVFvGpSnYE79Z+eVOLWWvVvWTHyX7C++Sj6dZ54kp39AA2+aMxOW9s
 6GB5bKd5D2yxATlDvKLvTI7A7K5KRZMNEFIqQwEiBvsQM5XgzwQBTn7WiS/QQSamfwlu
 L1iFwyQH0egmebSWyw0QsVFoMX0jzF17M55rTJtulTU8X/HcvKOL4ICNd5xa9+kG/LZc
 SRyXzPCFpnHkEeJONVbGYNwIPL8s5Mv3wFqaU9M+TQrOCnZTWJiK6Nt/fq6htvcQkSKx
 v5QA==
X-Gm-Message-State: AOJu0YwIV75DbYG/Z1ZzBNLkMO8+LuEpfavThDk7sHxA2/afPpB+mppJ
 CYk494igtQMgebs2CA92MHJ1R9IPMpv0NRsGrb2oCTEoz2dGrUEb9i1x6omBS1fa0/DXihf2ISW
 jvhgx0HzNvNoKZZaAFVBMjbnUNf2k/+iFIVJa/VVZWjG2Wq6eCRHNeZ7zVkMluYI1wS1XiSnj7o
 M1QrtkjxJVMJ9rcAqNfsoE4Jfw8KL0y5VBWCGt
X-Gm-Gg: ASbGnctXSVIyVTvzOeX7JxryZE49AfcWAF8qt7enAoUjDfofohblC5UZI0Qrir/nWqX
 LGoXbq4UUnkL/Pm5W7EqprUzzCgqTnHXUkoNVDucQhOB1Hoo53shrfPb6W34XlG5PM8VHBFIHWj
 5N3tKdrHYhJUukqHER8uee6JkLo7l6Qd2h/HYyv+W7nF0AAMe9D23DPFaCEdUEyzalOUF0/cuL2
 VHT0hX4XR6R/T3/8NzyrwN6z//FZ/S3sHMtgTuoPmo75EIWE1MUlKdiYJ2io5Wlm96qASQcAhto
 nuT0UMA9U3JD3MQ=
X-Received: by 2002:a05:6000:3110:b0:3a2:2ea9:4378 with SMTP id
 ffacd0b85a97d-3a22ea94501mr2015082f8f.31.1747076746627; 
 Mon, 12 May 2025 12:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt6c/+hSLCeKTstnF7HByGZMvRFK2q/hvgYOFwRbJGmP6yQNG635mjwOvgAGzaG68rlTNt/w==
X-Received: by 2002:a05:6000:3110:b0:3a2:2ea9:4378 with SMTP id
 ffacd0b85a97d-3a22ea94501mr2015069f8f.31.1747076746171; 
 Mon, 12 May 2025 12:05:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c7a5sm13583024f8f.98.2025.05.12.12.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] target/i386: ignore misplaced REX prefixes
Date: Mon, 12 May 2025 21:05:15 +0200
Message-ID: <20250512190524.179419-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 36 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index cda32ee6784..55216e0d249 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2542,7 +2542,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->has_modrm = false;
     s->prefix = 0;
 
- next_byte:
+ next_byte:;
+#ifdef TARGET_X86_64
+    /* clear any REX prefix followed by other prefixes.  */
+    int rex;
+    rex = -1;
+ next_byte_rex:
+#endif
     b = x86_ldub_code(env, s);
 
     /* Collect prefixes.  */
@@ -2585,13 +2591,12 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 #ifdef TARGET_X86_64
     case 0x40 ... 0x4f:
         if (CODE64(s)) {
-            /* REX prefix */
-            s->prefix |= PREFIX_REX;
-            s->vex_w = (b >> 3) & 1;
-            s->rex_r = (b & 0x4) << 1;
-            s->rex_x = (b & 0x2) << 2;
-            s->rex_b = (b & 0x1) << 3;
-            goto next_byte;
+            /*
+             * REX prefix; ignored unless it is the last prefix, so
+             * for now just stash it
+             */
+            rex = b;
+            goto next_byte_rex;
         }
         break;
 #endif
@@ -2618,10 +2623,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
             /* 4.1.1-4.1.3: No preceding lock, 66, f2, f3, or rex prefixes. */
             if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ
-                             | PREFIX_LOCK | PREFIX_DATA | PREFIX_REX)) {
+                             | PREFIX_LOCK | PREFIX_DATA)) {
                 goto illegal_op;
             }
 #ifdef TARGET_X86_64
+            if (rex != -1) {
+                goto illegal_op;
+            }
             s->rex_r = (~vex2 >> 4) & 8;
 #endif
             if (b == 0xc5) {
@@ -2661,6 +2669,16 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /* Post-process prefixes.  */
     if (CODE64(s)) {
+#ifdef TARGET_X86_64
+        if (rex != -1) {
+            s->prefix |= PREFIX_REX;
+            s->vex_w = (rex >> 3) & 1;
+            s->rex_r = (rex & 0x4) << 1;
+            s->rex_x = (rex & 0x2) << 2;
+            s->rex_b = (rex & 0x1) << 3;
+        }
+#endif
+
         /*
          * In 64-bit mode, the default data size is 32-bit.  Select 64-bit
          * data with rex_w, and 16-bit data with 0x66; rex_w takes precedence
-- 
2.49.0


