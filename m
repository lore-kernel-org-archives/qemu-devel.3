Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57820CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoa-0005UT-OC; Tue, 02 Sep 2025 09:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoX-00056j-P7
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoP-0004eQ-0c
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b7c56a987so17031615e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818752; x=1757423552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/tTBgokLUFCA34wn8/8NwWIbze6CCk78qIDAuN+F+4Q=;
 b=y+Ge5uqd1YX1VqCpWHkLNqGGLqc3hsyYRgqkJV/jS3Gli/7fyC86ChN2E1vKmFDBPV
 byGGnxpf9GwZ86mZ9iLxpb0BOc9dx7SPsIvbNRHesQAO0EbpF9gEBNRLUVN1tWU3D8el
 rXtvDHM2/FlnaJTMwv1uaoLEPshFIA2C8IStL+w5CkLpFhyDSNPC9CchPCKFD9D4QPdz
 LxAV8Th0zmTKoDIK325XvX05eqtDo8eN1iHE0aCaQ/nEurpNB1j6wspW7naLUhxpMSyt
 WalCwgxZcvqEP8RAjMv+rzRFllPD8yT9WCqm4snaXIelrlWSyT755V2/tj+wDWc3O4Xr
 cxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818752; x=1757423552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tTBgokLUFCA34wn8/8NwWIbze6CCk78qIDAuN+F+4Q=;
 b=HCsNZvPyuwZmTLImYwUez+sGUKQ3vBttEpbfM0Lcoq4XEYRv7/CmwOlSzN6FlMckPW
 lLJ6yFmibwBZCTv6DY90TXtwzJg6Ne9E/TehlR75AI8A3Ud6BrzxHd6+WsnNg88AvSeg
 /KCdQZy2H1rO02qekdB7aWM2n+z3WB/SOGPLYMuR4pe4z4cxM+OFIATVR44+y+rOvJjE
 pYPD923arRtiE+IermDHdxhEBETA9vG1GqxgWX80FAyslUYxogYYZHEIAix1Cv6HBgVX
 ilnmaDv0raYIize/io4uqRbjzPJrpEWPhwOiIhSQR8w5v2g9lcW6Aewj67kbZ4LdPmkC
 cGTw==
X-Gm-Message-State: AOJu0Yzm3qUO8J3R0k2x0mW3Zd6M0S7VGfK7EpBpcU/SuwVqnDYB24Kx
 +/aQPfTih30sqGKxKoh5IEy+67xRezMNoBzjLkU79vGpqjysZLkpKv2OxoKQ4VLhyVbUq28i7Bo
 lF2fD
X-Gm-Gg: ASbGncuSYYLLHdjg7rC66HaRjP5pVWXLGG41NZenCRzGpPrt3a5FmPESrpRreYgr/uR
 rTCoBhvHw8oYv4LvilIxGz9s1xyMsCkxpWl+UyguNE5gyHC2SZ3V4QdPdeHP25y+8bCnBlGJ9ER
 A/AHdBDRQ8TverAflepRCAtCyd/pKbZnI3jEqKSkSeLlz3HGWVFBGnXSuiyKbPwUJRuHNOM4H0/
 K+tPjt6G1gpgrHYHNUec7L8Al2d89746BCIyhTVnjjm6UQrEDxNwkOuSA8qwLEgWvsu1vi6C/OC
 fT5BcqfAImrOMn9YyhlxmyoNYTifrhClzCKVCqmLQ2FRSK1U5369myhgoiKUx/xnPAchlvJIsOj
 HaiVvo3L794a/RzN5SpIQ3a/c69PTvCt7Vo/v1PvXU6EFUiUHxn9qz66mdLpYNUUci+DA0CPW
X-Google-Smtp-Source: AGHT+IF4szdYYcE7KGURIilZU09UIvFaAXdncnUJP0o6T+7NPGetZbThP9l6y38TU6udFeoufI5bcw==
X-Received: by 2002:a05:600c:1f84:b0:45b:7ce0:fb8a with SMTP id
 5b1f17b1804b1-45b8559bd2fmr93543915e9.35.1756818752134; 
 Tue, 02 Sep 2025 06:12:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d2250115fdsm14225976f8f.40.2025.09.02.06.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/39] hw/sd/sdcard: Fix size check for backing block image
Date: Tue,  2 Sep 2025 15:10:06 +0200
Message-ID: <20250902131016.84968-30-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

The power-of-2 rule applies to the user data area, not the complete
block image. The latter can be concatenation of boot partition images
and the user data.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <0d95cffa6131a06404f3cd6ef5951720ce01c37e.1756019920.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8b142e4796f..7038a140a28 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2781,7 +2781,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk);
+        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
         if (blk_size > 0 && !is_power_of_2(blk_size)) {
             int64_t blk_size_aligned = pow2ceil(blk_size);
             char *blk_size_str;
-- 
2.51.0


