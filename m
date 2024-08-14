Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8768C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9wm-0003Er-6C; Wed, 14 Aug 2024 05:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9wk-0003DX-Ih
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:05:34 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9wj-0000i3-15
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:05:34 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so810029466b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723626330; x=1724231130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J60q0t7oJEREUn9MgXAbqmWebPRxS9iu40y59klmL+4=;
 b=NOK0C48Y5hHVlQM9tZh9XOD5xp0wOaLATmleV+IvvnNiGYxmrNvNhz/bFijKZ91zcq
 bKUric7Al/lauEJGHEfWlAc8T9F7TlK+H8iRgxn2J0Msuo5mpGWlV/a74AsqbrPr0hIF
 QIcjDulUrhbeOZcb03Cx5j/Sm9jsukzZptoz+D/wQVuLG6+UbugLeenF+1FVoIscLG8z
 QTSTkO2ANETbWL7mSSz5DdPd/osekp8xurUZbIul8joViq2NrDgjAl456XXSUmEZxRls
 C03LrA5TXWeMJ1sKLAdM5fjdJWxCvCTtk+x5QUdFn8GTHYmWAIbnOdXQ2K+J46PT+UmX
 MGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723626330; x=1724231130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J60q0t7oJEREUn9MgXAbqmWebPRxS9iu40y59klmL+4=;
 b=p+Bqx2X5bFnbohStjMzjqxJPNLNP37DJQsYYlXCBhXulplKZJwaFfvckW/LUMa2SFq
 EMczn2qMqbb2ibIlkYoNK6C4Fren+fXzsjW7EsCjbHF+/NzbggD7mYRE5jcxo3zQrySE
 YgeEXS6FfKtCVcohv7XmCUP+iAM9uXpsTJe3wMr1t/AbyJnAUyMmf9+VMmi32YGgI4hJ
 x9wqk+l40O7puNPOt5h19zAc8iZ3hIceRQSgR24Ey/9HFOfqdq3Q1BEiF6V4HQ7M9vzI
 4ZCy3eA5QZsd3KmyISn2bcoGcxZVVsjhNOxEAP4zrmnGDOU2d+zijLRVjldVZadREmAw
 K76g==
X-Gm-Message-State: AOJu0YxJli4qNQ3FUAkaMn9XTlgB1Kl3uVPV2cF9M7Wv+ve+lNp+BXzk
 C9jQ93F0IudLvIRDKIzdMTXB2RnHSKP+clHMZO/aguZZeP8Zjb/ar3DT82zPMaR3jRQNKI9yac5
 SlB0=
X-Google-Smtp-Source: AGHT+IETae5N4tsgm2HipoKtlfcQXCXIoamqQ5zeOHC+QWXDJWi5DfDwYT5Z8NDSHHH2ry4RpxiGCw==
X-Received: by 2002:a17:907:c7e8:b0:a72:b4d6:ec6c with SMTP id
 a640c23a62f3a-a8366d6a406mr135070866b.33.1723626330238; 
 Wed, 14 Aug 2024 02:05:30 -0700 (PDT)
Received: from localhost.localdomain (124.170.88.92.rev.sfr.net.
 [92.88.170.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fedd2asm147751166b.96.2024.08.14.02.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 02:05:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v4 0/3] target/mips: Use correct MMU index in get_pte()
Date: Wed, 14 Aug 2024 11:04:49 +0200
Message-ID: <20240814090452.2591-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Since v3:
 - Fixed size in get_tlb_entry_layout (rth)

Since v2:
 - Use MemOp (rth)

Propage ptw_mmu_idx to get_pte() and use it via
the cpu_ld/st_code_mmu() API.

Philippe Mathieu-Daudé (3):
  target/mips: Pass page table entry size as MemOp to get_pte()
  target/mips: Use correct MMU index in get_pte()
  target/mips: Load PTE as DATA

 target/mips/tcg/sysemu/tlb_helper.c | 69 +++++++++++++++--------------
 1 file changed, 35 insertions(+), 34 deletions(-)

-- 
2.45.2


