Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB2BC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIs-0002le-5E; Fri, 15 Mar 2024 21:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIq-0002l7-Lx
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIn-0000i4-Ar
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dddbeac9f9so19775515ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554253; x=1711159053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I6ltn5r5eQP6OaKsPETbZYIZfsGGG0xeYi8oAp9EDY=;
 b=cJxFzdIa2pPVmh8TQNEOzOfqED3H+ib7rEIu+9ZI6MqwNWlHMEMSTHUisES5UgEf31
 N0dXcuiU+REIyuGYd1gGnHHGi8Eh5U44HyxnpGeOss+AChhX5dBkTJu8dQelcNy1oQIr
 WPVC8/Vlls/An2gGldkhpk+stxrAdS5q1iU+T8ZVAnybcqG2lVcLA19FiF4PB15A0tE+
 +3OHb8YfBq68Kw/Ix0zxU+n6Ln0ZGTd0FPG/Y1f/FSjt4CwNB0PuYtBwioCg91x4DIRc
 3cPRhovlBpV6i9cBQAgUBXXHqgMaFs+wcxEMY8Q7WwwI9yXrQyVMq+dsGkXs6kBgoUqV
 yRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554253; x=1711159053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4I6ltn5r5eQP6OaKsPETbZYIZfsGGG0xeYi8oAp9EDY=;
 b=tjyYgCDIpgYOuhjrwHfVEaByTHilPBqanaR1D1uwr9l6YR8k3c4coo8MBSQA1Cg8mG
 vLSvZsUMStV8FhkgOCYKPsbnA+PRz4DX5JQeXAcVZnMsQDce7fr3IsvIA3C0UZ1X9Itm
 nw5AJsuwPZ3LKUy0id6cOdHO72vkWvdCh1OfnM9ccxea/zglgTrZnVvpHQtguhnWKfYu
 SJyghY4F0AzOCVDIbQvvBQi/zj16tiR1t/H8fh3aS1tKhtdDlsSMruYClDu0KSxigWdU
 UyTo8KcUE4e+gDPyIdBrMn6t/TsWHjO7hwWD+bapw4cZdtFptjKsa3qkzem5HywzTIdl
 FKuA==
X-Gm-Message-State: AOJu0YxGjT3fW/vazXxXo9WJmmrZrHPALi4VDah/IeEqCy4Idl4aYulF
 GQ6Btktf00J6zt3VMi9dRdOXA2VbWMZIy6S2Tqv7uFUlJhcrue+do6Cs+gxTfcg0lBC5mopxAwv
 M
X-Google-Smtp-Source: AGHT+IF0yfLjsf901IShrEUkr9telGYK6smk2Nn8XkKD5U6jzgN+sBkxVfJBWykDgu+BxBqurPx/BA==
X-Received: by 2002:a17:903:11c3:b0:1dd:7d6a:d6c8 with SMTP id
 q3-20020a17090311c300b001dd7d6ad6c8mr7726619plh.14.1710554253537; 
 Fri, 15 Mar 2024 18:57:33 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 04/22] plugins: Zero new qemu_plugin_dyn_cb entries
Date: Fri, 15 Mar 2024 15:57:02 -1000
Message-Id: <20240316015720.3661236-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 11ca20e626..4487cb7c48 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -307,7 +307,7 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     GArray *cbs = *arr;
 
     if (!cbs) {
-        cbs = g_array_sized_new(false, false,
+        cbs = g_array_sized_new(false, true,
                                 sizeof(struct qemu_plugin_dyn_cb), 1);
         *arr = cbs;
     }
-- 
2.34.1


