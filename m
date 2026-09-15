Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF08C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6IAl-0007uS-E3; Mon, 14 Sep 2026 21:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6IAk-0007uA-Fr
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:41:22 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6IAj-0003Z9-25
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:41:22 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6c1983dfaffso3261090eaf.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789436478; x=1790041278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Gu60AZK3N33wB6lLHPUz1Ztq4UvJi4A9BdlDih4FF4=;
 b=AeSma7tPVgZNV0njbVuoaZQECbes9FmCIjXM2EaSvSef6Jo14m/NQXsRlT2m3iAT7X
 aem7a7CaJz5aTFhZu3ioGyohJsSvRnO7qkrFXDvoUVHR7s3zF3mkPbh9VnRi3/kuOXau
 ibue2wim1TQD6l4iagb4kLm/ISSWIGWWBiMFR+J7Fi58ERlY6Vj5OwZ5u432GvAmR3zx
 +H2rqaJbdl4QjVId43M6KJQDzFNWRtnxTSLPkRjNNeGELVZZqAHX1TOs3I5UgvltAWjS
 WvVTnf0EfcuucUTVaumidIw7L0LztS7TWfksqMW7ua4R6NrxEiAjq9VSejtWC2ElJuZs
 gQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789436478; x=1790041278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Gu60AZK3N33wB6lLHPUz1Ztq4UvJi4A9BdlDih4FF4=;
 b=q2b3WiekvKNwn9qjchOFt1Fn9SRTTLxSKCjr5LojwoZAmbs4z2ttg+WNWb2yGhFIv/
 Byf4hB1KDErz8cTVa8Wh8S3+C7xH0uqj81rQWSbrRrANKxPtMRXikwxD0emQmGU6utBg
 9IGvjnDTDKj9K37ssBWRAp1Uzv60mf2e/uUQdIAD3lfcF+U1zhld8sj63Do89P8dHqhT
 upSihhG9HqpRK9hOHvuAuJKGYfV8kauf5fVJ8h8d0XguxpHY1VgAmiPUkF37IYA1Cy+A
 NqLEZEU3F3AeTF5zpWoLNm4GGVP6C74WkrEQwaQRdRELPPZWSq5bHoBC4NubloF43HFx
 G7lA==
X-Gm-Message-State: AFuF++kjej8FZD2bGbeLy5146+5U0N8N8pr/9jzayi0SaW6LU29QDq5o
 2x0P7qsmdBN5E7wQ5dIkbXVAEXIYZuwSRaHWFbkfNr2vWgiJIHFcHKj1m8FuXgBDPGPEfTjeJJL
 JLBBFh/A=
X-Gm-Gg: AYBFou1yThpcElt3LLeHfgFzHYYGd/SjqN9WmxjVkm83P61otz95Yk81OjgCUPK66ud
 3cqAxG9ZOW1QXrGazlv6/lBroNqqi1aIh1zd5NMcxJ+3be1hXhZFYxJwmkFKlC7cx/5AoZhZ7Jx
 yX7HIlTcpKWXFCTpCt2WPRypV6tsRjt4vz0L2E1/6li9TIDTM5zKavu4sMFDaQEJVeOsDLqxinj
 PqAILmzy5brlIOIEoYQRHbTHFTWuCA+zf9PB7Xx0zZfmJEM6PBnq1oEDLsZiVzAnq7OICQERjRG
 076T5cHDOrLARiASL3CQT1YytegoYSJSrdZhYo4zloarKcZNfOYpX69oDTr63x+Y5t3gZ6/9zIs
 rjSUZ6eKMCVW1etJgZJOzSWJs/wO18puwpE7kkY0IbDT2uWzc/JfRBNsgGcE9z0sp6nELbRTSzU
 buRrfJVmA5m4hsXs3GgCyJTrzaQEbnWiP6OiMkGyqMEk6xwwnAaFCC6cmGnvFWwnFNyzZqQRvjQ
 MLwsA2Or1xIq8V2
X-Received: by 2002:a05:6820:607:b0:6ba:a5cd:aac4 with SMTP id
 006d021491bc7-6c542732d5fmr3110495eaf.50.1789436478241; 
 Mon, 14 Sep 2026 18:41:18 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm26351702eec.30.2026.09.14.18.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 18:41:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/2] tcg/optimize: Fix fold_multiply2 vs 1
Date: Mon, 14 Sep 2026 15:41:13 -1000
Message-ID: <20260915014115.1809286-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Keeping the test case separate to ease backport of the fix to stable.

r~

Richard Henderson (2):
  tcg/optimize: Fix fold_multiply2 vs 1
  tests/tcg/arm: Add regression test for #4448

 tcg/optimize.c            | 17 ++++++-------
 tests/tcg/arm/issue4448.c | 51 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/arm/meson.build |  1 +
 3 files changed, 59 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/arm/issue4448.c

-- 
2.53.0


