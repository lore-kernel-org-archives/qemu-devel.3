Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DE6CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZu-0000IQ-Tk; Thu, 05 Sep 2024 07:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lJTZZggKCmEVGDMCQHJFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--whendrik.bounces.google.com>)
 id 1smAZt-0000BA-65
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:05 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lJTZZggKCmEVGDMCQHJFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--whendrik.bounces.google.com>)
 id 1smAZr-000305-MZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:04 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6d3e062dbeeso21751757b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535380; x=1726140180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=YlsjdAW6J5vVTpFBfjWCX8gwxASE5xgLrF4n+X8CTEM=;
 b=bSmGRoDVHw1tb53HMztE0ot+ne9qDbEqW+gkJOjgdD8mZ581aiOO7eqoqlHm9bfNV4
 UHAYiXpCLR/2kh2LOIUvY7UwvIHUDhL3YQu4q80SdQEqH/fzDjCHbiOOOnObEdr/9ick
 GLcl9tcCLt1AnNaIgCgbJicJYYm5Thj6xva9qYfDEtCvWGVB6I3O829U2R9p7XayFOem
 TEl1Np6ZNchWhmiYlHqqadQtOj1dv45xsEQlNZQ9HQYlm8FU85aAjxiXJq3LgOYfhtuF
 o2o+mVn54gTQokCcahzXdJj71mxbhDEzvEjKXrDspN+/iVlMdrtOwHbAwl0HNKnxW63E
 YscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535380; x=1726140180;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YlsjdAW6J5vVTpFBfjWCX8gwxASE5xgLrF4n+X8CTEM=;
 b=bgOIjEyoEBWS9DpA+PDaBihWCH3DxldldeAOnzJjUB3j9BXn/k/VbRZEfgPkROqhyA
 M1r8tPK82PZsD6l/iZpKy8iXYKr2/aqh/VSYr5H/uwYWPii2BBSvRzlHKqbfpYz4zVTF
 ZtVZypOHBAa/2DK6fUSi5MkdSCPoKGJ7m3dndKfznGEfTz0Y0aJ82TTNPToBVtB6YDnM
 +DUjCbfwVjZSqpH/bQ/MhigvhQb8PGIk750GCyN5IBi88WT+/oY2z3WAiSmceWtvLUgQ
 KtkS3vRoXg2j6XkALxwmycRrBmNNxMO4qi9hAmMDw6eqDPdcpKw6Ep6mFSCdpNtuFc0L
 FBTw==
X-Gm-Message-State: AOJu0Yzbn6OL+LuNkixcSvLud0icJCuqLjbUVOuRqSqQhsGpJ6efr8z8
 swg9dfmzBctt0P/yku+7HQj3WxQz6071ITYG0VqcjtUn0UNlZAZpxTuLEQIwDwbDMjoQaW7Tgaa
 FkY+ylyLb7k2TQ38zauVmxp10ZwjWVK8xoRygQGd8IvgGfxiy38++HILVgiOOJjMAjvFiVca5Nw
 4XRoSr62khdrULYlViOb4y1EK5pOLTMWJ+W4oYp91dbA==
X-Google-Smtp-Source: AGHT+IGvEqdxwxXcxkTHGsgHbdBq/O0o7N5ZKqrD0KrW26E5SCkQjSzGuzeVaEXURysMVkupaKE7TbQFQrUyWQ==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:a81:690a:0:b0:6d3:e7e6:8462 with SMTP id
 00721157ae682-6db25f47b18mr1464427b3.1.1725535380134; 
 Thu, 05 Sep 2024 04:23:00 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:36 +0000
In-Reply-To: <20240905112237.3586972-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-8-whendrik@google.com>
Subject: [PATCH v2 7/8] i386/cpu: Adjust CPUID level for RDT features
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3lJTZZggKCmEVGDMCQHJFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--whendrik.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Adjust minimum CPUID level if RDT monitoring or allocation features are
enabled to ensure that CPUID will return them.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 36e19bfa8c..7c8bf707c2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7562,6 +7562,16 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **er=
rp)
         if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
         }
+
+        /* RDT monitoring requires CPUID[0xF] */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0xF);
+        }
+
+        /* RDT allocation requires CPUID[0x10] */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQE) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x10);
+        }
     }
=20
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set =
*/
--=20
2.46.0.469.g59c65b2a67-goog


