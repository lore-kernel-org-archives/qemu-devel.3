Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 16:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEW5I-0006Sb-BF; Mon, 12 May 2025 12:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uEU47-0001sR-Rx
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:23:35 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uEU45-0006Ru-3R
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=qh+lRui77WZENMrsntqCrGJBtJrIS5AcrJH3n8hQ+kI=; b=lXFFqf4JeB2+6MOf4OO88T124a
 28ncFqt1+8Q2Mge5V42Rp7kyYwbySVqPVW/ojk/C02Z03ApO6FPKu0PeAcidfkZkpTcZvcMuUnN4I
 FvJWEKmk/Wlxr2EH2p4fjNWqbIjhKKYBFeVXIqpKKPBFwg3xWtESCNjZVOyZnaOTZpIrliuZKX/Ni
 ly5DbPxdH9wfqtCP839IlH57nLnKKm056QwBTSCsTq7+2Rs2csSKAH5+7vMOh1APndZ8tUXtWUEUD
 ZyfXgYa0iF1qAfcJZ4KOGEtPl0zYFEsQS3+CYUb5AmdTkn4RONBgd5EI7aKSHBcWr3Fyky6OK40HX
 SgQ+619w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uEU3v-0003Kn-33; Mon, 12 May 2025 16:23:24 +0200
Received: from [85.195.247.12] (helo=[192.168.1.114])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <daniel@iogearbox.net>)
 id 1uEU3v-0005bm-2i; Mon, 12 May 2025 16:23:24 +0200
Message-ID: <e61edfd9-8979-4ef4-b1a5-28dfd802cba6@iogearbox.net>
Date: Mon, 12 May 2025 16:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af-xdp: Support pinned map path for AF_XDP sockets
To: Ilya Maximets <i.maximets@ovn.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
References: <20250508123436.461030-1-daniel@iogearbox.net>
 <f044b02b-3b7a-4a64-ab38-3298f96955a9@ovn.org>
 <0d7285c0-15dc-4dcd-9436-b9134f07242d@iogearbox.net>
 <18f6aae8-2fa2-4fb6-a518-67e982623a5e@ovn.org>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <18f6aae8-2fa2-4fb6-a518-67e982623a5e@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27635/Mon May 12 10:33:06 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 May 2025 12:32:55 -0400
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

On 5/12/25 2:03 PM, Ilya Maximets wrote:
> On 5/9/25 4:05 PM, Daniel Borkmann wrote:
>> On 5/9/25 12:53 AM, Ilya Maximets wrote:
>>> On 5/8/25 2:34 PM, Daniel Borkmann wrote:
>>>> Extend inhibit=on setting with the option to specify a pinned XSK map
>>>> path along with a starting index (default 0) to push the created XSK
>>>> sockets into. Example usage:
>>>>
>>>>     # ./build/qemu-system-x86_64 [...] \
>>>>       -netdev af-xdp,ifname=eth0,id=net0,mode=native,queues=2,inhibit=on,map-path=/sys/fs/bpf/foo,map-start-index=2
>>>>       -device virtio-net-pci,netdev=net0 [...]
>>>>
>>>> This is useful for the case where an existing XDP program with XSK map
>>>> is present on the AF_XDP supported phys device and the XSK map not yet
>>>> populated. Qemu will then push the XSK sockets into the specified map.
>>>
>>> Thanks for the patch!
>>>
>>> Could you, please, explain the use case a little more?  Is this patch
>>> aiming to improve usability?  Do you have a specific use case in mind?
>>
>> The use case we have is basically that the phys NIC has an XDP program
>> already attached which redirects into xsk map (e.g. installed from separate
>> control plane), the xsk map got pinned during that process into bpf fs,
>> and now qemu is launched, it creates the xsk sockets and then places them
>> into the map by gathering the map fd from the pinned bpf fs file.
> 
> OK.  That's what I thought.  Would be good to expand the commit message
> a bit explaining the use case.

