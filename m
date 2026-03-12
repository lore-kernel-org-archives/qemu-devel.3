Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D1C105A594
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0eyB-0000YJ-Fb; Thu, 12 Mar 2026 08:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0ext-0000Wd-Nl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:16:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0exp-0006mo-1p
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:16:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ae4d919f9bso6620155ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773317787; x=1773922587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWkh+alhVzI4eF2DAPUc2nmsHRaOn439ujDERgY8uxE=;
 b=hqLZOMX23eHND7Jc3pMOTvBqB3XxpW8evnDgxgme6M42/zvNefQWJ2z5MOu9QAAvyA
 QhGfMKe8YztR/RlvI8UJU7MkYmiohNScv6eHYa1AFik9SVKaZ1B9zlLm3vFzOktK86rk
 ne5MSgOiwd9nXs08saVaNjykYnG367Et0B4pTbfQI6LnjgRiaksajWQuPUyZNdvBsBm6
 Q/RP/ZoQoKq2zpcJg9EmwTa05XJqdDb0aB2x0fYBIRLZMc1oMwDHT0n/gS/zAHBeDarf
 9nxRIr9/sd5+nbJsEFdu1WjbY0bNopV3huEt5m6wRL2dUB1AabrOPy2haqnHUp1poS5D
 zAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773317787; x=1773922587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWkh+alhVzI4eF2DAPUc2nmsHRaOn439ujDERgY8uxE=;
 b=tW/DDpfeYBuIWM2R7eeVM12Ak/IkDcstvjmWkACgOL6ot6A6CtD0myirygpBlTIhBT
 MBDvs0Hi2AHHL3B86IOwqeDaw2cUW6KMEd05pMTDUtU4csgJaMO7gMxkq90ghsv91kz7
 RHmuKzyMSv+6v+It+StVQ1Yqjfx4tNSGNDAPCa08m7qpc4c5DwiniPZhFDItLH6KMmHj
 PQIAYhZVf0Jjs4mw78tnACF/ivYyDeSUitAoKhgq6l4NFoBMq2oB96OO+mN+aCN29IR4
 9Mz46SCHOHwqrn+smoIxBxdIZW72ioBOnUQ8RN2UV+M2dIGo3Az5yeC5RlehDPTxqlS0
 mEWg==
X-Gm-Message-State: AOJu0YyJKffCTrRo0cXPDIXBziyUnOKuf9b9REG5Yb3eXYsY0OTjgSym
 v5h8yhEC50Fapi2NKusoIFZS6jJfIlCv2p5h/4978AnYs0S/D83h3Q64o1eAYjvGvM0=
X-Gm-Gg: ATEYQzzMWGRYs5/uZVw79pW4LitOdwuyGhhCbPHGgLWUdLuFOPxyzIw+VLg9SqhMhJf
 gtpGOFUnDhffdvTaP8DsYByG3qXdcCoSh0KEymdGfE8b51GsGIKzbcI+wxLwg3gD1Juo9vJOEHQ
 9W4TrqflosqEzmfraEzMLwCAkLvKMZ1XXdsr/rWIK+nkvsk6/zxc5qUtbmlJEDyE2es+tox9YIS
 Ap48tgDli1Fwd9ABh5q6oXLpZv5ft+7HJeIsG7Ne53+d97Xvvjx9kwdURFJ99SpCoKQmVCMOgQ7
 r3SMVUqWPV2aNQV2vjkW6//RxGc3KJ68aDams0x5e7mSejsqg2Z7aAdDSwD+YrbeqsEO9G0VkyA
 F8r5oYjqbiVQQPMpx+pXBmGmwWoxrcxSLP6i2gYTZB6wPaRkP695irROsVahAU9M9p0aT9RGYF0
 xzdmfGgj4VFleNkeqF7h9xQa4leSfdw8x4wRJh7jZoU+u8IjkEuGgLLCBwNwatmUtREBIcr99pl
 2sId8He+xoPURAOZ4eT
X-Received: by 2002:a17:903:1110:b0:2ae:8077:b1c7 with SMTP id
 d9443c01a7336-2aeae88381cmr64637515ad.37.1773317786968; 
 Thu, 12 Mar 2026 05:16:26 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae22287dsm52116155ad.12.2026.03.12.05.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 05:16:26 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] plugins/api-system: Handle migrate_add_blocker() failure
Date: Thu, 12 Mar 2026 21:16:17 +0900
Message-ID: <20260312121617.228654-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

migrate_add_blocker() can fail (e.g. if migration is already in
progress), in which case it returns a negative value and populates
its errp argument with the reason.

The previous code ignored the return value, leaving state
inconsistent on failure. Fix this by:
- Passing a local Error ** so failure details can be reported.
- Checking the return value; on failure, report the error, free the
  migration_blocker Error object, and return NULL to the caller.

Resolves: CID 1645470

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 plugins/api-system.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/plugins/api-system.c b/plugins/api-system.c
index 9a70b9caa6..f0d6cefe74 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -105,10 +105,16 @@ static Error *migration_blocker;
 const void *qemu_plugin_request_time_control(void)
 {
     if (!has_control) {
+        Error *local_err = NULL;
         has_control = true;
         error_setg(&migration_blocker,
                    "TCG plugin time control does not support migration");
-        migrate_add_blocker(&migration_blocker, NULL);
+        if (migrate_add_blocker(&migration_blocker, &local_err) < 0) {
+            error_report_err(local_err);
+            error_free(migration_blocker);
+            migration_blocker = NULL;
+            return NULL;
+        }
         return &has_control;
     }
     return NULL;
-- 
2.43.0


