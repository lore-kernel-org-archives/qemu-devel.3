Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47354606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=gzzywfM3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO6OK-00017j-OP; Mon, 02 Nov 2026 23:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xO6OI-00017M-Ml
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 23:44:58 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xO6OG-0005Z3-3M
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 23:44:58 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A34iXgT091236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Nov 2026 13:44:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=m7f/ipSQL1jXTAl72JfifN5OF104GMgtD/RgUgxoqzE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793681074; v=1;
 b=gzzywfM3FET2amdzpfj2O2meaKj1ZjI6eKhBOzduFBM79Gdb7uILIWDz96F9juKy
 e3xNqQrKfhRPZRiqOxG16hbJLUC6Lw6Yas9DUA92x0QKQqSbcCHnV34tV23/QFeU
 puWQbFVM2FC6gwk/agTjqFsPaoFUUM9AyngD37ak5zXSaxLttcKUfJs3ty8UGp6a
 OL8U+eM0Zcy4Xmri5bn3M3OC4I/CuO7fx10YsPwzXfKPFRaS3GJQVF8IJtCSubR9
 EPk5ZObJ+AU0QD3DHJbm/FYulKFHhYLL6dOsBDAMl3qH7pTQI4e2hJX2mTFoZklY
 aqrhrvyaMudzyJhIytvmuQ==
Message-ID: <ac5b6410-3f96-40fa-b9d8-99ac25f8648f@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Nov 2026 13:44:33 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: Set do_not_pad for net backends
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
 <20261027174625.4025878-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261027174625.4025878-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/10/28 2:46, Peter Maydell wrote:
> Currently our handling of short network packets (i.e.  those which
> are smaller than the minimum ethernet frame size of 60 bytes) is a
> little confused.  The intention is that we allow network device
> models to transmit short packets, but we protect them from having to
> deal with receiving short packets unless they explicitly opt into it.
> This means we don't have to have a lot of code in each network device
> to try to handle the short packet size -- historically that code was
> untested, and often a source of "carefully crafted packet can cause
> an out-of-bounds memory access" bugs.
> 
> Our implementation of the padding is currently done when each network
> backend feeds a packet into the system via one of the
> qemu_send_packet family of functions.  This mostly works, except that
> we missed some of the more obscure backends (e.g.  the socket
> backend), and it means code duplication in each backend.  We'd like
> to switch to making qemu_send_packet do the padding itself.  To do
> that, we first need to make sure that all the NetClientState
> implementations which do not want padding set the do_not_pad flag.
> We do this by setting the flag for NetClientState instances created
> by qemu_new_net_client() and qemu_new_net_control_client().  Emulated
> network devices use qemu_new_nic(), which does not set the flag.
> 
> Note that this also causes the net/hub client to request no padding.
> This is the right behaviour: we want the hub to accept short packets
> and forward them on to all destinations.  Each destination then gets
> to choose whether it sees a padded packet or the short one.  The
> hub.c code is length-agnostic and doesn't look inside the packets it
> is passing on, so it has no issues with short packets.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/net/net.h |  3 ++-
>   net/net.c         | 10 ++++++----
>   net/tap.c         |  2 +-
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index fdf6a2ddd44..3c5b99c806e 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -169,7 +169,8 @@ void qemu_net_client_setup(NetClientState *nc,
>                              const char *model,
>                              const char *name,
>                              NetClientDestructor *destructor,
> -                           bool is_datapath);
> +                           bool is_datapath,
> +                           bool do_not_pad);
>   NetClientState *qemu_new_net_client(NetClientInfo *info,
>                                       NetClientState *peer,
>                                       const char *model,
> diff --git a/net/net.c b/net/net.c
> index d7fa637ce51..1042a9d3a8e 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -267,7 +267,8 @@ void qemu_net_client_setup(NetClientState *nc,
>                              const char *model,
>                              const char *name,
>                              NetClientDestructor *destructor,
> -                           bool is_datapath)
> +                           bool is_datapath,
> +                           bool do_not_pad)
>   {
>       nc->info = info;
>       nc->model = g_strdup(model);
> @@ -287,6 +288,7 @@ void qemu_net_client_setup(NetClientState *nc,
>       nc->incoming_queue = qemu_new_net_queue(qemu_deliver_packet_iov, nc);
>       nc->destructor = destructor;
>       nc->is_datapath = is_datapath;
> +    nc->do_not_pad = do_not_pad;
>       QTAILQ_INIT(&nc->filters);
>   }
>   
> @@ -301,7 +303,7 @@ NetClientState *qemu_new_net_client(NetClientInfo *info,
>   
>       nc = g_malloc0(info->size);
>       qemu_net_client_setup(nc, info, peer, model, name,
> -                          qemu_net_client_destructor, true);
> +                          qemu_net_client_destructor, true, true);

This changes hub ports, suppressing existing backend padding before 
patch 3 adds padding to hub forwarding. So a 42-byte frame may reach the 
NIC as 60 bytes at base, 42 after this patch, and 60 after patch 3. 
Perhaps this patch and patch 3 may be squashed.

Regards,
Akihiko Odaki

>   
>       return nc;
>   }
> @@ -317,7 +319,7 @@ NetClientState *qemu_new_net_control_client(NetClientInfo *info,
>   
>       nc = g_malloc0(info->size);
>       qemu_net_client_setup(nc, info, peer, model, name,
> -                          qemu_net_client_destructor, false);
> +                          qemu_net_client_destructor, false, true);
>   
>       return nc;
>   }
> @@ -344,7 +346,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
>   
>       for (i = 0; i < queues; i++) {
>           qemu_net_client_setup(&nic->ncs[i], info, peers[i], model, name,
> -                              NULL, true);
> +                              NULL, true, false);
>           nic->ncs[i].queue_index = i;
>       }
>   
> diff --git a/net/tap.c b/net/tap.c
> index d71e3dd1175..ada69a21021 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -620,7 +620,7 @@ static TAPState *new_tap(NetClientState *peer,
>       TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
>   
>       qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
> -                          tap_net_client_destructor, true);
> +                          tap_net_client_destructor, true, true);
>   
>       s->queue_index = queue_index;
>   


