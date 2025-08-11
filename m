Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B07CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVz0-0004rz-4F; Mon, 11 Aug 2025 13:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyy-0004rA-L9
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyp-0001mz-Cf
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso2798966f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931996; x=1755536796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kCcMKgJsUFQdM/mVU8Sb2r9KycdWMl/tLnBwMf6U/Q=;
 b=oy/l4rcInepRoex/IKDezCvpAgxqsY/leWH8zOO35rCDZvfMUaUZkus1icH2RBLMa9
 nmxfxPeMOAo4C3TfUhRrTGCi+S08HYV569JdpfnkdcxEoAwNKARIc9gf5wX9/LzxJMEg
 MwBPM65hUbakaRTbYWV2x776bfbD9ElEy7ljjDmMSkytCOlpUp4uH+5nj0R/ryBRZF6n
 ioogttgRz90TCFvgUfgBG6yQHDchtvYPWi6wvjF7uuCD1EbzTfz1u/nIz1Moc1cjq1qJ
 FZFtGV5F4aGlFh376rdDE88nvrXP9bCiJmESrxkpoQiIDNPVBebOjOl0P/Cpl4UT59oS
 qLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931996; x=1755536796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kCcMKgJsUFQdM/mVU8Sb2r9KycdWMl/tLnBwMf6U/Q=;
 b=wVqSyTOka3klj/j7ij3zncKUxUzmxNEwTFQo0oM7/IEJgwdEQdjNZIDLo/A/N+odXe
 Zl5IUKiyIHlcnQWUcBsppd/Ji0z3bwkmSKImt5IXs44Oernc9n2DQGiQ0mcDdcQolWNX
 w3J04r9BWL9xUyUcbmibK7i5nHaRvp3JyZw5OP+mdiG+cqHb8OZHRofevB4fCUbrOr5f
 IYc8MJjdn7hiyU4kdssvtbvapZA7RZ2hLNXgsminx+0bGa7NDBpL8Jgf4FdOXPd3mOtR
 D7RGiMRQXaN0mL1ruPKvbjneYAqz11TUR+9Vrh67c8QI+X9txyVtK4uhqJtZVbYRwc4P
 GRbA==
X-Gm-Message-State: AOJu0YzzN26tFh7ih96tXv4KQHUdLzO5GCJtiX8174fSk2QRpcQFCuHU
 9VOTTlvSgoM+iUpyCUD5E0aOQdWzkMBnZI8+ICrLy8CORopKwueFOfkDGbfEuNxvH56jnZMHtpf
 0O0uP
X-Gm-Gg: ASbGncuRZsvW4MuJBikEYHkdKksSbAPrP4KFDg6X1SSgEX8Ikt1IN4go5meMxWmWVbH
 chSzp6zxV7EN1s3VwH14T/LBwibMrzS3ziloaDUla2QVso5903C62K/32iFEhed3nMjI/67QIZl
 OH6+8u6ii3Wxm6kqvwXtgcqM6wUHfpuRNIBLq9g7S3iT7yZwqhyNKQwSwazB0+4OBUmZvkVs/06
 EStgr3aTvZEIl2rdcpC77R1FwpTsyvG3HQoJ04hlYScuSAXCTCUgg7wjD/htbBq9gHSsMycK2U5
 XQzrCsmdxdVhtvEQ0Bt8BDqF/bFpYHyYPcVmviwpX6jfdPd7xU2U/jfzVZi0ajd0tmi/C9jjao8
 /ZeYRr/F1sMXamfQdxVzTfiZw43HZiFsQ29HaqZWV/lztjXN0BMbLRlkgmUI2OFDgUmNcl7yT
X-Google-Smtp-Source: AGHT+IH0cwxj5ttg7X/SuYwtZcuM0ETCatH/wcruBaxy12H3LRe2v4MWcJy+yEUAgit00aPOKJauoQ==
X-Received: by 2002:a5d:5f53:0:b0:3b8:de54:6e64 with SMTP id
 ffacd0b85a97d-3b9111b5fb8mr312079f8f.26.1754931995845; 
 Mon, 11 Aug 2025 10:06:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0846777sm31486669f8f.48.2025.08.11.10.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 04/11] target/arm: Factor hvf_psci_get_target_el() out
Date: Mon, 11 Aug 2025 19:06:04 +0200
Message-ID: <20250811170611.37482-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Factor hvf_psci_get_target_el() out so it will be easier
to allow switching to other EL later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47b0cd3a351..81dc4df686d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1107,6 +1107,10 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
 }
 
+static int hvf_psci_get_target_el(void)
+{
+    return 1;
+}
 /*
  * Handle a PSCI call.
  *
@@ -1128,7 +1132,6 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_hvf_psci_call(param[0], param[1], param[2], param[3],
@@ -1182,7 +1185,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
         entry = param[2];
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
-                             target_el, target_aarch64);
+                             hvf_psci_get_target_el(), target_aarch64);
         break;
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
-- 
2.49.0


