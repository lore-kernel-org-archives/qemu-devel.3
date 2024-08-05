Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682C2C52D72
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb27w-0005aQ-Tv; Mon, 05 Aug 2024 14:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27r-00051n-Sd
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:08:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27n-0006TF-Nn
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:08:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281c164408so66829595e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881281; x=1723486081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfG7K0vO2YZb8Mr7z2795N5nQIZIeeUZz/GR/ld9L/o=;
 b=NZzRJHB02aPFNmkbLJQdDjzVXVxyp6Xrtdl/BBr8iyQ2WgxybdNXivyrhT1dZAJNqg
 Wad6NhMC3osuWYFDT0EoHNxMxtyqAzZhYaeIZLpKVOPht8g+tyx1P5ZqDQtVD14xhbbh
 vTgaSMZwyUzZI94d7lL+jQqZCWlrCxTI55ZrnlPvprvHLVepmdrhbagDAPt5nR02Kl7k
 g0D6Y6ar8ep98GmtW0DTX/8cYqcbQd8zkcnBReRt2J64Is67yZlBGqRnMLgyhjCHUo0A
 Ua3c6NB+DyqrOX1SnNcMpK3iXs5QHUeFUMPbCRL7SQPB46t3PFxuEBG8K3H3DlpOKETF
 HCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881281; x=1723486081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfG7K0vO2YZb8Mr7z2795N5nQIZIeeUZz/GR/ld9L/o=;
 b=OZmkmyIDma2neFiLfSZNb8NbvcxGH23dTFnoLc3ozVqXBCC+IboeJ8eyx5wUUjPRU+
 IEIcSePR/UIK3w2fJabpVOKl5tOEzi/vOoegs1rMYJaeDmn+x2LioGaZ8+SfcDMSjJFs
 sXMWsoIvbzo0PUCx9KWNNwBqScG5yX9TyGjVr60V8nzFbx9CQgIi3vkkO3CRk20mmMIx
 b8qWm4BYWPbiRrUcs+dhda97ip2QqZ54E6tOri6RcKt8jU0bZABFeaCyTyRY3iOjIENm
 V3VVeONHFr8WJuY6B80B8z9IylxqezUfViajkX3Tcb9RkHPGAMWQby5wwzShVwNwvDoL
 gECg==
X-Gm-Message-State: AOJu0YzxSlaQ3K+7fayVOkK9ArB8wmuOSc29V0ysOncpFqj0F9NA3Z1h
 TG9zYyvXJ5GLok9HNZui7fNZdPBDFEmk78s0ncRXT8BjFsAEgx1u0YhUUkmUkFnn4tItVKIWQcv
 f
X-Google-Smtp-Source: AGHT+IEXTcU7MQ3MxoxplnGkl1wECgvnM6VpKsQM5RGiP4MIeX9BU9wrIXoqYON/TRtYYWW8Ubr0XA==
X-Received: by 2002:a05:600c:4ed1:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-428e6af1d48mr81677255e9.4.1722881281359; 
 Mon, 05 Aug 2024 11:08:01 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8ada30sm203060755e9.19.2024.08.05.11.07.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:08:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.2 v6 15/15] hw/intc/loongson_ipi: Remove unused headers
Date: Mon,  5 Aug 2024 20:06:22 +0200
Message-ID: <20240805180622.21001-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-19-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8382ceca67..4e08f03510 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -6,18 +6,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "exec/memory.h"
-#include "migration/vmstate.h"
 #include "target/mips/cpu.h"
-#include "trace.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
-- 
2.45.2


