Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49828D116F3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 01:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQEwZ-0001Iv-08; Mon, 01 Dec 2025 20:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQEwV-0001Id-BJ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 20:12:35 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQEwT-0007B4-NJ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 20:12:35 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3ec3e769759so1387122fac.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764637950; x=1765242750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BszQp91P3dEYYJ/R5vDOvfOm9dBJf3rs4KMkqD/DX5M=;
 b=Yh81sl3WfYiKhpJvKRvpHz5TNxmjcdDkVNivbSuw95f9SF7N+TmmUfkCtUmHEGs7EX
 Of1/hu85/1CBKfmdV72o5BWefh1V/7JULhG1AukhS6YVnetC+1DnYHJfarUfs2nXPyRO
 im5UpxqmRZTc03Jw3kBKMthgvoTeZZT7YTr19+/v/tlkTvbImWNqjOvWSvR0GjDCRLi6
 O5aaVRpOVNFhuhEzyszHKWLaNvgF+S8LdV4K3+0vFP/yzyd+VOa+3POMEW/PsqkYaYeT
 TXp56nS/A4kVVtt8K+q9bj4mfI1TDMn5C2WnNXQPFa/Am9fa/Gw6dDRZ/Gdh1/a+/oZr
 1vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764637950; x=1765242750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BszQp91P3dEYYJ/R5vDOvfOm9dBJf3rs4KMkqD/DX5M=;
 b=t3c0rTO8Yp41lY84imoC70WEXUOciFbitz8Ngc/UjgEqvULmqrBVC3DRsCgVNvUSBn
 SlaV8vU0zP0oG8OlPmCj7k6XHSblAlO4rn59Hu5qRmXwXYxUgjeVkzA7PYOQX+99OuRa
 33zFw+YzXsLmw5cXlgzI5M0fbDq/pdE8c/pQz9hCQ6hdqS1ETnwOg2bydN9HiPa2v29V
 L49alG673AndNjSXARVga/PMBMHunN+iK7ia+ADwUL19o9TqJ3cuhYzVapW0uHOi+aaw
 qWV7apI9e3QTMcRUwop0RRWcgvKmnZiQ/YvzYJGZDOK2Tqj/Nt5HB4nDl+MtKDj9mu8d
 rMmQ==
X-Gm-Message-State: AOJu0Yyq8L7cykYnfGVMFXIL+/y/raU917ktK7hIeaJyYKWSRT0H5zzF
 FknBJt47JTZIR5cKMnp2tQbS6FjWj7JOqgLONezbOIghjc00PmVoEVwGQSzMiNcRS593ulG+A2y
 /A+pFBn0=
X-Gm-Gg: ASbGncua5wZzo3yfzuqO+YEswV+PzPbhNzehoExSRM47Ts/rodyN08iaYI6ksR18N9d
 z0A7SzfvAqGBNZp1GO+YYfYJ8vjYleMcXL75qc1iPOcGN/E/7w+9p9vBAXz5SO/0W9V4h4XTgB+
 mOh9bcF+CNcU056sqMbak0M8tzOjnZg/fkHtHjCgxEgizrRz9Q2XLo7dwL8QMwv38rvWi4bLk8B
 YWDOdB6BeFmbM/b4one0XjyJdFFMYPyrd/DZOiQdWbi5SEDLycE7ERruPgpeynsLzg5Ax7L9lNC
 K0MeOhzXj7Mgc+lpDLlYgkL6BSuyzIExkTCY4LZizHFwB523uCEC9emL4b6zk4kzx8KYAIPCCMy
 +fYdeUYQhtjGzVxkkAWwOENQL+xF9tXm88kwipAh1pEVXTNOU7a1By9D0HpZB8WLYfanY79P2gi
 GqCRoiEaTKPu6mE6c=
X-Google-Smtp-Source: AGHT+IELIqdwjEGG/CyAK9aCg19tsX8VI43ss1yDnfbpidw+iRhneXBfD5+hANnEjI3gdJ94tiv75g==
X-Received: by 2002:a05:6870:c0c4:b0:36d:31f3:9f1c with SMTP id
 586e51a60fabf-3ecbe2e5246mr18328687fac.14.1764637950513; 
 Mon, 01 Dec 2025 17:12:30 -0800 (PST)
Received: from stoup.. ([201.144.25.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05bc9asm6458709fac.22.2025.12.01.17.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 17:12:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH 0/2] TCI fixes
Date: Mon,  1 Dec 2025 17:12:25 -0800
Message-ID: <20251202011228.503007-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

The first patch fixes an abort running qemu-system-riscv64 with tci.
The second patch fixes a make check failure Alex noted vs ppc32.

r~

Richard Henderson (2):
  tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
  tcg: Zero extend 32-bit addresses for TCI

 tcg/tcg-op-ldst.c            | 222 +++++++++++++++++------------------
 tcg/tci.c                    |  19 +++
 tcg/tci/tcg-target-opc.h.inc |   2 +
 tcg/tci/tcg-target.c.inc     |  14 ++-
 4 files changed, 140 insertions(+), 117 deletions(-)

-- 
2.43.0


