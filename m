Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC96EC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 04:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u20cp-0006Pw-Ba; Tue, 08 Apr 2025 00:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20co-0006Pl-5E
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:31:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20cl-0005bF-MD
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:31:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224100e9a5cso52968835ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744086705; x=1744691505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZxXm0QlquWnAAgfSfApIkjwAwaOBmaCNIExwOgtGj8=;
 b=KJZxzRXfv4iv6rEC1h5WD9B8Fc4gwDSycNtqmT5LL1xLGHGmgU06Pn6K+l/5DA7P9I
 O2FO7a530vqmI63SFLE5mlLcghxO/zHYDFIEYY+uuX3XkmE/IbGLgkb149jouwnXtKRG
 PcVBuutE/XyqC3YNKeyfo45ImGNUi+HVNKI3179jm1kjzKDR7e1X/6kyfOwr9UOvxYtA
 p9KYTedOQl71WlcE2sxBXpxzbruakiGXUeKuZ8bDsf7gDRjuOfo/4AwLxGjCTI7Dhzsm
 tyJGH4OXo61ug4qIG5bgZ4ezEyL1AzK0k9gn+5jaG39UzQY+TkMhAphonI6+Xij0cYrF
 oH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744086705; x=1744691505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZxXm0QlquWnAAgfSfApIkjwAwaOBmaCNIExwOgtGj8=;
 b=CS2D6tPSZrp398CRKSsss9LRVVoaI6eJVtDnTxhGh22ATf/l/xBnE6jQ68Q4TqBNCG
 FRUH0OYvnPzaJO/R2SoZ1YrrIQFl83fy1bBVQMKh488jqUueg2jnYmGQYAh5zXkilsdM
 qAK0sX2SpVrO4ktG9xi0CwXQjaZewZ7JWxRLS6kCFduzg79BRwsX04ocNHtvMh/8xbE+
 ojuGpLFMJ6MWeGSONO8vCPFlW3nuDQepDqx4sW3rZuBFodlMbw3btPJzb4kOrf1beCsP
 1B1sChsxK/aRDni/f/p20bZ5OOZn8XB339nTMV8Bf+EFsPxIs2LbBT82BnSzb0WzUfCK
 PnGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOxoevNW8Sqf0pmcyKHlySyf2cqgz2Yoq3/7Xd3B9WFUvVn/L3kTMq4vqlEMejEx3lKzcg+LfrPZT7@nongnu.org
X-Gm-Message-State: AOJu0YyIGG+tGxIDO2oINwgSx4qGj+QDyXyzzA5Cnwf6WA34rCKKrVqJ
 dMbpBn61kMfhBKC5jnQ54wx+HCscZTAuB51+y9aeOYXE+TUADfsV
X-Gm-Gg: ASbGncvkyrKdgKerv9rQ3TXuQ95koFWw0hGWck0WIZGWVkifNALDEXCjOwvXN88Rr2d
 jy4QIF5txzdTs+rfQDQ4+wEEp/UGj6+InsrcZh1OqVqYddLdijbkHij0rSMj0+7H/h5nd8rfZzA
 sMWlyFdPSqVoK7dTO3XiBaXY6r51Utxw10jWahat6q2Ow3W0w98KtL8csO7MCFi1H4LQ+TMpncz
 f3f0DlhdTF3WbN1cBxolwcu7FU7D57cPFvLXnWH/TYX5SrmdssWz8pkx+Y45U0hSsUizRvBbtzv
 ptasCmlXFx87EGhJ62FVuoifvi45wacaH6qd9SNywqdKa03ftcMk8AAS9lh+ug==
X-Google-Smtp-Source: AGHT+IFt6JXfyKu4EDJ++NOKplq8oWv97jONa67euAsJVjmGafxLTnJy8vMDTU8T40tTduhlBACCag==
X-Received: by 2002:a17:902:ce02:b0:224:160d:3f54 with SMTP id
 d9443c01a7336-22a8a87949cmr203740445ad.31.1744086705155; 
 Mon, 07 Apr 2025 21:31:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 21:31:44 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan.cxl@gmail.com, anisa.su887@gmail.com,
 gourry@gourry.net, Fan Ni <fan.ni@samsung.com>
Subject: [RFC 0/3] Qemu FM emulation
Date: Mon,  7 Apr 2025 21:20:27 -0700
Message-ID: <20250408043051.430340-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

The RFC provides a way for FM emulation in Qemu. The goal is to provide
a context where we can have more FM emulation discussions and share solutions
for a reasonable FM implementation in Qemu.

The basic idea is,

We have two VMs, one is the VM we want to test (named Target VM) and one is the
FM VM. The target VM has the kernel which we are interested (for example, DCD
or RAS feature enabled). The FM VM can be VM with any kernel version as long as
OOB communication support is enabled.

An application running in the FM VM issues FM commands to the underlying device
with OOB channel (e.g., MCTP over I2C), when the device receives the message,
it will not response to the request locally, instead the request will be stored
in a share buffer (implemented with /dev/shm), and a QMP request will be sent
to the target VM to notify there is a MCTP message in the shared buffer,
which needs to be processed. The FM will wait the completion of the request.
The target VM will read the buffer and process the message.
When the process completes, the output payload and any information needs to
return is stored in buffer, and a state field will be reset to notify the FM of
the completion of the processing.

The nice points of the method:
1. It is simple model (consumer-produce model with shm as shared buffer).
2. The communication between the two VMs through the qmp interface is simple.
One qmp interface works for all MCTP messages. Moreover, the qmp interface may
be able to use as a way for the communication between two VMs in different
context.

