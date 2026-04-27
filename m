Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7ACFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLU7-0006Ho-SH; Mon, 27 Apr 2026 08:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNm-00084I-EE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNg-0005f8-9I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso101472315e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294084; x=1777898884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WDavdCu+Xke+C7HS6Rur5ErMcRioXqigfD2Cj7+MUEs=;
 b=b9m6uQNwlK9iMEXk/NLxJW5LKyjwJAZr64+J6/L3gIUZSa2xj5/EwSgw9c9oQjs1iG
 7knzdxr085b0NMBnRODLaOP1RFF52awkeh+n3y2zgOvcmQxdu5VC6sfTeUSrAcmHE3xa
 /bUI8EEHLhF/BiLskxFmEMv9CtzA//WbnRDsACQMqY1B25ToFUX7fuvmeyy6f7BQ8w4d
 iFAE8EIfD765bN4/B7fJIBRYnMniJdbbPiX+ZiIqMFQEyn6LMcPf4zRCa+7xiKnO0iZQ
 8GSVbeMaZmS/iVfiW+D0S46ucWn1ZOIqSdG1bHOsVlj4ZRcDI0NFdrt02qGDuDZr5nbm
 5kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294084; x=1777898884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WDavdCu+Xke+C7HS6Rur5ErMcRioXqigfD2Cj7+MUEs=;
 b=MuErwJojgtm6GiLURIbyznFXCI5ngY1qg2TEVpAuY4qjO3IRg8g/8gBqLQIire9lX5
 oaHE+0wDxeVvzNDVmqXwStdunsXAeF5Mk/idfq9K7zGXRiSl3+Y/uur2zV7WgB1CRKxx
 ut9UZYFe31KIbkoqDJPsfu4urP7rl/4aYk1qSkasyt1F5wIveEzsXIySY5FDJt52XOr2
 /tXxNbsYoFmxA5bSSZpxglCucFhNjOgkNuDYB+LTIE7EE0vjEQ3ibk3Z1ZMH8BDGWwqM
 dWrtveADIscgic/lAeQkeTy2SaMCOr6soqGF2vd1yJR5HkZZO3qLqI4ELOtyWsc1nJ+g
 5yww==
X-Gm-Message-State: AOJu0YwYrJnGo2wfJICHISbJRTKVyCJ7N/8Y3GIyaFHwbBQBAB87DOnW
 Ee0D1r5NcmfKFmzwv5b4O3p8YwHI5S2k0zuOvUJZwk2OKE1hDsv0SUP04dBRhkfBxtEvYpEHv3m
 hREwG
X-Gm-Gg: AeBDiesHHnyAB+aFeh+JUQV9lncT+3iMAocpjddvlRsHYHPsq+ZexBFo6vq4fz25r/I
 2/jsvkZt24OEOXPduLnHgc0/Uq8wowqjY0p0aJuBcebPNE7hsHUWvS/Xsx8yMqeBvqkSWXD7s+I
 ozDlcm7wpo+eRQJ0j95YDF48srb9MmvyuIp21NvkcKaKn1Xki9OALe37kq9AsCsRNud+3Zx+bqp
 atuNthDMwMwJELFjGS4GNurtFbCYlgZldvLzUYQXWz8ueRHo73I44ff3UbaqaA9yxxsvjZ1ExUG
 Gq7Xcapm2Oz+sgeR5IVxUmg+aRbj12ELQ84uZYJXgY8guJGM6HjNfwKvN9cExyfpYf3iXgO/XfK
 DAtnQvwgPTQqQaxgE4PHRwlixQNgQ+MvafIclw/3+d2NgFzgyrJs3n9DCw4cKBBkCvZkbisXLsX
 hd/+fMbLRRSpAiimSTI+hJS4brjDd4XBXMUAeI4UuzLQYi0varLXeAt8XHdUrv2jj/BaVZP/fO+
 Xk77Y+15z5O/Sks7N7Duxgzjaq4hcGS8Sn+nziEXA==
X-Received: by 2002:a05:600c:c4ab:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488fb7864c3mr616732525e9.22.1777294083600; 
 Mon, 27 Apr 2026 05:48:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/63] hw/arm: Remove hw_error() for the unimplemented
 CM_LMBUSCNT register
Date: Mon, 27 Apr 2026 13:47:00 +0100
Message-ID: <20260427124738.966578-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
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

From: Thomas Huth <thuth@redhat.com>

When writing to this register, QEMU currently aborts:

 $ echo "readl 0x10000018" | ./qemu-system-arm -audiodev none,id=snd0 \
    -M integratorcp,accel=qtest,audiodev=snd0 -display none -qtest stdio
 [I 0.000000] OPENED
 [R +0.001907] readl 0x10000018
 qemu: hardware error: integratorcm_read: CM_LMBUSCNT
 [...]
 Aborted                    (core dumped)

This is bad, a guest should ideally never be able to kill QEMU like this.

Now, according to the "Intergrator/CP User Guide" from:

 https://developer.arm.com/documentation/dui0159/b/porting-integrator-ap-and-im-pd1/registers

 "The Integrator/AP CM_LMBUSCNT has been removed."

That means this register does not seem to be implemented on real CP boards
at all, only for older AP boards. Thus it should be fine if we simply
ignore this register in QEMU and handle it like all other unimplemented
registers in the "default" handler of the case statement.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3407
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260420064933.64765-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 03633f3d4f..164af03f7b 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -106,9 +106,6 @@ static uint64_t integratorcm_read(void *opaque, hwaddr offset,
         } else {
             return s->cm_lock;
         }
-    case 6: /* CM_LMBUSCNT */
-        /* ??? High frequency timer.  */
-        hw_error("integratorcm_read: CM_LMBUSCNT");
     case 7: /* CM_AUXOSC */
         return s->cm_auxosc;
     case 8: /* CM_SDRAM */
-- 
2.43.0


