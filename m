Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C007DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1yF-00009Q-5X; Tue, 12 Mar 2024 09:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1yB-00006Y-R0; Tue, 12 Mar 2024 09:15:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1y9-0006s8-T8; Tue, 12 Mar 2024 09:15:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6adf257fdso274603b3a.0; 
 Tue, 12 Mar 2024 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249299; x=1710854099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmKs3OLijRDjxbbgFJRC36Pyehi0EZh4ofDu2FesM1g=;
 b=X4Gr+ct06Dj9A/CysySkc18RGNB/vperkCuV/GaJJ0/YqfQ0ZwcugrLTZIW8215jg2
 20f0bTwDWGg0gGvgzi+MZQaqjeddpa3a0BOwTRACYRFhArIn7XIuSNf8JqKYkD2iHsTV
 NTBNtCLq+Z2cwmfye06TJGBJxjgrwPtYCJA+QpVuzNarALTLGLi9bkwyPOlhlhoC0jHB
 SDT1LYmjOLgwLnZ/7bWgkTChXC4Tbipl2+bWCdpL3eQtO+OpBw3aId4CmVOuql8sHmke
 nLsa8yBnQ0Ku3FpxliyvdjG9hFebliRYaXFmnTmp7VLq2L40QDr5jRCRpwf0P6tTWfSf
 mtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249299; x=1710854099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmKs3OLijRDjxbbgFJRC36Pyehi0EZh4ofDu2FesM1g=;
 b=Z32Puk8ta2RI87tEPn/y91VelFTuO0oYgSXZVrBVpSEX4otxaHfqgogQun8M15OtpH
 IS8+NCdMl2o1tupGCAQ4JokrJPWYjwBGBP16uSPnCTI5jyj/msgEMh+ZWnJEEu1oZvck
 ZL8LUC8okcMItNurKFWKE1ujJrcQSnRWy0fT1YxBwtl2PMM4FCV/U9v2NzHXm3SYeoar
 uahVLwMgQ/udU9VHyZFB5J7QrUWC0VxXCCZQHPZ2B3wMzHkw8KyW3Su8zzsaqD+G+ES4
 moXQfu4XyK6tzZYEHHiSDBAFSQZfiglVaslMFZ6+L0XluK1K3Gv5QHWFEGgz6cWRudi4
 S9pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwAnN4NkkkmlHX4ik9OTDtT9XLqXeI17YMeDFKZyBJSMqbnsNUT+Kbc3zhStZWhJen8dgn12Sy1KthIWTNeumknYMb/5o=
X-Gm-Message-State: AOJu0YzIb46PDH3gYYVC53lRYD1qpjjvMl4d+UJSPyqHEK4o9sf5RSyK
 7tmBfjnLtI19c4CjmLZ+F2o8bxhrHsvdwY44phYDaGlj+T1BlDYqtW4C6qAOoOs=
X-Google-Smtp-Source: AGHT+IGepATqylhpSSA/FQralTzzYOSVeR7wkdSwliSdSrAbd2oSsLJ6jN4vBvpX+qo/7zVozqzp5g==
X-Received: by 2002:a05:6a00:2e9e:b0:6e6:6bef:c53c with SMTP id
 fd30-20020a056a002e9e00b006e66befc53cmr12045515pfb.0.1710249299023; 
 Tue, 12 Mar 2024 06:14:59 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 09/10] target/ppc: Prevent supervisor from modifying MSR[ME]
Date: Tue, 12 Mar 2024 23:14:18 +1000
Message-ID: <20240312131419.2196845-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

Prevent guest state modifying the MSR[ME] bit. Per ISA:

  An attempt to modify MSR[ME] in privileged but non-hypervisor state
  is ignored (i.e., the bit is not changed).

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 410b39c231..25258986e3 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -264,6 +264,11 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
         value &= ~MSR_HVB;
         value |= env->msr & MSR_HVB;
     }
+    /* Attempt to modify MSR[ME] in guest state is ignored */
+    if (is_book3s_arch2x(env) && !(env->msr & MSR_HVB)) {
+        value &= ~(1 << MSR_ME);
+        value |= env->msr & (1 << MSR_ME);
+    }
     if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
         cpu_interrupt_exittb(cs);
     }
-- 
2.42.0


