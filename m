Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A629E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRkv-0003mW-Iy; Wed, 24 Dec 2025 11:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRkl-0003le-Un
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:30:25 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRkj-0004no-Qx
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:30:23 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-64d80a47491so5860171a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593820; x=1767198620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKgmwa/BNc5Q4zAyG7dP7fz1g0IU8jwP9TTBZ63ZXR0=;
 b=pj5ytyv0+TiSHDGvS/UwxanVfqX60yNrU5FvKpTMMPCHxGtumroVmzpl+H1QUTCVme
 7Q7H/L5ir6gfsNIr2+NTQscoMb5Rm4U4xuFgCVKkavSmcTpE7tU/IPaMOSbg5jMnzEnW
 0c5IrwmygKSVfKE3E2lFJ1NXq0PwWiA/bj+pefvvmETgzp/2gW49B0hXUn3hXtFr7z2A
 Q6+ESWUByMy2ihUoMtMYIglErMgTvgs1Yt6iqo43e2l4gj5ejS4rJarn57gfXE1H+SsS
 E2L83JPjCtpexvCTpBRsMNvUNNLhDWTI8z4XsRAnFuLpABW58b9MfPOKlZhgHyvis01/
 eTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593820; x=1767198620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgmwa/BNc5Q4zAyG7dP7fz1g0IU8jwP9TTBZ63ZXR0=;
 b=jV/pVsygJ7Mwj+DWFZj3Z+hJkGCEAh6FVK81ceEIiFizb/BUCp7DcYVGqGpEEz2Xxw
 G6nhhUq9KS9jaFkDU7Bg3iB6+3PJXuh2WZoyINR5bP7o+JhnUOeXXesz2I/bP3VxQ2Pf
 F/1vxc9zBmAsOg7EGahSZ0IoT4HkmQMcUdQPumlvkEMY27f2ib8KMALY8FVQP3MKp9mZ
 Usy09f24QBN323raoko5pWTgU4uwXrnGwpdH2KH2eY3AfyYfUzRpJoFLTGszrnK06CW7
 /+ajczPXP1IVJziUVp80/A9JqTAkEMWrjV9VAMp9MYdPFCz8aGBZGz2QaP/PqEkOahHa
 zgLg==
X-Gm-Message-State: AOJu0YwyCVDZXPunyQM4HIzkdLYmIYApjpRcQBHlcgGqXePU5J35MCJv
 T7IW46xFyPoJJZw4efPKgoOYTcfOnM9bLuJvTIe+H0ulVZ03pZqKcZZfvfZ38NSSQrz5zYQKwwa
 RP+bmk20=
X-Gm-Gg: AY/fxX4Qh5hq37GdqvFNoarq1zrBPHYl4d7wmixlBjqo6NCs3cSdM0cmv+j36zNx7YV
 MPZkTypVWF3aOas5Rc5xLvTcb6zQZwRK//qOSvhedZLf7Iaak6FWgH5uT3OvlF+/ozXi72KSTjC
 mxp4ZmR/3HCBqgOrSLtYCBzzNKONMAoFWR3cdw9SjwbmlyA2RDPQy2q2dbA7dgjqSE/SlH8koYt
 sXwdh5+EpmTNLcgdsSpAvvN5rEuQrz2EoRMhH7hzC3F9UzsqtSgKH1m9L9PrL61VjwEKvGpXxIR
 ugw6JslbfMXrhFVGGTFuzotFVBu+VjJGCzlElO+Zg7N3Z2109++089Qj0Q4BivtUyT9P3FZd4tf
 wXPJOgQ2v2tOtP2MPPjw2wSIm4PTY8IOfYdTHsccxJ7owc+LOQdcJwLloAmN0EB5L6FqXQKi/eW
 6fGqy3iCFAUmfGYciS8XbtqJQE4TbdCvU4dgIqJMGfdIMDHgQ2SLATmsA=
X-Google-Smtp-Source: AGHT+IGedUzYaMz/H5J+Zumxf1mMk8XeTE2ZDc5LuzYqUzLsluynaIK/QtDHagcwcdV94gOgRqWe1w==
X-Received: by 2002:aa7:c4d4:0:b0:640:e7bc:d3ce with SMTP id
 4fb4d7f45d1cf-64b584d6f63mr15921538a12.11.1766593819816; 
 Wed, 24 Dec 2025 08:30:19 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b90f53be0sm17093530a12.2.2025.12.24.08.30.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:30:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/tricore: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:30:02 +0100
Message-ID: <20251224163005.91137-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
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

TriCore is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.
Remove some target_ulong uses. Forbid further uses of
legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_tricore-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (3):
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Inline translator_lduw()
  configs/targets: Forbid TriCore to use legacy native endianness API

 configs/targets/tricore-softmmu.mak |   1 +
 target/tricore/op_helper.c          | 152 ++++++++++++++--------------
 target/tricore/translate.c          |   9 +-
 3 files changed, 82 insertions(+), 80 deletions(-)

-- 
2.52.0


