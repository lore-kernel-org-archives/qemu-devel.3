Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88239CEB2C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOYO-0006Qw-8E; Mon, 30 Sep 2024 18:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOYM-0006QS-Nl
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:07:38 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOYL-00023T-6Q
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:07:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so1091103566b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734055; x=1728338855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/26k0XIki0PfJQkG3TkT8x6m4iNLUaC+2Zypof+nqPg=;
 b=mnHnCMbS6t/kx7dHdOvYyYw/bOO8XnNn2im1qfgORQm0D3Gr9g6TCBBbh6WBhmjuXJ
 yecGheHipiKe/oPwxfqMf6Zk//E/UPoZR/4uMRku8aXGDSIQEG6FjR2p1Pgemo4MnmnM
 0HKqXxjN+pXyR8fU1Pf0HJux4yiHZhypDmv8Za2YFZjUIPH3dfLiPvs4QoSoXskOyZIa
 QGyyVGhRwnwIFy7KvoxPT+CRC31gKZQtd/w3LQOGOGubuwSMJEPSdNxrXF9IkUNI2Tp2
 zWagmCXydur9lszkViPWj2wVSaqMpxEqj+GhTakMwU8jcFiFZqDThI7SVswf72sZGryJ
 43lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734055; x=1728338855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/26k0XIki0PfJQkG3TkT8x6m4iNLUaC+2Zypof+nqPg=;
 b=Sg9BudZbroCGxRK8Tq+nwGDDVaeg9qk1zIv/OGDSmnHxn3AhC6eWiiqgwJGmZW8d4M
 vjKeCUhG+HRzB9IyzCEukFyPdOA0PwryP/JyLkhbIvtaQW6Q835JW5r9BZj3dkYLLHc9
 A1BSbS0xx80k+OXDoYm+PxrvnuKtNxaVu6GtPbz1KuSk8jrXFtOKE5RSEc3N6YBN6wXY
 B+uQul44Ex6Nv3dE8Q2gl4IwyHE1GsyXhL/9gROvgxiTzTYxXcYOjVbiq+5TOXT+RQBp
 54JftP+oVEbYJ8HxMZ7RrPyACESjakcC1Iwq26scUoc5n8K8TcHThl2HTBsBwdyy09Nu
 ezEw==
X-Gm-Message-State: AOJu0YyniWL+AwpSdKa08KaR40VFfisgaBQzMuatktuItUVlSpd9jSXR
 agMyAHX2qky96pYgksWWXcQkHzgpN1ICH5jU0U4jXi20wJjMob8+uVtomtUgsRSXacXYu1u4IN8
 cEis=
X-Google-Smtp-Source: AGHT+IHGWI7wl7ZzoVaj8Oc76P3zJDtHd5riRYGjTBdkbsCbV5TDN28XT/adIAresMGj4Q/Eoj7Hog==
X-Received: by 2002:a17:907:1b10:b0:a8d:4e69:4030 with SMTP id
 a640c23a62f3a-a967bf5350cmr100530866b.19.1727734054985; 
 Mon, 30 Sep 2024 15:07:34 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27c5aadsm593218966b.79.2024.09.30.15.07.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:07:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/sh4/r2d: Replace tswap32() by stl_endian_p()
Date: Tue,  1 Oct 2024 00:07:32 +0200
Message-ID: <20240930220732.58757-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Replace the target-specific tswap32() calls by stl_endian_p()
which does the same but takes the endianness as argument, thus
is target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240930073450.33195-2-philmd@linaro.org>
          "qemu/bswap: Introduce ld/st_endian_p() API"
---
 hw/sh4/r2d.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e5ac6751bd..6739ac435a 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -353,9 +353,11 @@ static void r2d_init(MachineState *machine)
         }
 
         /* initialization which should be done by firmware */
-        boot_params.loader_type = tswap32(1);
-        boot_params.initrd_start = tswap32(INITRD_LOAD_OFFSET);
-        boot_params.initrd_size = tswap32(initrd_size);
+        stl_endian_p(TARGET_BIG_ENDIAN, &boot_params.loader_type, 1);
+        stl_endian_p(TARGET_BIG_ENDIAN, &boot_params.initrd_start,
+                     INITRD_LOAD_OFFSET);
+        stl_endian_p(TARGET_BIG_ENDIAN, &boot_params.initrd_size,
+                     initrd_size);
     }
 
     if (kernel_cmdline) {
-- 
2.45.2