How we run the test?
Step 1: Start the VM we want to Target VM.
The device interested having "allow-fm-attach=on,mctp-buf-init=on"
For example, for my test, it is the DCD device.

In our test, the kernel run on the target VM is Ira's DCD branch:
https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.

qemu-system-x86_64 -gdb tcp::1235  -kernel bzImage -append "root=/dev/sda rw console=ttyS0,115200 ignore_loglevel nokaslr" \
-smp 8 -accel kvm -serial mon:stdio  -nographic  -qmp tcp:localhost:4445,server,wait=off \
-netdev user,id=network0,hostfwd=tcp::2024-:22    \
-device e1000,netdev=network0  -monitor telnet:127.0.0.1:12346,server,nowait \
-drive file=/home/fan/cxl/images/qemu-image.img,index=0,media=disk,format=raw \
-machine q35,cxl=on -cpu qemu64,mce=on -m 8G,maxmem=64G,slots=8 \
-virtfs local,path=/opt/lib/modules,mount_tag=modshare,security_model=mapped  \
-virtfs local,path=/home/fan,mount_tag=homeshare,security_model=mapped \
-object memory-backend-file,id=cxl-mem2,mem-path=/tmp/host0/t3_cxl2.raw,size=4G \
-object memory-backend-file,id=cxl-lsa2,mem-path=/tmp/host0/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
-device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
-device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
-device cxl-type3,bus=swport2,volatile-dc-memdev=cxl-mem2,id=cxl-dcd0,lsa=cxl-lsa2,num-dc-regions=2,sn=99,allow-fm-attach=on,mctp-buf-init=on \
-machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-dcd0 \
-device virtio-rng-pci,bus=swport1

Step 2: Start the FM VM and run the test program to send MCTP requests and
forward to the target VM for processing.

Note: the kernel for FM VM should have MCTP support.

In the test, we use linux-v6.6-rc6 with Jonathan's MCTP hack patches:
https://github.com/moking/cxl-test-tool/blob/main/test-workflows/mctp/mctp-patches-kernel.patch

qemu-system-x86_64 -gdb tcp::1236 -kernel fm-bzImage -append "root=/dev/sda rw console=ttyS0,115200 ignore_loglevel nokaslr " \
-smp 8 -accel kvm -serial mon:stdio  -nographic  -qmp tcp:localhost:4446,server,wait=off \
-netdev user,id=network0,hostfwd=tcp::2025-:22    \
-device e1000,netdev=network0  -monitor telnet:127.0.0.1:12347,server,nowait \
-drive file=/home/fan/cxl/images/qemu-image-fm.img,index=0,media=disk,format=raw \
-machine q35,cxl=on -cpu qemu64,mce=on -m 8G,maxmem=64G,slots=8  \
-virtfs local,path=/opt/lib/modules,mount_tag=modshare,security_model=mapped  \
-virtfs local,path=/home/fan,mount_tag=homeshare,security_model=mapped \
-object memory-backend-file,id=cxl-mem2,mem-path=/tmp/host1/t3_cxl2.raw,size=4G \
-object memory-backend-file,id=cxl-lsa2,mem-path=/tmp/host1/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
-device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
-device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
-device cxl-type3,bus=swport2,volatile-dc-memdev=cxl-mem2,id=cxl-dcd0,lsa=cxl-lsa2,num-dc-regions=2,sn=99,allow-fm-attach=on \
-machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-dcd0,qmp=127.0.0.1:4445,mctp-msg-forward=on \
-device virtio-rng-pci,bus=swport1

Currently, the code is not clean at all, it is a POC to prove the idea. Only
type3 (including DCD) devices can accept requests from the FM, which should be
easy to extend to support switch-targeted FM command processing.

The code is based on Jonathan's cxl-2025-03-20 branch.
A qemu branch with the code: https://github.com/moking/qemu-jic-clone/tree/fm-qmp

FYI.
I have a tool to make the test easier.
https://github.com/moking/cxl-test-tool/tree/main

Part of .var.config, see run_vars.example

QEMU_ROOT=~/cxl/jic/qemu
# for FM VM
FM_KERNEL_ROOT=~/cxl/linux-v6.6-rc6/
FM_QEMU_IMG=~/cxl/images/qemu-image-fm.img

# for Target VM
KERNEL_ROOT=~/cxl/linux-dcd/
QEMU_IMG=~/cxl/images/qemu-image.img

command:
1. cxl-tool.py --run -T FM_TARGET
2. cxl-tool.py --attach-VM -T FM_CLIENT
3. cxl-tool.py --install-libcxlmi-fm
4. cxl-tool.py --setup-mctp-fm
5. cxl-tool.py --login-fm (run the test program with libcxlmi)

Fan Ni (3):
  cxl_type3: Preparing information sharing between VMs
  cxl_type3: Add qmp_cxl_process_mctp_message qmp interface
  cxl/i2c_mctp_cxl: Add support to process MCTP command remotely

 hw/cxl/cxl-mctp-qmp.c             |  85 +++++++++++++++
 hw/cxl/i2c_mctp_cxl.c             |  68 ++++++++++--
 hw/cxl/meson.build                |   2 +-
 hw/mem/cxl_type3.c                | 166 +++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c          |   5 +
 include/hw/cxl/cxl_device.h       |   8 ++
 include/hw/cxl/cxl_mctp_message.h |  43 ++++++++
 qapi/cxl.json                     |  18 ++++
 8 files changed, 387 insertions(+), 8 deletions(-)
 create mode 100644 hw/cxl/cxl-mctp-qmp.c
 create mode 100644 include/hw/cxl/cxl_mctp_message.h

-- 
2.47.2


