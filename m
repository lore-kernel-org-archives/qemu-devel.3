Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834F2C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woIyt-0001mE-9k; Mon, 27 Jul 2026 06:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woIyr-0001lr-5l
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:54:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woIyo-0003Y3-1X
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:54:44 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66RAsUZp020070
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2026 19:54:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BtsNVOumNQ8Ld0giT3V3k+lI1afJGcu4M1x7qh9AThQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785149670; v=1;
 b=ekfd6HtCd+Ablhu+YxjlP1fSHWjTg/RkGtzEk9yAUkPZoTyucl3FNZNd2lThzEAW
 CRi0NvsXh/tlx5oWokaKbcrt87AFw1v4h0XtrLV4rHDpEGhvSPPlSrCHBA0FrLtz
 EF6TPe5cZqf7uU9CgFIaXFHTBfCRR6fekkzx9FRL+AElGpfKiiNO6uDmZFUqhgSg
 /IN7WVP9NUb0LyXdUX+0EBZBy16vQY+pJ6YHTlE81yEACV9HECe4W58uGCzXwEFh
 tAdrzlNtMrNswz0B7NePxDcHOnjA4+m30vuLJUpwhq+Xvg0PGkMS3I11L4Rudtw8
 VUwoKxxc1DWC2y+atAR+0g==
Message-ID: <54878ec4-66ce-45e0-a620-4d6fd9241731@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 19:54:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/11] docs: Add igb VF migration testing setup guide
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <20260727053935.1392269-11-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260727053935.1392269-11-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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



On 2026/07/27 14:39, Cédric Le Goater wrote:
> Document the NetworkManager configuration and network topology needed
> to test igb VF live migration in a nested virtualization environment.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/system/devices/igb-migration.rst | 155 ++++++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
> 
> diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
> index 4a3a93f01dfc..0e34e4b9fc68 100644
> --- a/docs/system/devices/igb-migration.rst
> +++ b/docs/system/devices/igb-migration.rst
> @@ -134,3 +134,158 @@ The driver fills the request fields, issues ``DIRTY_CTRL=QUERY``, and
>   polls ``status`` for completion. The device reads the request, writes
>   the dirty bitmap and completion fields via DMA, then sets
>   ``status = 1``.
> +
> +Testing setup
> +~~~~~~~~~~~~~
> +
> +The target scenario is nested virtualization::
> +
> +  L0 QEMU
> +    igb PF with x-vf-migration=on
> +    └── VFs with migration BAR + vendor cap
> +
> +  L1 kernel
> +    igb-vfio-pci variant driver
> +    translates VFIO migration v2 ioctls → BAR2 MMIO
> +
> +  L1 QEMU (stock, unmodified)
> +    vfio-pci device model, standard migration fd
> +
> +  L2 guest
> +    standard igbvf driver, unaware of migration
> +
> +NetworkManager configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In a nested setup, the L1 VMs (source and destination) have emulated
> +igb PFs connected to the L0 bridge. By default, NetworkManager
> +acquires DHCP leases on those PF interfaces and on any igb VFs created
> +later. This causes the VF MAC address to be learned on the L0 bridge,
> +which can misdirect iperf3 traffic after migration.
> +
> +To prevent this, configure NetworkManager on **both L1 VMs** and on the
> +**L2 guest disk image**.
> +
> +L1 VMs (source and destination)
> +...............................
> +
> +1. Prevent NetworkManager from managing igbvf interfaces:
> +
> +.. code-block:: bash
> +
> +   cat > /etc/NetworkManager/conf.d/99-no-igbvf.conf <<EOF
> +   [keyfile]
> +   unmanaged-devices=driver:igbvf
> +   EOF
> +
> +2. Disable IP on the igb PF connections (keep the interfaces UP for
> +   bridging, but with no DHCP lease):
> +
> +.. code-block:: bash
> +
> +   # Identify the NM connections for the igb PFs (NOT the virtio management NIC)
> +   nmcli -t -f NAME,DEVICE connection show
> +
> +   # For each igb PF connection:
> +   nmcli connection modify "<igb-pf-connection>" ipv4.method disabled ipv6.method disabled

I suspect we also need: nmcli device reapply

