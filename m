Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6722CD2B950
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LzP-0006jk-Tf; Tue, 05 Nov 2024 11:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzN-0006jP-MG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:05 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzJ-0007Os-Rw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:04 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso794826a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730822459; x=1731427259;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQg34qAwXV1dkoltfasHGRhCwLkvl9EuX77LcykV+9c=;
 b=HHZj1xGF3SCsyn7oDmN6htoRkX9v8OAFQLF6r39t1y31c3vm4kpCBaHPSe3fuKTTMb
 HHdOPhjR6Hbsn9U0paO26cCXlWhiGwJswqXOY+PS9sRVhm+q1vHS9jWC6KgCgmPQGiwM
 dzLWn7nIhTTR5s6ho0WvgtQZhIelH5YdDLOkc/OfqhaF/oJsy1tbBHwCJrDsIdvdorXG
 H3H5qtJR7z61dxKQL0v/wno9l6dig77DoV17YjI+3iUroO1Jivztp6fAAJG+CMT+FHef
 u4MKeTOh1vRS6JM3eJCEG9zBjFDITO1nWN4w/QeZDXEs57Xv36tcAV8NdqFWsiWix5qf
 32+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822459; x=1731427259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQg34qAwXV1dkoltfasHGRhCwLkvl9EuX77LcykV+9c=;
 b=vDle391VTr1kMwHB5pBPdIV7naCUzzLeeSFNXaxuYeVFBAYXv7Wbn0dtYSw2/R5/40
 572V14XyXN5xjsGzGCZG4QnqfkcAvXG3n5gY/FQCHoEj77XJnlaMVdBHWvYfhEf86mSg
 s/ky0Uc/XdAuCvxWtJnusBK0DAqeO7hhqnZLCMbxi2zJrr3RdZhlBbaF85qSJNyGjIld
 ytKTdl0cVvsm5G6wf9Ad6MkvOMes79vjFKiHNvvQP5Ni5ZMq4mEHQBkdV3ugGt3PoEHr
 VToyoEwIITec130/VN778q1e+k/lT0UPjkp9Q8+YShu3+ABjCnKvz+jJOgqCq+5rVuDI
 td6A==
X-Gm-Message-State: AOJu0YwmqPzaytXOISBYD8ziZcJjm/DkkqPbglkHLTWevYMjdPV3FFWn
 IaLM9Nfc/tZigcn903N/pnZPi4gFcMPhMUB4lCQ+Qrv+Rp82INv2HLalfBO2j3EANU3ueeME1JH
 QkA==
X-Google-Smtp-Source: AGHT+IFrtJt8vU6w+QZF6jAz0BpW3FewtCVaWYGz9QUlUYb3vV+bJdnYKBpM9c3YJguoV5eNhkap/g==
X-Received: by 2002:a05:6402:27c8:b0:5ce:deb2:6a8d with SMTP id
 4fb4d7f45d1cf-5cedeb26affmr6647262a12.0.1730822457335; 
 Tue, 05 Nov 2024 08:00:57 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a41bsm1467773a12.14.2024.11.05.08.00.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 08:00:56 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, pbonzini@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 4/5] i386/hvf: Raise exception on error setting APICBASE
Date: Tue,  5 Nov 2024 16:57:59 +0100
Message-Id: <20241105155800.5461-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105155800.5461-1-phil@philjordan.eu>
References: <20241105155800.5461-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::530;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x530.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

When setting the APICBASE MSR to an illegal value, the APIC
implementation will return an error. This change forwards that report
to the guest as an exception rather than ignoring it when using the hvf
accelerator.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_emu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index be675bcfb71..015f760acb3 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -794,9 +794,16 @@ void simulate_wrmsr(CPUX86State *env)
     switch (msr) {
     case MSR_IA32_TSC:
         break;
-    case MSR_IA32_APICBASE:
-        cpu_set_apic_base(cpu->apic_state, data);
+    case MSR_IA32_APICBASE: {
+        int r;
+
+        r = cpu_set_apic_base(cpu->apic_state, data);
+        if (r < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
         break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-- 
2.39.3 (Apple Git-145)


