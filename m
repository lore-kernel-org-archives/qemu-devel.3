Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB32ACAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20oo-0004iZ-UN; Fri, 26 Sep 2025 01:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20ok-0004hI-5u
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oc-0005zc-Ji
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-26e68904f0eso19091305ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863769; x=1759468569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/DaP3+sddK+/zkpqYC7IOvKVE8r0PMX8jSbWoxB2MQ=;
 b=W0b+5SP8Iu6Hh5b0nzdsLL7IuFlKT77tFNWVEZOo8tsxdYNn4oX+CMi52P/vxnZI7U
 TgQVWi4F5KsKeMKd1UDhC0Brk3PW5NFH34r2QQv9IZNu5YP56WcFLc7FgylcQgZiFCAK
 etOsc7rZTiTrNDYu2ziowyEDNp7Vjewa3G9YAhL/337iU3UfzAfNt6cm5I0mi2BgG8nt
 Q+W2/T2zsGJT4SCJCkWtKC9bkSlCj2LIlbg/fcVQKRWmz6V0+x7PNL39zF/rZ0OEny+9
 HSNypmy0J200oaIPBNoiRX5wUVSISL8BXxMtOKrH03sbRuuLDrW4+zFAaCmuWvDMioMl
 Qi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863769; x=1759468569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/DaP3+sddK+/zkpqYC7IOvKVE8r0PMX8jSbWoxB2MQ=;
 b=iDKx+B9MKUxziq2VQpnTuO0sQ0MwXi+ZiG8IVmi6o/EAylOxcFg3KMhAwTK6AdbwCD
 X0+2aEaFOVOo4RgCX/B1tqGr4BgW+bEplGV49EgNyGErrsEszW+di0VNHcJ0UC+r7EyM
 W7iBb5339LivE8UCjOookcYzb5SWiZThpru/BmdQYJgFoqTLCra7EF6JK9oqej9d+A3e
 klcPNR+f7bNA3cQjyP7mmHZvGta+5cEMEr2+LTTe+eKO4qjRqDNMWsrFQKE9zhAuGex1
 MZFhfazxNAwJaVPhWWrwWsYs3rA345Pi8x9hL1eP0t3iBT4Ka9ee876P9nvFyY9lNjPg
 vFRA==
X-Gm-Message-State: AOJu0YzS3C/+kNl5HmwDe3BpClBDi9jgcmbsol5lBrQOQNx0FOaNnSOa
 R//bT3nv/4+znkm3WldjFp95fclMJoapgUpBUHW7yRgVIhD8nclkSvibGnv8m3avAzIwE4nDhWv
 uko6o
X-Gm-Gg: ASbGncvx6jYhm8AxskROAGW94zMETGHKIYVUSotOAinvp3Zfbi6xqmY3IWsJlkA4F45
 mePbCbZMpH4XMFGk1izrYSB91PhU4KgsHM/xNrDQvvdoAmBNe5UyQ8qibTYki2U+Il54M04KddX
 lNvM8SkudGRnemPN1V58I/+44dPn++NR8ch3qny9H3gDMY4K6ECqJJV1WHEF/TPUEIcTSnub70B
 45wtI4u6uL3z4qAUXVFvUNl4i3VTGgZTDgxJou7UGoi/quoa75TF9xrJudgtug1/UOuqgrLbNIK
 gyAGCh0Idc3Z5dV4EHd7m20fVLxAVe9y5aDkQkx06/ya3UsfLSjYB3QtbFLmHH4x5lxui3Gd1Uk
 S+DINuiCeJlG11gh9CbHPwJZpbUOEBHrrZoaol+Xi9RM94qbOh/on1lWQ2toyWWseckQZ
X-Google-Smtp-Source: AGHT+IESTj0x93R9y1vcHTe6dMZBGTfzKVDf8ghASTb0VrAA9asIDF6CMBv9y+fa/iVXmwcG/6sh9Q==
X-Received: by 2002:a17:902:da8a:b0:272:c95c:866 with SMTP id
 d9443c01a7336-27ed4a16b38mr83246405ad.20.1758863769238; 
 Thu, 25 Sep 2025 22:16:09 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:08 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
Date: Fri, 26 Sep 2025 05:15:34 +0000
Message-Id: <20250926051542.104432-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Add check-venv target as a dependency for the functional tests. This
causes Python modules listed in pythondeps.toml, under the testdeps
group, to be installed when 'make check-functional' is executed to
prepare and run the functional tests.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3538c0c740..d012a9b25d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
 	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
 
 .PHONY: check-functional
-check-functional:
+check-functional: check-venv
 	@$(NINJA) precache-functional
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
-- 
2.34.1


