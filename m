Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E1C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umAPU-00055Y-Pf; Wed, 13 Aug 2025 08:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1umAPT-00055B-MR
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:16:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1umAPP-0005qd-Uy
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:16:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2402b5396cdso41422195ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755087400; x=1755692200; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IbnSBztKB/ky+HfHfoiCEKZibcC+VHhc0U9rmRsC39Q=;
 b=YTXhPcj2mDdr7lHC4dC6GBzXQcBmosWpawr7dC11as4YH6x6YIpM23fB+B70jCFFPj
 bDcaIfqWP+rGHj6o1fUm7EVSh8uG/t8UUEyDOcWT3Z4D1SndBEperee91jIoCKF6SEBK
 SfVatuQOOScR6Uz2/QK0PAM2B8GJq/TmgsLuxDAnUHoI98mkrPvHmT9TB//nHbtbWENY
 vrqU2luAyEeE9JNVWi2HIYQtEzHxwaVGhu533phcL5NBDUfb2CeyNpCjXa3X5ORZpl9Z
 60gBl1j4KLc6jEvnJSZru0Zcltl4jTGCvy6tkZDghXus0weGoScf7vohdfOPI5Bp6Wsu
 kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755087400; x=1755692200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IbnSBztKB/ky+HfHfoiCEKZibcC+VHhc0U9rmRsC39Q=;
 b=OyvvkO46I2gA9G3DmykLMiv56j65PHvyey1Inh+ga3kQCYrJ3LZelNE5PvoyXwEUxt
 +ZEhWE5UDVKhtD077NF7r3kFaAV5Z3q94i5u3vUd+pO2trQf5zWaiG32BasXMelrhmi0
 i4fhqdtYKIXCELsT6jZeSIG0+KIkZWQLGLbctF+KLbY+ROwGl2CGCjT9k6ZBcA8xSkhG
 +klSr2MaBw82eSLBgjK3X9IFNnWCcC/PVFw/UGt/G63VDd6L/VjVWiphbBeC2to808nf
 0V9vMlRK1F/r9rq5obhSGGS474Ndht5dgi9xJHy7jGoWtuVGC5B78XDQGVR0iaTIk6sz
 +AZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWghPFqYs/5qWjuEPJo16VMv/XVbuwgtetyfsYLfsCA9ohUBbO3pn5Yansu5+hNbSMgxi3JLL7vjdY3@nongnu.org
X-Gm-Message-State: AOJu0YzDTM81cWZhp5c0bF3UThqPhhr7T6sCXcDUo6bGsWAVEBp6SnCq
 H3rqh0jE3l58/xEtG/bknOPy7oH/+Sn+Cq4ypobdhdboMUgcNEWvt7LxKNqqezOsuiA4YHXhMFb
 mnMaSmkXXcm/N3b9FqWkTqUYLOAR6RHz6kVWirRuG2O3m2HWJVUOSGUo=
X-Gm-Gg: ASbGncvAO5qJoyaw/cwjSN+OUXMfvNyGDu1TLcvJmbdPQ3iJGtPGaQPcW1MCfdBkf2y
 7t60sGFZRoJDNGlypVRhSfUEIty4e7ikU1jDan0AK0G8Cw+bqj0twFTSQ//e9VCVU57SHIJTNmd
 rDaMIENQ0FQ0p6loTkE2Za24QjR0Oq9h3pk91FKnNeYX21kMDS9fS24CSL3oXfmSa/4kjNcVAqi
 GAybc+ksIk8gatF4ccijIxbmZ/7fDmzPAdjUF9N39L16IZkX5Y=
X-Google-Smtp-Source: AGHT+IEqRlX1hXQvIAC8z4ap56R3F6zBfHl+FK5wqB5WBXqk2utT/Iy+dcR7aD5xv5GmvhMOoS30o/Rmi8/TkNbCz1I=
X-Received: by 2002:a17:902:fc47:b0:242:a0b0:3c28 with SMTP id
 d9443c01a7336-2430d262dd1mr40863255ad.51.1755087400321; Wed, 13 Aug 2025
 05:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 17:46:26 +0530
X-Gm-Features: Ac12FXybqNMQTflDlQz__4h-ypQooKNx0q_GNsw0wCT1xS6QPkD-sG6dIOKmaWc
Message-ID: <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
 broonie@kernel.org, achill@achill.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>, 
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, 
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
 Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>,
 Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-pl1-x630.google.com
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

On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

