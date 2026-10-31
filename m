Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE7606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j44EHbUM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNAWs-000101-Bw; Sat, 31 Oct 2026 10:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNARK-0008Pt-3H
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:18 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNARD-0006Zw-7p
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:10 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso2124433eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793458325; x=1794063125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=atE/HO16RK3WcnYxutMxDJZwPnCJN9Q7nCKO2PXk8l4=;
 b=j44EHbUMzXpuj4Z2JDBmATNH/fQr/zBBN8aYf+aOsQCCJddH03yFfdSnaA9ks9JrgT
 Sw5GNdtTUjwjWvuLVXuvZrZmwTV11i87YVX4i2htSltjSfaOEu07oVougsbSYaTmSoR1
 Oz1vyoZVP4Je/bTHUDAvEgAX7qYHMHhrYUIGVKMp6put4JvZxiEV7ofdToRHpGB4A/G7
 EeFt9SL+i8yD4lsEJe/7kpiyWDNV2svrBSuSEBD2WsUP8rZPaC0pYX08OYtP0u2zodtc
 P/D1Zgi/5Fz1Zc2AyYk7sGVluWz6bSBSSR7p0US2DPzdFBTQnZk5y90HKum3kLR7YOnv
 mfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458325; x=1794063125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=atE/HO16RK3WcnYxutMxDJZwPnCJN9Q7nCKO2PXk8l4=;
 b=jATYrbmF0BOTsrY50BylmuM9Qoj5ZqZvGxHhYbF7xvAQ+5JaDjLMkqmR+TJMlMu9vv
 PQ/7PGMsdvsBkmVM0gMqYRQSww3TW7PFJfA/7sgXFfuax6qxkMsDYfFBcd5v8zh0Dsmi
 nOnj9nHSEyMyTRWKTHfyhnN0Rl2m3SwlxK7Kt0CxO7eHCk3+SwWrBsHyrIkPJ8dKbBz9
 l66aK12p9frWz8b11i0V30+x9EozKhcc3Ms3mBIcwQIPBk2By7O9tPEPrtkUU7Gllimw
 VgD+rOCBGMlUATkc4YWEyWafdXDeQdhKlVnvhdIPh9M5NYe+LyO7Qp5SNGCSBGaYfNnF
 PeRg==
X-Gm-Message-State: AFq9FYJd1aTYslO/0J7t03cHqQ6zorYMGUQZka3sq5oeTIYOIomRBOMb
 edyOFecrbB8o0i1/tB9dqfEdoHIfoMxhxtze3XxZtNA72+DzHFO4nQ5pT5GLG0Pw
X-Gm-Gg: AYBFou26lkEAOzYQvKC+9W70bB3QBheUvXRRKEh69AXw7PJV7pIMH+faEJpsCnI06f/
 EQdhzM+hFHBvdUZ65LLyN1dprqjAc3dKlV6NgYnx7CRVh4mEq2N/37GojtWaLnQh8kRDcaWWRal
 ubT/nFpANtSB80/QFwPjA2YxyEoXZ0LCPRspFVZBPss6IuexOYdGkFe1p/4bqeqtSKxP/3jlypV
 S3bzRyjv8q73RzSv5i+dUXo5tcx+tLMdm3gjbFhwLdgpUomgjK4Rrj5WWVuuW56ypxVuVTtP22R
 sh2jxckgFE+tAc3U8Vgyd8bcg3k7wK0tKz4ZkJCUcsgIQ4q73zV10cwrpD0m12x5sVXZbeZhfv9
 7ZR/7b3S6lK3XUwcTRwwR/KqtBvRqKslkSlyDnGeOV4Mxo/mmz3V3kPXxgs7TNtWLTjaVGfx9sM
 cDh1/0DoHZBr2c91PB8eBK/1RPZwyzOElOn/cDo/VwOaZPy2LPz1yV7IzHf/LhKnSt+hzaupq4n
 eVNcwozwf+qwLVpAIWcY1B56fvmpdJMxmjPg4ceWkTw3ZYg0mUMsSpcdDQpd2ubkNpcPlhD+VKU
 KokQI3Nj4fVbeCrzrycGFHxE5pYEOJuL
