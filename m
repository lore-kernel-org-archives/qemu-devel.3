Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAA4C55162
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpCkY-0007e8-8D; Wed, 29 Jul 2026 18:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpCkW-0007df-LN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:27:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpCkR-0008Md-9u
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:27:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caea3f742bso18619765ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785364053; x=1785968853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUFi+zCctBpA2uvKv+04JwYF81yZKqzpoGjoTvWudc0=;
 b=e0/D2x9fCUfD/IX4fUKCM7MnRCC+pzn98sv0bpE0UV+it7MhvSUIsxtRXbzxoyOUbg
 by531gJAlQKB8w6BxaUf8jRtPifSYAtwve/1nZgO8ab/MaG9fGG5SdywhrfZOx+utOJy
 2aDaK+TZEbDKnF2T0gJBqI2MURh9JdTRs6iajlvLmb5m0N6SFoFNIFJ3u4uQjgrB/HSV
 qV7vUvj/7gAQhOBWPakUoIPZ2AI3eJE2FzzCZKYq/7dtz3mgWJM4LJ+auV+bELvkNRYY
 uNlRldFd6VLf+VT+8Jzde3uaVy2mQFRF8yxYDB2xx0iaTy4HzKw6HiOFhTADbYKUFaxL
 498A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785364053; x=1785968853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUFi+zCctBpA2uvKv+04JwYF81yZKqzpoGjoTvWudc0=;
 b=Yv/bqH33Ht0rBBC+N+DNbuuMzVCaejqPNGpX/FsS7XsCWI8f1CNWpYlCCJOeUEIXXl
 +ho6YW4fkCtLv2fUOWA7v9RZQcJqNNnDkDEmQxNbg0KyzIzmKlopc74QqHuv1tYA2SXg
 mYsg/gdkY61Bl/Cd88erYy7dO4qpow/NNvbmSmu/4CuDoC4k+IvSbvBsANd52wICqlBj
 y3ufn7/5mHquGrOg4ePfSQfk3ghR4KmIbkZHIFJm8lGxQgOxO5lv44UFqGpE092kcI42
 xSPhy/snY92b0vzRVaw+xmQIj7s+/WpcrXQFotNEBrt1mTjOZh8B/Gdp8j6ng4ecDw3w
 6S9w==
X-Gm-Message-State: AOJu0YxuuwOPlT3wT4UpXk3s8B/4gBTqozGuh278JT2LKa42C9zomVkZ
 38TXyjUXsZmKTl8STV6QN+X3Ha1HXbHMqNdgfIY1Ghv7wFmp1eLPOYkzMX0j/7cC8U5KG/LPlV1
 N9e7m
X-Gm-Gg: AR+sD10d4k8u0+pX/hHnLGxe1XjLLbj3gmUHiHNNScYwL1p0Ws4FytTmHD3HvO7/KX0
 XZ9zNhjey00AxWnUe+tRQ8CmF9aQ+Tx0qw0K3MHt2aLdatMxfGCEAcJ6rrxxGENmso9IXBXPOJZ
 BLHgiL3LWnfUku3tMawSrdQnCboLAc+Mv0wmcKKdG0hw1digYV0ApwyBRN2Z13oQ9oEeO/uC0ZM
 9Wo/tBTp88xOpvDlLjsYyDqVKu/3QapNm6mFtAycpejQCM5tBxWviWLYF4imBMGN02zI/1d9B7C
 w+6VtZXRUeSuOj9mxf+W49Z7i4qTyjFni9RWlUv8gc/cb/TTP7FWPkwnGSacB9cDTAgsjIoQN52
 3PrBMAGQADLYxmafcPng3g7B4m7Ecw4pr/7JRJ49mhAhcs2DxsIAmdM7+QuNE27Yv/JjONTfc4e
 sa7Y9BFl5MvJsgAeNxb97Jete1RV+55VvgWYTSDgPHtkjj7BrBQlTYfHWswjejNDUwGF2EE6sp7
 wOsCrlajfF/8P9whqqF
X-Received: by 2002:a17:902:e783:b0:2c9:a9c0:80b6 with SMTP id
 d9443c01a7336-2d035d155e2mr1622435ad.34.1785364053383; 
 Wed, 29 Jul 2026 15:27:33 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bca9d7sm17159035ad.52.2026.07.29.15.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 15:27:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	2358543632@qq.com,
	quintin.kong@qq.com
Subject: [PATCH 0/2] tcg/mips stable patches
Date: Wed, 29 Jul 2026 15:27:30 -0700
Message-ID: <20260729222732.12927-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Supercedes: tencent_E2269E77D2CCF40AAE3E69F67780397B0A0A@qq.com
("[RFC PATCH 11.0 0/2] tcg/mips64: Fix shifts and unaligned loads - [DORA-B]")

Hi Quentin, thanks for these.  Note that I cannot even compile test
mips64 anymore because Debian buster was the last os release, and
buster has package versions too old for qemu.

I've fixed up the html damage from your mailer, reviewed the changes,
and have changed the second patch to fix the address inside the called
function.  If one wanted to backport the fix all the way to qemu v8,
one would have to apply your patch in two locations for mips32.

Michael, the first patch applies cleanly from stable-10.1, and the
second applies from stable-10.0.


r~


Quintin Kong (2):
  tcg/mips64: Fix variable shift operand order
  tcg/mips64: Preserve the base of unaligned loads

 tcg/mips/tcg-target.c.inc | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.43.0


