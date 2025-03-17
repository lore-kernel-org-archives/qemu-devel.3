Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A4C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSM-0000le-Lc; Mon, 17 Mar 2025 10:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS8-0000Zl-PA
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS3-000183-V5
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso15637945e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221702; x=1742826502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WnEm4y4Gb1gILlyNJ1p6kywDDvqp6Y8gIMTA4arfee4=;
 b=dYyt+Q9Z+KjmsvzUO/yn9zAV8xrPZdBm3S8gHuDWO6tJwJ1zCRRpg5H0P5eE/vOaY/
 S8X9Yan0NQY9O7zgiYtFPydqPYY5UNmdgtoDkupBMMSy3/j0L+LLB7cF/T1X3UnnO+LC
 i4tqLYpUDN8wTYVqIxwy8KG9lyWc+DFFxjYOAGiL//LhZKnC6dchQWFx+4/sg69i/eh0
 3Pm9iMktMUQxo6RaUuVc2IL/eQOesq7HjUq2BFwMSQCIddxTUXyEu8j3XzaQ72loty/T
 GqDCpyku2fOztZLOm9yuZy2qxtAQObxbXOEeCArQakHjo+1T05tuJE9RQqsJXPzDZAGT
 o2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221702; x=1742826502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnEm4y4Gb1gILlyNJ1p6kywDDvqp6Y8gIMTA4arfee4=;
 b=V/MvV0UfIeuzMpL9ejHlfz19JBpjOqdgbelIXE8+c/ZcR9C6iq84VETcyuM31vLawt
 wGMTScj3RQ+FcIq4JRhQujWg5gCHdcBJnexuvdcstuDXOMSOokCdKhlCTERroLjEIO/r
 yfOQdWGd45yrnrjy+IHSrqfKPzFUxtvmlZQXSTmqcbGEKm6MfIplF0sWn54WMQx0Vmt4
 mKKJNVSoet19KEzEDNjI2ylZT2JvoGkeuaC0UKwINoCa2XP1RbuNRIVydUVYt7xyeM8+
 dbxC14tBcdIF29IbUEl6VICS8Rb/3YY+eK2lZdJjGmAmtAkVdPGxgCzLRVMY9qTQRyqj
 XlHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7p+PP3mVLksHHjI9CSBbozLlMlGhpkD23yef6ecr5sqY8VvXNAoSY9DmgcaADaER6wefEiQ3jxcQF@nongnu.org
X-Gm-Message-State: AOJu0YwIokvZz6TS756zYXchZ1+qCUQcAG9suiNDPzUWspfv4rh1RlXg
 cvk8cg3EPpAiL+ytc03ofGpQActu9qxpE1a9qIoGzwtTfBdOj6ZF3TT8Q6t9jaxM4fbq0Mj/fAo
 b
X-Gm-Gg: ASbGncuttxPWy9t02+rsmDocRvkOeXJdMlVgA6f2h2dGC54OIlbfQEVVB7jH9J1/psp
 l53AGeH91/a2CiXnXlS2/XV4gc7AA50fkUP9oseDMDZ4k8JMpAB3pfJny5sKBif6f6iI3yaQm7h
 qNr0ofGseeUyIIcASSyBew3FPdySo/ob/ZsAeCzDfPQqDSSTzRJ5HtqQAO5suQueHtHgtWaPx48
 kd8n7ycnMWIPeqCboUlwBTiOTlwPWaKgFLsPBPcUm6Ef4AZWMD2JbAKXa9EhWAAX3XYsTJyVe2U
 psDEb/P7EALMIOE8VBLERXI84P0DbVwf/I7IwbK6wH6qeqrbyjw=
X-Google-Smtp-Source: AGHT+IFCuNubSvporwNQeOrEKbXRcIAl2JhiKpVerUwCSFLHM7VcelS2McAOBblwWQtBME9Dr7RZvQ==
X-Received: by 2002:a05:600c:338a:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-43d2021a1bdmr96258065e9.27.1742221702200; 
 Mon, 17 Mar 2025 07:28:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 1/9] core/cpu.h: gdb_arch_name string should not be
 freed
Date: Mon, 17 Mar 2025 14:28:11 +0000
Message-ID: <20250317142819.900029-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The documentation for the CPUClass::gdb_arch_name method claims that
the returned string should be freed with g_free().  This is not
correct: in commit a650683871ba728 we changed this method to
instead return a simple constant string, but forgot to update
the documentation.

Make the documentation match the new semantics.

Fixes: a650683871ba728 ("hw/core/cpu: Return static value with gdb_arch_name()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..5873ee5998f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -135,7 +135,8 @@ struct SysemuCPUOps;
  * @gdb_stop_before_watchpoint: Indicates whether GDB expects the CPU to stop
  *           before the insn which triggers a watchpoint rather than after it.
  * @gdb_arch_name: Optional callback that returns the architecture name known
- * to GDB. The caller must free the returned string with g_free.
+ * to GDB. The returned value is expected to be a simple constant string:
+ * the caller will not g_free() it.
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
-- 
2.43.0


