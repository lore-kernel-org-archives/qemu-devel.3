Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F103FE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI21-0002vG-5G; Thu, 05 Dec 2024 15:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aQZSZwgKCv42nktjxoqmuumrk.iuswks0-jk1krtutmt0.uxm@flex--whendrik.bounces.google.com>)
 id 1tJI1m-0002sj-Jp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:47 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aQZSZwgKCv42nktjxoqmuumrk.iuswks0-jk1krtutmt0.uxm@flex--whendrik.bounces.google.com>)
 id 1tJI1k-0001eU-Dl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:46 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-4349eeeb841so8996875e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428842; x=1734033642; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=y/EyZcmrposqvK7v6eP2KNJq/oTP0txZto7n4zafF4w=;
 b=BJOV7/6CrhWp9EfyJ2uP3YPzwMOyOyHqO9Lm+w9ZdKZFaOkMRIzp4R98kBYRubrZWb
 th+2ro5xtC2XdRjGAYTUbYp8WNOyovX8T7Z4YKJz6KJEP+XyhEEEkpIm5uftIvlP9etS
 ogiR0Y54YR8audte2S2jHHxf19VxN32bQRywxAz4T2f0xjF9ETIRzvpsZVAmf326SLH/
 UwneE4JEg9GXqWZbxxtuE7SoQafrKWPFrQpKvjpqbWdx9hLfW2zoCHmhC6w0sZ9kC+Op
 KYUPA8XvpKcS9bvAELRRNLHD9mWX5o8+jRp/0pFJnIw863daMRhiNJYt2ZQCBgKYV0Kk
 gUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428842; x=1734033642;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y/EyZcmrposqvK7v6eP2KNJq/oTP0txZto7n4zafF4w=;
 b=HmJ+G90toleTDV9M5OtD/Y60c4Kn+LnOjCagWQ9E/0q3+dgLA1UhxuQL8CE9DsR2WH
 EwfkfFoxqNHeLLAyaI72E7pXFB3BT1WITMtuv76KPkGvstF4ubyImKnNIgtlnnd7Ra0u
 3nPcDIOHyCSVxAupncjpMjEw79eNhcJ7KIrRWkL/VnOhbUtipqHxFJk2xnNz4YZi74+t
 HWBevJDET19SYPLqF/HgxAh0elGG+Awm2VhVRo90oBdm4P9MuZ5UwJYRALPjyqgQU6Nh
 aZkV0pdlQttqKhPRFkSxkvOVYS39kjyrvRhKt8ua8WcKbWF81CFB3oVFm6W5sRzVfX4D
 AbWA==
X-Gm-Message-State: AOJu0YyXz1Kfg/4+J9BmtLb7HAHwPQ0BLzWZhzJWZsP1UBKX/LNMPq1F
 unf+UhfEwFuhnhE7KDXhSKFTzo8l9A/XoZhpoyNNN9vGn6uetN5Kc+kFCa05UDf2Uy5zxl5NCM0
 McgB3VM8ZhclM2n502FzkHP2LEaG8/4GkoLfn4kbETGKATXKdoEgcKJuvTmWpcFmcfHJCPG8nNX
 g2UIB1LQYyFxcpnll2lM9dB+d/OAYx+yPrhRmIJ5gaxA==
X-Google-Smtp-Source: AGHT+IHTSTZmmHmeM6XYplaTA7zqIf5wCrVJEUJSykh7I/4p4C22l632QtWBjHoGo8EzU32FNJN1cYnBg8+x7g==
X-Received: from wmso25.prod.google.com ([2002:a05:600c:5119:b0:434:9e9b:cd19])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f87:b0:431:40ca:ce5d with SMTP id
 5b1f17b1804b1-434dded699cmr4496965e9.23.1733428841952; 
 Thu, 05 Dec 2024 12:00:41 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:24 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-8-whendrik@google.com>
Subject: [PATCH v4 7/8] i386/cpu: Adjust CPUID level for RDT features
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3aQZSZwgKCv42nktjxoqmuumrk.iuswks0-jk1krtutmt0.uxm@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 5e29bf341c..045705884a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7719,6 +7719,16 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **er=
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
2.47.0.338.g60cca15819-goog


