Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D27C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 23:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twUIg-0000gp-9k; Sun, 23 Mar 2025 19:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twUIe-0000gS-NQ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 19:00:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twUId-0008IE-3l
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 19:00:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so21598035e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742770809; x=1743375609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Htma0t3w/jsKKHYmsDDY7UhNDt53Cio1gT8F8zfAALA=;
 b=lSMzmE++Ryfy/Ciw7UMXSCpVj02ndj+7cWDj1gDIHYvZkl7dRN1NmruygsfH9JaCWZ
 EZYr404I9s5ia9JY5H6TGmI5FLZH0Xo0VTrmQQHDP8hDPF2G2LIpzvKX02XChZDpvYyC
 vtna3VdqLzgCi1LG1PBjzHXyRz6CFwShLsrKehfNtZ9o/FWB4e3BVZWKnrIsXlKvHfUh
 ANXdN7pfh4tM03ajbiC4OYf+pHqad+9e5v4TzmwMWjqR70b4FnrwnIJlHWb6/xBedel5
 yTnbnh2nJywqiypLOIapuut/nnj0uTqx0u6XBcp9K4wIjkFfvyDOacVr7wPoMtfvwfBN
 06qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770809; x=1743375609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Htma0t3w/jsKKHYmsDDY7UhNDt53Cio1gT8F8zfAALA=;
 b=cWUX56dNP3sFb8Ms3KGkDrX5TLRBykk7G597MI9oq7/AKbBy/W8v42+nJYuM1EUcP1
 o4FVowcexlg5IWEMvdUY9jPlA6flr8FddeD3BOsVeCv9PUpWd7TYgeceODuj2/9b/zHA
 uQwJZGs9nLHdJYeO9/onqbjvASQF9o4DDpppw3ZXS0+1P5Mxxa0drl+quVqXIe6TIiSI
 AzYL06GEyzB7ASirSrOq77GaqckGUTQedLrpAsqwGElF4AcOxDYPRRg8sdgegQBU2RAt
 v0oOHmmiBQAc1TFH3k4jJTdYNshDmTgOGGzFDZzaOO5eoRE2d5AYvJKM/RQqDpsXWkGY
 4ZAA==
X-Gm-Message-State: AOJu0YyoIciHx8Wtm9/1KIbLYmxZNSB5CMwpOe/08KxCQBVWOu7SsWsd
 SRf/e0xKRdU8rxRBnOl5Mr/EuekPrGi1rYmhGp7eQRiOWRTADzWOitJrASAdU6FrQBpSy6JhZvI
 8
X-Gm-Gg: ASbGnctG9hxHozwmYSkA7hnjhUeL8bOdLNXiUQR6o/19cC3VuVx2AghjZwxsXRVwaVv
 v6tNjY39XebFpZoMnQqdXAOVfTlnZ38elwrNbgaYE24l4Ibn4HycPYEFUZ4DF16mom/ebPSfzNY
 wwpM0Si8Nr3n2y3GIXAiIoQHtJmSPY4nrkkXnhZHIhRxFkYeRHsLz3Na5JXYbOdULv9T8AlV6qq
 f+lBjXuBTr5ssNReTVHD8UxmO23Vh6zB2/Pffl6RiTvPNoCmsW5wE7VLmgMV9SEALw7fnSWIFcq
 M4cwDhYMdMPTwy6e8CJk2t8ykfBEaIr9Hmjj8MzdK9wjOxaUUG9zyT5ne23lYiy8TmuSxhbjXWC
 cy6+K6jnJdX+8fO0HYqJVMzjd
X-Google-Smtp-Source: AGHT+IE+/FY4m2dxj89W/uu+3cMXaVZmGjQuICYOA+EkzHSexgmpVeGabauKCjpWfC6/RbSDvPrb6A==
X-Received: by 2002:a05:600c:4448:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43d4915e47emr163725925e9.2.1742770808716; 
 Sun, 23 Mar 2025 16:00:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c99sm152656925e9.24.2025.03.23.16.00.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 16:00:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/vl: Tidy up break in QEMU_OPTION_machine case
Date: Mon, 24 Mar 2025 00:00:06 +0100
Message-ID: <20250323230006.36057-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The break in the QEMU_OPTION_machine case is mis-placed.

Not a big deal, since producing the same outcome, but
suspicious, so put it in the correct place.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index ec93988a03a..dbca9ebba4d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3409,8 +3409,8 @@ void qemu_init(int argc, char **argv)
                         machine_help_func(machine_opts_dict);
                         exit(EXIT_SUCCESS);
                     }
-                    break;
                 }
+                break;
             case QEMU_OPTION_accel:
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
-- 
2.47.1


