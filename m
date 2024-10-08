Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F308CEFC42
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJe-0007Vm-KJ; Tue, 08 Oct 2024 14:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qp-QN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002Sa-B9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:58 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a39620ff54so1228565ab.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413510; x=1729018310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lBUGHhECpofGFp4uwDS9iqEwNffUJsxDhRgO3S72WA=;
 b=Muue62VaQTiXytk/EfeMpD3XrOTUFiO6/nxW1CtXElk6axYRH11EQIqwuOFc8QJnSo
 npGE77O3K4ztt49sjzXn9zQVLDSwGxKabuYx6WDk9UyJ0uHSkzhaMwWFepApDPpBwnko
 xd2msSWgNPgHxVT5fHoPI2aRRTxnK31soE1Vl0PnRu0CGwmDFIQy2iOCfm8paJDvxvbi
 pwigVpnYS5T6tIr3B7Vi1xfopho4zN9HuYn67zH9YVCkYL5a5rKP5kCXmf02QLvIJ35I
 LzgfZCmHMeiDAV3WHFQyTFiV3tlkvQrRnE71U0aGHzQxyIOw61xI7KGNeIgfegJuxoAM
 xUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413510; x=1729018310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lBUGHhECpofGFp4uwDS9iqEwNffUJsxDhRgO3S72WA=;
 b=p2iE7wK5R1K0LnRtolS5JOXrxprDEvlxmxaXOQ6ndSRA8pXVhJLR9zpbj+qiR2DsRz
 G7O+oBrTnMKIOmamHeo2HQpi13aOCKTqxFmcwQ+UGmubRQls8+1lubhdqL+f8dhm8GGJ
 B+KQaNMYKFEgeSfU0F6152b15XrAdQo9JAvBVU9L+juUeIKHT7iXOjOBZGKMWmgleBPT
 Oa+KSdphm11K/eGUA9yibULjlEk2LUk1/ehsXEkEU4uhMy9Ld1AfP0robYe2xFO+lRpc
 FbTVC2BqYxSs8GBScVFZ6+gPY6hE0arpBKNs5zSdkTzAmtqCflx0K6bpvhtax7fYofJs
 QgKA==
X-Gm-Message-State: AOJu0YzS8RTsjy+C6NAfE7PozqRO4dmLuKoqw5bZajGFHs+T8y0vNee6
 EoQhf63YBySkFZIGzbyV9RLJeL4jQsxFwrspFwQtpEEDw2eULJ5PEOPeAZyqv9G1p8qyZV3uh6O
 7
X-Google-Smtp-Source: AGHT+IE2AeQJbQsGjrsrp2A2Z1iPoIfAZfeOWIxlBiZCATrYaik7CHW0lVq+9U8RXwR+QCu8uOdxfw==
X-Received: by 2002:a05:6e02:1fc8:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a375976acfmr161764005ab.3.1728413510166; 
 Tue, 08 Oct 2024 11:51:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/14] linux-user: Display sockaddr buffer as pointer
Date: Tue,  8 Oct 2024 11:51:34 -0700
Message-ID: <20241008185141.20057-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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


