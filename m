Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BE6CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfp5-0004sa-Sk; Mon, 05 Oct 2026 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmV-0002Hy-R2
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:57 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmS-0000zg-Rq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:50 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b059eae96so1359674f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195526; x=1791800326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMh0wnw3agFF2IsElQcMdXFWf485YmO8ORQx8WUZoWU=;
 b=qKNrbwO+LHyxFxMczEgKPswMfvWEVMCZN5kVGPecE/eyL7XhxUf9tiwzF/6dW4Z2Xi
 cLbliqiYv7EVC46jim67DdJx6jjiF83jZLOm60czw4YsXqCLsFAiExPDFbPoALW+nwHy
 CtzC7UFsUpWpXnaAwesyragaN8REogTK0/Gx8e3FBW0owedgU8H1ubIhc6JjBdK1KFwH
 61lxrzYQYzEuo7TPXAQkKu1e1cCPt0nR12Pirzh1MvzSMZhw0cYT+AP69z3a5W9V2k5K
 fRVs+5MhDqZbPwN3RqhXUuoS1K0iT2XpnoOgr7laiIp9geyfeuUfhq285GmcJjprH82S
 GzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195526; x=1791800326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMh0wnw3agFF2IsElQcMdXFWf485YmO8ORQx8WUZoWU=;
 b=ecZzxli3q3WuAlkz8PPLlsB2vJVmNHxlD4+oESBfhGKpczKZpHTj0Lt057XQP3HYu2
 cTEUmgdsRDO5K8mIMRQmPr5y568mF4OouUdKuCC4NGxcShqNHS2EZK1HCjTc33cHe0pA
 BIikrA01FBO2WA4xmEnjmqw6KZbcen5KgyS55BDGFzz080elvoiX7y+NYncFokcAgEaN
 w28PyHcoxbfqgvJQY5l4xDEu8/i6BBTsZDFbVZ6wjDEgS+b+xZBD07uOt3Cq5uAa4T3L
 nMNlMyvmu2S9WK4QxLVNM+EkuvQyLIeTu0ao3wl0qT37Ee5dIOiHAz7d44U7HiXhnFNb
 82tQ==
X-Gm-Message-State: AFq9FYKZbH/tZBIe/PswZgQ8iX71J12tAJfCysmbj1bFk6l6j8WFdlpU
 LGeqh3Zycn7FjxYwlTVIqnkOnFI+xX4cSqcMGcJvpGdcMwLmGLrM31wkw3kjZQ==
X-Gm-Gg: AYBFou1KrcU+yFv6fAvhUSqZhr6+bRqVFiy14ZCIaZJjMhlw66YCr3c3qNgP7XGqp0k
 aN+E7BVr2SlVD5lD7RAqtBI+6/tmoU/heRW74jjBAQpdXfOF18JukuORlsZJxCvygubE8Ha+IxB
 SLoTDjvpFpaV2xrAAersv+0VBKznnNuVZDAXGxUpRsUep+0VYIZCqIkPiNelg/bt7ECZa3kluV+
 0HNcs18IV5Ub/bozZiAE8MLZ/c3MGCT6HQ6P/1YhXCXz3GcltpfchyhPzb2Z8FcTctelTA+FkVP
 p8OmzbYVhU1o1bB1vB7v6J+Y4D6de0mCfrYbsnwJ8tcpBvGWVaHGJFYTJyfovWStpRjhpy83xOs
 zhQgT+1RR0AFmALFMT7yYEfLqwdSH4X8bjpLHRLq7kDANWahYU8Ltuh7hn79whfXzKFPaGH/Utx
 5aZL6RN67FJh/bQQhkIuaPrSiS6oRSERkehJ6Q3LsRrjAqNfv+zM5JJVf0lJkv89aaZNbYNH6YG
 IBh61SjsNAKNlBJMJpEBkaX4rNqU4W3x2rcdEPBuouiCXiv
X-Received: by 2002:a05:6000:40c8:b0:48c:5785:9b77 with SMTP id
 ffacd0b85a97d-48c5785a1e1mr6214528f8f.27.1791195525257; 
 Mon, 05 Oct 2026 03:18:45 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 17/31] hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS
 from config IMX
Date: Mon,  5 Oct 2026 12:17:44 +0200
Message-ID: <20261005101800.10821-18-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since commit 464ce71a963b "Kconfig: Extract CONFIG_USB_CHIPIDEA from
CONFIG_IMX" all relevant i.MX SoC models select USB_CHIPIDEA such
that selecting USB_EHCI_SYSBUS became redundant in CONFIG_IMX. Remove
it.

Fixes: 464ce71a963b ("Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..d1711433ef 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -93,7 +93,6 @@ config IMX
     bool
     select PTIMER
     select SSI
-    select USB_EHCI_SYSBUS
 
 config FSL_IMX8MP_ANALOG
     bool
-- 
2.56.0


