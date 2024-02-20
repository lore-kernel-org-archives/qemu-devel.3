Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80444C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL92-0002ge-71; Tue, 20 Feb 2024 03:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL90-0002gF-Tt
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL8y-0000Ot-K0
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoZNemosrZlF0VbcrQ10QwNx5AdowgSfJjGMKLwo9d8=;
 b=P2We+nW8JWHRTMzhwks/0US7z39seeoaZHLem+VKMKee3kVXnZ/hLyFVMi7D1nR+UDZNEm
 KKQIkMcf1bLdduGH85SNhJFyerhKND2nDhfrR209y4bpvPEiE+e3reveiEMYAxONUVt+aC
 rtTpnrXAnADMqU855oPH6FPn8XZccFo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-m59GQlM9NyCg9Y6-8hAJTw-1; Tue, 20 Feb 2024 03:06:22 -0500
X-MC-Unique: m59GQlM9NyCg9Y6-8hAJTw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3ede65e32bso39251066b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416380; x=1709021180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OoZNemosrZlF0VbcrQ10QwNx5AdowgSfJjGMKLwo9d8=;
 b=u0DljWyCF5K/FE6BPccZLoGDVyJwhr6jykB1f3vGqxKcOHDG2Dsmts46tzoI20vyY2
 pmIKalJ94DlfnZA9EXiG1XU3hHecYYU4kABJPfJOScwEf1MT23bUYkJUOCPxeRb6g2O/
 8S1UCLZK77AMm2lmVpybH2UEtfvRayVfj1ZnEz3JyP1bJuT12XgdFeQGGHwmEakdtbIS
 OdDBccQoQeeyf44NYLVZyBLjH302MC/iC3I5GeY35jKnVbnFovjfTz+cQjS7WioxRZ+1
 0ypMIXqOr+zRXSRgpTWZm3LkQbBc1jzAq0HaEbrZq4xd49P0jsvJoeo/5q7gRqeNGLfe
 c/2g==
X-Gm-Message-State: AOJu0YzMNlH9vuoHEwZV9WgaRZiX84cNRiTkW4bzLNp2XmdOZr4UbeHF
 Ftw7qcsmolD3XAmWneKk50uTRgi9R4FEXOuY0SAxitErPSEaNBSEP19SxWLqGo9HxsG4w50hkAW
 yTYU/m/oHyN3+DkkPoe5jhSmpg7Eo60WeHbik7cFWmeoRcstYa9FVZUhn5hG4Bp3eqpT1wKkgeO
 ndy3FI15B8/bdHC+pv82Q+bNg5xdO3s2jmOY3W
X-Received: by 2002:a17:906:27d1:b0:a3e:5ae8:5777 with SMTP id
 k17-20020a17090627d100b00a3e5ae85777mr4299937ejc.44.1708416380572; 
 Tue, 20 Feb 2024 00:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoB9jVXQStklP/BiPSiKiUY8e4W4dTDRom3ggsec4DHRFY3O6UhwT7eG2BBZWfRRRKNx94GQ==
X-Received: by 2002:a17:906:27d1:b0:a3e:5ae8:5777 with SMTP id
 k17-20020a17090627d100b00a3e5ae85777mr4299914ejc.44.1708416380124; 
 Tue, 20 Feb 2024 00:06:20 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 se7-20020a170906ce4700b00a3d26a25cbasm3688569ejb.37.2024.02.20.00.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 qemu-stable@nongnu.org
Subject: [PULL 02/17] i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI
 and FEAT_XSAVE_XSS_HI leafs
Date: Tue, 20 Feb 2024 09:05:43 +0100
Message-ID: <20240220080558.365903-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The value of FEAT_XSAVE_XCR0_HI leaf and FEAT_XSAVE_XSS_HI leaf also
need to be masked by XCR0 and XSS mask respectively, to make it
logically correct.

Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>
Message-ID: <20240115091325.1904229-3-xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 800caeb593b..3ce138fecb7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6947,9 +6947,9 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     }
 
     env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
-    env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XCR0_HI] = (mask & CPUID_XSTATE_XCR0_MASK) >> 32;
     env->features[FEAT_XSAVE_XSS_LO] = mask & CPUID_XSTATE_XSS_MASK;
-    env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XSS_HI] = (mask & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
-- 
2.43.0


