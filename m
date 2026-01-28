Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEC6D35663
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 01:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vku22-0005WB-L2; Tue, 27 Jan 2026 20:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku1m-0005PN-W1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:07:30 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku1k-0004jJ-Gz
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:07:25 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso3033208b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769562442; x=1770167242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5zpaDtwbUmvhZ+khb9Dw1oVEF2j+B/7a3q5EMaLQTqg=;
 b=xoEWlg5bJCz/YG8n3bE2RhmWNnReGYma66EyLboVhWnEE/s7gN+7hdTHAir7jFpEXl
 UC3FZ1k32B4P/6zY3ak++xHOoOFrO3UdfXDXHkKS9DDx3ypdb1bQRrijqi/597oSVxgL
 NRrj7Stq5tuOTKf8vlqelANFG0CeB5/Ftui699evRF6HrYerG36Dyn1gh8tot69wTpU/
 8KGbM3J19PIAszkXL8wJ5OhEesQSyPTzsuktDur+oe4gaxJxQVcMFckFtm9BTGWRX4jk
 oFQw5Ejr5oBPv5Q6NplAjD9QWDZqo24o1b+0VYqxH/qX3u1ykP5+wrLDdSm65s4tO8k6
 r+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769562442; x=1770167242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zpaDtwbUmvhZ+khb9Dw1oVEF2j+B/7a3q5EMaLQTqg=;
 b=nCQc/Jrr41+cxhUlcxEvRXiPdGtQq4MRuSeQWyNeD8XebMWH7E2SElfMxMxA6RZYra
 HLulWlOQrCu47I54vNMR5UmbKhKJD3Ysq4lNxVEpoMHJVKMy6yhTNeGHwDMlRQjhkiQm
 4A8r59h+kTA5LCaI/n0Y1obVP2gRsHdbfL3jSCSl5Vnfv8on7bminQY6FTKiy+hVSO93
 saL/6B8S6iTdBDSHhoFRMyaX8tUMgcJuPAmp53dDHSY47j4O9KJ9+jDxKWVGNbAzsyZ8
 HJwj/6pExdc2CxH6GKkfcOi8zr2uzl6XH6hMiNqqWyFAsWeGKO/VO8fBfrBD6/tw0UsB
 9rrw==
X-Gm-Message-State: AOJu0YyxZQocLgvCdoPqEXjkpoKhcTc7cs8U6vtKS/nDc7xASMCfxAqF
 NBP59fiQ/BFMDVXLCsOq8/yFE41fCdwCWS2/emHF8ccdeb8kE50sA6775NKItNbzJOPkplTbd+v
 cJIOfY1Plqw==
X-Gm-Gg: AZuq6aKLMt2SDzsvJO096k+quBWe4DQS3/8eMPZFC33rNajNrzGHM1dgP2sB8RiMHo7
 Q0BlmbbnJ8pKE/bcJ8+jCmigxzhD9d8RTzWhKM1ZdmVfXOZjiN1R7qRG5vdrBFCzMUREPMgRLNi
 xMUX7VzL5OGcQkygiYBw3bBOl6Q3OzZqiQ3E7ZYzddIECH9bt9/3//6UB8wfe8BJhZ+sivr+adz
 V49ZM9JZt3oxF/Rh5gxGvL8pTEvLriAbOxDZN+DqIao3mqj7MIwsXifpPLpf7WrRSQPdqD7r3HJ
 BzBhUCZP/lu+XI4aojFegIjvwqQOfpFu5/p4RKHLMyjRmzUzxOjpAC1WM7wWwOdTFkY4dGrlSI7
 supSfYoFGsza6DzNR34hykAI1pHaqSb7sNRE7tTbDbJd8179GsxL9eezEe7PkY8Pam/4/J68L4L
 IPKpsHoMuuk9Ac8Bp2xA==
X-Received: by 2002:a05:6a00:3d09:b0:7ff:97b3:59bb with SMTP id
 d2e1a72fcca58-823691851d3mr3595298b3a.16.1769562441673; 
 Tue, 27 Jan 2026 17:07:21 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c53f6bsm719407b3a.63.2026.01.27.17.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 17:07:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 3160104094@zju.edu.cn
Subject: [PATCH 0/2] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
Date: Wed, 28 Jan 2026 12:07:13 +1100
Message-ID: <20260128010715.347776-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Supercedes: 20260123091505.20025-1-3160104094@zju.edu.cn
("accel/tcg: Fix uninitialized host_pc in tb_gen_code")

The documentation for get_page_addr_code_hostp already says
that hostp should be initialized to NULL with return of -1.
Honor that.


r~


Richard Henderson (2):
  accel/tcg: Don't pass NULL to get_page_addr_code_hostp
  accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp

 accel/tcg/internal-common.h | 5 +++--
 accel/tcg/cputlb.c          | 7 +++----
 accel/tcg/user-exec.c       | 4 +---
 3 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.43.0


