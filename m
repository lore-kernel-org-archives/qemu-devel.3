Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509F6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFw-0005Cp-1Q; Tue, 14 Jan 2025 06:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFl-000580-PO
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFj-0005Ra-8x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:37 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab2c9b8aecaso730238966b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854714; x=1737459514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlXD5Sn0rYO8He0H7Rs2R6nW3maRKYRQpAyPaWSU1Fg=;
 b=DT5XKnNiTbagRvz2AfNXIKDJCesSBIlMVrsJIUF2lksMLXIgE2tBgejhzpUa5zq8pI
 3Sz0BNduv0HkL5BJ8kqSAzIklFK0fDxIPeo10d00V/49qnX2XrvIE1eNdn2hgp92Bd6w
 we69oBBgMMZFnfB86et12+ka5wA3W64b/5xFeGuVixPhbw0DKZZ6cK2r5wmCP3WaXHtl
 Bdof7pz+lE48w4kC7v8zqhIbNVq5b9e/nHHsuBMNwiFKMSWHbVgefXgPI0i7x5zPk/4i
 LNP5m2lo4gjKFQskF59w7+8a73keF2Mb8cAs9C5RKY/s8l19EMtSELFrCKdwbFiZvqN0
 Solg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854714; x=1737459514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlXD5Sn0rYO8He0H7Rs2R6nW3maRKYRQpAyPaWSU1Fg=;
 b=SHn+uYD+m6xdwG3oSgAUPxBuzDwX+SpJkiqeoCRTHWFPXUdkB9aW+H4VsR95IyHQYO
 lM9CCX0telKjIzvIh5pWTXOzxXPx49TLZMNvoQlIWKt15RtKWMrXZim2thcIjq3C36nJ
 L66q25LNEi0IO6UsLLMF15cZOEmppR00CznAKpT5ziq6gE4BAJT5KoHSv/Tc8t+Yx3WE
 Gvml69AQKlOdgI+pzWuGvMvhB+QDXIUsFQZlAUloLWaIpyEvWf8tu7Mk5Z+uTsGGHNmS
 R2shtsOXyR+ggqU6Pwv9wlJeeDRHzWiodQVYIG/SCdCnkXTcO/TM+kXqHE3Z2p+ZSIDA
 TLQw==
X-Gm-Message-State: AOJu0Ywy/aFJCwSK54qCJY71fayM8g4DIUYiXNHGou62f+daTinCyFJQ
 rlClXD4flfMJTTrdiDIEOwRSSwyc1Ow2CLZIVjjtT/ZR1e2CpoBZqLLXwb5b29o=
X-Gm-Gg: ASbGnctE71rvaBdaV1JxKG6zPdX5bjy845PsCko7hGPpFDm4Mq5VCOvc81EcSIilLiH
 aBSgmEvt7gl1pjXV4mfzc7eWcENG9mm6ok7oKCBpxmOt3otxcExdzEUxW3YRcPsXV0BtI4synhR
 Pr+X0QsUkxv0zcbSQJUoVJcvuItHaTZ8pIwT27DwqMB2Znpdna03psSehYrLGAi4T+jamRCvYB6
 GElcwR2lLCZK7b2StiE5as+nBXv2Q6Z6Yd1DU2HxQ/ToXcaczhDbn4=
X-Google-Smtp-Source: AGHT+IEBy8bjoh/36I4aHtq06zdHiLSEtZwkJxCXTE9OT2ll5fUc8X1vBuiaeJjMSV7U8VRnujaaHQ==
X-Received: by 2002:a17:907:96a5:b0:aa6:834b:d136 with SMTP id
 a640c23a62f3a-ab2ab5f93c4mr2470534666b.33.1736854713573; 
 Tue, 14 Jan 2025 03:38:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9649939sm614159066b.182.2025.01.14.03.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42B675FAA0;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 26/37] plugins: fix kdoc annotation
Date: Tue, 14 Jan 2025 11:38:10 +0000
Message-Id: <20250114113821.768750-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

The function is qemu_plugin_mem_get_value()

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 0fba36ae02..3a850aa216 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -583,7 +583,7 @@ QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
 /**
- * qemu_plugin_mem_get_mem_value() - return last value loaded/stored
+ * qemu_plugin_mem_get_value() - return last value loaded/stored
  * @info: opaque memory transaction handle
  *
  * Returns: memory value
-- 
2.39.5


