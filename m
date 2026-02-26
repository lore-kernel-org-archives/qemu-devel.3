Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626FBFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiM-0005KV-MH; Thu, 26 Feb 2026 10:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiL-0005K4-CW
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiJ-0003kG-Ti
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso20764275e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121342; x=1772726142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LsYSqkEXXlF+Uy+d5bpFXeCPh+P+Oz2hTTvj2JRd0F8=;
 b=ZiWZXj3FfDuU/EQkcVRvwMhOdpxfzYyjAkCY0Xj3ekNk6XHP9fzyvfn3XrWzac07BC
 ZT/tepd6YCeG2c+JMQ62ys8cY6TTVUdU+d8xgr8N3XYZuICIdc6XDiA4IiXQjXRFWkIB
 WYd4GlMzHo2OQIBIS+b9OHriE3p6GLjeaycZJNNjsSaUjGJi7+hQJ7UPCL9BjGrGtZbl
 UD8Kgg94tuDGVQv/828FsABGjms3FSvadbGtPeUtyp6Mzlp8PP8kkS2TnXCglaLE6/Bd
 o5YajccSyNEkM9ycAwY8cC/ngBXRsy1gmVNmGdJqq4a0M98GTw3I1XnWVc8tf73Q8is3
 yCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121342; x=1772726142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LsYSqkEXXlF+Uy+d5bpFXeCPh+P+Oz2hTTvj2JRd0F8=;
 b=BBq38IIinYtsShn/owgEbnB9mO1bcR4MdgaIRxG1YFBiT3EpgRvv/9Fuw1ajxwRTha
 J+6MfOD2GBy96PwUuXlNE10Gwbln10unmtO/4Oeit9qsV886eYO03ffIpkLcSl3unSBV
 2ag6Fj3Nqv8m2oWomMoVxhl5zp+2vmNGpwLLS6T46MQhqaE5seunnpGzcfmwu3BE2GgD
 8UIfjKzO59AgVCVXsKGynlYg49y+NrUoJhLRpOKO2AinLyDhm5/INLxuvQM3ORkNloUC
 5hIKK8I0u6Lv5ZB4ATKwKOImJJOFlWmkCvsKk9EfXqyX8tfYSBq3uT7PW+7bTmuZdsXp
 B5uA==
X-Gm-Message-State: AOJu0YzlWlphHuVKNMx/swaHwPRQUH+A3KhrnvumSUEuvQ80iVeBzR0d
 fM2C+avIxi2XLFrlX9EjA8XI5MTY0cDCrFiFeXiug5DgDdlSL83EYv1bokw5ebuMBqJfImqOOd8
 wAL4q
X-Gm-Gg: ATEYQzwIS1Ae1qLSpMsmgtUmagH8X9bUlIO/Qg5bIZiWRiZRkjPoHIL9mKolnZlyCVh
 azVXxnBPikou6bIItfgZ7cfgb/6XR47o3wnXU+TPXSzChI6Z1EvfufcJCSpBuJJK7NbACM9NRpp
 CbgBpsJ+SOgljZNJ1kuXWq+ipSEyOpS4ovmuVOaENn6NKOv4452I2NX3x8eaugdidkYB1p5QAZE
 WjPvBwmok/wEtpZUYTDO3BDxlsveQoRyJo7p2jn7zEGHjwexfAgyP0MDxUWZnSLRH7gMNnfZ5UE
 am3uGBO/py5fkrntlqQA0WL6ybDhtR03TDKxu2uzF50x+fgkyId7GyKmZ3jn+irg1QPGMdsxfEI
 WlNXreDQ6Uv4OHjgKuwbYIFpVLmEVGP8jNZEfPe9sHLudDm4+8JD0v4VV4KjW0WH3iBm5r0j6Qm
 miGASnsMcxAe1EornJjQggyl8SRg4a+HaYm2aAQWqy/d+HUhLbBZe9+PZ9NXDlXMm9WxiT2eoqt
 exUYpb3D+8VITXH2BaSGOpD5mfcryk=
X-Received: by 2002:a05:600c:8b71:b0:483:7ea3:3de3 with SMTP id
 5b1f17b1804b1-483c33c3606mr59317755e9.2.1772121342376; 
 Thu, 26 Feb 2026 07:55:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] hw/arm/virt: Update error message for bad gic-version
 option
Date: Thu, 26 Feb 2026 15:55:19 +0000
Message-ID: <20260226155535.1171290-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

As we added different valid gic-version option settings,
we forgot to update the hint in the error message produced
when the user specifies an invalid value:

$ qemu-system-aarch64 -M virt,help | grep gic-version
  gic-version=<string>   - Set GIC version. Valid values are 2, 3, 4, host and max
$ qemu-system-aarch64 -M virt,gic-version=bang
qemu-system-aarch64: Invalid gic-version value
Valid values are 3, 2, host, max.

Update the error string to match the one we use in the help text
for the option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260219110228.3804482-1-peter.maydell@linaro.org
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 81e700f516..cab2e21e8a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3001,7 +3001,7 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
+        error_append_hint(errp, "Valid values are 2, 3, 4, host, and max.\n");
     }
 }
 
-- 
2.43.0


