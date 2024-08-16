Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1550C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1Wq-0003vL-ET; Fri, 16 Aug 2024 14:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sezhc-0003FB-Tc
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:21:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sezha-0000Cc-DY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:21:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4281c164408so15196565e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723825279; x=1724430079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k2a8wZIm05R7plSdjrg5kNp3Tv6BG06tA1WKCBKzCKg=;
 b=V2qrImzkVdY0dvQh8ePIFGyqSU8KPWxMnZJ0ZQX3vzjFHHdh+lRKuyEBGZvX76JhcZ
 j0baQ6B9I5NtEPAcGwdFDv2QRYFytql5X58WTgVhEBZ/TtTkjqF3qmUqbt4vX7GrObs1
 LU6suQftjlwi+7odcjHikEaW/t+pgtm3ZfPsU/aEIdQDfFYa5Lx4KmOBUr6zr2lZQtn1
 9UY5a1RIBlsUM8gWuIouzjXeNYH/3Hc4QCTtdwt5dDyzIJ3dgqV08/qXVUxDR4J1yONF
 I/tZ2GtR/y/0nyxMbWQKYDsa252IXH2vFbXnOeIcwgMhhWbiWnyKV/g2kbjeQdp5AbmP
 ONvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723825279; x=1724430079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2a8wZIm05R7plSdjrg5kNp3Tv6BG06tA1WKCBKzCKg=;
 b=VrwJdFBILA0OMAAAa2YQ16UnkCYA638mdJf73tGWO9wisfPCFylocwA6LMqewYHtNl
 zQWhn8GuRi+y/G3KIad83/jso98Y1+hDDEFt6AQ3wJurijeOxpFiKU+lD69G1mj7LvnY
 HMBdWP6weyc1xMQ5amj5R/OqE3FFHJ/pey/QS6Ijvc+JyPIYT1rhkRAFe7sLcoYhrw46
 3vikVA5o6tugswbSxgSR0ERkqrf2NK0G2u6Tz+7CkV2rYu9G2xAi33rnjX1z5dLaXGRI
 /Xu6w0F5XBmVukzq99AiApCAJ7f5ox4mJ5qcVdvo3uQoDGDTIh4zWQDlMRIOJZW5+bdW
 ciSw==
X-Gm-Message-State: AOJu0YwIJ2bdg1OTuJp7D17GgAQVDPiMKKdSLU5q7v067VwwylGVRxVB
 lhIZsieUzdCTArOmNTUKtHR+FkRtbH1ulpH55cHd+T9PcWlv4nVKCMMvNRrluFU=
X-Google-Smtp-Source: AGHT+IEHkQJBNmQ+uAqGfdE9gIofSXMVrQkjaOMym65F9iVtPRWWxd4UJkaMEm55hr1S8c4/qFfrKg==
X-Received: by 2002:a05:600c:458b:b0:428:1663:2c2e with SMTP id
 5b1f17b1804b1-429ed7a6b76mr21603425e9.17.1723825278913; 
 Fri, 16 Aug 2024 09:21:18 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:4869:8e00:fd40:3d83:5141:6edb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded35991sm79966185e9.21.2024.08.16.09.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:21:18 -0700 (PDT)
From: Elisha Hollander <just4now666666@gmail.com>
To: qemu-devel@nongnu.org
Cc: Elisha Hollander <just4now666666@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/1] allow using a higher icount
Date: Fri, 16 Aug 2024 16:20:43 +0000
Message-Id: <20240816162044.5764-1-just4now666666@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=just4now666666@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:21 -0400
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

Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
---
 accel/tcg/cpu-exec.c      | 4 +---
 accel/tcg/icount-common.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8163295f34..4c2baf8ed4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
 static void print_delay(const SyncClocks *sc)
 {
     static float threshold_delay;
-    static int64_t last_realtime_clock;
     static int nb_prints;
 
     if (icount_align_option &&
-        sc->realtime_clock - last_realtime_clock >= MAX_DELAY_PRINT_RATE &&
+        sc->diff_clk >= MAX_DELAY_PRINT_RATE &&
         nb_prints < MAX_NB_PRINTS) {
         if ((-sc->diff_clk / (float)1000000000LL > threshold_delay) ||
             (-sc->diff_clk / (float)1000000000LL <
@@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
                         threshold_delay - 1,
                         threshold_delay);
             nb_prints++;
-            last_realtime_clock = sc->realtime_clock;
         }
     }
 }
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 8d3d3a7e9d..f07f8baf4d 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -46,8 +46,8 @@
  * is TCG-specific, and does not need to be built for other accels.
  */
 static bool icount_sleep = true;
-/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
-#define MAX_ICOUNT_SHIFT 10
+/* Arbitrarily pick the minimum allowable speed.  */
+#define MAX_ICOUNT_SHIFT 30
 
 /* Do not count executed instructions */
 ICountMode use_icount = ICOUNT_DISABLED;
-- 
2.30.2


