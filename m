Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B66E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIYj-0005rX-QW; Thu, 05 Dec 2024 15:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIYi-0005rO-9J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:34:48 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIYg-0004Z0-5Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:34:48 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7f71f2b136eso1107314a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733430884; x=1734035684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xJ0m/olPXsc7c2xMRbA2MC5y0y1/uE04Yy8KC7/ff3A=;
 b=GTq8KoU/6rQuaXo21lyZnXtrNfmWFhXqe3Gtj118ygKK9knDqG7WEtWv9d9jl9+Mib
 YZdDaBVSecHf0YPFlzE/Xvu6iOJ2KeL3OqT/6Qvc1zXaO2GGBeYYN8DHpnI4yjbkx857
 zEHlRt6E8Gnf71BlKb2u6+nMuJHMsx5qf0JmpgGSf73onkswvUxy9xelg38e2mFsv/r+
 D/4aQKdj2BOH8so6LAWRciSBjAeJsdYtZB/Bjtgv9cKgs/j9RCz7Zn+E4fr/Vd1iR/f3
 F2TPDu5pkhVEhoGtbLaHTR/J/fwPTjgDZzOKHBlR8/cZyR6mXZZejMNj+jiKkZmmhJ32
 l8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430884; x=1734035684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJ0m/olPXsc7c2xMRbA2MC5y0y1/uE04Yy8KC7/ff3A=;
 b=S5GUeKYbKdWqVZ1OAauY5DWB5mfqNG6EgttNtrY77JRAjzKXpIW4SE6YFUc935/R2W
 zzCApDl99CCPNrX+3MY/SQewUnBVszMpqB4xU8coNDa/FsJJNGeXbulXKUlgCErQMIPP
 NfAJkB2YzOyldLuoP0S+VmWmdRLrPLii+f8MVPE+sOj8u0jKP00ua59YTTcDMVlLCwuL
 YM6rv0GpLnvNDmAbBx67jG5bNBtXB0vbAZnZzZ2FpcwLJ0YCyf4qF00OXt/wfTvrMETu
 J1wtMU0dSk1zo3o1e1aC5TF4DI+dsFWkQhvYFQhF/e6RLrlFJHIHqsVF7yeA0FnnC07+
 5RFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3MZJ6wKsRBdriQaLITsBxna/okBwYGwlXD6a5JJriO05ZpetMI4bNP+IDRZTYIMp+dy8ysuQjqeoB@nongnu.org
X-Gm-Message-State: AOJu0Yw5FlXuhxkzqi0MUp2NO5uo8Yl1JY6kWMZ6TBTuQp0HIRXQVVLE
 wbzgABfMmCZ9zOn7Rbg5KlZtjOJe1CxlqA/RJPNxmMf2FHhA+4pK
X-Gm-Gg: ASbGncsL1ZyWURyoXZQf47shF1d0XLAT3EaQFpI9UDV5HFW6zbpy7z/HEHQv39qIVpd
 F/Pyok15NTfK2N0ibtl5QqAzgPPVYgoqs6E8QnjJdC1YMhqn26EVSPLdJPg+G8LKc1KC2sgOULN
 OUi5sYJmIp5o4n7n3rxVj2BxrqUg4QzuMau4kuswYce/yqJIV5iyA7gPVL+o+OVyjGncC1p6WWT
 JacRpYMaWGVTJX68HSajbSxc2BPeL8aDo1d3qewnWE=
X-Google-Smtp-Source: AGHT+IE9oGbksi/VzxIWTe5rRi/hHp9R1r091lydcMjKFmTq2kAZuPUqANfXku7kPXba/eUrZTYzJw==
X-Received: by 2002:a05:6a20:7284:b0:1db:ef68:e505 with SMTP id
 adf61e73a8af0-1e1870cb327mr537181637.20.1733430882965; 
 Thu, 05 Dec 2024 12:34:42 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701c2f2sm3705905a91.23.2024.12.05.12.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:34:42 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
Date: Fri,  6 Dec 2024 02:04:25 +0530
Message-ID: <20241205203430.76251-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=icegambit91@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

There are two issues that I found while trying to test
my changes. I thought I would send the patch series
as well in case that helps in troubleshooting. I haven't
been able to find an issue in the implementation yet.
Maybe I am missing something.

I have been following the "Hands on vDPA: what do you do
when you ain't got the hardware v2 (Part 2)" [1] blog to
test my changes. To boot the L1 VM, I ran:

