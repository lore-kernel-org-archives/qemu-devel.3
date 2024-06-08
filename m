Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D548C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrX8-0000Wl-R9; Sat, 08 Jun 2024 04:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrX5-0000UO-GL
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrX2-0008GH-ME
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Omj7V/9neG3Skvv8V7gZhHDNOP50DtvEDEa1OSvAS0I=;
 b=MHa0DmYjgibuEL2RzWT3EvINYx8SEIKqN7rnvEQICEAWCC4jrccKmuu/ZSxQdQ8jfL8j95
 HBNFGSH2HHClaXw3zx669TY7cBg+HS3/qq4AWVPHg91BO1Of6SR1yoiZjYE/uoToQTTlMe
 ZstaHtlxNSV7rurt3Ij43xbRbWSjNjA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-CXzj5VwpPnya7bFAulUgeQ-1; Sat, 08 Jun 2024 04:34:33 -0400
X-MC-Unique: CXzj5VwpPnya7bFAulUgeQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6ef9e87ef1so31837166b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835671; x=1718440471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Omj7V/9neG3Skvv8V7gZhHDNOP50DtvEDEa1OSvAS0I=;
 b=ChU2PDkIpprpQPrg+VOBKJkbmbnaq0xkrPeIR/aRf3x6ws13gVvmOyj+AB7sdboN0m
 220JJ5lH4zYoivRFLle/lAuCC5xOEW8rWLT6GHD/bOXc0wGV3Xa+JiXhbgxaxbzNOodR
 HWJ6PUCEcRDW/deo8u9wOLRiE9gGRnMAua+kUK6cK7lrruSsFobsGIyZ/3u173F7Vc++
 YhJvPviYsQV5goPR7v6IN8qtXlSW6Fhc4PSHMXlHB3ojiehl3ymaLbVt4NVBoooWqSRB
 lECfq3YFZGvhXF+DjGWo1HvIUzthlPbNS6T3AtPM9+waDRFpiXWtGTHuyHd8/luwdq5c
 SBpA==
X-Gm-Message-State: AOJu0Yxsq/ZoWjh5tvbArE36KqMrB/7NkGd6KWB0aLYBTZPt37sPfdc9
 +aXYAf7i70x97olExzhUn4KE+S7xP7JY3EeIUx+pdGGX6DiRcoJ42gvyxSWBYNZSG0xLpMa4zhv
 BbT/lGE32pefvfIgUQLlRczZBxuDfBUbmpQy4G60k8abQk355bma1CCTHD/Svet+OWjz2ITJLYh
 XWQsRdwG+5WawBhmH2ka6JT115fprymtoJv/j7
X-Received: by 2002:a17:906:2542:b0:a68:bb1b:4de2 with SMTP id
 a640c23a62f3a-a6cd56108c6mr295956066b.3.1717835671303; 
 Sat, 08 Jun 2024 01:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFykmrOODqPKL7EYXWbYO/eQqSkcexDyW4HCsAL5qKGmwE3ONlJT/ui7SQPerCdE/D8L7b/Yw==
X-Received: by 2002:a17:906:2542:b0:a68:bb1b:4de2 with SMTP id
 a640c23a62f3a-a6cd56108c6mr295955266b.3.1717835670900; 
 Sat, 08 Jun 2024 01:34:30 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6efe3d3cafsm67834766b.158.2024.06.08.01.34.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/42] target/i386: implement DR7.GD
Date: Sat,  8 Jun 2024 10:33:38 +0200
Message-ID: <20240608083415.2769160-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

DR7.GD triggers a #DB exception on any access to debug registers.
The GD bit is cleared so that the #DB handler itself can access
the debug registers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/bpt_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/tcg/sysemu/bpt_helper.c b/target/i386/tcg/sysemu/bpt_helper.c
index 4d96a48a3ca..c1d5fce250c 100644
--- a/target/i386/tcg/sysemu/bpt_helper.c
+++ b/target/i386/tcg/sysemu/bpt_helper.c
@@ -238,6 +238,12 @@ target_ulong helper_get_dr(CPUX86State *env, int reg)
         }
     }
 
+    if (env->dr[7] & DR7_GD) {
+        env->dr[7] &= ~DR7_GD;
+        env->dr[6] |= DR6_BD;
+        raise_exception_ra(env, EXCP01_DB, GETPC());
+    }
+
     return env->dr[reg];
 }
 
@@ -251,6 +257,12 @@ void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
         }
     }
 
+    if (env->dr[7] & DR7_GD) {
+        env->dr[7] &= ~DR7_GD;
+        env->dr[6] |= DR6_BD;
+        raise_exception_ra(env, EXCP01_DB, GETPC());
+    }
+
     if (reg < 4) {
         if (hw_breakpoint_enabled(env->dr[7], reg)
             && hw_breakpoint_type(env->dr[7], reg) != DR7_TYPE_IO_RW) {
-- 
2.45.1


