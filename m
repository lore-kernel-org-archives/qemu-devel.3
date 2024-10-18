Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150CDD3C55F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1h3B-0008BY-Tl; Fri, 18 Oct 2024 03:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1t1h3A-0008BL-TU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:05:28 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1t1h38-0000rs-ST
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:05:28 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4a46d5aa949so532356137.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729235125; x=1729839925; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3EsDn71iKRJbsLqCH6cdyCF8oxK7HkDcTIVHp+N4J44=;
 b=avb7kQmUbUzMUQm/woHsfvNvsVbrIADf0sDXGBmLaIrkKndM2hf50pX+unDY9Dc0XV
 L5LtnBSwBI23gfExScV5YMERLfvjZ4zYZAxrBzx+XHNCcozAjv67RoljekZUcbcfW5lq
 1weYXuFjtDH3/+47uDzfKM63ljfTD/VYgz+sheNsFwnb5tb+sq2Vzb2Pq6WJjA9shCMA
 aKOJHu1EsQMD8DTO6loTmjCtVXTb2D8+RbY2F+dVQYTB0DizJdzzrGBNHCAExyho7PHO
 dBqT4ZqPpTRxhGytXlFE9nqrsYtyzpIpCa2DxxMBtSXuNJqhbr4U93+nbqbC5k7hoFbt
 DCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729235125; x=1729839925;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3EsDn71iKRJbsLqCH6cdyCF8oxK7HkDcTIVHp+N4J44=;
 b=Aqarbh9yXhhxJupWMk5AyUZfQNMyxWh7ee43s8dLwoUfqm/AvHFiovUbSc+cGDFJrC
 6ewW3jJjIsCQDF5HvrCwkRWN1i1W/1OJ/f3TOnJBvlwPGT8NAixLfY3u/Oioq/xBBC0L
 iJb8me14y3on0CrXxDCItXuvLT3mjUJINnkSRITKHhqCjEQNFYYyFQr8mVOUl7Fd3+3P
 PSOi88MQpCQO0manUcirSfcpXSPbDqrqYo20/iylBjD7s5A7ZRZekmQ3pzVSQKCgIEwK
 V7O9STOM/7cRXDbMO9IqP56w584Q8wa/ghf3+ckmygY0GPvAEGWh2fGqvblEPDJBQU10
 GhRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNIFDbfpfZG9vjB536Q1pzoQ6WOGzgUl/obffb8qltomdeaZmJuJaiaQFOyMLpiSSldweh0WeWJD0m@nongnu.org
X-Gm-Message-State: AOJu0YzZ+KgwXuEiHW/Bz8IGDEZCeVEwu7xGpzyL4jyHhzDWBUjOR7GJ
 WPhS3c3BymWYmQdOwAgWaCwAzwM36xSiUCjzHXvejYcGuEt4TwqNtBzQ/Dgsc6YMQtbaOaCJcVX
 QHnz5qX3c96p2Rem0f7esxZE5GAoCWIMKuAdDZQ==
X-Google-Smtp-Source: AGHT+IEMKaiswjTQniXEOdUFmx1XXP3WE2nVkQ6nLj/7XG+PW7CpRN/Fzi2UzGnsKtcggkXYx1K6vFJBvNS/bVGOk1s=
X-Received: by 2002:a05:6102:e0d:b0:493:bcbd:4633 with SMTP id
 ada2fe7eead31-4a5d6a8c469mr1644327137.3.1729235124950; Fri, 18 Oct 2024
 00:05:24 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 Oct 2024 12:35:13 +0530
Message-ID: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
Subject: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>,
 Aishwarya TCV <Aishwarya.TCV@arm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-vs1-xe33.google.com
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

The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
The boot log is incomplete, and no kernel crash was detected.
However, the system did not proceed far enough to reach the login prompt.

Please find the incomplete boot log links below for your reference.
The Qemu version is 9.0.2.
The arm devices TI beaglebone x15 boot pass.

This is always reproducible.
First seen on Linux next-20241017 tag.
  Good: next-20241016
  Bad: next-20241017

qemu-armv7:
  boot:
    * clang-19-lkftconfig
    * gcc-13-lkftconfig
    * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
-------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.12.0-rc3-next-20241017
(tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0,
GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1729156545
[    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: linux,dummy-virt
[    0.000000] random: crng init done
[    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Size (0x04000000) of region at 0x00000000 exceeds
limit (0x00000000)
[    0.000000] cma: Failed to reserve 64 MiB on node -1

<nothing after this>

Boot log link,
-----
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/details/

Build images:
------
 - https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/

Steps to reproduce via qemu:
----------------
/usr/bin/qemu-system-arm -cpu cortex-a15 \
          -machine virt,gic-version=3 \
          -nographic -nic none -m 4G -monitor \
          none -no-reboot -smp 2 \
          -kernel zImage \
          -append \"console=ttyAMA0,115200 rootwait root=/dev/vda
debug verbose console_msg_format=syslog systemd.log_level=warning rw
earlycon\"
          -drive
file=debian_trixie_armhf_rootfs.ext4,if=none,format=raw,id=hd0 \
          -device virtio-blk-device,drive=hd0

Steps to reproduce with tuxrun reproducer:
---------------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/reproducer

Boot history compare link:
------------------------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/history/

metadata:
----
  git describe: next-20241017
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/
  toolchain: clang-19, gcc-13 and clang-nightly
  config: lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

