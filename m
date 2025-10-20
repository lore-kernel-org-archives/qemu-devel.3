Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FDFCCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy4w-0006UH-Dw; Mon, 20 Oct 2025 18:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy4v-0006Tn-6O
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy4t-0006GH-6w
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4712c6d9495so2927745e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998205; x=1761603005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTh/TXHrRxWOV1KvlT5RHXxmysc4zuKbZjFKHXnGbRQ=;
 b=vTywkx/9HpPP4gFVhxgZrbUv/HMXUTEVpo5KemlzbgJHYy1MhyxoXdnc8XgRysyxkv
 gcBPrfmr2BqyNq1IZIsfH5Gmp5w3QvQ8Lh/3xZZYdiNZH/coLDtfGKnrsbkGROrFnLXF
 5DTCxDINxpttYI5I07ozPglimF4ScDxknLi+WRGMBL09QQvI/ILwTqs4FYiNNVIY3Boz
 8xaKQ5/SFA6m4O16CxYAtwH7wGAzGwbK3ruoXg8kTjJGkqfaExyStt7q4RLnSUl8TATB
 K2yXR13QYO5bTBF2juL6O8qKPY+oyyTIq6ZovxZLJErihOcj1au0Q2fIwU2yiIPN3yMF
 JiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998205; x=1761603005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTh/TXHrRxWOV1KvlT5RHXxmysc4zuKbZjFKHXnGbRQ=;
 b=R0HKhFmbj6dW9OIG1fq/tnNdL8ZYiPx2t+uZo9SvBeTTj7157sXg4a+pIShvv/MHbU
 +1HRx21xnB8vsp0bQjGcIMPRb5b/ZJL2sUcB9ricRp6qaRHEfKFchme9PpXcagBuNyWw
 HuE882bTs6kX5JVIqRLHqn2qonHynZseIeqodPGSJttre7fdWynLiOGUfi94qKKrz7kC
 jcnNN9U1mO0KCMB4eWZyybBWixqK1TJxmN6jM2QDG/ANj1LFxTxHMJO7Pp0VOu7/dQL9
 3Poue0Xir0uJwSIaNyD37RPFV3IaAbPApnUJ6ZBUpoT8VRc9PkZQuKz2gElqypzBrHKr
 Rcnw==
X-Gm-Message-State: AOJu0YzU2f+dmKytwsFtvuoeE5LyoGHJ2AKyBZN4364SR+Zz1+XpRMHJ
 UPcC/Ov5s0gf5PeSENkY11DG7WUY39hRJE0rymAmDwK5bxaSNw+N9c0X08R53jsZGt1/6/jJdYg
 UpokM9lo=
X-Gm-Gg: ASbGncv2qsxxhJUYemIu41HSx4b47mjCU+6pYhq+J2SjHtTBRluV6/tPbodiLFX9yGg
 SyqsGgfn0bGI0v312hcOdVh80Ti8uRYT60UhnOGNuM+1Gz1mJvBcN38VfPvAF79+skapC6gMHV6
 bmHOpIbT0mW9oIGVmi7MoMkflONiXpMdPN1CxpKqVHEef+e32chgJLueTTee4AfLSy07bxTLqx8
 fVjmPDyhKhuGt8a6mb4YD1VSF2+qk6wB38p3pgv9Tf+hgmNpPF3e/7nfx1EQlRUHp1KuOETGw/y
 77FbHnou07txe29cF+AohtrKLHdOafNvFOaWg3+9BF6kR+PA9I3dUINtMGvQwDNIsb1PSHlKwZd
 8dX8Xy4vZlmhxLE8iU53u/MVrjg3ttgcoT8uf+GJbdlcnX+H1JyJInyTiauJ/1any8pk4X4QObb
 99R725aCZBJGSb2sXiDkQ6u+epC4ZBBZ2mNC2Tt+f6X/clqQ6Css/ITO1LkpwCTJ/WOx/dGKY=
X-Google-Smtp-Source: AGHT+IGWxyXvKDwNF/DwAbM5Sh3jmQMh/rBRb4o4Yyw3vAcpz6nRLQd8zWBy8X44SuKWzwgtihli7w==
X-Received: by 2002:a05:6000:2010:b0:426:ff7c:86e4 with SMTP id
 ffacd0b85a97d-42704d8df97mr9666760f8f.19.1760998205024; 
 Mon, 20 Oct 2025 15:10:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3acfsm17032038f8f.14.2025.10.20.15.10.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:10:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v6 04/30] hw/boards: Introduce
 DEFINE_MACHINE_WITH_INTERFACE_ARRAY() macro
Date: Tue, 21 Oct 2025 00:09:13 +0200
Message-ID: <20251020220941.65269-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

DEFINE_MACHINE_WITH_INTERFACE_ARRAY() is similar to
DEFINE_MACHINE_WITH_INTERFACES() but allows to pass
an InterfaceInfo[] pointer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/boards.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 99292edf5a8..a60e1d83390 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -504,7 +504,7 @@ struct MachineState {
  */
 
 #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
-                                machine_initfn, ABSTRACT, ...) \
+                                machine_initfn, ABSTRACT, ifaces...) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -516,7 +516,7 @@ struct MachineState {
         .class_init = machine_initfn##_class_init, \
         .instance_size = sizeof(InstanceName), \
         .abstract = ABSTRACT, \
-        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ }, \
+        .interfaces = ifaces, \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -526,11 +526,15 @@ struct MachineState {
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, { })
+                            false, NULL)
+
+#define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, ifaces)
 
 #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
-    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, __VA_ARGS__)
+    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                        (const InterfaceInfo[]) { __VA_ARGS__ })
 
 /*
  * Helper for dispatching different macros based on how
-- 
2.51.0


