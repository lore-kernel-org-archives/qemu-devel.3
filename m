Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB555CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUPji-0003a2-Ah; Tue, 02 Jun 2026 10:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wUPjh-0003Zu-Ix
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:04:53 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wUPjf-0002HE-Uj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:04:53 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-6c5ac3fa819so1143574137.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1780409090; x=1781013890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ujK4eFBt2CiUF6UNRnobhV7dIbSUH85qOD9fCMSIzOE=;
 b=OYlxLd2XEvk8ouV+DDpOXxCfp3rlvzOKamQiyfEXGIbJHNfACTqt3WfL/JZeQKTK7r
 knly8SPX320ld6BhYZUb0nak7oIYllLLT8/fDKT8b1b2HeyF9XoWZdbKoXfQ72K4APnc
 V/42aZLRrTo4BMSCI2GLNEjVNgoC0YY4RxgXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780409090; x=1781013890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujK4eFBt2CiUF6UNRnobhV7dIbSUH85qOD9fCMSIzOE=;
 b=ocusUh5IVHwnMmKqE0QSpzPPIy4d673aqCcVX+dZv84VKQ/i37PyQ5SEwbH2N9sQ+4
 z1mHWaBj2343ldOEyOeLsuCMFwGv1LIMbhMDmHjnkuel5fCa/5peb3my0c86oNf5eBow
 aU5+KBi7FssEpj/W6e9au4Z+T8DZSKdb2B7vqlUnJI4ouVDwsF5JldW9TrG58SxJEn5q
 j3Xb80NfrkN9FzOb187WCM2UOR3hHe0nusXeyfq+sFrdP6GibQX8M8l9SeM2H8/4r7AA
 RaVoe7paVkYnAyGHG5xZZUJ7S9+Z3lK2mxUknpwRA4mO55CwupsnQAlaE53cjEoKxLrV
 e8OA==
X-Gm-Message-State: AOJu0Yz6QJhhFg8GmzynMyBATs0FFLztFk4+Cz61X2iR3066kdeaSsEE
 EXNXSaLYpGxWrDy7uKUm5IAQycLK6RsYPteJs52dU1WXBNuyFvCBuf5B9+qeYd2rWvEvBdl0BOi
 Kcv+iCHg=
X-Gm-Gg: Acq92OE6Pck2Xv6XZnrgMc8J17Rb95WRDW7syfVwI47UA6VmJzmGFMhnP9ngbbaUXv8
 DuxloKuuuE6GifLTK9JTtcceFash11Nt5JGuYU8B6v88HFECKvu6dJfGm5HuMqpeB8xo8aJ8k8W
 5IoaG9cMprv0ney3/tzejyQkYmiHZQuY4JgD961pJ+pbwILeKz8ADomY+d+5FTAoZCX1/99DTVk
 8dFXVRXUxgh/2lcPsBfSHy7Gxb1Ko0DYblY+WRFeU0ELHThllFaJYafxDy/OWvMDRtgwDCbpH8M
 kcbICVgAUTdO0rIZf+veM7VehIYZ3ZV7f5uk+3xuOlyRo7aiMrtHEC3Tdv2NiDqhFRSOt8QkwzM
 jxUiB6F3xX+kI8/RA7ff6MlG89W0Y219D92Q9xdiuW0n5upbEGQwVvCH968wA8i4nUoTFRfROlE
 1tzQ+nwibDoHFfEzt2Z8rjsAo7c8vGSCq8aTPdYg==
X-Received: by 2002:a05:6102:61d1:b0:634:420a:ab1b with SMTP id
 ada2fe7eead31-6c69b82c136mr3593702137.18.1780409090446; 
 Tue, 02 Jun 2026 07:04:50 -0700 (PDT)
Received: from tarski ([179.105.152.38]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6d1ff3909b3sm6097602137.6.2026.06.02.07.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 07:04:50 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 zhao1.liu@intel.com, mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH v2 0/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
Date: Tue,  2 Jun 2026 11:03:46 -0300
Message-ID: <20260602140348.774203-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=anderson@allelesecurity.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

I have implemented support for exposing and enabling APERF/MPERF
MSR passthrough for x86 QEMU guests when running on KVM.

As of last year, the Linux kernel supports providing a capability
to disable APERF/MPERF read intercepts [1]. However, there is
currently no native way in QEMU to instruct KVM to activate this
capability or expose the feature bit cleanly via CPUID.

My patch introduces the `aperfmperf` feature flag via `FEAT_6_ECX`
(CPUID.06H:ECX[bit 0]). It ties into the existing power management
framework, so when a user enables power management via
`-overcommit cpu-pm=on` and passes `+aperfmperf` to the CPU, QEMU
requests KVM to drop the MSR intercepts.

For testing, I passed the feature via Libvirt XML like so:

    <qemu:arg value="-overcommit"/>
    <qemu:arg value="cpu-pm=on"/>
    <qemu:arg value="-cpu"/>
    <qemu:arg value="host,+aperfmperf,+invtsc"/>

A FreeBSD 16 guest is successfully able to read the changing
values of the MSRs directly without exiting to the hypervisor:

root@freebsd16development:/home/user # cpucontrol -i 6 /dev/cpuctl0
cpuid level 0x6: 0x00000004 0x00000000 0x00000001 0x00000000
root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
MSR 0xe7: 0x00007fdf 0x22480f90
root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
MSR 0xe7: 0x00007fdf 0x2b8b48b0
root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
MSR 0xe8: 0x000050de 0x49270831
root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
MSR 0xe8: 0x000050de 0x4ad66ae6
root@freebsd16development:/home/user #

Based-on: QEMU v11.0.50 (commit 5611a9268d)

v1 -> v2 changelog:
  - Add migration flags

Anderson Nascimento (1):
  target/i386: Add support for KVM APERF/MPERF passthrough

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.54.0


