Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBACBC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLX-0005GW-S8; Tue, 25 Feb 2025 13:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJS-0008VZ-Si
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:50 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJG-0002FN-US
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:37 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce319so4932523f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506732; x=1741111532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0JcBFgIX1k9qKb/9fOhS3EkBYk5j5U8LD6sAYLyZV2c=;
 b=nSNbhi5m0PdcxAAc5epohlPStF8Dpfk6TRtknGnBYDjfH6lodaqGwpklIc1oB8vCPM
 c9B+noPegFuGl3aQYcfD5Q8/PufQ4+mEjR31pBLxnpM3MxKsYQYjnbDXzAm9VHyAD/2o
 GJh9Sh0mF+R25FeKg/nYZa9Q0QuJT3lrHgbU1637PqDRbUp3AY/KOa3IaajsIkzlxYUk
 KWwLOQAUm4btWDKAnzD3hxrFrkBC2vfKW1j6tTV4ykH1lNNL7jICZuKn/EMQ+1qUFyq5
 VYRWM2R5MtuIxINRNjryG28VmqkbNinkMc0Mm5H7+hWVkXCmQlPsqPEC9KGEfI1f9hpT
 98kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506732; x=1741111532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JcBFgIX1k9qKb/9fOhS3EkBYk5j5U8LD6sAYLyZV2c=;
 b=AW6mYN+thd4p2dCbr+ibfR7IUE0gnuudcTqpoyyB2gMSZh5F/EZ3k64UQToBeSEber
 fTlSz/9LqB0QkhF4TC5nI1HoTX0avMJiVdmcnEGnc3BpQcrgInrQDcrly8Op75Ou9Guu
 H8X93C2mtZq+kJsj8RiOv3DS3c59bmrxHnSNjNCT1htYVgBaWCewkpwjBoO+MOzgPe+o
 L3lFtpgE5S8fWj6a89kBbX8339m24E7OxKM78fD3ryK4BrGI/6/Wdkss7i01qwRiQIDd
 QfpfOwR0KeVZb8Zb1Y3qEfmWOmP8cvj+q1O34htaFcPzNrCfszvoM1tgKCQWsFWuTNIt
 RdGg==
X-Gm-Message-State: AOJu0Yw+U8Lq3eMHiTlCiT6j5lsEzTga9ayIdMjMGNpOZYCKrrVlAWub
 0eQC7uTl4Y+h2ghDUvlqId2w/iaw6llIc2sctdfFfZCr4QI5Ne5ClkSw3MN9Zqu8l5pQmjyTs+C
 E
X-Gm-Gg: ASbGnctO4TEbPvOFgJHs3H2UUTIFT5VPsj/Rw8qHoQ77Yl25jMQByqsswzdnirlfMOc
 9PHZOfEAt9PHrHCWU1xrQJ+YZkuSM8lChMdhKNIgvqDgJTNY7+uk6jLaoF3iAreeIB/JdQenE0h
 HWp0Aiq8NqmbS7BCE6XKMIcyKJFXlQcGOPEkL0beF76vsY0qqRyRi4pcntZcc8GsgJOCcqbuajQ
 QJ2tZTTRaNO/jVMnDq9NAjZ3LXN5UJb3HOKrqTFMnEUF2KYJCtI6t37NIxXy23ROEnO/zDt90rs
 DcjFBUnxiV4R7TH6oLuNtEIano8/9+FM
X-Google-Smtp-Source: AGHT+IEu4eiVwgrdvNv7kdekRb+3SCqpIAxBUfSSzj63vvO6IRBlFc4VHWrQkO8l7Lg46HwHQcEBog==
X-Received: by 2002:a5d:4090:0:b0:38d:ba09:86b5 with SMTP id
 ffacd0b85a97d-390d4fa3559mr173579f8f.52.1740506732472; 
 Tue, 25 Feb 2025 10:05:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/43] fpu: Always decide no_signaling_nans() at runtime
Date: Tue, 25 Feb 2025 18:04:43 +0000
Message-ID: <20250225180510.1318207-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Currently we have a compile-time shortcut where we
return false from no_signaling_nans() on everything except
Xtensa, because we know that's the only target that
might ever set status->no_signaling_nans.

Remove the ifdef, so we always look at the status flag;
this has no behavioural change, but will be necessary
if we want to build softfloat once for all targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250224111524.1101196-10-peter.maydell@linaro.org
Message-id: 20250217125055.160887-8-peter.maydell@linaro.org
---
 fpu/softfloat-specialize.c.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8327f727861..a2c6afad5da 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -85,11 +85,7 @@ this code that are retained.
  */
 static inline bool no_signaling_nans(float_status *status)
 {
-#if defined(TARGET_XTENSA)
     return status->no_signaling_nans;
-#else
-    return false;
-#endif
 }
 
 /* Define how the architecture discriminates signaling NaNs.
-- 
2.43.0


