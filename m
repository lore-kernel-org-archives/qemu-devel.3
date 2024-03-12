Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA75EC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1xv-0007yh-G3; Tue, 12 Mar 2024 09:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xo-0007sO-LE; Tue, 12 Mar 2024 09:14:40 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xm-0006oe-CF; Tue, 12 Mar 2024 09:14:39 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so305177b3a.2; 
 Tue, 12 Mar 2024 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249275; x=1710854075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hIrP+GOO7mqBVQBlneIZNaQyZ+Zlpvjob7t6Cp/ux0=;
 b=fAKSh2Nfc7QU2xQqKdZ9EPIg+FfGiQu0Od6kNKEpp2wiJQG+VJJ+hZWPPOodRGHaJ/
 STAUd0zfFUMTBLPZODb+PfcRFq1u0um6yTORuXDE+ZWimDu6gEgHvK3Q0tZiY9YXhd92
 M6PXVfGWLFWtM9D4Nj/775rUCd11ds12BCYkI/aznkcoey0+pjrVGnoTUkDiW7xScwZW
 brRmmny8Y+oz2HK1Myv24kMa5mXwAT57ogKp2pfxTPnT4fPxnQGkHxfEtLsQ4zPoJlgD
 K59JWSaiZCLKhv9cIf5B33cBOtqlktI2XwlsWyOFy6Q1Zin+wno0TyEvF8/ap1ANDWV1
 VnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249275; x=1710854075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hIrP+GOO7mqBVQBlneIZNaQyZ+Zlpvjob7t6Cp/ux0=;
 b=FXsXXjptAd2/6T+WzPebx0wQeyOYnTm7it62CNFZdcTq8q92RhiYTYWAjy7Bn5OloE
 AqM33OVtAECsyRbMTkCLgcG/qp6Ee0AoXRtjKmhOfKC6SrpZJQEB94Zie2uVGmmkZSBN
 tmeDHRupLYNBIC879DZE0SbeGVq8cTgpKJVulIJh60u27xbt7+Zwwg4Lb+etye9u0PXi
 pi78an/+9nw3SpWIU5tYh6Gl9HVSw+nYltQ4FBrkBxcP7Kx0z2WIFH5Xf7u7lNmWWv/q
 i+ZY2YobhjYq6cqdV477wOWxM5v+o60UhWTWEX0ogLfAuBSrH4h/UIVO5qfGS4KNOFNW
 TPBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL7OzVFPytPdl+iZVFpTz8KuL+3H6H1jKC362kEQfk8D38jsIFlfpe8SQpiABhQzvcoFxNnmEAbRkB4JrVFTC5PHolKp4=
X-Gm-Message-State: AOJu0Ywc6R4BS1X9z6VHc2LpBbbVsy+Cwnz3DOTDXhCXJSj75Nqio1m3
 D/VelePR15yUHBba0k2EHmpZ+dZDrGb03vvZgGTl8mGmzQ5zHiaUErT1VUPoJEQ=
X-Google-Smtp-Source: AGHT+IFHM5QqD+FFwWUSTdS0ckLdZ5o9YfQGZpazDX7iatZ5b4p9jenIQv/feUDAx46Gbaj6fFRucw==
X-Received: by 2002:a05:6a00:3a2a:b0:6e5:599a:52b7 with SMTP id
 fj42-20020a056a003a2a00b006e5599a52b7mr241282pfb.28.1710249275542; 
 Tue, 12 Mar 2024 06:14:35 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 02/10] target/ppc: POWER10 does not have transactional
 memory
Date: Tue, 12 Mar 2024 23:14:11 +1000
Message-ID: <20240312131419.2196845-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

POWER10 hardware implements a degenerate transactional memory facility
in POWER8/9 PCR compatibility modes to permit migration from older
CPUs, but POWER10 / ISA v3.1 mode does not support it so the CPU model
should not support it.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 572cbdf25f..b160926a93 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6573,11 +6573,10 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
+                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
                         PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
-                    (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
                     (1ull << MSR_EE) |
@@ -6617,7 +6616,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
-- 
2.42.0


