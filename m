Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E888CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0d-0008GR-2l; Thu, 16 Oct 2025 08:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9MzU-0006GJ-8w
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9MzI-0000Xq-RB
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so345526f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617298; x=1761222098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j5JoI8Mc0kdc4AY9UQ6qwcX98nv+ym+WkOZXJtVQ8Ec=;
 b=bf2JvhJF5CtvgP/fAucvncQsufyhxQC/zM3vLP2mPXTrL72LBp8B2PAEKAt/OCl+/O
 BE0pc3OEC0w+e93kg8k+DAiRWJj8y739nZA09ecqoXYI6LGptgO2oCgJw30ParHH+xxO
 g4YIPZhmRSTjZuLQd4dcohvQt0Uv2g/2IHP++mmZgYs5pb4VoB6fzdzMm9WL3xQsDFs6
 7w+t/NWZe9b3oWcyo+uLXMRflXEXDVdn+ORW3MCaVEfK24jtzUL2f1O5btQBvKvIDYm/
 WcGhM7l1FoGZjH9XGPHIANKbcqwaFQzrJ528u7Uf/bXgKMERgMHtoNK7QzB6T062OwiS
 jtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617298; x=1761222098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j5JoI8Mc0kdc4AY9UQ6qwcX98nv+ym+WkOZXJtVQ8Ec=;
 b=G51EOxO8HOq/6Ma5Xy7w4ONXpE4tRtUmOubLSVJR9GO1Iyj5+3E+ocEQglV5Yj5BIj
 mzGPOGi1Gfmw3I5qFP2/HiWWwAf2t/wLVOMOI5XN9hTySU6YHUYCmUXsTuJC2NMkGTk8
 rrGoakxNQll3Tg42NwpXCpFdhVlZhyzbqPkI+1rWyTX3GxEzs/7qTv/ZEf88NK3haAPw
 27cst35enSsyeBPNsPerW807upRP1amU63B0tuLGwM2OtkSs4uO6EqkENUmOlKeUC4Kv
 fIlJUDV+108CLiAWX0Sx/CvzX3+YQopt9z5rsvQSfkM3gcrm6lplcIM8CzPpX6uyLDaQ
 6ihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGknqlwQfXrzvtzUiLlzWyg6a/elWgJRDHQh4bmFf7Z52KOC+X6cMVVmOWxwM3cbsn+AeI42gcb7Ha@nongnu.org
X-Gm-Message-State: AOJu0Yz9WdDeu2QOIPZTPcG82G3sCNDrYEXlfArLUYHwrMl8+/rAukZV
 /eRgfm48BPR5SMjgpNPeHxgzS+DOY+pm0lt0i4EeoDPw1FxT2lg2owt1Zyx041gjNBqe6yGzan0
 i35dF
X-Gm-Gg: ASbGncu1HrO9Gx3A6UXqyIVh+W6n0/6m2e6GAQ1vLd5ff0FyORXXugsvWTX1BlGsw0v
 b6KmMh6+TaVRd8c2SRdsFKcbePnVXv005vvXs90xUQkgHDKqpdOtNpJjc7I1gPHBK97mHoXAm8P
 qwu3cRY6m4tcvinrLa/3kIOYL3ppenUVIFu76i63h2ZWTGebM36dQzJr/PO4JN1cl7qemHoNYNR
 Cj0w+WUtLyZJT6NmYxBLRZSK89lK1X2ZaY0e9fmIJ1XtQfSXUaHSKf/tKNQPvfFCy/5vwx5vL1t
 BQGiwMy4mlng5w8pIFjMHVfspXlq4iaz/sO5tWKu6sQJhDuEpvj3mIE+ShB5QYxqIFhgxManPpW
 9u2VdDIMXwxVcpOUwSJGlmxOq8TUZv8D8Lhf0+I9agCOqy+VOVBgFVLezpvY32DCfzIKdfCxqgW
 GQD/RbBzOokw==
X-Google-Smtp-Source: AGHT+IHcZysFXQCwAEBikJfkIp62aHPwAa6z4lu2jMo7yA3IQR+WFapZx8B+nbU8tMh+BPREnNbw3A==
X-Received: by 2002:a05:6000:25c4:b0:426:ee84:25a1 with SMTP id
 ffacd0b85a97d-426ee842899mr7611238f8f.38.1760617298536; 
 Thu, 16 Oct 2025 05:21:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ff65596csm3412428f8f.24.2025.10.16.05.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 05:21:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH 0/2] target/arm: Support SME2 in gdbstub
Date: Thu, 16 Oct 2025 13:21:30 +0100
Message-ID: <20251016122132.737016-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patchseries adds SME2 support to the gdbstub. This is
fairly straightforward as the only thing we need to do is
expose the new ZT0 register in the XML in the way that gdb
documents that we should.

Patch 2 is a simple "check reads and writes" test case along
the lines of our existing SME tests. I don't think there are
any specific gdb version requirements here because the XML
should be enough for gdb to know it's a 64 byte vector.
(I also did a little manual testing with a program that
reads and writes the ZT0 value in guest code to confirm that
gdb interactions do the right thing.)

thanks
-- PMM

Peter Maydell (2):
  target/arm: Implement SME2 support in gdbstub
  tests/tcg/aarch64: Add test case for SME2 gdbstub registers

 target/arm/cpu.h                       |  1 +
 target/arm/internals.h                 |  3 +
 target/arm/gdbstub.c                   |  7 +++
 target/arm/gdbstub64.c                 | 76 ++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target      |  9 ++-
 tests/tcg/aarch64/gdbstub/test-sme2.py | 41 ++++++++++++++
 6 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

-- 
2.43.0


