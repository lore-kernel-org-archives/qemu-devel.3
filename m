Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D46FB5E97
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Iub-0001k7-Tt; Mon, 16 Mar 2026 21:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1w2Iua-0001jj-4g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:07:56 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1w2IuY-0007r8-0D
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:07:55 -0400
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso3171895a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773709672; x=1774314472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zhdPDNx3d/gTg9oeVhzGz+eM7NeEiaOjpDXqmHb6X4Q=;
 b=gTI2/5r5rsh+joIwu6qQxbPOS4fpvSolAgDSRFHltdkSE4oGEeuJ1nArOjicmofAFz
 izXsKx6Sw12lELxBeTvhuTxAuTV4K7tZFw6cXYwaNwxPfFfNxHyu4O1LbZNMZ0QYQp69
 mol8lmmIDkvw4Ck0F68B+JJN2cgy2i5Gkdf+AN/3O/zOnKFxOTSBA7aOlIYa9ad9r+ii
 oZsUnHUROagW7fAUCrW/OJQXEno3amg43DEuKS4FSTPg4BkIVZAJ4ugp1KAjqLsiepax
 wgS8wtdeeW6i2newd8iJ9L4u+77VXPRcqjzKocPPPoKxoJrm8ohR7Ztt9SZmbr7Lr4ZJ
 SZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773709672; x=1774314472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhdPDNx3d/gTg9oeVhzGz+eM7NeEiaOjpDXqmHb6X4Q=;
 b=DMDUKVOKvLMNxFYyoOo1jtavLGL+W4Ppol56Z/AK+cJduMwXXjhmwxPQYPda5PUP3+
 +x85TTbxYvK+g6NYp/t0DywnDa44u9WVsSVXsVRI0KzRkyaUSmg8kC3Cryf7oQT8uSN5
 uhQ7E3lmnkjIKpDnlphYq5DPTEPVT1V1omTtV5Et+Ll1anLiWyeFk+2cU0PqByctiG+a
 yXAIPp2CVAYYonMDhMvesne1wbO73EvlZLFXzKRvm0l4tvUuKt4MzR297sK6bkWOB+Uc
 rcDYcMnBc/lsBepKUuooP4YZADu6B3Sw9lttQG9layZkdETQrMlNpOjJ69MkPKFgHz9r
 JZ/A==
X-Gm-Message-State: AOJu0YxI+W1OmTCVPTazJGw9wUk5eJ1dzMnDx3XCRYglB6gyAqSBytZf
 pG5Utq9SfexldwZtRIDOuyyaOhs5rLdxxtfnYxTOBSfYjBlSKjY7gUPT766MHrfxzSkK
X-Gm-Gg: ATEYQzzQviT6wmS8S0xxkVXiQDhOmcexBAgA0y+v4qj39u4TYdyftZCG9xfAHXK6cZH
 qpguL7LZ3fQ8s7fG8Ub2cQW7YsNfvNe/30qZKSjvVXAyIw0jKLLf+LnExejkmoBKx/EJBYCo2+R
 2vz0m/u+8v3zLI4/PFFvepqmWiDvh5ITmA2F6Qp2YZQ82JVptx6Ij2VMKqr9VE3/SxitKz4DoIr
 geVfCOZchBpIRlq5orUt/9Fvr8K455aDHYIDwdrPAOm4PZATOZnAju7cXYENxu7YZzYB6uMYWx+
 cp1wZFE6wZYgIGJFb4nlSkA+9LrgBxE9a7/htRKmOEHpLNjy9jnkz9n/HwoQ5U3BvWtavaL2giI
 gVTWs/WyIrYDDVtsrkI5ESdF2Z0tMyN1ctMmnIKV0a+z3Dny/PY3IZGb7G2XH1vXYxo2+mMHA0Q
 sN5XCLyrJsPxXV7zS0VP0OKpdi/P6TApZMOLnm
X-Received: by 2002:a17:90b:4a46:b0:359:1821:b4d5 with SMTP id
 98e67ed59e1d1-35a21e37cf9mr13872587a91.5.1773709671299; 
 Mon, 16 Mar 2026 18:07:51 -0700 (PDT)
Received: from MINIPC.tailf391d1.ts.net
 ([240c:c603:c:1531:d1c6:c5e5:6333:bbdb])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a245b3e97sm4194282a91.10.2026.03.16.18.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:07:50 -0700 (PDT)
From: Han Zhang <ihanzhzh@gmail.com>
X-Google-Original-From: Han Zhang <ihanzh@outlook.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, Han Zhang <ihanzh@outlook.com>
Subject: [PATCH] hw/nvme: remove unreachable default cases in
 nvme_directive_receive()
Date: Tue, 17 Mar 2026 09:07:21 +0800
Message-Id: <20260317010721.232247-1-ihanzh@outlook.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ihanzhzh@gmail.com; helo=mail-pj1-x1041.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Static analysis reported that the default cases in the switch
statements handling dtype and doper in nvme_directive_receive()
are unreachable.

The values of dtype and doper are already validated earlier in the
function, making the default branches redundant.

Remove the unreachable cases to simplify the control flow.

Reported-by: Ekaterina Zilotina
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2472
Signed-off-by: Han Zhang <ihanzh@outlook.com>
---
 hw/nvme/ctrl.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd42..36df6eeca2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7550,25 +7550,13 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    switch (dtype) {
-    case NVME_DIRECTIVE_IDENTIFY:
-        switch (doper) {
-        case NVME_DIRECTIVE_RETURN_PARAMS:
-            if (ns->endgrp && ns->endgrp->fdp.enabled) {
-                id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-                id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-                id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-            }
-
-            return nvme_c2h(n, (uint8_t *)&id, trans_len, req);
-
-        default:
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
-    default:
-        return NVME_INVALID_FIELD;
+    if (ns->endgrp && ns->endgrp->fdp.enabled) {
+        id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
+        id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
+        id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
     }
+
+    return nvme_c2h(n, (uint8_t *)&id, trans_len, req);
 }
 
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
-- 
2.34.1


