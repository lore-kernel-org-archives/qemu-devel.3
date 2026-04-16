Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90557F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrm-000620-By; Thu, 16 Apr 2026 05:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqd-0005H4-Js
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqb-0007n6-AJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so55275545e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331036; x=1776935836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jZkKdHqCTZ+oag6vibvyhQL+Cty3Vox88AzHxFpH2tY=;
 b=xmXqc5ledfULAppYvKfOQH5rBA/lxT2KEZ+A0n8MHsfMjgHuxUUwGPz5MIphpdulw6
 nHpqfAIboKlQ0cozBttb/2C2RM2xm6oZ88EWjDi1VX7vam5Vtz0s1LS1V1ihZgyQuSdX
 vAxpUkRXXzyigRHMBrM5Kld5Mg2934DRUP7wLftu/mMe/yhtjX2mzAZYmFlPPPDV11O/
 IYCUMmDSL71v6+fJx22mY25PWglWgRGy61GLrC8Bk0IWCqEZ5Q9ekhRKEO3CzKfOeMB0
 TktJtOirSimzpYKRWEyqqQdGEjdfPPK3xdXILSyOZn2+YnEs7b2dpLsqIJ/KrWRZ3MhR
 a2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331036; x=1776935836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jZkKdHqCTZ+oag6vibvyhQL+Cty3Vox88AzHxFpH2tY=;
 b=fxzaKyO8d7+lriWpMstsV/YRvsxC+fWH8C8nHSM7LFAKqqaQo1NYw3sqXeRLdrbCRT
 cU3Z+Dwe4cpc4t0MZcKqzLM2zduPAF6L6ja12BoHHe2J/N5uvgrptT0f3tsrlTG4z06Q
 B/QNR/6EkE2tSzafcq0JF68mGiM1HJEXrdEVGEcXPBjh89cmYf0mrpow9ZTtEtxqxQR4
 ek0nIbmLlGQr0cOTgUqYZkueiI4bfqls2pG7O2vCgw19RmCC6iqGbis31xKpEqzAvi8i
 6prNtU0lNSww/SY42g+ehQZqH9lKna62J18KCHTbBppoBKSLy2I24qrSmR6nxB/mpl6b
 4Ykg==
X-Gm-Message-State: AOJu0YxEfVi0Kkz76Ipw41lzK6HcEeUNIwfSPA7bC4WAibhYwyc2KoZg
 cfwJDkx6HHbM5vunGzBGKli8T14VjY4jZDCwweDGtQ4PAlU5opVsh28+5qfV6bnvpXgAjGpjXnP
 j3mL2VAE=
X-Gm-Gg: AeBDies5Gv939c6MTV3yym5K4Ws3HCS5CIr9wh66WzUSwyw0eFwONGJa3MV+kWONOgg
 L4TJY0jU4MzrAOJg5ZKpDrm+buRjilbwksbX84l68UPM+8XPWn7TUbhrYtkyNMuvZ7/omqu6ycY
 VFplJrMBVvnYoQtLJDlhVIId265igj73lj3h3Um1WeAXRm5ru4kOuvoA3Sxnl/YKT54k3E1O8c2
 V3N0FflrKPm0BPc5fo6LqH6f1wJSNCu6S6C/Rj2QQGJC+EE1dSGth8JauYkb3jiHl/dNpxmOCkl
 7iDx/fFKHb1jA+gkvD9FZIUOP0O611z9O7k18kZAtRcnzTzBANVstPjpRZaDu2FPy+TD6TCEnIc
 /GL+/qMQJiXtOUcK7h8/QXh8mWGoNwPXBqoSbv8H2kK/wP8Y/dCDAA7w5ZeP7CT7QJb5+hXqBIB
 MRv9iuXKdL+cH7MKllugs6rwmlytwAIk6/i2R/WDvICbiXKZGfYXqEMKBliT4E2AtoyVGxMatPQ
 OVYiqNjLQ/NPK4NR6C/hsp2IlDHFUVUMEF8b0MMynD0tFyF7VXo
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id
 5b1f17b1804b1-488d6ad17e6mr332512335e9.29.1776331035650; 
 Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/28] MAINTAINERS: Remove Luigi Rizzo
Date: Thu, 16 Apr 2026 10:16:45 +0100
Message-ID: <20260416091654.316158-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Luigi Rizzo has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fae251a642..375e3e111c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3412,7 +3412,6 @@ T: git https://github.com/jasowang/qemu.git net
 F: qapi/net.json
 
 Netmap network backend
-M: Luigi Rizzo <rizzo@iet.unipi.it>
 M: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
 M: Vincenzo Maffione <v.maffione@gmail.com>
 W: http://info.iet.unipi.it/~luigi/netmap/
-- 
2.43.0


