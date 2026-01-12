Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9372CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQne-0002DG-Iy; Mon, 12 Jan 2026 17:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnH-00007v-7W
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:51 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnF-0003bj-N1
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:50 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d2670932so3055975f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258427; x=1768863227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sUg87t0iFBFsEag00yU0i5OcBFg4F6lUVLgoGSuPxag=;
 b=wOO6oYur/MX5eKUSATZRMQnYS3jIuzHXdeIySp/Atp/yNpQxSYeA1o+vMtlX1IrO5n
 iagSNzidro511rvYuNDSn+1n44jK+x+N7DZD2WxygamMmsL02NaiGbrXpig+/tlhz3gM
 F8q1kgYz0LdeCo0MwwPUAJ46JuMHejSP2PmhSp5TxF8rLfN+Si2eEFm0K9lib07UjK+w
 WhSqlxgvEcfwtbQlj5h3Phc9vLFGzcvLqeknG0H1t3SvXwH8CuFcbaG1H46oD7gKNXN9
 dKGKWT4VHY/+Us6b4+SeEDDxubKZJRrLYcVr2N9XkfJwcQIGRvBgiseXtqgKAL0Eef9f
 tJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258427; x=1768863227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sUg87t0iFBFsEag00yU0i5OcBFg4F6lUVLgoGSuPxag=;
 b=FYEChrQURejP9T8z2OWy7VCpBPG9tt1Iw9UpO9M90HNvn1rn0rBqB4tkAmnTSnkE17
 fldK1o4vdXgKock9RIJdV+fMIv9Yun4ADdbCSwOBea4IRWQ0pubYLeJhNOls24TSJMq5
 rLhrRIZgS4HAb1rDIn9gjylBeUIuUTJBtBMKiDd/Y5eogG7pdTY/XagsgTPlSN6IJpbJ
 nS/2JFB8RqqVfiyGGUzqktbaFzzxcp3bBde5YQwXcAN1SQ6nu1q+DekJXoGheehZMFna
 I3ZwqdHzbZCicFGoIuK740/FspnDMM1QTq7IRtTRtNfpJ/t1D6Bw9O89LzXzSQhN2nI9
 NYuw==
X-Gm-Message-State: AOJu0YyZ6ahXm9cYcsIOI6g2ow9wsqgf+lAKjiix3P1RssOPQ27BqI8h
 HqnGhO7V/EcnmSuaSf/MzrZqCIYUvrj7cuBQ4uI4YLTZMAWdUwKy+HO6nPgp+ZJqPkLrwzDYKP9
 dPPC5++M=
X-Gm-Gg: AY/fxX4U+mpynRsWFpakyJvwS9FldBTxxPCZerj/JpXRYvSopCocJPvxugDGKt1jSbQ
 Yp6nLf3fDWxfZYpYF4PqpjwOLDabPGuX4dEv0hFBLd0s6G9gD2CfuaA7PbHFJP4ClmwgzfLtryo
 R4+dd2ipKTf73SlpYM4Nn/HTxt7i6wVYNvNB4V1ScnehXT5qSWPj4scnRLvOr3d05Ac7zBtjKPc
 +rwNFj75sJnkIVPbNHvMZIPmzgMncZkc7CJcfHzH2/JFYnHvNIEn3t0shGBxzcH6EPyq65mi05R
 eCuKhuZv85R9NwtmnuyS6wfGMjY4OrQDDcGnbnPWiEWgPdkrPihNr6vclMLpKMtrREyc1D0Gz3k
 ASN/fd9KaI3hfU8/DNhkLTiaDBxX7tqw56VsQvFDFfurSmS8Nf3LnxtQrQHdXmMET+JuHPIZWEa
 O9U9KifBZsEptZgQrwnyMthh06oggKfNK/+HukijSSpXp6xLZa7wNoFzp73XkM
X-Google-Smtp-Source: AGHT+IHBLkXnBef5GLH1S63AEY4RPmJTvkTMNBfUvPFgQIzEQvUor63bBZ6vIazsfKqbnAwa6CyQmg==
X-Received: by 2002:a05:6000:2881:b0:431:771:a51f with SMTP id
 ffacd0b85a97d-432c37d3670mr20691122f8f.49.1768258427610; 
 Mon, 12 Jan 2026 14:53:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ede7esm41584651f8f.32.2026.01.12.14.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/61] target/openrisc: Avoid target-specific migration headers
 in machine.c
Date: Mon, 12 Jan 2026 23:48:37 +0100
Message-ID: <20260112224857.42068-43-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header required:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-6-philmd@linaro.org>
---
 target/openrisc/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index f2853674f0f..2d5ca16c511 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
-- 
2.52.0


