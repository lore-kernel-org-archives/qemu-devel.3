Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A517C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4R7-0001Gv-R5; Fri, 10 Jul 2026 02:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qm-00019D-Ag
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qk-0001ug-RM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so5051495ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663785; x=1784268585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O/7FEaWq6GSW5DMyLSgoZ6CKEjGk7z8oVAnel2Qt41s=;
 b=Cym43GzWRc4C+ZRQhUf7PObP+vYyVDJt50UjO5xjKw69g9wB/7FzBpIhA41jjFGY+s
 pD85GgnLLryqTJyokJtCre/X/7uGmKhkePl9fm62uUTO/F/hQ8vwP4pGbQpnrnsEQd3F
 mO/BmndDVsMRvp5rbEswg1xk9iSDkXpquEpfmuUkcoeN9l8d1ZAXMS9FK+2foQDcitub
 rE9YjdhtTLtC7i7qWQ6RvY6I9gidalB+T/r/0r1CwQklLWtPSUlcSMxa/inQ0bSboTIr
 n1tJROL3tDAwerMJCtuiRhBQ9XoS0x1SuvjRFuybGfYsR3aUcCcUFnKuEjrtOQ0wa01L
 tzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663785; x=1784268585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O/7FEaWq6GSW5DMyLSgoZ6CKEjGk7z8oVAnel2Qt41s=;
 b=icbuRyngnslLw7LH62FxyiD+IaX0ZplDDAeu+4Yq2cXKvfl85zNs856OBJYfjiv74e
 u9xbMUEMg8sPFNYrxxeVMP6MgCxvEhga96EZy0GMsQx/mzhe0V8YS2i+az7Nmu5/yEpU
 4lw6QU/rvXSGysdGNUkfh0q6PLITSO1+3Zq4Bu3kIMSDw1hoav3shUU1v9I3VSkKVrNf
 vwFREwRO0dg1V5O4W+RdB8TwV2263m+2PMJ/gHQZ6QLFgvVy2tHausy7updIuE2bBQYK
 CpxAv6qukdF8x1xNju9JFXrVOhR6MXbbZYyigXiMyawcVBtpMAeeZ1s6zdEJX4jU5xB+
 82Ug==
X-Gm-Message-State: AOJu0YxWsKgMsOpb8i4/MibAbe7rqn2K2kTTv4mF+A8TMKxKG1KzpIQm
 AuZ7Plh8C3B2gNA5HexDMGC7KRO5Qs/mF/AVPvbTqs1PqUPvahQXkYqUGIo54OY0srWayTqMzMD
 rInqQoyUF/phVWuVWnymcBf7V0q7ZmvrUdchKDvIHHSl3s5IYnNMNkIMKJMe99JtrINP0sCi2Lw
 glM1MhO79B6Gj4PelGfEpYr2K3f/UzaGzQOnacPWM04GmvN2bd
X-Gm-Gg: AfdE7cn91bVXR2MfQGjJQVn7sRKt+VdCqmkwp03IiP7w1dwvn3XCt9z+r/ztHKvYTJZ
 loQy5hw45l7vS1stamw+2VZpgFn6e4zqW/mMF5HSSpqP7iYIDIkWfbn3FY3jdnp4x37//wME0/j
 AvOe4PhHhU4H2tTyGgZvBTQVAqMH94FIl0ZXJ+HhFjql4zVcB7KTcRNODUVW1sP6Ra8u5XG6pID
 Ear6ew2ewZL8hH7zwlp91+3b6e20yEek0BK6/pnbMqqnGI4UKi12q9Srpt5Ff4IdIIb8WRE0eAA
 7qE5vvr74SoiCTpBmre+RSd+H2vqy1SeclCtM707joaiaPAVkqilHqAa2Ibkt1I9kXhmgt93GOM
 cYn/VqvEgXTpGuI5wwIGPqlqyboipGjHvAwAYvCqUNpWPI/KBxHVoKVHlIbhT7ctI1Kgr29TUx2
 ooMuczuv1SBPvsXiDEtl7fXxWE2ngWnQsTHBoa3uo=
X-Received: by 2002:a17:903:110f:b0:2c9:bd64:8c8b with SMTP id
 d9443c01a7336-2ccea40dd61mr111099385ad.31.1783663785285; 
 Thu, 09 Jul 2026 23:09:45 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:44 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 6/7] target/riscv: Update Zicclsm ISA string and expose it
 as a CPU property
Date: Fri, 10 Jul 2026 14:09:13 +0800
Message-ID: <20260710060914.1227027-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060914.1227027-1-frank.chang@sifive.com>
References: <20260710060914.1227027-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Frank Chang <frank.chang@sifive.com>

Update Zicclsm ISA string and expose it as a CPU property to allow user
to turn on/off Zicclsm extension.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ee89f6fc4b..04b1ac22f11 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,7 +164,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
-- 
2.43.0


