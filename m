Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E9EE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI1y-0002us-Pe; Thu, 05 Dec 2024 15:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3awZSZwgKCgIyjgpftkmiqqing.eqosgow-fgxgnpqpipw.qti@flex--whendrik.bounces.google.com>)
 id 1tJI1n-0002sw-AK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:48 -0500
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3awZSZwgKCgIyjgpftkmiqqing.eqosgow-fgxgnpqpipw.qti@flex--whendrik.bounces.google.com>)
 id 1tJI1l-0001fF-ME
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:47 -0500
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-385dcadffebso617423f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428844; x=1734033644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=by/qrvvh7ycM+T3SHAtA87KxLdghdr+xZxH/HpZ0IE8=;
 b=W/VsBgR7yqm3sW+tP+fkk9QVcRgjjVXGKGQDzHneT+SPqiXO+byN78x8VrJWtHQ2CP
 D95HZwA5eJvP/G9ISudbNgzHENglugZ0xPaFTn1MZs7sRPzK5atTUpnVQxeukVufYrKw
 L4fo1QqVZGc74AjLnsBjerNdRrVTn2cw0OncoJO3NhyXwWzHM1wNwjSqtXURUXRgjrzv
 JveXVSmmSA/W6NtQNqJMZvlJQYsO1EBYYxW3Xl5fV4C9N+GAoNeRMeeoz1iwe4N1hBQl
 oD26/R4a2eg76yhTfnwIsqKD9f18O7+AHPRKAgPYtdIbktNukxovpHrimQwBuW0igKIy
 bMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428844; x=1734033644;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=by/qrvvh7ycM+T3SHAtA87KxLdghdr+xZxH/HpZ0IE8=;
 b=IGOna4Q/hSJXvKgaV6ovtBvFZkpNvlWryZWGg1LbSiTwwxePsbIxhYD22lFWfnq31X
 2XJ94GaPMHT9iOq3tZHWEkYCw0hxMnkQ5J+uqgRhkdNdZrvbSJe3tgIP8OxxixdH2oQ1
 z1Go4hrDPHVuMDa8SxPzR3T5ljV5rKx36JY1xW5q4HfUYo4bCKOUElKBD21Dljyyl6vE
 eN0vRvgFku02Ex1n0GrvSPPEP6kNBPNx7WsbLLYfwk4/k4fItMwQh6fJ0IvjQF5FqRQO
 DEDIL9zMw80GhZTTdlDJLE2qKDnqRoYwLBi4qjr/DlvvCzRIKrkEKlLoqTHYQfL82iUd
 vM+g==
X-Gm-Message-State: AOJu0YxeKIxPislOU8pUBU419U+uc+ZxPH6FZYM80+iuIC+21sQ4Ez8U
 CxmV8BKosfjtnWv4C9SeJ6D44bUrik0MCl8W6bNvxXPc1QqxH4+ul6/LaZ6sAX2dBOVXKk1qIu4
 6odWLngrv5mcclNxd4Rb3snr3RfeZj1abPg0qz2RVp5vm1rZ2GgibNkOmV5U0vURvwbu46WO3Jx
 EJHmLZZNpnEUMAagjVodlzd6dJnV6jJCC666Jj/4rfJw==
X-Google-Smtp-Source: AGHT+IGDO235tesWn38CI5l1mG4SH29DPsEeCjUEtDES5yaJo7RdiS4BaHIBoNFVga8bByvA7DqukIeMMpOmQA==
X-Received: from wmaw15.prod.google.com ([2002:a05:600c:6d4f:b0:434:a158:2c03])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1ac8:b0:385:e204:b30b with SMTP id
 ffacd0b85a97d-3862b3f29admr264650f8f.53.1733428843785; 
 Thu, 05 Dec 2024 12:00:43 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:25 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-9-whendrik@google.com>
Subject: [PATCH v4 8/8] i386/cpu: Adjust level for RDT on full_cpuid_auto_level
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3awZSZwgKCgIyjgpftkmiqqing.eqosgow-fgxgnpqpipw.qti@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
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

Make sure that RDT monitoring and allocation features are included in
in full_cpuid_auto_level.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 045705884a..e3f82571df 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -880,6 +880,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
 #else
 #define TCG_7_0_ECX_RDPID 0
 #endif
+
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
@@ -7672,6 +7673,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **err=
p)
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_15_0_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_10_0_EBX);
=20
         /* Intel Processor Trace requires CPUID[0x14] */
         if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
--=20
2.47.0.338.g60cca15819-goog


