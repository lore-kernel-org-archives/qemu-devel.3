Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezMZ-0006il-5c; Fri, 16 Aug 2024 11:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sezMX-0006iH-4o
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:59:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sezMU-0005IB-C9
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:59:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wlmnk2GYwz6K993;
 Fri, 16 Aug 2024 23:56:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CF10140A70;
 Fri, 16 Aug 2024 23:59:26 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 16 Aug
 2024 16:59:26 +0100
Date: Fri, 16 Aug 2024 16:59:25 +0100
To: Akihiko Odaki <akihiko.odaki@daynix.com>
CC: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>, "Andrew
 Melnychenko" <andrew@daynix.com>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v10 02/18] tap: Remove qemu_using_vnet_hdr()
Message-ID: <20240816165925.00003da3@huawei.com>
In-Reply-To: <20240428-rss-v10-2-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
 <20240428-rss-v10-2-73cbaa91aeb6@daynix.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 28 Apr 2024 16:00:45 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> Since qemu_set_vnet_hdr_len() is always called when
> qemu_using_vnet_hdr() is called, we can merge them and save some code.
> 
> For consistency, express that the virtio-net header is not in use by
> returning 0 with qemu_get_vnet_hdr_len() instead of having a dedicated
> function, qemu_get_using_vnet_hdr().
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

With a simple e1000e test (silly configuration as I was just using
it as a placeholder for some pci tests) bisection led me to this
for a qemu segfault. Reverting this patch resolves it.

Much of this is probably irrelevant.. 

qemu-system-aarch64 \
    -M virt,ras=on,nvdimm=on,gic-version=3,hmat=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
 -kernel Image \
 -drive if=none,file=/mnt/d/images/full.qcow2,format=qcow2,id=hd \
 -device pcie-root-port,id=root_port1 \
 -device e1000e,bus=root_port1,id=rngtest0 \
 -device virtio-blk-pci,drive=hd \
 -nographic -no-reboot -append 'earlycon memblock=debug root=/dev/vda2 fsck.mode=skip maxcpus=4 tp_printk' \
 -bios QEMU_EFI.fd

I've not dug into why yet as in middle of some other debugging.

Jonathan


