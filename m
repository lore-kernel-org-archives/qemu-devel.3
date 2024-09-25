Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB63CF9C7D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stTi5-0006rr-44; Wed, 25 Sep 2024 11:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1stTi3-0006qa-8K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:13:43 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1stTi0-0000yF-Bv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:13:43 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca6603aso4459123a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1727277218; x=1727882018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IuVoKJWqnIMqouoapji2Px76Fbl9MmAFuv2kFoc3Cnw=;
 b=VCK/S8HSRHok4TLOk9QWX+cGrrFjQgCLMRP+H1na4vr1OIHNxBHdoZCh1aZ/Bm+OOa
 LHW8++7soR6nnuWYog1q6HQ/89Nyrh2ZwiBnM/0um3OFqIJ7mdak5DNt+mpV14jB6IvI
 GcrLKWVE2hlp86hAcnIDdykBRTTBci07ipGfUuwiim5AEft6KRmJK6PDbtiKA54J+kOE
 DEEC79kf8OCMr0uZRsgSN0UddJ1KJHlY62364LuEbhvJ5cB11M7F3Vqu31VG/maxbBrg
 MaxbENMCwaTs3fb3AL1cppMc1dKvDdrv8RQQdmPR5z9L4eX1uZdCdlB2QQazti4SPpl/
 T/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727277218; x=1727882018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IuVoKJWqnIMqouoapji2Px76Fbl9MmAFuv2kFoc3Cnw=;
 b=NMJLG4D80jnOZ1lU/t7OmS6Cd2saFiXP06pF4SLbmWF1fdIZWe7rrstLpJwCvOtfwP
 7CsLjQp+kgWcwkat3dNmVEdlwD2D0bkMYr4MFbKrp6FG7uIW1y+oXaYydf28zsH3nD6H
 W8RWW6HTdT9WbOXny02+zb0+dQZGojiBKL/Co8UGfK+sKmL7y8UFksGQ4k8fE7LizctZ
 4dLolV6+SE5eFah2+c71/3iN31ZQmDLbCjIauZQDQ4fh7Qr1PKS9qnXawr6KdfuUhDLW
 5TFvddk9kYCSNp5PIa1UH06uA8h/1vrV3n2SmrIDuYiYQL0/7Ccc3PCr1KaW86a/0MaE
 dY6g==
X-Gm-Message-State: AOJu0Yx5V0dorVmoJ1fiO3QDQpEV1h9vjpGYWZCI3H9hkJ6jREBFq0Js
 jZbNWqAICQpUNw8YmIb35UqOw9eZLlL0XSBkP0XxC9sxS1jjORymWhZH2bI9KgGkskTn2NvOSPx
 Jdlc=
X-Google-Smtp-Source: AGHT+IE3RvrlsqhfYD2aoVUy2XEza7WVlrCIXX3E4z7hQ3dCIO+6JmVjYDBwGSOmGNHD8IMeflZfjA==
X-Received: by 2002:a17:907:9485:b0:a86:c252:aaa2 with SMTP id
 a640c23a62f3a-a93a05e6b42mr283624566b.51.1727277217547; 
 Wed, 25 Sep 2024 08:13:37 -0700 (PDT)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9393138af7sm217158566b.206.2024.09.25.08.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 08:13:37 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC 0/1] target/riscv: use a simplified loop to emulate rvv
 loads/stores only in user mode.
Date: Wed, 25 Sep 2024 16:13:29 +0100
Message-ID: <20240925151330.50215-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This patch addresses the suggestion given by Richard Handerson here:

https://patchew.org/QEMU/20240717153040.11073-1-paolo.savini@embecosm.com/20240717153040.11073-2-paolo.savini@embecosm.com/#aff5f930-d291-4ff5-8f24-53291059d59a@linaro.org

about the ineffectiveness of the optimization of the load/store loop for small
vector and data sizes when QEMU is in system mode.

Cc: Richard Handerson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>

Paolo Savini (1):
  target/riscv: use a simplified loop to emulate rvv loads/stores only in user mode.

 target/riscv/vector_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


