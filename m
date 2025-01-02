Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AEEE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPk8-0008Fr-V0; Thu, 02 Jan 2025 13:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPjs-0007Ib-Gr
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:16:11 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPjp-0006sP-4Z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:16:08 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so16353744a91.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841763; x=1736446563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6n3Ey0BMa2IfatRxBC8ClCoxhKKjolug6BuhijhMrb4=;
 b=kNOTls45dz83dNll+S0rs90Ty2j4JjYNEoQhlcqZlVtFOe8PwTIgKhZA0GkECd1smB
 j0f7YLU1/inpx2ttdGRPlCo7l4R5myK3WLM5pfltIJUDMvaZeJTaV3+bN9LcylTP/5tH
 o1db6S6iO3C/WBcDNjDq0oNOT+Ujm12JsU9THva8ZYyiAakBEjmF19BD/Lt9v3Djh0gd
 54OuZ6HbqW1uE1TWDIr3V3aHuZBiQaqtnWpqcoUIo2S/RQzztelqnMh/Kp25RGXyalEB
 Mnt219lklnM1oaFwodciJLY/SvDAvLkG10lCigfOicuBoeDhlJ0C/GsUYrfhuNiSwFmg
 p2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841763; x=1736446563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6n3Ey0BMa2IfatRxBC8ClCoxhKKjolug6BuhijhMrb4=;
 b=leR4vd80BXJa2zQBsk2FMbzLzyR7gS98df3iQkjOUtSkC0BTkaANTZiBk6EySOBiUl
 AOb8lytwdZvxTRunC1bH6NIJokqSp9PknrEOuZhLboTDEp566w/ajdJ4YMecooy2/BDW
 sBMLjhBCdiyOMvyOFck8lskUmhmXzPPb4gYG5XZu6M0brU4SKwkPX9gFiLHNgW4L/GMW
 NUoz5WpvYzis9xXuDiarwe0ILq+SIzYEJRLnFoWnoSC5AaUWbstNF3ipEJF4bNWNN2CL
 UanEYSg0D4lEKRjK1TBYrJPWwkbwxzYiAwXYzr6Mg44eKPyQGetI52caUma/v5dCgAge
 2v5w==
X-Gm-Message-State: AOJu0Yy73uxrti2knrZeZb0HTuxe5vUD6kSUKlhtlHtIgA6JsRDimeoC
 6zmvGv9jNJXH/6f+7C0SFBKP/ir2wXS9kJ7Ylz64QeuTMeVyZcC12qTWTG13H6GUkLF38xSaohh
 2
X-Gm-Gg: ASbGncsA7O9E5Zop01/uNOXr7bs7a/Ah4rN39mpdXp3Hy7zauFwHQ4GYsOUbttYomHi
 O23fMob94M3qTL5BItB1a40jihQ2EeoLMUAEt/wehTZVNMnambiYlSrt6Jiyf4+zquf2foqVCSC
 6ziAbYR3acFls781u0jZ21n2XxFJRmDp/+MbdNkf8X88u8hw4yjPQftdnFKeZ/fH0bDOZxHH6yI
 1plGSt7nl7553BH8AMleOqunoJ25R9M2QOVFfST2qyRUS8PXrMRYq+Q431AYw==
X-Google-Smtp-Source: AGHT+IEbv6jRzoHjZUHIoSd5rezU6F6dIGTr1rLMUc0BitnFiESjNOmtuyfKKG76NnFWq2ORgcgq2w==
X-Received: by 2002:a17:90b:2e4a:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2f452e3db0bmr68138350a91.19.1735841762961; 
 Thu, 02 Jan 2025 10:16:02 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f68e4sm230148315ad.211.2025.01.02.10.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:16:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	palmer@dabbelt.com,
	Alistair.Francis@wdc.com
Subject: [PATCH 0/2] tcg/riscv: Use BEXTI for single-bit extractions
Date: Thu,  2 Jan 2025 10:15:59 -0800
Message-ID: <20250102181601.1421059-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Based-on: 20250102180654.1420056-1-richard.henderson@linaro.org
("[PATCH 00/73] tcg: Merge *_i32 and *_i64 opcodes")

While riscv does not yet have a completely general extract,
the Zbs extension added a single-bit extract.

Tested on cfarm95, a Banana Pi BPI-F3.


r~


Richard Henderson (2):
  util/cpuinfo-riscv: Detect Zbs
  tcg/riscv: Use BEXTI for single-bit extractions

 host/include/riscv/host/cpuinfo.h |  5 +++--
 tcg/riscv/tcg-target-has.h        |  8 +++++++-
 util/cpuinfo-riscv.c              | 18 ++++++++++++++++--
 tcg/riscv/tcg-target.c.inc        | 13 +++++++++++--
 4 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.43.0


