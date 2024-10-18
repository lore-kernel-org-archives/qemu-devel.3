Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F548D3C559
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1hNL-00035J-OB; Fri, 18 Oct 2024 03:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1t1hNK-00035A-9p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:26:18 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1t1hNG-0003Fj-RC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:26:16 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-84fc0209e87so615062241.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729236373; x=1729841173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=piiFALoQ7z5HAKzAwidaLMXt4WFJputVxFgFqSQ8Dsw=;
 b=xHn2RiuDyMr3quEbNWC6ogFUHcXnMdQgJFztR7qx5BIcN0VzJdUnpiwD5H3fLOnBao
 sSBbTRWS0JPpUxoH8BG+x2L7z8AvgG8476ZB2hJ2mbW3fwuZ0PbeJGStCe4fIEtGdQJL
 wvmaFz0g6kZC2f03skkaPVYO7DdcuM4D51yx6lvFX4IdWQgavv1Etl9JN/Svl9rBBgiG
 /KlUJ7BKm20MzhFmQmgJnvG5I/6xNNp1eHF99owJ4+n+roeOeYqH35d95g5+WW6e2mWz
 yEuQ9ydJPKGspLX9rZSdQGO24dnVeAjW4duCh1ihN+PdRzLSKkkRIom1udAWMPxKS3qp
 cgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729236373; x=1729841173;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=piiFALoQ7z5HAKzAwidaLMXt4WFJputVxFgFqSQ8Dsw=;
 b=L3oqvOFFLigCpr2hLIp5ga7TP1gx79yA4EemS6YvCeMjSusWaszzdPE/ozRYdHSMH/
 sR5jc4eauIql7LwGACXiXzrIXbFbAymfFHF30zuJgx15briZ2KqKd9K3vorDoiNAvNmW
 sAR1cxyvQ5NAk9O/ZIt7ZXgwp/4kTG9GPbCIsVYMI3mj7/8RTrwNtDXUXIAudxFGlALU
 PFSFpgIZV8CmD6jmzLEV+hSTDO+p4Si8i5qnkSx2lL2EiwrwpW8D7QiX+cZnh1aRu6fV
 GvncIgKG8EJSN2SrXUiC0++jYJZDez46ZZQlTcY6qyQ9+apZo1roIkzO0Roo5HRH9V3D
 vM/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbp5cf8YxcXw6ijTkyc86HIHSrJmnxSDdp7l7sCIV9BdihDkDkv+1mrJ0ZPMIyDOsH9lY1nLu4LZlt@nongnu.org
X-Gm-Message-State: AOJu0Yy6XAhpsVSnHds/WtGXL26h40KgSRyrjShc+0UlFv3bC74eeYrW
 fRs3SID0I9WgUehSbNVHEZqNQgB4vBwyb1vuZ/Ao7htGgu/EEMdR/PRD1+gKvddgSkcdLP+FBPC
 TYNf3ShTPS0SG00EEXsKNBJpLkJlvh11jN8YRig==
X-Google-Smtp-Source: AGHT+IEDuknEZ7zRw7JqileQVNCYUrrUoiK9et5lckka/21EGUZiz4WBPeJonXMswilj/CNUKIzQ6VeF2HZtz3KX07Y=
X-Received: by 2002:a05:6102:956:b0:4a4:97d1:aea0 with SMTP id
 ada2fe7eead31-4a5d6a92561mr1705997137.11.1729236372962; Fri, 18 Oct 2024
 00:26:12 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 Oct 2024 12:56:01 +0530
Message-ID: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
Subject: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
To: open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, qemu-devel@nongnu.org, 
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-ua1-x92c.google.com
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

The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
The boot log is incomplete, and no kernel crash was detected.
However, the system did not proceed far enough to reach the login prompt.

Please find the incomplete boot log links below for your reference.
The Qemu version is 9.0.2.
The arm64 devices boot pass.

This is always reproducible.
First seen on Linux next-20241017 tag.
  Good: next-20241016
  Bad: next-20241017

qemu-arm64-protected:
  boot:
    * clang-19-lkftconfig
    * gcc-13-lkftconfig
    * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
---------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.12.0-rc3-next-20241017
(tuxmake@tuxmake) (Debian clang version 19.1.2
(++20241001023520+d5498c39fe6a-1~exp1~20241001143639.51), Debian LLD
19.1.2) #1 SMP PREEMPT @1729156545
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: UEFI not found.
[    0.000000] Capping linear region to 51 bits for KVM in nVHE mode
on LVA capable hardware.
...
[    0.000000] Kernel command line: console=ttyAMA0,115200 rootwait
root=/dev/vda debug verbose console_msg_format=syslog
systemd.log_level=warning rw kvm-arm.mode=protected earlycon
...
<6>[    0.305549] SME: maximum available vector length 256 bytes per vector
<6>[    0.306214] SME: default vector length 32 bytes per vector
**
ERROR:target/arm/internals.h:923:regime_is_user: code should not be reached
Bail out! ERROR:target/arm/internals.h:923:regime_is_user: code should
not be reached
<nothing after this>


Boot failed log links,
-------------
 dmesg log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25475692/suite/boot/test/clang-19-lkftconfig/log
 test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25475692/suite/boot/test/clang-19-lkftconfig/details/

Build image:
-----------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nYi294C2rkwmj8hWZ0XnFcTd7F/

Steps to reproduce:
------------
   /usr/bin/qemu-system-aarch64 -cpu max,pauth-impdef=on \
   -machine virt,virtualization=on,gic-version=3,mte=on \
   -nographic -nic none -m 4G -monitor none -no-reboot -smp 2 \
   -kernel Image -append \"console=ttyAMA0,115200 rootwait
root=/dev/vda debug verbose console_msg_format=syslog
systemd.log_level=warning rw kvm-arm.mode=protected earlycon\" \
   -drive file=arm64_rootfs.ext4,if=none,format=raw,id=hd0 -device
virtio-blk-device,drive=hd0

metadata:
----
  git describe: next-20241017
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nYi294C2rkwmj8hWZ0XnFcTd7F/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nYi294C2rkwmj8hWZ0XnFcTd7F/
  toolchain: clang-19, gcc-13 and clang-nightly
  config: defconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

