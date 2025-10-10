Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F482CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpu-0006hA-6S; Fri, 10 Oct 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cps-0006dn-ME
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp1-0003uT-L3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so14131765e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101563; x=1760706363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/huW5XyGSqEWizP95On9B8pHQS13+WfJtd9lPwIS+q0=;
 b=C18f0zgtxPMkQOzYwIBrqkpLZ9EHWbQdT+5ssC0k76Dhvf4r/Pa3glEIjbh4qWto5e
 lQflDSpBf66B8nidI43/8oDe7TvR5kUGRRCgtB0hzoemGEsEK/QfwT0b4qTwjTZJkHmy
 sQspQloJ/8CJ3+2KZy/2U9kW+B+iPiDg7xfKXq0mx98S3qfgmnyJ4bPFraDebhhHtNkK
 WAiAuYYtprStkoEfLwENCpOo4xmTbDJZUGRUgXjs39B6cbFyENz+i5Ye2hbUedck0m7m
 kHNmfbUN6PyXNbezWtvkKGafXJDJLp2hwO1L1CCX/IhoHILlBdpRsfsyzaQQ47Zc7X21
 pclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101563; x=1760706363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/huW5XyGSqEWizP95On9B8pHQS13+WfJtd9lPwIS+q0=;
 b=LYNN439T11cz4bYIxGs6F4w/fcUrqoN/j1fx4OwCZ9J/qK0AaKsxS+YEIfQSP4oYkI
 /m31K05bjeGtMUE8OtxH1CW/jvvsvKEmmq3VAvN0RSPAPQBrkmC7rFwEt0hiGanQdI7d
 gzNkH64yv3DjKfQphb4PiavBYprCF2+Bxu+InMhne9LggPwSy8XybA7Ii90S9ZYrTazl
 F3fRPPVtagDjHlO9cf6iK0oJLOJBT42sAGekoiqQH0KEv4CWf1p+PaeIf4FQHElF77DV
 MW2wrJOrN3vQlcwSnIKxYpG5QNesNTxhI5asern0Z8RtBOps/sJCSpZAmQihcDDGuNa0
 XuYg==
X-Gm-Message-State: AOJu0YybfFcNUA9868NQ5KobCXjmUO0WV5h9EyveIwJBzPGmlbEl7hfg
 XFPLlutm8n13cA6HD1XmQF1mlYGPHS+IDeNZMTBVBkfW0zE7zahCWEstNuHC0/aCJFRWcmfySlj
 F1wyL
X-Gm-Gg: ASbGncuH5WPBLv8dE+TZExlINL4BzwO68Q0wXiyWVun4jdPajOmFkuIjvl/+IqW9/eQ
 iHcSZdRqFHqWGx+C3Lp1E5+1CoFkW/l176FV4hre4ZAgqstDFUPMfPCbKlvgKQO1PPzo+qAyD3C
 jVvns/XM/HfaNIy74FlI21urjbhKXwC6RPQO6am/+HB4uBG6OFNXr17omtJ4eiX9XP5kpkQsHFo
 zkFTbAHL/WefxiL7L7C+SIU2BcSJorTXNF/F8gXMR3R8ASmYaK9aGZgqNqUDoKLqANGUMmveYKQ
 U2suQQYQFcBXZ64MpUcMqzjWQoP9lykcJjBfyGBWyjUlyYpsj6p0F/OxJN97TAAIMvQrmdSXXQQ
 6JkRMsD1TsMNpOXJySfsxuH20RmVTQzDxXtbqwytUujZPEHvY4WEXzX5cir55euvqYKw/vtct
X-Google-Smtp-Source: AGHT+IEUia3J4j29m6CoOlZtCF9PJfdjjrF3B/EIrY03NFrnfLzMzoPE6ukbwbWUodVj4n/wpTkrSA==
X-Received: by 2002:a5d:5d88:0:b0:3eb:dcf:bfad with SMTP id
 ffacd0b85a97d-4266e7e17c7mr6627858f8f.34.1760101563107; 
 Fri, 10 Oct 2025 06:06:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/76] target/arm: Support page protections for GCS mmu indexes
Date: Fri, 10 Oct 2025 14:04:40 +0100
Message-ID: <20251010130527.3921602-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6c52ed1ad00..d4386ede73e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1619,12 +1619,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (perm & PAGE_WXN) {
+    if (regime_is_gcs(mmu_idx)) {
+        /*
+         * Note that the one s1perms.gcs bit controls both read and write
+         * access via AccessType_GCS.  See AArch64.S1CheckPermissions.
+         */
+        perm = (perm & PAGE_GCS ? PAGE_READ | PAGE_WRITE : 0);
+    } else if (perm & PAGE_WXN) {
         perm &= ~PAGE_EXEC;
     }
 
-    /* TODO: FEAT_GCS */
-
     return perm & PAGE_RWX;
 }
 
@@ -2277,6 +2281,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              */
             prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
                                        result->f.attrs.space, out_space);
+        } else if (regime_is_gcs(mmu_idx)) {
+            /*
+             * While one must use indirect permissions to successfully
+             * use GCS instructions, AArch64.S1DirectBasePermissions
+             * faithfully supplies s1perms.gcs = 0, Just In Case.
+             */
+            prot = 0;
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
-- 
2.43.0


