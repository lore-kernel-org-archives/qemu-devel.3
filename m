Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366DACA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7i7-0001ow-P7; Wed, 30 Sep 2026 23:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xC6S5-00063t-D1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:23:17 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xC6S3-0002QN-9n
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:23:16 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 d9443c01a7336-2e2d2bbcab2so9326525ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790821394; x=1791426194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TIs43LA5OkZmPBJSryEHekZ6UeGCUX1x7+EpWHMxO8Y=;
 b=i190B1yLD2jhR2kEwgJFcfjEaXjRDI1CQmojMwYdBEMGVwJrHuZemJ86jxGVH1fC9L
 TS0BLulBazn/vkk+Tm3/hSXg6J6swtNQI1KUXXB9oBFKIIKuflCAkECEI0VFfXCpmFQC
 GImCryHCi/2kft2IIVQwzNLk3P0iW0IECjfNTSQrAwWdYp9RdOkfXZHAI7k1u3qwS2yb
 GSKwNiF0nkmmbHdYeqzbtqANhnKgqZebSiQiTFKINSwYl6CFsqdyrxCh7VHDmvatGMYd
 HVAMk+v++DNhePGlpgm9ajpDNRQds9oggRSYRrzOYY+zNHhc7H40dyY+BUprsNJm1SMJ
 Zu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790821394; x=1791426194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TIs43LA5OkZmPBJSryEHekZ6UeGCUX1x7+EpWHMxO8Y=;
 b=tKybNo72ZQ/ciwGtLNyXVcf8gPQ4i9LLBFaTDlHEs1I4+7ZS6Erp2VGSFfTZTuTx9Q
 UumCVXmQvgZzvkiZJ1cQ8Se6ZeatKuLdlH72Z3+YuiIwrEed0rM2DqjpaLEdcy3+Fgsi
 zWVHNfdwi4B0zmRZUwJJXSvuc5qhegMz5ABFC6Af75dVLF+duwpXdpG38qbtvSQmZJRQ
 HQ/rpGa41X7NdyvmYly2W+e4zWf5Slmh9+8DKDGZgZlvqj9BlO3CVZAbJw6uEWK2KHIl
 To/YgEeIR99GzHg6/vFSjsqRPFjxcB/2EQcu29uGjRNZWjSHlKuHbmyWEujZ0jh2WK9K
 13yw==
X-Gm-Message-State: AFq9FYLGHdb9VrTuoOfGqyYav0vDnaWx4tQb4d8Lm1SZO5sTXJK+zwmQ
 wbd3lpxoL1RPe2rHA6plRYEe4ZN5VRAWOVsEf27ONIu3d7qbv3HpLcCGjKtCgbmqb4Y=
X-Gm-Gg: AYBFou1oTQ9Vu1OI0UhHLf6sDRmEIvr6NaxNL0alz3xhuIujQFSfmRbWW8sQ6DdpI9G
 jDpiQl8fuWkCHZnZQGBQgl0lTV13MUMjEl714lJdktCor+8nbQKWMuQWimOI0xDd7i55D7bQdgR
 FZEQoCUjHh4an8q5k8/ckoxMahKzdHaWSUfgygAhA9JvSxbggxGPafKRwO5NjzdNM6elcDinm72
 TJkWQVwRldUww0ox8dykQhmQb8q+oykJd1FPV3b3j2DV8Ehks2xkOMLGebLPtLUesweFPyEMAfU
 VCuTKcx3uR+nsDVdUXgxm89xFU12Mi+AndqYuU9fGQ0Hkdgj8F2kF2quqGUFrUgI+ZWOIe2rr7o
 zTSZeRekUB2m9augEu4kuwyCKMO8yXBJ74lPqY2yTL8j0ocGnJ1uZZvqI5IHvcOZf8XVezp4Gnb
 CWyAOwrNKB6rkiUphXjJiFm3Twsq4DQiv8tzsO4z8/Ej0lPhzPt9sxzciKg4/iyZjLe3tCg5QhN
 eOWQ3837Un18vQp
X-Received: by 2002:a17:903:32c3:b0:2df:8a60:67f7 with SMTP id
 d9443c01a7336-2e2e4b5c568mr24910375ad.12.1790821393888; 
 Wed, 30 Sep 2026 19:23:13 -0700 (PDT)
Received: from dt-VM.localdomain ([175.152.37.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e300b8fd4csm3943635ad.80.2026.09.30.19.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:23:13 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Tao Ding <dingtao0430@163.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 2/3] qtest: fix k230_decomp_gzip test integer handling issues
Date: Thu,  1 Oct 2026 10:22:22 +0800
Message-ID: <20261001022223.8633-3-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001022223.8633-1-dingtao0430@163.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 23:43:53 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cast slot to hwaddr before multiplication to prevent 32-bit overflow when 
calculating the SRAM input address. 

Resolves: Coverity CID 1685514

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/k230-decomp-gzip-test.c b/tests/qtest/k230-decomp-gzip-test.c
index e80113fd28..249c8ae82c 100644
--- a/tests/qtest/k230-decomp-gzip-test.c
+++ b/tests/qtest/k230-decomp-gzip-test.c
@@ -46,7 +46,7 @@ static inline hwaddr k230_sram_addr(hwaddr off)
 static inline hwaddr k230_sram_input_addr(unsigned int slot)
 {
     return k230_sram_addr(K230_DECOMP_GZIP_SRAM_IN_BASE +
-                          slot * K230_DECOMP_GZIP_BLOCK_SIZE);
+                          (hwaddr) slot * K230_DECOMP_GZIP_BLOCK_SIZE);
 }
 
 /*
-- 
2.43.0


