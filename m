Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D252E83838
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cq-0001pL-7W; Mon, 16 Feb 2026 16:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6C6-0008Cp-Je
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6C4-00040S-VC
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-481188b7760so30183165e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277506; x=1771882306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8hcPS7BagBRSt3osrcB1v/gm3R+JU/H0mFRukwg/xU=;
 b=v7EGGmhYcA6yxdtLguHa7FM1Jh/kplUFLJWbPtS7YVzuBYNcC9pZ2D5IOBilJsHRw7
 Qst2hGGz2Byra/9zurDk+QJeYn751KwMo3g25IBRXTapa8ygOJUPch5ZTX7vBtjjlINe
 b/+jVZYrtKwNAZtrcoo00NzRZRS58faWG1XB11Es+1jV+FVa1fCah8B9DrrJOws/QsAa
 6Ew+VJ+uBrH6gMJEEhe31Os5e5XmbKpFRwkvTB+ZCl8zALBg283jmG8ISWx+g4W8Vs+3
 gH0hn2ULum5O1Zt/m4r7bnPAOXcuN1NOiFcAe2U6vONz9NG0I5M9QJXjZb4i6V6sbknl
 XN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277506; x=1771882306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8hcPS7BagBRSt3osrcB1v/gm3R+JU/H0mFRukwg/xU=;
 b=X9Nx+O/d0WLfPi5GYHSbevPP+YTdzHDGK7ldmWFSh1wKJZyl0L9OBlvKZ7GLwMkNrU
 KDpzVSEL+EoBnnKZBa3jFOrmmPhbMiVpnhYx9eZWGrOLtazOvB7v9S8fEDPWoVALrN77
 8Bw2+XjZCsgi1TS4IGUEu/Q/HoXzXP8H6XuIf+DvuDnYoFfAW3Y1oTNuHndgSptLk7Db
 Gt7S8IoikuOELk7Ow5rtVE4URY62d72SV/Bzbr+aEVb2IyuG4NI2sH5XKsPLbFk6maKD
 U7KPukie1P1kyBn/kxo+0418HqU3tk5kP3eL+OzAg113wtQ/lHzJBN69wNJq4+d+w9ea
 zH7Q==
X-Gm-Message-State: AOJu0Yzv1QyizY57C+NGhiGI04p+5DpV1OJhTQDOKMxQFPZk/ENWxSWw
 qU2vAP8C24xcdS+/EFfKYPxY2NMFLSX/VozYpfoNB8yMA5GwjAQZaAhp2PI/g6UzaUde1hFCw3U
 wXeFeAas=
X-Gm-Gg: AZuq6aIyj8amuWfgmPokI6qVyeCeyrTCx3DI0D7i34ECMniQw2zImdkND+O4lqni3n2
 UK2q/xjWgx+Y3WvFSWrbM1e4eZqSdSno0BbSanePVlLaipIQxvaXC9/KVa1Zdry4GLfWkPu51wv
 hn7VHr66tJDceS4cKvhemkqTkbMHIItJNLSGGRLXul6407d6BE6PTAcM5wSwu86iVnb1cywBLyY
 Z4ZQYLglcyLsiEsWwCBKtCSnT5EDR7Ne6Gf9EMBE9HatyJlCKteggPrzOyGS68HwvLXlo5ws00J
 KneG4UWaLhGdEdnlxZryqRmS2ipcQ4p7G3qfbpTtKsVrAkllBvfLVOzNFOJFoIaDNfe8G+N/IWC
 gS4czwmiDJULw15sRRda+offgvmmVfHqLbei7OyGOSjOlkLSBQoBRSVLpA5D78nS8dZLJ4y9leO
 0o0gZl8w1kn3OnuLH5XvH6rabhf04KcTOD59eK6yD3EXbd441/bZwaJB1p5muEqxq6KP0RrvRsY
 exiHFEFXv4=
X-Received: by 2002:a05:600c:a43:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-48373a07a59mr192480255e9.13.1771277506110; 
 Mon, 16 Feb 2026 13:31:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d78cfsm706462525e9.1.2026.02.16.13.31.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:31:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] hw/m68k/q800: Use MacFbMode fields in
 q800_machine_init()
Date: Mon, 16 Feb 2026 22:31:16 +0100
Message-ID: <20260216213121.47122-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Once the Mac Frame Buffer device is realized on the NuBus,
its MacFbMode might be different of the global graphic_depth
and graphic_width globals. Prefer the device MacFbMode fields
to initialize the BootInfo structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4767eb4298f..b55c03a90bf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -605,9 +605,9 @@ static void q800_machine_init(MachineState *machine)
         BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
         BOOTINFO1(param_ptr, BI_MAC_VADDR,
                   VIDEO_BASE + macfb_mode->offset);
-        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, graphic_depth);
+        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, macfb_mode->depth);
         BOOTINFO1(param_ptr, BI_MAC_VDIM,
-                  (graphic_height << 16) | graphic_width);
+                  (graphic_height << 16) | macfb_mode->width);
         BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
         BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);
 
-- 
2.52.0


