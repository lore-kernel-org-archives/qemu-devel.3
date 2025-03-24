Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084BDC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiLU-0006oN-Ly; Mon, 24 Mar 2025 10:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLE-0006lz-G1
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:59:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLC-00042Q-8Z
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:59:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224100e9a5cso82509825ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824785; x=1743429585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ycm8+FXf9bJFwfouIqzXpOahnKMfyZQnvppIi3S2rWs=;
 b=UM9JSw8Ah+Pt6U2rriaGu8QrP37EeDZUnBJ6akFbVZhNDJ7E3XSO26ONmMtc9cNkhi
 KM2ZMXr4s24R/lSKKt6CMCDjP1lqiGnF56OO4jKmRQK551kVEUaPdUGCE4TF69eSG0eb
 9bXbSDVmyi3ESTKVCPpgJL9kmEF+ExquW2uZ9GCdhbAPJBmD+SeKBM6ADPYXVidmSTze
 C04xW3d9B2WDwk5fQ5FRA1BYKuAUyz75vV4w97mdhpb+zcnv8KXzse03WVUD9jiqR/kd
 sBj2b2I3UuV9wJy4KnquOC/X5Ko1UIH+cN85YbddiHJzsHA1ZbCPrM50iCnALMLG9lC4
 vFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824785; x=1743429585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ycm8+FXf9bJFwfouIqzXpOahnKMfyZQnvppIi3S2rWs=;
 b=PdnYz5HlLpuVGdpopMNULUl3smp7RVnobVZZMkPInxQrAkedv9VOY/aYpCiPYSJem0
 5FocJ0M5mFWnwSZF8IKOmTRYuSJhVUKH2YR0nmGjDBkvfK+FlMOxQK8QsYxgh30iWv4F
 UceNFa0S+QsGLyvbQEVJyrldMjcxvWYJBx6HsMKI+jIMbsCT52H+4qfsx4/CRXyjTPZF
 apLV04Y2GCMbSOoLbR25vg8LJ5ZANTaWhKzgNbYqx6LPiNI0B3eZW33NbxHt5KsDE+Ds
 59HIL240zYhy2qKAWPRAOKtEU3Yo6oAhEIdt3+w0AVTQNu5Y8j9NZdYG+EawLgfQ57Zz
 TXTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHfLESC2Pi8i3DY3WdBM4qq8dwt4XxYhzT64KSerMMzq2gOZ7g011Yt3n+xe+vv/P8tPj6Vuw2Gk6W@nongnu.org
X-Gm-Message-State: AOJu0YwOzor8gzPZ/pkdgdUC2KQc1ZPExgge+rJvUp4v7T2FVF/MoTPO
 Sr5cmOih+uttSUyLjdiyvokW1wk8t25+Iokc7opPV3dG5LvqfGuV
X-Gm-Gg: ASbGncuvWqg3G3XzVg3lFo0Au88RgXATCP2VoxhjwBlGzqfF9m3SaS8mpByLqjcZTPP
 EYuZBf6q2kB0axzwrI1Zzn801Ov37uABhcY1AeiJgB6ysZJM1H9WnrHYNGr0v5MJUx7rm+064yW
 oOTQeIM1ftbWQcbKczM6W9386iRwGumbwAhDwbc4+SuMMMvSF71c/0SYUycWwAOt3q6WiEe+EJd
 4k/3U2wQtAitAO/9OS4/n49SkDh4pnUZO1jTpXgbO6ghuIZHqeNAVeQacdoOvI31bhWBA5vTMko
 qTvKCjrcWihe+FDmvu8pBFqtC95+bz4C+QZTHtg=
X-Google-Smtp-Source: AGHT+IFKU/u8n6U0DtcCaP1rX15fUJYZIJqlxHg6ULAZ0Ids7BrBrl5WvYVprdUqzfHGvl03sNEnvw==
X-Received: by 2002:a17:903:22c7:b0:220:d601:a704 with SMTP id
 d9443c01a7336-22780c7b0b8mr155446145ad.18.1742824784579; 
 Mon, 24 Mar 2025 06:59:44 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.06.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 06:59:44 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 0/7] Add packed format to shadow virtqueue
