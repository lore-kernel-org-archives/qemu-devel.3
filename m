Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BD4C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsZT-0007nt-Gw; Thu, 25 Jan 2024 00:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZS-0007nl-5m
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZQ-0008Aq-Kx
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40eac352733so44982555e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706161594; x=1706766394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7pl0jBZIgLiocBT81t4z9AQLPc3Jq1Fc18MeBj1ODrE=;
 b=YXMkxT3U1ZEW1CpUDlWR11RDHkFegH0w0jySA0RYSfDXQXQqjTKaVGMdtqZ/qFp71O
 Qrqpu4X7+78IUorj4bgiZr3O/tYby/W6Ib47tV9lvmKJxax49HkR6wnP6JOuPFJE72zF
 tEVwUjQ9S+vcmHtbsAw7dnJgt7x2iWbDUUzXlWsaW1QxR/Rgef9zSu/GjsZCNypAAb6b
 RQxj5Ghng9VB5Nb5UY11TPdFZHDzMo43omtldsZsd5D1/UGxJXIkvnSh/V/ILE4nx7aV
 U8i37msl1gZ/XB+/6DtIgfWZjU4hy3d9eVGNuw2SU9PCbWcj9lhR4ZSqFiJVgX2uWf4N
 p89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706161594; x=1706766394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pl0jBZIgLiocBT81t4z9AQLPc3Jq1Fc18MeBj1ODrE=;
 b=Zal52fn+FWElXFxNfnV20e5qaMvtJl07PT/PRXYY+OifOkUb4pJd7bX2/4Y0EHXR4k
 +nibsBGg0+YO36QVOL/Fe2h0ajbZI8zuDG+y6MrBopgS0Zo9nCP8WMJPvDVzouMeTui8
 hV4v+NFI0clAB2OvXwPsxHOs2VinL/1ozDzZvWpygja3gJsSJ7dysc0fSC29HvgxFg1f
 DIOZfOQ33Ijbf6307M0jf4aBoaen1Iqp/jF6/J/w+c/QwiP3XAwTRCcAvAX7CTo2Elo8
 HZnoHEttDjHuoPQGBy09vVEP2HzGMK4/+Dwc7pUydS9Jkpo2rHfC4P5gA1/ochyyiqIq
 up3g==
X-Gm-Message-State: AOJu0Yz0lsphJZDpDcmzQkJ9qz5/FQsBkqczRBw0GAFy8QAkn5yTmJHR
 h60nBrcvj1U1+2vvqihS8yuyXVrAuPigFp6eFMIyjsqGj8AJUN4C7Msbsz5kGbjAe71dIiddFgZ
 L
X-Google-Smtp-Source: AGHT+IF3/HexgY9G1kUtw6R0Bi7Gqn3D7O1C7U00Axh1BFY6Xo7ztbpW4Nk0t7wx9TbylhcAgVEj9Q==
X-Received: by 2002:a05:600c:220b:b0:40e:75e5:4e62 with SMTP id
 z11-20020a05600c220b00b0040e75e54e62mr167265wml.44.1706161594324; 
 Wed, 24 Jan 2024 21:46:34 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c35cc00b0040ecd258f29sm1268260wmq.0.2024.01.24.21.46.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:46:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 0/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Thu, 25 Jan 2024 06:46:26 +0100
Message-ID: <20240125054631.78867-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v5:
- Use v4 instead of v3...
- Rebased on commit 53e8868d69
  ("meson: remove OS definitions from config_targetos")

Ilya Leoshkevich (4):
  accel/tcg: Make use of qemu_target_page_mask() in perf.c
  tcg: Make tb_cflags() usable from target-agnostic code
  accel/tcg: Remove #ifdef TARGET_I386 from perf.c
  accel/tcg: Move perf and debuginfo support to tcg/

 include/exec/exec-all.h            |  6 ------
 include/exec/translation-block.h   |  6 ++++++
 {accel => include}/tcg/debuginfo.h |  4 ++--
 {accel => include}/tcg/perf.h      |  4 ++--
 accel/tcg/translate-all.c          |  2 +-
 hw/core/loader.c                   |  2 +-
 linux-user/elfload.c               |  2 +-
 linux-user/exit.c                  |  2 +-
 linux-user/main.c                  |  2 +-
 system/vl.c                        |  2 +-
 {accel/tcg => tcg}/debuginfo.c     |  3 +--
 {accel/tcg => tcg}/perf.c          | 14 +++++---------
 tcg/tcg.c                          |  2 +-
 accel/tcg/meson.build              |  4 ----
 tcg/meson.build                    |  5 +++++
 15 files changed, 28 insertions(+), 32 deletions(-)
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (97%)

-- 
2.41.0


