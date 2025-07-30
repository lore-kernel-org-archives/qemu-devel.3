Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA1C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvE2-0005St-2z; Tue, 29 Jul 2025 21:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCb-0003M2-MJ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:54 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCZ-0004l6-Vu
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:53 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-31329098ae8so417736a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837310; x=1754442110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMd8J0/RUWfhwFpStoHOnaEZ6YL81TnlupHumGV85nQ=;
 b=a3k2m/n4x1VG3HDio/pmlU6NKqTf2T9sZpNrLbnSK2gE91evaAHqQVAulhYz/n8sOG
 uv3t2kzjE++of5s+ihXtOQqOnaLF3uze6z0ShOaqTpS4C9N3p2Ewrmix+Y3NnffaddRP
 33N71QHeJ4f7qjwdnTEgj4nMSpGe06omTPIlHUJXgiD0gMrxHSRDEYCYpHLUR5Wv51Zx
 cGw9pyfPOQaDX4nIZpV+44rE+K23RjmnsdVgFk3jSfg0oQy1TVJKUc+mrtyraXk030A4
 GAFq2lOIN7W1/DRd3I9zDAMFlaGBC6YMeVWCOjRFpfp+PdGQH8uFN2ua5MYi8bf59Ip1
 UFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837310; x=1754442110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMd8J0/RUWfhwFpStoHOnaEZ6YL81TnlupHumGV85nQ=;
 b=BGx/jSVf6P2N4bx6/wLhyXR86e0o/uKspyiO6yBv+QlftAm3kJ73Dn8vOuD9B0ZIHn
 Vt6+eiV8Vbw8M31YcjpORa+2YSePuE/MFNGmp+t16jO3Sbqfm5tYDxl4RNLQfvdArHHh
 Ybid7yOlLPf1YY+eAFGBB9UBP/XojxhXBTD0wCVLJQaJ79wuv+C9ly0oA3ChMB91PSZd
 9rZmvkiJXQxD1YQoX5TjNNMKtSwCCPi8iwMwWZHwSVm3qm1f7Q6QoKayNQsmyaRcSlY3
 n/tHaqBYRvIqr+8KnjJ8j1rS0/vY0xzsO8ptXWVFtR0mCm0c1ZeJ4edw4qVfr+IHdO6W
 KQNQ==
X-Gm-Message-State: AOJu0YwR6VQNBPxZARGUVa+jtphySUB4ANPtOmJDJ2rGqVauBVAPFgLc
 DFxR9feZraC/N9brwp4iqn/2SxK9sEGXFuujqr8qzSKlarzaEe50VkywNl12Qw==
X-Gm-Gg: ASbGnct7E9tJfhzvdQZj4GzM6kIYLGMUNoPEryATx/5rF+7lLb7VHg/qT7k5untuHVD
 widWF3EfD8Mb8CRXSyWELTdlqnMlvtSaKzaIAiNowelBxVCG7JXp8DlT9PL/7QBCzb+SgyGfbZ9
 ILi4Mg45lBuxBm3XL3o8HG/MWnWTlrovGfxgtNW0XVldxGbwR9uZznqwOsb5ZAN+cwtRI0sNnh8
 ujb4WXK1jVF3b5wukHkJHLDmcgpWagSej3/xuctvkDKhe3VkONot3ZminiFql+/o5fk69MSon/R
 FQehU8M2dQ45anIi5Ga8zDByqJ9NzPXig9llMIku77GRzIReRMj7VFq8jhdvKmUrLxKfGrnQtWT
 KeFOZiGVQCWAjT38jweDA7l69Z1CmGJF3npNaerAeqkb2lpLkqEXlRvDWrlk0KhEKHZJhiQoOi8
 35a0s4/VYsOPJmLCVL8YRbEA8eYHQmATykx2h+SQ==
X-Google-Smtp-Source: AGHT+IE8u5vWLhLuW7MX+gfr02O/JuxKnUCPM1DfJTHjW3o05TOlZPNTXrJLBr5Y4sSuOgGlJpMUaw==
X-Received: by 2002:a17:90b:4cc1:b0:30e:6a9d:d78b with SMTP id
 98e67ed59e1d1-31f5dd1f551mr1857328a91.12.1753837309760; 
 Tue, 29 Jul 2025 18:01:49 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/11] linux-user/strace.list: add riscv_hwprobe entry
Date: Wed, 30 Jul 2025 11:01:17 +1000
Message-ID: <20250730010122.4193496-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're missing a strace entry for riscv_hwprobe, and using -strace will
report it as "Unknown syscall 258".

After this patch we'll have:

$ ./build/qemu-riscv64 -strace test_mutex_riscv
110182 riscv_hwprobe(0x7f207efdc700,1,0,0,0,0) = 0
110182 brk(NULL) = 0x0000000000082000
(...)

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250728170633.113384-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/strace.list | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index fdf94ef32a..ab818352a9 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1716,3 +1716,6 @@
 { TARGET_NR_clock_gettime64, "clock_gettime64" , NULL, print_clock_gettime64,
                            print_syscall_ret_clock_gettime64 },
 #endif
+#ifdef TARGET_NR_riscv_hwprobe
+{ TARGET_NR_riscv_hwprobe, "riscv_hwprobe" , "%s(%p,%d,%d,%d,%d,%d)", NULL, NULL },
+#endif
-- 
2.50.0