sudo ./qemu/build/qemu-system-x86_64 \
-enable-kvm \
-drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
-net nic,model=virtio \
-net user,hostfwd=tcp::2222-:22 \
-device intel-iommu,snoop-control=on \
-device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,packed=on,event_idx=off,bus=pcie.0,addr=0x4 \
-netdev tap,id=net0,script=no,downscript=no \
-nographic \
-m 8G \
-smp 4 \
-M q35 \
-cpu host 2>&1 | tee vm.log

Without "guest_uso4=off,guest_uso6=off,host_uso=off,
guest_announce=off" in "-device virtio-net-pci", QEMU
throws "vdpa svq does not work with features" [2] when
trying to boot L2.

The enums added in commit #2 in this series is new and
wasn't in the earlier versions of the series. Without
this change, x-svq=true throws "SVQ invalid device feature
flags" [3] and x-svq is consequently disabled.

The first issue is related to running traffic in L2
with vhost-vdpa.

In L0:

$ ip addr add 111.1.1.1/24 dev tap0
$ ip link set tap0 up
$ ip addr show tap0
4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
    link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
    inet 111.1.1.1/24 scope global tap0
       valid_lft forever preferred_lft forever
    inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever

I am able to run traffic in L2 when booting without
x-svq.

In L1:

$ ./qemu/build/qemu-system-x86_64 \
-nographic \
-m 4G \
-enable-kvm \
-M q35 \
-drive file=//root/L2.qcow2,media=disk,if=virtio \
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0 \
-device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
-smp 4 \
-cpu host \
2>&1 | tee vm.log

In L2:

# ip addr add 111.1.1.2/24 dev eth0
# ip addr show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enp0s7
    inet 111.1.1.2/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

# ip route
111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2

# ping 111.1.1.1 -w3
PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
64 bytes from 111.1.1.1: icmp_seq=1 ttl=64 time=0.407 ms
64 bytes from 111.1.1.1: icmp_seq=2 ttl=64 time=0.671 ms
64 bytes from 111.1.1.1: icmp_seq=3 ttl=64 time=0.291 ms

--- 111.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2034ms
rtt min/avg/max/mdev = 0.291/0.456/0.671/0.159 ms


But if I boot L2 with x-svq=true as shown below, I am unable
to ping the host machine.

$ ./qemu/build/qemu-system-x86_64 \
-nographic \
-m 4G \
-enable-kvm \
-M q35 \
-drive file=//root/L2.qcow2,media=disk,if=virtio \
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
-device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
-smp 4 \
-cpu host \
2>&1 | tee vm.log

In L2:

# ip addr add 111.1.1.2/24 dev eth0
# ip addr show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enp0s7
    inet 111.1.1.2/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

# ip route
111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2

# ping 111.1.1.1 -w10
PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
From 111.1.1.2 icmp_seq=1 Destination Host Unreachable
ping: sendmsg: No route to host
From 111.1.1.2 icmp_seq=2 Destination Host Unreachable
From 111.1.1.2 icmp_seq=3 Destination Host Unreachable

--- 111.1.1.1 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2076ms
pipe 3

The other issue is related to booting L2 with "x-svq=true"
and "packed=on".

In L1:

$ ./qemu/build/qemu-system-x86_64 \
-nographic \
-m 4G \
-enable-kvm \
-M q35 \
-drive file=//root/L2.qcow2,media=disk,if=virtio \
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,x-svq=true \
-device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,packed=on,bus=pcie.0,addr=0x7 \
-smp 4 \
-cpu host \
2>&1 | tee vm.log

The kernel throws "virtio_net virtio1: output.0:id 0 is not
a head!" [4].

Here's part of the trace:

