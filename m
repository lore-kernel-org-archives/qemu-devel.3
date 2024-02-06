Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCD0C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOzu-0003pB-IQ; Tue, 06 Feb 2024 12:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOzt-0003on-LT
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:12:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOzr-0003Xk-4G
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:12:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ffd94a707so893045e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707239554; x=1707844354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH56YTCLqm7CWs23iAH4TIELKHifi0GITJ752eBfDjw=;
 b=n6CxjObGleqwMRriOnpzRu81mjCflQa5feqBYbaH2GRaU713fP/4Ud6eOUojWwB8lR
 9KJd5ScFa8IjDXCEtZGPJOl4//483tGckgtIeHvdZ6ITUWlIX9gKGNF5CRD79Zoyp4pC
 cXWJIwFxU6DeCkk0TIsnDiKQfwhyEt1G4k6TOw9PUO6M19iJEZWNj73SpiHF9vkC3Ii8
 L8f7lIZUi1vxq2sa0RBugAaXPICi8JUAT/8JrRH3wxNGsIfRKRNdzqFnXJ/tHPBLkCzx
 +pC3hykk6vkr1FMn/G2+6/+3VX2kByj4Fq3sDNLd2EYi2SpetQ1u/xsglgFglO67zO+1
 FRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707239554; x=1707844354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH56YTCLqm7CWs23iAH4TIELKHifi0GITJ752eBfDjw=;
 b=Cq5TIwxLjgOq3BIx65NU1+weX0Y/ufRP9HU3ML4KZv83UMKUt35WLbUs17FSSBl7Y0
 0/zBXYpauB6jHnF3HPlHbXVpdqqBDqGwOGDAOvBhBOs9kBWYD+CW60uyy/SUDIFZA9n3
 drLs2EjElz0A/9+Efe/X0CoxqyeOelj44kbZrwvnQSn86RvOWaO+ZOOK5/BvTAaJ/JaU
 UzNl/xgAGioF4LOAZFuX/KLXw/QhqT/3qrpZeqH5GHFtTJ8NYxAd6+uuozdDKaxMOiob
 jZ5xEIf8k4VzkUwuimC6NHAttfAHuugTtBhucVGSFxh9QuTYwPm4iMUAz1NzoDNcre6k
 VPpg==
X-Gm-Message-State: AOJu0YyE0JffuWfsdlI5dBvs5Axk9cS8iy3sOyGhxB874r/N8JX/Y5yf
 m8OHyaT/HoKXcxp4yVDZYKcRcvQqQqb0X+VLyjDgnH/GZW8/YhY+agkyL+wP+Ug89w8KQk5yYPg
 7
X-Google-Smtp-Source: AGHT+IF0Z9SpK21UjqfxdazZp3bOFIjCaDR8J4mQAugA2p3SLfy7yCSH2rI3XPnRini5PccIIuVVrg==
X-Received: by 2002:adf:ce0f:0:b0:33b:21e4:68d5 with SMTP id
 p15-20020adfce0f000000b0033b21e468d5mr1757035wrn.34.1707239553719; 
 Tue, 06 Feb 2024 09:12:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWjoe4nxjJudTv3JMKkultf+xyz2bo4vKQlN5voMvzq4tv+9Rtb5n27S1VJTVTvhEmjZhvFYy1ynmx/kFtB5o+wBIy0IVxD6jUlAFutQZ8bTDz29+cIXfkolx9u74zSscViTCxKBiYVdVCLJIddSyffbKpE
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d4bcc000000b0033905a60689sm2561284wrt.45.2024.02.06.09.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 09:12:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Nabih Estefan <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH 2/2] tests/qtest/npcm7xx_emc-test: Connect all NICs to a
 backend
Date: Tue,  6 Feb 2024 17:12:31 +0000
Message-Id: <20240206171231.396392-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206171231.396392-1-peter.maydell@linaro.org>
References: <20240206171231.396392-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently QEMU will warn if there is a NIC on the board that
is not connected to a backend. By default the '-nic user' will
get used for all NICs, but if you manually connect a specific
NIC to a specific backend, then the other NICs on the board
have no backend and will be warned about:

qemu-system-arm: warning: nic npcm7xx-emc.1 has no peer
qemu-system-arm: warning: nic npcm-gmac.0 has no peer
qemu-system-arm: warning: nic npcm-gmac.1 has no peer

So suppress those warnings by manually connecting every NIC
on the board to some backend.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/npcm7xx_emc-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index f7646fae2c9..63f6cadb5cc 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -228,7 +228,10 @@ static int *packet_test_init(int module_num, GString *cmd_line)
      * KISS and use -nic. The driver accepts 'emc0' and 'emc1' as aliases
      * in the 'model' field to specify the device to match.
      */
-    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d ",
+    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d "
+                           "-nic user,model=npcm7xx-emc "
+                           "-nic user,model=npcm-gmac "
+                           "-nic user,model=npcm-gmac",
                            test_sockets[1], module_num);
 
     g_test_queue_destroy(packet_test_clear, test_sockets);
-- 
2.34.1


