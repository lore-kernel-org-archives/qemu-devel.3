Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5688EC3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRB9t-0001kj-1N; Tue, 09 Jul 2024 09:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRB9k-0001gH-Ef
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:45:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRB9Y-0002IU-Ul
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:45:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso35106985e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720532706; x=1721137506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OHkYQ/DRu8xLqubztqioO21tM/xMAwH4d9I7ANCcWmw=;
 b=MJbwGQtPM2gG/Gec7FYmB1HQT5XzLWvzobTlzDKVuko6mmKioPo8ACJdTeyKmZ8Vz0
 dOKwGYVppLIigj2fEBdVjWEJ4ei6IMefWkPVO3j0F17Csibn3Y3cfIHlLyW0gjURyfCR
 Zlh5QDKrRrGIKa7/mhbGwA6MLHtFZ7IkLnAQ95dbiWP0x5u4bM5JkoKAWtxSlvLvKyle
 6Ibhj1HkW0GB/dc1iK73Eyp/djzyF8rV71I0OUjSXUeGn3W9UrKwl9MNtLwT4ya4Vrmw
 jpPnsoNDgNRF6pREk73i7KI1DXA9SY9Z5JARjKxJPKJOs8zYRVkP07Vlylf9/moZg3Xv
 kZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720532706; x=1721137506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHkYQ/DRu8xLqubztqioO21tM/xMAwH4d9I7ANCcWmw=;
 b=EopxPuc9y+Wizc/QRUEZR8cTVbx//3m6VmhpXVcEMvnFL9xBdeDiz+qqqS08TFSXNK
 Fa+4Yfmu3Ux0nMSELkKf/F2CEWR6g4jwVWbpy1cjV4gFDnZMKzJOFFTGlZE8okxltlPC
 OgQs7Yn3JsCESzZAMZ8feKvtUpjNQ9cg4nc1aokZ+TuODInGGL9FPDILkXuDbu1O4JT9
 RmMSLIw8NtXXI+oLY/AszldBR554trV9yuLYS/WISg00CG2w6GFtFECkhtekxLkLjmkn
 AyU6Znt3F0JwS7X5RBgkgLqRc8ioVw7yydUVuCPllo1MZ6xTkdEWv0DX57+6kZCtLYkQ
 l/UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqf6ZSMOtUKbprdfBYYl5Y5canxMl9tY2AfLrQmBLPAB+CtM//+7iMjlEXqlqUBJIklt+lvhACUd45KFh2DX6cGO5V41o=
X-Gm-Message-State: AOJu0YykGGXZ7PxYKtwCubBqCB8qlNLScz14w5uY7mQmgkctnc2HapqI
 xqTEfFWgGoj25sSWUk6leYOH3TU99Pl+OamB8cnaWN2WoAlexEVMrCY7uCkYzv8=
X-Google-Smtp-Source: AGHT+IH2eyJq8Xy8pNd1/E7q1boKqEzwlUSh5F5v+BRvrrJp08fMkTZ813kEc2t+HMPASHf8TNP4DA==
X-Received: by 2002:a05:600c:6d8:b0:426:6389:94c4 with SMTP id
 5b1f17b1804b1-426708f9d84mr17475415e9.37.1720532706318; 
 Tue, 09 Jul 2024 06:45:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f22acsm210426605e9.24.2024.07.09.06.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 06:45:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: Fix handling of LDAPR/STLR with negative
 offset
Date: Tue,  9 Jul 2024 14:45:03 +0100
Message-Id: <20240709134504.3500007-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709134504.3500007-1-peter.maydell@linaro.org>
References: <20240709134504.3500007-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

When we converted the LDAPR/STLR instructions to decodetree we
accidentally introduced a regression where the offset is negative.
The 9-bit immediate field is signed, and the old hand decoder
correctly used sextract32() to get it out of the insn word,
but the ldapr_stlr_i pattern in the decode file used "imm:9"
instead of "imm:s9", so it treated the field as unsigned.

Fix the pattern to treat the field as a signed immediate.

Cc: qemu-stable@nongnu.org
Fixes: 2521b6073b7 ("target/arm: Convert LDAPR/STLR (imm) to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2419
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 223eac3cac2..f873e8bc8b9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -520,7 +520,7 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
 
 &ldapr_stlr_i   rn rt imm sz sign ext
-@ldapr_stlr_i   .. ...... .. . imm:9 .. rn:5 rt:5 &ldapr_stlr_i
+@ldapr_stlr_i   .. ...... .. . imm:s9 .. rn:5 rt:5 &ldapr_stlr_i
 STLR_i          sz:2 011001 00 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
 LDAPR_i         sz:2 011001 01 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
 LDAPR_i         00 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=0
-- 
2.34.1


