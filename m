Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A0EF54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pk-0000lJ-MK; Tue, 24 Mar 2026 11:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Ph-0000hv-P3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pf-0005DI-FK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so5025473f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365082; x=1774969882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E6ZwApvfGFbQl/yLyHCasjz6LaGeymRacGWTzWNB6N4=;
 b=zvbyXcbQMbRKFCgrpFsXFw7+cqc2SBfkstuu8uXghFoUmaGmjMY+Aiz5ewsbuHZanX
 wgQ2JsK1HUXphaIt41N4q5q86bQRIwA1VBoLzf9UAO2jYRwokb1RyNrM274w4wKV8404
 fZ1EaFRfN10eaV1cPWBufF47/lqUat/CqO4CF5osQ1A6JBIB1Z4rvzzzwmZC+0q2QOnN
 1xOpjxenVTQ/BGaAtLFdRG9qHj7TaHpCVsBNZUJD7k9iq1BsFUntky7MW1wW6TMTRVxD
 a/ADexkaVYtWpSqPCIadRNqbfwedhUMGswBZuggWvfdDyeC3HRCOKaNxz/0r9A5kLlEu
 Ocvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365082; x=1774969882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E6ZwApvfGFbQl/yLyHCasjz6LaGeymRacGWTzWNB6N4=;
 b=U9Ls8oK+/bQjnWWYQLOqp8qMIPeZooTtqB3sWMhQZJ88Q6JpDDbN5Igssf7k48kgtH
 3RzfFaY7V8uf1QCwfKYwOCmemcj0pnpW64G5cBDuRvJjtFDhoNLzGJt7H7Up0U+QIe4/
 PVgXLfm23YJIYz9I3wAq8p8al5WztzHwTf/vwJXFT2+BOrmuotYhKhl7bBiCyBNOlsDs
 SllzFEParbvfa3yfv0i/whoBNdxciJLAp3aFlnXuAn3mdtDWc69MwMkRozAdBWNVKbWF
 qrIfsDPwaQJ92Rq11EYVvSJyjOmqZTZKFpzdr0s3xLDinO+493OATAna37/rFXwcL1mo
 hsKQ==
X-Gm-Message-State: AOJu0YwjGGdEPuUvYzuIk/Dt1IznJZgtZma+7my+iWy+GkLULMh9dHx5
 MT7gG3HfJqk9D0467QW2V8xx5ZlJ1dIAY905Gv0MXK//rCR4tx+Go64gxhrrzcm6mMnjrjVB/ae
 wpnu3Ybc=
X-Gm-Gg: ATEYQzwQY5VM5nXE96BZEpI7d4e31ik6OYOakokIKI8Yz/ypxckO3id7buDLG3rg2Es
 3Dx5fyYxS1Q3SRE/UCqWuT+hcxTt8fBZgkIj6CqFX3x/fKcAvwA8d+pcJSea2j3Jy5TB016mP56
 d7pBltjb5uj+xNo1qySxnO/KFqMo5k6JFnoK4CRS9ZlHRWa3h7ZDt6tkSL31aggKXc838OVFR0q
 FUWepVwf8GOhVh/f59h8SNprqsc+ERy7QuW4cZeRci7OUPu3YVGUNz08b3oArjZwZrsGjW5uqsf
 lCyPgGQ68nKU/Bi3njKlLn+PakJQy3WVlkQU/wEWeyp+Th2jrCYpltIdHNYqALWjra5DP2gi7wX
 Mmrel01C66x3B+0xeXbwWI88ADIbM+8PZXJaeCdUYuY2KltiOOGgWmF8diwRk4m09ScyWkJgnCi
 gOy7Q0dYtLBr4xkFcqg5nbQUDFgLe/OFCpsAXGEU3/t+KTEP7bzs9R+xW1TQpvNlXnilj8asn8N
 KQCNeSjFO1lTeYbWACfSYE36yb7ZoY=
X-Received: by 2002:a05:6000:25fc:b0:439:d74d:a686 with SMTP id
 ffacd0b85a97d-43b805c3027mr5147046f8f.28.1774365081645; 
 Tue, 24 Mar 2026 08:11:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] hw/arm/smmuv3-accel: Change "ril" property type to
 OnOffAuto
Date: Tue, 24 Mar 2026 15:11:06 +0000
Message-ID: <20260324151111.237411-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Change accel SMMUv3 RIL property from bool to OnOffAuto. The 'auto'
value is not implemented, as this commit is meant to set the property
to the correct type and avoid breaking JSON/QMP when the auto mode is
introduced. A future patch will implement resolution of the 'auto'
value to match the host SMMUv3 RIL support.

The conversion of the RIL property type to OnOffAuto is an
incompatible change for JSON/QMP when a bool value is expected for
"ril", but the "ril" property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: bd715ff5bda9 ("hw/arm/smmuv3-accel: Add a property to specify RIL support")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-4-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c   |  6 ++++--
 hw/arm/smmuv3.c         | 11 ++++++++---
 include/hw/arm/smmuv3.h |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f21a6a9997..c31b64295e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -823,8 +823,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
         return;
     }
 
-    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+    /* Only override RIL if user explicitly set OFF */
+    if (s->ril == ON_OFF_AUTO_OFF) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+    }
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     if (s->ats == ON_OFF_AUTO_ON) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a683402a0c..ea285bdf64 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1975,9 +1975,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ats auto mode is not supported");
         return false;
     }
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        error_setg(errp, "ril auto mode is not supported");
+        return false;
+    }
 
     if (!s->accel) {
-        if (!s->ril) {
+        if (s->ril == ON_OFF_AUTO_OFF) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
@@ -2137,7 +2141,7 @@ static const Property smmuv3_properties[] = {
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
@@ -2167,7 +2171,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on)");
+        "Disable range invalidation support (for accel=on). ril=auto "
+        "is not supported.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this. ats=auto is not "
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index ce51a5b9b4..c35e599bbc 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,7 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
     Error *migration_blocker;
-    bool ril;
+    OnOffAuto ril;
     OnOffAuto ats;
     uint8_t oas;
     uint8_t ssidsize;
-- 
2.43.0


