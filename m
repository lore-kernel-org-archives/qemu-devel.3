Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BEBC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMc-0004ZZ-Rk; Mon, 25 Mar 2024 06:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wE4BZggKCpkLFHLM3839HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--smostafa.bounces.google.com>)
 id 1rohMa-0004Xk-W6
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:33 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wE4BZggKCpkLFHLM3839HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--smostafa.bounces.google.com>)
 id 1rohMX-0004j1-Kd
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:32 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dbf618042daso6579573276.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361728; x=1711966528; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PIQyD7fWOKdqPHHegPpRK4rKc0e9PSQxmCaN+UfpwQ4=;
 b=YiKDHHR27Ts/QTXAbauExWJYru2GsbrYDPhHk13b1aH5LrXdmFk3ENWgvVdGPY8I0c
 nKf8RYNJmIuFcgVp2N1N4mZOEvQG4bSIsYuAk7csA+fyexSaql4r89/j9HVAHHA5V5vu
 Iu+Wz5gwzdniMy3x2MuLURFA7zgZ2+QfU5QS/Lsxn2nXT6We2bDcaLC8dNf3aYMry3Oc
 PfSvOrb08bVY4Av+3QhoKfk4PSDAqheAb5GFy5N/atyjpbGlgBjkJpGW/J+y03+4SkWa
 ToubZat9o54EGdrGugssdQy+cofmozjF5zZRJA2XVuByerxUaI7C0g4CLmchYudLjmIY
 9yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361728; x=1711966528;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PIQyD7fWOKdqPHHegPpRK4rKc0e9PSQxmCaN+UfpwQ4=;
 b=QKbf47tLE5vAGFlLx76v6F8ng3GKj3GUIjVH3CbLmX/xDfHSwglNw722NgMUqH0Fsi
 FTXGHxY6dPR3urFmrozkMSieFGdKRP48afckebH962Jtz21iinpu7FFwprKlwMy/7Ii+
 3U6IF/XxHD0hXSMYXXm/5z3cvyw08y5t1aoogEX0+FtNGkyWQt7AWcRZTdhsXEwsgGcB
 7G7UprIs36CXXJ4IhZMjJg8Nf2HX+828Saq3V+zlZnRUGS4OFswiFU7w7U59+JZHUFJC
 yVdaujK4/NkIdcg/yEd1pKSEkOd7QM3PBlRHoE5OxwjQkZhZ4zU9BVdJptOh84NV5FCN
 fEjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR++jrV6VcGakEl2E+7fU70dOJKu6A7sfiFlSGL2CFFBpNydtU8HPNpb2mVl2QLIIb+KYpNqZR/SAvr1ssOhgegh4yO18=
X-Gm-Message-State: AOJu0YxiTDO9Xo8yAxCivHq5WUPkT6ZmtmbbrCmU0XzuiYAqApFaYRTs
 OtiFQ/qe3TIsRewXGx6JChqisygkr1Ir0TRW3dawwKnXFakv5rkNbUTPYiepSqDseTSX6KchxoE
 4JHMxsHC3UQ==
X-Google-Smtp-Source: AGHT+IF/8jxqEryQ332F3IpGb3mlrotrn5WHTTl485//bAS4u0Rj9DpbMmYxICx9IowU22tYToi1vssVuX59MA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1207:b0:dcd:3a37:65 with SMTP id
 s7-20020a056902120700b00dcd3a370065mr237591ybu.7.1711361728495; Mon, 25 Mar
 2024 03:15:28 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:07 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-12-smostafa@google.com>
Subject: [RFC PATCH 11/12] hw/arm/smmuv3: Add property for OAS
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3wE4BZggKCpkLFHLM3839HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add property that sets the OAS of the SMMU, this in not used in this
patch.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h |  2 +-
 hw/arm/smmuv3.c          | 27 ++++++++++++++++++++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a7d53b3854..9bb4ec9ec6 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -105,7 +105,7 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_IDR5_OAS_DEF 4
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2a29e3bccb..9d0db25379 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, s->oas);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1869,11 +1869,34 @@ static const VMStateDescription vmstate_gbpa = {
     }
 };
 
+static const VMStateDescription vmstate_oas = {
+    .name = "smmuv3/oas",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(oas, SMMUv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int smmuv3_preload(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    /*
+     * In case it wasn't migrated, use the value used
+     * by older QEMU.
+     */
+    s->oas = SMMU_IDR5_OAS_DEF;
+    return 0;
+}
+
 static const VMStateDescription vmstate_smmuv3 = {
     .name = "smmuv3",
     .version_id = 1,
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
+    .pre_load = smmuv3_preload,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(features, SMMUv3State),
         VMSTATE_UINT8(sid_size, SMMUv3State),
@@ -1901,6 +1924,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_oas,
         NULL
     }
 };
@@ -1913,6 +1937,7 @@ static Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_INT32("oas", SMMUv3State, oas, SMMU_IDR5_OAS_DEF),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..00a9eb4467 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    int32_t oas;
 };
 
 typedef enum {
-- 
2.44.0.396.g6e790dbe36-goog


