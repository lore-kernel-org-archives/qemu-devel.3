Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73BAC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5n3-0004b9-T7; Thu, 25 Jan 2024 14:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5n2-0004al-Qr
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:32 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5n0-00018B-U7
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:32 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2901ceb0d33so860077a91.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706212409; x=1706817209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/oyfu8F9JrvZRYOrB3TV7TzLXN+nQeozYC9MMIMKt4=;
 b=muTUxIjIyHToMoqPH5H+zN9d73rGRz4RPCJ/I7frxYwy97Fgp/gX1tA8lKonIXw/Uq
 0ATil8GUand02aumrGhgVqYr8Mt8CoEuGWWLlWnGk74N95DqTr0B5phnduQ/Ib2Kl6jI
 25vqMMeE0JXLetr3Z4oSSrz9RScxu/ocR/qMiUZOP1j1L28qDv5kpxW3ENGaNfWiYfUV
 xr2gLU1JbBFeIn0uVLsw1tMjygfNJ7ZKrifC95IYqCfGV55e+RoqVASp3p6J+PdifqkB
 dRXmNapU8WxgWZF4hDitgKTbPZf/FnzhEgdFtoSow5Qr00Fx+N2GS+MJGuJx51PzTHOH
 2R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212409; x=1706817209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/oyfu8F9JrvZRYOrB3TV7TzLXN+nQeozYC9MMIMKt4=;
 b=NnMQNOyxQKwDvpNzAyKhw6DplV8blkVtR5ITjoJXAYVekRGPX7GW2Vs8Cv87vFZsOX
 2pLuFCYuZDIvqKm+sAjYa7zpaFwFoHreTzI8CEaeTJwyLT9ByCRTgYATJg/Nil3c+pLA
 Q6ZgNCJRk2IgQmn4Xl/70HabZKBn5+0CYJNUPJ3meM1nS1MmbJxO9Hi+EXvEprLT1gmb
 DkFve09iHJRw2Qdj+xvCChIdrUAo3UGsClXItbW45R8FdHGIVqL3kH92cNoj/LFHJo3C
 HM+yrdIcJjqXU1pIr0bUoLQosW7tjcEdh20mE+4P+zyPpBc1gbD+GGj6DJsIvxutf5nz
 srPQ==
X-Gm-Message-State: AOJu0YyAyW1pjMoHrs4w02pHitZONsANs098re34xBGCFtauVuJ3PnoE
 WJA4ZTpEZ5afnmxYFuu/hUnf+MBSThNFtZJ2mda1WqRYyCJmukMhHp5grA+qj+trxO93kdXIaRG
 O
X-Google-Smtp-Source: AGHT+IF5d+a2aej83/NQuV1JReLHg5rFAIKC9IRPwRlVTqtA73VDKA9JHyN6xVNzzmb2+6B9RkdckA==
X-Received: by 2002:a17:90b:390e:b0:293:9966:6b1a with SMTP id
 ob14-20020a17090b390e00b0029399666b1amr73360pjb.39.1706212408793; 
 Thu, 25 Jan 2024 11:53:28 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a17090ad40700b0028b6759d8c1sm1958613pju.29.2024.01.25.11.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 11:53:28 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/6] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
Date: Thu, 25 Jan 2024 16:53:14 -0300
Message-ID: <20240125195319.329181-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125195319.329181-1-dbarboza@ventanamicro.com>
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Recent changes in options handling removed the 'mmu' default the bare
CPUs had, meaning that we must enable 'mmu' by hand when using the
rva22s64 profile CPU.

Given that this profile is setting a satp mode, it already implies that
we need a 'mmu'. Enable the 'mmu' in this case.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index da437975b4..88f92d1c7d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1107,6 +1107,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
 #ifndef CONFIG_USER_ONLY
     if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        object_property_set_bool(obj, "mmu", true, NULL);
         const char *satp_prop = satp_mode_str(profile->satp_mode,
                                               riscv_cpu_is_32bit(cpu));
         object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-- 
2.43.0


