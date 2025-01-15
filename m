Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD66C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3mp-0005vq-Fw; Wed, 15 Jan 2025 08:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mn-0005v7-L6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:21 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mj-0007rO-Iq
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-3eb8bdcac2eso1323600b6e.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736949015; x=1737553815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVDN4MjaZBTmqIZfmehnZjKJIdM4iScvOXjzGweeZx0=;
 b=aH0ChLMH7lw5o60dvhiPWPfSnyV/spj34YODgdj8DJpwMPv1n8Z1WTSSYXNaH1TWvC
 av9IPjJ7UtwpY+nxarxLGVRwnnS/wN22war24EV8YH5WYM0jgDW8kWddYIOxw4kqt8G4
 S9Cw8J8usRM8ldO7y03JetGJdUzAPK3BqsUetQLW/9EbvvJ1XHFu5531oGWGPklmZ2u4
 /FC5mjuM9OhgWyzMHW2nmXuuboH0omVNns5NcrqI5Yn70e2RgfjgchVN9Wa6hoO9mBTj
 ErHkBYu2LF7hZ/m200Ol3CVjScyO7MBiNpDwraSbT32ehK5A7bR04G6Z8zyYGgOe+GBH
 n3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949015; x=1737553815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVDN4MjaZBTmqIZfmehnZjKJIdM4iScvOXjzGweeZx0=;
 b=onoSPah2J2yTOJLI6vFBvLOj3ruorAJfjtvFbbUUjgdfftLLknblW6pHJrlucwLDQ2
 SBqQLrNf7o+0ZeeARhwUFMkulH8kas0m7UocXzSCCcfehJRhXkR7l3dLsSu5vpByB6Fr
 9Z9GFs9CMSHBZoqau7jyQHxE8S0iXha5iJLSbVZPRxbybHukHs3VhDmwnLuLw9tgvgFw
 +aQM6wym7xeBuT+bftA6yvb4qt5J61lay/BJcC6YS+ATeNGHd7l/mIayq2t+VT7xDSf9
 leIiy9wxt6MCS5lwc6mkhHC0MQVulAvxjuA6WTH/1MDizrzv8xN7tvLIrWKJHsD7iXOr
 tCCw==
X-Gm-Message-State: AOJu0YzzONcR5F5yNjR+QvTMS/UzpLYRvgWIZP/b8jm1FD36Ki7qkeQI
 NJObn4GhNcY1ndFMSbYf1pxP4mhS69ZavqYDqtDDwQUSns2+CC8MWkHRvHf2QL3qicN1HWkNgPJ
 m5+Q8Qg==
X-Gm-Gg: ASbGncsAZCFdXbhnBNTyAQ7mVVohX6NptZFmuEU5SSl8THpUGkW73Wk4rFJP2HB/xeW
 a2UguPD2WEmY8wrUs4baGH9kGLf7d4nALCcQT/uyEprg3JRwIIkeg+J3E3Vy4YTxmMCerkvMeKC
 dqI03sx/iOdEnG94DEtaxHfNMdLkbO95UM/hNHZJOg/iXiHQ/OaxRjk2BqHohSPzDTv+GhTqyId
 WhMB4rHDcP+5V1AMI6O+4dWt2sEQH6zbVboHPZoo72jZYPreWZ/bms7nU8=
X-Google-Smtp-Source: AGHT+IH7peWFR+BScJ5K/AkBtDok822AwSX4+Ba/PBebpktTneL5M53qeYXXKGOGleM55abNjkZZbQ==
X-Received: by 2002:a05:6808:1b0e:b0:3eb:483f:978f with SMTP id
 5614622812f47-3ef2ed59420mr9094191b6e.32.1736949015679; 
 Wed, 15 Jan 2025 05:50:15 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f0379eff69sm4952177b6e.41.2025.01.15.05.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:50:14 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/6] target/riscv: use RVB in RVA22U64
Date: Wed, 15 Jan 2025 10:49:53 -0300
Message-ID: <20250115134957.2179085-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x244.google.com
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

From the time we added RVA22U64 until now the spec didn't declare 'RVB'
as a dependency, using zba/zbb/zbs instead. Since then the RVA22 spec
[1] added the following in the 'RVA22U64 Mandatory Extensions' section:

"B Bit-manipulation instructions

Note: The B extension comprises the Zba, Zbb, and Zbs extensions. At the
time of RVA22U64's ratification, the B extension had not yet been
defined, and so RVA22U64 explicitly mandated Zba, Zbb, and Zbs instead.
Mandating B is equivalent."

It is also equivalent to QEMU (see riscv_cpu_validate_b() in
target/riscv/tcg/tcg-cpu.c).

Finally, RVA23U64 [2] directly mentions RVB as a mandatory extension,
not citing zba/zbb/zbs.

To make it clear that RVA23U64 will extend RVA22U64 (i.e. RVA22 is a
parent of RVA23), use RVB in RVA22U64 as well.

(bios-tables-test change: RVB added to riscv,isa)

[1] https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#61-rva22u64-profile
[2] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc#rva23u64-profile

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c                |   2 +-
 tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b187ef2e4b..6fb4d5f374 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2351,7 +2351,7 @@ static const PropertyInfo prop_marchid = {
 static RISCVCPUProfile RVA22U64 = {
     .parent = NULL,
     .name = "rva22u64",
-    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
     .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index b14ec15e553200760a63aad65586913d31ea2edc..13c8025b868051485be5ba62974a22971a07bc6a 100644
GIT binary patch
delta 53
zcmeBUp1{l%<l!7LfsuiM@#{n`13^7TMg~>JqB1j+%-qDZl;ot1UQ&#clNpsc(ij;S
I3K$s}0ARKZK>z>%

delta 52
zcmbQh+{ern<l!9B$H>6Im@tvcKtP9)kwJyAsLaeHGdD3UC3&N_6yxMHMkS6EMh1pF
HMg|4|IwT82

-- 
2.47.1


