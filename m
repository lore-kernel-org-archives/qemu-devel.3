Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE81FD4F17
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01sD-00022n-4Q; Tue, 10 Mar 2026 14:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01sA-00022Q-Vi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:32:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01s9-0007hC-8V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:32:02 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a871daa98fso98608945ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773167519; x=1773772319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij/BbbSlxGP9JNf8FSJsHo5Km+Y3EWVXNZBcQXu31hs=;
 b=EJZ5iaJPgdmN4JAD1GuCgzLesnw0EvZnXfYT6XoHE49w/y4RcxhrbFqEGDbkhjmxY3
 a03c4clUNKQL5+G8EnhHc+jD2/oeMNHYiiHyAwGsctgUWtHJEc8y0SSEXb6alw/ydmNh
 tABS3GIcKLXyhcTIMQM17GqIw5o/P+S8TSNPA/7AchwULFDi5R1Mb69UXM0s4NdBqTZU
 BsjjQYFiSKaAU2Uc0moEidAZzNPi4AaIrdgh7MXq0HHEXswJC2DEvcMiiFi5ZOOUglTx
 /phCDBDOMd/VTfIK+awKOCkxDLT4RK/9Bc08FiTS24SYXjTcXpELoY8cGaVTCBzf8Dyp
 S5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773167519; x=1773772319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ij/BbbSlxGP9JNf8FSJsHo5Km+Y3EWVXNZBcQXu31hs=;
 b=lxSixEmSU1e0LLkajU3h+/8bQJdaLn3mm+IWp1I2qpc9bFli0VejOA0axA5wIQj03S
 /wJ+dmxD0Iq8NiwV43l4T69hnn/Em3BzoRRlkytQkbFWgWTVesUSZLL7L0btkFQrbQTu
 BEm/4p6XHxECsHZdO4EfuN1jKaHx6rlKhXuEcB5G2ZO2krPv5HuAlQSd8h0l8vNuw5uI
 lzUifPi5KafH4EGPWCRNUG4HwEUy2gPe20Prwq34lGBr/x/WGuTXA7+V+WmPgBrydUJ9
 AhpfOIzXU/8VOAquWQzNb0wKxIT9D9HTDY6zB9owDRt8RikKX0mqdwmVfHHKrHWPagBn
 wSpw==
X-Gm-Message-State: AOJu0Yz/p+dD3WZ00IHSrUQlEJdHDUMOp7i4AUP+0kG+eaZ9b0SOvruj
 9lnH+49HbEJAh/jxsjWZ8Hiny5KSVbR457uZ1ck1lBEzxvuoED0XRS2mE30VoLIAFOvsVQ==
X-Gm-Gg: ATEYQzzxVXGHzqtAGC085GLcO5mxjVpIxWlKs1bh8BjOMiJML/yrZiNQKTXgljeW9T7
 /DtBWtdmueV+3NUs9YG9iAf1qlUxCBEqKHwpWMrbC7KUTzbnQrgCyYCjia/WCK3zOb18ZeiYY7L
 clnMAs7p/y28V2QZMEiTXMQmEQ7cQ40B9T9woFIkhZ+UyWPnivTBlZX3bFzODTvr4kzeH94PdjW
 HL2z+DkxLm32dHr9D8eaBtoOOJ5fy249/5B60d9frV+oAmbgnTvbe0VhIardt9N3CAHJVPSyyEa
 NprqavM21LiImS6IOyKjNnnu/R2ykDD1PuK+faLp4MFn1Hn1I9+BuUkOXnEyB3XsacQZSKI9PeG
 SzRNzsmFeTcIbJE0D4udHImobxOd/ookSKSO318uaJOBJs95GGChcnWaQu6+f/s5ilrgfEnolyP
 fK/C8wd3/E2LN+ypIhB/R/avLZRUFaoI5IxJFz3MMephxZvQ==
X-Received: by 2002:a17:902:ce88:b0:2ae:593c:48fe with SMTP id
 d9443c01a7336-2ae823cb7d1mr159888145ad.13.1773167519401; 
 Tue, 10 Mar 2026 11:31:59 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840b2e9dsm209437015ad.85.2026.03.10.11.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:31:59 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 2/4] hw/core/loader: fix error handling for get_image_size
 callers
Date: Wed, 11 Mar 2026 01:27:58 +0700
Message-ID: <20260310182801.196443-3-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310182801.196443-1-viking4@gmail.com>
References: <20260310182801.196443-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x631.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check return value of get_image_size() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 hw/sparc/leon3.c       | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 012e2ee4fe..fd875491f5 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
             g_free(fru->data);
             fru->data = NULL;
         }
+    } else {
+        error_report("Could not get file size '%s'", fru->filename);
     }
 
 out:
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 9147d56bd4..c821dfd3bb 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -354,6 +354,11 @@ static void leon3_generic_hw_init(MachineState *machine)
     } else {
         bios_size = -1;
     }
+    if (bios_size < 0) {
+        error_report("could not found or failed to get file size: '%s'",
+                     filename);
+        exit(1);
+    }
 
     if (bios_size > prom_size) {
         error_report("could not load prom '%s': file too big", filename);
-- 
2.43.0


