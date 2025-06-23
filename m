Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299FBC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThgw-0008E2-PT; Mon, 23 Jun 2025 09:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgv-0008DF-2r
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgt-0007Gn-Ia
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso5342673b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687110; x=1751291910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nlo8as5e/cpldlYDplp41yosw6ZzdGOstiWraYoHkls=;
 b=oHRKiiECvDy/vU8G3L3PgadJZcssOkVlPB3T8PRyvtC+CYcCv2ExkaXwJmT5XBLz5y
 o0xMIYjy1J/P4+RyM123QGUTzxXXOZyHpq0QKz7ePus01mw0YgHhonokjENr7lbigfEZ
 J8DlN5L16w3lk0bsWf+aTLenSiJ2Vi7f6Xtff0DqDp6cztOEW2pumZ+M0FiyiYM/Ho9w
 epSB1MxH7vPv5PvrbcgXCnIAbgFLh1DdNj27nEJnE2jYGU5Ybox/coGRNF+bmYcyUa2o
 FtOoW4KYUcjEAzNobujdA02PQrSY0MeUI2DGQe3PQkx2eQ3VcSDkWKOq5XFRUjo2Kc0P
 EC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687110; x=1751291910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nlo8as5e/cpldlYDplp41yosw6ZzdGOstiWraYoHkls=;
 b=ifNnFAIjRk0W7lEZldkoO7R16DUbhSoQt+bHLMp8HMhHtRCup+MrXKOxaFcpqKJ3ZZ
 hIHHuuznjsq2lMnA1pbzcyNl29O3P1y9RVsXKVXrxKGiIhZZRDs3dqWQoVLGuKrCD62S
 mC1xEkGl8U7Q3JqVxFTLDwHxCQMpCpuUYmR7bwf+wPauNL82VuSqcrXWFfvepfkCcyaK
 mlFl7QPqvawXDdwNltypEtuQcYIrPCvukyzkRom4Oq4hnYcyoacIyJPq0FIUD6ikEkSU
 WH8vU+y+daohc6wMGktID9TuquT38R73x/1H5c4CqZNYracFe4Hc5idyPxbLoTGDnjAS
 r1vQ==
X-Gm-Message-State: AOJu0YysBwPNo2j2QynvGtpjfW+Hq0IOd9TyWWaiVdjVoix6GaNAIT/l
 zjACgJEqJKWqDnM0Xw1VJPQzI4rVhCXRoUQCz6ph8ZrpZZKeFkkhKRp2yZV+CV0L4fl46GrHyzM
 QiuFB
X-Gm-Gg: ASbGncss3y1KICTbsMwCJFOlyMMgzXfyhBNCERjfFxoi8tQVAqzW2gtgDK8XX0QxSec
 rkFjkz8Q5OF5CJQXDN0MQ7OY8f9MjA6DGIsl582fHujn210IH0xgYxlxbHknLv4poAJw3wgo2gj
 blK4QY6HcwciS41mCa1VKBc1PKpot38V3lBYO0bW2ifpyYf5LkCYwyP1Gftxs2pHd86Be8edaTh
 zwVUs7ig9Ql7mLTdZo+9xxnPv9UIScyNbBSSJFKvooqlps0+RPvhGe9MxtIF4BoTS6iNcRaMF5C
 k+jM8VWYmCJ3SEXoufq1GFWG1TEJXd2dKd4fsQSqHULgwI/5lsBBMyJd9/AnUR9nP4l5rLdGMAu
 iZg==
X-Google-Smtp-Source: AGHT+IGg0Hu01Sq7RKr8UgZ1A7DHPgd6q0vY0ikfWBIFKs7+PyeEB47pid34WctGwhJJz5vwK28x2A==
X-Received: by 2002:a05:6300:614:20b0:220:2a67:14a5 with SMTP id
 adf61e73a8af0-2202a671568mr16673077637.32.1750687109875; 
 Mon, 23 Jun 2025 06:58:29 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:29 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v5 2/9] hw/arm/virt: Simplify logic for setting instance's
 'tcg_its' variable
Date: Mon, 23 Jun 2025 13:57:42 +0000
Message-Id: <20250623135749.691137-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Because 'tcg_its' in the machine instance is set based on the machine
class’s negated variable 'no_tcg_its', 'tcg_its' is the opposite of
'no_tcg_its' and hence the code in question can be simplified as:
tcg_its = !no_tcg_its.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a3..19f85d0abf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3337,12 +3337,8 @@ static void virt_instance_init(Object *obj)
 
     /* Default allows ITS instantiation */
     vms->its = true;
-
-    if (vmc->no_tcg_its) {
-        vms->tcg_its = false;
-    } else {
-        vms->tcg_its = true;
-    }
+    /* Allow ITS emulation if the machine version supports it */
+    vms->tcg_its = !vmc->no_tcg_its;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
-- 
2.34.1


