Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E97C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6U8a-00020w-Un; Mon, 13 May 2024 07:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1s6U8Q-0001yP-SX
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:46:26 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1s6U8N-0003sh-G6
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:46:25 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e538a264f7so39970281fa.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715600781; x=1716205581;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sr91vFn+rXPWaLnBRul9mCHYW6rHsFULmgkxOyTre9M=;
 b=rUwSfuKxsXAoo0RcF09gAV/okH7wY8m/4AYk8mrfZWOmoa8KBYQu6bejXkXYyEum1P
 FbT0hJtyUk9fmLdWx+FbrVpT2NcU6gUuCK0jNXwzXLwCO04W0/svgkqf0qI4H+1bBIhj
 NXyeJcVwSjS9Dhv1Aq6LxMcABaZiBaS7792GOXzjcWM4ukUiH2ps+DLyYgmi02hwk3mm
 N+khv16EMf6svfxtQ4/+iegk/2IING582VRgFnRmfaGFt06Q6Yo2+0+7rCeTVB/giSh1
 cISFy4glAqbWF4B4XKyCcqTxCd2YqlOooxbIva4ep/XKHrH+9qdSEM67bBP30ag0EAX2
 F9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600781; x=1716205581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sr91vFn+rXPWaLnBRul9mCHYW6rHsFULmgkxOyTre9M=;
 b=BnKHpFLHRRQytaOMaN6PEa7MfcdP1Ba16GDqiGCqSrhhzo3kG7JckG/P49M9rxBy/x
 cxgM030pzquClbK/omv4pQGOg3KMhm6RAAddoFbjIgLsr2juxbqjeGalHSrKvoKIM41A
 2NIVVBuNjRUW/0KyE/NUfjB85SDEhNS66y48KjMBpLXtYupznFCUDOu0bzk+MbRsIS7z
 s425yrS9dDYgOwgp9RuEdYfiH09Z1b03JvmOEr8wXAyoBwQZ0vEWy9fg7KNcthFv0UP3
 Mtg/OCW8mjRtomRH4n8Z+CRmFX34jkkcjM4tmX+d9u6+89Gwxc68ZgfRAfqyLYBu6q2h
 EpHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWLK6PDZWbuM8dKV8qoxxziqnsKhOOPnSmk6JxL+5YKbcMdPoou4HVO563CMuFz1AqNUnr4ga1T6mRn0F9YFfCFYXFh80=
X-Gm-Message-State: AOJu0YxdaJ471ry0qXdU7VimGiXKBBamW67T447vRjXibpu0Yly7UtP2
 xu40abSl+pdUn3pexRyuzzJd74EznM5yWBCKGRY49l7QbvNrEBfsF/V08vF0JAI=
X-Google-Smtp-Source: AGHT+IGNLPHszQZcPyOGrbBmwIK5jU+MB148nAl806r+my1RWyUCmDO1xxNi1p1JEhoFbzxnd/xlRw==
X-Received: by 2002:a2e:988f:0:b0:2e4:e7e3:67a9 with SMTP id
 38308e7fff4ca-2e51fd2dd54mr53428811fa.7.1715600781074; 
 Mon, 13 May 2024 04:46:21 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:45f9:e636:91a8:bb8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf47sm10907636f8f.78.2024.05.13.04.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 04:46:20 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com
Subject: [PATCH 1/2] target/riscv: Extend virtual irq csrs masks to be 64 bit
 wide.
Date: Mon, 13 May 2024 12:46:01 +0100
Message-Id: <20240513114602.72098-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513114602.72098-1-rkanwal@rivosinc.com>
References: <20240513114602.72098-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=rkanwal@rivosinc.com; helo=mail-lj1-x22b.google.com
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

AIA extends the width of all IRQ CSRs to 64bit even
in 32bit systems by adding missing half CSRs.

This seems to be missed while adding support for
virtual IRQs. The whole logic seems to be correct
except the width of the masks.

Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual
interrupt and IRQ filtering support.")
Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual
interrupt and IRQ filtering support.")

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/csr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 45b548eb0b..c9d685dcc5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1193,18 +1193,18 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
  */
 
 /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
-static const target_ulong mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
+static const uint64_t mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
                                     LOCAL_INTERRUPTS;
-static const target_ulong mvien_writable_mask = MIP_SSIP | MIP_SEIP |
+static const uint64_t mvien_writable_mask = MIP_SSIP | MIP_SEIP |
                                     LOCAL_INTERRUPTS;
 
-static const target_ulong sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
-static const target_ulong hip_writable_mask = MIP_VSSIP;
-static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
+static const uint64_t sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
+static const uint64_t hip_writable_mask = MIP_VSSIP;
+static const uint64_t hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
                                     MIP_VSEIP | LOCAL_INTERRUPTS;
-static const target_ulong hvien_writable_mask = LOCAL_INTERRUPTS;
+static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
-static const target_ulong vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
+static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
 const bool valid_vm_1_10_32[16] = {
     [VM_1_10_MBARE] = true,
-- 
2.34.1


