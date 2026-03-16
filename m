Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AA4F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PS-0001vm-Pa; Mon, 16 Mar 2026 06:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PO-0001aS-IP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PM-0003gV-QY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so50332695e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657767; x=1774262567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E8/4CMtNXRZ2X1/ftYSmtEFaBPOReSBwxJEUSTFqB8Q=;
 b=arP1WSN996OIJDPiWp2dZoZX6E+PHlHtczd5BLYB+E/3U+B1TDTpmhg/0jWwDT8yWI
 4PAwZMPUsI6K+LHcyjXWWUL89ozRJ88vheMOatANtq7KMPq+7HMRBpQrKDYHQhfEhP8x
 ClFUWGl6FiZiLtHPwTyCg9wZ4ldGgHIBSCReentdeuqjE81Gm3ecyy764uQkNNeOqsNQ
 bwpJlb6ngHJPmokn8O9cxX9kSxeV5nL6Z06mhudBy5zjqIPQ2YfrqnZUQorJEmaFnLxB
 +p0kN0eWLNleBZkyFXNYGhwCCcGPEDI6GTG8h0FzSQBCOvIjq03L50gPahfbF7RhNoZp
 KhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657767; x=1774262567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E8/4CMtNXRZ2X1/ftYSmtEFaBPOReSBwxJEUSTFqB8Q=;
 b=EB0oMHxvY2jqmVPylYr4bpXRP2dRe8NICy3c60MdSN72NX4ivaxiUDF/EslyFFlgWb
 Q112ADub7+Jr/ic8f4N9N5LNgYjlBsBwg79qGqCOpAbibfAj5z903BCm/cztD1b+zfs/
 3r9UoJgf/MZGq5RYmPooDV9a/KdtAp2dT3lz90lMjX4oT4h/7aIqRla54hZH3xmD6SSS
 ILppSCHpTMvhiJ20vZdGjWzkVkyWU2LOwK3wC7SR29O9UXpjJE5p+EKoo7tKEcniSxYf
 XPVNgzLz7JyqkZvT0fLbQDm2yvSqWQDFjs2OAZfONt58vQzZq8c6ZxyykRa0QmQ08f2f
 fngw==
X-Gm-Message-State: AOJu0YyG1Tr/eJD5wgXDN5oqOf3OuoGYiMcZ7FR2qQbuBPtK9e2YB06R
 5ayO8nOElBk8/ifHgp4HOz3No6vRDTXRYLUUkhLIM+AHjwo6sUEGNBLvi7lQL7JQ8jpdsQCPrzS
 YgBxP
X-Gm-Gg: ATEYQzxpQH9boC/Zapm7QrmPfGWV1V8dXwG8/VEZAllnSpxSLbzYg9ZCl068eB4MFeI
 eBV385yt2t3AHiZuf1UnQr7ereN64F+LIThHjEkRU05bH/G6tCS3TroVCxZTkCnz1TsZfvAF8c3
 OvqeP+I03rrMgnia4jjPg3oIwcz6J6z4QNnG7VL5rZyPQFVNrOCKW7toUawZz/47X9rQZlYvoz7
 V8falp3v43HsrRcC7HbPe7ro6uPYUyxj2ul3YOrCgE+LT1mVGyIKbUhvbuqToY7ACHLcfUIGNks
 syrRJjjKN9OC5pUCqrc05g1ImMlYenD2iOvlmAI6hzYv6he8GAaTF4m4wOeLJeYAWne8FFc0fAe
 4fl+VK0Uw/jbzeCfAKJR6Z9H0lJkgUQxm/15yAUmsYswP7hN9uOCN5cv7/R/Ooajr21uuiPIQu7
 G2CTxDEXsdHu8DDghBQjWHgpnCfXp/P3eZAtNR7iREeRfCxqQr5U6msv6kFSCIlmEQi01dGrB9i
 +43EcdMI8Q=
X-Received: by 2002:a05:600c:8208:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-4855a8d7004mr189315425e9.31.1773657767315; 
 Mon, 16 Mar 2026 03:42:47 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] MAINTAINERS: Remove Chris Browy
Date: Mon, 16 Mar 2026 10:42:26 +0000
Message-ID: <20260316104230.836962-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Chris Browy's listed email address is undeliverable:

The recipient server did not accept our requests to connect; it
times out on attempts to connect by my sending mail server (gmail):
  [avery-design.com 99.83.249.127: timed out]
  [avery-design.com 75.2.78.167: timed out]

Remove his name from the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306120555.2035421-7-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06a0bd0383..7a0c71e12c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2160,7 +2160,6 @@ F: docs/system/sriov.rst
 
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
-M: Chris Browy <cbrowy@avery-design.com>
 S: Supported
 F: include/hw/pci/pcie_doe.h
 F: hw/pci/pcie_doe.c
-- 
2.43.0


