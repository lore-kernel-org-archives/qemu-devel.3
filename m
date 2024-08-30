Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A65ECA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nN-0000yV-Vp; Fri, 30 Aug 2024 12:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nM-0000tZ-M9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:20 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nL-0006yh-3C
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:20 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7cd9e4f550dso692542a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036497; x=1725641297;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVrxnpz839aLLYnBnHuqeTltn+xpAuxyl7GsFPJsO10=;
 b=xWMXYNxa3n7GucP5TMTZMfGD+5cIMKmSWwLI+vIpkTbcTgbUBdGgXa0NleknVZJjyU
 CTpuKVbchlhUUryd5PXqnxIj16SxhgzhFZU2ZJk9kusU6Jw/Qp/+huBQ/rIu8eDC6LVz
 Jp+DyrtSKxMnkNwTWguyrGQpNMilBdvIoPsO2J6/uSc8e6zu7cRnHsE1C4ZFr9tB3jir
 z2d3+Xb21m/r92ZaJiHDPLUnfVid42kAptGHV3CPjA8dL1LgNjGpiF5innzie89gbj41
 Y+JyAgQKIc8fGh1jjziuqsSdZOVQ2Qw/ZR4JZDGKTQHooicDjyobE5iFv96PbQU9OXVP
 FxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036497; x=1725641297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVrxnpz839aLLYnBnHuqeTltn+xpAuxyl7GsFPJsO10=;
 b=KQu22jN4XxDEyfPWy+K9ZHfrsPksFsoCUcCxp3nYk+mmHQlmgDnE3UYLUXMF2D7BSo
 YvuYmFnMBfTo5kmZu/mgtWviWjUbnI4264m6asOr+tM6mFuGWzrDf+0ZXYHhqqQQN8J+
 kHGQgfuHycjNp3/FPoXIBqKQB245uazOj2HlrvtzCj+nLFFG2edRBu8EHM6GOO6TziOS
 Zwy3onIeBHsaDA+mXdSGpXGcLX3+LW2mSgfZ5DPvlTiIe+NPB+asmyYTOfEBwVjkGV4k
 WFPYFlH/se9jCeJzrO0VpJ+0PgTYyxWIDAwD02BVLEjUWVSpfluQUFQt4P866KkB8fVh
 JPpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh8Dh3XtR0nIVR8st2mhSAZtzXgV28aNFopdygzlZkAlqbqvg2k+seVpztI5Lc8kh12P0qt7zMn6O9@nongnu.org
X-Gm-Message-State: AOJu0YycXGvrrd3DPA26JaKpglNvLEgkTCatIURFX9atkf3S4SoCeJp0
 PUKZxqjyFx+jcige0dzZ5q2Rb9srXZVdOcGhA3zLvQ5MnVlVOoqwMD04/AR9koY=
X-Google-Smtp-Source: AGHT+IEnLXzEHBCXXMwhrd3WkM1niPey8NG6Ui+wXmAK4ahG/q3vVVZeoJXinuCntIBoLo83KY7ocw==
X-Received: by 2002:a17:90a:a10f:b0:2d3:c0e5:cbac with SMTP id
 98e67ed59e1d1-2d856173cb8mr6966223a91.7.1725036497400; 
 Fri, 30 Aug 2024 09:48:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:17 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 09/20] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Fri, 30 Aug 2024 09:47:45 -0700
Message-ID: <20240830164756.1154517-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 55754cb374..c9aeffee4e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1481,6 +1481,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.44.0


