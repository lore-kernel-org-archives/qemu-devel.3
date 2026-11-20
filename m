Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE400606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6a5tJXV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PhZLDCSp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3c-0000pK-2F; Fri, 20 Nov 2026 07:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3a-0000oi-AO
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3Y-0004l4-N6
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqKxOcavRdkss7CvBdIIjsxzaXmG9yDTO0yKuff2+/I=;
 b=a6a5tJXVWL+spm8KIEV693gWduwR3J2W6d5geuUCX8Ts8dRZwPM2R4zi5Ey6Xu1YqKQ2rj
 yV7AF4lJFUlGNrFklISCjGwu5j7A8fTghn+LhXhWCSf2/5gsx73V+fCABefSdBwYENk6w2
 WIXhZOSSzUU/taQVkwVeWauCQME6gEQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-3R4TBKBPP6-fqihDxwM8XA-1; Fri, 20 Nov 2026 12:49:30 +0000
X-MC-Unique: 3R4TBKBPP6-fqihDxwM8XA-1
X-Mimecast-MFC-AGG-ID: 3R4TBKBPP6-fqihDxwM8XA_1795178969
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53661e036a2so17300531cf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178969; x=1795783769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqKxOcavRdkss7CvBdIIjsxzaXmG9yDTO0yKuff2+/I=;
 b=PhZLDCSp2NhWsUVOF7LjOeAci/m0VyAbuH8RlLB9dzRZuuKNWs56COQPQrkFkJu0np
 KTbfBLImxqs/S5y2Fr9Thw4YyayexVE+xheoi5JxKVODv8ARR1v2gsQqb+yyHTAZcybP
 9Nzl5d14Y8KKiOv+XlwRa1pLpExp/m+FZv2M/OUkxFoqSIFO/d9T8t9IqIlyD+k48npE
 dZlTd1e3Qc3hJcgfF+AzCB9t+by51MsWm4u6MCEk4KrPTxlQ6+VNj2TXCNKNFDEUvQyQ
 82vOX+1SAmxHGFMXtom03NmD/DiQl0KquqaEc8LP4KZ4zicZ/FPw0Zpsq9C5oby+55tm
 IcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178969; x=1795783769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IqKxOcavRdkss7CvBdIIjsxzaXmG9yDTO0yKuff2+/I=;
 b=fl0onUAInw6U1vnrZLryeIS+bd7203NYsDCMVz/yM+VRxt13UI1KohaUaoEYY2tUk9
 t5Kv1wB8MF+6fYrNWWOlkO9ER52kKHRaMDcf45UzZJ9Fk0t6bhwAyjrEC2+R587Pzngj
 mVuckoxC6km/yf+vHNN5qaxXmlrOz8IP4ynfQmIbChondoTwhk7mHdSrQo7ieSvU/Bn1
 5pyPfo16M4BB6PMzU6N27CPZ0IGhf7WOD+uzoIG0mr4hvRpAg4oDQnGzuDmRz8BlEasv
 XSLXkwC8Tb3ssFPHiQrLig3ozXzNv5TRpbfxQfJ8hGDI9eVYRXFkMbc7nDP263buHGHr
 ozvQ==
X-Gm-Message-State: APuU4Z8ioawe/ZSbEIUG6aUXzy0UJX6sfyRsv3e6B6CXWDsZqEnqJnt+
 vIl4BkkA8ObF3wKyDeBkGiDaGRis038Xv5p4KqsWf+LPc0pfkLE6KcYaLngwfoks4TbMUCvILRL
 UfLHX+eEtrwd+2fk1qpl0QOA7ICgIDhp+zjikQWZP/Kkgdyalgq7wPUs1c9NoSSj+aFjTPrmdmu
 rA/LS1dFz27Y2TaTB+Fi/ZDYekP78oraX1hB031A==
