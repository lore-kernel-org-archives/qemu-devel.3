Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3B2E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuyh-0000qg-7X; Thu, 09 Jan 2025 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVuyf-0000pw-6u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:01:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVuyd-00043g-L3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:01:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso8933545e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1736438501; x=1737043301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0QJ4KatK6l/Y5j5t7WgOmntkYRcQFFRg/a6TUimYtoA=;
 b=d/8FK9rDFR19tdbl/iFHKCQPJ1PjCJBBVaI/cwi/pLlDGj/yRySrCIFuZvn+k4xdwB
 nRuiQJhKz011YagUS4fC88uw+837bYUecfzgdFE770g6ciMmunuG5MFfmoLAS7uaP5xc
 SB3mfFDIUvxjzgv1syTqK6dR6ObeGesgCuQkEKyuiWlIAMgJAGMG8xkKKntTUY1K/X46
 Rnl2fEDZ3Q/LTVrDbtysnUK34dd6/aZqkFCKuDdFcbbXSJ0uC2Q06b1iApFJAngKXtkt
 QCzu/GQ/tbGxeY3+ThMu6uvIbPn+nJkRbwAURY+h+j496sCr5YAXXUWuWuyz+gaaTh7z
 b4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736438501; x=1737043301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QJ4KatK6l/Y5j5t7WgOmntkYRcQFFRg/a6TUimYtoA=;
 b=RuWa8s9uiXrBkyQZnDb8Wish3cBsqPSUAIlmV9MbswKSPtcJoik7BrWfY2xHjG++T4
 Q42H6DZ8f5r0R/Jzo85HmYTRlBImdazKDw/usS0xzz4PPH6oElRU+eqYAu/FOfrhFbWQ
 uuPELO0aYj1awM7Yqd8jpi4ZGPc4e4YDBlKIf0ONIpaUiU33FdCanRIPGAYg+eAmiJ8X
 Vb6qDjVMtNE4xqMJJt0uy9GAg9gNE530HzSJJDfrGu/nC/r4FXOsyjGsZZX5zRJNLKQX
 5VIE2dR8UKwNvjvAZNYk8pE++MgPWDXQD2vwenZ8oNxywFE7z3pE2pWeswVVtWmwch7k
 Z3sw==
X-Gm-Message-State: AOJu0Yx3sI5yRzr851cxVJV3HXeUiJOL+lwerrCBZ0z7PqcFWmKJlhf2
 4MGT72sUigkZUp/YHhRID1PEYoFUj/Xmj7/iXCh57dVv3wtNyPavI38NDpz0zxbM8Qn+nhcAQ3d
 Bq1w=
X-Gm-Gg: ASbGncvtiBdXSUIeprssBtny5+4gYGQ0yHxnmIjMden68LANynB6DSFzGjMCmT75oKd
 VEPAsB9BWO0Ug/aJOFz+orDNjFRgy75SFfE5o4m4TETupPiPLWrQY7qdd5ft3tFhK6jQDMqX6wd
 vnI6Zz7n/o/UPJcjTTn5/W/j9zQWb0hRqyQB3myYJACVB42RkQoc6nJ1koOaL9mWPUHqhFwxjE3
 Bj1lhku23Zy/csAXSRWdrm3bfh2YfUStiqBbg1rfbtNuRHp/EtfrEEmWWVcS+MSUFG93yowJIJh
 CQjA7tcTPlCD
X-Google-Smtp-Source: AGHT+IF9Kjq/1ndrZazWLzL8QO0jtM6CVqFPjIudF3zz3J1fcIT/P/m/R/2N6EAkgqgLND7qY+hGEQ==
X-Received: by 2002:a05:600c:3143:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-436e26b9d45mr62535695e9.18.1736438500460; 
 Thu, 09 Jan 2025 08:01:40 -0800 (PST)
Received: from dorian.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm2201524f8f.30.2025.01.09.08.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:01:39 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v10 0/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Thu,  9 Jan 2025 16:01:21 +0000
Message-ID: <20250109160122.129409-1-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x32a.google.com
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

Sorry for the quick repost.

Changes since v9:
- Add element-wise loop to handle case where no suitable atomic operation is available.

Changes since v8:
- Add missing CONFIG_ATOMIC64 guard.

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/
- v5: https://lore.kernel.org/all/20241211143118.661268-1-craig.blackmore@embecosm.com/
- v6: https://lore.kernel.org/all/20241218142937.1028602-1-craig.blackmore@embecosm.com/
- v7: https://lore.kernel.org/all/20241220122109.2083215-1-craig.blackmore@embecosm.com/
- v8: https://lore.kernel.org/all/20250108143523.153010-1-craig.blackmore@embecosm.com/
- v9: https://lore.kernel.org/all/20250109152833.75385-1-craig.blackmore@embecosm.com/

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>

Craig Blackmore (1):
  target/riscv: rvv: Use wider accesses for unit stride load/store

 target/riscv/vector_helper.c | 95 +++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 8 deletions(-)

-- 
2.43.0


