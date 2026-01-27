Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C47D2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTH-0000s0-6q; Tue, 27 Jan 2026 06:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTE-0000nz-A4
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wi-SU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5654506f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514168; x=1770118968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPm2y5sybrJp31Zb0KMoMrNiIBmvGJL1ZYz1YnW/UAE=;
 b=rzvxU5XYga0Uy3OCGJH+yXlaHlSOzlHpr0NGdml4Uus9Qi7ZotD/cmn3n3zu5Np69Z
 2hZytvn+CR7cOINaf6lAUC/S4+uIgmvBg385gv0DOGfH2bSSyrH1lGwoqMnQnY2Ju7Sa
 TK8s+jtZVVc+95KVLy4Lw7gSLHjMpgdqSWk1vUSozZGtr6cCwWK8Smh8V8UlorQFmsOa
 cRFg8/jUlF3Fd7bdbz/mmFP6WgNEbgXUDWjDHT7orWR5Etgxm7YB64BFZFaDSpDvoN1R
 rPoMMDTl6k4AFDIXl9uRQrbBL+IdR95Rf2OlaoOf4l2RhjhoHg0oD3giQHqxBbCUAANB
 TTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514168; x=1770118968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MPm2y5sybrJp31Zb0KMoMrNiIBmvGJL1ZYz1YnW/UAE=;
 b=Whch6cPpaimP8DjIxoaK7nhx4KtTzFJh6l3o3zVlAV5WBGzItiJPAFET3pGFevHHyv
 ZaArAqikUhXlwvGNBbFapWGD52XIcRPefvf6EyJkkRkzzz6A7RavpzU+ZgyNgkU9TFpP
 UUrGHbmCV6TyMw+iLOGqBIkTjPAR24MnniHsW5o5sxsrIpfECzPGbSS3eIavwSYfLyD/
 hh3ibISqLpBfuaTtZYkoqBwumPnkGrsYCxqdCbKonrg2l4/yR5OS4KfBArtDS4Xtl3ab
 9XW3fqmOsCrKoUGu+RF61hb/LZ4g4GHmrpcutaB0s/0zEhK6mKT/QEDYqsqsM8QvYKMz
 Ly0Q==
X-Gm-Message-State: AOJu0Yz9F2kMXS1Kj7lmhbFFJk+kAPrHRXVO5TxgjieRZ7I8inVUMVu5
 T3TXsfkyhqyXaZjpCNopZ1cK098MhhTqy/BXFAPoHSqMFhoBheY/NE2naaR1JLsHDGE=
X-Gm-Gg: AZuq6aJh/upqrRZPe+1Diz+iikWM+04ZjkDEIitqi0KXSpRWdWRdnQxBvE0xpglRAQ8
 Yzv/cdYfNKnus2MgE4JqEB3xfgZtfk6plGRImyu+VolKaJ3RMRyAMnwiU4+pA32VLyj8BPr7I01
 p0UxjVaflS8Oa2UaQigp+vctHL7AHKHBtvUiW4+4tuV/1yK1ha/LXxjStTA4FZ1GN6xkqTL1hij
 u0GEMGZ1gsDyfnLR+xnvRGkIc29ogwLoGNgPpYTm4TH+ueOB0my2huLLiZItm/oTwUiXGAMaIVL
 VeHdAuGMsN7A/a3L7CXAggVd46dzxsdCUBYy7QTRqGxerdpYmMrDf9wKY0ZuMyCjM7Q9s3Ku8kz
 xFefMRFyiH/bA9Dk6hxEB4smn0KJXb2Xm3i+k9pIQ+QhM3p3B6FxOJHs+lj4GuD7cdp+GSF2ZBg
 zmxAbq6dLXw1I=
X-Received: by 2002:a05:6000:609:b0:435:9bf5:b32c with SMTP id
 ffacd0b85a97d-435dd1c0c81mr2176133f8f.29.1769514167940; 
 Tue, 27 Jan 2026 03:42:47 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24b54sm38255984f8f.15.2026.01.27.03.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F5C35F93B;
 Tue, 27 Jan 2026 11:42:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 7/9] MAINTAINERS: add reviewer for linux-user
Date: Tue, 27 Jan 2026 11:42:37 +0000
Message-ID: <20260127114240.3009791-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I had interest in this area for some time, and would like to help
reviewing it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260123145750.1200879-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 49507340e3d..97d887a5c19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4034,6 +4034,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: linux-user/
 F: configs/targets/*linux-user.mak
-- 
2.47.3


