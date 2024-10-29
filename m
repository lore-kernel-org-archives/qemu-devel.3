Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCBCD3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0L-0006UI-Dp; Tue, 29 Oct 2024 11:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o0C-0005sE-9t
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o0A-0000RM-CW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ul/+wTlhx4/Ac2GnRdd1GaRTCtsYyRhOd1o7JsQ1WiM=;
 b=PNSQtY6I6gxex0gZ6TzqlxxJ/jjebF4q+686CwADHg+K3NJllhqhlBsrBhWlOuk48WXXzI
 0rY5mc0Ey3d3a40o9PhBZArwiL+0erK/GIwjaea/77t6VVSFu9PlMmn/VsVtz74U/9adbf
 LD2ryCGbkT5KxuxWr6k8LpC1ARhTckI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-4O-JGqpAOeW5TEHgKTQukw-1; Tue, 29 Oct 2024 11:19:20 -0400
X-MC-Unique: 4O-JGqpAOeW5TEHgKTQukw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso32378705e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215158; x=1730819958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ul/+wTlhx4/Ac2GnRdd1GaRTCtsYyRhOd1o7JsQ1WiM=;
 b=UGEP3GDnVWOmvC8ESv60WHf5LpZRO55WKd17ZHgi4856kaFVUeAK7CxMua0LrU6RKL
 6finE3SqwkQ9Gruh3s0W4elzE0fl94A5EaKGJfKW1yylnqmYUPi2WbYxvlH9YBe6ZxeL
 zSJkw5HmPzz6bQG2yAWNVpO5zaGTTT+TeAkGoj58VI+uQ4PAtf99vHhumjdCx3jGvpbg
 zivSyKJTwtBgCggRdNBr2/ySFjjlQ7tzMObsgvbA69SD2b25zl8RoYeZtCruWaFMIHWO
 TqfQT3OzQCSrTzQ6VQvOQ9nAwLZkP4W9T7KbRESXhzeIDETjlievC8+Y5+1vUehTfmCr
 xivQ==
X-Gm-Message-State: AOJu0Yzl/DXY2TOjsgYtsASvugRdwI0cMqvtJqwMRalMFrOelwkPtaJR
 Ot0I0AXi7PUdJbuW3wEIIeM5Wu7aqmpqRVyCK3KK9P67yhGLSEMYIKRv7+Wt1kpjFYzj9xjRizq
 yyQRqjC9XVvFaLcSGQ4XIDXaVSvG8UqK6PrUxypuUJzGuspNDa2w5IorQKg1g7WSedkTCS0MIVY
 PxV5QHzCxeNuAPbcFsdX3e/8EvoQfq9ymAi9G2Uh8=
X-Received: by 2002:a05:600c:4f91:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-431b5737b8emr21768335e9.14.1730215158543; 
 Tue, 29 Oct 2024 08:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWMAIfUiRbSWH/posKOyCgJJCPn1KrWgDvpMdnLFPu0itsMnydcdvKjrCyaHklg35VCeN6sw==
X-Received: by 2002:a05:600c:4f91:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-431b5737b8emr21768165e9.14.1730215158125; 
 Tue, 29 Oct 2024 08:19:18 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b567838sm181233555e9.23.2024.10.29.08.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com,
	zhao1.liu@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 7/8] target/i386: Add AVX512 state when AVX10 is supported
Date: Tue, 29 Oct 2024 16:18:57 +0100
Message-ID: <20241029151858.550269-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
are identical to AVX512 state regardless of the supported vector lengths.

Given that some E-cores will support AVX10 but not support AVX512, add
AVX512 state components to guest when AVX10 is enabled.

Based on a patch by Tao Su <tao1.su@linux.intel.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c86a49ad05..b6799ddafa9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7166,7 +7166,15 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         return false;
     }
 
-    return (env->features[esa->feature] & esa->bits);
+    if (env->features[esa->feature] & esa->bits) {
+        return true;
+    }
+    if (esa->feature == FEAT_7_0_EBX && esa->bits = CPUID_7_0_EBX_AVX512F
+        && (features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+        return true;
+    }
+
+    return false;
 }
 
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
-- 
2.47.0


