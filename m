Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0971DCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEL-0005sj-G7; Tue, 14 Oct 2025 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fE4-0005XJ-48
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDz-00014i-J9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4PpLZCIcS/TWHP7SQYNUMpLS4jIGwyW9HPY7SpN9RU=;
 b=brq8RrCkfh7wyTCOc+bXGEvuFCVCqJjEQuDRYWzj/0x3bGWb0Kqmv9cLq0CiJi6G9Uqo9a
 Rfo5LqLQE3T41uM/dPK5w1cksaTeDjfcLA372KksaXOGhL0euCw7qQsd3Ynv+SU3zPXLxx
 dgD3gqSXa9UTMG03mht4HjY6IXukrNs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-IL8OpvtWPqiqtAZqUnO4_w-1; Tue, 14 Oct 2025 09:37:53 -0400
X-MC-Unique: IL8OpvtWPqiqtAZqUnO4_w-1
X-Mimecast-MFC-AGG-ID: IL8OpvtWPqiqtAZqUnO4_w_1760449072
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso38647385e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449071; x=1761053871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4PpLZCIcS/TWHP7SQYNUMpLS4jIGwyW9HPY7SpN9RU=;
 b=dZNEcl+FUPyjMAjrOl0hC2lLjbJoyKzCfhKWjlukP5vK7Hk10P5TCCqspguOW+XgZ5
 pbSTEFf64WUsS5Tdp6PaielReYWbzEZp8k8juXvi9BFIGhqlDmIC8tlt+yBDFVKuHXuv
 0ShIsiR6bpTKkVpu8ZDAm41AD6xob23xstq41NzO+7tjDprs1uZcHskywUtLasNnW144
 AxH+g5lAhVuYjudWNfyBTpWJNWJviHoY5C4s66Zj7URDkrJXv/OOKnHD4XpN/WjQaSrs
 oxNwicXMi30GJx5tPbUQREFFp62uSjqkUJCCvfBltZvYVZJe1X3bke1JuBSI5LU5Re80
 WnEA==
X-Gm-Message-State: AOJu0Yxc7ELNoiK2wqbUjvthpf443jfo41AA+qPt0Yrog6aIGyuvALfI
 80IOFbTpiu3BGgi6k0Tz3EGdqM3Y4sx3vHESZfFhEoxoBw/DfCuk76J7jAsUmHZu5NuAg8/d5av
 SSxG2C1BhsC/3GhO2ohKMVo7bY4zz3n8IixB+axtvDVFBfBoeZ+ABgMeJDYbnwWPpB89JfUoZ9/
 iTbeVkvntoHcBi6cSIX1iZhQnl0VpXP478SyMiapMC
X-Gm-Gg: ASbGncuOshYNd04b27iXHdN5m0KiqYtoOLMMCa/U+si3/Ud89vsWcDWn0mdnyw8Z26K
 6+8NIgtEQ8uqTTI9VF1Eisglzm9+Wf5KdPTIQji7Z4sOhm9T2bFxASLgUzDo3WWERlWqO8Yte+H
 10YwtadTHBHAdNuBkVGu7MbrR66sDfD7/i+BPbrKA+GxxNY1x9XCbtacWMtLJgWbbePGWrX1FlE
 mGXkP2eeuhwcKBE2dd2FbsQ6cXaE0LNhBKZ8m4YuMy0J7SOaF0rrI/AYUNpAU2SeUl7RlYfdynk
 vQMaSackFeaZX9fMGMrSn0siUZtkuR3Uee8mRfd8S15MgEsPNt5wkpkmitBPfHEgddRm0bSMleO
 GfRfNUirygIk+7XegjP+cgcOAK28zRAsfOoTfUsypsRw=
X-Received: by 2002:a05:600c:8b41:b0:46e:4b8b:75f2 with SMTP id
 5b1f17b1804b1-46fa9aa2209mr178663565e9.16.1760449070969; 
 Tue, 14 Oct 2025 06:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTsWrd5e3mkFYaptflG8bQe4QuGl5qvratYD+/UegofuzuPh3tlYwcW0VfSB2SEztlHC2xkA==
X-Received: by 2002:a05:600c:8b41:b0:46e:4b8b:75f2 with SMTP id
 5b1f17b1804b1-46fa9aa2209mr178663305e9.16.1760449070434; 
 Tue, 14 Oct 2025 06:37:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab524f92sm150156755e9.7.2025.10.14.06.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 14/28] target/i386: user: do not set up a valid LDT on reset
Date: Tue, 14 Oct 2025 15:36:59 +0200
Message-ID: <20251014133713.1103695-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In user-mode emulation, QEMU uses the default setting of the LDT base
and limit, which places it at the bottom 64K of virtual address space.
However, by default there is no LDT at all in Linux processes, and
therefore the limit should be 0.

This is visible as a NULL pointer dereference in LSL and LAR instructions
when they try to read the LDT at an unmapped address.

Resolves: #1376
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4f99cbc5c0b..455caff6b23 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8649,7 +8649,11 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
 
     env->idt.limit = 0xffff;
     env->gdt.limit = 0xffff;
+#if defined(CONFIG_USER_ONLY)
+    env->ldt.limit = 0;
+#else
     env->ldt.limit = 0xffff;
+#endif
     env->ldt.flags = DESC_P_MASK | (2 << DESC_TYPE_SHIFT);
     env->tr.limit = 0xffff;
     env->tr.flags = DESC_P_MASK | (11 << DESC_TYPE_SHIFT);
-- 
2.51.0


