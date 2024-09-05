Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9E7CD5BA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZv-0000JY-1Y; Thu, 05 Sep 2024 07:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lpTZZggKCmMXIFOESJLHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--whendrik.bounces.google.com>)
 id 1smAZt-0000BW-8n
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:05 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lpTZZggKCmMXIFOESJLHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--whendrik.bounces.google.com>)
 id 1smAZr-00030O-Pg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:05 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6d475205628so26690387b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535382; x=1726140182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=sUIKZZlpr0KfcGjHDI4XoRscrAb+aelmj8CI87q4Re4=;
 b=xmwiJRZsoNiIn7gEdhyrbtMOUZGEe9vElS7UnOeF5nejtv54hIuMP9xP2D2mhT5GiH
 pCPyzQ6AJM1oy1a41SSJoWxAEF0tXFWMzM9PNIihtuaUeDRAB41erYCKxicmCf4mMxEW
 rdpmziankbsAdq+X7612c1GHPOq2mpL9FZdGqXGZEERsw+N4S3ktvQWXKgD1j25OyBDW
 J1nwOBDc0W9SLgzBWWAEv/BGHjb8PsxPXx563kZU4RFMqx3k9GxiOs/lpI9wEdaE2REO
 hv/gndh+JlEW1iS4BiTLQbTLc6e1xYHI7bw9EPKRMeFmBVYsuIabORjitqz3xXGKX5/j
 /8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535382; x=1726140182;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sUIKZZlpr0KfcGjHDI4XoRscrAb+aelmj8CI87q4Re4=;
 b=Z0mzdk1SDimXMnrutflEGBXoVdTgIEd9vk1WYXX2vUiZ34EeFPUdDws2EdDm9xb49d
 HOj275E53hioHAfGD6orf8oPmztRBMfmsKdG5D1N5UZ4c2kC9PWnuiQCilYfcrWV9hIg
 TjwqsOpYl85HD3Yxfl8SZBqUkwDPlBWHh7M07qcYP+wgUYsfbTPusIUcDNZJjNvXS1iJ
 7KYVmzbSrMqLz1BJi2IcO+/dw6WOrln3bdNS6WnwLWd0KUt6oTW0ybybmkJiEUya9AnO
 xHla1LKq8SaM2yfaeC3x+3DLFrszM8RwbhJo62jQhsfqp0ocKFDdGj24T2IkNHiEOcoh
 N80A==
X-Gm-Message-State: AOJu0Yxvos1VNG++6ISYNQLdwLHC0Lwjo5fQcTbOPUKfGeLoSm5Rf4AX
 Ur5eT7iyTc37NRI+J5lEhfAcAMA3p3x0YK+CxQI/eKFIEkaWxz3Gm3NJLL0S1A2gfhmC8V0NETn
 TcZ00swde8Yz0LBxUyS79bBAYE05fE/Wyb0TS5iNMEJ/8tTsTkxIRFS0/psKM7aV2kDPVLUWiPy
 tah0EPOIBokR6w+Y4f9+XQsgU2EHgpgs/umcYb9/cS+Q==
X-Google-Smtp-Source: AGHT+IGmeHQ+41Z3kVOPocZoLAuHqAweDU9d+GaHg+LGxfzt08A2bmKQIyMSwz3YL1SSGQudX9NsAYgchB+y0Q==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:a05:690c:6382:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6d40ff0d1ccmr8721437b3.7.1725535382249; 
 Thu, 05 Sep 2024 04:23:02 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:37 +0000
In-Reply-To: <20240905112237.3586972-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-9-whendrik@google.com>
Subject: [PATCH v2 8/8] i386/cpu: Adjust level for RDT on full_cpuid_auto_level
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3lpTZZggKCmMXIFOESJLHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--whendrik.bounces.google.com;
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

Make sure that RDT monitoring and allocation features are included in
in full_cpuid_auto_level.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7c8bf707c2..649540e971 100644
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
@@ -7520,6 +7521,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **err=
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
2.46.0.469.g59c65b2a67-goog


