Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9912C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAZB-0004wh-Jj; Thu, 22 Aug 2024 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ7-0004uk-UU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ3-0007Ja-US
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428243f928cso7717355e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343689; x=1724948489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Pwg1o239tHw5GeNWwmrUQKUbQB8ts+OmOxcr++H9xA=;
 b=EmlNIVRIITaRXxUCIJQate2Qp7Sa53D1fbFsl1wtvWfVuKlgZCpvXSCuHArYz5XXmQ
 czyhncuiP1ETNCLNe4qTw6c14YzglyUYpbBW3pY1l60MpdOmPk81+mkK3/sL9mGmk/PK
 i8n0fSEvLqAIiWjo4L7npTh0q+KrLt6uXrUM514X1vYxiAuJMKZ3m0IxPMfDdfQhTpXB
 HUialNPN4iTmhl9fbnWj+UPpqBYOa3rPYDCCqEZhJ1kUUJCK/hxyj/nAdkVqD5CqxvsX
 kG0pXCfkR6qb/6N5zIvr5yp3frg8YcLwHnXuR0umDej+b8Us2PfcKVEGStUr+PrxMbJt
 4znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343689; x=1724948489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Pwg1o239tHw5GeNWwmrUQKUbQB8ts+OmOxcr++H9xA=;
 b=qXuRKMiySX9hltZaiDoH8Rdzz3Oh3yMsCBckp+aoVBsCz9m8W2Iv7FVix8CZVBKPAv
 iijC1agCg793G9x1uvCoNziLlojfIPcaboISzoQYt+kmgXGbzvy8PzpznhrTY7jSITHW
 TfPFWcgXZNSizCjLfF08tiBOHNYyo+XecUZNACGa19iY164tAMaFaAIIm5zXuOMnSIBT
 A6ovZ5QtlUCYWTQoxWRasWfcYr6HXFyVa8wtWD8jtNOmhJ3q2hRANBwjftJzwiDx2Pzh
 XxggeGE8jzbtvN1+q9/zHyt3QiqUPbIZFrCq3wb3xAHhuarrC2/zL4/gOGOgyX5G/VRm
 0/xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5uqt9KDuz53JvoUj8GHhPvA0D6gTPJ6WmCF/LCEG5vFp9N4EAEiLX6jHvhJaAE+WFYQv0TtYs+RDF@nongnu.org
X-Gm-Message-State: AOJu0YzBhKkJNFaJYlWa2T0DbHoMaLVlHFcbo+2KXYbrBOECaHbBseSD
 VKm0f7k0OO5Yn9MCOm7sOAYT4rXWjY8ElLCJIQ4fsC0DCYXe1ZZxFPfRDmWeI6g=
X-Google-Smtp-Source: AGHT+IER5WMGvM4d6yiQ/7RlTY2P76hLNDrfJ4HoJJTJSn61Rv4eTfDOJcKxtjpc5CwJzSfi2Dl4YA==
X-Received: by 2002:a05:600c:3b08:b0:426:60e4:c691 with SMTP id
 5b1f17b1804b1-42abf05796dmr39379265e9.11.1724343689279; 
 Thu, 22 Aug 2024 09:21:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5162347sm28928485e9.23.2024.08.22.09.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:21:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH for-9.2 0/6] arm: xlnx: fix minor memory leaks
Date: Thu, 22 Aug 2024 17:21:21 +0100
Message-Id: <20240822162127.705879-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patchset fixes a collection of minor memory leaks in
various xlnx devices, all detected by clang LeakSanitizer
when running 'make check'. Since these are longstanding
and not very important leaks, this is 9.2 material.

thanks
-- PMM

Peter Maydell (6):
  hw/misc/xlnx-versal-cfu: destroy fifo in finalize
  hw/misc/xlnx-versal-trng: Free s->prng in finalize, not unrealize
  hw/nvram/xlnx-bbram: Call register_finalize_block
  hw/nvram/xlnx-zynqmp-efuse: Call register_finalize_block
  hw/misc/xlnx-versal-trng: Call register_finalize_block
  hm/nvram/xlnx-versal-efuse-ctrl: Call register_finalize_block

 include/hw/misc/xlnx-versal-trng.h   |  1 +
 include/hw/nvram/xlnx-bbram.h        |  1 +
 include/hw/nvram/xlnx-versal-efuse.h |  1 +
 include/hw/nvram/xlnx-zynqmp-efuse.h |  1 +
 hw/misc/xlnx-versal-cfu.c            |  8 ++++++++
 hw/misc/xlnx-versal-trng.c           | 12 ++++++------
 hw/nvram/xlnx-bbram.c                | 13 ++++++++++---
 hw/nvram/xlnx-versal-efuse-ctrl.c    |  6 +++---
 hw/nvram/xlnx-zynqmp-efuse.c         | 13 ++++++++++---
 9 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.34.1


