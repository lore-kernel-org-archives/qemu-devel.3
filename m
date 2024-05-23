Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB720C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZm-00039H-3w; Thu, 23 May 2024 19:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZL-0001g4-MP; Thu, 23 May 2024 19:09:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZ3-0005oz-A2; Thu, 23 May 2024 19:09:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd661so294877b3a.3; 
 Thu, 23 May 2024 16:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505775; x=1717110575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leNP85nF0VhOqKR15AYi1UxMrPgTQvoAv1nRyxHoBYo=;
 b=Wj4Xo5O1TZKLbA4pcDQaSynccUPmme34vLaerjC1RTv3DCq55Kmw+3qiz61wzm+1Xj
 U8efVRgmkZt+cNmc5aktpmVfN8tw0NkVbp+KFSrolqKbd7fSQaP1dwRBv2dfc/wP8GYi
 wVRNTPwVCNLYaGBRZwbnGRGFBiLWBKCfMKBT7vrfFDYfb+0jDNx7nI7ee9ycdqYSZ1zv
 ubO8Ql1wkc5jVDKFK+Ed9MPKhsS7erFbVBW5VufjsoCfZiOAIrZk6KOKqMD85jyLZyR2
 g4seQrwOEKoD1hdmYNhTp+DSDsYMyfDXYbcLVd3Y95bGJc7U8/GzA4BZmiIqFASYH/Kw
 A0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505775; x=1717110575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leNP85nF0VhOqKR15AYi1UxMrPgTQvoAv1nRyxHoBYo=;
 b=jnKRrOpZIFfHqz2hu8Lhf3LVuXjdj6y9tcoCfhmIr0pY6kTTxzeN5B/4ohVMXpssTv
 6vx5zk57tXU9lcAFJEG306TJjTuABRY3fqb4ZAREgYR32DxGlI4LhpoyVu5lGLJoB2Uv
 QWrKscuZBV+2Z5PVpl+GwlFKP2Iv9M87UHUlLv2Cj92EvQ55g9Acali6HXnrR8Lpsz+k
 AnfuFH6TP5dy8o4YIsICIvRvl5WWI+odEFaZgSD8H2pCABYoSY0R0keW/U0PwWgaEIoX
 zxE5cT44i8zHfLi4S4dQ8KY3xheDu/W1z86vLRoE57Oe9qsrZR2iv71Hj2Vlg0DoA6Ig
 kfuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh/ySVGCnkvCi65q69GBZS27J9wtBg+DRTR+zpOCLm2iDntaCX4ewD/EzNYJJVU9DkfjXex19KB/5iF810xpINEBee
X-Gm-Message-State: AOJu0Ywcyn0Ke46uJNN2Y8HpCab6CCSn7OF3ZxPXTMHhAOD6y/UfQp3q
 u52Th7iWuuztF1GcBFc4I2+NBt6IM3lo1zo2xXtHBimco+uCZNvtN9FT8g==
X-Google-Smtp-Source: AGHT+IF5ty5lw46Bmv5nOj3/D7PNOt03VdveUSNOTzlHxZiYA52A2GE2gnemuHhTdnFyIGF4W4v9Aw==
X-Received: by 2002:a05:6a20:d04c:b0:1b0:1be7:3705 with SMTP id
 adf61e73a8af0-1b212cc5089mr1217095637.7.1716505775408; 
 Thu, 23 May 2024 16:09:35 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 31/72] target/ppc: BookE DECAR SPR is 32-bit
Date: Fri, 24 May 2024 09:07:04 +1000
Message-ID: <20240523230747.45703-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The DECAR SPR is 32-bits width.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index ee01415c32..927721d49a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -792,7 +792,7 @@ static void register_BookE_sprs(CPUPPCState *env, uint64_t ivor_mask)
                  0x00000000);
     spr_register(env, SPR_BOOKE_DECAR, "DECAR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, &spr_write_generic,
+                 SPR_NOACCESS, &spr_write_generic32,
                  0x00000000);
     /* SPRGs */
     spr_register(env, SPR_USPRG0, "USPRG0",
-- 
2.43.0


