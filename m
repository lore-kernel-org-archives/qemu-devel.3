Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DE3C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 13:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzu6-0004NG-1D; Fri, 30 May 2025 09:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uKzu2-0004Mq-6y
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:36:07 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uKzty-0007nt-Nf
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=uKYhjqwv5850TTltY/0GkwfhiFu3WhrP0UdgJOI2jao=; b=FVkC7O1KqgJgIPyN0aOTlOekbl
 BH/upCcqpOBG9waSynCdhydl2mA2FiUA2xBrbTFK2xgYWKXNO16ubxw7hHeTsuoMquf05Xy1vcmTs
 8E4UjXnxMCsjAShzwavUQ8efUqeb4+WID70VsETpH4HavFMWPiHmf5GkyfDdTPwQ2xBaj8EXAedWJ
 Qc9riDZliIFlHSg6CUBfUD8x67lMBiYOK43iKx5AEMOLhauEWAhV5Gw/E6YgGkucf1sIg3WbHfiPQ
 GW4VjfBoyH4tG6YjXKkpR1ykKVRCmlzu0dcJbgSA6lxTO6dq8RRWhtEYP+UEDXf2KGhRRArkUZ2qj
 wDhGYdmQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uKztq-00035p-0m; Fri, 30 May 2025 15:35:54 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <daniel@iogearbox.net>)
 id 1uKztp-00038w-1k; Fri, 30 May 2025 15:35:54 +0200
Message-ID: <7bc6fe2e-4ee0-4f68-be11-41fd5d06b405@iogearbox.net>
Date: Fri, 30 May 2025 15:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/af-xdp: Support pinned map path for AF_XDP sockets
To: Ilya Maximets <i.maximets@ovn.org>, qemu-devel@nongnu.org
Cc: Anton Protopopov <aspsk@isovalent.com>
References: <20250512160621.550062-1-daniel@iogearbox.net>
 <61e3c8f5-623d-4480-9ed4-5d7a897c2a02@ovn.org>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <61e3c8f5-623d-4480-9ed4-5d7a897c2a02@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27653/Fri May 30 10:36:57 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Daniel Borkmann <daniel@iogearbox.net>
From:  Daniel Borkmann via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Ilya,

On 5/27/25 10:51 PM, Ilya Maximets wrote:
> On 5/12/25 6:06 PM, Daniel Borkmann wrote:
>> Extend 'inhibit=on' setting with the option to specify a pinned XSK map
>> path along with a starting index (default 0) to push the created XSK
>> sockets into. Example usage:
>>
>>    # ./build/qemu-system-x86_64 [...] \
>>     -netdev af-xdp,ifname=enp2s0f0np0,id=net0,mode=native,queues=2,start-queue=14,inhibit=on,map-path=/sys/fs/bpf/xsks_map,map-start-index=14 \
>>     -device virtio-net-pci,netdev=net0 [...]
>>
>> This is useful for the case where an existing XDP program with XSK map
>> is present on the AF_XDP supported phys device and the XSK map is not
>> yet populated. For example, the former could have been pre-loaded onto
>> the netdevice by a control plane, which later launches qemu to populate
>> it with XSK sockets.
>>
>> Normally, the main idea behind 'inhibit=on' is that the qemu instance
>> doesn't need to have a lot of privileges to use the pre-loaded program
>> and the pre-created sockets, but this mentioned use-case here is different
>> where qemu still needs privileges to create the sockets.
>>
>> The 'map-start-index' parameter is optional and defaults to 0. It allows
>> flexible placement of the XSK sockets, and is up to the user to specify
>> when the XDP program with XSK map was already preloaded. In the simplest
>> case the queue-to-map-slot mapping is just 1:1 based on ctx->rx_queue_index
>> but the user might as well have a different scheme (or smaller map size,
>> e.g. ctx->rx_queue_index % max_size) to push the inbound traffic to one
>> of the XSK sockets.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Ilya Maximets <i.maximets@ovn.org>
>> Cc: Anton Protopopov <aspsk@isovalent.com>
>> ---
>>   net/af-xdp.c    | 65 +++++++++++++++++++++++++++++++++++++++++++------
>>   qapi/net.json   | 24 ++++++++++++------
>>   qemu-options.hx |  3 +++
>>   3 files changed, 77 insertions(+), 15 deletions(-)
> 
> Hi, Daniel.  Thanks for v2 and sorry for delayed response.
> 
> I tried it out for myself and the change does indeed work as expected.
> And it's quite nice!  So I looked closely at the code this time.  See some
> comments below.

