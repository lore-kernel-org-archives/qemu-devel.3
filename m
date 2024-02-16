Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67683C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw1w-0000yl-1b; Fri, 16 Feb 2024 06:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1s-0000jp-H9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:16 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1f-0001C1-QQ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:16 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33b28aadb28so1011208f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081501; x=1708686301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48d0wm1jd8E2EcPt+QBeCr00l3Febl6qelXBQC6Tkz0=;
 b=p8uKsUMA3UkpnF4XwBkE7tJapWa2ePRHGARhy3jA+bfHqxZKHz1pVa0Ow8w7HmwY6J
 tYZdkmvmTDJiP+kh/bUai9Sfht2Og6D9ZM7WAPhebwQAzVu+u5qOIHi6bLtwvnotnLys
 IoxPJHNHwfLiir4Ye4QjE0e7McEAzNZFPFR/WTlaAbH3NXIVQBGvQpH/DoqOzimKt/YY
 3aF+/S8Jg8d+SDfFWiN4UGw7jcb1Kq33HgOXuJsSEf8AY0Y8xz27qyhUMtScmlE8AzcI
 vzWj37XV2C95kIkgcF0uWA/hQyr5C47IxL2uev2a8rEuGEPVvDA/qCp3CCQzXNvsnOc0
 BRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081501; x=1708686301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48d0wm1jd8E2EcPt+QBeCr00l3Febl6qelXBQC6Tkz0=;
 b=uOjww+USZdVlx8lzxN5t9/Yh5t0ezjfGYFPbD0vkzB7GfmbdKo6TOEv6I0nuffQx7a
 GBMf4WwszUQd0t2I2sbE89YIC5yVWC6qvcjCpeTwLdr9O9eAkoTf2LPK6l5ncb2Dr+AK
 OMMAzGhZBiwSfQeeoGKi2l0qn0t6sLjZFPjDUg/7ny6O+T8Usm3cKIQTvqAkPEj+2PPG
 n+1zmdx1Jx9SYJFT+UAF5GcS6Kwz7zi+G2DMyypwJf2flJw4SM+SKBFcRs8y7CaGS/fP
 Sc7wHKKlmb9aAWPsNPLqH1gJjTAOyGjqXYSYZzhzQRCXulsxbyYlJvbXyO292iP6gWxU
 ueMQ==
X-Gm-Message-State: AOJu0YyApFpcdbtNnjpCW3w9kKPOo42vMxjOt9nt1KLgzBVAaGdL8WUQ
 nQBylshABqYKooWH32XFD9pR8IkMYG++ps3l4q5lM1qdYQQ/Y7iHGzRjhEHo7M0298b26LWKr8d
 +
X-Google-Smtp-Source: AGHT+IE414mhQNndxrGFebQrZkzATjJvXCu4SoPFbAYg+BjNJr7pqir1xZ7MIJ6MJ4hnVG5vxB285g==
X-Received: by 2002:a5d:6a8b:0:b0:33a:e9dd:5b6b with SMTP id
 s11-20020a5d6a8b000000b0033ae9dd5b6bmr3133003wru.9.1708081501246; 
 Fri, 16 Feb 2024 03:05:01 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600011c500b0033cf095b9a2sm1872339wrx.78.2024.02.16.03.04.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:05:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 16/21] hw/net/can/versal: Prefer object_initialize_child over
 object_initialize
Date: Fri, 16 Feb 2024 12:03:07 +0100
Message-ID: <20240216110313.17039-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When the QOM parent is available, prefer object_initialize_child()
over object_initialize(), since it create the parent relationship.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 47a14cfe63..f8e4bd75e4 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1900,7 +1900,7 @@ static int canfd_populate_regarray(XlnxVersalCANFDState *s,
         int index = rae[i].addr / 4;
         RegisterInfo *r = &s->reg_info[index];
 
-        object_initialize(r, sizeof(*r), TYPE_REGISTER);
+        object_initialize_child(OBJECT(s), "reg[*]", r, TYPE_REGISTER);
 
         *r = (RegisterInfo) {
             .data = &s->regs[index],
-- 
2.41.0


