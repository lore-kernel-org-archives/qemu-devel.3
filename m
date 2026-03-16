Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA524F4644B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PO-0001b5-Q6; Mon, 16 Mar 2026 06:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PM-0001Up-NJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PL-0003gB-50
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso22531835e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657766; x=1774262566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VZ3XMUYm+uS9vWPU0VkmALluObtDZ3CULMv+l+51GP0=;
 b=cyZrNDyloPTOcLMVGSjHGWv6jisT3aV4R3bBM3ryIkZ20ob3n1Pa5pQXZSJJSmtqjc
 5vT9wVSvn4aLJQizVVwhq9ut6bEt34R0TIyJtzIYp+w1Wlo7uGmFubUZL2tHEOVnlnT+
 cQdydfpFTiyZhZz9ANJPmSvzHva8ru26av8wVDbJr1YtlxtUq+vf7aLRqatZC9sKf4hV
 xAVLZF37DPhUxcnobKm/I6DDsW4kP9lJiOQFD9hfE1gvgSwnRPSMnIRmL6WDwkj3qjAV
 hTLBP/YHKFzBSCZYL7kxbHN7YnioFHttnf9uJt36MBdxqVSzRQXhZWhwOYSHUNfC3S9z
 +mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657766; x=1774262566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VZ3XMUYm+uS9vWPU0VkmALluObtDZ3CULMv+l+51GP0=;
 b=YbRDCK1K91Cdg4ewAkEMu64WL6AcdDsoI6uTn5NJnrhOAOCN5PMpmZViwP9AS/vqCi
 +bqtG6hu8JDCek24jkJc1LLqTWDOHzZRcpSV92ObJU4hpjI4xeiRF36BnJhcN6fRYXO/
 9mJPAyNMgtSDOuI3ennU4OPflVVKVsZS6QbLenFmzIyoWWE4aGUKZcF7Km4mn9I/VyoC
 EKq90ZvRMZktw3OfwvsMuBohhKYeo8lXZgjWX5NGvcpbFIy9xt1eJJwwNOmWsRHkiU/K
 VSabsp4ndMXgA1GQKju7HPyP3qVy8VO0t/07X7myPho/hb/JjugOEq57Z6HFGJAdkr03
 dPqg==
X-Gm-Message-State: AOJu0Yz58vo6AaHzC6cWXCtaDxEXF58X0aE8ROtdprrf1ZnWG2SqvNSY
 LzzWBtZhW8jNJTFcsiA98VfChyzsZ7DCAgvqWBmE+wYqgj3844y+ZYDkFA6QNb3cwMY3Jbw4VE0
 g6JEg
X-Gm-Gg: ATEYQzysO5IhzPzA3qKnMRn/hAFPVl02Y5ripnNwpVyAeFqVQdNy7tZTxnPdiVgc9pU
 KQ1yHqSH3I2rqU+RFxkZgYDdcYhMRllEtq1RWKjxR6gh7a3QSSRRNviLZPO+a31qecRBB7j3dNs
 sHcUP4X8gJr4WAfeTSLLexWZh59SdhyMuJ66eSDJgvgk2bhCx8cD9Y2uidfMKyyBtgHkGDQ7HM5
 8A73ImrhFf2NNk/J/q6PILf5ktVtXO7h/zBYGSBwhIoYMoFraPy8WrwTyj/4LdcY/PyKL7eZMui
 UQJBKuzO7BB4vBzzyb+1kKXdvC4agIdbJHwlWYa4zoFPdwSHnCQeDrlTZ4Qf4r7mhsbenjTT/BT
 WXKjPdsqTZLMvwr0cHqq4rj24OWIfycKlowetLCbGUuN+UqV39XHNZVWSYusybLuE7XDivQvUsc
 DvKtlDyLnaJudClkrKKWs8nlnc66/ilY83D2fzRmj3N9Uu3FcxZek3yrLOybYzi6b6jW3pFssbg
 +6xr9/yG30=
X-Received: by 2002:a05:600c:4e16:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-4855670cd92mr200885605e9.30.1773657765589; 
 Mon, 16 Mar 2026 03:42:45 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] MAINTAINERS: Remove Radoslaw Biernacki
Date: Mon, 16 Mar 2026 10:42:24 +0000
Message-ID: <20260316104230.836962-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Radoslaw Biernacki doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306120555.2035421-5-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71cd07acf1..9706003812 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,7 +1036,6 @@ F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
 
 SBSA-REF
-M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
 L: qemu-arm@nongnu.org
-- 
2.43.0