LKFT found three regressions on stable-rc 6.16.1-rc1.

Short version:
1) Pef build regressions on x86_64 and i386
2) LTP syscalls failures with 64k Page size on qemu-arm64
3) Kernel warning at fs/jbd2/transaction.c start_this_handle x86, qemu-arm64

Long story:
1)
The perf gcc-13 build failed on x86_64 and i386.

Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
fallocate failed.

> Ian Rogers <irogers@google.com>
>     perf topdown: Use attribute to see an event is a topdown metic or slots

Build error:

arch/x86/tests/topdown.c: In function 'event_cb':
arch/x86/tests/topdown.c:53:25: error: implicit declaration of
function 'pr_debug' [-Werror=implicit-function-declaration]
   53 |                         pr_debug("Broken topdown information
for '%s'\n", evsel__name(evsel));
      |                         ^~~~~~~~
cc1: all warnings being treated as errors

2)

The following list of LTP syscalls failure noticed on qemu-arm64 with
stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.

Most failures report ENOSPC (28) or mkswap errors, which may be related
to disk space handling in the 64K page configuration on qemu-arm64.

The issue is reproducible on multiple runs.

* qemu-arm64, ltp-syscalls - 64K page size test failures list,

  - fallocate04
  - fallocate05
  - fdatasync03
  - fsync01
  - fsync04
  - ioctl_fiemap01
  - swapoff01
  - swapoff02
  - swapon01
  - swapon02
  - swapon03
  - sync01
  - sync_file_range02
  - syncfs01

Reproducibility:
 - 64K config above listed test fails
 - 4K config above listed test pass.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
fallocate failed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

swapoff01:
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapoff01.c:44: TINFO: create a swapfile with 65536 block numbers
swapoff01.c:44: TCONF: Insufficient disk space to create swap file

swapoff02:
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapoff02.c:88: TINFO: create a swapfile size of 1 megabytes (MB)

swapon01:
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapon01.c:39: TINFO: create a swapfile size of 128 megabytes (MB)
tst_cmd.c:111: TBROK: 'mkswap' exited with a non-zero code 1 at tst_cmd.c:111

swapon02:
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapon02.c:52: TINFO: create a swapfile size of 1 megabytes (MB)
tst_cmd.c:111: TBROK: 'mkswap' exited with a non-zero code 1 at tst_cmd.c:111

swapon03:
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
tst_cmd.c:111: TBROK: 'mkswap' exited with a non-zero code 1 at tst_cmd.c:111

sync01:
sync01.c:49: TFAIL: Synced 11403264, expected 33554432

syncfs01:
syncfs01.c:53: TFAIL: Synced 4096, expected 33554432

sync_file_range02:
sync_file_range02.c:60: TFAIL: sync_file_range() failed: ENOSPC (28)

fdatasync03:
fdatasync03.c:43: TFAIL: fdatasync(fd) failed: ENOSPC (28)

fsync01:
tst_test.c:1888: TINFO: === Testing on ext4 ===
tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.2 (1-Jan-2025)
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_fsyX4HNML/mntpoint fstyp=ext4 flags=0
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)

fsync04:
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_fsydyQA53/mnt_point fstyp=ext4 flags=0
fsync04.c:43: TFAIL: fsync(fd) failed: ENOSPC (28)

fallocate04:
fallocate04.c:198: TFAIL: fallocate failed: ENOSPC (28)

fallocate05:
tst_fill_fs.c:53: TBROK: fsync(4) failed: ENOSPC (28)

ioctl_fiemap01
tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.2 (1-Jan-2025)
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_iocjRR3ot/mntpoint fstyp=ext4 flags=0
ioctl_fiemap01.c:74: TPASS: ioctl(fd, FS_IOC_FIEMAP, fiemap) : EBADR (53)
ioctl_fiemap01.c:77: TPASS: ioctl(fd, FS_IOC_FIEMAP, fiemap) passed
ioctl_fiemap01.c:79: TPASS: Expect: Empty file should have 0 extends mapped
ioctl_fiemap01.c:86: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: ENOSPC (28)
ioctl_fiemap01.c:41: TFAIL: Expect: extent fm_mapped_extents is 1
ioctl_fiemap01.c:50: TFAIL: (extent->fe_flags & fe_mask) (0) != fe_flags (1)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (4702687395951105107) !=
fe_length (1024)
ioctl_fiemap01.c:96: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: ENOSPC (28)
ioctl_fiemap01.c:41: TFAIL: Expect: extent fm_mapped_extents is 3
ioctl_fiemap01.c:50: TPASS: (extent->fe_flags & fe_mask) == fe_flags (0)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (4702687395951105107) !=
fe_length (1024)
ioctl_fiemap01.c:50: TPASS: (extent->fe_flags & fe_mask) == fe_flags (0)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (5136714152143953955) !=
fe_length (1024)
ioctl_fiemap01.c:50: TFAIL: (extent->fe_flags & fe_mask) (0) != fe_flags (1)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (8387236464277024288) !=
fe_length (1024)


