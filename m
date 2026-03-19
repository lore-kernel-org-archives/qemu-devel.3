Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D51088E66
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335t-0003jd-Pd; Wed, 18 Mar 2026 22:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335r-0003i5-DK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:39 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335o-0002r3-Ls
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:39 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79a51edef1fso24804477b3.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887191; x=1774491991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqOECBK48fd3/HOaVd+Lj39XqKiw8Mz+sralwGO6znk=;
 b=rdmBSyKIN6dqtCycNYee4/XxZlSvCHQx5amvwpBeZoPmC7qK7TsIDE7IvPal4ZRclk
 mOkjoC/L/oVTKrHhcM9d9YgZ+r59IE8TPVesZui3mxfdD6tQzvH7YfWNDLdTiy1PvzgP
 5+Ha0pi7+Q53cyA5EXnlRR/7v9QFs9hpHIjwgQpmB7CW6PSYBHs33J0HKhwJPsKyDk5T
 747O4VKDxQTTvF6SqJ5daocq0Gt4k72fK5PekEV2T8CWOFcNU1f99SOarrG+RumUDBzd
 lUBh4kZEz0iXp/goohLKV/Xb/OLglh6DM84xvmbXmj2no86JnKpeNx1d5lA9TtUIkqTJ
 VmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887191; x=1774491991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LqOECBK48fd3/HOaVd+Lj39XqKiw8Mz+sralwGO6znk=;
 b=QXsQ8w5CymolwQIGPjqJ3Dew2fnFxlU2kjzTBNienwKkjnakr71JuTP3fANPsPYBQi
 Kv0VyHHNsclq5l/jtvOM472sway7tvaWVYFnHbIWgwXEiAqvtfHNFKSUNQcrIMl1uRZJ
 29n7V5IUTuFeYqfSL+LCTJfXDfrTz2quWYFtDooQVuEPlU4bCAW05FfBxkPyk8q092OL
 pR6+w861Iuy+a088cdh0BFO/iceW5mhjc79T7I08lxXGJTUsDBymmeunBu/rHFqZUQDy
 o4o4TgetO0qTw031HefAfWkK3D42WOsS0ZBUtNmMTljimOFe5Uyj+10oGHUj7tqb+RNo
 /vnw==
X-Gm-Message-State: AOJu0YxVH7vJG1qhBVtZTHQW/C8fFJJjMobFbn82AZov0B27TDPYYT0x
 I4TxoQMeuO7MpdfYlM0JvYuDhi3ckXwj1s7I0UwXZcOBdreWUP6SzEVh16fYQqM7XiI/nFZbu57
 ubcOn76w=
X-Gm-Gg: ATEYQzymW33x92mAfL5FyyWXy9SonBqgimKE3naQgFet2znI2LAIQPmyhReyTkwvHT2
 7fdXK4rVU+og1Xkk25aXdIvNff94oJDHrSZw5RZRLA4POSEUFxYAJzIpXz3u5svAzsrn0iCz1e0
 z8CWBOKs3SO6wJ7TwZdJq/AbXyWClHssgwu6bPf7fzv9GW4ZNCWpZN0BrCrDL7ycKmuE5d+y4n2
 yDRfz2XoWX4qLsiBj/ej2VDCmsMelsAMKMwF0uQh18lSnAipGR88669DTJti+65vcHB2RB5lLSD
 5YfDgycyPIics70YsClKqRf30Sg7nmwzk40iNFxVFIRkEuoGRktPNsICh6gc2QMcp23RrllPPO4
 IuAJW73LBX5ke6IrNkL6054jwg1Fzogw5iq8kIka9lL4dahmJrRvDA8PvCj8csiPF2EwaAe6fWc
 NUMIJFwrz0EsfmXGgvtZcfJLRiJOX9bg==
X-Received: by 2002:a05:690c:91:b0:794:c02e:f617 with SMTP id
 00721157ae682-79a81a9018emr19109557b3.12.1773887191446; 
 Wed, 18 Mar 2026 19:26:31 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:31 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 2/7] target/cpu: Add two new address spaces for FEAT_MEC
Date: Wed, 18 Mar 2026 23:23:30 -0300
Message-Id: <20260319022335.22523-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319022335.22523-1-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x112e.google.com
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

Add two new address spaces for FEAT_MEC. One is used to store the
substitute encrypted page, which is returned instead of the actual
encrypted page in case of a MECID mismatch. The other is used to store
the MECIDs themselves, associated with physical addresses.

Signed-off-by: Gustavo Bueno <gustavo.romero@linaro.org>
---
 target/arm/cpu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..87c1787c9b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2364,7 +2364,9 @@ typedef enum ARMASIdx {
     ARMASIdx_S = 1,
     ARMASIdx_TagNS = 2,
     ARMASIdx_TagS = 3,
-    ARMASIdx_MAX = ARMASIdx_TagS
+    ARMASIdx_MEC = 4,
+    ARMASIdx_MEC_PAGE = 5,
+    ARMASIdx_MAX = ARMASIdx_MEC_PAGE
 } ARMASIdx;
 
 static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)
-- 
2.34.1


