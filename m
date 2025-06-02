Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7085BC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2Lo-00075R-K6; Mon, 02 Jun 2025 06:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uM2Ll-00074w-6B
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:25:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uM2Li-0005xe-1I
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:25:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so45664285e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 03:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748859896; x=1749464696;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8ic5XirRqb4XZiGcDrqBD/qOk5zxCb+sVUh+RN9QB0=;
 b=LayUnfebLLLPByJzXXmPxnuxIC9f+ZJ8jpi+HrhKhvGribVhwqYuD5LLtK7hDNHqZR
 VHjYEiZMdJH5fOkNyywZ4wLdb1ZdNxo/MKV1XpyZpEaA2FU3JoKQIzxC32KceCbOg2Qj
 t3ofm4RM31Y4r5YxxR77wLA50ZtobbHsL4AFHme9bbIAUlxRWn1HFO8C8rvVZ0bnnjrJ
 oIwZ/322RZ6jq0340wRlEwOzTT3DYUZ2g1jolh/bK1+JlTZXN0i8XfpltEk6WcC6gWZN
 PUzu+v1uAvjLuWwdjuNI3CbGFwW/3q4R6Kju9pzFiHBlchhkBQHzfcWTdmsgLmcm5TxC
 VoZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoS5uzYD4aqyqu4iD9IR8gLfQjHXj/9GKMm0HRO5XxCmXmU0UB0mz9FubqBplteLtwp2SFIvPg1vZ4@nongnu.org
X-Gm-Message-State: AOJu0Yydvo/LA6GU64vMa246aULs/QAy+7Uzda3hkpgWVJLkq3tEPfJY
 bsK6MNOdSO4qhlwYRrMfYkMY11q+7aObOtwm1Ztpwj2Q1QfT3zeEFfZu
X-Gm-Gg: ASbGncvigwRzf6FQwJT8NyiYGY9tvD3WEvdWPqD6prCugXxGjcm3qkZB+y2GU0lbR+Y
 n/Gndlo5JBwMRo/WoOeV2u7r3K7EHAhfQxuG7061X/PVwFSPpuj/eYNDJw9uVY2dxaKCfG1r1mu
 M4CrWxVYB1QVGEfDRKyDLhb/GMTauKJWo5TbfXNi1IJfl3WnndKgZWRjobz/IohMWyA+AUsJcBK
 HpQH7bbbOYnaT2Wpi7/iDpTaQRn+Rd1/+4deijDmD33CyjZbXtwVxx0+ifh3YOLM4RvRKVILlwN
 sRT61UOM4JbFcAbGZe7sCC7EOXUuKi+Z8T+GyXClpOa/CSL6dDVIhYnVs3opCsy2YxQlOvzVZEl
 9AuW7m2OcHeeZDGU=
X-Google-Smtp-Source: AGHT+IEe1cSCu3JgEY/lJhBSKUaKx42cyLGU+lLMRyPlNMjnRBMOEi9a4iRxqGYBVDxIzpRoJxgBww==
X-Received: by 2002:a05:600c:4688:b0:43c:f8fc:f6a6 with SMTP id
 5b1f17b1804b1-450d64fcba2mr127739505e9.9.1748859895807; 
 Mon, 02 Jun 2025 03:24:55 -0700 (PDT)
