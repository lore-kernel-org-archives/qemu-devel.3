Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B63C30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 18:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLo8C-0002Zj-RP; Mon, 24 Jun 2024 14:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8B-0002ZV-Lv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8A-0005VI-54
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:31 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso3833623a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719252567; x=1719857367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y1sUyu2NpDGG39jui+mslSabiSdHVEC5l8i2enczN+U=;
 b=Kfdehs4DUKViHStLURRqGjWE2mEVxxOxRVlv95Y9K+g0kxSUzm+Eeom+nVGXnQWyNl
 vWI6gJ1Gk5xrbr6PuZiP/nKs/xwbehLfkTKPLmbBcEwOaVscbo6QPyk0l+Mq2/rsJ02E
 hCWgfeKa5N8f3hwjeUigC+SfZinA44fZNBeHKIDJI720ZkQGd4SitIFTuLDPMjUEH5Z4
 dAGg2FTXd0oqz5MPOGrpNIozJppx4ZEG8KiIZVRDA+yYH775165wh3t66BLWoLnXKn6x
 8DgqzpG/LhkxX4KYFiuNrdtFReT8eQpw0b6vBa7SY3ktFBMmm/cfUnCchwYYpM+9EIY6
 tfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252567; x=1719857367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1sUyu2NpDGG39jui+mslSabiSdHVEC5l8i2enczN+U=;
 b=lgo+UxEnqqRik+/8Hhsj3C/xmUjeeINB/zhxwX40QCPvA/xP7yZPejZ25Pp1Bgn1+7
 ALFeqEXgoE82sHP1hB2u4Dhb3lmf2MOOUSHt/lvFmJs/UkxKZXu4ulhmFw8xG+Uy7QXw
 4SWuQWltVxKQlJsX0kf2RkhpFFz6+4edqbMKde8pOEbtJ3kqtU5G/6lCQT/u4ToF1b3x
 EYrwOm0tHXY2C6Fp82WQUuXvGlee+3v8h1BvUkA6X652/YAbtgkbY98qqKh8Wc0kO2pm
 pGP+QXlc+B+IP+X2KEkk2giK2rS6EA7vng5nlRm+464M8E2PZrUQa8GCOeun3EIcTFm8
 dtTA==
X-Gm-Message-State: AOJu0YxRIK/LV8DKeUTsOT07kQRPImPCZhxPRg6wRK4bFmEh8/Q/x86M
 p3WfqMP5W85twh78zTDAa2GLewyZIN2PwdzOERc0RbwE62pAWRYwT0rVEExt3zDjDkmcgGpy/ER
 W
X-Google-Smtp-Source: AGHT+IGHA3DTTprIxDPFYgRrzhHT6s+ndDFUtm77+0eMoad/OADSRVOwVD1y6N3+nkllXEESbn7GmA==
X-Received: by 2002:a05:6a20:33a7:b0:1b5:ac9b:a59e with SMTP id
 adf61e73a8af0-1bcf44d8c1amr5867279637.32.1719252566680; 
 Mon, 24 Jun 2024 11:09:26 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706666e9708sm4974942b3a.121.2024.06.24.11.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:09:26 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 0/3] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Mon, 24 Jun 2024 18:09:12 +0000
Message-Id: <20240624180915.4528-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
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

Enable FEAT_Debugv8p8 on Arm max CPU.

v2:
 - Revert to the original comment above call to aa32_max_features()

v3:
 - Added feature entry to docs/system/arm/emulation.rst
 - Explicitly set t=0 before using it to set DBGDEVID reg.
 - Put indent fix in a separate patch


Cheers,
Gustavo

Gustavo Romero (3):
  target/arm: Fix indentation
  target/arm: Move initialization of debug ID registers
  target/arm: Enable FEAT_Debugv8p8 for -cpu max

 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu.h              |  2 ++
 target/arm/tcg/cpu32.c        | 35 ++++++++++++++++++++++++++++++-----
 target/arm/tcg/cpu64.c        |  4 ++--
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.34.1