Thanks!

>> diff --git a/net/af-xdp.c b/net/af-xdp.c
>> index 01c5fb914e..494b894706 100644
>> --- a/net/af-xdp.c
>> +++ b/net/af-xdp.c
>> @@ -51,6 +51,8 @@ typedef struct AFXDPState {
>>   
>>       uint32_t             n_queues;
>>       uint32_t             xdp_flags;
>> +    char                 *map_path;
>> +    uint32_t             map_start_index;
>>       bool                 inhibit;
>>   } AFXDPState;
>>   
>> @@ -261,6 +263,7 @@ static void af_xdp_send(void *opaque)
>>   static void af_xdp_cleanup(NetClientState *nc)
>>   {
>>       AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
>> +    int pin_fd, idx;
>>   
>>       qemu_purge_queued_packets(nc);
>>   
>> @@ -282,6 +285,22 @@ static void af_xdp_cleanup(NetClientState *nc)
>>                   "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
>>                   s->ifname, s->ifindex);
>>       }
> 
> I'd add an empty line here.  The statements above and below are not
> really related.

Ack, will do.

>> +    if (s->map_path) {
>> +        pin_fd = bpf_obj_get(s->map_path);
>> +        if (pin_fd < 0) {
>> +            fprintf(stderr,
>> +                "af-xdp: unable to remove %s's XSK sockets from '%s', ifindex: %d\n",
>> +                s->ifname, s->map_path, s->ifindex);
> 
> Maybe it makes more sense to just not close it?  i.e. keep the open file
> descriptor in the AFXDPState and use and close it on cleanup.  This way we
> can be sure that the map doesn't just go away underneath us and so we can
> guarantee a proper cleanup.  WDYT?
> 
> Also, the ifindex isn't really part of this operation, so it may be
> reasonable to not print it here saving some line length.

Ok, ack, I thought we don't need to waste / occupy an extra fd given VM can keep
running for a long time, but I don't have a strong opinion. I'll keep it around
for v3.

>> +        } else {
>> +            idx = nc->queue_index;
>> +            if (s->map_start_index > 0) {
> 
> Should probably check the has_ just in case.

I don't think we need the extra test since we already do it earlier, but for v3
I reworked the logic a bit anyway and removed the test.

>> +                idx += s->map_start_index;
>> +            }
>> +            bpf_map_delete_elem(pin_fd, &idx);
> 
> The uAPI says that this call can also fail.  We should warn the user about
> this failure.

Nothing we can do about it aside from warning, ok, will add.

>> +            close(pin_fd);
>> +        }
>> +    }
>> +    g_free(s->map_path);
>>   }
>>   
>>   static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
>> @@ -343,7 +362,7 @@ static int af_xdp_socket_create(AFXDPState *s,
>>           .bind_flags = XDP_USE_NEED_WAKEUP,
>>           .xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST,
>>       };
>> -    int queue_id, error = 0;
>> +    int queue_id, pin_fd, xsk_fd, idx, error = 0;
>>   
>>       s->inhibit = opts->has_inhibit && opts->inhibit;
>>       if (s->inhibit) {
>> @@ -384,6 +403,23 @@ static int af_xdp_socket_create(AFXDPState *s,
>>           }
>>       }
>>   
>> +    if (!error && s->map_path) {
>> +        pin_fd = bpf_obj_get(s->map_path);
>> +        if (pin_fd < 0) {
>> +            error = errno;
>> +        } else {
>> +            xsk_fd = xsk_socket__fd(s->xsk);
>> +            idx = s->nc.queue_index;
>> +            if (s->map_start_index) {
>> +                idx += s->map_start_index;
>> +            }
>> +            if (bpf_map_update_elem(pin_fd, &idx, &xsk_fd, 0)) {
>> +                error = errno;
>> +            }
>> +            close(pin_fd);
>> +        }
>> +    }
>> +
> 
> This part doesn't seem to belong in this function.  It may be better if we
> just create sockets here and create a separate function af_xdp_update_bpf_map
> or something like that and call it from the main net_init_af_xdp.
> 
> Main reasons for that are mostly related to the error path:
> 
> 1. The error message below is a bit misleading and doesn't really tell what
>     happened.  For example, if the map_path is incorrect, then we get:
>       "failed to create AF_XDP socket ... : No such path or directory".
>     There is no mention of the map path that we tried to open and failed and
>     the information is kinda wrong as we did actually create the socket.
> 
> 2. It's better if have xdp_flags properly initialized when the socket is
>     actually created and not error out of this function early.  This may not
>     matter today, but seems cleaner and may save us from some headaches in
>     the future.