[...]
[  945.370085] watchdog: BUG: soft lockup - CPU#2 stuck for 863s! [NetworkManager:795]
[  945.372467] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_g
[  945.387413] CPU: 2 PID: 795 Comm: NetworkManager Tainted: G             L     6.8.7-200.fc39.x86_64 #1
[  945.390685] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  945.394256] RIP: 0010:virtnet_poll+0xd8/0x5c0 [virtio_net]
[  945.395998] Code: c0 74 5c 65 8b 05 24 37 8b 3f 41 89 86 c4 00 00 00 80 bb 40 04 00 00 00 75 32 48 8b 3b e8 00 00 28 c7 48 89 df be8
[  945.401465] RSP: 0018:ffffabaec0134e48 EFLAGS: 00000246
[  945.403362] RAX: ffff9bf904432000 RBX: ffff9bf9085b1800 RCX: 00000000ffff0001
[  945.405447] RDX: 0000000000008080 RSI: 0000000000000001 RDI: ffff9bf9085b1800
[  945.408361] RBP: ffff9bf9085b0808 R08: 0000000000000001 R09: ffffabaec0134ba8
[  945.410828] R10: ffffabaec0134ba0 R11: 0000000000000003 R12: ffff9bf905a34ac0
[  945.413272] R13: 0000000000000040 R14: ffff9bf905a34a00 R15: ffff9bf9085b0800
[  945.415180] FS:  00007fa81f0f1540(0000) GS:ffff9bf97bd00000(0000) knlGS:0000000000000000
[  945.418177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  945.419415] CR2: 000055614ba8dc48 CR3: 0000000102b42006 CR4: 0000000000770ef0
[  945.423312] PKRU: 55555554
[  945.424238] Call Trace:
[  945.424238]  <IRQ>
[  945.426236]  ? watchdog_timer_fn+0x1e6/0x270
[  945.427304]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  945.428239]  ? __hrtimer_run_queues+0x10f/0x2b0
[  945.431304]  ? hrtimer_interrupt+0xf8/0x230
[  945.432236]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
[  945.434187]  ? sysvec_apic_timer_interrupt+0x39/0x90
[  945.436306]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  945.438199]  ? virtnet_poll+0xd8/0x5c0 [virtio_net]
[  945.438199]  ? virtnet_poll+0xd0/0x5c0 [virtio_net]
[  945.440197]  ? handle_irq_event+0x50/0x80
[  945.442415]  ? sched_clock_cpu+0x5e/0x190
[  945.444563]  ? irqtime_account_irq+0x40/0xc0
[  945.446191]  __napi_poll+0x28/0x1c0
[  945.446191]  net_rx_action+0x2a4/0x380
[  945.448851]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[  945.450209]  ? note_gp_changes+0x6c/0x80
[  945.452252]  __do_softirq+0xc9/0x2c8
[  945.453579]  do_softirq.part.0+0x3d/0x60
[  945.454188]  </IRQ>
[  945.454188]  <TASK>
[  945.456175]  __local_bh_enable_ip+0x68/0x70
[  945.458373]  virtnet_open+0xdc/0x310 [virtio_net]
[  945.460005]  __dev_open+0xfa/0x1b0
[  945.461310]  __dev_change_flags+0x1dc/0x250
[  945.462800]  dev_change_flags+0x26/0x70
[  945.464190]  do_setlink+0x375/0x12d0
[...]

I am not sure if this issue is similar to the one
described in this patch (race between channels
setting and refill) [5]. As described in the patch,
I see drivers/net/virtio_net:virtnet_open invoke
try_fill_recv() and schedule_delayed_work() [6]. I
am unfamiliar with this and so I am not sure how to
progress.

Maybe I can try disabling napi and checking it out
if that is possible. Would this be a good next step
to troubleshoot the kernel crash?

Thanks,
Sahil

Changes v3 -> v4:
- Split commit #1 of v3 into commit #1 and #2 in
  this series [7].
- Commit #3 is commit #2 of v3.
- Commit #4 is based on commit #3 of v3.
- Commit #5 was sent as an individual patch [8].
- vhost-shadow-virtqueue.c
  (vhost_svq_valid_features): Add enums.
  (vhost_svq_memory_packed): Remove function.
  (vhost_svq_driver_area_size,vhost_svq_descriptor_area_size): Decouple functions.
  (vhost_svq_device_area_size): Rewrite function.
  (vhost_svq_start): Simplify implementation.
  (vhost_svq_stop): Unconditionally munmap().
- vhost-shadow-virtqueue.h: New function declaration.
- vhost-vdpa.c
  (vhost_vdpa_svq_unmap_rings): Call vhost_vdpa_svq_unmap_ring().
  (vhost_vdpa_svq_map_rings): New mappings.
  (vhost_vdpa_svq_setup): Add comment.

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/net/vhost-vdpa.c#L167
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L58
[4] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1763
[5] https://lkml.iu.edu/hypermail/linux/kernel/1307.0/01455.html
[6] https://github.com/torvalds/linux/blob/master/drivers/net/virtio_net.c#L3104
[7] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01148.html
[8] https://lists.nongnu.org/archive/html/qemu-devel/2024-11/msg00598.html

Sahil Siddiq (5):
  vhost: Refactor vhost_svq_add_split
  vhost: Write descriptors to packed svq
  vhost: Data structure changes to support packed vqs
  vdpa: Allocate memory for svq and map them to vdpa
  vdpa: Support setting vring_base for packed svq

 hw/virtio/vhost-shadow-virtqueue.c | 222 +++++++++++++++++++----------
 hw/virtio/vhost-shadow-virtqueue.h |  70 ++++++---
 hw/virtio/vhost-vdpa.c             |  47 +++++-
 3 files changed, 237 insertions(+), 102 deletions(-)

-- 
2.47.0