X-Gm-Gg: AZFdTZe+I+XKIVBhF30tkv4dRtQ/b8mlnTl0nAs5MSLDLP4BxJFTJtPbU5a+UfiV3Tj
 wDe9+wS2yvPxGrJtB7feYALt/54QtnSKbvnzxzHyzt3tw5csgdXG7RkX8kkLdwumWtHzOylVFt/
 Dj4eYH5MK1UscqAydwOC1flVnYgf3NdIgNUNwkm56G33a8Kt3t3Cv6JaD0EivkKCuJ1NlVwhSgp
 fyZbz/LBYmuQ6DxlGyoOKhVtIadlXBzz/AmFP+qJMrmE6x7daWPWodawTdnr9eteBoJAlfgBh8+
 SjXslANwkPzUGPjYqOs70F7Rve4AGI85YTQqMO3pOlMqIP4t+stMe1S+sy+PzLQzpdn0p6rPB7d
 o4gqGDUddJjzcsY/cFQht/o0wPgx55OGnPk/nIC8gqIK+
X-Received: by 2002:a05:622a:1f89:b0:55b:8a74:cfc4 with SMTP id
 d75a77b69052e-55d76b5e88cmr50298651cf.76.1795178969439; 
 Fri, 20 Nov 2026 04:49:29 -0800 (PST)
X-Received: by 2002:a05:622a:1f89:b0:55b:8a74:cfc4 with SMTP id
 d75a77b69052e-55d76b5e88cmr50298231cf.76.1795178968832; 
 Fri, 20 Nov 2026 04:49:28 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7c654585sm13759661cf.5.2026.11.20.04.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:27 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH for-12.0 2/6] hw/gpio/zaurus: Move VMSTATE_VALIDATE() check
 into post_load_errp()
Date: Fri, 20 Nov 2026 07:49:19 -0500
Message-ID: <20261120124923.1656220-3-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120124923.1656220-1-peterx@redhat.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To pave way for removing VMSTATE_VALIDATE(), remove the use in this file by
moving it into the post_load_errp().

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/gpio/zaurus.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 3cf626a550..a60f4d4393 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 
 /* SCOOP devices */
 
@@ -188,12 +189,24 @@ static void scoop_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static int scoop_post_load(void *opaque, int version_id)
+static bool vmstate_scoop_validate(ScoopInfo *s)
+{
+    return !(s->prev_level & 0xffff0000) &&
+        !(s->gpio_level & 0xffff0000) &&
+        !(s->gpio_dir & 0xffff0000);
+}
+
+static bool scoop_post_load(void *opaque, int version_id, Error **errp)
 {
     ScoopInfo *s = (ScoopInfo *) opaque;
     int i;
     uint32_t level;
 
+    if (!vmstate_scoop_validate(s)) {
+        error_setg(errp, "irq levels are not 16-bits");
+        return false;
+    }
+
     level = s->gpio_level & s->gpio_dir;
 
     for (i = 0; i < 16; i++) {
@@ -202,7 +215,7 @@ static int scoop_post_load(void *opaque, int version_id)
 
     s->prev_level = level;
 
-    return 0;
+    return true;
 }
 
 static bool is_version_0(void *opaque, int version_id)
@@ -210,27 +223,17 @@ static bool is_version_0(void *opaque, int version_id)
     return version_id == 0;
 }
 
-static bool vmstate_scoop_validate(void *opaque, int version_id)
-{
-    ScoopInfo *s = opaque;
-
-    return !(s->prev_level & 0xffff0000) &&
-        !(s->gpio_level & 0xffff0000) &&
-        !(s->gpio_dir & 0xffff0000);
-}
-
 static const VMStateDescription vmstate_scoop_regs = {
     .name = "scoop",
     .version_id = 1,
     .minimum_version_id = 0,
-    .post_load = scoop_post_load,
+    .post_load_errp = scoop_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(status, ScoopInfo),
         VMSTATE_UINT16(power, ScoopInfo),
         VMSTATE_UINT32(gpio_level, ScoopInfo),
         VMSTATE_UINT32(gpio_dir, ScoopInfo),
         VMSTATE_UINT32(prev_level, ScoopInfo),
-        VMSTATE_VALIDATE("irq levels are 16 bit", vmstate_scoop_validate),
         VMSTATE_UINT16(mcr, ScoopInfo),
         VMSTATE_UINT16(cdr, ScoopInfo),
         VMSTATE_UINT16(ccr, ScoopInfo),
-- 
2.56.0


