Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777EAC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDTD-0007Kr-Dp; Tue, 23 Jul 2024 07:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWDTB-0007Di-Et
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:14:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWDT9-0006Mp-7H
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:14:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-427d8f1f363so29589965e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721733248; x=1722338048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=emm1dXPsiiDCghZiFJPAGLJzP7tu/YdBUknoNwu8rB0=;
 b=F+S5ev6Ec3Q1r3RMBpRm4+ZGG3TwEvQ5noa2lpfi8uT44XnbZ58oNyeJ2+FxskFwRg
 Sq28Sqx3ykrwh4lEWEHUW9kAATg4TaFLZLNO/R9er+FoRj5MvKbot9Guww3PJvxWd5PF
 zGqXlU82NmBLe6TOzb6iYrdv4n5McuZ82dJGdyz5tlviZfAku51otKW2davFRnABkeJ0
 x0rIa64a/RTT6MBPwQ5SNJ8Cw0LKpoe250m8/5bdZ3++GaqK8Ih/yW50TnB1ikaEXznF
 +fKoZ/qicTeaivD3XTWIqAd7d99H5UJ5gLu/JlEIlvzAjopdhI7VG0iFLyX2HEL9ausz
 47VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721733248; x=1722338048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emm1dXPsiiDCghZiFJPAGLJzP7tu/YdBUknoNwu8rB0=;
 b=jzQio2VLCymdFH6ABuBRDRVaucBl3iLTMXQdfmvAmTU2RtktbUZr0H1JEA4Rn7j8qJ
 +SyuqxbLUJNK8ROHSMfET3h6nFFt5Dh0kqxlvOa1CSuf09PV5cPDyT5JOFg25EAyKJqJ
 NcJrnH4v0iZJ9xzSVu1jcuobxLGT2sOY5Smbv32Ie2X02/ibzujl/ICHzaPN6E7FiLYr
 /1cGg5XYwfP0tLm2kPpb9UsY0r0ILoXcnc+KYxTg9iAAKRXA8McQyW8+quRWBE02+5jX
 4kswlIR7Be1JRXjVnS/i7YzVDkUbKC4EHjfd7hKVcGSU0UKUbEM+sEGPWzzdf8e4Ztws
 xJZw==
X-Gm-Message-State: AOJu0Ywhh+uTFIWDxE3CQAxOZxuBIgqOqVKin02JBN3tc4NiTSX2QfQm
 rpGIf9GkUI+6E6clMlZdrygLCY2a+aRd7DsYWdz/IHAO3/EaxhVk/s1aK5wlk1VUGH8DUsdmPKf
 TOnA=
X-Google-Smtp-Source: AGHT+IEWYBDyxaYp5ZRjQF7ektkbo7T5kGCplssHnTI3UTz8pEw3iv2Og9ZCIC9kbT9TVV7/1NLZAw==
X-Received: by 2002:a05:600c:35cf:b0:426:5f0b:a49b with SMTP id
 5b1f17b1804b1-427dc5254fcmr66929175e9.23.1721733247951; 
 Tue, 23 Jul 2024 04:14:07 -0700 (PDT)
Received: from localhost.localdomain (5.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a638bbsm186516955e9.15.2024.07.23.04.14.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 04:14:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/intc/loongson_ipi: Fixes for qemu-stable
Date: Tue, 23 Jul 2024 13:14:03 +0200
Message-ID: <20240723111405.14208-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

- Fix endianness
- Fix resource leak

Bibo Mao (1):
  hw/intc/loongson_ipi: Access memory in little endian

Philippe Mathieu-Daudé (1):
  hw/intc/loongson_ipi: Fix resource leak

 hw/intc/loongson_ipi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.41.0


