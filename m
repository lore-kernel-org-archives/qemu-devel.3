Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83879C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfUA-0000WL-8T; Thu, 13 Jun 2024 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfU8-0000UG-0R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:07:04 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfU6-0008IO-Ek
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:07:03 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52bd48cf36bso983380e87.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718266020; x=1718870820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31cNCR2mzBLKID4O2IUSTWgxKOCqpW5ErAleu4fDPAI=;
 b=hJ3qTq6V4EdDSLboMb23SlJnwVw8zW/hmDcpSaGYvyFn21zUqzvc4W+1xLyqYWZ2Kw
 zhl/gIJD+MQiylQA/prxSIVQM7XYAyPcHrhMiszR+cnuR2N8tFflW3Ehf3noifp6xD+Z
 dB8Ucr7Xh6Y1WB1E17o0SgewR8ibir479lUMA5uTcXpp9vObdjyrHGVBpHosOaw5tlY6
 0b/CpHs8Qlb3cxJ8PzoEf2TtBUPwM16GbGe/xzmKQe4RSMPv+IPfTYFobtu2yO6y+7PY
 BFoi1o2eZ31wKGSg9oX9ZqaXQVGkCvzJ5OKPjWa+Z49yxi5rijh9zWS1XgQgeAaUrUH7
 Wrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718266020; x=1718870820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31cNCR2mzBLKID4O2IUSTWgxKOCqpW5ErAleu4fDPAI=;
 b=gxXw2Me+1tuOOkf5DQDqMVnrNTWRxYLz7YxM0zJFZSya1d4npm1IrFWlTBs2ws4hiK
 gRrDMzbV8CQoB4vTZLt1+SK3oErfFYFLuFOYIaV6+m0D3BaSicwIJXzRx5j4WszS8cwT
 HFr606fWi+HW7ffp9tS8DgMYfYX+3j8qq7WSiAUv1nOA1yMsn23M9Qv3TYsbdVCtQ3Fz
 g/jPtA5qhX9YKU78pBvOyebU+HfXlaj2d4xqX0k8Og1pBFWJ5AyrOoTP7lUoQZmEi+l1
 8o1vMUNYmytbKPD2vw39Y/38hs0I35JYnaSlQqCdZY3SWItiHNMpyUbpFY/DOltNFA02
 pu9w==
X-Gm-Message-State: AOJu0YxH7MLpI+X4MMBMH5W8zgfKjTEa0bHAHfZy3VSgH4Vk+pwnanqG
 lS208qtWyxHPTsbHYIw9BXcbP4U4YXh4IJ2N0qR3DCzyu9Df6tjPs7Gn1A2xxF4Ng/S0ELwayDr
 9s38=
X-Google-Smtp-Source: AGHT+IHZnsu0Q+oMiLFXGRzAgK3YLxw4QZYh3CCVVjQfWIn+iYI/JPMAZEP5PibTw3RyoJ/+sL9FVA==
X-Received: by 2002:a05:6512:3083:b0:52b:c88f:b107 with SMTP id
 2adb3069b0e04-52c9a3d9747mr3245894e87.33.1718266020460; 
 Thu, 13 Jun 2024 01:07:00 -0700 (PDT)
Received: from localhost.localdomain (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104d88sm910811f8f.104.2024.06.13.01.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 01:07:00 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 2/3] util/readline.c: add C-n, C-p shortcuts
Date: Thu, 13 Jun 2024 11:06:12 +0300
Message-ID: <9876594132d1f2e7210ab3f7ca01a82f95206447.1718265822.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
References: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x129.google.com
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

C-n and C-p are the default bindings for readline's next-history and
previous-history respectively. They have the same functionality as the
Down and Up arrow keys.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 util/readline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/readline.c b/util/readline.c
index ded31b04b7..0b627d62ad 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -418,6 +418,14 @@ void readline_handle_byte(ReadLineState *rs, int ch)
             rs->last_cmd_buf_size = 0;
             rs->readline_func(rs->opaque, rs->cmd_buf, rs->readline_opaque);
             break;
+        case 14:
+            /* ^N Next line in history */
+            readline_down_char(rs);
+            break;
+        case 16:
+            /* ^P Prev line in history */
+            readline_up_char(rs);
+            break;
         case 23:
             /* ^W */
             readline_backword(rs);
-- 
γαῖα πυρί μιχθήτω


