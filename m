Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8072AC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpA-0004mX-1Q; Fri, 09 Feb 2024 04:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMp8-0004kB-En
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:30 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMp7-0000eN-3P
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:30 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5116643c64eso1224160e87.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469527; x=1708074327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uecpz7Rb+EX/CcmBYnI+TtkUcrh2kOpPPUMxgv5mV9I=;
 b=R2fC0McBml3rl4ic1RH3da6vXUZG9OqO9uFwb9L5SQyV7qiWDw9TRZ7y4A262BTXGk
 sY2nxsiq3tW6fI4QEnUpXgqcM1NjLYsvsqehpphnmzNPreG46bIPvE4Y0mt5b0R6V1SU
 5ylcOOq4Bsx41n49Twm2HaGwbUPpbGonO3kzs9nLFb+ApeH8DgjiZOVloP0AX/fV3RXp
 X6PWXutSK7IaBFvxxQimgXCpgT3QqtJhROPKqruxHRNjXBh/p+TK3eS/kgg1HNFxzrXM
 RoPdvFyXPjFSr3W2XzPjqVZvcML9hyTE2GSMla96IXhyWWUhLPZrF8SNjbj4Ufos2Ds+
 BfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469527; x=1708074327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uecpz7Rb+EX/CcmBYnI+TtkUcrh2kOpPPUMxgv5mV9I=;
 b=f3fY7gJH1URbiv/jKYmwWRYKRE8oMygruIaAjM5uPHDMYITTSoxtRkhsYU8flngvOS
 5ZC2wNXiDY5SuRlEvv7xxgxi2axjT3Vsgj0LJ4q5daYZnXn9gkR/ZAapKIoBq59wgO2y
 1C+lTGRUxbnqnxMH32exj2i8sM5WTBASgvrcfI21Lrwxz3+XhMXp7m9mF12XtMJY/Q5p
 hGt76lJ/kgnyuNTzSONqohcujX1CQMPdfrN70mlEtognGyKYMBbWNU6V5JfLhcHNnR9S
 8nKrlSBQgnLMGQxXFmEKVTXKHxSb/CZaIFxqks7fTaXTXZwfJXR70Ma+kDdS+wiEt8TC
 bE2w==
X-Gm-Message-State: AOJu0YxMeDBv5J4NcAd/X93tQI91/nchlQggOkS8vTwRRr278q7f8sLD
 qwhnn4xuiXml0DT3FnpRldy04mkLgFMn1pNTd2emJFIAa/BIz1SgkX9Nu07anyMFrPIrfCNbAwW
 nRSA=
X-Google-Smtp-Source: AGHT+IG0Zn5QjzYRE/O3jDPUHzQLFP+gczTROeCAnyYz8s/3MhlIBPfgZtDjrZ335y4o/L/8QLx7GA==
X-Received: by 2002:a05:6512:1391:b0:511:66fb:9f95 with SMTP id
 fc17-20020a056512139100b0051166fb9f95mr690815lfb.3.1707469527238; 
 Fri, 09 Feb 2024 01:05:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMMNSRw+vHtY3A5hZBXwEkP96EhoqE4YeeoC8kwtZp21h5+7btLsUpoPKSIS01PDEH3pmi8onOc7M6yDrwcW9Z1ynejISGrC5Kw8P6qAFCSHXOZo4Lvv/d29/h8dgFBVeYxEfCB3anb2BfDRYOra+2YMPNkWEZI5gODG7imkDW2AfnJ6uQ78a0Y3y00cgmQqg9BBuP3cE0pHSmU9xRnwgQCLm+TkIXE6mySlYE3fsOlFYEriqbeyaWJ/fCa4ljJye9N29HXAwJ0k0lWrAAjtonLeBoflUe8vZjmUcmjOim4FaLYxHj831mT6Xdk3ZDAwqE5sO5jourPobTLbJ1VJJeEPmKLc=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c314a00b0041076153a40sm497054wmo.44.2024.02.09.01.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 02/11] hw/misc/mips: Reduce itc_reconfigure() scope
Date: Fri,  9 Feb 2024 10:05:03 +0100
Message-ID: <20240209090513.9401-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Previous commit removed the MT*C0(SAAR) helpers which
were the only calls to itc_reconfigure() out of hw/,
we can reduce its scope and declare it statically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mips_itu.h | 2 --
 hw/misc/mips_itu.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 5caed6cc36..3a7330ac07 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -79,6 +79,4 @@ struct MIPSITUState {
 /* Get ITC Configuration Tag memory region. */
 MemoryRegion *mips_itu_get_tag_region(MIPSITUState *itu);
 
-void itc_reconfigure(struct MIPSITUState *tag);
-
 #endif /* MIPS_ITU_H */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 37aea0e737..db1220f8e0 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -86,7 +86,7 @@ static uint64_t itc_tag_read(void *opaque, hwaddr addr, unsigned size)
     return tag->ITCAddressMap[index];
 }
 
-void itc_reconfigure(MIPSITUState *tag)
+static void itc_reconfigure(MIPSITUState *tag)
 {
     uint64_t *am = &tag->ITCAddressMap[0];
     MemoryRegion *mr = &tag->storage_io;
-- 
2.41.0


