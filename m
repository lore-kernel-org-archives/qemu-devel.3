Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7E9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqht-0007C5-Bl; Fri, 19 Apr 2024 12:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqem-0001HN-Cp
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqef-0001BW-4r
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:07 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34a4772d5easo1176379f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542399; x=1714147199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIcQyW6KzhNyvwt6+UmGVqg4qIIzzlR1XREhlouJbsQ=;
 b=aLuni6O2CfN0M94nZsISYxn09Oln0L6lJvO5GmzfUdl/3ZC1tTvB6FTVUEPx6UY7gq
 XCIGCmelcLCEIDcb7P7VSia5kSFVHBjPTApr0Mg+0VKRgALRUsX1CrM4tZHkXwAU/jbb
 uzSwDNpU/MzYb/QSjLugeQISkSopeEkWrfWOm47jzDESzSTksa8vad1Wy1muxT6JFzBU
 TT8SfOPSZmtaT+kT1BeDZvkziB52dmh43nNTA+m9GhSbT/w74gfJNSgvLCJQhweHK4rR
 UMxqvxZ7LmgJ/xShBAHMBu79FzuokR4bLpKQYFE8WOPmJZf/N+hrzRNKPy41gz3bqxVf
 eIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542399; x=1714147199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIcQyW6KzhNyvwt6+UmGVqg4qIIzzlR1XREhlouJbsQ=;
 b=vfDrIbnEuUeMIqran5EWu3fRoMBgF78DxBSNejk5HkkEsz1iI33RehTYeEkqwDiel0
 1+gQ3ZaH2MWkZvm/263AUkNQ6wtdmPEDE9R107Cxm78mckTQoKwEynJeYvj6HJEqSPfu
 7F3qvVXAMoatP6j2GAfs14a442oMcDcrFBMXVidb5F3hT97DPtaWG2nNhaOAroCnN+Bb
 Nk8Zz+yfv9dACOi2gcJYuecFbnpB1DVGEDIpefVkpsasew6IyJ5ynPfLX1jwVa9dISNl
 YMq1hyEt3icRDXnCiGSib9E2TMIlea67riFbN/Xj08U5AYPISAiNLbzD/CL3kFnYnh8j
 sFfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXENcc4qkg5riQ39nF6r+6bnwrmpUTqin7J6FoWFUEySR9wHaRrkiOZmnlLyzUgNpFXRyZZdT6z3LxxOVIKGaoGTVvFg/M=
X-Gm-Message-State: AOJu0YyMJuUZgdDYc5W8pHuwKZPhT5FKeaONr94IWn88h9kRHkvJMPQD
 3JMww1/8D8Qvl68aPM1Kw4yDV7gJc3QwV4axtsyg1bcMPun/AbWr3bO+aWLUq4k=
X-Google-Smtp-Source: AGHT+IGhGSM7QgbfXO8OR3slb7jRSos7wMZm9vS1hUM+S6LXvKS+/GJivhp4kH4tzFVyibQMKFVAWw==
X-Received: by 2002:a5d:4589:0:b0:34a:5663:40e with SMTP id
 p9-20020a5d4589000000b0034a5663040emr1679936wrq.9.1713542399398; 
 Fri, 19 Apr 2024 08:59:59 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:59 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 19/22] target/arm/cpu: Inform about reading confidential
 CPU registers
Date: Fri, 19 Apr 2024 16:57:07 +0100
Message-ID: <20240419155709.318866-21-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab8d007a86..18d1b88e2f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1070,6 +1070,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (cpu->kvm_rme) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.44.0


