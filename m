Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481F3C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0t-0005RY-TY; Fri, 24 May 2024 04:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0r-0005QQ-52
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0p-0000bi-Js
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmC8Okn408+OIImdpDOg08XGTOAlF1tk7pin60JmUdw=;
 b=UKrnU1JcxuYK1NX3Jhv0DIn/p8cyksde786ZjrJGSbIMpIOGtdvqZiedJhmnDI822n1oTX
 zq6mAc1YbCncS7D0cFWUXzhc87nLmCYLMggilJaFKrJjbSZMgQtNPBuqZzxpeygkJI5SXR
 RWR3zWTKbL9ebKtyxMHPdEYJmk3iq3c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-d9c6mPJjPIi1G5hPmPUDYA-1; Fri, 24 May 2024 04:10:48 -0400
X-MC-Unique: d9c6mPJjPIi1G5hPmPUDYA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-578517c51ceso284253a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538246; x=1717143046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmC8Okn408+OIImdpDOg08XGTOAlF1tk7pin60JmUdw=;
 b=TW7mNhbjMIVUc+ZP7QI+ytI0HHpLiZmYXcRytkS9P94Ij26VrNvMNm/7/TPvHqBMr9
 /V/G2d8U/45urJa96KTf4b46gq0LooYE4S95mIGz0QRaQSN3w2bZ+p63xuBn3fVRpMV9
 TVDBvPJoXrUvLzqOcCc/wFpfIV6qodq7sG9MxApdzSMkRAgkQmJJS9f4//pjosXVqhzd
 TBS/7xH1sJmHYYKzVgkyIeB7xjxMEPy4nff58IS7/z7ZOZ6w/9SJs08gFLOLqtS/RaZL
 eMBTfh8SaAe6z6wXO13qNMQk8Pc4JgvB5hifPR8yM/Z5wkAIpDP+Ws0RYV/7p4K2ccAX
 o+tQ==
X-Gm-Message-State: AOJu0YwdT8R+ihEX9LOI00ekvgFf4qH4A2JzYrvtUP0ln6ZMeBUnJL+1
 AKWW+2ImTcDkZPQ8NFdi1LS2YL9PXHhmN4TkttD4pwsv765skrQ+ZTZKjnHml7cAzttoaxfVJqZ
 8djngklYf0b1n4rJzO4699DgooY/1dAwut7E+tjgYWxNiCz3I5UehfWUy/ls+9c/HJmH5SMB76X
 I5PO02GmaBS+Z09MKa/+zbbYOgO/0W92Z9oaUW
X-Received: by 2002:a50:d001:0:b0:572:d082:79fa with SMTP id
 4fb4d7f45d1cf-578519870b5mr1009808a12.14.1716538246049; 
 Fri, 24 May 2024 01:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCaRG9TQWKKY3llApjg3+z6Qmt266abydjDih4HHQddCYOdgdI/2bdPkm6pdb6tIFki4C8OQ==
X-Received: by 2002:a50:d001:0:b0:572:d082:79fa with SMTP id
 4fb4d7f45d1cf-578519870b5mr1009797a12.14.1716538245665; 
 Fri, 24 May 2024 01:10:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57852339ea7sm1224446a12.1.2024.05.24.01.10.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] target/i386: use mo_stacksize more
Date: Fri, 24 May 2024 10:10:14 +0200
Message-ID: <20240524081019.1141359-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8138da23b3d..7b6bc486a63 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2068,12 +2068,12 @@ static inline void gen_pop_update(DisasContext *s, MemOp ot)
 
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
@@ -2089,7 +2089,7 @@ static void gen_pusha(DisasContext *s)
 
 static void gen_popa(DisasContext *s)
 {
-    MemOp s_ot = SS32(s) ? MO_32 : MO_16;
+    MemOp s_ot = mo_stacksize(s);
     MemOp d_ot = s->dflag;
     int size = 1 << d_ot;
     int i;
@@ -2111,7 +2111,7 @@ static void gen_popa(DisasContext *s)
 static void gen_enter(DisasContext *s, int esp_addend, int level)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
-    MemOp a_ot = CODE64(s) ? MO_64 : SS32(s) ? MO_32 : MO_16;
+    MemOp a_ot = mo_stacksize(s);
     int size = 1 << d_ot;
 
     /* Push BP; compute FrameTemp into T1.  */
-- 
2.45.1


