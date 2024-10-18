Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE31D2F7ED
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jBa-0005TB-Oa; Fri, 18 Oct 2024 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cmarinas@kernel.org>)
 id 1t1jBY-0005Sk-TZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:22:16 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cmarinas@kernel.org>)
 id 1t1jBW-0007Ym-Ty
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:22:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 669135C58A4;
 Fri, 18 Oct 2024 09:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5DC4CEC3;
 Fri, 18 Oct 2024 09:22:00 +0000 (UTC)
Date: Fri, 18 Oct 2024 10:21:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 qemu-devel@nongnu.org, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 Mark Brown <broonie@kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
Message-ID: <ZxIotWFxJf8H9bYX@arm.com>
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=cmarinas@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On Fri, Oct 18, 2024 at 12:56:01PM +0530, Naresh Kamboju wrote:
> The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
> 
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm64 devices boot pass.
> 
> This is always reproducible.
> First seen on Linux next-20241017 tag.
>   Good: next-20241016
>   Bad: next-20241017
> 
> qemu-arm64-protected:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Boot log:
> ---------
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> [    0.000000] Linux version 6.12.0-rc3-next-20241017
> (tuxmake@tuxmake) (Debian clang version 19.1.2
> (++20241001023520+d5498c39fe6a-1~exp1~20241001143639.51), Debian LLD
> 19.1.2) #1 SMP PREEMPT @1729156545
> [    0.000000] KASLR enabled
> [    0.000000] random: crng init done
> [    0.000000] Machine model: linux,dummy-virt
> [    0.000000] efi: UEFI not found.
> [    0.000000] Capping linear region to 51 bits for KVM in nVHE mode
> on LVA capable hardware.
> ...
> [    0.000000] Kernel command line: console=ttyAMA0,115200 rootwait
> root=/dev/vda debug verbose console_msg_format=syslog
> systemd.log_level=warning rw kvm-arm.mode=protected earlycon
> ...
> <6>[    0.305549] SME: maximum available vector length 256 bytes per vector
> <6>[    0.306214] SME: default vector length 32 bytes per vector
> **
> ERROR:target/arm/internals.h:923:regime_is_user: code should not be reached
> Bail out! ERROR:target/arm/internals.h:923:regime_is_user: code should
> not be reached
> <nothing after this>

Qemu bug. See this email from Peter:

https://lore.kernel.org/r/CAFEAcA8uJL1t2MDjaJL7u5oW4ns23_E+sk7987x4gAcs3dSZOw@mail.gmail.com

-- 
Catalin

