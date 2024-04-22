Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B87C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuCA-0003sC-AH; Mon, 22 Apr 2024 09:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1ryuC7-0003px-Cq
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:58:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1ryuC3-0002jY-B2
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:58:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34a0cc29757so526625f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713794329; x=1714399129;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iZkvdy3nHVfG+OpWotHOqDYl4caZhvGaq43kdwd0U8c=;
 b=ZDnVTNCF7kn5qvq6nMoORfnAOTcVmKBXLWvZmvkg0W5Tg5LIrhXOLaQBWGQlhly1QV
 5DJ/IYoEoDNTFezysKpGcgcHvIC+q7HuPfuF226AErk71EiYs6dhQc1abpl2YMvGCW5c
 wCWwQHopIpp8cFTGooGUkogxtSR4+5CFoSvFLVYEeKdn16FJDLTCyufyBVOx6t+H4fez
 czu23fPHVJPLoNVBqQqjy39C/0QANA8kq73qw6NqlOMC7SCyPAD0sRa0dOsOG+bRU5KS
 LZWtH2sLNxyLgkPc6U0cq+5T+Wkov4U7TFXUYF2Wbud+ew8INfHt8ta/nLyBf5+zbHB3
 tFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713794329; x=1714399129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZkvdy3nHVfG+OpWotHOqDYl4caZhvGaq43kdwd0U8c=;
 b=D/9QjOVQMwqxP2Z3GnFy3I9N2TVpiBdO6unofS3fqKVaRT1Z9hEsfBuW9Y1WOI1r/B
 Www5Zvr4sAh9zX1Z1Dya+FxpYHtjtjo/hWh6aWEutT3JpRdiWzLXbew/2ba6ng49KCpj
 gBxySmC5+Wbn0hch49AnbMZXRuNzc7at8C/Ux+BCHmy+M8yUCyuLXsnTmcprWaS/I0W+
 4uMomc0tY13qyiLBqoWeQ1o6+NpNzJKNnjoQUuehfArZk/RhZPhuYhJg5yB0ITS1tSoM
 LuZRy9K986tjj6mmbzbkQRKZVGgZ5Xcn7cQOiZJY3eICz8VpP5J+du+RHGgErCUEsE9V
 Gv1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf9wfGYwNFxeDBsxwmEpAz2K2F5S8zk1bysgqeR/QCmSl6uyKDMS7ceV5yDFa1zIsT2q7S9Vl2Z/KKW5Hs32OtvLiXgoo=
X-Gm-Message-State: AOJu0YyvgD4CJQ6++rE5r0KLtTmYuCE964nhKxPtmHjyVP62wfD6RuXV
 9HTd5RFqZjNJQoaCFSCMNWtZpczKXbMPKpIlFrjkf+MLr9ErxdpcP94Su5gb75E=
X-Google-Smtp-Source: AGHT+IE6GvAPJJEhjEGyRH5alMtBQCKezk2s1FFlEO/wMK3k8B7UfIMhQ4cFlIkGsCaJYiH6i+xOmw==
X-Received: by 2002:a05:600c:1c90:b0:418:31b9:55c3 with SMTP id
 k16-20020a05600c1c9000b0041831b955c3mr6748756wms.3.1713794328865; 
 Mon, 22 Apr 2024 06:58:48 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e027:15d5:993a:92b])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05600c444b00b00418d5b16f85sm16746838wmn.21.2024.04.22.06.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 06:58:48 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-riscv@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: change RISCV_EXCP_SEMIHOST exception number to
 63
Date: Mon, 22 Apr 2024 15:58:36 +0200
Message-ID: <20240422135840.1959967-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The current semihost exception number (16) is a reserved number (range
[16-17]). The upcoming double trap specification uses that number for
the double trap exception. Since the privileged spec (Table 22) defines
ranges for custom uses change the semihosting exception number to 63
which belongs to the range [48-63] in order to avoid any future
collisions with reserved exception.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 target/riscv/cpu_bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fc2068ee4d..74318a925c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -670,11 +670,11 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
-    RISCV_EXCP_SEMIHOST = 0x10,
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
     RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,
+    RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
-- 
2.43.0


