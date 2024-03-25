Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF25C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rofmV-0003d3-CI; Mon, 25 Mar 2024 04:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmT-0003cT-MN
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:34:09 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmS-0004Hx-Cs
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:34:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso2834895a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711355645; x=1711960445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnvubSbXLg2BWwOx87msU0XQ3d0bes7qQf5bQx35ugg=;
 b=Ya3zXQ08hPl1N1nO9fWskEhd/7zx1qmDYkOYZk93zLL/Wmgie072sewclB13BMsF+r
 wMFi2fnOoLQhD1J8A6v+WFIS+rBuY9ZX3S/6AvNvZEklsdTw2sppXCIst3tORcZW8TW5
 k58+Bl81pQqOd9Pz5mBbKe17X65V4c82E04bhWCjf7FJehfXPp91TnDdErLIuCRXKYej
 8n/DMAh3vP1KmXvXBcCH9iUkCcXNWCNgW8Anil+WytTAOpantJFav5b3813qCXKyDxwO
 VZfMnO62lFs+JPfSG94bk8MzsIIhSOPYdlvmvauJkVj7RPiKqU2V+El6WHRQbjP/hQk2
 ED/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711355645; x=1711960445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnvubSbXLg2BWwOx87msU0XQ3d0bes7qQf5bQx35ugg=;
 b=YAOmjcPW3jFkBJJprRvgFHHoSgAGqn2g+R1PhPTgufYOwChtwdY2vENbS7baoe5Qor
 7OHul1rSR/KktbxvQph90QNtlvO6j0nW7L8AOdpfr0pt7chXIwnrBvMiyka0YXqYrjop
 7EDlGK4D/C4LeP1GRnw5od+9lOtJvhFPq+bforNuy2mDVsUWsz141lCTuEwFFGKL43tZ
 VXYroAbhcBGowM66mcPozj6zKeUP1YEWwP/i8oZE+Fa4oJcvKAsCIB9yKUzxH5Eitxub
 liyJFBN2D5BosFw7fsLDidqBB/tv8eEwBo20PoQXn9i2EAgUdQCjRuJF6+NKChd0LNQk
 mJpA==
X-Gm-Message-State: AOJu0Yy4SARo+v2UOW4R/KgjJrD4Pt5d+DxgEPa+tA1ltjox8len+WNU
 y8XDfOIjIHLxF/OJyPl4Mf1Wln5wu8/qHp3AlJebXK5PKJ+d+x/x83OfqMkKeCA9qdBnc9ngaLx
 d4A1eaFyyCkWs7jVSShgi5OXZczRzg7Rks5rjc8WKuwofB3snsqNkf7SiN2r3Huo4/H/k1+jeZZ
 aWNAQiHrd3ZOWKw1WA/toBgXZHppZE3doTt4xPTjg=
X-Google-Smtp-Source: AGHT+IE1Xg0YRynYqVePbmvnTQJXF/LDxYmnvm7rLg7mjRFzL5NlsF+29z3s95UqhNT+R7avS5nHUQ==
X-Received: by 2002:a17:902:ea09:b0:1e0:b1e9:afb2 with SMTP id
 s9-20020a170902ea0900b001e0b1e9afb2mr6013364plg.7.1711355645394; 
 Mon, 25 Mar 2024 01:34:05 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b001e0287592c4sm4311269pln.267.2024.03.25.01.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:34:04 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 2/5] target/riscv: Expose Zve32x extension to users
Date: Mon, 25 Mar 2024 16:33:36 +0800
Message-ID: <20240325083346.16656-3-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325083346.16656-1-jason.chien@sifive.com>
References: <20240325083346.16656-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 851ac7372c..6bd8798bb5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1473,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
     MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
     MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
+    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
-- 
2.43.2


