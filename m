Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4551FC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThe6-00039H-Dp; Tue, 16 Jul 2024 08:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThe4-00036p-DQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:51:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThe2-0004vz-Ak
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:51:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb457b53c8so44813145ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721134260; x=1721739060;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OjSJhOxndUTwoLpjqK0yxNqbOlPYxQqUKSKd9L15YsQ=;
 b=oYWGXCHQ6zkEOZJBd51NcS369+pgn1v0HK3zuyu2wIBtfFITVeraZ2Si4DPD/UO+aA
 0DxDIyXE3bSyl8qS2po2OueJofOsgCVnrZzmmQURHwiSIarzwL+fK3QtKhAx0eJEMICE
 kMny+7PRT827Pw0OBqpaVq3QZSndsX8u4koxSGS1B46UmnjcPfOxZFhjcTL12Clj1h9p
 lmISQ17UUPAkhaKLJd+BLN9yeJrM4rpeGGSgniR1JfiG+grFn0bKukPplQzG63slhnVO
 CvIlMWe3u69yS6+zyd/zAPzOVxLAjfpUSHAQbHSfUNhl85/wTFy+RDqcZLER3HgnQdBB
 DYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134260; x=1721739060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjSJhOxndUTwoLpjqK0yxNqbOlPYxQqUKSKd9L15YsQ=;
 b=O7iKXZQ3gaJOVIEVYJlnczmlABNx56dR+O9i75fF0Rq3xFl3MyKBP9/32PGyKawI/s
 B2YSbHd2xnmsd9/OEIcpsA23/i8LDHFnwWwuRxljFv+fiVTJ4tjCy1HV2pVN3A37V5Ly
 kcNrchDjs83UrX4wunfsYK1jjQ0EM28KesY3kPGwyewNPWdb4HHx6RcmwmYyrcpNGEst
 HNEMz/M+/SzYJzw2QAqrbH10umQzOeS7MiB4uT8vfAenxEuyOIXexbpSavrfPpAV1UyV
 dcE3eCvc4UQM/+Lf+jwEYx8kkdqHXrF68xUseeQCXBxirFdQB/CIC3JLT5/Kl4nQBUfK
 R++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUh0gf/wlOMqSDXJy03OBa+RW4ctkNAnxHtcszg4bnG7N6Ue5JLtqMu16Ke9sHYfPHRK7xjXfdkTZQz0DUsUY9T1bDq7c=
X-Gm-Message-State: AOJu0YwA2rxDEgR4+bPlXqGMcSkntaN60swLjOUrIVDQFXydAoZi/LcL
 zpKgXUkyAa34iJr5qCDaM68XYMv4uTnmaU2HYExmYeuGo7EtYSBo3fViTtUaUIV9LaTMCp+/QBo
 4
X-Google-Smtp-Source: AGHT+IGgcKegqUs568FNJ+2uzBaWczfapraF6MVhNCtN2VRAYUITEj5Hc21cmEbXS/e5G1SoNrN+kA==
X-Received: by 2002:a17:902:d2ce:b0:1fb:67f4:1b72 with SMTP id
 d9443c01a7336-1fc3d9c526fmr13149915ad.54.1721134259665; 
 Tue, 16 Jul 2024 05:50:59 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc273b3sm57465755ad.130.2024.07.16.05.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:50:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 21:50:33 +0900
Subject: [PATCH v3 4/5] hvf: arm: Do not advance PC when raising an exception
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v3-4-8c7c1858a227@daynix.com>
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

hvf did not advance PC when raising an exception for most unhandled
system registers, but it mistakenly advanced PC when raising an
exception for GICv3 registers.

Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef9bc42738d0..eb090e67a2f8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1278,6 +1278,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (!hvf_sysreg_read_cp(cpu, reg, &val)) {
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            return 1;
         }
         break;
     case SYSREG_DBGBVR0_EL1:

-- 
2.45.2