> ---
>  include/net/net.h   |  7 -------
>  hw/net/e1000e.c     |  1 -
>  hw/net/igb.c        |  1 -
>  hw/net/net_tx_pkt.c |  4 ++--
>  hw/net/virtio-net.c |  3 ---
>  hw/net/vmxnet3.c    |  2 --
>  net/dump.c          |  4 +---
>  net/net.c           | 24 +-----------------------
>  net/netmap.c        |  5 -----
>  net/tap.c           | 28 +---------------------------
>  10 files changed, 5 insertions(+), 74 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index b1f9b35fcca1..6fe5a0aee833 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -57,8 +57,6 @@ typedef bool (HasUfo)(NetClientState *);
>  typedef bool (HasUso)(NetClientState *);
>  typedef bool (HasVnetHdr)(NetClientState *);
>  typedef bool (HasVnetHdrLen)(NetClientState *, int);
> -typedef bool (GetUsingVnetHdr)(NetClientState *);
> -typedef void (UsingVnetHdr)(NetClientState *, bool);
>  typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
>  typedef int (GetVnetHdrLen)(NetClientState *);
>  typedef void (SetVnetHdrLen)(NetClientState *, int);
> @@ -88,10 +86,7 @@ typedef struct NetClientInfo {
>      HasUso *has_uso;
>      HasVnetHdr *has_vnet_hdr;
>      HasVnetHdrLen *has_vnet_hdr_len;
> -    GetUsingVnetHdr *get_using_vnet_hdr;
> -    UsingVnetHdr *using_vnet_hdr;
>      SetOffload *set_offload;
> -    GetVnetHdrLen *get_vnet_hdr_len;
>      SetVnetHdrLen *set_vnet_hdr_len;
>      SetVnetLE *set_vnet_le;
>      SetVnetBE *set_vnet_be;
> @@ -194,8 +189,6 @@ bool qemu_has_ufo(NetClientState *nc);
>  bool qemu_has_uso(NetClientState *nc);
>  bool qemu_has_vnet_hdr(NetClientState *nc);
>  bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
> -bool qemu_get_using_vnet_hdr(NetClientState *nc);
> -void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
>  void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>                        int ecn, int ufo, int uso4, int uso6);
>  int qemu_get_vnet_hdr_len(NetClientState *nc);
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 7c6f6029518c..d0dde767f6aa 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -352,7 +352,6 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev, uint8_t *macaddr)
>      for (i = 0; i < s->conf.peers.queues; i++) {
>          nc = qemu_get_subqueue(s->nic, i);
>          qemu_set_vnet_hdr_len(nc->peer, sizeof(struct virtio_net_hdr));
> -        qemu_using_vnet_hdr(nc->peer, true);
>      }
>  }
>  
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 9b37523d6df8..1224c7ba8e38 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -349,7 +349,6 @@ igb_init_net_peer(IGBState *s, PCIDevice *pci_dev, uint8_t *macaddr)
>      for (i = 0; i < s->conf.peers.queues; i++) {
>          nc = qemu_get_subqueue(s->nic, i);
>          qemu_set_vnet_hdr_len(nc->peer, sizeof(struct virtio_net_hdr));
> -        qemu_using_vnet_hdr(nc->peer, true);
>      }
>  }
>  
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 2134a18c4c90..903238dca24d 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -578,7 +578,7 @@ static void net_tx_pkt_sendv(
>  {
>      NetClientState *nc = opaque;
>  
> -    if (qemu_get_using_vnet_hdr(nc->peer)) {
> +    if (qemu_get_vnet_hdr_len(nc->peer)) {
>          qemu_sendv_packet(nc, virt_iov, virt_iov_cnt);
>      } else {
>          qemu_sendv_packet(nc, iov, iov_cnt);
> @@ -808,7 +808,7 @@ static bool net_tx_pkt_do_sw_fragmentation(struct NetTxPkt *pkt,
>  
>  bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
>  {
> -    bool offload = qemu_get_using_vnet_hdr(nc->peer);
> +    bool offload = qemu_get_vnet_hdr_len(nc->peer);
>      return net_tx_pkt_send_custom(pkt, offload, net_tx_pkt_sendv, nc);
>  }
>  
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 58014a92ad19..f6112c0ac97d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3794,9 +3794,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  
>      peer_test_vnet_hdr(n);
>      if (peer_has_vnet_hdr(n)) {
> -        for (i = 0; i < n->max_queue_pairs; i++) {
> -            qemu_using_vnet_hdr(qemu_get_subqueue(n->nic, i)->peer, true);
> -        }
>          n->host_hdr_len = sizeof(struct virtio_net_hdr);
>      } else {
>          n->host_hdr_len = 0;
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 707487c63666..63a91877730d 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2091,8 +2091,6 @@ static void vmxnet3_net_init(VMXNET3State *s)
>      if (s->peer_has_vhdr) {
>          qemu_set_vnet_hdr_len(qemu_get_queue(s->nic)->peer,
>              sizeof(struct virtio_net_hdr));
> -
> -        qemu_using_vnet_hdr(qemu_get_queue(s->nic)->peer, 1);
>      }
>  
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> diff --git a/net/dump.c b/net/dump.c
> index 16073f245828..956e34a123c0 100644
> --- a/net/dump.c
> +++ b/net/dump.c
> @@ -154,10 +154,8 @@ static ssize_t filter_dump_receive_iov(NetFilterState *nf, NetClientState *sndr,
>                                         int iovcnt, NetPacketSent *sent_cb)
>  {
>      NetFilterDumpState *nfds = FILTER_DUMP(nf);
> -    int offset = qemu_get_using_vnet_hdr(nf->netdev) ?
> -                 qemu_get_vnet_hdr_len(nf->netdev) : 0;
>  
> -    dump_receive_iov(&nfds->ds, iov, iovcnt, offset);
> +    dump_receive_iov(&nfds->ds, iov, iovcnt, qemu_get_vnet_hdr_len(nf->netdev));
>      return 0;
>  }
>  
> diff --git a/net/net.c b/net/net.c
> index a2f0c828bbf2..bd51037ebfb0 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -529,24 +529,6 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
>      return nc->info->has_vnet_hdr_len(nc, len);
>  }
>  
> -bool qemu_get_using_vnet_hdr(NetClientState *nc)
> -{
> -    if (!nc || !nc->info->get_using_vnet_hdr) {
> -        return false;
> -    }
> -
> -    return nc->info->get_using_vnet_hdr(nc);
> -}
> -
> -void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
> -{
> -    if (!nc || !nc->info->using_vnet_hdr) {
> -        return;
> -    }
> -
> -    nc->info->using_vnet_hdr(nc, enable);
> -}
> -
>  void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>                            int ecn, int ufo, int uso4, int uso6)
>  {
> @@ -559,11 +541,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>  
>  int qemu_get_vnet_hdr_len(NetClientState *nc)
>  {
> -    if (!nc || !nc->info->get_vnet_hdr_len) {
> -        return 0;
> -    }
> -
> -    return nc->info->get_vnet_hdr_len(nc);
> +    return nc->vnet_hdr_len;
>  }
>  
>  void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
> diff --git a/net/netmap.c b/net/netmap.c
> index 241b27c8e973..297510e19088 100644
> --- a/net/netmap.c
> +++ b/net/netmap.c
> @@ -351,10 +351,6 @@ static bool netmap_has_vnet_hdr(NetClientState *nc)
>      return netmap_has_vnet_hdr_len(nc, sizeof(struct virtio_net_hdr));
>  }
>  
> -static void netmap_using_vnet_hdr(NetClientState *nc, bool enable)
> -{
> -}
> -
>  static void netmap_set_vnet_hdr_len(NetClientState *nc, int len)
>  {
>      NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
> @@ -393,7 +389,6 @@ static NetClientInfo net_netmap_info = {
>      .has_ufo = netmap_has_vnet_hdr,
>      .has_vnet_hdr = netmap_has_vnet_hdr,
>      .has_vnet_hdr_len = netmap_has_vnet_hdr_len,
> -    .using_vnet_hdr = netmap_using_vnet_hdr,
>      .set_offload = netmap_set_offload,
>      .set_vnet_hdr_len = netmap_set_vnet_hdr_len,
>  };
> diff --git a/net/tap.c b/net/tap.c
> index 72ae95894ff1..c848844955df 100644
> --- a/net/tap.c
e1> +++ b/net/tap.c
> @@ -262,13 +262,6 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
>      return tap_has_vnet_hdr(nc);
>  }
>  
> -static int tap_get_vnet_hdr_len(NetClientState *nc)
> -{
> -    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> -
> -    return s->host_vnet_hdr_len;
> -}
> -
>  static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
>  {
>      TAPState *s = DO_UPCAST(TAPState, nc, nc);
> @@ -280,23 +273,7 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
>  
>      tap_fd_set_vnet_hdr_len(s->fd, len);
>      s->host_vnet_hdr_len = len;
> -}
> -
> -static bool tap_get_using_vnet_hdr(NetClientState *nc)
> -{
> -    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> -
> -    return s->using_vnet_hdr;
> -}
> -
> -static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
> -{
> -    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> -
> -    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
> -    assert(!!s->host_vnet_hdr_len == using_vnet_hdr);
> -
> -    s->using_vnet_hdr = using_vnet_hdr;
> +    s->using_vnet_hdr = true;
>  }
>  
>  static int tap_set_vnet_le(NetClientState *nc, bool is_le)
> @@ -394,10 +371,7 @@ static NetClientInfo net_tap_info = {
>      .has_uso = tap_has_uso,
>      .has_vnet_hdr = tap_has_vnet_hdr,
>      .has_vnet_hdr_len = tap_has_vnet_hdr_len,
> -    .get_using_vnet_hdr = tap_get_using_vnet_hdr,
> -    .using_vnet_hdr = tap_using_vnet_hdr,
>      .set_offload = tap_set_offload,
> -    .get_vnet_hdr_len = tap_get_vnet_hdr_len,
>      .set_vnet_hdr_len = tap_set_vnet_hdr_len,
>      .set_vnet_le = tap_set_vnet_le,
>      .set_vnet_be = tap_set_vnet_be,
> 


