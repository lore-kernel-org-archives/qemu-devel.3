Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDF8CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 04:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNO3m-0006Xn-Bd; Sun, 23 Nov 2025 23:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNO3j-0006WX-F4
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:20:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNO3i-00061N-0i
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:20:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso22861675e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 20:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763958012; x=1764562812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y+5DwZ4wA9wfJaYXx57jvRGMAi66RIV1WqcWNGLHWbY=;
 b=q4w5BI5ikXajkD7eOTJ45ili/j0ZuVBA5Duj/NFieJ6vPN5Ghs2ERoLa1n2I8SiD0s
 x7SM8dIBhekDZ46Y0d7osrQqbEy8Hv8vwn6YkxqRN2Ue+vqd7Lpg0dfbrvJ4Xy32/ZR9
 N3ljRh0iFfJilw9+I/qivwh3PSAlFZiDjwDQY50qkGb8WaF6oprAAH/BuekEqGnOiTdN
 BJ+nXrRSW6nhbXXr6YD07I2iXFrxnNg2wRtOCPI/h51lvxJqA83LhBAgj98T+hgeD5sw
 d0AYpkiNwfIO7bmAV/ZXM3KghCYHZLXoeKZTuegYpnl90GtZSMxhbx9coW3Z/279+d0z
 0McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763958012; x=1764562812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+5DwZ4wA9wfJaYXx57jvRGMAi66RIV1WqcWNGLHWbY=;
 b=QEV//7H2Zqo21P2T/8JVag/uuogSuxSNm8Y/gKuwIAU7+8u9klKFSc6kNWFhM4AP+q
 uW9egqSGN3WZ7sE7dmdtsuTSw0R1RT19sss/wlUv9Hq/xZyuQHIbWFGKslze8KF6vG1P
 NwRk8WAC+78WcaanN4QwbB9rX0R8nw+TBvhLws4IzmaScrTb77j6NWUB/klipfk9Z3AJ
 mNenAf6EpELjcidDgrZ7juqqmHWYgoHa0hLDU1uHhkIK7jswQqEYqhbn28IzWMy3oSk2
 lShlhK+sfVBQXnGQi4+5/RAP2+JyYSxBFDOmgZjaXIUH7RN53vO9PyEG/eZ90KdWywqC
 G2BQ==
X-Gm-Message-State: AOJu0YxzYIHcmIfgz3JTazRKEpMDGbguPkP7e4gTVn9B+n4Zq3CiNqUp
 rXInv++7CNN9XvT2npbS7Vp9TQL5rsPjl5SQ9wk4uxzqzqq0TzFLU2keWD/IvoNkCWtRzDLhUz1
 TrQUbXnYVvQ==
X-Gm-Gg: ASbGnctBCNRhX0Y9ugruNzZdNpgxrM/Wm1tu/+hxPdK6ma3NJps/OxHRbglEyQ1s69K
 HO8Om9DoqR8G1qaeYa8UNLWlgR/5Dt2o+V5Q8YiLSUTPUeK6YNIRLf81BS530WU6R8680Ohjl1L
 Zbl1AzAide9kEfTKoGEeFt2ZNhVHPHHw2+BxdVj2ID9WUyUaf/LSt/DVp3X0BGB45IcjcxNnjGU
 sGGUjTEmFGCJxMJDY8Os2HH3LYHmOK1JqkmsrvQR+zpsX7U4eQUNP++obSA6UkeJGPBdgWITVJf
 OL6MsW8hzTjHPf3+ZCSCQfQ5yeUkVnObPI/22LFbrIljRx0wX+e93N7qOmA7DXV6103Uzq0FYrc
 ckE8OKfUXu+iX3YgKSF1W6+CPvpn6goQ4b7axx8WEzlUNnaznrVls8NiOXji1n2S7I7ESuQ1TlL
 dQ6YiyDkMU0cvFKGwicmSBRzXVODWBgn7VDksBXf3Jx4LGPA/GOU05EuFrP3cy
X-Google-Smtp-Source: AGHT+IHWYvFlLxItwWnefl66526JOHRhxstGBIcl6xNJQYM/S+YfGVOirndLY3h0gTzqUzX/qAYNaw==
X-Received: by 2002:a05:600c:1914:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-477c112587fmr76757925e9.25.1763958011872; 
 Sun, 23 Nov 2025 20:20:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f3635bsm26086018f8f.17.2025.11.23.20.20.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Nov 2025 20:20:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Christian Speich <c.speich@avm.de>
Subject: [PATCH-for-10.2] hw/sd/sdcard: Correct SCR 'DATA_STAT_AFTER_ERASE' bit
Date: Mon, 24 Nov 2025 05:20:08 +0100
Message-ID: <20251124042008.55710-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

As a 'SD card vendor', QEMU chose to fill blocks with '1'
during erase operation. Update the DATA_STAT_AFTER_ERASE
SCR bit appropriately.

Fixes: 818a5cdcfcf ("hw/sd: sd: Actually perform the erase operation")
Reported-by: Christian Speich <c.speich@avm.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 40a75a43ffb..d35537702b2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -446,7 +446,7 @@ static void sd_set_scr(SDState *sd)
     /* reserved for manufacturer usage */
     sd->scr[4] = 0x00;
     sd->scr[5] = 0x00;
-    sd->scr[6] = 0x00;
+    sd->scr[6] = 1 << 7;        /* Data after an erase operation is 0xff */
     sd->scr[7] = 0x00;
 }
 
-- 
2.51.0


