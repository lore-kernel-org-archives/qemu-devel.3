Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB795EE57D1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 04:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vao9y-0001Ek-Am; Tue, 30 Dec 2025 23:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vao9w-0001E2-Li
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 23:50:08 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vao9u-0004Ia-Od
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 23:50:08 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so10538946b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 20:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767156605; x=1767761405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HD6LriWQ/de4bVWaU96VOSqwLCwREQyFwMT9Hx8jYDc=;
 b=C4YtkLMtYZdJp5Do3/FaWp25h2TVXQUhSUQpS50FB8Ec1pMEst1ivDYW4eSydReYXc
 +a40RJspY+UIzVMyGfX54EIV54gNtVYRfCdlnACaN3FN2eA/U5j2zZRwae6rva9/vAzl
 m75CcWaOlZpUXuhdY6NNqnyWReh43vSO6aDK3E9dv2WVwJ7yUn6TwdiHT3yk1/2wT+jq
 mzSytFtMwKAt/M2zGGlFgocpcsz59dsGbYxSwbe8f9xc6xOWaBK8cPAg/Ms1uWoOCcos
 X5vbC8jrXCHyo5IYU70CnFK/Y5FEThj2EP9WAGMJDHCnZLaiME0A84IyD1QIzKSHMsCM
 47rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767156605; x=1767761405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HD6LriWQ/de4bVWaU96VOSqwLCwREQyFwMT9Hx8jYDc=;
 b=fbug0o86NJSvwY7F0+ETJ9TDyRDorQiuQ9RVRy0ZI3UZI8deyydalGRwDsJKqDN5h2
 NAtDZCk79GiF30eRE6eGHZblmTfEl663L/476aRQvnYJpICiDer8bShUPNGPZELnz9Zw
 LA/mjbnxvP4OHcd9+C6BzIvDLVCeO6vW6CBLilW0q6/PmlkRDKvV7hPYfusGKvDnyrVb
 cVKU/BZ2/Hr2kLFEQ04YSHuhSVcZ74G2XkYRfcOrDyvqdiO/Hw+I3WghchoI71l7TP+k
 pb0Py3zGOMqOFcHRfk45hi4FDdoJ+pNlpf56h1X16sGBPPxGw4SCTbui9d+XXxkrV6Wa
 vePw==
X-Gm-Message-State: AOJu0YwSugauBm9Gd27ja0JefZLlRW1j1YGbGUKREXOLk7BCAHJCSseF
 EMHT9s+6Jn5g0cUv9nEHeAS5Cfjc2G6g5rNHXSFW0PFz6KAG97+m8VSzBm2h81eJHtj41WPO6z/
 GuLgviEsvgn9z5jRHiHQOxckMTso1EbXvc+1MAIH6YSJq0QMXl7khfKav6BnaJ1rNw0TLKiE2kf
 KQw65j+ltRLMSsvFhA8xhDWNigSQ/LRNGafc4H9SKsHps=
X-Gm-Gg: AY/fxX4R2+TkVH6qFZzQatIJo5T2l7w+TEGorzB5tamjY87te6p2r2Jr9Xw4S+RQ5Qf
 N1ld70qBlFLYEgD07m/N1Sgkjrb2vdqolYVVeuMVLvSZKKZ2SJg9o8MZFdOtnoAH4CMi7tcR7m2
 WJqIjxtXpoywkpWhi/vs7kT4c/YZU8ofkm2ySX9oHXVuQ1ZffO1s/IA3ExVmIDiOZhkFP8qj/0r
 9iQYzfSu9IYYVqNZBHGikqLenhAMY4h83nEpv8xDLPT15FxHxFv/y7E23DD2Nm6YzisOl/L5ccD
 NosLb3UjN6vEeW85zDm8F7oIpMSq9IUucCMyAwUdy2dOGu7ie367RqaxlL17ZDpJd611EkluYcL
 s7+rHXL2aizUbXrqd+1t+6hc7J7lgBBXb1katcCnz7PCSRo9TlUzA4sutZ30SB/+DmYkp3b/SNS
 deANvYzL7KoSKY6MFNkI/rr9O9Oc9omuK99gbIJ0bHGasJEgaMZQ==
X-Google-Smtp-Source: AGHT+IE+0f1gyGvO8nkQlHDiESEsJzxHFb3lrjmYlljZtwlXBnFo49iONOJc8iPrOHJLP9whxRvu0w==
X-Received: by 2002:a05:6a00:b902:b0:7a1:49f7:ad04 with SMTP id
 d2e1a72fcca58-7ff642154b6mr34644636b3a.14.1767156604552; 
 Tue, 30 Dec 2025 20:50:04 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a8442edsm33981945b3a.12.2025.12.30.20.50.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 20:50:04 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v3 0/2] target/riscv: Fix PMP address alignment 
Date: Wed, 31 Dec 2025 12:49:58 +0800
Message-ID: <20251231045000.30120-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x42f.google.com
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

This series fixes PMP address alignment to comply with the RISC-V
specification WARL (Write-Any, Read-Legal) semantics.

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Changes in v3:
- Use ROUND_UP() macro for NAPOT address alignment

Changes in v2:
- Fixed commit message grammar ("it needs to be aligned")
- Use ROUND_DOWN() macro for TOR address alignment to improve
  code readability

Jay Chang (2):
  target/riscv: Align pmp size to pmp-granularity
  target/riscv: Use macros for PMP address alignment

 target/riscv/pmp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.48.1