> +
> +3. Reload NetworkManager:
> +
> +.. code-block:: bash
> +
> +   nmcli general reload
> +
> +L2 guest disk image
> +...................
> +
> +Use ``virt-customize`` to add the igbvf unmanaged config to the guest
> +image (offline, before any test run):
> +
> +.. code-block:: bash
> +
> +   virt-customize -a /srv/migration/rhel10.qcow2 \
> +     --write /etc/NetworkManager/conf.d/99-no-igbvf.conf:'[keyfile]
> +   unmanaged-devices=driver:igbvf'
> +
> +Network diagram
> +^^^^^^^^^^^^^^^
> +
> +The diagram below shows the nested setup where the source and
> +destination hosts are themselves VMs (L1) running on a physical
> +host (L0) that emulates the igb NIC::
> +
> +  ┌────────────────────────────────────────────────────────────────────────────┐
> +  │  L0: physical host                                                         │
> +  │                                                                            │
> +  │  virbr0  192.168.199.1/24                                                  │
> +  │  ├── NFS server: /srv/migration                                            │
> +  │  └── iperf3 client: iperf3 -c 192.168.199.200 -t 60 -i 1                   │
> +  │      │                                                                     │
> +  │      │  L0 virbr0 bridge (192.168.199.0/24)                                │
> +  │  ────┼──────────┬──────────────────┬──────────────────────────────         │
> +  │      │          │                  │                                       │
> +  │      │     ┌────┴────┐        ┌────┴────┐                                  │
> +  │      │     │ virtio  │        │ emulated│                                  │
> +  │      │     │c0:ff:ee:│        │  igb PF │    L0 QEMU (vm6)                 │
> +  │      │     │ :00:06  │        │ + igbvf │    tracks DMA dirty pages        │
> +  │      │     └────┬────┘        └────┬────┘                                  │
> +  │      │          │                  │                                       │
> +  │  ┌───┼──────────┼──────────────────┼──────────────────────────────────┐    │
> +  │  │   │  L1: vm6 (source)           │                                  │    │
> +  │  │   │  enp1s0: 192.168.199.6      │                                  │    │
> +  │  │   │  (management)               │                                  │    │
> +  │  │   │                        enp8s0 (igb PF, no IP)                  │    │
> +  │  │   │                             │                                  │    │
> +  │  │   │                        igb VF0 ──► igb-vfio-pci (VFIO)         │    │
> +  │  │   │                             │      dirty_sync → L0 igbvf       │    │
> +  │  │   │                             │                                  │    │
> +  │  │   │   virbr0                    │ VFIO passthrough                 │    │
> +  │  │   │   192.168.200.1/24          │                                  │    │
> +  │  │   │       │                     │                                  │    │
> +  │  │   │  ┌────┼─────────────────────┼───────────────────────────┐      │    │
> +  │  │   │  │    │  L2: rhel10 guest   │                           │      │    │
> +  │  │   │  │    │                     │                           │      │    │
> +  │  │   │  │  virtio NIC           igb VF (enp7s0)                │      │    │
> +  │  │   │  │  192.168.200.130/24   192.168.199.200/24             │      │    │
> +  │  │   │  │  (SSH login)          (iperf3 data path)             │      │    │
> +  │  │   │  │                          │                           │      │    │
> +  │  │   │  │            iperf3 -s -D  │ (listens on 0.0.0.0)      │      │    │
> +  │  │   │  └──────────────────────────┼───────────────────────────┘      │    │
> +  │  │   │                             │                                  │    │
> +  │  │   │  virsh migrate --live ──────┼──────────────────► vm7           │    │
> +  │  │   │                             │                                  │    │
> +  │  └───┼─────────────────────────────┼──────────────────────────────────┘    │
> +  │      │                             │                                       │
> +  │      │          iperf3 traffic     │                                       │
> +  │      └─────────────────────────────┘                                       │
> +  │                                                                            │
> +  │  ────────────────────────────────────────────────────────────────          │
> +  │      │                  │                                                  │
> +  │      │     ┌────────┐   │   ┌─────────┐                                    │
> +  │      │     │ virtio │   │   │emulated │    L0 QEMU (vm7)                   │
> +  │      │     │c0:ff:ee│   │   │ igb PF  │                                    │
> +  │      │     │ :00:07 │   │   │ + igbvf │                                    │
> +  │      │     └────┬───┘   │   └────┬────┘                                    │
> +  │  ┌──────────────┼───────┼────────┼────────────────────────────────────┐    │
> +  │  │   L1: vm7 (destination)       │                                    │    │
> +  │  │   enp1s0: 192.168.199.7       │                                    │    │
> +  │  │   (management)           enp8s0 (igb PF, no IP)                    │    │
> +  │  │                               │                                    │    │
> +  │  │                          igb VF0 ──► igb-vfio-pci (VFIO)           │    │
> +  │  │                               │                                    │    │
> +  │  │   virbr0                      │ VFIO passthrough                   │    │
> +  │  │   192.168.200.1/24            │                                    │    │
> +  │  │       │                       │                                    │    │
> +  │  │  ┌────┼───────────────────────┼────────────────────────────┐       │    │
> +  │  │  │    │  L2: rhel10 (after migration)                      │       │    │
> +  │  │  │    │                       │                            │       │    │
> +  │  │  │  virtio NIC             igb VF (enp7s0)                 │       │    │
> +  │  │  │  192.168.200.130/24     192.168.199.200/24              │       │    │
> +  │  │  │                            │                            │       │    │
> +  │  │  │              iperf3 -s -D  │ (connection survives)      │       │    │
> +  │  │  └────────────────────────────┼────────────────────────────┘       │    │
> +  │  └───────────────────────────────┼────────────────────────────────────┘    │
> +  │                                  │                                         │
> +  │      iperf3 traffic resumes ─────┘                                         │
> +  │      (same IP, same MAC, same L2 segment → transparent to client)          │
> +  └────────────────────────────────────────────────────────────────────────────┘

The diagram looks corrupted to me.

Regards,
Akihiko Odaki