Ok, will refactor and move it out.

>>       if (error) {
>>           error_setg_errno(errp, error,
>>                            "failed to create AF_XDP socket for %s queue_id: %d",
>> @@ -465,8 +501,12 @@ int net_init_af_xdp(const Netdev *netdev,
>>           return -1;
>>       }
>>   
>> -    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
>> -        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
>> +    if ((opts->has_inhibit && opts->inhibit) != !!(opts->sock_fds || opts->map_path)) {
>> +        if (opts->has_inhibit && opts->inhibit) {
>> +            error_setg(errp, "'inhibit=on' requires setting 'sock-fds' or 'map-path'");
>> +        } else {
>> +            error_setg(errp, "'sock-fds' or 'map-path' requires setting 'inhibit=on'");
>> +        }
>>           return -1;
>>       }
> 
> This is getting a little hard to navigate even after the re-wording, I think.
> And we also need to cover more cases now.  So, I'd suggest to just bite the
> bullet and spell out every case separately, e.g.:
> 
>      inhibit = opts->has_inhibit && opts->inhibit;
>      if (inhibit && !opts->sock_fds && !opts->map_path) {
>          error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
>          return -1;
>      }
>      if (!inhibit && (opts->sock_fds || opts->map_path)) {
>          error_setg(errp, "'sock-fds' and 'map-path' require 'inhibit=on'");
>          return -1;
>      }
>      if (opts->sock_fds && opts->map_path) {
>          error_setg(errp, "'sock-fds' and 'map-path' are mutually exclusive");
>          return -1;
>      }
> 
> This should be easier to understand and also saves some line lengths.  WDYT?
> 
> The exclusivity check here is because we expect the file descriptors in the
> sock-fds to be already in the map.  It would be an awkward configuration if
> we have the fds and the map, so it might be better to just prohibit this.

The combination of both will semlessly work however, so even if you pass in
the sockets, then the internal logic will skip creation and we can still push
them into the specified map. So technically there isn't really a reason to
restrict them to mutually exclusive. But I can adapt the code to the above
either way if that's the preference since we don't have a use-case today for
having both passed-in.

> We'll also need a check that map-start-index requires the map-path.

Will add.

>> @@ -491,6 +531,12 @@ int net_init_af_xdp(const Netdev *netdev,
>>           pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>>           s->ifindex = ifindex;
>>           s->n_queues = queues;
> 
> I'd put an empty line here.
> 
>> +        if (opts->map_path) {
> 
> This check doesn't seem necessary, g_strdup is NULL-safe.
> 
>> +            s->map_path = g_strdup(opts->map_path);
>> +            if (opts->has_map_start_index && opts->map_start_index > 0) {
>> +                s->map_start_index = opts->map_start_index;
>> +            }
>> +        }
>>   
>>           if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
>>               || af_xdp_socket_create(s, opts, errp)) {
>> @@ -504,10 +550,15 @@ int net_init_af_xdp(const Netdev *netdev,
>>       if (nc0) {
>>           s = DO_UPCAST(AFXDPState, nc, nc0);
>>           if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
>> -            error_setg_errno(errp, errno,
>> -                             "no XDP program loaded on '%s', ifindex: %d",
>> -                             s->ifname, s->ifindex);
>> -            goto err;
>> +            if (!s->inhibit) {
> 
> The s->inhibit is set as a side effect of af_xdp_socket_create().  It was a right
> decision when the socket creation and the cleanup were the only users.  But since
> we're using it now here, we should move setting of this value to the loop above.

Yeap, ack, coming in v3. Btw, I'm also considering to actually remove the warn
below and only leave the error case for !s->inhibit as this decision is completely
delegated to users. The XDP loading can just as well happen afterwards.

>> +                error_setg_errno(errp, errno,
>> +                                 "no XDP program loaded on '%s', ifindex: %d",
>> +                                 s->ifname, s->ifindex);
>> +                goto err;
>> +            } else {
>> +                warn_report("no XDP program loaded yet on '%s', ifindex: %d",
>> +                            s->ifname, s->ifindex);
>> +            }
>>           }
>>       }
>>   
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 310cc4fd19..66a1fcf6ae 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -454,7 +454,7 @@
>>   #     (default: 0).
>>   #
>>   # @inhibit: Don't load a default XDP program, use one already loaded
>> -#     to the interface (default: false).  Requires @sock-fds.
>> +#     to the interface (default: false).  Requires @sock-fds or @map-path.
>>   #
>>   # @sock-fds: A colon (:) separated list of file descriptors for
>>   #     already open but not bound AF_XDP sockets in the queue order.
>> @@ -462,17 +462,25 @@
>>   #     into XDP socket map for corresponding queues.  Requires
>>   #     @inhibit.
>>   #
>> +# @map-path: The path to a pinned xsk map to push file descriptors
>> +#     for bound AF_XDP sockets into. Requires @inhibit. (Since 10.1)
>> +#
>> +# @map-start-index: Use @map-path to insert xsk sockets starting from
>> +#     this index number (default: 0). Requires @map-path. (Since 10.1)
> 
> The doc uses double spaces between sentences.  Also, may mention that
> map-path and sock-fds are mutually exclusive.  For both options.

Ok.

>> +#
>>   # Since: 8.2
>>   ##
>>   { 'struct': 'NetdevAFXDPOptions',
>>     'data': {
>> -    'ifname':       'str',
>> -    '*mode':        'AFXDPMode',
>> -    '*force-copy':  'bool',
>> -    '*queues':      'int',
>> -    '*start-queue': 'int',
>> -    '*inhibit':     'bool',
>> -    '*sock-fds':    'str' },
>> +    'ifname':           'str',
>> +    '*mode':            'AFXDPMode',
>> +    '*force-copy':      'bool',
>> +    '*queues':          'int',
>> +    '*start-queue':     'int',
>> +    '*inhibit':         'bool',
>> +    '*sock-fds':        'str',
>> +    '*map-path':        'str',
>> +    '*map-start-index': 'int' },
>>     'if': 'CONFIG_AF_XDP' }
>>   
>>   ##
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index dc694a99a3..50fc592f5d 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2909,6 +2909,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>   #ifdef CONFIG_AF_XDP
>>       "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
>>       "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
>> +    "         [,map-path=/path/to/socket/map][,map-start-index=i]\n"
>>       "                attach to the existing network interface 'name' with AF_XDP socket\n"
>>       "                use 'mode=MODE' to specify an XDP program attach mode\n"
>>       "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
>> @@ -2916,6 +2917,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>       "                with inhibit=on,\n"
>>       "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
>>       "                  added to a socket map in XDP program.  One socket per queue.\n"
>> +    "                  use 'map-path' to provide the socket map location to populate AF_XDP sockets with\n"
>> +    "                  beginning from the 'map-start-index' specified index (default: 0) (Since 10.1)\n"
>>       "                use 'queues=n' to specify how many queues of a multiqueue interface should be used\n"
>>       "                use 'start-queue=m' to specify the first queue that should be used\n"
>>   #endif
> 
> There is another section below with all the options listed and some
> examples.  It will need an update.  Not sure if we need an example

Thanks, will add!

> for this new use case, but if you can make a small one with just
> using bpftool, that maight be useful.

Full blown example is a bit more involved, so likely won't fit since we also need
all the other pieces (example C code, build, BPF skeleton) which mostly !inhibit
does in the background.

Thanks,
Daniel

