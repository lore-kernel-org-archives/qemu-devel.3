Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B84E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28v-0007HO-GI; Sun, 15 Dec 2024 22:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28s-0007G1-1P
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:35 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28q-0005yf-LN
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:33 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e2aa8d5e3so1947394a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321091; x=1734925891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4CpHjWxyM4MviuiMSkrydePOGdO/jcnUzBym98D8q1M=;
 b=ehW1yYcl5O1iDs0/2PrL5DfEaDuFWiOPwut/azK8I/xYwgqrhDpcoqoHY6FmGYxOqK
 8vRKYj938P/J6HS4zFWPeOILA8c/U6/xZIwI3PEpbwXuDlPGiGCltvgorPBi9Fajz6el
 3QHRdn4PVtLoM2njaRB1Xx4uuWmKC7aepc2rWWECBxqNXS4k6/IIEbf/EZ5/dJmPr3m+
 MRDaEiU/CpfyLudVQFlf1sYXWUGGy+5gdr9bovURn4GZycRS3Njh/DPWiNMQmZIQ66gD
 HyBBHnXAEO92OEjxQirSDGHP3Q/R804D8UWFpHXucoVMQf5oiY2HAgmNwdYmgdRogsTV
 z2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321091; x=1734925891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CpHjWxyM4MviuiMSkrydePOGdO/jcnUzBym98D8q1M=;
 b=oH5mKyFoRSTO0O+0h6Z1i3XSWlGxmt992kOSFhxYoITVaVdEeClg6SEa9bmmRPxAAX
 bsi2UyO5pl9kiuEbw32xP5/BYN8MsDy98hLgGarLT3KGmobc9mN4faKx25VEs1ThUDYV
 uH4fMMK3iawujq/i5hxpG7s4eCh5Iayr7PF/LNLF8BhYzJdAbcHrrR2PWo5FM7dah6uR
 c9Wpf08oz8A/a8NEfyp5Pjnkz66Yks2zz8Gjxv0lOPf2p0CPzXYAwYhGlA+/xDKaPp0D
 gPYfpL9gxWnzr1iz9hhMI9gVVukq0NH3KX0AxlnxWj4LVx155IfWzKx/7k8PsB5j0LVF
 EcMQ==
X-Gm-Message-State: AOJu0Yw6vB1j+ULGEf8HMru3TGAdL8bTfMkp90mP1wcI/y+0DB8C2lBF
 xz/u1w7hxH7+XzwKc8yrffjQMPAGBPfYCJcPIJRTPiSPmeS+GACg7R1h8QBnHFlpXzDi1+WcBvf
 RGi0ykjZx
X-Gm-Gg: ASbGncvZMORX+QP+2v7up2DTIh7Izd/gwD6ovorb7ABisBhUvRDfBng0C9fwQbHU6Kg
 cuEBpy4nalkHAN0NXX/6xndaUxHec/S8R/1Wjm+CFw4MNwJouXsc5AVCFeHcgGkWTKYDkFrSjnz
 9g4ufPOutCi5lG4WBc93Z8+7JQZABYGnBZLH/nyUekpBh26WiPD39WbaOa73BMNtlEg8N6ZtPk9
 Ll3xW2l8lXkIhWdUJWVE/h0hyXOB9KvctoimDgrKVaUqsZjkJgsskW8T9FyDOdsGCOouDeP04Dw
 vxotQ9kQdePRUAuR+uyJUvDI9HeRQ21T7P5SzL3azAI=
X-Google-Smtp-Source: AGHT+IGTE4LUM32BHMIB8p2vW2F9dRJs5AlEfz95rpHN5jAHx14vpTw7fUB6g65H2mSx3KU1byti+A==
X-Received: by 2002:a05:6830:2107:b0:71d:415a:5d18 with SMTP id
 46e09a7af769-71e3b82a420mr6827534a34.3.1734321091381; 
 Sun, 15 Dec 2024 19:51:31 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/24] hw/ppc: Only register spapr_nvdimm_properties if
 CONFIG_LIBPMEM
Date: Sun, 15 Dec 2024 21:50:51 -0600
Message-ID: <20241216035109.3486070-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
 hw/ppc/spapr_nvdimm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 2ef6f29f3d..6f875d73b2 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -884,22 +884,22 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
     vmstate_unregister(NULL, &vmstate_spapr_nvdimm_states, dimm);
 }
 
-static const Property spapr_nvdimm_properties[] = {
 #ifdef CONFIG_LIBPMEM
+static const Property spapr_nvdimm_properties[] = {
     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
-#endif
-    DEFINE_PROP_END_OF_LIST(),
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


