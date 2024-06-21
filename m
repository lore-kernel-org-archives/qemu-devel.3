Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFCAC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfQS-0006oy-R4; Fri, 21 Jun 2024 10:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfQQ-0006oo-Sb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:39:38 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfQP-0007xd-AA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:39:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-70b2421471aso1578166a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718980775; x=1719585575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E3/WZqFWAHQRjBXjGRmHCUu9PQRrPOKBj97O5x5guDY=;
 b=yzzLSJpQZ0UgfGNpBgAeff3Y2Q1ZCGboC1CxK773WRU3/1AhQQungWR2v/O4jiu5dP
 QSZvI7nh5XeXEI1/x7rGc9KGcBfJW7Pe8g7CaCUUQyQuLVXUPucGgUDEOioOSgXmspg7
 meylWNZggKKwKhbEn/gIHn+QLN9SXLcLLw6hve7WcyEBtt9+WA7psmzlihrb88LubFz7
 GZCGPt9PRHAISZvwFc5tAg13n3IJ8PtVCp1qRMDasVu7mEazduItj8rntQGmInr74D2h
 GJO9YLRqnFoBvvLece24tvjl95tSIvS4bQgpx1FXiFNCPDcgov3W7/WFF2qwA6JeVSx9
 4UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718980775; x=1719585575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3/WZqFWAHQRjBXjGRmHCUu9PQRrPOKBj97O5x5guDY=;
 b=tUkBnVQGYoPYPuBugFgktzFcwhL3ZMqqHzj/5Yo/nO5hIPX5gZINDw0QNvMgNJ6c7e
 ij2yNuDTDuq9HUrkb1KRugXM6TEBC90DvQy/J+UctOcDp+NE8aJ9Zwfn6uX7urwqeigN
 2zkVyd3km0QDQyhV18wvz2FOdxFprHYLf/F6Wb/wD1/tA/GjSqIb5dOqI1eih5NA7qj2
 /zMIT7sXz+zOqTv0Lwpwb3pBTvTAJp3Ib3cWUdsOLJZsdpb7XFvveXj/p4mc3Eo9D45z
 sVCjeaPUucx7kJwJZnMVgboSi182m5UHTnNiv61v7n6xsRvlJhJTAb8aYmtrMvLTOqQQ
 K/DQ==
X-Gm-Message-State: AOJu0YwGAOwdg6F1RmwT1PGvjzlzpPkQytqL885ONNNSROPzBNkF33lX
 D9iVKqrYohfKXcSqag8ATHV719XXw+gRVn7Ke+8oJqJl/rN6D52LpuN/A4hjmxLh1fVGT+rARGn
 K
X-Google-Smtp-Source: AGHT+IEOnym4MGNIRaXFO5jWrGH7B5XwyS9hoyTRYicswERGf3Zov+y0o0xN1b/Id96nmYClUjC2kg==
X-Received: by 2002:a05:6a20:6a1a:b0:1b6:6d41:7bd5 with SMTP id
 adf61e73a8af0-1bcbb58062amr10674457637.15.1718980775145; 
 Fri, 21 Jun 2024 07:39:35 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1654:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065130e8e2sm1466513b3a.215.2024.06.21.07.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 07:39:34 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 0/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Fri, 21 Jun 2024 14:39:01 +0000
Message-Id: <20240621143903.3598230-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x531.google.com
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

Gustavo Romero (2):
  target/arm: Move initialization of debug ID registers
  target/arm: Enable FEAT_Debugv8p8 for -cpu max

 target/arm/cpu.h       |  2 ++
 target/arm/tcg/cpu32.c | 34 +++++++++++++++++++++++++++++-----
 target/arm/tcg/cpu64.c |  4 ++--
 3 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.34.1


