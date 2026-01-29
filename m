Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05B0D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbN-0002Vj-Pw; Thu, 29 Jan 2026 11:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUav-00011b-GI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUat-00075r-Sk
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so12005095e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703006; x=1770307806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Ho/I25FOA6chejNv9Tw0n7zZKd605wODU6AjbZ1BZA=;
 b=Cs6tyMRaVsGVWry+40QdAaAtJ5WqPURp+3aMOD0xqVq6Zj77YceLead+uxXIE374iL
 pLJc9tsUxvqTRlUx+PMTvWCqSHRlXagHkQ9y3p4Bc5S5SdEJpZgxarfRckpHCM/4giIU
 qgc7ilYI0TJgRX+ONE3oUvx19hJlUs1J+VryhgqNkl3zGgtgVdhr4ZGI0Di5TbLGRoqR
 TQBlZx/S2/R7KTqsth/2lE2bZZkWDCEU8QzpEC6kEPGYF1cbDClqftWJPI7fYiU57Zkw
 +A1MqHOwejkVjcHqafqy5Wbh63ZUW7VUuKoKcaVX8KHtPV4MDVBN+Ihi+20k6Kcl1tqD
 fCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703006; x=1770307806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Ho/I25FOA6chejNv9Tw0n7zZKd605wODU6AjbZ1BZA=;
 b=Jr4Wp0HCfHTiHLK0jlz5OHR2U+LSx2fzREjjHV4fh2ACOeBPiOmK7IzoKxNXsu3df7
 3baBX/fRlAeCv+tIqGJFT03IJXbENXPfgStQ2fekKJE0DKNFZnE4qAHGHyFrCagssICc
 FrHevRpClNdAP/jX/14tGLSVlJY4kone5QmYV4qskBl59NCA2lhw5JpWT3f5ujzcmjmy
 105Ksoir8u4G4lhaEuoi2QHzy2wDkR2w/JOHSJiNgsztb7dV5BMEFworNB5GaPblAtXf
 gnHk2Fq19kuRcilEiRC8KTrb0wvgCWrM7oJL6r04ouJ5aLG8AKCfDIx4xk5/R2PZSGIj
 eliQ==
X-Gm-Message-State: AOJu0YwQy8pZiivG5xsvB5mklww2zU/h3tmVAm3ayjMTVZ6kDL6iL+EX
 AeKkHOC9Z7G4ENnahZppS7U2L7gnBb8/TmMqQyT9h3aM1xtROYF4KCojeeeponK8s4MSKFQ7PUM
 GiRhCNIE=
X-Gm-Gg: AZuq6aKY0oTKRXXWWvvfefBtVxKMqSmLo3yVsK5nDa4Zop+MtCqKy/URii2CeRUGm53
 UiaqZwl/R+/0tnGGuINv30+Th7o42WKjurwOhcCAXy+m67XDE0J4gOS2f/7gfdwt7XTV047g2Rb
 EMfgi7jwexLk5YuaDZYpnY3ZHMi9+gVI9T1v/K/0VXgairH/HbjI7imkJGCVoy9cpVjwP/7qr/D
 oS1vMb0PgOgNGuFHsnC5LbN/NFj8U/rU1Y8NJfCDgFHN7MEBY4FO61X6v21dAPU0/pabwA5cNw1
 TFy6C3hU5CChnuXu3GXvrJ88kOXPkZhMEoOkm8nWx0KTB7akerKDc9azZdoyRFIla3GGUhF5xfr
 fjynUPT9u7+OCJHCDf2nvwLZyswhd1ZoKUyKiF5MrdUp97zKC37Ny55dii3TZAGEDCpvJfT1Gbf
 aGlM+wIE08SBAOwjZV2pk3tOsDrscBww==
X-Received: by 2002:a05:6000:420d:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-435f3aba02dmr140492f8f.58.1769703006289; 
 Thu, 29 Jan 2026 08:10:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/43] MAINTAINERS: add emulation.rst to ARM TCG CPUs
Date: Thu, 29 Jan 2026 16:09:14 +0000
Message-ID: <20260129160917.1415092-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is updated as Arm architectural features are added so we should
catch changes to the docs as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260127145928.3073826-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dccdf47888..9b7ed4fccb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,6 +213,7 @@ F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
 F: docs/system/target-arm.rst
 F: docs/system/arm/cpu-features.rst
+F: docs/system/arm/emulation.rst
 F: gdb-xml/arm*.xml
 F: gdb-xml/aarch64*.xml
 
-- 
2.43.0


