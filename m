Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A49C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsDZ-0001Hh-Qn; Tue, 25 Feb 2025 05:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmsDY-0001HP-3y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmsDW-0003A5-4T
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740479469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzu/Q+aMlPAsv8TJnCfFKEIcHHvMaDgK1nKnAsY1s4c=;
 b=W6pnyLvMBpsxxxRuZCp4pkUjMM4dTo2nXGf2M1N4Sxk5fG7StYVvayFSPHY43ur+Hrw/HF
 AjWyqPUdJcRWZBFqv8QusvcxmakZRoJ75ARX0DIsdyZlX6bT8ErdULwsBhOg9EGXpsUexW
 aX0drWnhPsDsRqQhYYZsrBSHfX5awbw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-GNpvWRJHOKGMb1F6OloVDw-1; Tue, 25 Feb 2025 05:31:07 -0500
X-MC-Unique: GNpvWRJHOKGMb1F6OloVDw-1
X-Mimecast-MFC-AGG-ID: GNpvWRJHOKGMb1F6OloVDw_1740479466
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f45a86efdso2775525f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 02:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740479464; x=1741084264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzu/Q+aMlPAsv8TJnCfFKEIcHHvMaDgK1nKnAsY1s4c=;
 b=p7MuoXgF6Kr6ecIjJTpOYvpEmWTZCsPdqGen9is0BCCXSwxbJI715JH6Adv0NuIl3j
 WVQBqAuwVq/rO9rYATpv0Z5BQJfSJ+IpfLjkHB7frx5greIXtp2EaI/vg/jwpz/3pb1W
 VI4czwy9cu++uyIL2GvjMA0SFT6ZQnXPy99SP+lAtorRRZ8B57j+l0iURdKHMmuR9nyv
 zGKuzTuBSEQIBeYN083tyOXiZV9Hq8gmTKZvXjhGTYPwBqdxYD+B5T6JuiZll0GiP1zU
 NZ8CMjhc8pauYnDQO0B5ZcHKg5G3iLQxVfwuzFLj3UIziMISEDXoslZRBB0lICSPYt1J
 O8Ag==
X-Gm-Message-State: AOJu0YwQ8vJ8wiamzGobQxLEoVeMs0rXDFTu9Qu366lwVvEVJZ4Z3usg
 kjN7cfFI79R2ylwMQk857ztgy2BOTwFAg6hlb5pcZ3ujNuSvZaF7WR/SO+nCVWkaJQccB4w/buc
 tX7/oNbVxCrsbtBv1NpP2UnLJzqRiMEXHBrmGAfQFWLIPp4F8g0Fc1ZrguQXS1mycgnR2qL44oq
 gVOCLm+yNruNH4hIDUVcpC/wZ3x6VCd02sF8Xk
X-Gm-Gg: ASbGnct71q6GiQd6xxH2cxMwniIFT0hXR860vL/OIN8i5/wYm484v0xnKK4EiW/rnvk
 dVXYej3Bk2Wma0kRJLelpQMpeKNsNRoR10q8VcygSVgSHQUQllPMW08Smp/co+LvViGAHR/OYSd
 xKC3Qr8L1V9GtDg6r3M1/hEvpQYap9iMbyN9MWZrNvOfMARKYfXIJT6OeFvFmtB1DiAUk2FvU8E
 C61UmHApfZUguvdAysxsYvI2qQ3IYOn/U+9XwuSsStoqFVlg1eabSSnX0oDqsbuslWE6d/1fKlD
 ldv6OQQBaaP0BpCkAQM69zjNIm4/DJNayJ8XVd4uYW1o0KQJ1o8GSdpySGIXOJs=
X-Received: by 2002:adf:e7c7:0:b0:38f:309c:2c5f with SMTP id
 ffacd0b85a97d-38f6f085f21mr9450751f8f.34.1740479464273; 
 Tue, 25 Feb 2025 02:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNvG0VdwAO0+26NW/rq5UD9WPtCp8/pCde+BdWfK9+t5VXd4keVRoL4XygJsoRm6uwC0H4eA==
