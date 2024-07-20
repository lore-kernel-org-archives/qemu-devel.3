Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E703BC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6RQ-0001a4-CL; Sat, 20 Jul 2024 05:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6RI-0001Kc-CE
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6RD-00072z-SU
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so1115387b3a.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467894; x=1722072694;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wrhfxyQiCKIug187Kcca0q3LwAZ1kZXZGPDwQT1UwgA=;
 b=qFei2RyODpW5R6Q+cJb9Mk7qm3bhdTjgpjnRjl1fF9VpP6tLORjyAJyWFnGNCRsFBL
 SssK9+HHQ+ZX8gnBw9/2lp17hFVFG7wOUWy0KmsK10HZJUPAni1liZHA8lzeDeIDULJT
 79O4VkNOBJEIZmTL/IM2KpNYGh5qqSJjgvgX3m0MYSnkFH6llttlmpZTJjmg6yV8u0eG
 YAbNCVe/VN2cbbjvp4mIxV6ixOwQNbGX2LrtLjncvAjsuG5wtkG3iM7rLMB02DSi7pFQ
 niWOBsA3V47oQLFkN4LSWv+umMQHzttcLEeuX/xbAijMZF7fLkwzKrj3xse2dQI3zt2i
 iSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467894; x=1722072694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrhfxyQiCKIug187Kcca0q3LwAZ1kZXZGPDwQT1UwgA=;
 b=Rkorn8KgPS07MAljJAu4m80t2WOOZURvRrUv4ajry60QUUdqpsMVUwcypNQHSllhYq
 acPZuXCDtzR0Z850q+wfNYJYax7vRtu2phnzMIVQC7M0w7nL6v+6hKWJjl6EultdHcxW
 9nVlI6KbB8SSgjKoKHT1wPF28tFBm/CJC1kmYsfuvAR+XoV4OZF5WlKj2gdBwJDsl4r3
 ZJAEBxcpufvwqJSq/76UK6hYi042LF+r8USerZl5nuO0UV9lyj2huDsMriWdBD5K6D2q
 hCKkTcOfWh6b0WOXWbIGA5o2moov9II5A3vTAkHyqxPQIvCIBNdsa9V622/zuieJD4iG
 a2OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV4o2Kd5fAeD+Z36cF8fqjYe3v1vUKwiN3pMZ8uX19mqf8Q7L2kU+TEI/whPJ+2hUG/at5HqQLJU3OsPthOoQJ4xyvCZY=
X-Gm-Message-State: AOJu0YxnlmE+T/Hakb/SiFLixSNnryMGWKMnjDyeWT/+/1eoLldu8aTp
 EiSuDtsrPeYAAj0+nB3SLeLiAhlDmmNaastZx3o2MS2RSRiM/Fg6ui/HVvsU8qEvlWIRVnc+4jC
 QU30=
X-Google-Smtp-Source: AGHT+IEXOqSyEy2UA66P9jRHggHMp/WMJoRJ7yRzlzsXWfBfVUa9ITQgOCdoVMCmOnpVU5hdmZPN4A==
X-Received: by 2002:a05:6a00:1887:b0:70a:fa5d:ad97 with SMTP id
 d2e1a72fcca58-70d0ef82323mr719873b3a.1.1721467894392; 
 Sat, 20 Jul 2024 02:31:34 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70cff552c39sm2341661b3a.136.2024.07.20.02.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 20 Jul 2024 18:30:54 +0900
Subject: [PATCH v4 6/6] hvf: arm: Do not advance PC when raising an exception
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-pmu-v4-6-2a2b28f6b08f@daynix.com>
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

This is identical with commit 30a1690f2402 ("hvf: arm: Do not advance
PC when raising an exception") but for writes instead of reads.

Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index adcdfae0b17f..c1496ad5be9b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1586,10 +1586,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (!hvf_sysreg_write_cp(cpu, reg, val)) {
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+        if (hvf_sysreg_write_cp(cpu, reg, val)) {
+            return 0;
         }
-        return 0;
+        break;
     case SYSREG_MDSCR_EL1:
         env->cp15.mdscr_el1 = val;
         return 0;

-- 
2.45.2


