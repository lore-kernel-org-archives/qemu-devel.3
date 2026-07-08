Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE4DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjh-0003L1-KF; Wed, 08 Jul 2026 10:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjf-0003CQ-8T
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjb-0002yT-I7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so4520965e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522724; x=1784127524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PTm0sLsjJBeFiHiE5l451U5rV2CAyhUncotlao7jQhQ=;
 b=LQ7PiyFJRNpzuU/ghuYsS3g4hWXIxhKbutyrohQjZ+Eo5nA/7n035kzvTjCWrY9qXn
 lWlM1lm5mb8w5ZPjFx0GG+dXWE4JqT4d1alEOF5HyrbIxi/ofl/TMwuO5VYUK6PU+wNh
 BCos3IQo6pqsc17NIUxmsGTBJMYnNLVNEhO21HNbkVnNnZHTOoitD//91yrKBJ56CLWe
 z4Gk2C+MoglptRGeC/IyTnnQA7e+jXPlzhakzVMR4YoDXBL4g+IgKnfBytavihWMJfv1
 wihG0LX3iHuHldO2UDQ7pLZeW07FAIN92P254JCSGi08YjSLDQgGvRuS9JoHmV0hW12X
 Nkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522724; x=1784127524;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PTm0sLsjJBeFiHiE5l451U5rV2CAyhUncotlao7jQhQ=;
 b=Lpgf+GnDI2IXhuMGdoB2ExJEzrlQVQB4R5pqetRp9UKKF0O5qzy25FtskCQ7A4ZVyy
 v9XjG9qFAiTAMs5QeAprXAlcX/RU1SeG9pHOeTAzTRLxVrpkKzh9HVtK4k1b+ShpFj/V
 jYA+feXkgj8ap6agRy9fdpAVUYyx+JE/6SqD5BjSOlIgUMtYvN9MozW7jTMhNywXjvCA
 65H95d+MSfv8T2YQJpruONBsv+rk7xWeahCslgI8hzMQu0Ccs8gDrjo+kx3sRKL45SVi
 P12Wc6dBkdU9dLOaATZaVq7SXFy7ahoLm5+ef8qynmJVVonJcM7Icow2I9o4yO3Q2HRF
 Smwg==
X-Gm-Message-State: AOJu0YzZSdeYc9MVAfwTToVoO4SSARx8uOFKj1gCrAS1jK1dZQJC2zJf
 FkWDq9A4HqHzUVsCb68nHS4UF46PJIOSJXtcwCOiQ7nPbxVck4lqiuy78IpHgAEll6A=
X-Gm-Gg: AfdE7cnxQEwQL66uqwG/pYIaEetFyBZuRq6TufxBAiXYBEa3dcmsKXKBXgrssiY3nHk
 wsdmGoACLQW/5DgPFcSqGOxQhCeA5lEHmWvhm7J8P4qpXtrrkR1bH+u+aVEwV6v/FEvcRjfo5fY
 0YND6LF77UYr/8ARoBnCqS2Dg7R2vpH5jVwLarJBkr8pdE7Zv0hLZVdbrroqZSF6gQauB0XGWMu
 /jwgHx45vdEtVLUJ10YPI5BG+0ErP4glaUQm7rfHfjFqMYIYHWFgAYHRVfijpSyPPBChoVhYI0O
 MV/QRbephy0FKEpc+IHEW0x/Y4scupqRrZAsGzLa5mUpGEnW24xKwkPWTKoJMuuAuE48PNy3uWj
 Kb2sbdvIvFdHil7vqdCEknd24YgoSVFCfEHHyGoRnn++UnR2d5dd5AuDODmsZ58aUKMP7mrbQoo
 BvWQJyf4NaQjGu
X-Received: by 2002:a05:600d:8443:10b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493e68e0d0cmr23399585e9.37.1783522723997; 
 Wed, 08 Jul 2026 07:58:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e54a25cfsm77596205e9.0.2026.07.08.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BF9A6004E;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/8] docs/system: document FEAT_Secure
Date: Wed,  8 Jul 2026 15:58:36 +0100
Message-ID: <20260708145841.3032079-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have had support for Secure state ever since the initial TrustZone
support.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index d19b6c04429..b751646e10e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -162,6 +162,7 @@ the following architecture extensions:
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
+- FEAT_Secure (Support for Secure state)
 - FEAT_SEL2 (Secure EL2)
 - FEAT_SHA1 (SHA1 instructions)
 - FEAT_SHA256 (SHA256 instructions)
-- 
2.47.3


