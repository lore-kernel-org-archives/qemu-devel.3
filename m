Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55871D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNj-0004Cs-A2; Thu, 31 Oct 2024 13:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZN3-00039o-C4
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZN1-0007Uf-S0
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jSXAMlOSOXDfcDW9peFIbeG+9mklECY0bfsbGQ9WRs=;
 b=IlflAdRk25PSABfpYmAylSwQBfWgCg0AT2wRboPO4Fug/g0D3j0gowtJ+6BXG9Wq3k1BT/
 +Gyu0M0dtekgoQIxkKyIVQXs8Ed64QaA9wl+JP2Hgxbz8MsQ0AhU2/VpkBMJfN3yRPjeTU
 TgV8hPpbX1Ic6DegLaozi0DU+Xk+EL0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-4Wozo2tHPWWIg1YSqJwgEg-1; Thu, 31 Oct 2024 13:54:04 -0400
X-MC-Unique: 4Wozo2tHPWWIg1YSqJwgEg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so7508835e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397243; x=1731002043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jSXAMlOSOXDfcDW9peFIbeG+9mklECY0bfsbGQ9WRs=;
 b=CoMO0kN+SB81MlN5O+kLa+J4lxeh+ejeLDbqAQjnIylUZHZ6dYhYuaQKekmFoYjTys
 SvUb+/kYjFl691YD4efopE93+Wanqw52kkE4h5BGq3pbCpXFN5jRh39lwfVHGx16MoJl
 U3OlfS+Ebk1uoRPAYyhqdzdw3kQ5TausltG15J1CgbTYOyFJGfQf6VhAbzgrd6E486Sp
 WWvn6Cq4587IM04t8kTLEc99BOJewx0J+HOKagJnf6a9SCn1xSImxjsPevA3tXIz2MxV
 DkqihL/ZooSkTzq5ESKTjvPsKosxPgHn6XpCwOfVx70ftDYhj7ySpoT8Gg7H6uSJShMn
 vKVQ==
X-Gm-Message-State: AOJu0Yws96AQeiZrZcqnFptNs77jFmMVkJCBvMefXr9kVOJ/qCI0Q5Az
 teMcPFhQotqmGX0HfHYPflRC23HiHOKSlfh0cH06DkEwsa6Ilz7Ud+sq6L4jmcpz1CpNbUsJp9l
 kcZi9KkfqXfBxyFs91kEF5wKGErHifCQ+P80hMyZrrZKL1CgUIPHsZYaI2ndegs2GjGAN5wyrgx
 N8/v8in2IGkFJQWVEoDyA+qZ8b6xp1perJ3gie9PM=
X-Received: by 2002:a05:600c:3b8c:b0:431:52f5:f497 with SMTP id
 5b1f17b1804b1-43284aedac9mr2537785e9.9.1730397242947; 
 Thu, 31 Oct 2024 10:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6MIfkPv8NB3i7IfQmm/IkZwjNiz+XqsmIpfAib0JegqwoKuErp6E6+6qKFUTFEPxjELiZzA==
X-Received: by 2002:a05:600c:3b8c:b0:431:52f5:f497 with SMTP id
 5b1f17b1804b1-43284aedac9mr2537465e9.9.1730397242456; 
 Thu, 31 Oct 2024 10:54:02 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca818sm64186645e9.40.2024.10.31.10.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:54:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Xuelian Guo <xuelian.guo@intel.com>
Subject: [PULL 48/49] target/i386: Add AVX512 state when AVX10 is supported
Date: Thu, 31 Oct 2024 18:52:12 +0100
Message-ID: <20241031175214.214455-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241031085233.425388-8-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d056285a034..7666a50bf06 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7156,7 +7156,15 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         return false;
     }
 
-    return (env->features[esa->feature] & esa->bits);
+    if (env->features[esa->feature] & esa->bits) {
+        return true;
+    }
+    if (esa->feature == FEAT_7_0_EBX && esa->bits == CPUID_7_0_EBX_AVX512F
+        && (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+        return true;
+    }
+
+    return false;
 }
 
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
-- 
2.47.0


