Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C68DD64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swi-00043c-VJ; Fri, 08 Nov 2024 12:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swh-00042w-EF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swb-0007cY-Mx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PsIDDY16NboYx8h/JucmIPxHaWOUWJZI19U2mvWFn4=;
 b=FNW/EI2DpN7Q30c/glpGJZS2HIO6IiPmxjfo7dEPk6psI0iBl9hDvPT6Uhxaj+QAQFQNfl
 0TX6NS/D+oGmT21Mw453i9lb0W4fU3XZJem2Cmo+SyeUrrmr141GdQvnDSvnW9+/9hmEMK
 ZSB/8kgNhSG/zkSz5f9//2TvY8PBqcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-4ADrDa3nPCuGDPcqyc7auw-1; Fri, 08 Nov 2024 12:38:47 -0500
X-MC-Unique: 4ADrDa3nPCuGDPcqyc7auw-1
X-Mimecast-MFC-AGG-ID: 4ADrDa3nPCuGDPcqyc7auw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so16536585e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087526; x=1731692326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PsIDDY16NboYx8h/JucmIPxHaWOUWJZI19U2mvWFn4=;
 b=hnySQg+ypiroTOgAkyea1SpaxkKxl4Mpr4j6v/KRwV8dFpOdB2ufEWdU+m92TnJmWz
 AQr1T/yStX5b+1VF3kXolc07xnKv5naJTF/o3aEhQZM2BBrRnzAZm5MOqsa/GlDE+sB2
 yk2MeiMZks+7KnKvZh6aRXUIFxvZ3Sf+MHKDEOiXGdgd/hJqHW9O35ijZ45eTSH/z8Q9
 CqpFtQLn6J7aV5sgXXKXTHJlz/m4lPcaJn98vIlKnHnn9Me3uVeIAmjDzUY3aYFGuDVI
 fmao29fMWZonQVOU3+AZvPTZ/dLVjoFzlcC+ly2fyZnTkio5EdwvoZF05AtVGcgpZwbn
 3wUw==
X-Gm-Message-State: AOJu0YyhKluWJ4+/J0U1egZCC3SJ9iWTnr2NLiRWfAZDDUIDUF42OtF9
 8BHhLyiOEWfORVbCMq0rHhQa38tm3ehqFuBU0nb/jSyjK6qQEMNpBJago8jHYk/ZLE+gVtTMOzx
 jXkgje6NzYkyfJZExNn2nTz5At/V+rbJ4HmpEK03q51pELVvoXXsav7zTICVHcGGlVY0tp3SUgp
 VISFf92hrI9DMqJjNH6nL/Rn8PABwVI34dkbnMPU8=
X-Received: by 2002:a05:600c:8715:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-432b751bcc2mr30817415e9.27.1731087525928; 
 Fri, 08 Nov 2024 09:38:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRrXhlmPJ0n37QsRSInR5hhbtG4RSaFgNZqEa/TDwSmqv4aMq5b6+AU/3Qn/on13osz6JQaA==
X-Received: by 2002:a05:600c:8715:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-432b751bcc2mr30817225e9.27.1731087525438; 
 Fri, 08 Nov 2024 09:38:45 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707bdsm5666540f8f.4.2024.11.08.09.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PULL 08/13] i386/hvf: Fix for UB in handling CPUID function 0xD
Date: Fri,  8 Nov 2024 18:38:23 +0100
Message-ID: <20241108173828.111454-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The handling for CPUID function 0xD (supported XSAVE features) was
improved in a recent patch. Unfortunately, this appears to have
introduced undefined behaviour for cases where ecx > 30, as the result
of (1 << idx) is undefined if idx > 30.

Per Intel SDM section 13.2, the behaviour for ecx values up to and
including 62 are specified. This change therefore specifically sets
all registers returned by the CPUID instruction to 0 for 63 and higher.
Furthermore, the bit shift uses uint64_t, where behaviour for the entire
range of 2..62 is safe and correct.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20241105155800.5461-3-phil@philjordan.eu
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 3f16b0f363d..af9ee17a111 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -119,8 +119,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         eax = 0;
         break;
     case 0xD:
-        if (!supported_xcr0 ||
-            (idx > 1 && !(supported_xcr0 & (1 << idx)))) {
+        if (!supported_xcr0 || idx >= 63 ||
+            (idx > 1 && !(supported_xcr0 & (UINT64_C(1) << idx)))) {
             eax = ebx = ecx = edx = 0;
             break;
         }
-- 
2.47.0


