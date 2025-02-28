Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED433C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6bx-0005MC-S7; Fri, 28 Feb 2025 15:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-BbCZwgKCnMnYVeUiZbXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--whendrik.bounces.google.com>)
 id 1to6bm-00059q-Aq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:19 -0500
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-BbCZwgKCnMnYVeUiZbXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--whendrik.bounces.google.com>)
 id 1to6bk-0001Al-Bz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:18 -0500
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so2107118f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773113; x=1741377913; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=T6l8npdxC324roaIdrme3w/FcKx3sGvjwIH9lVt7u+8=;
 b=CerSCiGw+ung4PEbdtyhmlBE313UoEAqhuVVwS4dQZA228PmElW9ZaR3HZ5QXC2dI5
 p4scgA1YDJp1PaZrndlne5N3P5FAX8fvQTD+hz5vYLorI3UwgodUxw+s2qTXu3VlTA3f
 u+dqbAmPfTG8Rdav/72kDvZHiGjZiJg/uk+IGoh9L9LBSSXuNyd9luGwRgVIio4V0d7W
 ARedrRnVmfxVaA+IxJ/m35HrxuNSVcleQEEvor80X9naStS0JbOEvzNgreJA0mgrUwTE
 uhzAyQlj4WPeE5nWths/7PDlzmmLnRffSeF31Bx1ujPHwZ44qEo+REU9LXR2uMRufuFH
 eS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773113; x=1741377913;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6l8npdxC324roaIdrme3w/FcKx3sGvjwIH9lVt7u+8=;
 b=ADMbrzyZp1IhYATU18XsV7Wt4NREdIdB0aEszHLSeN8oj69iWErecgIbGNYtS3dEFs
 HW1UYYmvH14RSWaxnGvqnifpOlSsYNcbFaWlxdAI/CJQJMM/lrnaVVX7D1eMU8JF4xvs
 kzFHmCcWqNKWjSQhP+qbblyedm3azJr0qVOLexeWH3RcsOQHg/eoEN0sdIR/YeaLsj8o
 HgZsY9eEqvbS++dlMWq7S8gQKpz+5bj9yOSWKBtvRmQI58f3EAJRpDRaKDfWmZhmKkf5
 ifz7G9QhWCMoBQd5IulgKWoAMnS2DeANxJL1v+/Ro8um+bKQ9wreJLK3a7GG844UIH6m
 hmpw==
X-Gm-Message-State: AOJu0YykSzTp9+dNRuV0athXHaGEJMqkZbRiZcWaclnTcBu06oA0ZM4K
 YKym5Cpj52/NvYM87Wj8LAiZk7OsDYxORKfxt8pTMs+OpSkLEUYAkctz7ALZcaPduhy6JS+MbcF
 ZPm1GUfudYwldpdrlhMSDhNAJ9HIBNjktokLJ67f48XkK+qGtftTVYPZPTED948LkBrRb6zKPBW
 IiehghgzqQDdN3g7Th6Gv9gJYBWrKqiMw/N3XQ5TzQRA==
X-Google-Smtp-Source: AGHT+IGXOpJDqUEYXVp0Y50O72GYiqFNXjrYusgeUKsSM773D6PSE4XAHz4u4s7Woov0xziW0t8RI2r0vyjZFA==
X-Received: from wrbee9.prod.google.com ([2002:a05:6000:2109:b0:38f:3f49:99e9])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a6:b0:38a:8ace:85e8 with SMTP id
 ffacd0b85a97d-390eca5b4c5mr5511269f8f.44.1740773112991; 
 Fri, 28 Feb 2025 12:05:12 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:53 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-8-whendrik@google.com>
Subject: [PATCH v6 8/8] i386/cpu: Adjust level for RDT on full_cpuid_auto_level
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3-BbCZwgKCnMnYVeUiZbXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Make sure that RDT monitoring and allocation features are included in
in full_cpuid_auto_level.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ec3d88a65..55003760a6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7825,6 +7825,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_F_0_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_10_0_EBX);
 
         /* Intel Processor Trace requires CPUID[0x14] */
         if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
-- 
2.48.1.711.g2feabab25a-goog


