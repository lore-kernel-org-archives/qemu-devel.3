Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3D81075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38lX-0006T3-Oa; Thu, 19 Mar 2026 04:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w38lW-0006Sg-07
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w38lU-00005I-Dl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so417621f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773908998; x=1774513798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jg1Ac/W6rLVfHyVE5FH13fCwEpFUB9bueqclq2Ybdqg=;
 b=xW7fhnpo8/3vE7BaxWv7KzfsUV4igiwjjOrrZ450kd5jfJC+3xdekSKJ0uRPI1oFOj
 ZrMT1XClgvSB/OisDWX/4DFBpAGhB0i/N40H0BYqa9AAmxsD1wShngnnFJCPL96LDjo/
 ORRKrftkVOgqiwJkHJKQ3Z4PVEmx6WfXLRSBJLBbZG0Q2jqInxt1Qj+d3bA5nxgKMymP
 IhDrMY6ysCpnNdxgP+c7FwvqhUHyO/F0Xr5Ch5Nksrf0hy3GTPdS3x0ek0DzgJImVzC2
 GO+om7ci2v5rNQFRaAXoPqE1nQvHglpGOl2KEYGg/iD2Qcw4oIsXz0PbGbYVkWdLp2/p
 R9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773908998; x=1774513798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jg1Ac/W6rLVfHyVE5FH13fCwEpFUB9bueqclq2Ybdqg=;
 b=dD0D7u2GAc5CytRRuaZ0lnMhYo5MInAZJ8396en0lkzzJ8nFAxd/huB1VPdT8C5Dvt
 0mbSFXE4sktKz5FwWwicRpzqRk1aQoCGMwHBVGJcpJe3Biir6KwpqTnylLQiUEqOygos
 2nRwfFVlnDzWaASe08PLfgSa2meIW+nq1bQQOgZW9/Erpd/kgKQ/pMNlBfxGZWPPYdXc
 QY+Q4681XTBr63O5t9yfG/h+ATiDu6tMQL3OHPghwWL9XqMQNL9C06bzgmxcuZNDA4PU
 O2WoCItRakA2BCb+C7odALR9bEP7uU5CI02t5yO7HxIX/9URNKC9fTF1i0AlCU5nNIiT
 ANaw==
X-Gm-Message-State: AOJu0YxvZvNob6CL18FE2UhkswIQ/+PcvF/jjQeasdxqKLZ7Dwp0Tf/t
 Z4pt4mnzylopMqw1V25iYEovjwTOt5w0d7bXhrHa04I+l9RiVL8bP9qA8+60wd9ReFYmQzEIU+f
 erCDEtOA=
X-Gm-Gg: ATEYQzzXNvcv96IAvtnUtIGzC7YAb8dBMB+lTanAH3C0lGF48SugFcKZWO7vIsgoHnL
 oXtnj1MBOLKsl9fuSNkySig+7tBSuc8bSszyLcBRkYyiAKPhyp1EWlCSA+GlKg3TYPQGgH20Aw6
 DcPem88ZLQhP5EicFr8Q/RRNIZdiMavhbSMOH2xnF6Z6nXQ0OAMUaWAZjIv1rdQEZe4zbrE5F50
 JrwLjyP3mvulOiEi+HhDQRzf/cnIse29FQYxOha6ApeQ6eItxyhLNnbXYOMJud8XPuA9s0p6MwX
 GksJaglKaWsRoXPVw6IuKisEwrbMC9HVYaAsC1U3Zn9eGhrlFey97ozd3HRE6/bm0n543Hjx8Nd
 eIBUnkg8n+2BGzRu+wCkEhidPbNpu4uD/MWa1jYFKpmOp0SbX0vHeFdWVvQ5ZySkXoaIpj6HoqR
 ILIdydoPXL70KSDDJZi47CI3q55KwASGibeHqTc0nw1K6nuYIhc6v++dZWZLri4zH9El305zUi/
 UBkWnR+xU0=
X-Received: by 2002:a05:6000:608:b0:43b:40ef:5d1a with SMTP id
 ffacd0b85a97d-43b5279deaamr10354065f8f.5.1773908998235; 
 Thu, 19 Mar 2026 01:29:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892161sm15238798f8f.21.2026.03.19.01.29.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 01:29:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Ani Sinha <anisinha@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Roman Kagan <rvkagan@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/hyperv: Replace legacy ld_phys() -> address_space_ld()
Date: Thu, 19 Mar 2026 09:29:54 +0100
Message-ID: <20260319082954.65069-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Prefer the address_space_ld/st API over the legacy ld/st_phys()
because it allow checking for bus access fault, which shouldn't
happen here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/hyperv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a8196..5a0e00892d8 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -704,13 +704,16 @@ uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
     EventFlagHandler *handler;
 
     if (unlikely(!fast)) {
+        MemTxResult result;
         hwaddr addr = param;
 
         if (addr & (__alignof__(addr) - 1)) {
             return HV_STATUS_INVALID_ALIGNMENT;
         }
 
-        param = ldq_phys(&address_space_memory, addr);
+        param = address_space_ldq_le(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
+        assert(result == MEMTX_OK);
     }
 
     /*
-- 
2.53.0