Links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470711/suite/ltp-syscalls/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470720/suite/ltp-syscalls/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470711/suite/ltp-syscalls/test/sync01/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470720/suite/ltp-syscalls/test/fdatasync03/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470711/suite/ltp-syscalls/test/swapon01/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29471488/suite/ltp-syscalls/tests/


3)

Test regression: stable-rc 6.16.1-rc1 WARNING fs jbd2 transaction.c
start_this_handle

Kernel warning noticed on this stable-rc 6.16.1-rc1 this regression was
reported last month on the Linux next,

- https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

Kernel warnings:

------------[ cut here ]------------
[   34.805150] WARNING: CPU: 1 PID: 627 at fs/jbd2/transaction.c:334
start_this_handle (fs/jbd2/transaction.c:334 (discriminator 1))
[   34.807683] Modules linked in: btrfs blake2b_generic xor xor_neon
raid6_pq zstd_compress sm3_ce sha3_ce sha512_ce fuse drm backlight
ip_tables x_tables
[   34.809152] CPU: 1 UID: 0 PID: 627 Comm: io_control01 Not tainted
6.16.1-rc1 #1 PREEMPT
[   34.809652] Hardware name: linux,dummy-virt (DT)
[   34.809961] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   34.810205] pc : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
[   34.810395] lr : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
[   34.810798] sp : ffff800080e2f7e0
[   34.810962] x29: ffff800080e2f820 x28: fff00000c4b43000 x27: ffffa9c145dca000
[   34.811259] x26: 0000000000000658 x25: 0000000000000629 x24: 0000000000000002
[   34.811507] x23: 0000000000000629 x22: 0000000000000c40 x21: 0000000000000008
[   34.811750] x20: fff00000d0800348 x19: fff00000d0800348 x18: 0000000000000000
[   34.811992] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   34.812234] x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000000000
[   34.812858] x11: 0000000000000000 x10: ffffa9c1456a8c08 x9 : ffffa9c142b54b84
[   34.813572] x8 : ffff800080e2f408 x7 : 0000000000000000 x6 : 0000000000000001
[   34.814462] x5 : ffffa9c145629000 x4 : ffffa9c1456293d0 x3 : 0000000000000000
[   34.815093] x2 : 0000000000000000 x1 : fff00000c4fd0000 x0 : 0000000000000050
[   34.815812] Call trace:
[   34.816213] start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1)) (P)
[   34.816719] jbd2__journal_start (fs/jbd2/transaction.c:501)
[   34.817124] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
[   34.817687] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242 fs/ext4/inode.c:2847)
[   34.818109] ext4_writepages (fs/ext4/inode.c:2954)
[   34.818549] do_writepages (mm/page-writeback.c:2636)
[   34.818983] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:376)
[   34.819520] __filemap_fdatawrite_range (mm/filemap.c:420)
[   34.819942] file_write_and_wait_range (mm/filemap.c:794)
[   34.820349] ext4_sync_file (fs/ext4/fsync.c:154)
[   34.820486] vfs_fsync_range (fs/sync.c:188)
[   34.820624] do_fsync (fs/sync.c:201 fs/sync.c:212)
[   34.820743] __arm64_sys_fsync (fs/sync.c:215)
[   34.820882] invoke_syscall.constprop.0
(arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
[   34.821046] do_el0_svc (include/linux/thread_info.h:135
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
arch/arm64/kernel/syscall.c:151 (discriminator 2))
[   34.821172] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:768 (discriminator 1))
[   34.821307] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:787)
[   34.821460] el0t_64_sync (arch/arm64/kernel/entry.S:600)
[   34.821712] ---[ end trace 0000000000000000 ]---

Link:
 -  https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.16.y/v6.16-628-gcd8771110407/log-parser-test/exception-warning-cpu-pid-at-fsjbd2transaction-start_this_handle/

--
Linaro LKFT
https://lkft.linaro.org

