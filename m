Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CFFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVT-0004KZ-Hu; Fri, 19 Jul 2024 13:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gJSaZggKCk8Dyv4u8z1x55x2v.t537v3B-uvCv2454x4B.58x@flex--whendrik.bounces.google.com>)
 id 1sUqUf-0003bD-4Q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:05 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gJSaZggKCk8Dyv4u8z1x55x2v.t537v3B-uvCv2454x4B.58x@flex--whendrik.bounces.google.com>)
 id 1sUqUa-0004b0-TJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:04 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-36878581685so649744f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406592; x=1722011392; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ojXTO+gqQjO+YFItkBY171VxHM34+l/GDY7MCVJj9s0=;
 b=ePmxGedKkOiTeAYqJcDtD9WiV7dxItX7Jd/rd//k8TcMTsdAEFvxqSV4apvCJ3FixP
 gTLcrp41ZH8fCRDM8f6NwwCgMIZLw7xwLYimjij/Kcj5A1j1vuN9qNiADNLpHTuNsPrE
 oXAZxURqzY/eW1GsPMCEtuc6nFEAcClu0R4fJXR5jZ8uoK7ZLBFGLuOuSC96Xv1CeMlf
 acF33BhsRrN5IKuROsXUVEFq6oVKsUb/CDi1DBqfkw1m6N5SP07QqG281aqaZqmYEoG0
 hzRNUo9W/XoUUANfLqKBbBTr2UAIzmcstDqASBFAZ7ZIYAH6rfS38yTTavlvEBkBQyIP
 +BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406592; x=1722011392;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ojXTO+gqQjO+YFItkBY171VxHM34+l/GDY7MCVJj9s0=;
 b=PJTcQulUX1WobL5HdI3WHHSueF6Kz64EfyfNVaf3DiX/22AiZpuGzTjrtDrfQG+A+q
 aINzqwJHa9r9Edp01cEeGEzEtpKLVz6ztyYZKTQPMiZJ97h/3ruJGqMpJiYwhp76Od2a
 9sNXrZ6WZ5u2PmWBWZJPULp4F0/XYq9Nln96SxBET1/KEaHo5IeqYAQggD+8AUB86YnM
 jlUPO1oRQ96uSk4VCAncVI+IaoSR5XcA1pF7YdpFmqrIX+VSPmjhlcrjav/eCRqAj9xB
 TXpJup6C/E2dD4bmmdNxk9VuQQym2u4wylXG5RbCfW91qRM7OoarBt1iIBxBtSKYREYs
 3ejQ==
X-Gm-Message-State: AOJu0YwdbA1sDsXtELboL7HxUvCDEsWJ+9aqmSDbwzrg+nSiY50IQpFm
 17EnQEtx73+9o6pFuihAGfHUPr6ZQGem7PekulvNAADgqDF+ein9ED244skRvwjfrcPrdmp9MjF
 C66zkzcwKQbBIDuf0P5SVFjJ3cPpmFJyTaAtYts2QOCkQBzScW6qAE02gmb+sjT4GqJkBlWmc2P
 kbfz+uY6q78hYVKdPoBqGMdg24TGr4kzu7CK3jGfWREQ==
X-Google-Smtp-Source: AGHT+IFp5gGxwdfse0K3H/gM+iZmanS258DPiFCNv3JKrx0NW64k6R9ieMSz1dSPNceUxVn1IgDfId0NEogI/Q==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a5d:460c:0:b0:361:fa84:60bc with SMTP id
 ffacd0b85a97d-369b67a35c5mr103f8f.12.1721406592281; 
 Fri, 19 Jul 2024 09:29:52 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:28 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-9-whendrik@google.com>
Subject: [PATCH v1 8/9] Adjust CPUID level for RDT features
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3gJSaZggKCk8Dyv4u8z1x55x2v.t537v3B-uvCv2454x4B.58x@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:51 -0400
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
index 1cf5e5d5ff..482f980a1f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7590,6 +7590,16 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **er=
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
2.45.2.1089.g2a221341d9-goog