X-Received: by 2002:a05:7301:438e:b0:36a:3767:ede0 with SMTP id
 5a478bee46e88-36a4240176emr7447663eec.26.1793458324905; 
 Sat, 31 Oct 2026 07:52:04 -0700 (PDT)
Received: from ubuntu.lan ([2405:4802:913e:86f0:fc32:76b2:b6d6:a3f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm17541006eec.6.2026.10.31.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:52:04 -0700 (PDT)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH 4/5] hw/misc/allwinner-sid: Support configurable eFuse
 capacity up to 512 bytes
Date: Sat, 31 Oct 2026 21:51:46 +0700
Message-ID: <20261031145147.32683-5-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031145147.32683-1-dovankhai97@gmail.com>
References: <20261031145147.32683-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 Oct 2026 10:57:53 -0400
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allwinner SoCs provide different eFuse capacities: older SoCs have
16 to 256 bytes, while newer 64-bit SoCs (e.g. H618) provide up to 512
bytes of eFuse storage.

Add a "size" property (defaulting to 16 bytes for backward compatibility)
and an internal storage buffer up to 512 bytes (AW_SID_SIZE_MAX).

Signed-off-by: Khai Do <dovankhai97@gmail.com>
---
 hw/misc/allwinner-sid.c         | 8 +++++++-
 include/hw/misc/allwinner-sid.h | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index b5f827d4bd..0068b07eee 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -83,6 +83,9 @@ static void allwinner_sid_write(void *opaque, hwaddr offset,
 
             if (id <= sizeof(QemuUUID) - sizeof(s->rdkey)) {
                 s->rdkey = ldl_be_p(&s->identifier.data[id]);
+            } else if (s->size >= sizeof(s->rdkey) &&
+                       id <= s->size - sizeof(s->rdkey)) {
+                s->rdkey = ldl_be_p(&s->storage[id]);
             }
         }
         s->control &= ~REG_PRCTL_WRITE;
@@ -129,16 +132,19 @@ static void allwinner_sid_init(Object *obj)
 
 static const Property allwinner_sid_properties[] = {
     DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier),
+    DEFINE_PROP_UINT32("size", AwSidState, size, sizeof(QemuUUID)),
 };
 
 static const VMStateDescription allwinner_sid_vmstate = {
     .name = "allwinner-sid",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, AwSidState),
         VMSTATE_UINT32(rdkey, AwSidState),
         VMSTATE_UINT8_ARRAY_V(identifier.data, AwSidState, sizeof(QemuUUID), 1),
+        VMSTATE_UINT32_V(size, AwSidState, 2),
+        VMSTATE_UINT8_ARRAY_V(storage, AwSidState, AW_SID_SIZE_MAX, 2),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/allwinner-sid.h
index cfa22a4d7f..da8c235c5d 100644
--- a/include/hw/misc/allwinner-sid.h
+++ b/include/hw/misc/allwinner-sid.h
@@ -24,6 +24,9 @@
 #include "hw/core/sysbus.h"
 #include "qemu/uuid.h"
 
+/** Maximum eFuse storage size supported */
+#define AW_SID_SIZE_MAX (512)
+
 /**
  * Object model
  * @{
@@ -54,6 +57,11 @@ struct AwSidState {
     /** Stores the emulated device identifier */
     QemuUUID identifier;
 
+    /** Size of eFuse storage */
+    uint32_t size;
+
+    /** eFuse storage buffer */
+    uint8_t storage[AW_SID_SIZE_MAX];
 };
 
 #endif /* HW_MISC_ALLWINNER_SID_H */
-- 
2.43.0


