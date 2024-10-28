Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0D7D339AE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5UG9-0005VP-8I; Mon, 28 Oct 2024 14:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hNQfZwcKCusiRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com>)
 id 1t5UG8-0005VH-CR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:14:32 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hNQfZwcKCusiRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com>)
 id 1t5UG6-0002ej-Vt
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:14:32 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e370139342so83743737b3.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730139268; x=1730744068; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QcXB1LmtAQFEXSUS90sErQxDRM3Ijz+Y8bQE4SW/GfM=;
 b=hS9/osyBKEDQ5ESa1jMH2WXlRRYxCeqsVNzI2io7w5LCH3rnKrhSFU99cN/rPZntii
 VkSw8VnQitJjW9bN26n7hEDKJyJDdSwEc8kJoEu6qkGdrNhBOs2cn/RT4Ij5kO4Iw7wG
 F7gPGU/T6lurdh9sutx80ZYWNVsIRwyc4+xfulqpF1+1XOQw+/5qx8rIixjfqPiYzV2z
 1hkCSfVK9JJ19T5UpBLI/WklKDX0QeySK/NMBsw7KM0GkYtXwaOFQwP6j067jXMTGTOy
 K90VBDtdm2/mjW7/fUTTgF9tjp5xgxpkQCkM7/QExQaR4ZmZNpkJgeCTcA+RB47whL75
 vZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730139268; x=1730744068;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QcXB1LmtAQFEXSUS90sErQxDRM3Ijz+Y8bQE4SW/GfM=;
 b=xTnQrzKEqx3Qxeg2D5+J6Jr0JRMfe+S+8O2F+FE1emvmLZoQ0LMLHssCq11jSbikgW
 zqI6VWMqYQ2PPpmJd0fsO+ORy+kEscE/6+SW/NbEYfafjkw8qsG4oa1GlT0h+frqbIGw
 ZXUmD5+xrrdGzDDJsP7mrlIwYWpawTvZTLuHgUJWHCQcEsspz+wsRVv5E0FtoYisbpgQ
 NLO1ua30mbwfKtKWYME+3lx18TDIMp3W+87WSlBLsE1MCoQOsYa/FZvPMmLDszc2SoKW
 LgET3e+c8nKxi+/7N8OVYqUDhZdZAnsAqilybIrxXbny8TIaRYc+7ky/PtcMD8oXe/S0
 FtvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRGBJcnfkLeRP729iTkWNlfstgWGexh5OdpYxcLlPJf9ssB2DbBQ+6DE7wmyJ5nHWw+Rq4rwAUrxew@nongnu.org
X-Gm-Message-State: AOJu0Yw9g9YTYRbQbfFQgC+TP5cCRToNvdTtws/Vy0cLwAH2JT/Snx4V
 wSYmtDoIVKLMLDF00JILZtrJJkO3tbohGVc9RU191X16VsSM8+jg28nvNwvafJr5kddg80T65BV
 WyjC4Hg==
X-Google-Smtp-Source: AGHT+IFYjXVdC+n7nCz7BT12K//NDUMOmoUehwU5BSUliDfnII7+GWQBDr5TXmwzFImBeNw9cNzGTFVBxVzK
X-Received: from venture.c.googlers.com
 ([fda3:e722:ac3:cc00:c2:1635:ac12:d1ad])
 (user=venture job=sendgmr) by 2002:a25:ed07:0:b0:e1d:912e:9350 with SMTP id
 3f1490d57ef6-e3087bc765dmr23274276.6.1730139268203; Mon, 28 Oct 2024 11:14:28
 -0700 (PDT)
Date: Mon, 28 Oct 2024 18:14:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028181420.1438938-1-venture@google.com>
Subject: [PATCH] hw/arm: enable at24c with aspeed
From: Patrick Leis <venture@google.com>
To: clg@kaod.org, peter.maydell@linaro.org, steven_lee@aspeedtech.com, 
 leetroy@gmail.co, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, 
 joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Patrick Leis <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3hNQfZwcKCusiRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Enable AT24C with ASPEED in the KConfig because the boards build this
device.

Signed-off-by: Patrick Leis <venture@google.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e7fd9338d1..1b25e73578 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -539,6 +539,7 @@ config ASPEED_SOC
     select PMBUS
     select MAX31785
     select FSI_APB2OPB_ASPEED
+    select AT24C
 
 config MPS2
     bool
-- 
2.47.0.163.g1226f6d8fa-goog


