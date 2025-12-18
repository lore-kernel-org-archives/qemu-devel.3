Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15EDD6E2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo8-0003xA-ID; Thu, 18 Dec 2025 13:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWIn3-0003nx-Hi
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:53 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWIn1-0007MU-RQ
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:53 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-598f8136a24so1060903e87.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082710; x=1766687510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kK/8BDYclAhYqhTuMn481i6aXarsHINljHJpjl1/oTo=;
 b=cd+x5FMMdocZt4oUEE9OdiOPkVrGtPGcIfg3r/XG8/khanWut/f8RkkbU9tck94+rm
 6+rDlkyvS9oPPbS0rnfi0dQjQPEx2FBGUgkUMZzTr/DhPbR369zZOBv6PjRtL3Ue3Jp3
 FDgM4d8PQoOOzhnTm1x3ppfrcC8PVFTBD+DsIwGuRsUOvx/hoRTreQf/XpZcFxxJbRn4
 yGWXoNtDN7j75LRnj2zs7VTzSwtF6Ip8Q4CmDBCI2YQlYQWV/3TQJlRp2oENuKWAdb12
 vkbE2tQNr20wE7DNArF3WE0gS7IFRChQVxKyjfAQ0IVCmcLXAHLF2ecxISaUefgrxvb4
 akfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082710; x=1766687510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kK/8BDYclAhYqhTuMn481i6aXarsHINljHJpjl1/oTo=;
 b=w6WDX3v0sCCRl5ujoE70E0cK+FjMbdOLSC5YOz0ZWkR+EQlgNeqsIn+gLNd7SesjGO
 eNTp3WyqynM0uKSjS4vfCXWJJIP7hjHeu6hBD8evqD6L92V5wFRAgzn5OCt7+D8pnQ2Q
 wfdaoFDsr2fjytANRX0Wmz9JOz7OYp6asBtW7JUvv8sW3xzfYXbJr/DLp0x7/vRbkkXL
 ZDtVxMVYK7/+lG0MwU2x3g4cwUPES/Uk81bdKeHEdpL6OjTc+vqLQG0GEm6mHWTEjmr7
 o/NM5geAtMARWYmvnAiNTLES8rIuYk771bUyUKVulOQRh8PJ8l2JxGGKnx2dUkr8QA1H
 AV0Q==
X-Gm-Message-State: AOJu0Yz6TZpa2Iw+MMMqoPVQXiJFmOhdCL/N5XICzRN1EBiq4iXcyWov
 kbFTiE/FUion+i3bRREDDd3IzRGOGMx6BfliaE9hyl1cLRT4yQ5+W6k+lrNRM5UJ
X-Gm-Gg: AY/fxX4z9pg5Dth/v+aLomzboihxONZzIRvISBiFf64H0wQLn6f3P699fUYPPUrg0XC
 +sPfkH9cy+3j+lCGhix/0kfIjUi7NdIgoe+1K6UDfcOHBZR1Wc1r9uUx2x7NdYd/IJMe7l7aUSV
 G58IaeP4sZSJnlvsNqDfUKVsGXi+oKrmdDkt1DYbHZ5ZnWw0jyr8qB7L8qbWRWROMXdhDyxLI89
 anw/05F/EojDvqdqx1KK6D+FGvx69k5u9MsIgmxqhQpKk0B8aerjogBIR7lcDWGJ+18nNgQrBS0
 pbIv7GvJ0XK9edqPvKLmrAvhyuPzMJI7JsCtFhJZEuYgkBSVUi0tjotllqHSPeazUX9nPBPy/Ob
 sMAVISagVNEKPCICEw3YG2BEWpk9p+NOG5o+pfz4nOJlHjsRGY70u30hCw9TjW8povrIXKp/jX/
 S/Fht6ir4v5o4H
X-Google-Smtp-Source: AGHT+IHCrr1ZQ1hkiOQuV+5QCCfn9EDZMGOoyBKlU4Mr4qZVKArybDZZugepNcWsu+jcV6xbXAYhqA==
X-Received: by 2002:a05:6512:b8b:b0:598:fd98:e9cd with SMTP id
 2adb3069b0e04-59a17d4958fmr170938e87.1.1766082709350; 
 Thu, 18 Dec 2025 10:31:49 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:48 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 6/6] target/riscv/machine: Add smcntrpmf registers to
 VMStateDescription
Date: Thu, 18 Dec 2025 21:31:21 +0300
Message-ID: <20251218183122.408690-7-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218183122.408690-1-sergeev0xef@gmail.com>
References: <20251218183122.408690-1-sergeev0xef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:44 -0500
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

Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Alexei Filippov <halip0503@gmail.com>
---
 target/riscv/machine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 5083bbb1f2..2f6a5fc25c 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -474,6 +474,10 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
         VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
+        VMSTATE_UINTTL(env.mcyclecfg, RISCVCPU),
+        VMSTATE_UINTTL(env.mcyclecfgh, RISCVCPU),
+        VMSTATE_UINTTL(env.minstretcfg, RISCVCPU),
+        VMSTATE_UINTTL(env.minstretcfgh, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
         VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-- 
2.51.0