Ack, I already adjusted locally. Planning to send v2 ~today with your feedback
incorporated. Much appreciated!

>>> The main idea behind 'inhibit' is that the qemu doesn't need to have a lot
>>> of privileges to use the pre-loaded program and the pre-created sockets.
>>> But creating the sockets and setting them into a map doesn't allow us to
>>> run without privileges, IIUC.  May be worth mentioning at least in the
>>> commit message.
>>
>> Yes, privileges for above use case are still needed. Will clarify in the
>> description.
> 
> OK.
> 
>>> Also, isn't map-start-index the same thing as start-queue ?  Do we need
>>> both of them?
>>
>> I'd say yes given it does not have to be an exact mapping wrt queue index
>> to map slot. The default is 0 though and I expect this to be the most used
>> scenario.
> 
> I'm still not sure about this.  For example, libxdp treats queue id as a map
> index.  And this value is actually not being used much in libxdp when the
> program load is inhibited.  I see that with a custom XDP program the indexes
> inside the map may not directly correspond to queues in the device, and, in
> fact, may have no relation to the actual queues in the device at all.

Right, that's correct.

> However, we're still calling them "queues" from the QEMU interface (as in the
> "queues" parameter of the net/af-xdp device), and QEMU will just treat every
> slot in the BPF map as separate queues, as this BPF map is essentially the
> network device that QEMU is working with, it doesn't actually know what's
> behind it.
> 
> So, I think, it should be appropriate to simplify the interface and
> just use existing start-queue configuration knob for this.
> 
> What do you think?

I was thinking of an example like the below (plainly taken from the XDP example
programs at github.com/xdp-project/bpf-examples).

   struct {
	__uint(type, BPF_MAP_TYPE_XSKMAP);
	__uint(max_entries, MAX_SOCKS);
	__uint(key_size, sizeof(int));
	__uint(value_size, sizeof(int));
   } xsks_map SEC(".maps");

   int num_socks = 0;
   static unsigned int rr;

   SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
   {
	rr = (rr + 1) & (num_socks - 1);
	return bpf_redirect_map(&xsks_map, rr, XDP_DROP);
   }

If we'd just reuse the start-queue configuration knob for this, then it wouldn't
work. So I think having the flexibility of where to place the sockets in the map
would make sense. But I can also drop that part of you think it does not warrant
the extra knob and align to start-queue then the map always needs to be of the
same size as the combined NIC queues.

