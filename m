Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB92ACD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWLO-0005LL-1E; Fri, 05 Jun 2026 11:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVWLM-0005Kr-I1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVWLK-0005xR-3d
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780672816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjHqaSOnrx29GLKNlcvVjVzeXyq3ExDRnObF0ZIQkyM=;
 b=FB+nuCY305jJIf2HEdzqSCnkNd3SIQvalnn+sCCnVyQrwcjv6SZy293HgrNB8HaXcDtUXu
 eUtf4HtPqV+Z2FQErVVsiXIVxeqx2zHoc29BObUHRNDRZPC34hZuD8M/yBWZtJZS9Xibrq
 6vRBqur1yMGsB8DdAifxmgYxNfFp0qI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-fuhxNX8kN_CMAFwMyJx12g-1; Fri, 05 Jun 2026 11:20:15 -0400
X-MC-Unique: fuhxNX8kN_CMAFwMyJx12g-1
X-Mimecast-MFC-AGG-ID: fuhxNX8kN_CMAFwMyJx12g_1780672814
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-68c4453b623so1960878a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780672814; x=1781277614; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qjHqaSOnrx29GLKNlcvVjVzeXyq3ExDRnObF0ZIQkyM=;
 b=mbHpKRWKVcJYsm3MOCRE71sUM17D6AaX1aPSqo8+lUgFYT47v2mBRJWR9QdOlrrTuo
 rUU6AFUBE+EdYZx+kObKAlN8oEAapfTx6wWyEX62cyT1q6cuaSMzB0POwru+Hyma+3L1
 qHBxMlnEHMLkPgi4gtRVX3KqnRi4PPNyfYyeD6dpjoAcSLp7GfUoIOIcuViz1JudL8cj
 3fXUtucBk8RJ5Lq3gw0ZBWW8SIJoY3DtHyQ2wWyb0btRz3+J4onBsk4q7T4KfEmTxIne
 8Vyr17MfyR/Lb3R7MKPjHUNlIuTFthih188Ih6E43bZSJmCrLefsvkUyTxhWZC1+xAjI
 OtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780672814; x=1781277614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjHqaSOnrx29GLKNlcvVjVzeXyq3ExDRnObF0ZIQkyM=;
 b=T+L+vG2B/IbXcZ3vLtxc2te5W+r13jzdm9HXkZsgNE3wnq+/I+8W3KcFq5bDnd8aaA
 r/vDTbqNStO7qexDw7kiSHrhxuOv0/oDExCTU0vBwnAMHravubTosabisVnduKMTVb80
 hvwFXiyGgPrVzYNz8HQfVO9OqJ1fSPYgfaiPOvt63zooK4jXCU8IoBQgw9DxxABznKJE
 leBXPqLhFz3M30x/I0JI26fLSd4YvW/5Iq8JI/V7TcLKSXNVvzE6Pqn3MVO83XHIIK3F
 vHnbJ1zTY4CuL5vwoSKYW9pB2BASzbIDCg1oyO/sN1oQnH8i577XnszetB2tlYeh7w5o
 xoYQ==
X-Gm-Message-State: AOJu0YwbFw9ewwSMA/Rc/s14HnuxY/ZprrvcRTiHMUK3bp5I7TAtrJrO
 LNf/F19g20yy0jQEfjBXZHYipv4zNqCFD0ghCE4fY09g+Wg+7GlLDtoMc6seFRo5+KUeK93VCFh
 sZQ25/GCAHOJ99eEb665Dawb/CEKHvMMsc/7Yn1N6h2cQi1uRGHkeLilD
X-Gm-Gg: Acq92OGBKaUP86ehIqCCFc8/4WCgCLtPAQcaDYcDHZbnHPevMghCJGnAWR9Qt5nZsYX
 Mz5RApmMseNWhgjelVhy2sZhNkckW2detCrnkLQ9bi2g0SSc3C3v2AzkvhetVpljUMJgUKbvm7H
 jn5NOtwm7KtumjhHXAR+SyPe6fTdmSTBAsMzle3OIap1DW1xCW9toducXrLF/8kCKqw4KOZ2qx1
 gy7JSzEZcm/GuF2FZOaXbLGiKC2AcFVcXPG6p4w5rQO3J0VBpcjR+kmOFcxsHMynvfaF1FM63GK
 4lAK6D4vWQIvSiDvN91dzB+N30MeA9vUIx1vOTy/jWsmICgxEy9+lH4QNx7qwjgsa81RNbHVG2t
 gSJ6X/UIMbYOHvTgC44OtFwxilNJUce+865IZFc1Krby/hDDH41rwfT8=
X-Received: by 2002:a05:6402:388f:b0:68a:ac22:ccc4 with SMTP id
 4fb4d7f45d1cf-68fa5035f4fmr2129310a12.14.1780672813910; 
 Fri, 05 Jun 2026 08:20:13 -0700 (PDT)
X-Received: by 2002:a05:6402:388f:b0:68a:ac22:ccc4 with SMTP id
 4fb4d7f45d1cf-68fa5035f4fmr2129279a12.14.1780672813356; 
 Fri, 05 Jun 2026 08:20:13 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b4d988sm3934047a12.25.2026.06.05.08.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:20:12 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:20:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gabriel Goller <g.goller@proxmox.com>,
 Stefan Hanreich <s.hanreich@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by
 default
