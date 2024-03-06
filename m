Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEFDC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhum8-0006RK-UV; Wed, 06 Mar 2024 12:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhuly-0006OP-6w
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:42 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhulw-0004Hk-Am
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcd6a3da83so213765ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709744978; x=1710349778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BatQI6PUZGO1KNqgfU3RtFkXz7my1gBF9/eXeStE9J4=;
 b=mWuWQc26f9CCMX6Wb+giTei1QIEuPFiijOJdAn9IgcO9bM/sCH5synWbrrKlwPEC87
 0OdA3brUo+kmIdpmztbzEs/+r8ZnE02uBXQs/by+Aa9Rqh+IhqnBzLPljVDMKVoVp2gz
 lV+lhi3+h+x+YAA/JgNnDOVrZEbWiLTjmbM/ZKQxnBi5w3uM8tyvaA53WWUl8MrrFEaG
 HBiww+14oe2pxOhy7dCQZFg9R23oKlEdfdAQ5Z9ZIyZX0GdX87R0QffA4v7Vd9bDAdso
 uN2o8Zjb48Bhzu6DWTm7Di2LhdHBwhrT0uWlcEVNU+CQJ2IzNgURlCoLnIdlK48KkDRI
 nlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744978; x=1710349778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BatQI6PUZGO1KNqgfU3RtFkXz7my1gBF9/eXeStE9J4=;
 b=tX5u7hkwJdluRd3s99qF4MstnqWwgowmlJXxP3fO0jy2zQplYUfgoTqQnNoknw8koC
 ut6GzL3510YqPTBpZt5dnjXdMm1ytxOkxgnOjLVJAhyJl2Kt/IXirHg0oEeTowxysAu5
 3dVryzLWLDPdMTG/cTYwgLj9/i6y2de+JzDNp/iso78QbUAs/55uwrnSPeHqtzp4hcwl
 dLUGG5bTO1AAM3BrKFumymaUzrv1/dFJAJ0WLnu4yTvFWsgwsi66JMz+zninH1UNR0KC
 872bCxacCBpn8nV+roB6PsxCondenozZwUZkfQVvnMRnM2MMQm0wGqcrUTbHtoN0nzYa
 NQpA==
X-Gm-Message-State: AOJu0Yz0iGW/Yb6JG28RavvANAUkHlK1yiHByzzBeABBksxKjoWrQpKV
 hf+Ayqej0V04O6Cs/A5OmGJ1VwWdKxp1sefahBzXHa7TvSnrpQ+93jv14cqvOPY9fq2UpECtWAX
 205qiW3Yk9QNu8hhQjlyjXF4hFT/3NxwSiN6MZCwwYt5yaJFhC+71z9/WG0sWv00DBX5WsBAX5v
 xgnkUxXt18Gore+UTS1Ze0LsASNRL3u9uZmvEri5M=
X-Google-Smtp-Source: AGHT+IEtkaaKi/elR6F0A30iDjwvQoWOBsS5TrBwrh3CaBuhK69mfm4UGuB04bnFsfCSNYyXOVVDPg==
X-Received: by 2002:a17:902:c40c:b0:1dc:8eba:42c3 with SMTP id
 k12-20020a170902c40c00b001dc8eba42c3mr6891686plk.23.1709744978371; 
 Wed, 06 Mar 2024 09:09:38 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170902e74800b001dd091cbc4esm7230076plf.181.2024.03.06.09.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:09:37 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 4/5] target/riscv: Expose Zve64x extension to users
Date: Thu,  7 Mar 2024 01:08:37 +0800
Message-ID: <20240306170855.24341-5-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306170855.24341-1-jason.chien@sifive.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8b5d1eb6a8..58b2a94694 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1473,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
-- 
2.43.2


