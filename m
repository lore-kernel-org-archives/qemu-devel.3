Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78985CE8E6D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x3w-00046a-MY; Thu, 24 Oct 2024 08:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3k-00043c-5x
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3e-0000Fx-1F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=leQodRwO8cbwBZJdEKIZ8FGqkROJiM0fBvAauKBAI60=;
 b=bFleFaYgxFQqiBuYBnHsrgUiJlHoYqmhbv7nGSrOFt70xaIfZSv+5yscg7TZLJWSsB/DVy
 tdWjNFNHCJyY0q8+v9CzaRTvzNEaWy8oOISL7w+2An1JfRp8uwlKEr66fp52WWRbWEOSD9
 n943lu9RZ9YQCxmb/VNIChD6swZskpQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-hApMlT_zM_y2HMZPTXd2eg-1; Thu, 24 Oct 2024 08:35:15 -0400
X-MC-Unique: hApMlT_zM_y2HMZPTXd2eg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso7400015e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773313; x=1730378113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leQodRwO8cbwBZJdEKIZ8FGqkROJiM0fBvAauKBAI60=;
 b=nifJesxguLoXmJrxir3EhdL6F0hZk1Zi5+CBfj5Dctui1JjpF+HAHPYmm2BSKMBa3L
 BE71RI5xtJCPpNhdtExtlfz89gsAcJl7YZZ0g1uO1aIgGHE5sfCRYjADdj0rX9UHkQcw
 A/zre4J7lKyhBzMRh1hzoyuZdFztB5YwNOgC2ucMt2hV7vxOHG4/gQ2gxO0gDwh8zMER
 ctHowdvJ+dRQ4RVixFnY38cVLfXbMONspCtgsQECf7J/y8Mx2ehUNmY7KnsZ5ey2qUGQ
 KMWw9wFLLVWX9Etcwmjp1l6EZcam5uid8QbDW6G6kvf/2QF+9cxawe7Ujjo5hfpfcC47
 brlg==
X-Gm-Message-State: AOJu0Yxeb1zofDIWKspCaCexCxyH4XsPvug70MNahfxwLcKnGcfBIOmu
 QIIJ9GqiPefmassU/7afmlCw/h+htMLJwde6ZjXwsK5gLOnL5eRD0HrI8gCY/nvO3f6gSmBK/w3
 IJb8JeA4D2wdpwLVUD1VYGCxLa1cp/jlptE/qE3PVAfnriCnegnyoB1jI+nywb1j8Lyc5BVpw1P
 p4Sv7QxRHmkGepL2qpNfAhguHGgzffnS/QYQql5b8=
X-Received: by 2002:a05:600c:45cd:b0:431:55bf:fe4 with SMTP id
 5b1f17b1804b1-4318c75557cmr16380925e9.24.1729773313482; 
 Thu, 24 Oct 2024 05:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGElUTr29IYXjOtHvrb+2JXgBpV6sHTF+rf7RUz4hleS5Pdbm3Za7Js2aez5VfU2Ocu//S9tg==
X-Received: by 2002:a05:600c:45cd:b0:431:55bf:fe4 with SMTP id
 5b1f17b1804b1-4318c75557cmr16380645e9.24.1729773313023; 
 Thu, 24 Oct 2024 05:35:13 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c1e387sm43915315e9.41.2024.10.24.05.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	qemu-stable@nongnu.org
Subject: [PULL 6/8] target/i386: fix CPUID check for LFENCE and SFENCE
Date: Thu, 24 Oct 2024 14:34:57 +0200
Message-ID: <20241024123459.59350-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
References: <20241024123459.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

LFENCE and SFENCE were introduced with the original SSE instruction set;
marking them incorrectly as cpuid(SSE2) causes failures for CPU models
that lack SSE2, for example pentium3.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f193716468..48bf730cd3e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
         [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
         [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
+        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
         [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
-        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
+        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
     };
 
     static const X86OpEntry group15_mem[8] = {
-- 
2.47.0


