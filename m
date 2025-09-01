Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCABCA1007
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut426-0002QN-2p; Mon, 01 Sep 2025 08:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut424-0002Ow-9F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:12 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut421-0004J3-OK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:12 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afede1b3d05so723587066b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731187; x=1757335987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FA62XwpQPyNmrR76Sl1OJ/pIEbglEP1qpDGBeqWAqWk=;
 b=LAEsZJf29nuE9grq7Vm1smIILMy9j42UFFx0ECvuOyxMA0/ko8zTOfQGdguISfYAFr
 gVgNlqJ7loZ3ZoeKot1KNmL57dm4Vw19ffipJGeRf5WIlVbs0SB0ENJ7L4tAd6Hhy4Tq
 w9esue1ZBQb5KGmXzbdpGEqpgpxSiKngexWQ3AoLMekrEZJa2hmvUtSspaf0DEie3M3g
 uKQRGM6pby+JDr4JfIJCasR+dzBZf83Sr07JiBjp3id+e5fwDNdtc/eyoROvnGphePds
 w5emen/eFhfcGwf8ibdMl5Dnciqwgu0eoCs6XeFEeeeOH8s56MfoHh0HO36VzPHymTaQ
 9kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731187; x=1757335987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FA62XwpQPyNmrR76Sl1OJ/pIEbglEP1qpDGBeqWAqWk=;
 b=ghEES5oRmvqNnxH4eWn8yQm8SNGosQVT/Uh8SC9RiettAlXRpPUv8+bKey0s4AQQE9
 6m2+RkBQkJ2iqbu42Hm6hYhUOz+5EbpWqry2FVxzATS1cjVaKybyl/PzcagoVjuirayE
 holj36mOGC9vaVo6gDbcS0XN96+A2R1lBDeHkH0fZtoT1P8xfhJMQoMAMeJqQaPp87iU
 u7wGohEUybZI/IEnY8VJy5MGwhkurSHFpwN6cK/72trfNw6z1szu9m5YfKKJP5Cluten
 2PsJOjcJyzmgEQpXhyTu+XuFyEu+rsJ9q447aDdcblcxBUrKOphdSj9h33mDjeA5ulOk
 Zsbg==
X-Gm-Message-State: AOJu0YxC30QWE2yUZJ6b5fWWkvFN+sVjfoO3GEpcwxn3lOpVlmpFEWkK
 dHDr9N3iofMAPNZJCz9iYSErn6k8G4lZLfVeoAGNUr3vCfr6pi7U0VtPfqyX3gScnVM=
X-Gm-Gg: ASbGncvc64B3ClhH2NEmywuasvwjHAJ+CtUhFQ6pmLJyog0JYuC/7/1Mer/M0RLSCft
 tGmiFGxE42ztjz+uNl4w4mcV+xsiOUlOXmITDzvW6aZyi8hvv8gHedC1Jc9moN46DfpyeHQOylq
 Ftrx6XY1b8UJk6q3IloyLxJhDmysbdEi57anOQUU9Cs12+8E1QP/GnW2o1VtrhY2a7JnPlSVtFq
 cm2JMsph3gMuUKKcQOgL28jBIVeSYvuBvcu1xQuXjf56Spgv4IdnuVo3CL6SvBFduAD4TVFVRl6
 I7yzDs8VkJ6mPu1RmB0fF0MIEM8O5hAd7B/SUrdyPEX1mCUkCzzYtz1TjoJqnEo3dnG9AcBl86L
 BxavlSKAAcBLDY2phcYMRQjln1t4QPM1U9A==
X-Google-Smtp-Source: AGHT+IGMBxwB/DKnr6fY8T1v5bK6K6ol72OuQXuqtTuwPjbzA5oRGLscHORewCaINkYKGrNDehzR9A==
X-Received: by 2002:a17:907:2da2:b0:b04:36e3:c07c with SMTP id
 a640c23a62f3a-b0436e3c5d3mr220300166b.33.1756731187351; 
 Mon, 01 Sep 2025 05:53:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0432937e0esm190990766b.3.2025.09.01.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:53:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F40EF5F7F5;
 Mon, 01 Sep 2025 13:53:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] arm_load_dtb cleanups
Date: Mon,  1 Sep 2025 13:53:00 +0100
Message-ID: <20250901125304.1047624-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

This was prompted by a slop PR that came in via github and while
looking at it I thought what arm_load_dtb really needed was to be
modernised to:

  - use autofree to avoid goto fail
  - use error_setg to report errors
  - use error_fatal rather than open coding exit()

Alex.

Alex Bennée (4):
  hw/arm: use g_autofree for filename in arm_load_dtb
  hw/arm: use g_autofree for fdt in arm_load_dtb
  hw/arm: use g_auto(GStrv) for node_path in arm_load_dtb
  hw/arm: expose Error * to arm_load_dtb

 include/hw/arm/boot.h |  3 +-
 hw/arm/boot.c         | 75 ++++++++++++++++++-------------------------
 hw/arm/virt.c         |  6 ++--
 3 files changed, 36 insertions(+), 48 deletions(-)

-- 
2.47.2


