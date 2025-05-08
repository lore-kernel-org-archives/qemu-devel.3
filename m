Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E633DC3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA7U-0003so-Ub; Thu, 08 May 2025 18:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uDA7Q-0003dS-RI
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:53:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uDA7N-0006jy-Ue
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:53:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-5fbee929e83so2274059a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746744807; x=1747349607;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9e/fC6fU2lh9c7GzUuH09/jCREzNc81OgSNbCgdXcQ=;
 b=XfuokHB28v0+LMLlNsDd9L8AKnSNr3WmrNRsypYqUkJCCBPw2/acqdkCR3abwbSJ+z
 cne0mtsGsPGjK9c163/JBGACZ/a1vPjH3n8pDBsfDkXIn0oxeI9/Tpe4VEfPSCEAehLo
 tBfWA1UKrYg+iIg/9lEbEWqQVqWKvtmo/fC5kycnYmx/6T+i1dwAhVho5klDX4XXxcT+
 AfPmYdD57vKsdXYXY4JBlTl+SnmO/H9HPTvE7lL5OB+/ygfQ3x33lolqzdZuMs1jB/Gy
 H4bvunD8RdL49e9eOyOIV5Egq54NGXDvSww7h97Bl4eZ3gpOKLwIMCHz4ieJHxutos/P
 NdWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViOTTiXmWXfQgyaniWc9YORqNTZiDHXXbsGIJkiCQFsXWNVWby5z6rlhl2V2LAnRwSfLpuHa4dnHXo@nongnu.org
X-Gm-Message-State: AOJu0YyiwnVAFI6zoB5XkMrrwCrAFipF4tRp0a8jsMqT3assqLFimDip
 7v4KoVSL92aoqJ0YyXNAc459slNt4ggj+vsmtOgzVQ6xj7ye/pb+
X-Gm-Gg: ASbGncsJczPbYHEKL7SMwHVZ/JzYA728voufzjKFmTezLyiZ9S8VzLknRtcHh+UPV6F
 aq0tJWqhNWsn4Sh5TQ6FHFjYyHoDDIqrpbvV7UYZPIu/YuOVcSN4AGWe+nvXvKqjv+3nYchNX1i
 Hv/v7l0+RfexcyLAPyfm2dbf7RBDUsD540XnnsjV6Fgl+IEFGEDF8d62xOdf9IR8ZVYbun6jZfs
 knnnb6uyxXd2YOdILzFu1rVJxlu+XjUeqp58vq38nf/V4La65h6E8A9Ge+Eq8gIduCNlfhVuksF
 1v+wKlT1QbXoUVA4EpAoRbypx+94PdoN0zmqW2Z/Skchv+qjNQyQFFcTuyGvufEJi2QYdiHCT/I
 H4JEsbAw=
X-Google-Smtp-Source: AGHT+IHJM+lCiZ2vhvVRIlbITWEf7Izk9/j7f3d0CGYn8KSO7+yyv6Rk8y/Svw2hv8VLqt6slfGo8g==
X-Received: by 2002:a05:6402:13d4:b0:5fb:1eed:cdb1 with SMTP id
 4fb4d7f45d1cf-5fca0793ecfmr823609a12.18.1746744807314; 
 Thu, 08 May 2025 15:53:27 -0700 (PDT)
Received: from [192.168.88.252] (194-212-251-179.customers.tmcz.cz.
 [194.212.251.179]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9cc261e9sm510663a12.23.2025.05.08.15.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 15:53:27 -0700 (PDT)
Message-ID: <f044b02b-3b7a-4a64-ab38-3298f96955a9@ovn.org>
Date: Fri, 9 May 2025 00:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH] net/af-xdp: Support pinned map path for AF_XDP sockets
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250508123436.461030-1-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250508123436.461030-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.67;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ed1-f67.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/8/25 2:34 PM, Daniel Borkmann wrote:
> Extend inhibit=on setting with the option to specify a pinned XSK map
> path along with a starting index (default 0) to push the created XSK
> sockets into. Example usage:
> 
>   # ./build/qemu-system-x86_64 [...] \
>     -netdev af-xdp,ifname=eth0,id=net0,mode=native,queues=2,inhibit=on,map-path=/sys/fs/bpf/foo,map-start-index=2
>     -device virtio-net-pci,netdev=net0 [...]
> 
> This is useful for the case where an existing XDP program with XSK map
> is present on the AF_XDP supported phys device and the XSK map not yet
> populated. Qemu will then push the XSK sockets into the specified map.

