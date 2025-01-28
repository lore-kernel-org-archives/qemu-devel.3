Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0AAC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmTc-0007jd-Sk; Tue, 28 Jan 2025 09:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTX-0007hX-SN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTW-0002I1-3E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:21:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so63369085e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074114; x=1738678914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GTWOcGkuvsTBXu5MPW4cUBKzI5fUdevEC8idGZXnYVo=;
 b=NChL8UFTNB0yeDL2ts6N9tqh7Iq3HPgrCvMH3on/+zFuSBKZPRZ/TV2gfvHL5jkYYX
 1+tfAOKADypb9N/FuSGIoO//RbXMrHntUfg6dIsBh7A1wBmmTl5oFcNiKv0ITMx5K3Km
 cHMdSUVBwnddZon1sBAMl5T3yDSGvxvOLTt9eI+UFLI+d2mJWhgjrm53rFCT//Hp3TJj
 tYzaRIl0blnK74bF5IKZmhYTD1LiL3dxLf+pelr6mSl4iFazoGjdNzohWnbhRdH/Q0R3
 rh6ST8AA7004ZN0n4yCeDIJMGRcco5FhT6/WXtGhObX38YYa6GRCShweeQme/7YAC8Hx
 A3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074114; x=1738678914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GTWOcGkuvsTBXu5MPW4cUBKzI5fUdevEC8idGZXnYVo=;
 b=G7jFMrrErxWFag1dCEHbvaRta25hY8pH34jujTNEmyfjQE70/EABXZuKBELPpsnNcb
 xu2MaYiOpamdl/62dYaLqS5vmdBeivcaJoCRcNjJ755UhP7VpWkO8WvggMHBVr2fqv9h
 QcJtphqJieITT1fpKyERmY603QTRJvEpxNOyp0AeTijXoJWyCnVdnUHH23UiC+enj4o0
 d7MdXOUlL+UfBPa5t3mefmsK0Rr+lmZdKsSkPnYkgJPVjPRiKtEXfkR0YnAjZLAT5Hfz
 7XKNlk2O9GpL7xkHjLKc2nHERvwX9dVSmu8BpiJdorplfOZinj6O7qkCuMfXuxuNgJO3
 2jjw==
X-Gm-Message-State: AOJu0YwGbXl7VNKC3A1Fd/jrCwfWkRLjvrt8ZeLTiPar5WRYli9Zxt6y
 7cFSmElsmpwFf5KVABvB0dufwwm5zOKfCOZmhvj2YoQZOmpoB3ZCvcLS8si1ujcbRRK9ySLrDhN
 +Lgg=
X-Gm-Gg: ASbGncvaEM9Y9dR5jQzWCu8fnzSWa16t2IOdRY9JUyLBQfDHNnu3jNYwK6YJXUFi0C/
 ThOH5fkmeBxa/P680q/Sn060SMJQ5CAZAZhySnDJ2wz/TrrDek2QQhRGLzP1wdvmq9SQkDRm1vs
 fhxqFcilFxyyTaVIuqYgyWyux7j2KG72+mZfyri+iVm6f9GLopqXckHjNV4xm7lngD7F0KH+XNA
 W18F8r5u2ZveJoSloX+IOlvM+Xnoz7z23hPhpzQTC9Chj0TipK9/X4vzwEileah/A/ZLZgCfqLb
 z3V9dD+BrX8sQjviFWsaEfF1i9vuw3nBm9r8Fr9zB1Kr7N3/29IAMfUUndXc1+XYGA==
X-Google-Smtp-Source: AGHT+IEDmxhLcOfTcSEi37XXd9ud7b8QXTwfgTu2TslBgmGqCsHxl82T7fwyR9UndhuusIGzaqFKDw==
X-Received: by 2002:a05:600c:4e06:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-438913c60e1mr415615875e9.4.1738074114496; 
 Tue, 28 Jan 2025 06:21:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f367sm170386975e9.7.2025.01.28.06.21.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:21:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 0/9] accel: Only include qdev-realized vCPUs in global
 &cpus_queue
Date: Tue, 28 Jan 2025 15:21:43 +0100
Message-ID: <20250128142152.9889-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi,

The goal of this series is to expose vCPUs in a stable state
to the accelerators, in particular the QDev 'REALIZED' step.

To do so we split the QTAILQ_INSERT/REMOVE calls from
cpu_list_add() / cpu_list_remove(), by moving them to the
DeviceClass::[un]wire() handlers, guaranty to be called just
before a vCPU is exposed to the guest, as "realized".

First we have to modify how &first_cpu is used in TCG round
robin implementation, and ensure we invalidate the TB jmpcache
with &qemu_cpu_list locked.

I'm really out of my comfort zone here, so posting as RFC. At
least all test suite is passing...

I expect these changes to allow CPUState::cpu_index clarifications
and simplifications, but this will be addressed (and commented) in
a separate series.

Regards,

Phil.

Philippe Mathieu-Daudé (9):
  accel/tcg: Simplify use of &first_cpu in rr_cpu_thread_fn()
  accel/tcg: Invalidate TB jump cache with global vCPU queue locked
  cpus: Remove cpu from global queue after UNREALIZE completed
  hw/qdev: Introduce DeviceClass::[un]wire() handlers
  cpus: Add DeviceClass::[un]wire() stubs
  cpus: Call hotplug handlers in DeviceWire()
  cpus: Only expose REALIZED vCPUs to global &cpus_queue
  accel/kvm: Assert vCPU is created when calling kvm_dirty_ring_reap*()
  accel/kvm: Remove unreachable assertion in kvm_dirty_ring_reap*()

 include/hw/qdev-core.h       |  7 +++++++
 accel/kvm/kvm-all.c          |  9 ---------
 accel/tcg/tb-maint.c         |  2 ++
 accel/tcg/tcg-accel-ops-rr.c | 15 ++++++++-------
 cpu-common.c                 |  2 --
 cpu-target.c                 |  7 ++-----
 hw/core/cpu-common.c         | 18 +++++++++++++++++-
 hw/core/qdev.c               | 20 +++++++++++++++++++-
 8 files changed, 55 insertions(+), 25 deletions(-)

-- 
2.47.1


