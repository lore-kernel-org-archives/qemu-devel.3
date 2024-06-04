Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63660C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOJa-0005KZ-5b; Tue, 04 Jun 2024 03:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJX-0005IQ-QT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJW-0000YA-9p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70249faa853so748448b3a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717485032; x=1718089832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMVIvPPDyIsXb0IIrUQL6wLJN2o+AMmh9m6vpVCxHFY=;
 b=OYMgmQN9myQF42XPOgWwko684GYNTl8z3MEbidxK9OJ+pSDF3IdFkh4iiEd47t1V4Q
 aVZjwDZ8WsEnJjjM0veOH6s+GZpYMlcZoDGBp/ZJFWG/CyNmi3UBCiYEAwYvimxAB6Q2
 Z9IY4DqSrHxjkgkBZJzrroT9e3rwIBYKFNSyvhBA5/6js4K7gC9oLrJqZDHTqjWmjSP1
 KozTCk+jMqxX7/DGFqKilABi7i+QQ7TDuc0OvN3xlq+Wp+QdZIqMd+/NlAeHPqs0WzyK
 XGbZMHLfWj+17XZZsRkmK3VQK/Km/IENwwM73305ppozpdDyoKaWhnCtI48VBpe7638D
 XNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485032; x=1718089832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMVIvPPDyIsXb0IIrUQL6wLJN2o+AMmh9m6vpVCxHFY=;
 b=bN+XILkoJ1z3JouK1Kpp+dTC66bgr53vpRwtDQ5T0DtE8HLByPEQVfMkER9s+HNPXe
 ZkVCOphORzJSTWdrcLJTon0T1QABoBZAAAm7a+QcKtPt8S3rj8fVCsSzvfoYZdLmYnof
 0AmSsER8rXuQ3kkSEivBcTOlOZj8eS9v/4E6njP6XFe2ue614OQHnQVsvJ7WJldyUqf7
 rNVsIJBVuwhs9rJo9UAMAs6FRc0bygHX/vsuWTpwxlkFyzEz4YXCD704EeRYDTbKFkIx
 rCQ2ucDSAACWgseX0II7a13R6E4YLme2SJmYGI52LBKxjEAM+ih6xE2iQirz4MjrNaTd
 RSjA==
X-Gm-Message-State: AOJu0YzC11PKDPT+0MBpqfkAMShI9IwaxTySynnQFrpHAH0LYzPYZwbQ
 6Hg+M8q72RkSgoccUD4GxjdxQLnNpoiliE9SUPHBiJgNDkOUdwKajy8Ow6rBo25YGHD87fHwupF
 dX5lUxYDmdEnTnCc+E2xf85P730dHr71ljEiCyAxQWByhPwzDrDA3XMn/VSkLruhdV465vxnGuU
 ZPCkIjeiJn6NTNrd50ZnrFbqqJ1MW4V5QhJF4=
X-Google-Smtp-Source: AGHT+IFNBNbFFNI0Z2FXtpy156m8R+OwbriW2NDurDgUcGysUlw5Z5W6yvC4uYHvhytzETUa4sHAFg==
X-Received: by 2002:a05:6a21:339c:b0:1af:af89:ed71 with SMTP id
 adf61e73a8af0-1b26f117905mr12281701637.19.1717485032298; 
 Tue, 04 Jun 2024 00:10:32 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d68dsm9237943a91.6.2024.06.04.00.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:10:32 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 3/3] hw/net: Fix the transmission return size
Date: Tue,  4 Jun 2024 15:15:40 +0800
Message-Id: <20240604071540.18138-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604071540.18138-1-fea.wang@sifive.com>
References: <20240604071540.18138-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x432.google.com
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

Fix the transmission return size because not all bytes could be
transmitted successfully. So, return a successful length instead of a
constant value.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/net/xilinx_axienet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 7d1fd37b4a..05d41bd548 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -847,7 +847,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     axienet_eth_rx_notify(s);
 
     enet_update_irq(s);
-    return size;
+    return s->rxpos;
 }
 
 static size_t
-- 
2.34.1


