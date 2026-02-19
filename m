Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97270E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MN-000455-Vj; Thu, 19 Feb 2026 09:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5MC-0003uz-Pv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:22 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M6-00084n-Nn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:19 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4362507f396so1096701f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512591; x=1772117391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rt/W6ouTfZVSR4Ud5vC1h7zS5UVtzxCsy8jnIZDfYtE=;
 b=h57Ib7o1aBgP3FI+Ql0YbfZM/i0VQYkourJnOKHpxIqzu/9MJkyFDLaYFDaNxxAWGo
 JRGVYn6ykDNJF+TLy666ZB52LSaRjrtdXQFYaKZax4WSThLr19/ldEuaTl/Yj3uLPUQT
 FK+JOKDE9GK6SyEq+apKSUIfAzB2x8OuL2GO6vSELh14/+ifv47dNvntJZBJvTvDtX2D
 32Wy9x0h73hV5DSLfplSPTpz2CeGuddz8Om9f+a2Ab8efV4SPnlCBB1nrsL2hxQj8k/Q
 R/Q/l4cIaVwxMDOOEr7z1ufh9l81Pv+jAsKSeSm5l+P/dkriVyvUIxxdBvGp46IO6dNi
 pqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512591; x=1772117391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rt/W6ouTfZVSR4Ud5vC1h7zS5UVtzxCsy8jnIZDfYtE=;
 b=kMvWd5GPqwpKBh56pcTfdUVaqxATXN75jcprxmRfRgPBm1LtPgdzzvGgwx2Y/JrJ2W
 8D8bwkdzSw7gFzfC1toBKxuJBWOvGdvwrvO4kZFWM0EBLLg76ymY7XXCw7OMJ345l5UX
 9ugS9b2ivaNFslIZ4EbzRxbn39iC+NzqLz2f5iw9TvINV6FclxtYAw6N3uzPkaFih+gH
 XeJSMgSs8tjfDNDhHO0fKwWEzJkSOMaRxUaRxzB4WbYGSk8NnpwAI9nBoadtm+WAR5yN
 6Ra9PQDuiJoXOBsKx2PaUdUqPJw/iybaWhxtWw2+bSCMzPKptEYVE2vPoLEkk0VvQS+o
 b8vw==
X-Gm-Message-State: AOJu0YwmqAkPHx7bx2G1j30hWGWdxZAmDo9lDM58rmD9am4cz6u8AZU1
 DqKEzIWGcq0s+w5KCuJOEXRFoIjxpqiwpm+8OCoste5ebnhjUBUm3DRsJoqDhbnh
X-Gm-Gg: AZuq6aISxBknHztMx84K4xmhZtKss5461l77Yc2V/5icg1eai3HFWrbqgDCNakMtIyk
 6dY8VAni59kkJcPXR2je3n6Ts/8qDq7zD8aIymmDSnp6AKI8DMw+RMG3p1rKKPJTM2E30wKXugJ
 wdL2p4DWdxcg4uBo2rgtYxNxRe1GD+htk3u6WAOuQX7XN1FmDhbLCpOJdVdDTcA4XfER6vpktFO
 dsNpavv9hd/L9kBewJa18cNyyO/9L9tKDcbH2W8GP4UpZxVQHFuiwAe/GF5wsWOq0zp/ABFmOCG
 0+sg6DL9rF66KPre0bwvqownUTQGMCLCQ3+6eJGlYMP12Clp+6xnXj+yuWyEe7A8dt9Nabpq6Bc
 6fojFsUkGwjNvDQM1erOiepuHKpK0wDs5A0Bw1IrENMTFbEMPMJNUyGZTvyGTfvx2zhKBB1JGMy
 KNhqw8/tEkJvVpSrWEsS3ko9QcHu7EE1eqvDSEsjdpFug5cs5lflECbDaSJ/cxwDulvKqm
X-Received: by 2002:a05:6000:288c:b0:435:95c9:6891 with SMTP id
 ffacd0b85a97d-43958e4f7f1mr11279014f8f.42.1771512591366; 
 Thu, 19 Feb 2026 06:49:51 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:50 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 27/33] hw/core/fdt_generic_util: initialize serial devices
Date: Thu, 19 Feb 2026 15:48:55 +0100
Message-ID: <20260219144901.3317747-9-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42f.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch adds proper handling and registration
for serial devices instantiated via FDT.

The devices with 'chardev' properties are
connected to serial backends, if corresponding dts
property serial id number is set.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 3179248142..c58a9ccdc7 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -36,6 +36,7 @@
 #include "system/system.h"
 #include "system/reset.h"
 #include "qemu/cutils.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
@@ -1216,6 +1217,7 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     props = qemu_devtree_get_props(fdti->fdt, node_path);
     for (prop = props; prop->name; prop++) {
         const char *propname = trim_vendor(prop->name);
+        int len = prop->len;
         ObjectProperty *p = NULL;
 
         p = object_property_find(OBJECT(dev), propname);
@@ -1235,6 +1237,13 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
             continue;
         }
 
+        /* Special case for chardevs.  */
+        if (!strcmp(propname, "chardev") && !strcmp(p->type, "str")) {
+            qdev_prop_set_chr(DEVICE(dev), "chardev",
+                              serial_hd(get_int_be(prop->value, len)));
+            continue;
+        }
+
         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
     }
 
-- 
2.43.0


