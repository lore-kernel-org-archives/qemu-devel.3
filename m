Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA1EC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK15-0005gx-1o; Tue, 06 Aug 2024 09:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0j-0004E0-Ge; Tue, 06 Aug 2024 09:13:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0f-0003Ws-TF; Tue, 06 Aug 2024 09:13:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fd9e70b592so5886315ad.3; 
 Tue, 06 Aug 2024 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950030; x=1723554830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XYyJCLzvnn8wO2a9+7AscKvhpo1XrKV7Sx5tGxYTLM=;
 b=EpS8697Nwudjvl0eIj1OD+SsMSbRFRYLSUmPnweSxc+3x10UGTlQUYGmVVaZFxW1bu
 iO1cCtXgScLNVfW07trCZ1RWtubraa+F1d7wKxQj9+AWhqV6PQ9HxicNEaPybNWpv9fJ
 aE+sPwXvedq/m0bqSIPqYL8i46KBez/xTnKv+PSh5FQEfpkK0q7HuPBIQIO211WxnnxL
 rbnF8K6I+rCUVnulG5TOeoSyFJ89R9t0CE42vY5cIUSteC3KA0HZMB58SgX4AYqoDibz
 GIuvRXDuYBsxL/tJCxmrow5lZB+m+yzapVY/gC5g9ODsn7en5GFhp9RULeD8FUsSvTaZ
 w9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950030; x=1723554830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XYyJCLzvnn8wO2a9+7AscKvhpo1XrKV7Sx5tGxYTLM=;
 b=k/cBk2UFEsHm87ABueY1Ls9WRreh5ObBi9XPzmj1qKssOr5fJF1BlTtA7twH6EKWIj
 tPrFztKciBBcXqB0xI/gB8R0wPxG0h6ODfIUq93DYBCIHuyV7o50KIBxUkyHFQqLL5P2
 vWcTxr007Y0FjOQgiBqcRgSkOHNpGWKMemp35tfKmXBl583+2wNQY6sAIGk840RFyKH+
 9qBtUlCiPE0sRuZnK1clWAw3lwi6ERVIAZD/La+ThWd3RNDgZd8O0VaKWPlm0bu8FZfe
 6URMMHNKg4qJTbTocnWBXz4uVq6I9Q0+1D1PSXITPv2uWx2ux5Ku7yUTnGpdjJCbeG1M
 c+XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCe3ctG7pqpn6U02sgx6hs8tNRGiJx/ck1Y6sL1Xnx6nEoUO1nhdN4bteF2K13sRbKeo5HVcYNrxwLVMxRxYFISObDUY0=
X-Gm-Message-State: AOJu0YwXxgGsOx3LUGyvu8cSZ7mLNJynYYMR1RsCpox9vrgV0TGlDLwM
 GpmWuz6zozJ1YsNOJ8u1TuQkbxiwrT2POwTzDq0N3BMMh0b+2NCtz/DzVdd4
X-Google-Smtp-Source: AGHT+IFVTUR2zNJzggAN83mRWimea12aZp2Q4ejiZxQJ7ffEe/QORbo0/RtebXbwUR/u4Mxnr/Ub1Q==
X-Received: by 2002:a17:902:db04:b0:200:7d10:b7c9 with SMTP id
 d9443c01a7336-2007d10b8e1mr9796865ad.28.1722950030218; 
 Tue, 06 Aug 2024 06:13:50 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/ppc: Fix HFSCR facility checks
Date: Tue,  6 Aug 2024 23:13:16 +1000
Message-ID: <20240806131318.275109-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The HFSCR defines were being encoded as bit masks, but the users
expect (and analogous FSCR defines are) bit numbers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bd32a1a5f8..f7a2da2bbe 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -635,8 +635,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
 
 /* HFSCR bits */
-#define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
-#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
+#define HFSCR_MSGP     PPC_BIT_NR(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT_NR(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
-- 
2.45.2


