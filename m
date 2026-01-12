Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CABCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQlg-0002ds-V7; Mon, 12 Jan 2026 17:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlO-0002VT-Ly
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlN-00038r-3d
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so47502845e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258311; x=1768863111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/u9V1kI0nm3QQUayqhkrs7oiAPbGF5m4dMySBaGVkrs=;
 b=d9ospdSgy+D5F4xjXLO7j0dmstlbi9bvTgYGJZkuu0QqzReLtTOJZmxU4kp+Csy/Le
 9Zesfi9jPegpsaDv5D5RrWsfB0h9ObhXbwHwATGyvFVnYU1K+wewFKW8Jsop6rQLib9f
 YkQJ7hRx1bjEqmv/xyEuhw9pV8Kh3ZxdUIwSnUj2WLodj3Zs3ObhFlVV55UqYMOgN1nN
 i+Lcvc5CN4U/evSLN6Bd+MwHsTpsaYQWVSPWq0SBQSgfrHdff53r0GFaOHdujd5LMSwF
 DF4hAnOFfgXYM8UIXnWDgICwe8LD0lUImcbM2y5SgpUGwoW5mxeclk4axBia3v9y87VW
 PsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258311; x=1768863111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/u9V1kI0nm3QQUayqhkrs7oiAPbGF5m4dMySBaGVkrs=;
 b=JdxkWQ21YeoeHKK04TLo/AUmQWSm9pfBzMiiZ/XmEbkX/3SILPkcMkIzkrcYb0kpU7
 tT0FEGBopQcW5P5Un558VPxnRgXKkXXmiD+zSXeVp81/UXi29sVOVdlcyWeElTiRp1Xn
 jj+hJy4UHUzuzB5LNmD7JJjB7uXS6q6bf9OODm02T6sZnD9saWKOBOvRHy3lJ4vJZ4e5
 GsWSkIPt0HlPJp224mMmFBIrafQZ1uIWWE6Zo3dbCfcwP/q4ID5ivyzgU0T1nwSpOJve
 MbfZRCm0uerDszt8KkBiZsVGaXObMPptDtCUO2uzNnhYZhxGaFuFiBSCcD4UixLSq1z4
 B3mA==
X-Gm-Message-State: AOJu0Yx/up5qbgKmle2QPnEBf0DZtXqvkG3q6zPwxju29Wk0C35iY327
 owBqaAYwE7WaQjdqqJa3oqW+UI5UdrCEdtYz5cpxTSwchVAUMsSlgoMRjY9YKCAKbemVQrVOrJh
 KXQYjfiA=
X-Gm-Gg: AY/fxX4+Bjeh407Cm6M68KdFomYQCraRgaF/BfhrjLrqyrwXKYvuL9jPZsBBqPAHjY2
 01k/QMmSMaiPo1zpnmrFd2GoyrH2IYJud847oy95HfgidhBU6tg7oA3wgHPyGPoj9ljQpdoPf6y
 YkUuK8elRDtRxy2fo6sHUHklNNbHuAwX36nVHB1ztoQbNXHMuVca37IfSU6guG2Uj/bU+LOrApg
 EVuC3LuJbkcBsiG0GKm+LZXO1BViIdUqcOmyORA27SUte+UUnzQGFoByw3yBLzkiviliPW2TWDW
 s6wGEIgfaLXRLNr/HCm853Tnix2eqfgaj1qW2ptZh957yf0u74SL11OJn8s9dxHfIFj8H6+vVfS
 bMpcE7he3NHroJIWqMicqD2Rap4fd275MSZD5Ho0Cr4J4KHczCjRM4wCMp37oQQNWdnqbnGVm9Y
 sBX6iTY+Lef1C9ns6lxGSQmSyKlFIHGSnwHV2yRWPK4LJDHHL4xoo58fMNjW4iNzvjFOb/udY=
X-Google-Smtp-Source: AGHT+IHF46zCrE+hb9CLKqBnpQlGGEwurDrsXunE5VdGyF8IgMi6Nz3pzlvEk+FYflCDqf8GhQAa1g==
X-Received: by 2002:a5d:5f53:0:b0:42f:b649:6dc9 with SMTP id
 ffacd0b85a97d-432c37c3338mr23578462f8f.58.1768258311242; 
 Mon, 12 Jan 2026 14:51:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df90dsm40999886f8f.20.2026.01.12.14.51.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/61] hw/loongarch: Use explicit little-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:20 +0100
Message-ID: <20260112224857.42068-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The LoongArch architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/loongarch/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20251224161456.89707-2-philmd@linaro.org>
---
 hw/loongarch/virt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2580ab37b63..7c138818856 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -740,9 +740,9 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             lvms->misc_status |= BIT_ULL(IOCSRM_DMSI_EN);
         }
 
-        features = address_space_ldl(&lvms->as_iocsr,
-                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                                     attrs, NULL);
+        features = address_space_ldl_le(&lvms->as_iocsr,
+                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                        attrs, NULL);
         if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
             features |= BIT(EXTIOI_ENABLE);
         }
@@ -750,9 +750,9 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             features |= BIT(EXTIOI_ENABLE_INT_ENCODE);
         }
 
-        address_space_stl(&lvms->as_iocsr,
-                          EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                          features, attrs, NULL);
+        address_space_stl_le(&lvms->as_iocsr,
+                             EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                             features, attrs, NULL);
         break;
     default:
         g_assert_not_reached();
@@ -798,9 +798,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
             break;
         }
 
-        features = address_space_ldl(&lvms->as_iocsr,
-                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                                     attrs, NULL);
+        features = address_space_ldl_le(&lvms->as_iocsr,
+                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                        attrs, NULL);
         if (features & BIT(EXTIOI_ENABLE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
         }
-- 
2.52.0


