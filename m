Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C22CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOYv-00073W-24; Tue, 21 Oct 2025 22:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYs-00073G-3S
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYq-0000xl-5R
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so82862425ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761100006; x=1761704806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BggvODyv+V6+7dTdUyhB+wxSw41sK1/lfcBOB7MlUHw=;
 b=ZD13L5cjY9xI7EVG5Z/H9HiGLYa23ncNQtt7DC+H9PYY5+7NoDmKmJ64upGz9xebcp
 bHpbM54SVcAaLufQ/XgWHCYYF6Ku1qZstsoXCLZu5IJE1RFwwpTl5ps3Bsr7SFxu/D2y
 LwWfDozHHu/2ZHAf1BPL0og5gxoLhpLtM/ge2NVU8oF6wlgDMDXFKaYx5LYmlQ4mifSn
 rmp6RHWiyjWVwmEYUTJ8nl6IZnQ3f/gLCQzfVUtjz5lMenpBpxiTmQxCMIV6cktJd85w
 kO7YS/Yg8wkuBawCdf1FkB7SlkvBGJBKMrOquEeaUWzjda6UQbMM4NbxY8OhuMHM61ek
 cqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761100006; x=1761704806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BggvODyv+V6+7dTdUyhB+wxSw41sK1/lfcBOB7MlUHw=;
 b=bKJwpQ+bMSy5j+1hyO70i79Bxq4a6nGynV1eSEtBf3dVjiPj4Q5Qj7QRU7V22HS2Uu
 p3Nm5sCEQQ6pbRpJDOYItTZc6k+MOi3RYggqJQkO5tun72JYFNFc+cbbT949bCpBWnHJ
 G0Q8oKg5RnUExUWSM4w21dGZ+YVHcAisBgak05B9t2FdNmSs0dVfaTRzqbHbcEmIJAeT
 ic/ezZzi8nqexvUrhKUQW4MM6swkmnZeTsNFOLYRoS3cdK5uzCYIC80VapjtE0l8klKA
 GoZTeze998tn+TrQn5XjRGhe7Oh6jy/5xJhTMXJi3rZftcZtE9QVYAqva/ZQLsnCe9AJ
 w81g==
X-Gm-Message-State: AOJu0Yyapa/N9WOXaGTvPMZHYAhDdMgDrKSkaHhlE+V3EcKIsrXjgxPo
 DLCbo/XbtKG2kwXosS1cAm0j6/VPK4pbkxus9p55dQnhP5rOCkWi7M2uNKblKYPk8Aa6C6cD+7u
 6q0oqdhA1TLrlgcAQwHoxLRLkAhRFbznBlNYQefnvK6LWm0aAwhUA86nsFlfXzzsnkI44kD8aYg
 msIeVRr2VGNT5UzLVa2Bgsn4zKX/cfpuFHMdJ/JMOE
X-Gm-Gg: ASbGncsOgRFZCTWUVjzl7BR0rpRvFss1kU4/7/0N8vF3Sa06EorTklAj1z/9gCssNse
 n6pvSuYVGFL0X9vxbiccqN1oQsZsK8XoM/mB0a23/40aCtBZ9S8tV8dPDYCBWsBVC1M0uz7ufbV
 hUa/mbPhWT29VzK76hkFqongvzvYA4NxfGpmnZGISpsxtdCxrCJdw8EfuIx7nNlc1rqf9zR+u+0
 bxNeY/pR0rUB85OajkOcuwi6xK9dDmg2qF8C/1KVdinHXLRhzETiQBO/60rPByZ6Tco0hTixhEG
 WU4E0m6ybfhonVqPzjMberzH6rQPu8Xr0Sc/Xgz4n3vK5jSIPysh2Su5wHN3ib+0avz7onrKWOr
 8LT68cVEy22bplRTiKqgIksFEo4FtVMuyHxHlCSxmCwwqilo/6Hb4xn9qGfkrtmmmJJD5Q8zc2v
 El+94iWu74FwPJuNX+7s9ooguKjaY02EwIGUq+5fxogUtRVTIISg==
X-Google-Smtp-Source: AGHT+IGd+HxTJv0vOieGQBPeNQ348OwYAyDSOenacuD25MDOxBolBc4hwVvWnYgMGR2AhmCdQiUFHQ==
X-Received: by 2002:a17:902:e944:b0:290:c76f:d2ad with SMTP id
 d9443c01a7336-290c9cb6b61mr241086065ad.19.1761100005889; 
 Tue, 21 Oct 2025 19:26:45 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2930340092dsm4673545ad.42.2025.10.21.19.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:26:45 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v2 0/2] Make PMP granularity configurable 
Date: Wed, 22 Oct 2025 10:26:26 +0800
Message-ID: <20251022022628.41307-4-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022022628.41307-1-jay.chang@sifive.com>
References: <20251022022628.41307-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x635.google.com
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

This patch series enhances QEMU's RISC-V PMP support to conform with
the RISC-V Privileged Specification regarding PMP granularity and WARL
constraints.

Previously, QEMU always used a fixed minimum PMP granularity of 4 bytes.
This series introduces a configurable "pmp-granularity" parameter, allowing
platforms to specify larger granularity values. In addition, the handling of
pmpcfg and pmpaddr CSRs has been updated to follow WARL constraints. For
example, when NA4 is not valid due to a larger granularity, it is silently
ignored. TOR and NAPOT address ranges are also properly aligned according to
the configured granularity.

A new CPU parameter `pmp-granularity` is now available on the QEMU command
line. For example:

    -cpu rv64,g=true,c=true,pmp=true,pmp-granularity=1024

If not provided, the default remains 4 bytes.

---

Patch summary:

1. target/riscv: Make PMP granularity configurable
   - Introduce CPU property `pmp-granularity` for platforms to configure
     PMP granularity.
   - Default remains 4 bytes if unspecified.

2. target/riscv: Make PMP CSRs conform to WARL constraints
   - Update pmpcfg and pmpaddr handling to follow WARL semantics.
   - Align start and end addresses of TOR regions to PMP granularity.
   - Ensure software can read back correct values per the spec.

PATCH v2 update
Change UL type to ULL to prevent bit-width errors.

Jay Chang (2):
  target/riscv: Make PMP granularity configurable
  target/riscv: Make PMP CSRs conform to WARL constraints

 target/riscv/cpu.c                | 39 ++++++++++++++++++++++++++
 target/riscv/cpu.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/pmp.c                | 46 +++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.48.1