Hi, Daniel.

Thanks for the patch!

Could you, please, explain the use case a little more?  Is this patch
aiming to improve usability?  Do you have a specific use case in mind?

The main idea behind 'inhibit' is that the qemu doesn't need to have a lot
of privileges to use the pre-loaded program and the pre-created sockets.
But creating the sockets and setting them into a map doesn't allow us to
run without privileges, IIUC.  May be worth mentioning at least in the
commit message.

Also, isn't map-start-index the same thing as start-queue ?  Do we need
both of them?

I didn't read much into the code yet, but this patch is missing a few
bits of documentation, e.g. it's missing an update for qemu-options.hx.

See a few other quick comment below.

Best regards, Ilya Maximets.

> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> ---
>  net/af-xdp.c  | 63 +++++++++++++++++++++++++++++++++++++++++++++------
>  qapi/net.json | 24 +++++++++++++-------
>  2 files changed, 72 insertions(+), 15 deletions(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 01c5fb914e..ddc52f1307 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -51,6 +51,8 @@ typedef struct AFXDPState {
>  
>      uint32_t             n_queues;
>      uint32_t             xdp_flags;
> +    char                 *map_path;
> +    uint32_t             map_start_index;
>      bool                 inhibit;
>  } AFXDPState;
>  
> @@ -261,6 +263,7 @@ static void af_xdp_send(void *opaque)
>  static void af_xdp_cleanup(NetClientState *nc)
>  {
>      AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
> +    int pin_fd, idx;
>  
>      qemu_purge_queued_packets(nc);
>  
> @@ -282,6 +285,22 @@ static void af_xdp_cleanup(NetClientState *nc)
>                  "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
>                  s->ifname, s->ifindex);
>      }
> +    if (s->map_path) {
> +        pin_fd = bpf_obj_get(s->map_path);
> +        if (pin_fd < 0) {
> +            fprintf(stderr,
> +                "af-xdp: unable to remove %s's XSK sockets from '%s', ifindex: %d\n",
> +                s->ifname, s->map_path, s->ifindex);
> +        } else {
> +            idx = nc->queue_index;
> +            if (s->map_start_index > 0) {
> +                idx += s->map_start_index;
> +            }
> +            bpf_map_delete_elem(pin_fd, &idx);
> +            close(pin_fd);
> +        }
> +    }
> +    g_free(s->map_path);
>  }
>  
>  static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
> @@ -343,7 +362,7 @@ static int af_xdp_socket_create(AFXDPState *s,
>          .bind_flags = XDP_USE_NEED_WAKEUP,
>          .xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST,
>      };
> -    int queue_id, error = 0;
> +    int queue_id, pin_fd, xsk_fd, idx, error = 0;
>  
>      s->inhibit = opts->has_inhibit && opts->inhibit;
>      if (s->inhibit) {
> @@ -384,6 +403,23 @@ static int af_xdp_socket_create(AFXDPState *s,
>          }
>      }
>  
> +    if (!error && s->map_path) {
> +        pin_fd = bpf_obj_get(s->map_path);
> +        if (pin_fd < 0) {
> +            error = errno;
> +        } else {
> +	    xsk_fd = xsk_socket__fd(s->xsk);

Indentation is off.  Tbas mixed with spaces here and in some other
places in the patch.

> +            idx = s->nc.queue_index;
> +            if (s->map_start_index) {
> +                idx += s->map_start_index;
> +            }
> +            if (bpf_map_update_elem(pin_fd, &idx, &xsk_fd, 0)) {
> +                error = errno;
> +            }
> +            close(pin_fd);
> +        }
> +    }
> +
>      if (error) {
>          error_setg_errno(errp, error,
>                           "failed to create AF_XDP socket for %s queue_id: %d",
> @@ -465,8 +501,8 @@ int net_init_af_xdp(const Netdev *netdev,
>          return -1;
>      }
>  
> -    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
> -        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
> +    if ((opts->has_inhibit && opts->inhibit) != !!(opts->sock_fds || opts->map_path)) {
> +        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path' and vice versa");

This may need some re-wording as 'A requires B or C or vice versa' is
a little hard to understand.

>          return -1;
>      }
>  
> @@ -491,6 +527,12 @@ int net_init_af_xdp(const Netdev *netdev,
>          pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>          s->ifindex = ifindex;
>          s->n_queues = queues;
> +        if (opts->map_path) {
> +            s->map_path = g_strdup(opts->map_path);
> +            if (opts->has_map_start_index && opts->map_start_index > 0) {
> +                s->map_start_index = opts->map_start_index;
> +            }
> +        }
>  
>          if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
>              || af_xdp_socket_create(s, opts, errp)) {
> @@ -504,10 +546,17 @@ int net_init_af_xdp(const Netdev *netdev,
>      if (nc0) {
>          s = DO_UPCAST(AFXDPState, nc, nc0);
>          if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
> -            error_setg_errno(errp, errno,
> -                             "no XDP program loaded on '%s', ifindex: %d",
> -                             s->ifname, s->ifindex);
> -            goto err;
> +            if (!s->map_path) {
> +                error_setg_errno(errp, errno,
> +                                 "no XDP program loaded on '%s', ifindex: %d",
> +                                 s->ifname, s->ifindex);
> +                goto err;
> +	    } else {
> +                warn_report("no XDP program loaded on '%s', ifindex: %d, "
> +			    "only %"PRIi64" XSK socket%s loaded into map %s at this point",
> +			    s->ifname, s->ifindex, queues, queues > 1 ? "s" : "",
> +			    s->map_path);

How a missing program is not an error?  Seems strange.

> +            }
>          }
>      }
>  
> diff --git a/qapi/net.json b/qapi/net.json
> index 310cc4fd19..c750b805e8 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -454,7 +454,7 @@
>  #     (default: 0).
>  #
>  # @inhibit: Don't load a default XDP program, use one already loaded
> -#     to the interface (default: false).  Requires @sock-fds.
> +#     to the interface (default: false).  Requires @sock-fds or @map-path.
>  #
>  # @sock-fds: A colon (:) separated list of file descriptors for
>  #     already open but not bound AF_XDP sockets in the queue order.
> @@ -462,17 +462,25 @@
>  #     into XDP socket map for corresponding queues.  Requires
>  #     @inhibit.
>  #
> +# @map-path: The path to a pinned xsk map to push file descriptors
> +#     for bound AF_XDP sockets into. Requires @inhibit.
> +#
> +# @map-start-index: Use @map-path to insert xsk sockets starting from
> +#     this index number (default: 0). Requires @map-path.

These are new fields that do not exist in the older versions, so
they will need their own 'since' qualifiers.

> +#
>  # Since: 8.2
>  ##
>  { 'struct': 'NetdevAFXDPOptions',
>    'data': {
> -    'ifname':       'str',
> -    '*mode':        'AFXDPMode',
> -    '*force-copy':  'bool',
> -    '*queues':      'int',
> -    '*start-queue': 'int',
> -    '*inhibit':     'bool',
> -    '*sock-fds':    'str' },
> +    'ifname':           'str',
> +    '*mode':            'AFXDPMode',
> +    '*force-copy':      'bool',
> +    '*queues':          'int',
> +    '*start-queue':     'int',
> +    '*inhibit':         'bool',
> +    '*sock-fds':        'str',
> +    '*map-path':        'str',
> +    '*map-start-index': 'int' },
>    'if': 'CONFIG_AF_XDP' }
>  
>  ##


