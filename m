Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1011F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Q6-0001B0-C1; Tue, 24 Mar 2026 11:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Po-0000nR-0Q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pl-0005EP-SW
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso4338698f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365088; x=1774969888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2TMW0vdUcydQ9bOK8sLS4OIxCtVe8f+/eTENHyGWuoE=;
 b=KToUZIKVsSfFUdjxEtOOnz4lI2X2NUN376viAJ7lihxxnu+2TGQLZgliBYoSEu/ee1
 A3cOwDYG2NH6Be+Jh0AYuJAwGLQ4nHKmvFxILwXUB1wO0R0fn1tZU6oI0/IRAb7rMpMP
 uL86BXlCfyboUW1SDWvW4BQPb6a+liZ/Uk6kT4oL3ghh2kOtG9iPoSKpSRA3y/wH/fF9
 y/1ZkpHAN8ZI9WbgEVEbpCpQ61WCnOrO6jmENoM7OiRF6SXxFYUVZaj2BdrYEAGvnQTU
 1VhPGtu90mBd+Lwxi5rU7OYPhUIJY0OIpsDvJQcE6DLjCllH6RD0+AkaSdcnsuNfYmHT
 wF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365088; x=1774969888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2TMW0vdUcydQ9bOK8sLS4OIxCtVe8f+/eTENHyGWuoE=;
 b=rkjxlR6WWttZ7fW67RY8DD6tGCUzoGG7I+MUjp4maZr0Rax/r7IaGOP8FMtAVhnLHj
 pRFoQdb2eYBl2uYpQ7frySeDvUpwYGGvmn630/yhGBElU9PLL3BAXWIkyzo2nQtN8iFK
 3kNjjmWIkX3uDji6/vAuPfr5mYawAnVu7MQ7eVhiSKbHTn427VJkPHVAncMgb+eMopzC
 2urPK8tOHlZsUouGrntCYJFy/LT1Z4U0Kadn0hPHeP0xLQljlCgLZOAUw5S1iIC4rvHY
 xiPfz+OD5OrD0hIC/G12uV81sdshf1Pcfrd5EaZdKl0617s0gAaKTRigydRK8gspE8VO
 KDog==
X-Gm-Message-State: AOJu0Yyxx1zSuLCejMvS644lw0yT2NcdMC5INn9P4Ho8IpiqB/9RS4GM
 5XpvV9Oz7M3REKgFZh201U3ptZNgIhk8vVbFNKmPxBSoEyDCbu8zk9pluH1LTKxfK/Snssip8En
 JCBjAli0=
X-Gm-Gg: ATEYQzxGJlggOMoW1wGtYZPRrssmI17H9xCAwOphIptF9Ncgw83D+iKSW0F27F7iYkm
 EVuMqhGpCOSvA6wQ1nmB1dlVGq80wA+hdT1XiW2KrmXpq/qlgszT/U1REMzP/XkisyviLKv1pf/
 GR+gOyR9i0Yhpn51kjRtxj/xUW+uwqr5K+JlI1y0aWGyurqop9MoRANqtqCAdFnh9BAtEhR0mo7
 zjnfz5QZMMTmTXOMgfGgN/+plkNmh9muBVRze3W8aLvNm7Mi4aPSJ50MIo1LgeniGcgM2BtHs4j
 uuFa1W2+HpyS1lSj68fwCWSK5NSJ5j9Wh6CVvLNP3fy3NpnLy3dh1X7FZZBegO0G13c5TEH071P
 qDtQTS0HsRxvz4FByAbZR64IMXkLVdOfLfJguu0qUX6EG6GYqh/ajSDfjgafNUlkuVnVtVVtIOd
 oE22CRaTtku+wKrGJxiji2QvswpPP3F7LwKz36dE+0sT0ozQUamGJ+YDzw9Zce1URCcPM0uCkVw
 M+1ZoRMKhrN3wvM0RsK11XfiJYY0Iw=
X-Received: by 2002:a05:6000:2601:b0:43b:8823:c12c with SMTP id
 ffacd0b85a97d-43b8823c371mr390959f8f.35.1774365087044; 
 Tue, 24 Mar 2026 08:11:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw/arm/smmuv3-accel: Change "oas" property type to
 OasMode
Date: Tue, 24 Mar 2026 15:11:10 +0000
Message-ID: <20260324151111.237411-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nathan Chen <nathanc@nvidia.com>

Change accel SMMUv3 OAS property from uint8_t to OasMode. The
'auto' value is not implemented, as this commit is meant to
set the property to the correct type and avoid breaking JSON/QMP
when the auto mode is introduced. A future patch will implement
resolution of 'auto' value to match the host SMMUv3 OAS value.

The conversion of the "oas" property type to OnOffAuto is an
incompatible change for JSON/QMP when a uint8_t value is expected for
"oas", but this property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-8-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c          |  2 +-
 hw/arm/smmuv3.c                | 17 +++++++++--------
 include/hw/arm/smmuv3-common.h |  2 --
 include/hw/arm/smmuv3.h        |  2 +-
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bc6cbfebc2..65c2f44880 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
-    if (s->oas == SMMU_OAS_48BIT) {
+    if (s->oas == OAS_MODE_48) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 79018f8d66..7fead1c3cf 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1984,6 +1984,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
     }
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
+        error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
+                   "OAS; other OasMode values are not supported");
+        return false;
+    }
 
     if (!s->accel) {
         if (s->ril == ON_OFF_AUTO_OFF) {
@@ -1994,7 +1999,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
-        if (s->oas != SMMU_OAS_44BIT) {
+        if (s->oas > OAS_MODE_44) {
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
@@ -2012,11 +2017,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
-        error_setg(errp, "OAS can only be set to 44 or 48 bits");
-        return false;
-    }
-
     return true;
 }
 
@@ -2143,7 +2143,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_0),
 };
@@ -2180,7 +2180,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "supported.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits");
+        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
+        "supported.");
     object_class_property_set_description(klass, "ssidsize",
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 7f0f992dfd..4609975edf 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -342,8 +342,6 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_OAS_44BIT 44
-#define SMMU_OAS_48BIT 48
 #define SMMU_IDR5_OAS_44 4
 #define SMMU_IDR5_OAS_48 5
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index ddf472493d..82f18eb090 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,7 +72,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     OnOffAuto ril;
     OnOffAuto ats;
-    uint8_t oas;
+    OasMode oas;
     SsidSizeMode ssidsize;
 };
 
-- 
2.43.0


