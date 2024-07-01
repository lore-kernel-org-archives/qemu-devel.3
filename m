Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149DDC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO78W-000304-6i; Sun, 30 Jun 2024 22:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78V-0002yS-7w
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:23 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78T-0000DQ-LB
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:22 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c8e7553c9eso1794296a91.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719802280; x=1720407080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3N6rPlpvzYKdcGfQuTrjYcbyNAlpYXYp9ucQoujl0c=;
 b=MBMM8ZAQ/LynmXoslz7vX4zIJjv7/3x/6x4CHIgo1bYTDREuXGwTVqftSDsBLck1BS
 4jIqrL/fsVsaKUK6T4r6vmko274QBcSvG4/T0keJPdNv5JcSdZwtlCm0zFesTG7GymDT
 nydsCGLE9ce/Pu1HQgZqaNBhSAGzk08H/6X9zQnZ6W/HKEt5OjzhbClqi0InB8cfCkaM
 O97HBXhuljL9dcymQMSOpPfXpf0EpvoWwjYt8Ydm1ML3gyxmtZe+gcvUzeEkubnGt2p4
 8W6E/6eTUuNsnvpzHAqsNYYmLX0puJ2/bEtQqUEtCyd6XPhCCVj88+G+mhVbNYWYhaad
 JM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719802280; x=1720407080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3N6rPlpvzYKdcGfQuTrjYcbyNAlpYXYp9ucQoujl0c=;
 b=AjC4VBDKq3kwOtbra5Jgntv3I3DY9n1bBNSaftofqFDd2rJgdMgirnFtK2lukHVdEs
 TZSkz077aeG+LDf3QHK413Shjn+mIk+qlJMc99DoMLcn3S3sRsu4ot30hlbL85FRj6aw
 8vIA8nloKHJnOXiEZj/QSgnBaWvgECgcGH+dGXrSPbstogf2QrZfLpYYwF+z064d77JX
 RBIlirRFxqY6yHibT53dH2cx93+H+6uYXHEeNzvvS7n1ABf1o8CYhWx7luFuV8TKNUAy
 2aGpZ2rrv35AbBshAP49Fz5Dokn0PpTVsJclEWNWUPZHHTLN4lhg2O+bmfex3Gt428NO
 iLMg==
X-Gm-Message-State: AOJu0YzRfEYe3l+WfNhq1YuAxYulYiWNlCZJQNUum1sHMkf4l8HjDNdL
 vTPKwPiGwOC6hfZd+CA7Lhi6BB2Ej5Ym3wbLSl3q8/nLOODMCuQJ58SmvrS8+CQUleKB+ggRtSF
 z
X-Google-Smtp-Source: AGHT+IHPZokYVk3/63oBakFeipGmzM7Rak8PpTpgOviYTVmG8EuKuUj+QkvZW6Py2tfoA9HvDc67aQ==
X-Received: by 2002:a17:90a:c084:b0:2c7:c6a1:42c9 with SMTP id
 98e67ed59e1d1-2c93d6f22ffmr3648624a91.10.1719802280206; 
 Sun, 30 Jun 2024 19:51:20 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3b9349sm5531698a91.37.2024.06.30.19.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:51:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 4/5] target/i386: Remove default in cc_op_live
Date: Sun, 30 Jun 2024 19:51:14 -0700
Message-Id: <20240701025115.1265117-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701025115.1265117-1-richard.henderson@linaro.org>
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Now that CC_OP_NB is gone, push the assert after the switch.
This will allow -Wswitch to diagnose missing entries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e5a8aaf793..e675afca47 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -318,9 +318,8 @@ static uint8_t cc_op_live(CCOp op)
     case CC_OP_SBBB ... CC_OP_SBBQ:
     case CC_OP_ADCOX:
         return USES_CC_DST | USES_CC_SRC | USES_CC_SRC2;
-    default:
-        g_assert_not_reached();
     }
+    g_assert_not_reached();
 }
 
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
-- 
2.34.1