Date: Mon, 24 Mar 2025 19:29:14 +0530
Message-ID: <20250324135929.74945-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62d.google.com
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

I managed to fix a few issues while testing this patch series.
There is still one issue that I am unable to resolve. I thought
I would send this patch series for review in case I have missed
something.

The issue is that this patch series does not work every time. I
am able to ping L0 from L2 and vice versa via packed SVQ when it
works.

When this doesn't work, both VMs throw a "Destination Host
Unreachable" error. This is sometimes (not always) accompanied
by the following kernel error (thrown by L2-kernel):

virtio_net virtio1: output.0:id 1 is not a head!

This error is not thrown always, but when it is thrown, the id
varies. This is invariably followed by a soft lockup:

[  284.662292] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [swapper/1:0]
[  284.662292] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_class vfg
[  284.662292] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.7-200.fc39.x86_64 #1
[  284.662292] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  284.662292] RIP: 0010:virtqueue_enable_cb_delayed+0x115/0x150
[  284.662292] Code: 44 77 04 0f ae f0 48 8b 42 70 0f b7 40 02 66 2b 42 50 66 39 c1 0f 93 c0 c3 cc cc cc cc 66 87 44 77 04 eb e2 f0 83 44 24 fc 00 <e9> 5a f1
[  284.662292] RSP: 0018:ffffb8f000100cb0 EFLAGS: 00000246
[  284.662292] RAX: 0000000000000000 RBX: ffff96f20204d800 RCX: ffff96f206f5e000
[  284.662292] RDX: ffff96f2054fd900 RSI: ffffb8f000100c7c RDI: ffff96f2054fd900
[  284.662292] RBP: ffff96f2078bb000 R08: 0000000000000001 R09: 0000000000000001
[  284.662292] R10: ffff96f2078bb000 R11: 0000000000000005 R12: ffff96f207bb4a00
[  284.662292] R13: 0000000000000000 R14: 0000000000000000 R15: ffff96f20452fd00
[  284.662292] FS:  0000000000000000(0000) GS:ffff96f27bc80000(0000) knlGS:0000000000000000
[  284.662292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  284.662292] CR2: 00007f2a9ca191e8 CR3: 0000000136422003 CR4: 0000000000770ef0
[  284.662292] PKRU: 55555554
[  284.662292] Call Trace:
[  284.662292]  <IRQ>
[  284.662292]  ? watchdog_timer_fn+0x1e6/0x270
[  284.662292]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  284.662292]  ? __hrtimer_run_queues+0x10f/0x2b0
[  284.662292]  ? hrtimer_interrupt+0xf8/0x230
[  284.662292]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
[  284.662292]  ? sysvec_apic_timer_interrupt+0x39/0x90
[  284.662292]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  284.662292]  ? virtqueue_enable_cb_delayed+0x115/0x150
[  284.662292]  start_xmit+0x2a6/0x4f0 [virtio_net]
[  284.662292]  ? netif_skb_features+0x98/0x300
[  284.662292]  dev_hard_start_xmit+0x61/0x1d0
[  284.662292]  sch_direct_xmit+0xa4/0x390
[  284.662292]  __dev_queue_xmit+0x84f/0xdc0
[  284.662292]  ? nf_hook_slow+0x42/0xf0
[  284.662292]  ip_finish_output2+0x2b8/0x580
[  284.662292]  igmp_ifc_timer_expire+0x1d5/0x430
[  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
[  284.662292]  call_timer_fn+0x21/0x130
[  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
[  284.662292]  __run_timers+0x21f/0x2b0
[  284.662292]  run_timer_softirq+0x1d/0x40
[  284.662292]  __do_softirq+0xc9/0x2c8
[  284.662292]  __irq_exit_rcu+0xa6/0xc0
[  284.662292]  sysvec_apic_timer_interrupt+0x72/0x90
[  284.662292]  </IRQ>
[  284.662292]  <TASK>
[  284.662292]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  284.662292] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  284.662292] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 53 75 3f 00 fb f4 <c3> cc c0
[  284.662292] RSP: 0018:ffffb8f0000b3ed8 EFLAGS: 00000212
[  284.662292] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
[  284.662292] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 00000000000289ec
[  284.662292] RBP: ffff96f200810000 R08: 0000000000000000 R09: 0000000000000001
[  284.662292] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  284.662292] R13: 0000000000000000 R14: ffff96f200810000 R15: 0000000000000000
[  284.662292]  default_idle+0x9/0x20
[  284.662292]  default_idle_call+0x2c/0xe0
[  284.662292]  do_idle+0x226/0x270
[  284.662292]  cpu_startup_entry+0x2a/0x30
[  284.662292]  start_secondary+0x11e/0x140
[  284.662292]  secondary_startup_64_no_verify+0x184/0x18b
[  284.662292]  </TASK>

