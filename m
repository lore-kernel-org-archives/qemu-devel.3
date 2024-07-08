Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25B2C3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyGm-0004fH-Rw; Mon, 08 Jul 2024 19:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyGl-0004e4-OA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:59:43 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyGi-0000bh-Sn
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:59:42 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-707040e3017so3029283a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483177; x=1721087977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cCQtk4ewWl7WgPDITSsZ5PpDbONDkoK+blGGaS89AM4=;
 b=BvQYio/jpOY0Iqn+OHtzjdzEHK037A09hJVjS6cens7nRYRiIfr7GWUnS3T6PQSvmB
 Nrs7ORnFKU9cyZMfWOI1u90L2PzmKGk4apHsnzJswseAi3l5wIP3EXaCDAYzHKH8iQ2W
 70+skYhHrCHSnkpNy8b18K5iqMpAFxEQpRgoXQbBxGYrY7Dp+uomf2CT4dRw47HGl6+Y
 zLrwsp2hau6XXe+5idA4Pu1BGyedRLYMAQbQzXsLFW9DYwA1NoNgP/ORu0K5lFTZTuwR
 n+vXEe3Te6U8pXrHFuFc8+MqsQuW7fqjuggZ7XLyKtYCl+ZhpXneY7i3I17+6OhaY79W
 0Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483177; x=1721087977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCQtk4ewWl7WgPDITSsZ5PpDbONDkoK+blGGaS89AM4=;
 b=Ae6KjUSpUy6wUSXrvJQySlGyawOg3B9gq5+zM5Xp+9ZtXlQEqNJ5IxCSK64zTjxj7L
 jKlN/JuCTybTzMQVQnANl2tRozb3A5Jy5tZmFf5jgW9kjFMULdpDDVSkyOMbmJpf+Hqi
 6Nl9SxkXqXh0bYLAIHzmnae/Seqy3geVw1vmqjwzrlQ7NpawZasCfwIrBXjDLCuTUw8N
 QdKCp/7u2kay2a1zLGB0ifn3TQwFpl92VaRCJk7VTQg4Fq4YDpR6idNljTkGxXLKOs9W
 4flvalAeDegqt3cLIEftIsHzli+wl5r85idJjemnJNOiTvURcN35PxQOrOYRRxzH6mdw
 P2Mw==
X-Gm-Message-State: AOJu0Yzn32qy1IXIXCdDu/l2svf+10nZIMlE2krpGz9mI4j9RFAmdgBA
 N0+TuNBCq4fOXYLHi0WsE2YdeN+MsNAReggmjnXuI8JIDk0dLmILgM6TeIQChy2JWwR8ECQT3FZ
 8Fcs=
X-Google-Smtp-Source: AGHT+IGtdVo0BqHGuSWYXIDFZI7F8O+LU1UFYOY/fwFmCY2Od0zDqsGfUwQ+ArWSQlUpggxVrqPd8w==
X-Received: by 2002:a05:6a20:d80d:b0:1c2:9941:c9bb with SMTP id
 adf61e73a8af0-1c29941cb6amr656168637.58.1720483177539; 
 Mon, 08 Jul 2024 16:59:37 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ac0841sm4156325ad.211.2024.07.08.16.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 16:59:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.prg
Subject: [PATCH 0/6] target/arm: AdvSIMD decodetree conversion, part 3
Date: Mon,  8 Jul 2024 16:59:30 -0700
Message-ID: <20240708235936.382058-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

A small set, but better than waiting for a larger set.
It's a good stopping point, finishing the convertion of

  disas_simd_three_reg_diff
  disas_simd_scalar_three_reg_diff
  disas_simd_indexed


r~


Richard Henderson (6):
  target/arm: Convert SMULL, UMULL, SMLAL, UMLAL, SMLSL, UMLSL to
    decodetree
  target/arm: Convert SADDL, SSUBL, SABDL, SABAL, and unsigned to
    decodetree
  target/arm: Convert SQDMULL, SQDMLAL, SQDMLSL to decodetree
  target/arm: Convert SADDW, SSUBW, UADDW, USUBW to decodetree
  target/arm: Convert ADDHN, SUBHN, RADDHN, RSUBHN to decodetree
  target/arm: Convert PMULL to decodetree

 target/arm/tcg/translate-a64.c | 1155 +++++++++++---------------------
 target/arm/tcg/a64.decode      |   77 +++
 2 files changed, 460 insertions(+), 772 deletions(-)

-- 
2.43.0