X-Received: by 2002:adf:e7c7:0:b0:38f:309c:2c5f with SMTP id
 ffacd0b85a97d-38f6f085f21mr9450723f8f.34.1740479463825; 
 Tue, 25 Feb 2025 02:31:03 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0367577sm135124645e9.25.2025.02.25.02.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 02:31:03 -0800 (PST)
Date: Tue, 25 Feb 2025 11:31:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 00/10] accel: Only include qdev-realized vCPUs in
 global &cpus_queue
Message-ID: <20250225113102.00769bee@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250207162048.1890669-1-imammedo@redhat.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri,  7 Feb 2025 17:20:38 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> Changelog:
>   * drop wire/unwire hooks patches
>   * drop unrealize related patches
>   * include fixed up patches from
>        [PATCH 0/6] tcg: fix qemu crash when add assert_cpu_is_self() is e=
nabled
>         and cleanups related to cpu->created check
>         https://patchew.org/QEMU/20250129134436.1240740-1-imammedo@redhat=
.com/
>     as it's related to the topic (well, modulo bsd cleanup)
>   * CI mostly green modulo rust failure on Ubuntu
>      https://gitlab.com/imammedo/qemu/-/pipelines/1660855467
>=20
> The goal of this series is to expose vCPUs in a stable state
> to the accelerators, in particular the QDev 'REALIZED' step.
>=20
> To do this we split out cpu_index assignment into a separate step,
> and move call cpu_list_add() to the end of CPU realize stage.
>=20
> I expect these changes to allow CPUState::cpu_index clarifications
> and simplifications, but this will be addressed (and commented) in
> a separate series.
>=20
> As result, the series also
>  * fix regression intoroduced by
>       30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB fl=
ushing")
>    for deatials see 'tcg:tlb: use tcg_debug_assert() in assert_cpu_is_sel=
f()'
>  * drops no longer needed workaround 'cpu->check' due to vCPU being expos=
ed
>    too early in cpus_queue.

Richard,
gentle ping,
can you pick it up is it looks reasonable.
=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <richard.henderson@linaro.org>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> Igor Mammedov (7):
>   bsd-user: drop not longer used target_reset_cpu()
>   loongarch: reset vcpu after it's created
>   m68k: reset vcpu after it's created
>   tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()
>   Revert "tcg/cputlb: remove other-cpu capability from TLB flushing"
>   tcg: drop cpu->created check
>   cpus: expose only realized vCPUs to global &cpus_queue
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>   accel/tcg: Simplify use of &first_cpu in rr_cpu_thread_fn()
>   accel/kvm: Assert vCPU is created when calling kvm_dirty_ring_reap*()
>   accel/kvm: Remove unreachable assertion in kvm_dirty_ring_reap*()
>=20
>  bsd-user/aarch64/target_arch_cpu.h |  5 ---
>  bsd-user/arm/target_arch_cpu.h     |  4 ---
>  bsd-user/i386/target_arch_cpu.h    |  5 ---
>  bsd-user/riscv/target_arch_cpu.h   |  4 ---
>  bsd-user/x86_64/target_arch_cpu.h  |  5 ---
>  include/hw/core/cpu.h              |  6 ++++
>  accel/kvm/kvm-all.c                |  9 ------
>  accel/tcg/cputlb.c                 | 49 +++++++++++++++++++++---------
>  accel/tcg/tcg-accel-ops-rr.c       | 13 +++++---
>  cpu-common.c                       | 23 ++++++++------
>  cpu-target.c                       |  2 +-
>  hw/core/cpu-common.c               |  2 ++
>  target/loongarch/cpu.c             |  2 +-
>  target/m68k/cpu.c                  |  2 +-
>  14 files changed, 68 insertions(+), 63 deletions(-)
>=20


