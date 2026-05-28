Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A3CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSclM-0002MP-Tx; Thu, 28 May 2026 11:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wSclE-0002HB-EM
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wScl7-0007W5-8Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4905529b933so45706925e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982495; x=1780587295; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vrp3eKnBy+B2K+P0IWU9ZtNVlySGJBybDn0Cv7Tdxrg=;
 b=x/EFeZ1vXE8FptbsViQ/iGvrWEl9xh+wSVqOmI4nZxkQKrSj/1xOosKStYIT3KE/uH
 XvD6WmlH/Yq0MJj0gftoCfWWZwZghs2DVjybu68lGGtWoOv/JAAUu5YkwRpHM+1bs9vR
 gSrvl/wlKIHDHrY53Xy9ImKvFFfjqSqddzzcdg0DizrOpLDJRy+qQdNOW2PtRrITaKqS
 4bFPZGRBX77ulxA+IcbkKkJaZcv9Mq63vLnvtIVCBMUyc9LwpUkVh3R6TGU55hTM37i1
 l79DcYFgKXD6KNAyWvuWVFTWH49g8tZ3WaQjXvAjCe4fIckCjrZyZclrnksp1ws8WgAw
 3jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982495; x=1780587295;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrp3eKnBy+B2K+P0IWU9ZtNVlySGJBybDn0Cv7Tdxrg=;
 b=JkmPnguexGSkg9I5gkSh8pDCBT+kNahvcx1x1FZLAPOYClG47iQSr9kSr3+DrpzzO7
 lWpwpc3POOdyYvu5ZlsaM3ZicJJ52Vx3jhfzQSXVVaUo+thotJxmqIl16XYjOJ16nTV0
 g9yGI8gfFa7Z2O3C0baWfA5uWI0AfLqNy6PI5FX+DeXlhW7OiyJlJwgxDaN/JclosG0u
 KmZpAa/I0CHeRraGKCBJV7OVZJ0ZJ/Gq9QudSAlPOTEfXjBcbcZUjEBe3+ST28o4BpvX
 74opbU5eXUKrTnDTcXbYjTaEiXTvyt4ZaLLIY4lR+RNQ6h9x9gs2MbDn5VaZfqDc3b5h
 741g==
X-Gm-Message-State: AOJu0YzbyFvpnLn5BjBRk5nscCyFdncwtzlOg8BIidL6td7Qbm7Xalvs
 VqYoVgk1RRueIyZEkbLo53e+lBQQ7kx6cAe97oamg+nQRdM8eNVXzsa4pWkHD9ORb40=
X-Gm-Gg: Acq92OE8D56SWV9XIL/8DY6Tsjem8HoRiNzK/od4UNsvr+NJ/0QO4+yx7R5sZSgerx+
 IudHIVScBymtlGIaXKC0bs70ISLkxOu4IrJuM47rZGvTO8MbnlMFuz2W1X1HhGgiICuHwCh4wMW
 ndYee6jJo7MNX00KaTA0cXMtMRx88TqjEz0s5fJFDjqce6Pym2BPCwFWKeJqGtdo5Xq3gCNJkVX
 lU6CBa+sTl7SWr5G1oi+Ku4QEwzjQ58qC6YEb5CYR9z/JSnw8SrOFI62wev/e7JJkuM693FgcD5
 1OA10KgpsFH4L3sgme09u9lCoDXShX8vf+M6ir0Gjf2zkHG09w6pZDjl24QTJ0L8R4D40Q1erp8
 W3wyczFgMWChJ65Ld8L2PSuh+PL1k0LCB3NeExdDUoyKY9U31Glyu06oDORqt8sfYJEJb7OWPCO
 8wNv3yD/S0iHp8yK2fEd3yFbew3fT2UrMJqao5PQ==
X-Received: by 2002:a05:600c:4f53:b0:490:7136:ad05 with SMTP id
 5b1f17b1804b1-4907136ae08mr219106955e9.31.1779982495070; 
 Thu, 28 May 2026 08:34:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f5a7:372a:ab8b:3c01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm46514785e9.11.2026.05.28.08.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:34:54 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 0/5] target/arm: Add aarch64 GPC3 bypass windows
Date: Thu, 28 May 2026 16:34:35 +0100
Message-Id: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItgGGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyML3azcxGTd9IJk4yRdQwvzNMsU8+Q0g5QUJaCGgqLUtMwKsGHRsbW
 1AFgCkvhcAAAA
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds the GPC bypass windows defined in D9.2 of the Arm ARM. D9.8 (the 
APAS instruction) is not implemented yet.

A large part of this is testing. To test GPC effectively, we need to
check that memory accesses are causing exceptions, or not causing exceptions
as appropriate. For some tests, boot.S is altered to record certain
exceptions and continue executing the test. An alternative would be
to use gdbstub to break on locations inside the vector table and continue,
but this requires significant coordination between the C test binary and
Python test driver, so has been avoided for now.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Jim MacArthur (5):
      target/arm/cpu-features.h: x-rme now means GPC3
      target/arm: Setup new registers for GPC3
      target/arm/ptw.c: Add Granule Bypass Windows
      tests/tcg/aarch64/system: Alternative boot object for exception logging
      tests/tcg/aarch64/system/gpc-test.c: Basic test for granule protection check

 target/arm/cpu-features.h                 |   5 +
 target/arm/cpu.h                          |   7 ++
 target/arm/helper.c                       |  19 ++++
 target/arm/ptw.c                          |  50 ++++++++++
 target/arm/tcg/cpu64.c                    |   4 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  22 +++-
 tests/tcg/aarch64/system/boot.S           |  62 ++++++++++++
 tests/tcg/aarch64/system/boot.h           |  14 +++
 tests/tcg/aarch64/system/gpc-test.c       | 160 ++++++++++++++++++++++++++++++
 9 files changed, 336 insertions(+), 7 deletions(-)
---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260528-jmac-gpc3b-187f9d7cf0dd

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