Received: from [192.168.88.252] (37-48-2-229.nat.epc.tmcz.cz. [37.48.2.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa21e4sm119548335e9.11.2025.06.02.03.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 03:24:55 -0700 (PDT)
Message-ID: <1bdf8e28-139e-4f5d-8c9a-b7b7f0a47e34@ovn.org>
Date: Mon, 2 Jun 2025 12:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v2] net/af-xdp: Support pinned map path for AF_XDP sockets
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250512160621.550062-1-daniel@iogearbox.net>
 <61e3c8f5-623d-4480-9ed4-5d7a897c2a02@ovn.org>
 <7bc6fe2e-4ee0-4f68-be11-41fd5d06b405@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <7bc6fe2e-4ee0-4f68-be11-41fd5d06b405@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.67;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-wm1-f67.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/30/25 3:35 PM, Daniel Borkmann wrote:
> Hi Ilya,
> 
> On 5/27/25 10:51 PM, Ilya Maximets wrote:
>> On 5/12/25 6:06 PM, Daniel Borkmann wrote:
>>> Extend 'inhibit=on' setting with the option to specify a pinned XSK map
>>> path along with a starting index (default 0) to push the created XSK
>>> sockets into. Example usage:
>>>
>>>    # ./build/qemu-system-x86_64 [...] \
>>>     -netdev af-xdp,ifname=enp2s0f0np0,id=net0,mode=native,queues=2,start-queue=14,inhibit=on,map-path=/sys/fs/bpf/xsks_map,map-start-index=14 \
>>>     -device virtio-net-pci,netdev=net0 [...]
>>>
>>> This is useful for the case where an existing XDP program with XSK map
>>> is present on the AF_XDP supported phys device and the XSK map is not
>>> yet populated. For example, the former could have been pre-loaded onto
>>> the netdevice by a control plane, which later launches qemu to populate
>>> it with XSK sockets.
>>>
>>> Normally, the main idea behind 'inhibit=on' is that the qemu instance
>>> doesn't need to have a lot of privileges to use the pre-loaded program
>>> and the pre-created sockets, but this mentioned use-case here is different
>>> where qemu still needs privileges to create the sockets.
>>>
>>> The 'map-start-index' parameter is optional and defaults to 0. It allows
>>> flexible placement of the XSK sockets, and is up to the user to specify
>>> when the XDP program with XSK map was already preloaded. In the simplest
>>> case the queue-to-map-slot mapping is just 1:1 based on ctx->rx_queue_index
>>> but the user might as well have a different scheme (or smaller map size,
>>> e.g. ctx->rx_queue_index % max_size) to push the inbound traffic to one
>>> of the XSK sockets.
>>>
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Ilya Maximets <i.maximets@ovn.org>
>>> Cc: Anton Protopopov <aspsk@isovalent.com>
>>> ---
>>>   net/af-xdp.c    | 65 +++++++++++++++++++++++++++++++++++++++++++------
>>>   qapi/net.json   | 24 ++++++++++++------
>>>   qemu-options.hx |  3 +++
>>>   3 files changed, 77 insertions(+), 15 deletions(-)
>>
>> Hi, Daniel.  Thanks for v2 and sorry for delayed response.
>>
>> I tried it out for myself and the change does indeed work as expected.
>> And it's quite nice!  So I looked closely at the code this time.  See some
>> comments below.
> 
> Thanks!
> 
>>> diff --git a/net/af-xdp.c b/net/af-xdp.c
>>> index 01c5fb914e..494b894706 100644
>>> --- a/net/af-xdp.c
>>> +++ b/net/af-xdp.c
>>> @@ -51,6 +51,8 @@ typedef struct AFXDPState {
>>>   
>>>       uint32_t             n_queues;
>>>       uint32_t             xdp_flags;
>>> +    char                 *map_path;
>>> +    uint32_t             map_start_index;
>>>       bool                 inhibit;
>>>   } AFXDPState;
>>>   
>>> @@ -261,6 +263,7 @@ static void af_xdp_send(void *opaque)
>>>   static void af_xdp_cleanup(NetClientState *nc)
>>>   {
>>>       AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
>>> +    int pin_fd, idx;
>>>   
>>>       qemu_purge_queued_packets(nc);
>>>   
>>> @@ -282,6 +285,22 @@ static void af_xdp_cleanup(NetClientState *nc)
>>>                   "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
>>>                   s->ifname, s->ifindex);
>>>       }
>>
>> I'd add an empty line here.  The statements above and below are not
>> really related.
> 
> Ack, will do.
> 
>>> +    if (s->map_path) {
>>> +        pin_fd = bpf_obj_get(s->map_path);
>>> +        if (pin_fd < 0) {
>>> +            fprintf(stderr,
>>> +                "af-xdp: unable to remove %s's XSK sockets from '%s', ifindex: %d\n",
>>> +                s->ifname, s->map_path, s->ifindex);
>>
>> Maybe it makes more sense to just not close it?  i.e. keep the open file
>> descriptor in the AFXDPState and use and close it on cleanup.  This way we
>> can be sure that the map doesn't just go away underneath us and so we can
>> guarantee a proper cleanup.  WDYT?
>>
>> Also, the ifindex isn't really part of this operation, so it may be
>> reasonable to not print it here saving some line length.
> 
> Ok, ack, I thought we don't need to waste / occupy an extra fd given VM can keep
> running for a long time, but I don't have a strong opinion. I'll keep it around
> for v3.

IMO, the fact that qemu process will be running for a long time is exactly
the reason to keep this file open, as there is a higher chance for it to
disappear at some point.  Shouldn't be too bad, we have separate file
descriptors open per queue, so one more shouldn't be a big problem.

> 
>>> +        } else {
>>> +            idx = nc->queue_index;
>>> +            if (s->map_start_index > 0) {
>>
>> Should probably check the has_ just in case.
> 
> I don't think we need the extra test since we already do it earlier, but for v3
> I reworked the logic a bit anyway and removed the test.
> 
>>> +                idx += s->map_start_index;
>>> +            }
>>> +            bpf_map_delete_elem(pin_fd, &idx);
>>
>> The uAPI says that this call can also fail.  We should warn the user about
>> this failure.
> 
> Nothing we can do about it aside from warning, ok, will add.
> 
>>> +            close(pin_fd);
>>> +        }
>>> +    }
>>> +    g_free(s->map_path);
>>>   }
>>>   
>>>   static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
>>> @@ -343,7 +362,7 @@ static int af_xdp_socket_create(AFXDPState *s,
>>>           .bind_flags = XDP_USE_NEED_WAKEUP,
>>>           .xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST,
>>>       };
>>> -    int queue_id, error = 0;
>>> +    int queue_id, pin_fd, xsk_fd, idx, error = 0;
>>>   
>>>       s->inhibit = opts->has_inhibit && opts->inhibit;
>>>       if (s->inhibit) {
>>> @@ -384,6 +403,23 @@ static int af_xdp_socket_create(AFXDPState *s,
>>>           }
>>>       }
>>>   
>>> +    if (!error && s->map_path) {
>>> +        pin_fd = bpf_obj_get(s->map_path);
>>> +        if (pin_fd < 0) {
>>> +            error = errno;
>>> +        } else {
>>> +            xsk_fd = xsk_socket__fd(s->xsk);
>>> +            idx = s->nc.queue_index;
>>> +            if (s->map_start_index) {
>>> +                idx += s->map_start_index;
>>> +            }
>>> +            if (bpf_map_update_elem(pin_fd, &idx, &xsk_fd, 0)) {
>>> +                error = errno;
>>> +            }
>>> +            close(pin_fd);
>>> +        }
>>> +    }
>>> +
>>
>> This part doesn't seem to belong in this function.  It may be better if we
>> just create sockets here and create a separate function af_xdp_update_bpf_map
>> or something like that and call it from the main net_init_af_xdp.
>>
>> Main reasons for that are mostly related to the error path:
>>
>> 1. The error message below is a bit misleading and doesn't really tell what
>>     happened.  For example, if the map_path is incorrect, then we get:
>>       "failed to create AF_XDP socket ... : No such path or directory".
>>     There is no mention of the map path that we tried to open and failed and
>>     the information is kinda wrong as we did actually create the socket.
>>
>> 2. It's better if have xdp_flags properly initialized when the socket is
>>     actually created and not error out of this function early.  This may not
>>     matter today, but seems cleaner and may save us from some headaches in
>>     the future.
> 
> Ok, will refactor and move it out.
> 
>>>       if (error) {
>>>           error_setg_errno(errp, error,
>>>                            "failed to create AF_XDP socket for %s queue_id: %d",
>>> @@ -465,8 +501,12 @@ int net_init_af_xdp(const Netdev *netdev,
>>>           return -1;
>>>       }
>>>   
>>> -    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
>>> -        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
>>> +    if ((opts->has_inhibit && opts->inhibit) != !!(opts->sock_fds || opts->map_path)) {
>>> +        if (opts->has_inhibit && opts->inhibit) {
>>> +            error_setg(errp, "'inhibit=on' requires setting 'sock-fds' or 'map-path'");
>>> +        } else {
>>> +            error_setg(errp, "'sock-fds' or 'map-path' requires setting 'inhibit=on'");
>>> +        }
>>>           return -1;
>>>       }
>>
>> This is getting a little hard to navigate even after the re-wording, I think.
>> And we also need to cover more cases now.  So, I'd suggest to just bite the
>> bullet and spell out every case separately, e.g.:
>>
>>      inhibit = opts->has_inhibit && opts->inhibit;
>>      if (inhibit && !opts->sock_fds && !opts->map_path) {
>>          error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
>>          return -1;
>>      }
>>      if (!inhibit && (opts->sock_fds || opts->map_path)) {
>>          error_setg(errp, "'sock-fds' and 'map-path' require 'inhibit=on'");
>>          return -1;
>>      }
>>      if (opts->sock_fds && opts->map_path) {
>>          error_setg(errp, "'sock-fds' and 'map-path' are mutually exclusive");
>>          return -1;
>>      }
>>
>> This should be easier to understand and also saves some line lengths.  WDYT?
>>
>> The exclusivity check here is because we expect the file descriptors in the
>> sock-fds to be already in the map.  It would be an awkward configuration if
>> we have the fds and the map, so it might be better to just prohibit this.
> 
> The combination of both will semlessly work however, so even if you pass in
> the sockets, then the internal logic will skip creation and we can still push
> them into the specified map. So technically there isn't really a reason to
> restrict them to mutually exclusive. But I can adapt the code to the above
> either way if that's the preference since we don't have a use-case today for
> having both passed-in.

The problem I have with combining the options is that we expect sockets to be
already filled in the map when passed.  This is explicitly documented.
So, there is no point in having the map when the sockets are already in the map.
If we allow them to not be in the map, then we need to re-work the docuemntation
as well.  And sice there is no real use case for this, it seems better to just
mark them as mutually exclusive for now.

> 
>> We'll also need a check that map-start-index requires the map-path.
> 
> Will add.
> 
>>> @@ -491,6 +531,12 @@ int net_init_af_xdp(const Netdev *netdev,
>>>           pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>>>           s->ifindex = ifindex;
>>>           s->n_queues = queues;
>>
>> I'd put an empty line here.
>>
>>> +        if (opts->map_path) {
>>
>> This check doesn't seem necessary, g_strdup is NULL-safe.
>>
>>> +            s->map_path = g_strdup(opts->map_path);
>>> +            if (opts->has_map_start_index && opts->map_start_index > 0) {
>>> +                s->map_start_index = opts->map_start_index;
>>> +            }
>>> +        }
>>>   
>>>           if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
>>>               || af_xdp_socket_create(s, opts, errp)) {
>>> @@ -504,10 +550,15 @@ int net_init_af_xdp(const Netdev *netdev,
>>>       if (nc0) {
>>>           s = DO_UPCAST(AFXDPState, nc, nc0);
>>>           if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
>>> -            error_setg_errno(errp, errno,
>>> -                             "no XDP program loaded on '%s', ifindex: %d",
>>> -                             s->ifname, s->ifindex);
>>> -            goto err;
>>> +            if (!s->inhibit) {
>>
>> The s->inhibit is set as a side effect of af_xdp_socket_create().  It was a right
>> decision when the socket creation and the cleanup were the only users.  But since
>> we're using it now here, we should move setting of this value to the loop above.
> 
> Yeap, ack, coming in v3. Btw, I'm also considering to actually remove the warn
> below and only leave the error case for !s->inhibit as this decision is completely
> delegated to users. The XDP loading can just as well happen afterwards.

Maybe convert it to info?

> 
>>> +                error_setg_errno(errp, errno,
>>> +                                 "no XDP program loaded on '%s', ifindex: %d",
>>> +                                 s->ifname, s->ifindex);
>>> +                goto err;
>>> +            } else {
>>> +                warn_report("no XDP program loaded yet on '%s', ifindex: %d",
>>> +                            s->ifname, s->ifindex);
>>> +            }
>>>           }
>>>       }
>>>   
>>> diff --git a/qapi/net.json b/qapi/net.json
>>> index 310cc4fd19..66a1fcf6ae 100644
>>> --- a/qapi/net.json
>>> +++ b/qapi/net.json
>>> @@ -454,7 +454,7 @@
>>>   #     (default: 0).
>>>   #
>>>   # @inhibit: Don't load a default XDP program, use one already loaded
>>> -#     to the interface (default: false).  Requires @sock-fds.
>>> +#     to the interface (default: false).  Requires @sock-fds or @map-path.
>>>   #
>>>   # @sock-fds: A colon (:) separated list of file descriptors for
>>>   #     already open but not bound AF_XDP sockets in the queue order.
>>> @@ -462,17 +462,25 @@
>>>   #     into XDP socket map for corresponding queues.  Requires
>>>   #     @inhibit.
>>>   #
>>> +# @map-path: The path to a pinned xsk map to push file descriptors
>>> +#     for bound AF_XDP sockets into. Requires @inhibit. (Since 10.1)
>>> +#
>>> +# @map-start-index: Use @map-path to insert xsk sockets starting from
>>> +#     this index number (default: 0). Requires @map-path. (Since 10.1)
>>
>> The doc uses double spaces between sentences.  Also, may mention that
>> map-path and sock-fds are mutually exclusive.  For both options.
> 
> Ok.
> 
>>> +#
>>>   # Since: 8.2
>>>   ##
>>>   { 'struct': 'NetdevAFXDPOptions',
>>>     'data': {
>>> -    'ifname':       'str',
>>> -    '*mode':        'AFXDPMode',
>>> -    '*force-copy':  'bool',
>>> -    '*queues':      'int',
>>> -    '*start-queue': 'int',
>>> -    '*inhibit':     'bool',
>>> -    '*sock-fds':    'str' },
>>> +    'ifname':           'str',
>>> +    '*mode':            'AFXDPMode',
>>> +    '*force-copy':      'bool',
>>> +    '*queues':          'int',
>>> +    '*start-queue':     'int',
>>> +    '*inhibit':         'bool',
>>> +    '*sock-fds':        'str',
>>> +    '*map-path':        'str',
>>> +    '*map-start-index': 'int' },
>>>     'if': 'CONFIG_AF_XDP' }
>>>   
>>>   ##
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index dc694a99a3..50fc592f5d 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -2909,6 +2909,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>   #ifdef CONFIG_AF_XDP
>>>       "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
>>>       "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
>>> +    "         [,map-path=/path/to/socket/map][,map-start-index=i]\n"
>>>       "                attach to the existing network interface 'name' with AF_XDP socket\n"
>>>       "                use 'mode=MODE' to specify an XDP program attach mode\n"
>>>       "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
>>> @@ -2916,6 +2917,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>       "                with inhibit=on,\n"
>>>       "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
>>>       "                  added to a socket map in XDP program.  One socket per queue.\n"
>>> +    "                  use 'map-path' to provide the socket map location to populate AF_XDP sockets with\n"
>>> +    "                  beginning from the 'map-start-index' specified index (default: 0) (Since 10.1)\n"
>>>       "                use 'queues=n' to specify how many queues of a multiqueue interface should be used\n"
>>>       "                use 'start-queue=m' to specify the first queue that should be used\n"
>>>   #endif
>>
>> There is another section below with all the options listed and some
>> examples.  It will need an update.  Not sure if we need an example
> 
> Thanks, will add!
> 
>> for this new use case, but if you can make a small one with just
>> using bpftool, that maight be useful.
> 
> Full blown example is a bit more involved, so likely won't fit since we also need
> all the other pieces (example C code, build, BPF skeleton) which mostly !inhibit
> does in the background.

Example may load the defaul xsk_def_xdp_prog.o that is shipped with libxdp.
Should be no need for C code or compiling in this case.

> 
> Thanks,
> Daniel


