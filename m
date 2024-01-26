Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D543C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNPU-0002rf-NE; Fri, 26 Jan 2024 09:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPR-0002iw-8a
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:22 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPO-0001RB-CW
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:19 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3510d79ae9so26146266b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706280136; x=1706884936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHxMCRnEljW/h+q6H+cTZi0z1+riOoBx0yCYJzMalqA=;
 b=GGHW4nJNFs3nHZUHxJgrfGOaC5val6sksSriZuiJdlUJd4qYW8sHuRk8u2LltMkmFt
 Tpdsd3/qfbVHLCxzpDvPoWqqtMtyiKHh7gVOMkPJqIzIuGcTwi3l0H5tw33IU0zsRwQg
 dYq0lw9AsgHnVaHPaYGWOx59GQTwTrcRN2erMMaOw4EVkUKnVC3/f+nF3L/KCrWp0rFA
 JCTycsIK0NHtxssm9BH0gZr0LdI69GAQMQ/BmucN6Q5aMS5i/QfIE8aNl9AvSnLDU+YJ
 ckGjUmeIO6UIxX9EtqPLHeDE4gbpZPcl+LSvnc6zXr11epS1dynt+DuohLS5yhO9tzpb
 RNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280136; x=1706884936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHxMCRnEljW/h+q6H+cTZi0z1+riOoBx0yCYJzMalqA=;
 b=h51AVG2Csndmyntwb+fKAg1nouPKwtzKNQ9+dByMytpw2e62P92p7vOCIdUuAXCwJW
 W5IU2u9+oe2qLGfmJcT7fXYJ5bIHkNhR1AqN+M8kpk7dgrpGvShFZtLqEvhodNEGGWbo
 9yyFfm0Xc3EEm/Rl9Iy5YcfMQbZfExYlOB4YjnCBBA1SZ1gCE9K1jKgPwl+Q7utcGJ1/
 T845FCbsQu9g1zN+AUDqhGqPRAxoUFwPUapfnU6Cr1QKfw60MBJ65Ar64cJLhj8hYsGS
 VyXkoO1eiBNR2oLtNp/6Kphxuy8pQSpM1z2KymonCxpl2x+o2sdJCPMVOVKvqXQzciG+
 oe3g==
X-Gm-Message-State: AOJu0Yy8PeNTHn1clYwluqi3Kb5E6aDdLIHFxGJggl/1xa5St2WOP+is
 cF2RyGC3Spgzsq4+6FSN0plQ5QQ0hCM0Pm7g/REbHCct95A+9SF8JfVabPEB9/dskVB0aWki01q
 RJF4=
X-Google-Smtp-Source: AGHT+IE/nwbDUrHd9Xycjmq2cUxBLHPYlTEVvA0xXHGyHK10r+V4+f06BIXwdHnkQmUOKk+Y44YrnQ==
X-Received: by 2002:a17:906:b310:b0:a2c:298f:9057 with SMTP id
 n16-20020a170906b31000b00a2c298f9057mr837333ejz.68.1706280136147; 
 Fri, 26 Jan 2024 06:42:16 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 ox27-20020a170907101b00b00a3221b95ce8sm699168ejb.77.2024.01.26.06.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:42:15 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v1 1/3] hw/display/virtio-gpu.c: use reset_bh class method
Date: Fri, 26 Jan 2024 16:41:48 +0200
Message-Id: <947fcb0c386e77b5ef59f4a6ca48baeee0d1a980.1706279540.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While the VirtioGPU type has a reset_bh field to specify a reset
callback, it's never used. virtio_gpu_reset() calls the general
virtio_gpu_reset_bh() function for all devices that inherit from
VirtioGPU.

While no devices override reset_bh at the moment, a device reset might
require special logic for implementations in the future.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f8a675eb30..2b73ae585b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1515,7 +1515,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
             qemu_cond_wait_bql(&g->reset_cond);
         }
     } else {
-        virtio_gpu_reset_bh(g);
+        aio_bh_call(g->reset_bh);
     }
 
     while (!QTAILQ_EMPTY(&g->cmdq)) {
-- 
γαῖα πυρί μιχθήτω


