Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3C9CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqMH-0006Cu-GT; Wed, 20 Mar 2024 03:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqMG-0006CL-0d
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqME-0003ih-6z
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6cb0f782bso5527557b3a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710919648; x=1711524448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4pSOxGw1iKhj6JyuEVr4nPf5e0kX4KKw2u4riiw7+w=;
 b=i5qUIyyEuMLVoIMSvxIb0s3pH5oBFZVCr9sgbhJgtCLIEvLXbthaUuLmTN14GjKj1I
 8yHH12/+aFnO95pCf/RQZO+/M0pMUwSUp6sHlwiWhe5rL9oHTOIgBF8T6CIIfLF5uJ60
 ojMzn3wDDPTBT5uSwTtMvjq8jr0CirmTA8qbZWeAQsrdGBt3okL1hnB5OryCdHqB9IHL
 DFYE9FrFXHn80CEE9dcdiGm3OOTwVUBpDAJ2Gtyky8ypOl4Vj6LAaSYLFxB385BbCAPn
 tlEiGsmUn48ApMPL6nhA7OGlAg58IicBK3fMfXT2LnLg1nsjghe3HKbpPjf7DBptGd7V
 ivag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919648; x=1711524448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4pSOxGw1iKhj6JyuEVr4nPf5e0kX4KKw2u4riiw7+w=;
 b=YTkaEExwQaWHIXKw9b0W2MHBmNUqiYrR/Q6Iw0SNZZiDciHLYvevRTKzsaRMYNIu+R
 NGtNpu6IJhD4A8MNijhSTPS39Z4xGqPiMUuGry/MJgsxQxcrPSUnalIu4ztSnZPRE0bn
 esE9CKDlsevJw/gS5AGkAQvpjDKjYnlsGwaY/om/OhAOo1DOt08EsFDS9DgrCZyJz9ff
 21A2g2/KKXiUHQ+R5FTMx38ehoBX539n/PAfWGEcV7FGOnwenvwBy/9h+fX7Is/nGtpQ
 6ECY9Ab3iZ5BYyP6rPZABlJS6DhplpHf+mA/s6LqMSC4M7XwtMHAMPLCbUzuEgylI+G1
 B6VA==
X-Gm-Message-State: AOJu0YzGbW9PyviHB1Q54hzZ7ZB3hQoK9Y+xFX5sTE+1OwF0L7oF5zrc
 mYPbI3lWDhglvBKtKiQYbPwiUBHiOnuiJyYTUbRzRFBXeSlOtKPJ6bIVkSCUP7FwVTGEUQAzCIm
 30ESaGr8FRwyKxZIiNbv4SunDCrFPGdfWngwobSvMVde5qQxR9mGClqbVfjJtNq+5zNHlCgt8wM
 EQfHiJBE429M9nQqfV4LRYJ59MVbRen1o2Hxe30w==
X-Google-Smtp-Source: AGHT+IFYCuEmNtVd+9qnOCTZtfYOqG1HPFg+QY6lvWC3uksv5rI+PSVqHTwuWOAitDJ0Lc1zXFlFlA==
X-Received: by 2002:a05:6a00:2304:b0:6e7:2e76:5358 with SMTP id
 h4-20020a056a00230400b006e72e765358mr1233025pfh.29.1710919648075; 
 Wed, 20 Mar 2024 00:27:28 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 p10-20020a056a000a0a00b006e6b45debe8sm10811376pfh.78.2024.03.20.00.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 00:27:27 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/riscv: rvv: Check single width operator for
 vfncvt.rod.f.f.w
Date: Wed, 20 Mar 2024 15:25:04 +0800
Message-Id: <20240320072709.1043227-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320072709.1043227-1-max.chou@sifive.com>
References: <20240320072709.1043227-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42d.google.com
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

The opfv_narrow_check needs to check the single width float operator by
require_rvf.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 6cb9bc9fde..19059fea5f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2817,6 +2817,7 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.31.1


