Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B9AC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvr-0000KU-HY; Fri, 30 May 2025 03:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvm-0008Td-5x
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvk-0006pi-01
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOdyiM5i52fELrIv/W1T+k3teEGSvJpSoU6puuRxHmI=;
 b=JdkevJCsqr9nKPG+GLq7RVsZ67ge1g9WpzrHybM8Bg3HZD6L+RW0P0K50+WO7bC9wcpA49
 x87kSbykGv9o4bI0PKWcm0c/nwDJhNSob+f59AakHn2fm3/tRjs9SjG+V/Z48G0JVm/mZJ
 m9iPghOTKDhlSz6c6E/G3QHU40TF9WA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-CYwN916-OxmxKZB-SCV8EQ-1; Fri, 30 May 2025 03:13:23 -0400
X-MC-Unique: CYwN916-OxmxKZB-SCV8EQ-1
X-Mimecast-MFC-AGG-ID: CYwN916-OxmxKZB-SCV8EQ_1748589202
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad89da57be0so148824266b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589201; x=1749194001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOdyiM5i52fELrIv/W1T+k3teEGSvJpSoU6puuRxHmI=;
 b=Sf4Vnx3jVcvDDV1bVbL2oWreyiUytWcwvk9m/AvlVQ8mwd1mjttpOMafRQT0702D2M
 m5cyotdEW7hY4HfUKMNphEnxbvwak7IRFwO4I/RFlkrDZsWlVEddiz3p6DELzcfNu7+W
 aYpJQr10cTYTeSC2w0YMi6X8zzFEAudfSOPLX3SMoLuZOm8jyu8piIUMUuyzfb2CmQVJ
 y/Gl7vKJfQRGy4JOF+EvsdiAdzMlgAgv2dPz1QikNoB1qUif73H3DS5hM9KwUvUCKUGi
 MJ21Gi3nNNZJbuengniU4IyoX+jbsHfnBO6oMgaPQlow8ROJurOOJMdBrcrB5fqFKt7c
 B+OQ==
X-Gm-Message-State: AOJu0YwjKbhHb1KOuFgxcg9jlkgoyTiEMb+urETozEkWCPu+6OBuP3/g
 xp3114bfjKNiHEjJ3mMJOWVQDYdPwHla3IAoPmOe8EdSSfAMHvnub+V8d8X1NVUcvPsAg/A/MHS
 1dEnK5GlV+AVYQG/4bwm15u2ilL2q0QPbNfPgwxcxoesFfWvZ7Nqe6OUBLJ5Mzb9oFt9VncVgYN
 Gpl9Ppew3XdJ70QPWW0lZkYhlO8NKUSz1mbVITvRhw
X-Gm-Gg: ASbGncsTr+ORpRoPMfF7Dpe+SLAr0Yt1ce6eIewNaEQIOn6oaGCv0nvSgu4RVJgW0hR
 7mHhOkVsDHWfTxAv5gZuUUH7GKigW5AXPLKTgiOU8fkf/BVc5NHl3gKoZuraLu72nv77ZkbJRZe
 42W0GwKaTRx69caw0fRIpj98VVVZI/XF11PGDtWSw46r+/Dp0dkADjoUSV24D2LsVOR2wgzskap
 F4LsWW5pqu3MKTHw/7Lmd9Uhlap292vLgv5WHga/1c+iyY38JS281zSSYGdd25OeCZzVIIvDzd2
 PdYdWU4q7aDZlA==
X-Received: by 2002:a17:907:7249:b0:ad8:9844:1424 with SMTP id
 a640c23a62f3a-adb36c08a69mr92047166b.61.1748589201331; 
 Fri, 30 May 2025 00:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrBmd8zLXX0sXa1HD8GXPXreS8gwNSYrx2e9HZU5aJ8m2rf55FXpCmP7Txix4YpOqy+fRiyA==
X-Received: by 2002:a17:907:7249:b0:ad8:9844:1424 with SMTP id
 a640c23a62f3a-adb36c08a69mr92044866b.61.1748589200838; 
 Fri, 30 May 2025 00:13:20 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fec86sm276403866b.7.2025.05.30.00.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/77] target/i386/emulate: more lflags cleanups
Date: Fri, 30 May 2025 09:11:42 +0200
Message-ID: <20250530071250.2050910-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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
 target/i386/emulate/x86_flags.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index 47bc19778c2..cc138c77494 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -255,19 +255,19 @@ void lflags_to_rflags(CPUX86State *env)
 
 void rflags_to_lflags(CPUX86State *env)
 {
-    target_ulong cf_xor_of;
+    target_ulong cf_af, cf_xor_of;
 
+    /* Leave the low byte zero so that parity is always even...  */
+    env->cc_dst = !(env->eflags & CC_Z) << 8;
+
+    /* ... and therefore cc_src always uses opposite polarity.  */
     env->cc_src = CC_P;
     env->cc_src ^= env->eflags & (CC_S | CC_P);
 
     /* rotate right by one to move CF and AF into the carry-out positions */
-    env->cc_src |= (
-        (env->eflags >> 1) |
-        (env->eflags << (TARGET_LONG_BITS - 1))) & (CC_C | CC_A);
+    cf_af = env->eflags & (CC_C | CC_A);
+    env->cc_src |= ((cf_af >> 1) | (cf_af << (TARGET_LONG_BITS - 1)));
 
-    cf_xor_of = (env->eflags & (CC_C | CC_O)) + (CC_O - CC_C);
+    cf_xor_of = ((env->eflags & (CC_C | CC_O)) + (CC_O - CC_C)) & CC_O;
     env->cc_src |= -cf_xor_of & LF_MASK_PO;
-
-    /* Leave the low byte zero so that parity is not affected.  */
-    env->cc_dst = !(env->eflags & CC_Z) << 8;
 }
-- 
2.49.0


