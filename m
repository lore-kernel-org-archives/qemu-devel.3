Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956E2CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TLd-0005jy-8q; Wed, 24 Sep 2025 13:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TLE-0005Y1-Iy
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TKZ-0006Yd-Sc
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so85538f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735036; x=1759339836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJl55yMN8mxVV2arqCWHPRSKMows93UfHOZHUInGBvY=;
 b=vt4g+R++ZtMdEhVZKszpaAVMOVLXBXFWVg58b4iA1cVyIpbtRTEC9EH5XARRev5YjN
 ZlXnbQIiA0IEMuJPkkRozp/7HYByByuTrJ3R3I0buvcKtHas9sp6+Zbz4iLOKGeLyaNj
 6eA1r1i8Qxs0ub7oFPafCyVdQ4SJxAhb5ho5pYc5aI75ysR/TqvvqDfeYuZF1r+NETL5
 AW1j4UnwewDqOZKOA2LS+EZ6P/83tSXZBrFDDi86SLnPKrVMCDgiM5LHJxJq0kuAqQCK
 OJI6VB6g7+YWOYbmbc8u9bq1lHdNzLXIgAAwAWHn1N1eY9mqUdrprsJjB8sB81ECpPSf
 Zq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735036; x=1759339836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJl55yMN8mxVV2arqCWHPRSKMows93UfHOZHUInGBvY=;
 b=FGpe6J5eilL17G6YyTOjr3FgelMZA1xpwzuwsC39c3O/mHgiTLkfrYEFzes09E41IG
 j9mGhSu/iwcRfHVPlfZuo42AymhOqgGw+CgN/u6pQrEUPgl0oN+cmBuBJhHskcAT5NeO
 zPktJmM3MhOI/ya0PRe1mPJbNZQtOftyAFXex7fFFre1QecNDS5piDgo81pwEDsOXMLz
 1yBOrF8ruF1FgwERdCH0co6I5OUAajOs5OuZBJ2u8alZNOX3UnwMnvcSb9Kg8+FwOYqG
 dQbCjjEpAqZwVZZPav2aklalV48l0yfaLLdvBlANtXwnq2rbPZ2fyDafhCCUh2iksyxx
 RXNg==
X-Gm-Message-State: AOJu0Ywg/n4ckpAXRvBJ0HEWSvRGu1FNDY7W2TUGCqB5R5p6x/vfAB5a
 zDd9usRDzo0MA5f2D6KsCnG+b0qn7TxuTG6sp2a2gv2kL2uK6NeP2N1SBFJUzvIB5NrGl51zNIj
 7+LB9vYP37g==
X-Gm-Gg: ASbGncsQ8TylPFCm+Fhh6J95U0OJXjsYHHfn0Lew5JZzlWSkVqUnnZ0qgAk+V41rRCW
 JekZU5Gjj4t0UDLFeq78J4uTM8T2TLWNxC2AggBz/laUr1HCfejStcZ1kbwD7LflmdRLldwwq0x
 XCyVCdKdmYih7UYE36JFXi915HiVPbBr5CWTa7SSd8lXkxlyCo2Wirnrt3sEt5GdJDlX5TziQjS
 ze48emFd2WyeetJTc2nJm/JkzPpf3ERhPPtZu4nejBMweiwic61I897rehUTzdZWluWxiik6ryA
 8Pm7sLKLDXXFsAMVLmrbZao9r8gwOZinmhzyb2F7auwOgAIy2Kr0eNN4QHXGQUEZ7V8tUrJui3t
 9RjmyjfPHPTA/EF/ZmpBmw8roB0CDDxNcmnnwXZCYnu+qxFawAHVcNW/HqHakVekTJ9NWcJlc
X-Google-Smtp-Source: AGHT+IFImt9yVd7VauyD9LQ2sQSXI0lfTRJiQqYsRBUMN4mYE3UXOEVyxvzIWTstANroPDg91Y0k/w==
X-Received: by 2002:a5d:5f55:0:b0:3ee:14db:701c with SMTP id
 ffacd0b85a97d-40e49f66b7emr595130f8f.41.1758735036192; 
 Wed, 24 Sep 2025 10:30:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f00cc58b91sm22757343f8f.1.2025.09.24.10.30.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:30:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/ppc: Do not open-code cpu_resume() in spin_kick()
Date: Wed, 24 Sep 2025 19:30:26 +0200
Message-ID: <20250924173028.53658-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924173028.53658-1-philmd@linaro.org>
References: <20250924173028.53658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In order to make the code easier to follow / review,
use the cpu_resume() helper instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppce500_spin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 2310f62a91e..bc70e50e926 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -99,8 +99,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
 
     cs->halted = 0;
     cs->exception_index = -1;
-    cs->stopped = false;
-    qemu_cpu_kick(cs);
+    cpu_resume(cs);
 }
 
 static void spin_write(void *opaque, hwaddr addr, uint64_t value,
-- 
2.51.0


