Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19256C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdE-0000IX-GJ; Sun, 28 Apr 2024 23:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39hIvZggKChE9359Arwrx55x2v.t537v3B-uvCv2454x4B.58x@flex--smostafa.bounces.google.com>)
 id 1s1HdC-0000Hx-KZ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:42 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39hIvZggKChE9359Arwrx55x2v.t537v3B-uvCv2454x4B.58x@flex--smostafa.bounces.google.com>)
 id 1s1HdB-0003wb-0Z
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:42 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-34a49f5a6baso3652695f8f.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361079; x=1714965879; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+2FrCp08msyUMlnVBTobpSr4lQVeOTHH3GZjzw6DLxA=;
 b=ZO0+Oo581CeD/USj4/fKMJU6/6wQuOgXa+hHsGqQnYH3z7QBD7LN69BQN+ivNqxrrW
 ovmzJwn+yqhlKTbhDhfoi+74+9yeCVnSSr24AUNS3OTzkASDU7IQnGGez9zf+7xyznHr
 6XD1nlsYdq1d+5bXcgfWQthOW/+QudM/mWROS0R+QBsc8VeoY+Vty3fz58Gw4PfPPj4E
 fS6eDm5F9joO6+SIfT+j6NP0Q+udk5S6rU+VdPIjKxGBPIiiLrKDYbfMb7AN8risN8i5
 DJM63NU9w3uyImOfNYcMXnTph/CExowBSmWRoQU8Q354W5VJNvwYjKnqUAOA9S0CKKYt
 5IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361079; x=1714965879;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2FrCp08msyUMlnVBTobpSr4lQVeOTHH3GZjzw6DLxA=;
 b=i0iAq8yTaNqknoZY8yzLDyuJ9uaWWKhhEHb2MjwiMGsc2LX0yRCcpTfFhKsyg6Ng33
 7GD4OyXYOmg1m/nVM2N3Tbb++EW1PW3q21aJqkPdHphyVKWza0TeA0BHdpr0RKBlP7UU
 uBahQ0nfLb9eupA0sCIPkqnuCrsb1Gf9IB0hrI62mUeAh5GAnnRAPliCI3+Be1hP/hpo
 CDaguM589W7kbxK45UUcMSblUV6lCAgXfk214dixxvZypEJlULbIlx+f/zkrLqKWdEoO
 9M7np+D1DOCPDWi0cqHCYPEb8FRR3hF5zqzj43NpWdxUQxuvE/fPTskDn9ZQ2Nxa9kKM
 zgQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgjm6WuFScq6rgdYKOtxc87dQNVEvqm85d5lTVGNt6fUNAg6EiwLn8t3lWDrwgx2QI83KIUXseNrbIeiZ0ZbQ2oL1zhUY=
X-Gm-Message-State: AOJu0YwD52BqW2GikfGdmrTRbyZybCTW9Eu46U2eEthGBRWm0keXnlae
 7vJqNGWrO5KR3XY48OSUZMWg/BEpufVgVdEVkA67thNW6KjFd1OsU7SInqpNJxryzQo5SwCDxsk
 M6ei3S9Fbaw==
X-Google-Smtp-Source: AGHT+IGoL+lY5+giB5jeMhcbGdrDzJJTUxK+poXpGh4Swf5KRYTGZ6bsPJ4nrEnSfh1GNr4mesXuoscCIcArTw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:3b97:b0:41a:2857:fcb5 with SMTP
 id n23-20020a05600c3b9700b0041a2857fcb5mr32887wms.5.1714361078951; Sun, 28
 Apr 2024 20:24:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:47 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-4-smostafa@google.com>
Subject: [RFC PATCH v3 03/18] hw/arm/smmuv3: Fix encoding of CLASS in events
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=39hIvZggKChE9359Arwrx55x2v.t537v3B-uvCv2454x4B.58x@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
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

The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
class of events faults as:

CLASS: The class of the operation that caused the fault:
- 0b00: CD, CD fetch.
- 0b01: TTD, Stage 1 translation table fetch.
- 0b10: IN, Input address

However, this value was not set and left as 0 which means CD and not
IN (0b10).
While at it, add an enum for class as it would be used for nesting.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h | 6 ++++++
 hw/arm/smmuv3.c          | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e4dd11e1e6..0f3ecec804 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -32,6 +32,12 @@ typedef enum SMMUTranslationStatus {
     SMMU_TRANS_SUCCESS,
 } SMMUTranslationStatus;
 
+typedef enum SMMUTranslationClass {
+    SMMU_CLASS_CD,
+    SMMU_CLASS_TT,
+    SMMU_CLASS_IN,
+} SMMUTranslationClass;
+
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9dd3ea48e4..1eb5b160d2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -942,7 +942,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             event.type = SMMU_EVT_F_WALK_EABT;
             event.u.f_walk_eabt.addr = addr;
             event.u.f_walk_eabt.rnw = flag & 0x1;
-            event.u.f_walk_eabt.class = 0x1;
+            event.u.f_walk_eabt.class = SMMU_CLASS_TT;
             event.u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
@@ -950,6 +950,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr = addr;
                 event.u.f_translation.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_translation.rnw = flag & 0x1;
             }
             break;
@@ -958,6 +959,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr = addr;
                 event.u.f_addr_size.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_addr_size.rnw = flag & 0x1;
             }
             break;
@@ -966,6 +968,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr = addr;
                 event.u.f_access.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_access.rnw = flag & 0x1;
             }
             break;
@@ -974,6 +977,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
                 event.u.f_permission.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_permission.rnw = flag & 0x1;
             }
             break;
-- 
2.44.0.769.g3c40516874-goog


