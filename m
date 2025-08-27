Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0704ECA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4hv-0001eD-PH; Tue, 26 Aug 2025 21:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hN-0000wR-3p
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4h9-000058-Fq
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so2236998b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257079; x=1756861879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJsmimIu7dr8vrnk5jz0WzsneJPGwlTRlLHJVKFaYTw=;
 b=Qm2txHIuIQf8apYKLwjFsVJQzO3NNkF4JxVDXPi1QA0AaxMm6e7Y5VqR0Vgn0FYC4E
 x7HmIdWMHbscvzPO/Fwf1U9n/4SNYCyw+4Ez8MiLEwTvKADda2gMcYl6Uo6txC0kjzqN
 YiAsay1kgH1eVwi5S99SjrhopRLRLhyFPg3wvRslRND6Z3XHnBqw+Ji6EEOPFlyPUAX4
 QXuyZgTe9M8vI0I9ygUmHonJtXwe7CEIbrlA0dIcaxTeEiw2IsI1YwB/SBgvcZ2becoR
 VgkvvL52ZTF2R+ot/vAb1Uh0x/qmtsiDxOsXRaCHFX6QGAfxZV4wxVzAN/66V3kDLI1Y
 q1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257079; x=1756861879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJsmimIu7dr8vrnk5jz0WzsneJPGwlTRlLHJVKFaYTw=;
 b=HF2DOY7MCUR7fEsIXw8oAkoPIqjxHVXPAClTCKLp4VUrmWZhj5bDTn6MhfCpdI680l
 adZaBCelRfkvG/SGqiIYOvumkcdVW2TPJsFwP0dN8ccNmC9Hq7c8LpEkfDog8BxPfnYI
 jDH5LC/UBQX6e1U4VA8RySFWWv8IwyloT/6ffyjO0rGFICFFMBUfuBgErW50YmDW2/eW
 dBpb/uIapo9ylMKZCJQIp+vLstUPkoRz4HYvfFDbsoqSREkkvVb0GnTY9qfZSJVpjzMR
 AAHr8TE/CoIm3qGgV2kI3Ux2hMg0RFdWWwUpI4SIEyoEEcPqxpELI5shVvws5CP3mpiE
 Svtg==
X-Gm-Message-State: AOJu0YwDcL98ye+fHSKvz4Qzx7iZuziSHnajLCXyJ/6rbWuIoJ+f5PJo
 Ndod0ZHVoSBQZO1mbARDpPESDxQfEmcjZXJtQJ9niFbDaUrtvX6ewBjY9rVV6BMPEVJMHRXXtYX
 jzgU/ePI=
X-Gm-Gg: ASbGncvq09hvmvmb/W23fc304zB7Ozo0NFl0fgAWok3fKV3rnxa8cP0zq60pBpy9ONz
 HbemHbpqiyY/IfcQxGncxFxd8ZGHvICuY9QcEhJEkjwoCJd/J100mBW7oczkY71t+0fP1dnIvqx
 zeBUVduP/W4sVSlQ0S7KwAJ0m1zgBb0Fm3+WshAHNJmHvHBdM5/ShfcU6Iwpr6NhopOXap8M+8S
 Q0SrmNMCzednK7AfeaPUZJY3BQCHJeA1Hvto3d1s0M4Ve0CY7Mo6n8es9fhMiDxNAPx2ndfRoDB
 rKQkzaT7dDvLipN5aA/DwQ9kdyKXDgyOwwXsoreE+Txh+6gH0cL56F1wCMTOnJVLrhbogWm73nK
 s+aO29S3xzjCDxQJNlA8hxu+PnQ==
X-Google-Smtp-Source: AGHT+IFpXbvERlfbH8lvKcHAfFXSL4ExLtBeFodIJh4MsP6k+QtpbALQRkDzzg5W1v7tBAq69RB3pA==
X-Received: by 2002:a05:6a21:9997:b0:243:78a:8270 with SMTP id
 adf61e73a8af0-24340e1939emr27306031637.54.1756257079164; 
 Tue, 26 Aug 2025 18:11:19 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 42/61] target/arm: Add raw_read128, raw_write128
Date: Wed, 27 Aug 2025 11:04:33 +1000
Message-ID: <20250827010453.4059782-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  5 +++++
 target/arm/helper.c | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 90f14dbb18..0d8c45b60c 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -21,6 +21,7 @@
 #ifndef TARGET_ARM_CPREGS_H
 #define TARGET_ARM_CPREGS_H
 
+#include "qemu/int128.h"
 #include "hw/registerfields.h"
 #include "exec/memop.h"
 #include "target/arm/kvm-consts.h"
@@ -1065,6 +1066,10 @@ uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri);
 /* CPWriteFn that just writes the value to ri->fieldoffset */
 void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
 
+/* Likewise for 128-bit fields. */
+Int128 raw_read128(CPUARMState *env, const ARMCPRegInfo *opaque);
+void raw_write128(CPUARMState *env, const ARMCPRegInfo *opaque, Int128 value);
+
 /*
  * CPResetFn that does nothing, for use if no reset is required even
  * if fieldoffset is non zero.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 18af67742d..7568b78c49 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -59,6 +59,8 @@ int compare_u64(const void *a, const void *b)
     (*(uint32_t *)((char *)(env) + (ri)->fieldoffset))
 #define CPREG_FIELD64(env, ri) \
     (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
+#define CPREG_FIELD128(env, ri) \
+    (*(Int128 *)((char *)(env) + (ri)->fieldoffset))
 
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
@@ -88,8 +90,23 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     }
 }
 
+Int128 raw_read128(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    assert(ri->type & ARM_CP_128BIT);
+    assert(ri->fieldoffset);
+    return CPREG_FIELD128(env, ri);
+}
+
+void raw_write128(CPUARMState *env, const ARMCPRegInfo *ri, Int128 value)
+{
+    assert(ri->type & ARM_CP_128BIT);
+    assert(ri->fieldoffset);
+    CPREG_FIELD128(env, ri) = value;
+}
+
 #undef CPREG_FIELD32
 #undef CPREG_FIELD64
+#undef CPREG_FIELD128
 
 static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-- 
2.43.0