Message-ID: <20260605111823-mutt-send-email-mst@kernel.org>
References: <cover.1762698873.git.mst@redhat.com>
 <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
 <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 05, 2026 at 04:02:39PM +0200, Fiona Ebner wrote:
> Dear maintainers,
> 
> Am 09.11.25 um 4:10 PM schrieb Michael S. Tsirkin:
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 17ed0ef919..3b85560f6f 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -4299,19 +4299,19 @@ static const Property virtio_net_properties[] = {
> >      VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
> >                                 host_features_ex,
> >                                 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> > -                               false),
> > +                               true),
> it seems that the host_tunnel setting can cause issues when VXLAN
> traffic originating in a guest goes over a physical NIC which does not
> support the feature. We received several reports about the issue
> [0][1][2][3] and were able to reproduce it. Turning off the
> 'host_tunnel' property in the commandline for the VirtIO net device
> makes TCP traffic work. The network configuration from our reproducer
> setup is as follows:
> 
>       guest A (iperf3 -c)                   guest B (iperf3 -s)
>   vxlan using vNIC as underlay         vxlan using vNIC as underlay
> virtualized NIC exposed to guest     virtualized NIC exposed to guest
>     ---guest boundary---                  ---guest boundary---
>  tap device connected to bridge       tap device connected to bridge
> bridge with physical NIC as port     bridge with physical NIC as port
>         physical NIC   <---host boundary--->   physical NIC
> 
> Bridge configuration:
> iface vmbr0 inet static
> 	address 10.48.0.109/20
> 	gateway 10.48.0.1
> 	bridge-ports nic3
> 	bridge-stp off
> 	bridge-fd 0
> 	bridge-vlan-aware yes
> 	bridge-vids 2-4094
> 
> VXLAN created with:
> ip link add vxlan0 type vxlan id 100 remote X dstport 4789 dev eth1
> where eth1 is the virtualized NIC exposed to the guest
> 
> The physical NIC does not have the feature:
> Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme
> BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
> tx-udp_tnl-segmentation: off [fixed]
> tx-udp_tnl-csum-segmentation: off [fixed]
> 
> Using a physical NIC which does have the feature works:
> Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57504
> NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet [14e4:1751] (rev 11)
> tx-udp_tnl-segmentation: on
> tx-udp_tnl-csum-segmentation: on
> 
> Host kernel:
> Proxmox VE with 7.0.2-6-pve
> 
> Guest kernel:
> Apline with 6.18.34-0-lts
> 
> QEMU commandline for the vNIC:
> > -netdev 'type=tap,id=net2,ifname=tap103i2,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
> > -device 'virtio-net-pci,mac=BC:24:11:78:C3:3B,netdev=net2,bus=pci.0,addr=0x14,id=net2,rx_queue_size=1024,tx_queue_size=256,host_mtu=1500' \
> 
> We can see that QEMU sets the features for the tap interface via ioctl()
> and the host kernel allows it:
> tx-udp_tnl-segmentation: on
> tx-udp_tnl-csum-segmentation: on
> 
> As far as we understand, in the problematic scenario, nothing is ever
> filling in the checksums for the inner TCP packets, meaning the outer
> UDP checksum ends up being wrong on the target side. Is the host kernel
> responsible for doing that before passing the packet to the physical NIC
> (without the feature)? Or who would be?
> 
> Turning off host_tunnel_csum without turning off host_tunnel does not help.
> 
> Interestingly, turning off the features for the working physical NIC
> does not make it break:
> tx-udp_tnl-segmentation: off
> tx-udp_tnl-csum-segmentation: off
> Could it be that the NIC just always fills in the inner TCP checksums
> regardless of that setting?
> 
> On the other hand, running
> localhost:~# ethtool -K eth2 tx-checksum-ip-generic off
> Actual changes:
> tx-checksum-ip-generic: off
> tx-tcp-segmentation: off [not requested]
> tx-tcp-ecn-segmentation: off [not requested]
> tx-tcp6-segmentation: off [not requested]
> tx-udp-segmentation: off [not requested]
> inside the guests makes it work for the physical NIC without the
> tx-udp_tnl* features.
> 
> I wanted to ask if this configuration is expected to be unsupported and
> if the management is expected to turn off the feature on the commandline
> if the traffic might go over a physical NIC without the feature. Or if
> this could be a kernel or NIC bug that should be investigated further?
> In the former case, should the option really be turned on by default
> with new machine versions?
> 
> I'll be happy to test and capture/provide additional information. Let me
> know what would be interesting.
> 
> Thanks to Stefan and Gabriel for looking into the issue with me!
> 
> Best Regards,
> Fiona
> 
> [0]: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> [1]: https://forum.proxmox.com/threads/183494/post-855144
> [2]: https://forum.proxmox.com/threads/182328/post-854627
> [3]: https://forum.proxmox.com/threads/183963/post-855737


looks like a kernel or nic bug to me.


-- 
MST