>>> I didn't read much into the code yet, but this patch is missing a few
>>> bits of documentation, e.g. it's missing an update for qemu-options.hx.
>>>
>>> See a few other quick comment below.
>>
>> Thanks a lot for the review, appreciate it!
>>
>>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>> Cc: Ilya Maximets <i.maximets@ovn.org>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: Anton Protopopov <aspsk@isovalent.com>
>>>> ---
>>>>    net/af-xdp.c  | 63 +++++++++++++++++++++++++++++++++++++++++++++------
>>>>    qapi/net.json | 24 +++++++++++++-------
>>>>    2 files changed, 72 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/net/af-xdp.c b/net/af-xdp.c
>>>> index 01c5fb914e..ddc52f1307 100644
>>>> --- a/net/af-xdp.c
>>>> +++ b/net/af-xdp.c
>>>> @@ -51,6 +51,8 @@ typedef struct AFXDPState {
>>>>    
>>>>        uint32_t             n_queues;
>>>>        uint32_t             xdp_flags;
>>>> +    char                 *map_path;
>>>> +    uint32_t             map_start_index;
>>>>        bool                 inhibit;
>>>>    } AFXDPState;
>>>>    
>>>> @@ -261,6 +263,7 @@ static void af_xdp_send(void *opaque)
>>>>    static void af_xdp_cleanup(NetClientState *nc)
>>>>    {
>>>>        AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
>>>> +    int pin_fd, idx;
>>>>    
>>>>        qemu_purge_queued_packets(nc);
>>>>    
>>>> @@ -282,6 +285,22 @@ static void af_xdp_cleanup(NetClientState *nc)
>>>>                    "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
>>>>                    s->ifname, s->ifindex);
>>>>        }
>>>> +    if (s->map_path) {
>>>> +        pin_fd = bpf_obj_get(s->map_path);
>>>> +        if (pin_fd < 0) {
>>>> +            fprintf(stderr,
>>>> +                "af-xdp: unable to remove %s's XSK sockets from '%s', ifindex: %d\n",
>>>> +                s->ifname, s->map_path, s->ifindex);
>>>> +        } else {
>>>> +            idx = nc->queue_index;
>>>> +            if (s->map_start_index > 0) {
>>>> +                idx += s->map_start_index;
>>>> +            }
>>>> +            bpf_map_delete_elem(pin_fd, &idx);
>>>> +            close(pin_fd);
>>>> +        }
>>>> +    }
>>>> +    g_free(s->map_path);
>>>>    }
>>>>    
>>>>    static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
>>>> @@ -343,7 +362,7 @@ static int af_xdp_socket_create(AFXDPState *s,
>>>>            .bind_flags = XDP_USE_NEED_WAKEUP,
>>>>            .xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST,
>>>>        };
>>>> -    int queue_id, error = 0;
>>>> +    int queue_id, pin_fd, xsk_fd, idx, error = 0;
>>>>    
>>>>        s->inhibit = opts->has_inhibit && opts->inhibit;
>>>>        if (s->inhibit) {
>>>> @@ -384,6 +403,23 @@ static int af_xdp_socket_create(AFXDPState *s,
>>>>            }
>>>>        }
>>>>    
>>>> +    if (!error && s->map_path) {
>>>> +        pin_fd = bpf_obj_get(s->map_path);
>>>> +        if (pin_fd < 0) {
>>>> +            error = errno;
>>>> +        } else {
>>>> +	    xsk_fd = xsk_socket__fd(s->xsk);
>>>
>>> Indentation is off.  Tbas mixed with spaces here and in some other
>>> places in the patch.
>>
>> Sigh, sorry, will fix (editor was set up for kernel style).
> 
> You can use ./scripts/checkpatch.pl to catch this kind of issues.
> 
>>>> +            idx = s->nc.queue_index;
>>>> +            if (s->map_start_index) {
>>>> +                idx += s->map_start_index;
>>>> +            }
>>>> +            if (bpf_map_update_elem(pin_fd, &idx, &xsk_fd, 0)) {
>>>> +                error = errno;
>>>> +            }
>>>> +            close(pin_fd);
>>>> +        }
>>>> +    }
>>>> +
>>>>        if (error) {
>>>>            error_setg_errno(errp, error,
>>>>                             "failed to create AF_XDP socket for %s queue_id: %d",
>>>> @@ -465,8 +501,8 @@ int net_init_af_xdp(const Netdev *netdev,
>>>>            return -1;
>>>>        }
>>>>    
>>>> -    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
>>>> -        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
>>>> +    if ((opts->has_inhibit && opts->inhibit) != !!(opts->sock_fds || opts->map_path)) {
>>>> +        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path' and vice versa");
>>>
>>> This may need some re-wording as 'A requires B or C or vice versa' is
>>> a little hard to understand.
>>
>> ack, will do
>>
>>>>            return -1;
>>>>        }
>>>>    
>>>> @@ -491,6 +527,12 @@ int net_init_af_xdp(const Netdev *netdev,
>>>>            pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>>>>            s->ifindex = ifindex;
>>>>            s->n_queues = queues;
>>>> +        if (opts->map_path) {
>>>> +            s->map_path = g_strdup(opts->map_path);
>>>> +            if (opts->has_map_start_index && opts->map_start_index > 0) {
>>>> +                s->map_start_index = opts->map_start_index;
>>>> +            }
>>>> +        }
>>>>    
>>>>            if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
>>>>                || af_xdp_socket_create(s, opts, errp)) {
>>>> @@ -504,10 +546,17 @@ int net_init_af_xdp(const Netdev *netdev,
>>>>        if (nc0) {
>>>>            s = DO_UPCAST(AFXDPState, nc, nc0);
>>>>            if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
>>>> -            error_setg_errno(errp, errno,
>>>> -                             "no XDP program loaded on '%s', ifindex: %d",
>>>> -                             s->ifname, s->ifindex);
>>>> -            goto err;
>>>> +            if (!s->map_path) {
>>>> +                error_setg_errno(errp, errno,
>>>> +                                 "no XDP program loaded on '%s', ifindex: %d",
>>>> +                                 s->ifname, s->ifindex);
>>>> +                goto err;
>>>> +	    } else {
>>>> +                warn_report("no XDP program loaded on '%s', ifindex: %d, "
>>>> +			    "only %"PRIi64" XSK socket%s loaded into map %s at this point",
>>>> +			    s->ifname, s->ifindex, queues, queues > 1 ? "s" : "",
>>>> +			    s->map_path);
>>>
>>> How a missing program is not an error?  Seems strange.
>>
>> Just the xsk map could be populated with the xsk sockets from qemu, but not
>> yet attached through XDP to the NIC.
> 
> OK, I see.  Yeah, that makes sense.  But shouldn't that be true for all the
> cases where we do not have direct control over the program loading, i.e. all
> the cases with inhibit=on ?

Agree, makes sense to rather switch it to inhibit=on test.

>>>> +            }
>>>>            }
>>>>        }
>>>>    
>>>> diff --git a/qapi/net.json b/qapi/net.json
>>>> index 310cc4fd19..c750b805e8 100644
>>>> --- a/qapi/net.json
>>>> +++ b/qapi/net.json
>>>> @@ -454,7 +454,7 @@
>>>>    #     (default: 0).
>>>>    #
>>>>    # @inhibit: Don't load a default XDP program, use one already loaded
>>>> -#     to the interface (default: false).  Requires @sock-fds.
>>>> +#     to the interface (default: false).  Requires @sock-fds or @map-path.
>>>>    #
>>>>    # @sock-fds: A colon (:) separated list of file descriptors for
>>>>    #     already open but not bound AF_XDP sockets in the queue order.
>>>> @@ -462,17 +462,25 @@
>>>>    #     into XDP socket map for corresponding queues.  Requires
>>>>    #     @inhibit.
>>>>    #
>>>> +# @map-path: The path to a pinned xsk map to push file descriptors
>>>> +#     for bound AF_XDP sockets into. Requires @inhibit.
>>>> +#
>>>> +# @map-start-index: Use @map-path to insert xsk sockets starting from
>>>> +#     this index number (default: 0). Requires @map-path.
>>>
>>> These are new fields that do not exist in the older versions, so
>>> they will need their own 'since' qualifiers.
>>
>> Oh didn't know that there's a section for each version, will do.
>>
>>>> +#
>>>>    # Since: 8.2
>>>>    ##
>>>>    { 'struct': 'NetdevAFXDPOptions',
>>>>      'data': {
>>>> -    'ifname':       'str',
>>>> -    '*mode':        'AFXDPMode',
>>>> -    '*force-copy':  'bool',
>>>> -    '*queues':      'int',
>>>> -    '*start-queue': 'int',
>>>> -    '*inhibit':     'bool',
>>>> -    '*sock-fds':    'str' },
>>>> +    'ifname':           'str',
>>>> +    '*mode':            'AFXDPMode',
>>>> +    '*force-copy':      'bool',
>>>> +    '*queues':          'int',
>>>> +    '*start-queue':     'int',
>>>> +    '*inhibit':         'bool',
>>>> +    '*sock-fds':        'str',
>>>> +    '*map-path':        'str',
>>>> +    '*map-start-index': 'int' },
>>>>      'if': 'CONFIG_AF_XDP' }
>>>>    
>>>>    ##
>>>
>>
> 


