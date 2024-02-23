Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC24C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVOi-0007T9-IY; Fri, 23 Feb 2024 08:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJP-0002Wk-Pq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJO-0000By-8p
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9HILDzSeft/x8LKIsAPFE7LYaAwnW+F+2deJrffy3I=;
 b=IYtQobaogxPFn/bj/GWKCJEUhPz4lU7bx7xwY42JBzJZ+GYRkbZysc5LkP8tieMZtAyu+J
 6//ghvpc7u8ZGVqgzn1Egu799WIhfiRTgJ4I1BIV8HkYjXV3yvCIRrhvt+vN6/diIcvY25
 /NIw0M4EXDynsY4sSwR15Gp8dUj6bho=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-a9DmyXPQOw2Ld5BGJhI-Tg-1; Fri, 23 Feb 2024 08:09:56 -0500
X-MC-Unique: a9DmyXPQOw2Ld5BGJhI-Tg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50e91f9d422so1101538e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693794; x=1709298594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9HILDzSeft/x8LKIsAPFE7LYaAwnW+F+2deJrffy3I=;
 b=V7tnEQPU+ALuAGk/HmexT8dhnAJmQd+SnYuQwgQwrSNItZbFHcxG2PjsXXcfrhPLdM
 2PftSnvC374ZI3KVY4HIugA+ey0Kaka65570uIglIm1kH/A9QBTyG9zrKU+xiCvil1Nz
 230k0GJ/27nzTYd4oQkHa3FFjE+MszMXNXRL17GQKBLDnug4tDpRz2/4TgbxW8zXUCiq
 xCD9Lgj99nEqLj2pdhnjaQEiXbjpBt2TSBO1XPTr/DYFYa1882x4fCo1DsysmqJU7HDn
 s4zyHiXptlPkHuRBOuWh3vXXne72Z6V4BcdtyUilveZrzhyweErw5YQzA89Llu6Kt4TO
 YHug==
X-Gm-Message-State: AOJu0Yy6608ryO4XJeL1SlsRCJHNX0vxhC+A1CHtB6F+HrCFCWIBZ8yl
 GrDXFG8VNOEGY8DAu6NRG5ZHVoGU89cMkczbBby4RSymNQvEkxqAEAGOy1mHDMwtk+T9iTNiRBa
 o/2vt13XoT/INVzCX++Pejuhh73nWCIYSPwfB4M17aRLwzjrcp1wO5h61MvN6POt8jn7OoKvE3D
 JGDHAhXoabvqWzavXjPGNoDd/Gog4a3MlbXFj8
X-Received: by 2002:a05:6512:280e:b0:512:a9b7:c637 with SMTP id
 cf14-20020a056512280e00b00512a9b7c637mr1844962lfb.29.1708693794120; 
 Fri, 23 Feb 2024 05:09:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiQYSWmODja1eQtpxRBKZ2tluaszOw2+BqWFo5r2ga3PS73eEAwnQqiY+K9X+lu8puL5n6fA==
X-Received: by 2002:a05:6512:280e:b0:512:a9b7:c637 with SMTP id
 cf14-20020a056512280e00b00512a9b7c637mr1844941lfb.29.1708693793730; 
 Fri, 23 Feb 2024 05:09:53 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a19ee09000000b00512ec1559cdsm86394lfb.213.2024.02.23.05.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:09:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 1/7] target/i386: mask high bits of CR3 in 32-bit mode
Date: Fri, 23 Feb 2024 14:09:42 +0100
Message-ID: <20240223130948.237186-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
paging or PAE paging).  Do this in mmu_translate() to remove
the last case where get_physical_address() meaningfully drops
the high bits of the address.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439add..11126c860d4 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -238,7 +238,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
+            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -306,7 +306,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
+        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
-- 
2.43.0


