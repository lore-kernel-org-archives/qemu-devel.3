Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6700C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtr4-0006B0-0B; Wed, 06 Mar 2024 11:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rhtr1-00064X-SO
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:10:51 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rhtqz-00081w-5r
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:10:51 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29954bb87b4so4650111a91.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709741445; x=1710346245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=npEeaAAo3oCK9gf/6CQOc1KZa2+QOGbXENzn0EtNKw4=;
 b=NMNx874c9bSrUioPP9qsGvbQa2Cez6XKaKGewrq2nj9CS0jPSL56WmOnv5CkQ0ZIVE
 XP1ggEs6ycFgnLnHMd7YB1WU6FDh7EGo1RpyGa/gl4iAUDZiugtIzQZNtEr+Z+oKSfXh
 9h5EIQEL4mUG4ZS9KtG0qVVbf75Wzk6l0sOxTkL6CzmL9gSDXoUZygZNeHEnrgY51itf
 psp674360hjW0quN8ImHjW9hK/FTZbY1rBJFcPHkVKBDNsLwJ1vpfVTPNUTegx/Yh+XY
 +mCovhrEypcljPCbkClVtbtdkKUV7BAFbiGF5zIFBxUZL1YZeHGTbmSFv4AKkTVzDRQl
 +0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709741445; x=1710346245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npEeaAAo3oCK9gf/6CQOc1KZa2+QOGbXENzn0EtNKw4=;
 b=vDn+HBTrCf5zVG5eundT8wYlqRR8hP8CLAj4KWxwq2PuLpqxJjNjr4s21EJNVr2Q66
 0njIhU9mbLpibaI8oTdqhYATSduwhvQAyxnsot8VZcvWSk4dZdPkTkYUiau9iu/Pw1lU
 gwykDvk0ADobG2ztifqo7TurOyGezxUSRlI8Mu8aDWZnznygOrTSyPMECz4ITOc//Stu
 BWbrELkH8sxB9l8aeh9PJW/ukQkmHW5J+CDYryyGlvKJ19WdUcRsAi4Co91uLTsfNVGh
 z2D7ESNHvvEO+3XmBO4qWJjjcyPbYOrWvKCRvXDce6uYOqhmvo5yjdrLyV5fHZIHg1U5
 Wgpw==
X-Gm-Message-State: AOJu0Yx801L6yjnFeUMdJ3HNvstCc776VSgOM4gjVz9Q9wIYh/b2YLuI
 k0Jv1SlkED8ZujtlCkcRHpL58wEZQ5fRV5T2kTiLOpkt7Cr5og8y5O65IdQDoI76AkBFrxqWKyS
 905RelFCwAI0CZTaQibPeiaYc2LeFb+i2X1uCrVTUi76S0QWTY3HrICX+99udZyaZNNHcJSQr6B
 RfjbqGN5+mn4vXNLEj8buCTAvGySDBtlYG7PB4ywx/
X-Google-Smtp-Source: AGHT+IEqPnPG+bO4zBfFIKPhmTsTQGzMMvlcZQSKfqvxg3I/yda0WfXw+k5CReCmZc/fi1z/YZf+1w==
X-Received: by 2002:a17:90b:711:b0:29a:9952:67b7 with SMTP id
 s17-20020a17090b071100b0029a995267b7mr12392900pjz.48.1709741445298; 
 Wed, 06 Mar 2024 08:10:45 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 h21-20020a17090a9c1500b0029b73f2a0besm1605497pjp.45.2024.03.06.08.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 08:10:45 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv/vector_helper.c: Avoid shifting negative in
 fractional LMUL checking
Date: Thu,  7 Mar 2024 00:10:22 +0800
Message-Id: <20240306161036.938931-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When vlmul is larger than 5, the original fractional LMUL checking may
gets unexpected result.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb20..adceec378fd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -53,10 +53,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * VLEN * LMUL >= SEW
          * VLEN >> (8 - lmul) >= sew
          * (vlenb << 3) >> (8 - lmul) >= sew
-         * vlenb >> (8 - 3 - lmul) >= sew
          */
         if (vlmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
+            ((cpu->cfg.vlenb << 3) >> (8 - vlmul)) < sew) {
             vill = true;
         }
     }
-- 
2.34.1


