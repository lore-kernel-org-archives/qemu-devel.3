Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40834C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKjmn-00046A-SX; Thu, 29 May 2025 16:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKjmj-00045L-OG
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:23:30 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKjmf-00065s-Ba
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:23:27 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4e6d911daeaso269274137.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748550202; x=1749155002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gfHuZ0E99LVLJfXThl3w1NwekVMKfh+8f/1cLy/B10I=;
 b=QflPa/uPMpovIdHoSNRs9MPpFnOCqXChw7hRqXlE0T0YiFL9Khj1RomtYrHj4mZC7L
 u8xbIuXE57piiAyQYKtHpm04QKwI5ht4Rk0kQWDU18kcSW2NG3URXjxsFhDzN0f5AP/3
 grpkpMc1gcFcVU47ttxmr/ay+DZfcvBF49dGosLIKqVRpgJGtNb7/1W2k90O6dVRMUnV
 RzEMv2X341TQkvnJiHS7M7ZPYOomrkkKQ8Jnc70Eo5OnUka8/AXlS36edTHoI+yOOPjy
 Bn+kXFfFXIi+YSGsoTOh24McmHYRuMGDtBmKYmwelEKnT6liE85FGIrSrFn07GVU7vw9
 hLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748550202; x=1749155002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfHuZ0E99LVLJfXThl3w1NwekVMKfh+8f/1cLy/B10I=;
 b=S4pXDlGsLxRToHfCR0aiGPguUufqxFthJuYO/2L1Z/tnZUTwHAWjpej/p96EAcWch4
 G8yLMp6iDm1iO9zLDKDIxAC6adUg1YVJk98VYUA700OH637z0EjSP4PGT8LJQmknF+QU
 V1SYMvbhZfRTYGZRNivZSeLU9NLQ4xzy8MrxrKecH6aesQs/AobCv4ZHadStcX/G34wU
 3AKayqylPgJgfJI8DfXx21DKm3s6GvtN1vHnmTVM1tJnP0G942v1QJQ5FjC3nQI+5yZ+
 dxvw238IE071akfVFmisAqHlEMDxwsgukXwAASOlItIxinazf9UMrrt5vavuBHOzIUCM
 D9mA==
X-Gm-Message-State: AOJu0YzgqGbdSuBSZYjpl4nnvn2vuRvbNbZQlqgDZkN++Ak9C2mFptS9
 7MUP4VKv3HB4Tbro4K8jDoEdNo8yA/kYXp7wWLqDr/3XjkqzwyafEjxvvEB774Vc6uQp02ABw8E
 gPvJZ
X-Gm-Gg: ASbGnct7nkbxq4ZSACCpXb1KB+IJCkCvXWwFgaux9qDakVk3PCqbXpzEhq2MtbzBuN9
 KsAyIk695pmnGYnVtlls155qrcZsjy+cLTenP5MRlSTkYWaGn4a2xgLUzMBlTtSEEYID9rBtR9J
 Jdj4lHPVA04hvpAynwBIIy3xAzB50pqG7w5XWk31rBPKam+bSm7XFwwauC+8GU9IxM8tYTf4nkd
 ymVrFbratPEEkCMV8h7Ea04C1NQsZbHy/vqR7icI4DYp4BeivXkMFHppmQL9EdY8OCh/wl9NtJv
 wxyhhei8MiOOMIjc3pB/AGluC1Qw6F3i9YWKVjrTIS7/yHnREat3YFHJ2qnh0ch/nFDq2e0LdAz
 lBzTpVC2z/3u0Fw==
X-Google-Smtp-Source: AGHT+IEf+EffzzQ73XC42MasVF/lbCg6Kl7q1clWdM2/5GhEayA7l119ar/KI02nyQCjSDSEettBLQ==
X-Received: by 2002:a05:6102:38ce:b0:4e5:93f5:e834 with SMTP id
 ada2fe7eead31-4e6e41b2ec2mr1485431137.24.1748550201956; 
 Thu, 29 May 2025 13:23:21 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.35.190])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a2c774asm1647137241.20.2025.05.29.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 13:23:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [qemu PATCH 0/3] target/riscv: add missing named features
Date: Thu, 29 May 2025 17:23:12 -0300
Message-ID: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vs1-xe2c.google.com
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

Hi,

These simple patches add two missing named features in riscv,isa.  Third
patch is a doc change I figured was worth doing.

Drew, as far as Server SoC Reference platform goes, we don't have
'sdext'. I guess we'll have to postpone the Server Soc Ref work for now.

Daniel Henrique Barboza (3):
  target/riscv/cpu.c: add 'sdtrig' in riscv,isa
  target/riscv/cpu.c: add 'ssstrict' to riscv,isa
  target/riscv/cpu.c: do better with 'named features' doc

 target/riscv/cpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.49.0