The soft lockup seems to happen in
drivers/net/virtio_net.c:start_xmit() [1].

I don't think the issue is in the kernel because I haven't seen
any issue when testing my changes with split vqs. Only packed vqs
give an issue.

L0 kernel version: 6.12.13-1-lts

QEMU command to boot L1:

$ sudo ./qemu/build/qemu-system-x86_64 \
-enable-kvm \
-drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
-net nic,model=virtio \
-net user,hostfwd=tcp::2222-:22 \
-device intel-iommu,snoop-control=on \
-device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,mq=off,ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_mac_addr=off,packed=on,event_idx=off,bus=pcie.0,addr=0x4 \
-netdev tap,id=net0,script=no,downscript=no,vhost=off \
-nographic \
-m 8G \
-smp 4 \
-M q35 \
-cpu host 2>&1 | tee vm.log

L1 kernel version: 6.8.5-201.fc39.x86_64

I have been following the "Hands on vDPA - Part 2" blog
to set up the environment in L1 [2].

QEMU command to boot L2:

# ./qemu/build/qemu-system-x86_64 \
-nographic \
-m 4G \
-enable-kvm \
-M q35 \
-drive file=//root/L2.qcow2,media=disk,if=virtio \
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
-device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_mac_addr=off,event_idx=off,packed=on,bus=pcie.0,addr=0x7 \
-smp 4 \
-cpu host \
2>&1 | tee vm.log

L2 kernel version: 6.8.7-200.fc39.x86_64

I confirmed that packed vqs are enabled in L2 by running the
following:

# cut -c35 /sys/devices/pci0000\:00/0000\:00\:07.0/virtio1/features 
1

I may be wrong, but I think the issue in my implementation might be
related to:

1. incorrect endianness coversions.
2. implementation of "vhost_svq_more_used_packed" in commit #5.
3. implementation of "vhost_svq_(en|dis)able_notification" in commit #5.
4. something else?

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/drivers/net/virtio_net.c#L3245
[2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2

Sahil Siddiq (7):
  vhost: Refactor vhost_svq_add_split
  vhost: Data structure changes to support packed vqs
  vhost: Forward descriptors to device via packed SVQ
  vdpa: Allocate memory for SVQ and map them to vdpa
  vhost: Forward descriptors to guest via packed vqs
  vhost: Validate transport device features for packed vqs
  vdpa: Support setting vring_base for packed SVQ

 hw/virtio/vhost-shadow-virtqueue.c | 396 ++++++++++++++++++++++-------
 hw/virtio/vhost-shadow-virtqueue.h |  88 ++++---
 hw/virtio/vhost-vdpa.c             |  52 +++-
 3 files changed, 404 insertions(+), 132 deletions(-)

-- 
2.48.1


