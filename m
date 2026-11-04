Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5C607077A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=bjhizAdH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtG-0002uf-6H; Wed, 04 Nov 2026 14:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgt4-0002iF-0v
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:10 -0500
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgt2-0002TZ-Ct
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:09 -0500
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2449167c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821384; x=1794426184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5iHJKabwd8CSEpwPPxasBgAO9oJcHNxbYgWfk//OP8=;
 b=bjhizAdHnpSMi6zGYlif4gksld/F8BDwD2l2n3kmXp9AEsjt9VpboM8wOgqZnmKKvY
 n3ASjoCgfOaL+4BLGOE3ZE9wZK+JwADEu9oWj0IrGZwuRmRn/QFAOtBfMLbit0RTh4Pb
 YY44z0nJRamzUI03tms1xnxrcaEzfFpCcnCjGLWHMsaGejdt9ZBWuQOnKMqYxe5xeVQ4
 stygyncMCtpXt6ZoBCSxAeNsLGXoIxzXY84tUfmM6r5bMBPiHenNA0h7xtY7zQRs9PVc
 oSVrJ3aXb+5aQ6fEyYB1/o9EWUOsMU8mXbaujRScSqVIKJW0IWmt238Nt52fK9U2+I7/
 dSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821384; x=1794426184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g5iHJKabwd8CSEpwPPxasBgAO9oJcHNxbYgWfk//OP8=;
 b=RSYA8aAyJh8lYMjO2D5qGCNDpymfuIe3vlmuchqb4ykCwI8oj+BvvocFF9Wi94QAu4
 YDkv4OMo2bbq6H2rmG8miw9aIA8r8lPMFFZOsOK/eHsr2lYM1SXZB5VnfheY8AbTSh97
 mtw03dgSQm1Oc6lmw4pH4PXEnBS/9n0eWPwr1VBzoYl018zAnfnEQbAJGIjJuwKBHtxW
 GyWkTDpNqa9PKJX8ACu+eOTa8neG0PMGForiNR8ayMK9xOuRSDgXQZTckGJXYiwFXQGB
 Y93rUJeQdSe+6ghgML56zMkBhSMvnsopE1ObOCyPgqWZzNl4lsTI4NeArHwuXY5Um6kH
 8gxQ==
X-Gm-Message-State: APuU4Z+kg8aBidIE1EyAUywrfN4u1sLxq4m0vyvs0RSXCUS/5tDDqHiB
 fmjQ2EPjeSPWz2qKg76qD8dV/TDhpxynT/Cembi1UUSb+zPLr+OAI/rOl8+yW7ku6i3XedyibzI
 wOFcwMcleCjLCzCkrJAZNHeSrqtku/1nmXIg1myFUU5elDLcpp3lXjakQcUXpO1Zla8wSALmyY0
 G9KeG/TZ/UupDeZsIRNzyp+I9ipRazHIGC0MlpPTuAEw==
X-Gm-Gg: AYBFou08YdZHhepLkdv6+SFHYyA9GI1+aHAbBp0wwIlIDTKvoNByCA3C1W7+5fG1XEp
 iZlaPa1xP8YNE/jPt4YTXTYsUgKzYOyP3pxD0wTHIQnutPpX+snENxL5m/W3LpGbaNEVJjT/uJw
 vJlRyyYQdbTQyncLPMiuHgrchpIBVoaclqFc+LgubIWNgi11U2yYCbF8ItiEZTMit853hvbwDoz
 R80LDip9qRz4GRM58y/zC7foNvb5PFSVIchuFA7ywzKcyTMYYU2MojerbVWeCwwKoOWrgYuYD1A
 AARDJwtOCYWx7NoFoY8EszP9bdmYiAszwU7ev00CujaxdNIT1WLU3Fm5sE6i2v9UeHvrHroYHtx
 EyxF482iXMxwN5BxQKjQtBj3r9G4B/sP/l5Q8OpDEIT3mlWNZqhf222LU3WItWRmh5iS6539LP9
 zfRindsThiDYLw9OzBuvpJdlAaOcwfm6kUaHswEaAG9Zr6TL+XwbHcX5BXdvMgCPrtlPEBVNKNy
 rkcSQaVsXhpgRbe3j1KZUcLpi+tsXJt83OO7uI3GbfAUSRMnOxtRNj4MdPr3CDR9EIPhOX3z8L5
 C7s2Sim5XRm06KBBPXRoFvAdY60SmGtSDBaboFI0aRUJ4t7S7uDoA816ywE0a4TazEpG12Mz2aZ
 r2cD/Ojgj47xxM1e86iKkrwuYkwSOMx5isBfP1AnigvAnqf2RHg==
X-Received: by 2002:a05:7022:3f04:b0:16b:fdbf:4a9c with SMTP id
 a92af1059eb24-1ac5ac4cd7emr26749601c88.23.1793821384079; 
 Wed, 04 Nov 2026 11:43:04 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:03 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 16/38] target/riscv: Add implied rules for Zvfqwdota8f
 extension
Date: Thu,  5 Nov 2026 03:41:31 +0800
Message-ID: <20261104194155.679241-17-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=max.chou@sifive.com; helo=mail-dl1-x122d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add implied rules to enable the implied extensions of Zvfqwdota8f
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f2e7a8faa9..6c09685bd4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2875,6 +2875,15 @@ static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfqwdota8f),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
     .implied_multi_exts = {
@@ -3081,6 +3090,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED,
     &ZVFHMIN_IMPLIED,
+    &ZVFQWDOTA8F_IMPLIED,
     &ZVFWDOTA16BF_IMPLIED,
     &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED,
-- 
2.56.0


