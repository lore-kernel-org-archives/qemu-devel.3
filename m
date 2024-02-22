Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdB0M-0005Bf-S8; Thu, 22 Feb 2024 10:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdB0L-0005BW-Dr
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:28:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdB0K-0000OU-0r
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:28:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so4892897f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708615734; x=1709220534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iQ3mhDuZFxw4v/RDXonwhsB2p6WbD00VJUj071WFjs=;
 b=LWahLmuGy7nCNqkt4Z6aBANrU63/If4zuQaK+8W1+YZJDoq7fRLF0rqBJ0ArokOPlG
 8HNVcnlpzZ002pKcY4vG8OG8gbA5ruRl0xJ8PAlXz5jcFR63gU9M4FcFxMgTN6EhWovE
 DbLDjJzUnqM2Iyqa9oPhBNNgmqMwhoGdWtAeMWQAFnx3zFPPJMR4sM0ABduQPzaKPazy
 QkCctstfY2x21yAk5OCrcsWiyTStDwabMDnGW5FmTwYq/LHAGK6ajRJVblSh6arcgh1u
 T3Ugjm0+x/rOu/NqLgoET/S7oKr/F6Hz0LHldHVRiTQojGsjuZSFGa2BHNY/zDLjDrjt
 YdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615734; x=1709220534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iQ3mhDuZFxw4v/RDXonwhsB2p6WbD00VJUj071WFjs=;
 b=KXa/iaFHNLnIjZAsQvXJtP4iAXb+jZIruJ4W3AglcnEVJ4kXBIzcyJLLcU81GrH6YX
 L8X9l1Bx+rALA+LDKTp9017F1lxh/BTqx2/Iq6QbWD1b4fDitAj7IcaqMl6VVqFtSaFc
 /bZrK4ZEFIAvMgc/AElUfaH667nXOj4FzTqNUWl+Unk0U87ZIHSevs0qIY/e7t+iy70I
 A49oA0Jo+0ZVUyJUw4HKgr9M4uPyoHOO0dmrts7Eb/7j2zX7k5kdNy0QrYiy2ozydIZ5
 bMrFKpwFWn/iw9i3izhkrBQmjVqAZ1CzfAPNFc1VIjMU7F9yVUT1VOK45mPv2i2ABhEQ
 crEA==
X-Gm-Message-State: AOJu0Yx3ouNNa9HSQouwqqCF/eC6Ld/6m3z65VBhXRGt0vCUOgcY097z
 NGqXacge4m+ExCF6JFuEXKeIAdKBPhw5V/bSz0OGNy+fgLe4W1dl06KERvPXteNlpoDV++e6cDe
 Tzfs=
X-Google-Smtp-Source: AGHT+IGfPUUCq5PVNYoIWdCdzpA7d3bs8VEGCBpqm4uVQCSEwKp77DQtKfzN2y/0xTpisYXB/lZ6Ng==
X-Received: by 2002:a5d:6201:0:b0:33b:62c0:6181 with SMTP id
 y1-20020a5d6201000000b0033b62c06181mr13756918wru.42.1708615734183; 
 Thu, 22 Feb 2024 07:28:54 -0800 (PST)
Received: from m1x-phil.lan (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 u11-20020a056000038b00b0033d7dd27d97sm5885868wrf.45.2024.02.22.07.28.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 07:28:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Dehan Meng <demeng@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/3] qga-win: Add support of Windows Server 2025 in
 get-osinfo command
Date: Thu, 22 Feb 2024 16:28:35 +0100
Message-ID: <20240222152835.72095-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222152835.72095-1-philmd@linaro.org>
References: <20240222152835.72095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Dehan Meng <demeng@redhat.com>

Add support of Windows Server 2025 in get-osinfo command

Signed-off-by: Dehan Meng <demeng@redhat.com>
Message-ID: <20240222025352.58859-2-demeng@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qga/commands-win32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 87ce6e2870..9749e4e6a3 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2155,6 +2155,7 @@ static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
+    {26040, "MIcrosoft Windows Server 2025",    "2025"},
     { }
 };
 
-- 
2.41.0


