Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9145606A332
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vJkY3bVB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0Y-0007QM-By; Mon, 09 Nov 2026 09:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ0G-0007F6-Vd
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ08-0008B8-7a
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so8123455e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233135; x=1794837935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ufvtlh2otS2NmCc+UOXX75RiNO7l/xL1MQiDIKuY8Ic=;
 b=vJkY3bVB1sP9U8Kuq1bAIgg0Rl361wm95louGmAdw6wKdgIhyk6Tcr5zaEo7E6A58k
 HIdn1aVMeAgC7zYc0wjq1FdoYkC5DKKS8prVxPtQpQX5pNrJKtvasRrZ/wf+MJTo2hfc
 QM2vuPhHR/kl/04Ud9R9UezaPLWaefsfl1JHnV6DYviUZ373gEpmL3AEBB/uRF2Dcxzb
 71ZZJIoy26cAl5qwKoVfzXbvJ9hv+8U7T7rqgTocyDvotbmupx/l+rKgg/X2pbk95XjH
 hDjlL8eiZCQcb8a1B4iROg8k7ezZyLbeAfSIM64MBhGU0lPCxXmy8YKiKNZfYDr1Jt/e
 7P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233135; x=1794837935;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ufvtlh2otS2NmCc+UOXX75RiNO7l/xL1MQiDIKuY8Ic=;
 b=VbRBFEPJ5GKkLsaGmLP6lBvn9Kuxl3B4RgH1EBLwYOVBGmLhR6Rl+P9HDWR0IvgSWe
 ts7Sxb5UUfXfSms936axU9g91EzYK4bFEwyOvTiPCDSQqVWXnZDWemH8Vob0siM+Fxu+
 gb1VAnp8sr8iPx+4e8iudtQ6OMlhAwRpllFcMYU+8EAoIrDJf/EHU+ZLUUD/JKZD1kPp
 nHanRPZSosdVpT25IQy+L+D1KirCfG8Fs9gNqWMhIvqSyDPk7Pvb+3Ps0l9gXSrggJVA
 0QtEFcx3hoiZZAmUaR+nAHoKqHYGPqXPTs+tkIL74TTRYB+IVPxMICnMm1iujfnJ1IaG
 bOJg==
X-Gm-Message-State: APuU4Z+mI0FY28tIizIXIFWjYNvcLXswFFOfnEyHFKoHWymgakg6wikE
 YmmdPJu4Fm1vUc83ogFJmFeoHGk1gry/+M5knd6tasGaa0U57HzxjsHjR9uvwa80kG/QvZCwKP1
 FVJ4SBJw=
X-Gm-Gg: AYBFou187oBjI6ZPrXQU0V4eBVQ7z9Q1ea6oXID/lABhTHaCON89a/fcUzmkbkE/bLO
 ugdzS1bb5ap4HrpC1aQovBnXrLfOVzOoEGYOhS2IRfsQ1tI5PZDcmzGHbdBPMMHEGL9BJKC1hz6
 y7+GH7uGoQFbcckl0IOoRdSNIUqprBc56m8ZoJqmdPfEB7HqT34jUV4ZMBj+/XIGbvtqwYdd21c
 m1kCft+xYOCGAlcFwFIlhlC6pldvyRZyGnF4jLAkRN2I03+kS175ADg0fqfzCnSbzNMP6VsIJxr
 GgflGumWomhmN2fcHFeCVph690wbm4iN8Q6L3J3QcoV1wen7BZKcG2Yy0Xv0GEOMyOXmVgn5NG/
 Ra9plJGRhHg7BKd1Vn2qKtiDwoz6p1/oIU0vGSoisOmkqSADyqQmI4oncEg6z0sat3SRfgAISPs
 JLzjCBqahqwqWogdJYHiuX1B86/dvFw/v4hYeP50+Hd8l8w3wimaGvS5c2hAgPiPBrhJ754J8qF
 8w5/n7gEh/kV7Y60mDcpv8yW1be0SOJ3wnsku/wd7T43IIWlCHIMCidqa0XV+vuRqRwppl67nGy
 RL5emY9OmKUcmZYIyaFmPVJETzfHUcW5QrfSJz6scX5ENCflKn5xB21n0jCiSBi2zrKV4lIkrbz
 wwcYoEUs7LXLGubykXt4JXAr+tcvn5Heliw==
X-Received: by 2002:a05:600c:8b6b:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4b960da49c6mr75786085e9.7.1794233134700; 
 Mon, 09 Nov 2026 06:05:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] target/arm: Clear the local monitor on AArch32 (v8)
 exception returns
Date: Mon,  9 Nov 2026 14:05:22 +0000
Message-ID: <20261109140523.240161-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Copeland <chris@chrisnc.net>

A/R-profile exception returns prior to Armv8 do not clear the local
exclusive monitor, but in Armv8-A/R it is cleared.

From the Arm Architecture Reference Manual for A-profile architecture
(DDI0487 M.d) §E2.10.4 "Context switch support":

    "An exception return clears the local monitor."

The same language appears in the R-profile manual (DDI111353 A.a)
§B2.11.4 "Context switch support".

We correctly clear the monitor for an A64 exception return, but
in adding v8 support we missed that the A32 exception return path
needed updating.

Cc: qemu-stable@nongnu.org
Signed-off-by: Chris Copeland <chris@chrisnc.net>
Message-id: 20261108-armv8-exception-return-clrex-v1-1-ec11079bf695@chrisnc.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: commit message tweak]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4a31ce979c6..22f47f7450a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -803,6 +803,10 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
     mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
     cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        arm_clear_exclusive(env);
+    }
+
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
      * masking depends on whether we're returning to Thumb or ARM
-- 
2.43.0


