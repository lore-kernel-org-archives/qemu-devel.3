Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A153DC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrej1-0008NO-6g; Wed, 05 Aug 2026 12:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreiz-0008Mq-MG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:44:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreiy-0001zO-6X
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:44:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cea3004256so15727315ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785948251; x=1786553051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O5v+4E6AH085JvEW/ulDh5E/YMq66y/1MyNCyiZh4NQ=;
 b=QmYnb3iwLhmBi58VIng7FQyHeN+hnyQzIJoudahIw291lkPePDY5I1lI9jwgU44pOZ
 iEP/sAEIXCHgARIabhDR7+Kz45rOOVoKXM+HJmorY1U7GVLbnhfvjJunK5gEkeE9SVbw
 atRqAirXSulMvoZt1396OOzqbU58hmjx/F6vVeY4Ljn2vM2RJQupAdLtZO8KzvxIxU8x
 rVw2MNB95Wo2xatM0CdMvQDyl580QS5Xt2aNSWGSrhqyXGoQ0lgE8YmHNi2l2xcvsqeS
 0As/nI19VORS5N44kbefNzHT3FyfVur+7a9v7yIRaXcAOzW6ZVue3CwWuWZxq+fRvBcd
 4fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948251; x=1786553051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O5v+4E6AH085JvEW/ulDh5E/YMq66y/1MyNCyiZh4NQ=;
 b=ZF1b0sgYVrNua/k9eTiK8/FppnEdJhEmZ/WRVcTScgO4JOL9FRz2d4/li4fmarhCX3
 +uaBJ4WHXCTcF0TrdxardH5aTruVlcsTe1/AXE0lLpYjyvI8IizkmhAXpqPsW9Qz06xJ
 Ti9ORGqAbLYpYAN/kF6pI+g4Eg0yxyM+CeGFsnfsnYdurnlho04V6gGJv5vbnt2H0r4f
 F2pAnGF9yLxhEVrYcrTEoH9r2uiNZFTrsPH7U/Xg9LSdoP95ElyvwObQ2FVyRpGhDiMy
 tZZBqpKpykMIM3TGePimnruyr5sQ8ZGdIUV/syywEPwnljli9IlNVZK2mmM7nEzBfT5W
 2umw==
X-Gm-Message-State: AOJu0YzrgBZK2/4HPu8XVjL2R0W/CqH6u6UKLTxZZy5M2IV0S9uFQoWA
 c7CQ1ucXes7/H/gURPTYBeFIvmw+UcY40+sGquYePH3s66Ls7ZYxAL3SQw6OsC9eQ/4DYfGvey8
 om4XichPBieHMm5kMR5Cyq+1Pzf/U/Uha5nYOekQPfmHgBTrQN7K0BUDScDQbDQrSQv5QlqiJsl
 ts5vrCB/b3YoHHSsuN77uTT2v00WoysyHNg3jU5T+8+XIq0+Bk
X-Gm-Gg: AR+sD11qq/A8Sz2o/tW2Wq5P9srxbtt3F8I7omGQyX6YItd1o+DzjOV/Sqbqgq1784h
 8d1BuNi1Likpffxog0mBD3YqqN6OOy8Cu3IGvnBtXdP7Cg4bpvSmSUu0Jd6k9uVZsIvvbxxQ72L
 R24vcM9JVfz1koV+ruqmNwwnbuQReUo48/2ZFuEwYwr5Xe16PsPmiuYjHcX/23BUfTMNIyqNIL4
 4o1jRYghD9TwhxsOS+YXLjXcBM/Hk1cMSpYiFsBEi6ZvbX6kQXZgB7oc458/H9sllP/9785cQgo
 YZaJ9F7L+meKhH4+8/FnOo+RJX6Gkqu1n96IFYEeBXvdSJkWDHFi6A+9YQBRFqGeJlRVADFUksb
 k36d/kMnVEuhcJSmJFQ7TmPms3yLSWckMdzCeikBflO9vUH3wqzMxLxWzl6Cuyu7xXAF75wxXxX
 jH2tOcV3aMPTYvTSOeeF3RcTv/SdcOT20VpDpAKg90vqjj77HwbmBseqCQsneIe0BovO+U2CRja
 WsKPmaRzbndpUg=
X-Received: by 2002:a17:902:f60c:b0:2cc:6329:b7ba with SMTP id
 d9443c01a7336-2d0ca7835a7mr98497315ad.16.1785948250541; 
 Wed, 05 Aug 2026 09:44:10 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm16719065eec.13.2026.08.05.09.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:44:10 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 7/8] target/riscv: Expose Zicclsm as a CPU property and
 update RVA22U64 profile
Date: Thu,  6 Aug 2026 00:43:44 +0800
Message-ID: <20260805164345.698208-8-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805164345.698208-1-frank.chang@sifive.com>
References: <20260805164345.698208-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
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

In addition, Zicclsm extension is mandatory for the RVA22U64 profile.
Previously, Zicclsm was enabled automatically when has_priv_1_11 was true.
Now that Zicclsm has been converted to an explicit CPU option, it must be
explicitly added to the RVA22U64 profile's extension list to ensure the
profile remains compliant with the specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ee89f6fc4b..19b93f9c979 100644
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
@@ -2237,6 +2237,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
         CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(ext_zicclsm),
 
         /* mandatory named features for this profile */
         CPU_CFG_OFFSET(ext_zic64b),
-- 
2.43.0


