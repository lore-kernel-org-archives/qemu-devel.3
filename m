Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6072FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxL-000554-FS; Fri, 31 Oct 2025 14:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxI-00052j-IM
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwc-0006Ic-D5
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so25671325e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935626; x=1762540426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MYEuzBXFGDsM4jW4FIPbwMx9iCFjthLPhm6pk7d7ndg=;
 b=ys/FwztWh65jpuqFDJclHmN1mctJctUtmxXvmLhLRXp/KGBJVHimbWRp5m/IyUltHm
 +10RSBpEfsI7ipxQ0PHrlJo6+1N3c4HXXqIzTvKSWFBujJt87aR/FlGMQTcWXjB1+iXy
 7grXSl1Wg4ptymwW6/9dmeYQdVbrLnv++GVr9Ju1Rq/5z3CMUgKfyiLnwkMihryLhEIo
 mfTAv9ZhxOQQgWC1fun7v4D6gwUZc4tUq4uFmraiJaeEhHwI/a2CxVfVyTBdh0mSMVu1
 bDjN/sDoFIS5mchISd6jkgGOI8qE1XSlgqgD4ZJRu64brgznI/Lr7rTN34gWI1vXjgbH
 aMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935626; x=1762540426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYEuzBXFGDsM4jW4FIPbwMx9iCFjthLPhm6pk7d7ndg=;
 b=LTWX+HtoKP7LNnbYhQdilXdQ9Dogl7EuqoLbOpzLIkNDMuppfusp3vVrfyq+lYKV5G
 JTYPdKnWiP0LcGp2wrWLH1pTjWB9CLjV0UyaNywf4JUk8ufBB4UWRycrXtHAD+mCZPhZ
 BAfWHe8dL2eNRwcLemlCjhCD7ErplFHOw3z9wfL4urVqjRxWhOO7G2LEO+ZTweBWdzO+
 eOUJrSMuiE5ylRURHpInvTV2XDn/+lJPI44Ui6DzGP6f/St2hYUfsB/uTUo+6lTfJ/HF
 WbOTf7B+FGkECJOH6/ChaTFk3qAHz43IsFrFBDtRRFpGibZrKtMTZJsIBCYqnleS+lsC
 OMxQ==
X-Gm-Message-State: AOJu0YzUh1/08luNDuWV0XeKJKu7Y2ZK7FS/lOcuQs6LJux7CSoJtGPd
 upuxpf3VTH8Cgp2qr6E/gsBz2fJ5qmfrwsaWy+maegIIbqhvlzP2kHMx7lz4CFMkFgZRFu5xKZE
 rdE0a
X-Gm-Gg: ASbGncvFRLEuT8YDxs5Fjrrpl18lCWorB04FiPcjWy9Ke4g40Bo368BFYTUAVCzwrma
 FJrNqajDfBWQx/nALIo216h0Puyr5JP17za4XFz5/vdE/0kdvW8JKDf2How1sNzEiIMpPBQ2JVY
 wOYBKpmz1l8bfVoG0ueAyZjukx1s8+1JiplEosZOcSm2dyp0+Xxn0KiTEd0XVqVIjTr1uoRyKYb
 IVJta16AD2ialEA7hp/8ofDlzVTb4t1bE9DzwsP8LaDosdLJ5Ib1VVtampOkQM2/nu7ZtrxzANc
 2zzBPzRO3+gblmNIy9m73H2whgIdP8iw1OThHXHsuJHAN5t52r3xzj92Yf72rytxfGs81NjZt3k
 yZdoV3j3mHgksBv695zEW8tikdlkJa9vQp/qqYVz+d+rWCe3s2jLJTFn1h2cu21Yh6tBd6cYtaM
 r8j+ruNQi0kzJz73vD
X-Google-Smtp-Source: AGHT+IHjIg+K0YyjVF7ja5VNf8y0oPjBnVe4c3ZXGLolUQCoSjYCOCYX2G42OYbgWDVHNRXE1jbLyg==
X-Received: by 2002:a05:600c:820e:b0:475:de12:d3b2 with SMTP id
 5b1f17b1804b1-477308a6da5mr48012425e9.36.1761935625714; 
 Fri, 31 Oct 2025 11:33:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/38] target/arm: Re-use arm_is_psci_call() in HVF
Date: Fri, 31 Oct 2025 18:33:07 +0000
Message-ID: <20251031183310.3778349-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Re-use arm_is_psci_call() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 26bafee259e..a3bb71e63b9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1934,7 +1934,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -1947,7 +1947,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_SMC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.43.0


