Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB58CFB422
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHb-0006C3-3R; Sat, 05 Oct 2024 19:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHZ-0006BE-OI
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHY-0004Dd-AP
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e082f2a427so2433380a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171231; x=1728776031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lBUGHhECpofGFp4uwDS9iqEwNffUJsxDhRgO3S72WA=;
 b=l54tXIgKtrH35E54nHKX6diTs7rhvXfO9/3Wzpnmso6SHpH+6FR4BzM4DpENA7t597
 gATfh/T7xSs5VAjcEhZcfEXUs6mhwJwu7Lpzxe1oDB6GtWmgzKCADLTb4QpkzgQTii/9
 4geeHvMarTfJX61D9/tG11e7bg+L+Qflny3tOkV2JM0BNUHBFJzib22wVKwwWz53kVEL
 qabjL1SNdvJ5M53k+3fPn537sfJdj4okIKip/MNXNtCAdNOut9BqAinYsrpjzLZVa/UE
 SCxpC01EUWEy+SBvVuQVQxZPNtpsVE+zKCE+aJbz4fGjXmOM6ZiTDalTc74vTgdF1YK0
 m3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171231; x=1728776031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lBUGHhECpofGFp4uwDS9iqEwNffUJsxDhRgO3S72WA=;
 b=sR12ZlNOWPOTKFIMEbB+/yRnC0IqZbe/VlEeLThezg8F5ye3aSsLsd8A2oxHD4o3Sb
 UeY6bspzFb65Ft+28XfGb2ixPtoMxWHQ1rbSe/LY7LEUdQ8iUFZvJc5YAQIJdjyG+jGm
 5+AI5Y6Iqo/yw/p6EmTnjmWd8zu3EWNlD8U9j1tTvOH1H50I6v9YWomrirBgZ902P1Ca
 Li+bXGYgqm1lqONaab1QJSKv3U8u+YQQzukn0qFjNFedL1L6kWS1k7TyVBxfZBWnyz5I
 bS86iQiAMsYKbEFsjMnpstSjDJO5puSPBlf5aKvXJ/FyPiRiR/KQBk3ONLGNSfICIDwx
 xZEQ==
X-Gm-Message-State: AOJu0YyDvqrEEQiciwYBQFuLAQ4sEfjWotj3hseidve0fWoX9+GAlOHa
 lgW/cUOCjW8SVKXbp3mWv/FeDlvL+XEQrFxQOB8rfpwmWa1jrZVGzmx8bn/18LgKlF6orCg3pZd
 n
X-Google-Smtp-Source: AGHT+IFSKRa4SE/ADCYJbfVsk2d/P2PVNDs0ikRJYMpdCWHpJvOdbUf6ioFv4Z3/DgLGjCJ5BNkB8g==
X-Received: by 2002:a17:90b:3891:b0:2e0:9d3e:bc2b with SMTP id
 98e67ed59e1d1-2e1e636f94amr8943063a91.25.1728171231090; 
 Sat, 05 Oct 2024 16:33:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 07/10] linux-user: Display sockaddr buffer as pointer
Date: Sat,  5 Oct 2024 16:33:40 -0700
Message-ID: <20241005233343.503426-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rather than 'raw param', display as pointer to get
"NULL" instead of "0x00000000".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240807124306.52903-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index dfdec58542..b72fcd515f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -437,7 +437,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         }
         unlock_user(sa, addr, 0);
     } else {
-        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
+        print_pointer(addr, 0);
     }
     qemu_log(TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
-- 
2.43.0


