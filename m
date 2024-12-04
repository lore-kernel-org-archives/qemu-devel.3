Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF303E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl4C-0000Ni-SG; Wed, 04 Dec 2024 03:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3exdQZwgKCiwePMVLZQSOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--whendrik.bounces.google.com>)
 id 1tIl4B-0000Ly-ND
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:49:03 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3exdQZwgKCiwePMVLZQSOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--whendrik.bounces.google.com>)
 id 1tIl4A-00015g-6E
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:49:03 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-434a195814fso48709325e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302139; x=1733906939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=iToU4ifoTogZaZYEzFXGtcqpRLmu4bvhKXXyDGHPJUw=;
 b=aFfCB/r1W+PYfOT8JOtbQDeY3W0bjU2tkn+Vtd5miUCGVIvEEWXR9KvCde/GXSPJo/
 VPufqE6YcwLCbBYGr533oYw2rFqT+nV1r87/ZEGTkIdmZ4reA7TiQKvR0OSTO4FXwgZN
 mvTXpoYP+ydy6xZxeINE/pzLf9EXlpo/IAq/K0nw9x8LATk+DMxTkzD+VnAnwcX7o7cT
 F71GiVF8zEjFPsoRVsUH+GvbJuZbMw5HLi8IKk/zsHuPwl0nH8c007nrSakdu8atl6/d
 EpYJVFMzaw6uAiGIe1WhkjEN8bQU6r0fy5D0JKONOrZIJr+jYFTLRfuJKhAHeXhi10pa
 mHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302139; x=1733906939;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iToU4ifoTogZaZYEzFXGtcqpRLmu4bvhKXXyDGHPJUw=;
 b=rBdlwGx/yw5dVRUOBjw6EUAYBwlFlcY0znKaFon69AcO4AqlvFDOlHHZoO6KiVv7kN
 3ixMkLahY+2DNY65JCZE+l3/98KYEhrC4HM6PidCVoPqpjnqYqcU5TOhVySwmizZ6KX3
 AfUroIXvfzD13/Pp/WmrTn8RzlNiuS1rSdXhyD8IcohJ6uWq14Jht4CBxpsZqn7n5lC9
 iyBlgRt2YG/tmG5xSShHYZkM7kqWoTgIoBFzKbDVMKx6TkhPPiGvD+x28oTDx/4ow5jR
 uqXkpshv0HvHZu5gIFa18OOLlVgnmaYYC1HGwpDtrsDYH54w4U5aKJdtpQHqHVzOVrxD
 8QZg==
X-Gm-Message-State: AOJu0YxPw5u/GTkfQSXtCsp8K0c+wg9UtB3o8xOLRzPSPstz+9tyP0c1
 VdTCZgfiIikV65C0RxpM37p5DiVe2XOYi0UA61+LO2EuoOUpV74HR3e/phn4m4m1SobXEITWTmN
 Y4131eL4/B+3Vide8b+HLeCGSe6JJplURluZesOVSlx9415TlcRsxnh4EK8p/zTe7ykUDDX3ZBI
 wG0E3hags8ZkbJ0binZnF8N8HZcazCXhEYd6nGr/R5rA==
X-Google-Smtp-Source: AGHT+IHOGBM2ZkXOs7Twgi1Hm4IPflsO3ws7GO+JLAnrUNLckMKMfR2gCWONU49AFOsL6/CBIWcOJFYUeexftg==
X-Received: from wmow13.prod.google.com ([2002:a05:600c:474d:b0:434:9f2c:eb0f])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4745:b0:434:a5b3:8fee with SMTP id
 5b1f17b1804b1-434d0a07c49mr42095765e9.26.1733302139239; 
 Wed, 04 Dec 2024 00:48:59 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:37 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-9-whendrik@google.com>
Subject: [PATCH v3 8/8] i386/cpu: Adjust level for RDT on full_cpuid_auto_level
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3exdQZwgKCiwePMVLZQSOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--whendrik.bounces.google.com;
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

Make sure that RDT monitoring and allocation features are included in
in full_cpuid_auto_level.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a400839216..787bb5ba92 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -875,6 +875,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
 #else
 #define TCG_7_0_ECX_RDPID 0
 #endif
+
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
@@ -7526,6 +7527,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **err=
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


