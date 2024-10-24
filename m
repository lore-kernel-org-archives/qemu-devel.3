Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CCDD0E3F8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43k9-0006Oh-BZ; Thu, 24 Oct 2024 15:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jr-0006MW-1O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:19 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jp-00081s-Dp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:18 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so20397031fa.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729798996; x=1730403796;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQ/wvxuTvQaiavS01m+IKLgZecmKu0OzwEWLUO9nnOE=;
 b=QC0qOy/QbhKv/rtQKfJjK1pbuAHOb2WBwwAMY7b/Eef4PvKIT3KaFbDDA8EV2mObja
 NCd58jmuCfwCA+eyg5cvr2eiOp3ejEZ+jc4EShc6UYdah1LVlH7MbaWp5rzC+2otiVvO
 BfBmitCt2rdMQrHXvnN2Q+JW9Kpp3b8fhIR1IQlauqHrPfyFLeURfclbbwsYmLbJW+UV
 o6GHokSA8sNBXkAvy13z1Qgx8fRvzCd3j3XQUbFD/6HRfcNXvc0bDbqkY86natcoV5yJ
 t3yooTzt+TvURIJI/22eky/LFuN8bmL/pnwB1nk67oDPXb2nBhUeteO42xVEnAUW9wqB
 s4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729798996; x=1730403796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQ/wvxuTvQaiavS01m+IKLgZecmKu0OzwEWLUO9nnOE=;
 b=hRc/ys6hcSBUm5Bxwbbn+Mqczs3+Pr134XOq5Ezp0slZQ1+AfVEzeX78UKJfG4CbyD
 O3O4blVRHjmsHQe/oI9r841HSc0J2LtiSksO6oSCyEFr1TIN3qYO4FUYYUtmVXWfwsUf
 6IJL87DSYdZdSNJBw3hEESKtA7W2Dcma+nhOECtC/BGbRaj3SbjBdJgtbVM/KpeX8Mi7
 7DxUFoeqKNNhBGjTvbG2UJoespRC9suHeBBUqEqvSESRWz9ngMMltQrK5jFBxLMg405d
 L6vgCp9oUdCWhbubf3jUqNckySEo5O5O9UkC9tc74nCdrvvMLhX1ydURezakZvWJ1Ed6
 YC/w==
X-Gm-Message-State: AOJu0YzkbKlSSlvm1RmWq652xDXFfNvcsVjJn9i9pyddNXn+Ch6vcpDV
 ZCN6PN5kvW1KxBcIxcu3STxvyeHQQEflKG4wj0D0LWqHEjr8HMouezso/G9jp9W5wymKZtJrA21
 OsA==
X-Google-Smtp-Source: AGHT+IErPCr1lx2PKut7PFBXRgnYuP3JhIurv8PkEvGIdyWlUCU16/GfguBhyg5L41TSSwR7lLEADA==
X-Received: by 2002:a2e:b8c5:0:b0:2fb:3960:9671 with SMTP id
 38308e7fff4ca-2fc9d31a99bmr70046091fa.15.1729798995571; 
 Thu, 24 Oct 2024 12:43:15 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6545sm652536866b.31.2024.10.24.12.43.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 12:43:15 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 4/4] i386/hvf: Removes duplicate/shadowed variables in
 hvf_vcpu_exec
Date: Thu, 24 Oct 2024 21:43:03 +0200
Message-Id: <20241024194303.32100-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241024194303.32100-1-phil@philjordan.eu>
References: <20241024194303.32100-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::233;
 envelope-from=phil@philjordan.eu; helo=mail-lj1-x233.google.com
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

Pointers to the x86 CPU state already exist at the function scope,
no need to re-obtain them in individual exit reason cases.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8527bce6eef..c5d025d5576 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -586,8 +586,6 @@ int hvf_vcpu_exec(CPUState *cpu)
             break;
         }
         case EXIT_REASON_XSETBV: {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            CPUX86State *env = &x86_cpu->env;
             uint32_t eax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
             uint32_t ecx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
             uint32_t edx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
@@ -644,7 +642,6 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             }
             case 8: {
-                X86CPU *x86_cpu = X86_CPU(cpu);
                 if (exit_qual & 0x10) {
                     RRX(env, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
                 } else {
-- 
2.39.3 (Apple Git-145)


