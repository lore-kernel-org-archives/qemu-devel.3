Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348BACAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKZ-0005dh-3e; Sat, 13 Sep 2025 04:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKX-0005d7-7x
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKV-0004Zq-0I
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757750993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7F7JtBib3HtIMCET12RYVWnFXL3A+/WcjU3+rd9Ob6M=;
 b=YEzFEhHbZisysNn0WG41PlslZoSPVPP4XJZC9NAot0EeFkmp/Fu6dmMW0zqZ5rmjWgVJ0G
 sVrggz+Ub36kLt5tU8Mj70TQHDMNkWcxmivudlm16ltvL0MHkaGi4FUn0Ir8F9CvRd5r2l
 m36ygXRufE33Ilu9GdCuowU9LA7AjsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-hQdZRjUaN2u4p49ij2XVEA-1; Sat, 13 Sep 2025 04:09:52 -0400
X-MC-Unique: hQdZRjUaN2u4p49ij2XVEA-1
X-Mimecast-MFC-AGG-ID: hQdZRjUaN2u4p49ij2XVEA_1757750991
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45dcfc6558cso20047995e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757750990; x=1758355790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7F7JtBib3HtIMCET12RYVWnFXL3A+/WcjU3+rd9Ob6M=;
 b=DgFwTSUUdkxYHsuJq8Ho/9fYMYZKXL8qK1XmqKKWCMwM9v9BNaxloVQiPlEXIs8JDc
 LGyK1vqRLN5HjYb/BGw+QlX7zatH1ElI4//qmzKLI8pZuD4NPRok0vkoAgn6IHFPZ4Ko
 XviyfkztpuqjHI2+NVJVw5kFcS7VeXQf7SysRNAhuIODyjqrTEfLQveC56GNQT2DnS5L
 cMsI6ANHsDqchRlM31vinFeodE2xhVDqRuV3VLjjSr9nNE2UFAni/YjJa1cppN5qBJbo
 6wjSEPkeQLzd0l93hdpGLIIGu8PEYCnpzWMTfY9xcZ7GPljAA+WqiWqMLNzhsVLhku+/
 SL7g==
X-Gm-Message-State: AOJu0YxC11/iVuvIV87cgTIqGBkC1oCAu82q7QIqqcdrEeESGxdmS981
 qyoLl58Ywt7FL0Cll/Mxn1woa1OXqBHH4/bhEgtzRMH1gclTYyXwItxdGYr+Xr7JCOvM0xDyPDM
 eBn9vmQixty64Ydpm6xEXzAVyWKBdxujmvKFtKt0TczFWLHbNbLRnBAvHxdxYRcx/tes5YQwLCp
 8dFRnQQogdy77IT+u1Qil1satKsCr8fPrmG1UibZog
X-Gm-Gg: ASbGnctl/dE9VEgVobkA2yTTVuw7r/QqqcuywJvj0h8WFADWYTHu8xM/Fx/jtiLH3ii
 3ljuGq4ZiqoHOYYUVZ+m0+GWFPHGj/524vbGobsTiG198MFjLjgpMVAgKurEt8v6Ru3LUamiU8l
 JK7bh8yYRpXCEfb3JF/sZ5QXYKvvUw3DRSRjNJLT6zbBUY3ijtKnaU32fPdt3eSDzxfhrg5MRJK
 2ZCHLZEXXFze7bU5qM4Ns8ssUVzBkhJYez9T0WRyF4xUHZnsLqmkyHDm1JL0Efib3RH15cYzQ3N
 duxFCfma/bDBImu2Xi6xHNX3zXw9CLA+2SGGEHgn1cXONuhYdvPvwZs15XvZiEEnl9cS1GJz0xG
 OdwJH3ZGgh+E6USNeaSgcXk82akWzK9LqkUv471R1nWM=
X-Received: by 2002:a05:600c:4ed1:b0:45f:280d:15ea with SMTP id
 5b1f17b1804b1-45f280d1cc8mr9541235e9.26.1757750990134; 
 Sat, 13 Sep 2025 01:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC11Zoxy0Fa2GZwYApBFBrCf1/4pBkVMrVKI8bW9Ly3tyor9J8hlM5OA4Z9wWy5jhPFDtyLA==
X-Received: by 2002:a05:600c:4ed1:b0:45f:280d:15ea with SMTP id
 5b1f17b1804b1-45f280d1cc8mr9540885e9.26.1757750989674; 
 Sat, 13 Sep 2025 01:09:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e859a278c1sm2067283f8f.24.2025.09.13.01.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:09:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/61] target/sparc: limit cpu_check_irqs to system emulation
Date: Sat, 13 Sep 2025 10:08:43 +0200
Message-ID: <20250913080943.11710-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-sparc* binaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/sparc/int32_helper.c | 2 ++
 target/sparc/int64_helper.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 39db4ffa70a..fdcaa0a578b 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -65,6 +65,7 @@ static const char *excp_name_str(int32_t exception_index)
     return excp_names[exception_index];
 }
 
+#if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
@@ -96,6 +97,7 @@ void cpu_check_irqs(CPUSPARCState *env)
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
+#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 49e4e51c6dc..23adda4cad7 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -62,6 +62,7 @@ static const char * const excp_names[0x80] = {
 };
 #endif
 
+#if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
@@ -127,6 +128,7 @@ void cpu_check_irqs(CPUSPARCState *env)
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
+#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-- 
2.51.0


