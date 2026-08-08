Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11461C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 07:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsbMb-0000EL-Bk; Sat, 08 Aug 2026 03:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ming.jvle@gmail.com>)
 id 1wsbMZ-0000E8-KU
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 03:20:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ming.jvle@gmail.com>)
 id 1wsbMY-0003bt-6L
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 03:20:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso3707415ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786173657; x=1786778457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bz6b9wfdqJsVA7aaaHrxQVnkDF5Q8fa9BxIBT89Xjc4=;
 b=OaWAjlm1+Gw/hYLlZwj/D0U5EXvvOq3CmJGBoQTbQM6yinOsvtXd1Wx4DobxFbyqmT
 qNUB5xi4hrRSW4cOKM4NSRqiK3LZ3dX8OXHMhMDg8d+27MgohuRZ8bKljTBuW50ZZ9cS
 vdCRKoI9r3L+Z1cy4pSKZ6apS0w9iG/iAd3of5MzWlnOwLIeT8W3TOEebVkVGFPg/7HE
 bLfEzby28oVaw1Pw0tfqX1FR3KToUqUZvk8CFmvJx7bxe0Xmc5hgNuFPgHC4d12ui16d
 SKoYySMqr0A+j1MLUPvWvyqzH5lIOZpfbVXECjBjZY/B+fkq3Q8d+BXHkpRebtMMtaXD
 1Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786173657; x=1786778457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bz6b9wfdqJsVA7aaaHrxQVnkDF5Q8fa9BxIBT89Xjc4=;
 b=fM7/nucFt0eafw+KaAlTOQduHM1S7WX7Ma77qYfm6Yw6PS4WZbrC6LXeq3MJPToOS/
 gTjRXzBfx/aDHl21uClcUM4iNM31ej3RKVEWRDZtmode35LHWcMzclpAUCzO44ue+6UB
 XfObEieepyXQ6fbMoevcsSFvR9i9jipu0SWGgB3zVR0YKucCeGTXmgiF5wtmDl6odgTU
 dvuzrHFNALIk9dAMl1RzGO8o0R/7MVtM/OawQ71Q41HrjS6s3RoS4wxH/hCu1Vv96sFC
 5i9gWS08DJyzOCwmdLRU+a9/4PV6ofxhZ/a8b3ntkq/pgEdNvAdsoDULinkPJOGDpJrH
 dL2Q==
X-Gm-Message-State: AOJu0YzvPsB+z604D/PTQgHiGz1i7cjnVhh4GBe+2lWPocfpgXymsv8e
 +5bM4MMrN4BnPEEWRqTnplTR2iD53PjVO5rXxIdOsbfUZBiCCpNgfMud
X-Gm-Gg: AR+sD12YnwOXrY2kBtBM4bFcBcnVgZ0uWmJGiQdl9ecUVII5Sd+QSvAUdRH6878Ewow
 c0+NWi/WoYtxA7YciE415HId02Ww8MElWl6Np689I/4dmjIjBgwNJhE3eHiu7ROzBOXrdyoirYw
 MHetYcWlU36ALZK5BOs86mKpnqBRRU3K61m0Ec5HcVarz6Pjn4n/pCm9v8MwNq/T/nHBYC9E9/i
 wuBnQEPoDIwAJGm1Os0svZ9jNKqIrVRuOPhh+uMzk1EyUBhSKOlhy4nrFpej/BWAd9/bbqi33Nf
 ImJ/HGgtwZJ8xwk9SdUurqdv/BRAN4Jd2tpf0S159jDBuauWSdkJ3sM5xxy77r525R9to3OclsG
 aBs3riMoC8O+GBjukVxTtGKTtVu0U3aFcai5+p6Hk/BFgk5UpE8ZUcO0fMHnJf6aWw4+FkQvAnJ
 gCx7EJiju5/lpjAp3KRgwp6GF6Wobqa7ZPhiNWa6hP/ZEGgUKS5dswjji205OLwczkJnltICbbU
 yfy8VJTQL/gSrBz5jO6ZGprbvI=
X-Received: by 2002:a17:903:46c6:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2d0ca713b0dmr338893645ad.6.1786173656525; 
 Sat, 08 Aug 2026 00:20:56 -0700 (PDT)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([117.172.228.148])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14dbedec6sm16330195ad.44.2026.08.08.00.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 00:20:56 -0700 (PDT)
From: Keke Ming <ming.jvle@gmail.com>
To: pbonzini@redhat.com,
	richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH] target/i386: allow RDMSR of MSR_TSC_AUX outside TARGET_X86_64
Date: Sat,  8 Aug 2026 15:20:46 +0800
Message-ID: <20260808072046.229644-1-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ming.jvle@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

WRMSR already accepts MSR_TSC_AUX outside TARGET_X86_64 and stores
the value in env->tsc_aux. RDMSR only returns env->tsc_aux inside
the TARGET_X86_64 block, which makes the TCG i386 target unable to
read back a value it can write.

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
---
 target/i386/tcg/system/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 2998b1aae7..eb06f032af 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -387,10 +387,10 @@ void helper_rdmsr(CPUX86State *env)
     case MSR_KERNELGSBASE:
         val = env->kernelgsbase;
         break;
+#endif
     case MSR_TSC_AUX:
         val = env->tsc_aux;
         break;
-#endif
     case MSR_SMI_COUNT:
         val = env->msr_smi_count;
         break;
-- 
2.43.0


