Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E635E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKS-0001IQ-I3; Wed, 18 Dec 2024 08:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKO-0001Dy-RK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:05 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKN-0005eH-2Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:04 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb7edfa42dso3241550b6e.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529382; x=1735134182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQOQ8zFuijPHvC07mGguwnvYLc8FVIGLE5CxHx1qa9k=;
 b=pfyIFbZHeM5VkkPDgJTVvYbEnJ38mn0GtVWueCTLFWV97XCWkGcSl+MaHRVLFijmeU
 rHJxrkuwNOOQmdOI09cCxfTuz7cAgSap0Wvh+u5VuDE29bQtZ16s5fwLSxqeFcMjgGW1
 BRGV2tka3Qvx4tn2hikELtHBSuHnRHtQdrs5lUvQ+rA2Og1y94rnq10FfW+eICu2Iwxv
 +PfjJD5q+VcIu2YC1YdvRfg+VS5udwkjU5bgpowNR2r6aYKVL8ZCYoZVK/BmwKDGa/0s
 QCVtajDdg1TsMCHA1mBFQAq0jpAc6/arFXtoD+SujR0+s8iexQWuDrMH5XPoOEqf065g
 wqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529382; x=1735134182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQOQ8zFuijPHvC07mGguwnvYLc8FVIGLE5CxHx1qa9k=;
 b=HWAFugqOIVGSgQxY33Ngl+9WI4gWkdEilMs4xdUUGu5E2ik9PEwthCC0ivkiUYfeeQ
 TeWpMxCMb/GWN+MfBy1tGeJg7iqQh1p4aThG6t/ql4jFYWxDMgoDycvk5COMLZsf08+4
 nHWl7SvQKUI7kLn1U02SkLhDwrRNHIgR7UsK9GEdIkVuNQKuSFcS207pO2Yk6g3/pKpa
 3wTUWpEIBzQQuKjxG/v2qDVEooaNeg7T90QLGGooPyrgjk7ApZMOlS/oddu4KO+DwxY/
 w9Cv7R92xryrN4j2/K9DPCb8iwKQS3GWI7lIdR1jsXmIU7X4FSl7QXJOQmKkrscduHwN
 Qu6A==
X-Gm-Message-State: AOJu0YxBnZRaa3reSF1ilYD46+KirgvkWHoM0dDLEZwKWn/8Z0kBTivB
 Gzc8izAgjJxz2J7rChK9caaTG3c/cBfoCH/MTJD35tOB7CgsSNuu6QF1lK79lOl90tRvU3dUwNn
 yJbYuquR9
X-Gm-Gg: ASbGncsbFHKNZnYfXjGG7PnnlLGD4UNe8GoocciRSEB5Msuooy/j7wUTi1SuNqVbJqb
 iBMdPSK5fJsplmJThX+4XBZvhWyAX3IBZXq2siVAClQtPTujwWuylmHWXPlFzpgZpkXhc/BZvpE
 rUpSByO+XzELo2NUU0nB3D7oYR0YcSgtPDaGRxnh2/zP4uiDOysW8mVs+nFJ0K6IZTivb3W/0ss
 SnNjWSu+Gjb6V5YKubp2jG5TJFUhAIp2iOwT6AH/n0GXKcEto2aEcMvKtbEr+5S
X-Google-Smtp-Source: AGHT+IHQR+mnk3v8kvet22/22ub88Q5gzP2qbv6a2EmQ1VXbsQ3AONr8h3guWga9hPZQXzGp12DVlg==
X-Received: by 2002:a05:6808:f93:b0:3eb:651a:6cec with SMTP id
 5614622812f47-3eccc070d61mr1856356b6e.31.1734529381939; 
 Wed, 18 Dec 2024 05:43:01 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 06/24] hw/ppc: Only register spapr_nvdimm_properties if
 CONFIG_LIBPMEM
Date: Wed, 18 Dec 2024 07:42:33 -0600
Message-ID: <20241218134251.4724-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Do not register an empty set of properties.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/spapr_nvdimm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 2ef6f29f3d..8bcce4146a 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -884,22 +884,23 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
     vmstate_unregister(NULL, &vmstate_spapr_nvdimm_states, dimm);
 }
 
-static const Property spapr_nvdimm_properties[] = {
 #ifdef CONFIG_LIBPMEM
+static const Property spapr_nvdimm_properties[] = {
     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
-#endif
     DEFINE_PROP_END_OF_LIST(),
 };
+#endif
 
 static void spapr_nvdimm_class_init(ObjectClass *oc, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(oc);
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
 
     nvc->realize = spapr_nvdimm_realize;
     nvc->unrealize = spapr_nvdimm_unrealize;
 
-    device_class_set_props(dc, spapr_nvdimm_properties);
+#ifdef CONFIG_LIBPMEM
+    device_class_set_props(DEVICE_CLASS(oc), spapr_nvdimm_properties);
+#endif
 }
 
 static void spapr_nvdimm_init(Object *obj)
-- 
2.43.0


