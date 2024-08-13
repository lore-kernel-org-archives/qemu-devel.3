Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAEAC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrxx-0002fq-DQ; Tue, 13 Aug 2024 09:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdrxv-0002f7-D3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:53:35 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdrxq-0007mi-Ac
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:53:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso6304250a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723557208; x=1724162008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P6fzrWupNo9cyO01KzZOKhTGGPPu+S9ujWB0wuHVkXQ=;
 b=vUuHzoKeke1Z7ztKX7kT1FczuoRfDFgyoK40PU7nsD+WEEwk4jMQs2xXdyKYi4lnLy
 sDGjVQd8Ey8oItkMJUhCeoLd6sLZGYLuedDEuVNdVIvwOgYIYDQ8EJNGXCD2xY9BHsY4
 RtJZ5YEmePe5od38XNBKR1AQjPTouQPY/ETw0zxDyhFv+fBBXt2K5AF9MKuGDdt+k9FO
 Xou1SsCht7o+cLuMthJETapQ8HJJwIhEbj+BXGh+w7mJzfNvHBJGHBbKaj5lInLkGsRO
 CKURJnn9bPPEqZnlLi/rird7OAU5agI1xB36gcOHfTeTHGvD8q37yQ+AzaNujcJ61p4G
 lE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723557208; x=1724162008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P6fzrWupNo9cyO01KzZOKhTGGPPu+S9ujWB0wuHVkXQ=;
 b=h5SfICtWuiG3z644Y5br+9keZAUgOqOB2zJKaWg+0Fj6Ff99erKplbuA5DPtGkyXzL
 0h2wBptHLh8mXpVRxQPIqDf4JOT6vPHakrQJMTcx++s2fro/o0ptlS708btDlI5d+cbX
 XiPHZL2B0fvpzzu6162cSdgNCCOYtZYAw3BL2PD1a/6k/7g7GsqWtr2eRWnCH4czv9K6
 Qv0GyryoutlXo8MsrksxzuPAYvN/WzbGv9wFMEqOmyNZcbu4yhE4aUvgEMWGganCy9o0
 CamgNyQaKrpQMbw8NxNnNIC8FDHV7zDINB3E+AqtBgYSaoM7e4uZxAxS/XwAiadDdYhw
 UbRQ==
X-Gm-Message-State: AOJu0YyzOp1p5L1s3SQC/SpMCGEypcKG4nIlWZuLLQCAkRQiSW9m9FdO
 EjduwVMaSG8bxkgiJEYDIj7GryzY2AL7bIp7EVBWtt0J9mL/XsRDryK03hCAlAiQcS/wMCD9WcA
 ZR/s=
X-Google-Smtp-Source: AGHT+IHsMz85fksK6vE1PwLIBhqY/Qhp9B8EmlasfOVrjvO2damGNe+MSF2/clEI88gM1UZndCFqGQ==
X-Received: by 2002:a05:6402:42c6:b0:5bb:9b09:8c7e with SMTP id
 4fb4d7f45d1cf-5bd44c66d1cmr2723997a12.26.1723557207701; 
 Tue, 13 Aug 2024 06:53:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd1a5e02ebsm2898682a12.64.2024.08.13.06.53.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 06:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v3 0/2] target/mips: Use correct MMU index in get_pte()
Date: Tue, 13 Aug 2024 15:53:11 +0200
Message-ID: <20240813135313.96519-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since v2:
 - Use MemOp (rth)

Propage ptw_mmu_idx to get_pte() and use it via
the cpu_ld/st_code_mmu() API.

Philippe Mathieu-Daudé (2):
  target/mips: Pass page table entry size as MemOp to get_pte()
  target/mips: Use correct MMU index in get_pte()

 target/mips/tcg/sysemu/tlb_helper.c | 70 ++++++++++++++---------------
 1 file changed, 35 insertions(+), 35 deletions(-)

-- 
2.45.2


