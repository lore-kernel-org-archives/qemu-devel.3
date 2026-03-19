Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFEA1088E65
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335s-0003i7-MM; Wed, 18 Mar 2026 22:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335o-0003hc-Sb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:37 -0400
Received: from mail-yx1-xb144.google.com ([2607:f8b0:4864:20::b144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335g-0002qB-Ix
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:30 -0400
Received: by mail-yx1-xb144.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso128878d50.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887187; x=1774491987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+xmqgAoXpPj1mii3lAZ3rHspNN4EUTiaFvnVJgN6ZU4=;
 b=WmfsHHoNtS0vSB67N2SjYzWwDbzXPZ0YvZ2iRdRJC2cMS/5lRtoj6EQoTpp5Tyt20Y
 0elvjTGPoPbVlCqlRa24toPvAUG2F/RjFsjN86ABo9WJMfCeujGgJSPRRKU2G4CrBD2J
 7ZP44okDBzHFy7JTezAegv321fXqPiYA6STGuCP5/zvE+CGqm6se6kGbHWuVBs1vAb6g
 r6OcpmxotYWn2WxZugyi9S+T+DWOcgDO3n4P0jYyo6Ty+WEAftZ0m4JhAw73XbXogzM9
 dxIf23Kdf7UYSZuMx0y1EWiLJQ5XvyJ2SIyB1yhk5JlXP2humZq+Bgb7krG4Vb7k7tgK
 mUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887187; x=1774491987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xmqgAoXpPj1mii3lAZ3rHspNN4EUTiaFvnVJgN6ZU4=;
 b=cqPSoeWbOWru49LXYsJ+3saLanetlN74Gq9zO6PFTDMb/XpNLdzqlfodj1vT1maLcF
 H6JmXUotmN2O7ORn4xSK7qh9UMdxa1SUa0YYYwQUvkd97L0fDtUMbdJcDMtFXxx8fabB
 pl0/5BUtKC8C/wIYkGHsOvdcQtCTNI1iEIEaaHqs8wCQ4wbi/JJUKoZjUDYPbQQW2wfB
 SrfvBO7zOxCgi/nOWQZ3hecGMeoYnRYlfrtIU+bqXesChOQsUo0Xb0tjP/7bUIlN+NrT
 T5HQ9eWkcgthmgQnqu4MO7BBY8/xsPyk9fShbsdnNqGKl0C/UsH1iNmkfv78kqo8tR/g
 Iflw==
X-Gm-Message-State: AOJu0YwVWboLpVVb8vndrQhzJ0w2ECygT7P3yrS3eEhjoSuQF0Z2CMjp
 Y3qO4fHxElILHCgz3M6A4ImCmi/yq+W+kG2l9OszjoM0I/VaZkXcthyNqoMOmJJATvxZwlsVy+e
 1BSrrY/o4Rw==
X-Gm-Gg: ATEYQzwnHr6dqO3QdCOq+EksX5Uf8BJklLo3cebjvg2YJQx9VqwQR1XfZXWflQHqWnx
 wh+BbGsZL0qeaEIKoKispamlf+hho43sPftCcUn+0duDZdshC0dmtqXezMgaTPXPCFPNjFUtYOE
 4RjFADrBIDKtO1NDjS7Hn8UeAl8Tg62NPzKZkQaOllD8LcfyBenDcX41bGNHkMe32tc2w4lV8iw
 aA+oNQ6svvEhqsV2Ipo3psnXxpMLo2mgnSQUiGLRLgaax11RfKE7ZqwSA13geBdZp1ShrxSxnl2
 r0ctjbimMP1MYIPROFp56Lc32Hw+DtNLS414+pzWo7ffVM/jnPmSvWXVBIW2VzgWpGWZUJ0pMW5
 MQWNDf+/SuPWWXo9jwakevBSr8O7KoNQTluJebVKLCBgJeHdHbJigEwc8HnQNauqSwKVM+tGq37
 0y7ro+d+huc0T/Pd+9V1MfEhE61heAhg==
X-Received: by 2002:a05:690c:3346:b0:79a:668a:b6e8 with SMTP id
 00721157ae682-79a71cb2314mr55988177b3.61.1773887186487; 
 Wed, 18 Mar 2026 19:26:26 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:26 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 0/7] Add FEAT_MEC (encryption)
Date: Wed, 18 Mar 2026 23:23:28 -0300
Message-Id: <20260319022335.22523-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b144;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yx1-xb144.google.com
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

This series implements the proper use of FEAT_MEC MECID registers in
QEMU for all translation regimes. In physical hardware, MECID registers
are used to select an encryption engine that transparently encrypts
memory data per Realm (as FEAT_MEC is an extension of FEAT_RME).

The main idea of this series is to avoid actual data encryption.
Instead, we store the MECID associated with each page during guest data
store operations. On subsequent memory accesses, we verify whether the
MECID in the register matches the stored MECID.

If a MECID mismatch occurs, rather than returning encrypted data as on
physical hardware, a substitute page filled with 0xdeadbeef is returned
to mimic the hardware's behavior.

I tested this series by booting Linux on up to three VMs simultaneously
and verified that the MECIDs for each were set correctly.

There is one remaining issue tho: when a VM is destroyed and another is
launched in sequence, a MECID mismatch occurs, leading to an
"Unexpected exception on CPU" in the host. Since the software stack is
still under development, I cannot yet exclude this is not a firmware or
KVM-related issue. Regardless, this needs to be addressed; however,
before I dig further, I would appreciate feedback on the implementation
proposed in this series.

For testing this series you can:

Get the stack to test FEAT_MEC either:
Download the artifacts (tf-a + tf-rmm + linux/kvm + kvmtool) from:
https://github.com/gromero/qemu-linux-stack/actions/runs/23274571242/artifacts/5998250548

Then unzip and untar in QEMU's build dir:
$ unzip ./build.zip
$ tar xvf build.tar.xz

Or build them from scratch:
$ git clone https://github.com/gromero/qemu-linux-stack.git --branch rme_mec --single-branch --depth 1
$ cd qemu-linux-stack && ./build.sh
Files will be in ./out and should be copied to QEMU's build dir:
4.1M	out/flash.bin
167M	out/guest.ext4
167M	out/host.ext4
38M	out/Image
3.1M	out/lkvm

Build QEMU with this series applied

Run QEMU system with FEAT_MEC enabled (mec=on) from the build dir:
./qemu-system-aarch64 -display none -vga none -chardev stdio,id=console -serial chardev:console -machine virt -cpu max,x-rme=on -smp 2 -m 2G -M virt,acpi=off,virtualization=on,secure=on,gic-version=3,mec=on -bios ./out/flash.bin -kernel ./out/Image -drive format=raw,file=./out/host.ext4,if=virtio -virtfs local,path=./,mount_tag=host,security_model=mapped,readonly=off -append 'nokaslr root=/dev/vda rw init=/init -- /bin/bash'

Once in Linux, do (for 2 VMs, for example):

# apt-get install tmux 
# tmux
Use [CTRL-b] " [SPACE] to split the terminal horizontally
Use [CTRL-b] UP/DOWN to move between the two windows
In one window run:
# /host/out/lkvm run --realm -m 256m --shared-mec 0 --restricted_mem --kernel /host/out/Image --disk /host/out/guest.ext4 --params "root=/dev/vda rw init=/init"
Then [CTRL-B] UP to move to the other window
Then boot another VM:
# /host/out/lkvm run --realm -m 256m --shared-mec 0 --restricted_mem --kernel /host/out/Image --disk /host/out/guest.ext4 --params "root=/dev/vda rw init=/init"
Wait for the VMs to boot

I added a patch to the series, 
"Print MECID if not zero [TO BE DISCARDED]", that can be used for
printing the MECIDs used by the VMs. It will print a bunch of messages
like: 

MECID (in register) stored for va = fffffffffffa7000 pa = 630d5000 is 3 [...]

where one can observe different MECIDs being used the VMs, like 3 and 4.
Just mind that the prints can slow down QEMU and cause CPU stalls on
Linux.


Cheers,
Gustavo

Gustavo Romero (7):
  target/arm: Flush TLB on MECID write
  target/cpu: Add two new address spaces for FEAT_MEC
  memattrs: Add new attribute 'encrypted'
  target/arm/cpu: Add FEAT_MEC object properties
  hw/arm/virt: Add machine option 'mec'
  target/arm/ptw: Add MECID checks
  target/arm/ptw: Print MECID if not zero [TO BE DISCARDED]

 hw/arm/virt.c           |  76 ++++++++++++++
 include/exec/memattrs.h |   7 ++
 include/hw/arm/virt.h   |   1 +
 target/arm/cpu.c        |  20 ++++
 target/arm/cpu.h        |  14 ++-
 target/arm/helper.c     |   2 +
 target/arm/internals.h  |   2 +
 target/arm/ptw.c        | 218 +++++++++++++++++++++++++++++++++++++++-
 8 files changed, 337 insertions(+), 3 deletions(-)

-- 
2.34.1


