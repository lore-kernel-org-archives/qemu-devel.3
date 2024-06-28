Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55568C3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFv8-00045o-VK; Fri, 28 Jun 2024 14:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFv6-000442-0D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:02:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFv3-0001wV-PU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:01:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70675977d0eso724956b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719597716; x=1720202516;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+Uro0lVMNWpwdL8qFKUS4UIGWxGceMi8hnoPrKOXpg=;
 b=L0ajA8cJ+LqPl64rA6EiHVWlZak8zyjudQp54grlM5YOQp06L2BJYGsInwL+YDRgTz
 EKgRYMlP9NJAYLe6NaAk5gdtm6hJyGTXxbmLhHwPEpxl+PFWAZ2+TPJHguF7pAFoH9Tu
 Pg1gFajDXGxJ+9wYfFtFk5K/pm7ad674BcUpGE01L7zJT00jeqqGRcPbCYKA25QCDkbZ
 a5B/1zNlW8KtAs1ioUadGQSzGyMivwSSUz05jJVgkETyqcb5PEeZAIaYNr+5KrupGTiZ
 Z11wtuiLrcJK2Gjlg9rp/hnY3owhclguFUxVGrVeZZxb/EBnXN9lO4d1DIHB06teGKVi
 p/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597716; x=1720202516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+Uro0lVMNWpwdL8qFKUS4UIGWxGceMi8hnoPrKOXpg=;
 b=UbMXH0FUoTLdR4X9oxeqTDRfPWdFGUWvbKbbsO9yLdqZXBvtWk8nVYpxEms74NFaf0
 pqyaYN4gQ30J5VdOda53rC0bioSTxYh3oSECiWGD/MHlfbcv5+LfTV0/ei5JbflDBt/k
 pp0oUct6gm/GP0qbGYHkvXtUWg+TCJxhy87oTN5TX+LOwrCIMU0pcBoORHs9kqejb1+I
 Q/YpkCasR0Nfg7Bgm6L/EEh/KVuyI+jiBRxvkTLE+W7/eW1i5gAucP5hStvLaBTifTqo
 pxgJKvIAcRG7ocseQbTVZ76Vap0WuUjLPa3bDS2VSgPc9ygxfDzyZ3XQo9Dim3icqJEf
 ORpw==
X-Gm-Message-State: AOJu0YxOaiGX3SPY92hy/zypWj2IuemN8MQ3lPqYfI5k1JNiFz+yw7AQ
 UW6vnrIUjuH7rfRPMJYQBVuOT+mUgwXh+d6yktbBjBGO9qAZCQXfxw5s65UPUAFGwy20FJfq5Yy
 D
X-Google-Smtp-Source: AGHT+IEVAjPp1S2+V3y7u0YANg6NKz/y6sJWk1eHLDBYi/WuaQhI99WvmQnaW+l0akhXVv/WIpbUBA==
X-Received: by 2002:a05:6a00:398f:b0:704:3678:3f03 with SMTP id
 d2e1a72fcca58-7067455bf67mr19752501b3a.5.1719597715699; 
 Fri, 28 Jun 2024 11:01:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70842036d13sm1752053b3a.98.2024.06.28.11.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 11:01:55 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Deepak Gupta <debug@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH 1/3] target/riscv: zimop and zcmop extension for riscv
Date: Fri, 28 Jun 2024 11:01:52 -0700
Message-Id: <20240628180154.597919-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <qemu-riscv@nongnu.org>
References: <qemu-riscv@nongnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

`zimop` stands for `may be operations`. `zcmop` stands for compressed
`may be operations`. For some RISC-V CPU extension, once compiled into
the binary are part of generated code which can't be gated behind a probe
of whether an instruction set is supported or not. One such example is
`zicfiss` [1] extension where `shadow stack push` and `shadow stack pop
and check` will be part of every function body. Thus binaries compiled
with such extensions need to run in following scenarios

    - On machines where extension is present and enabled
    - On machines where extension is present and disabled
    - On machines where extension is not present/implemented.

`zimop` (for 32bit instructions) and `zcmop` (for compressed) were devised
and defined [2] to support such future (like zicfiss) CPU extensions
where zimops and zcmops provide a base non-faulting behavior for
codepoints that may claimed by future ISA extensions. Minimally, any
CPU implementation wanting to have binary compatibility with such
binaries only has to implement `zimop and zcmop`. Furthermore, this
allows per-task optin for software where user has the option to enable
the feature on per-task basis.

`zimop` are defined to write zero to `rd`. `zcmop` are defined to *not* write
to any register.

[1] - https://github.com/riscv/riscv-cfi/blob/main/src/cfi_backward.adoc
[2] - https://github.com/riscv/riscv-isa-manual/blob/main/src/zimop.adoc

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..3caf8553d1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zimops, PRIV_VERSION_1_12_0, ext_zimops),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
@@ -2273,6 +2274,7 @@ static Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+    DEFINE_PROP_BOOL("zimops", RISCVCPU, cfg.ext_zimops, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cb750154bd..5c42ff8cdf 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -124,6 +124,7 @@ struct RISCVCPUConfig {
     uint32_t mvendorid;
     uint64_t marchid;
     uint64_t mimpid;
+    bool ext_zimops;
 
     /* Named features  */
     bool ext_svade;
-- 
2.34.1


