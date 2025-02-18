Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88101C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvD-0006fb-Lu; Tue, 18 Feb 2025 11:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQv8-0006eb-75
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQv6-0004O9-80
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNVOf8cteKprFV/c4sEs0Ac8UK6jFPeO8r7YxasCam0=;
 b=MEt6UJE0rEj1CL99Eu0bq12f/hduJiKry2bgwftkcJNa/Uitw9T86IHreacluFxR4q1urW
 nC65ijyDoDA07r/Wf+eJrbTDNqOaaLuGpBsku3O2aobGErwNjrxRKi8SR+DUR3op5Q013z
 YZOJKcdi7z1ZjHWCb9fUaQTBl/QKvK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-j9FungjoPL6zpuKp7HWb6Q-1; Tue, 18 Feb 2025 11:58:00 -0500
X-MC-Unique: j9FungjoPL6zpuKp7HWb6Q-1
X-Mimecast-MFC-AGG-ID: j9FungjoPL6zpuKp7HWb6Q_1739897879
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-439868806bbso10422165e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897879; x=1740502679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNVOf8cteKprFV/c4sEs0Ac8UK6jFPeO8r7YxasCam0=;
 b=fCqSoGMOi9Ko0uS2o4K1w9/x2hbrvap6rRWqAA4JAMVzSGfuOhfCgW8aO8FPeqCR0w
 d+WJIfQBu5fggtEGg3gAd4hci5Awm+di9bOWuVdEkPhWeXaJiBZ1Ws99Gkn4e+i6/5WP
 VYz2UtTaAD3PD/+REYvaziY7utCFXkxVR/HL7Svk8KY3MrEt6Wa80+jxhdQ6K9Z+C6hX
 ALbqGhoCDCV3Nlg3zXxK8QVwRmFyGMsIZCqN9y4L01yikW0kFn26te2Ur4BS1Wdpfd+b
 2qN/mSzLSgIeK7qN970PGos4AwPRs1t7sEtjwJnfvVtdycBRW5ugzIziP7BrelDQBjUw
 bDbQ==
X-Gm-Message-State: AOJu0YxMN10AYVyMqh9bLdsdf0yeMzXydOmGau1SvvOxOn8zmiJJRlq+
 mLuI1aPG9o4fPhinYpuuCWrzwTIYOcQqHk+/9sFAwpEDGEyNXsl6GX+LN7e6PpansmnO/o1Zpzy
 Cy2yA1I+MHbPKk5dD3o2lcgIzS72WyMdiBINbrIUk0+pNjZ+A7Eun/1VWQlPG1T/OYbZfP4XE4U
 DpV87/OWYaGZGJvDwF9ZUbdpJrRol9LzluLZn+zqI=
X-Gm-Gg: ASbGncu+/UHE96J3Fd68JtxeMkMjvRHSx/lCfOK/+NHMNp9mDM4t/YQMLMMU7mFhu3S
 QNNYmy/XTbLYQpVX+Qmiw0l4FUgVumCd+3pyceDUJa7qenkSk4tze7Yn2Xo6KONE0s6UJm93+EJ
 On9bfkwa1h0TsNRFUrzM0qpN+gVo9XAX1idbmqc/DkU4OQOTG5mxJ6MNQhzsBRxu0Tkc3TUhN9h
 j4ZQR2fL8zZnx9MZckq0y5eLRJV/fZbC0QjxmzCB9YSBavecrtmR1rJQs0P/FX5wvlDxc94ujyP
 LAZI8RKXrVs=
X-Received: by 2002:a05:600c:4aa9:b0:439:8605:6d7c with SMTP id
 5b1f17b1804b1-439999d46c1mr5377935e9.0.1739897878820; 
 Tue, 18 Feb 2025 08:57:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSM35MSziX5kfi7q6mxl7CFy7+5Sknd25cGQsAeOa1XbDJrRzJ4aad4n9vfdDUd8JR4FSZWA==
X-Received: by 2002:a05:600c:4aa9:b0:439:8605:6d7c with SMTP id
 5b1f17b1804b1-439999d46c1mr5377765e9.0.1739897878397; 
 Tue, 18 Feb 2025 08:57:58 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43994f0c10csm21731075e9.26.2025.02.18.08.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:57:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/7] target/riscv: store max SATP mode as a single integer in
 RISCVCPUConfig
Date: Tue, 18 Feb 2025 17:57:50 +0100
Message-ID: <20250218165757.554178-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The maximum available SATP mode implies all the shorter virtual address sizes.
Simplify the handling of the satp_mode field in RISCVCPUConfig:

- store a single byte in RISCVCPUConfig for the maximum supported size,
  and adjust it to the maximum requested size based on QOM properties

- move satp_mode.{map,init} out of RISCVCPUConfig since they are
  only needed to implement the user-friendly properties for -cpu

The benefit is that code outside target/riscv/ does not need to call
satp_mode_max_from_map() anymore, it can just check cpu->cfg.max_satp_mode.

The first three patches are independent bugfixes.

This series is a spin off of "target/riscv: declarative CPU definitions"
(https://lore.kernel.org/qemu-devel/20250206182711.2420505-1-pbonzini@redhat.com/T/#t).

Paolo

Paolo Bonzini (7):
  hw/riscv: acpi: only create RHCT MMU entry for supported types
  target/riscv: env->misa_mxl is a constant
  target/riscv: assert argument to set_satp_mode_max_supported is valid
  target/riscv: cpu: store max SATP mode as a single integer
  target/riscv: update max_satp_mode based on QOM properties
  target/riscv: remove supported from RISCVSATPMap
  target/riscv: move satp_mode.{map,init} out of CPUConfig

 target/riscv/cpu.h         | 15 +++++-
 target/riscv/cpu_cfg.h     | 17 +------
 hw/riscv/virt-acpi-build.c | 15 +++---
 hw/riscv/virt.c            |  5 +-
 target/riscv/cpu.c         | 98 +++++++++++++++++++++-----------------
 target/riscv/csr.c         |  9 +++-
 target/riscv/machine.c     | 13 +++++
 target/riscv/tcg/tcg-cpu.c |  3 +-
 8 files changed, 100 insertions(+), 75 deletions(-)

-- 
2.48.1


