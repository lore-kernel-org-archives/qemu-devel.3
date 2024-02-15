Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF656C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahQ6-0001lG-BS; Thu, 15 Feb 2024 14:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahQ3-0001kY-Od
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:16 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPj-0004iZ-72
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:15 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-296cca9169bso1060323a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708025332; x=1708630132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnoQZWyM3IQrdfNlHpKnjwy/1Zr4Y+mdXFsSbK4jOXc=;
 b=CtdvXNJ4VbnpEP0ovK72hVQ2e6ihvnIHCCvhQ5BFEq3My4WXqYYvmIMyN/PtfFL5uN
 FnRnHw+zOcpYl79z4uQZfjUgNYr9NtndKML7XPMcN1fYvONv8ZvV3lbU7s3MViuy4y0g
 Y4Dx27UFdLgDfzVoD3YV17SKPTT+HqBIONrSxcQN84uRsu7JmAYP6EtA9i/WB1i6kMSo
 ZJFmBWtcieSSuPrrqan932hvPB5YjYekqWsljeGq5+uahqoX5tKKTcMmPVfKondu/A40
 3gEl1DfRTm8fFGe6GnGlJFP4AYQ3y8HmjOJJd9cD66V22N34YmaOErdweeYBh2/szn5e
 25Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025332; x=1708630132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnoQZWyM3IQrdfNlHpKnjwy/1Zr4Y+mdXFsSbK4jOXc=;
 b=Pk2gFk7JAV2loiW7tEbus/0417PihjfkUn+T9JmvQJlmrtp/k9/OlgnjMLKo4++03d
 7GYVBxpt88Ifv6syj9MKehyKSwtF8hLG2mwPC311pQaFPQm3w9lpdh9kLLFSCPAE4L7F
 psH/3Jy6CWbcKfGSd9kdRoH4efyvI0b/pnAOhp7Tla922DtmRTivPlUoxoVZ7Wu7qGrH
 AgiNusZ0JcbElQa3gfcolDlhBsP2aHGBfdra3E+ONgFperzm3j/5F8fgA25sFws7obrU
 boQavF4F5dbkxttzumtnwK5NK1nXTnsjY18yw0xP49zPo111EVEG3b3hyQ9SjZyDqluW
 lEZA==
X-Gm-Message-State: AOJu0Yxur88s4f7Ztr9yWV6HoQq5sxbuYio4Vr5Lv0MMfkS5rTmkLfa9
 joSEyeAtzUDUQ+H4kNfzM40RpiUX8UmPPQsmMhX4QHPZsVE/Yl5gYmAsFtkZp9VXgnNywt7qImE
 rUN/aw2A2gbldji44is5Z6/NidEbJu5gmV0ZrPjGm3zMMf+1cpamNOhjvJ0O+/cqSri9mA8eJT1
 zFr/6WMaJ57L2Kq4cTq2Egz9kVTuJ/siNJsJNta3lK
X-Google-Smtp-Source: AGHT+IG5YuTs6vjhF3Bi69Xsf/3ASVE8egLuLKosMtoQKuXI34cy1tP7UDdbE3vL9XaQUz9VElWqJw==
X-Received: by 2002:a17:90b:154b:b0:299:ed7:24fc with SMTP id
 ig11-20020a17090b154b00b002990ed724fcmr1910269pjb.49.1708025332282; 
 Thu, 15 Feb 2024 11:28:52 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902a60800b001db5ee73fe9sm1618653plq.114.2024.02.15.11.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 11:28:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 6/6] accel/tcg: Inline do_st1_mmu function
Date: Fri, 16 Feb 2024 03:28:17 +0800
Message-Id: <20240215192823.729209-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215192823.729209-1-max.chou@sifive.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 accel/tcg/user-exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 803c271df11..9ef35a22279 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1050,8 +1050,9 @@ static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
     return ret;
 }
 
-static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
-                       MemOpIdx oi, uintptr_t ra)
+static inline QEMU_ALWAYS_INLINE void do_st1_mmu(CPUState *cpu, vaddr addr,
+                                                 uint8_t val, MemOpIdx oi,
+                                                 uintptr_t ra)
 {
     void *haddr;
 
-- 
2.34.1


