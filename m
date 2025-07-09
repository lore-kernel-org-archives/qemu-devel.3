Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B9C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 12:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZTw6-0001r1-Pw; Wed, 09 Jul 2025 08:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uZTvz-0001ph-1h
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 08:29:59 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uZTvw-0003O3-2Z
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 08:29:58 -0400
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-ae0bc7aa21bso1178996566b.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 05:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752064193; x=1752668993;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KH3cfphyNcM7Eu2DLKQBmZh3/vKO3LlR+4/pYjd4Lw8=;
 b=d/r+wvZtPiSOkKd7u1Funjgg6Rt+jDuWU2sKlhtgtakPFHcHzenK5pML/13YLQLYBE
 i7keDPEd+cMmClObqRuRv76VlHTCq1J71Nv+NrhSzGC/Hc5TvWqQAibDGnbPy+8BhTUP
 q4eAmm3PXreG50i0EvNA9TXzeGW7cYfTaYRxzNVO7ydKO2i30409UjgNzA+zemOwhad7
 VCDsR16KjQJsAdezkjzUBthSc8QhZYyYRWkqHS3XmwUsJqfVgCJ1Ak1jA5p4w7xfx/BG
 40byjlHWd6UTsCg4wgMKSAnH9Xc5ElcZE8sGpmkrdenXMa4DZTk+shLrso+Wcf+FcIbK
 eYoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwkPNbMrvB5VbGmOO75rOizkssPzQl/hgRsmbzlaL70T5LGsVSyBrhzXYtOFLppireOnPqLGihZcRF@nongnu.org
X-Gm-Message-State: AOJu0Yzsg/SLFoPMRc4HNR0Kyktm5I5w+LyYUXY4NxHlqAPyvTBQTrzS
 awDRXeHtSZh0QwvPRFB59ObAMuI5Y2q8atbR4TBrAwFyWkiUOsSjJQgg
X-Gm-Gg: ASbGncu6t/Gh68921jE1XhpxzxVGWmz1KJ49o8BbHb576jSe5HBFXw7M7+HsjcStvhY
 iwQ+vdQYRyduZeenLJSl1k0rqi0lqg9ZI58Zp21qBX8+tE7t+Ce1O1cZ5B/WWdI8gCjDTNJlxWz
 0tmKXM2FkPMIsZ5jCfsjzDfclmecfXJVI/5XAYrfHk74X8emaWAf4DQCJE5kgeimDGSN9QHQ83q
 dP5axBiL3rFYrvbKWFW2zv9Xw9IfYOm9uSASKD3uD+vcgndJnDVkD2rEqjvsEfOMVH5hLIF3alr
 ep5aY9IcGZsD5NkVKV4I7j29WERWqh4uST606MsTdZBAO1NhY1rA8TPQ0hp8zwMWuQQ4CI5/oWl
 1phM7Th8TqivdnO47pjCOhUSiPkpb
X-Google-Smtp-Source: AGHT+IFRiBvh90TQ0AtuTbhJ20AbUtasvSP5y+YO8Z64+TOd2ffGIBjxJOGYrtuvuWrTuBHS8Le22w==
X-Received: by 2002:a17:906:d24f:b0:ae6:ddc2:f9f4 with SMTP id
 a640c23a62f3a-ae6ddc30132mr25401466b.6.1752064192768; 
 Wed, 09 Jul 2025 05:29:52 -0700 (PDT)
Received: from [192.168.88.252] (37-48-10-116.nat.epc.tmcz.cz. [37.48.10.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b05292sm1081200166b.122.2025.07.09.05.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 05:29:52 -0700 (PDT)
Message-ID: <bd4b60f5-8bf1-4f03-9b9f-9e034bc60574@ovn.org>
Date: Wed, 9 Jul 2025 14:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v4 3/3] net/af-xdp: Support pinned map path for AF_XDP
 sockets
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250704130531.144325-1-daniel@iogearbox.net>
 <20250704130531.144325-3-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <20250704130531.144325-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ej1-f65.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.039, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/4/25 3:05 PM, Daniel Borkmann wrote:
> Extend 'inhibit=on' setting with the option to specify a pinned XSK map
> path along with a starting index (default 0) to push the created XSK
> sockets into. Example usage:
> 
>   # ./build/qemu-system-x86_64 [...] \
>    -netdev af-xdp,ifname=enp2s0f0np0,id=net0,mode=native,queues=2,start-queue=14,inhibit=on,map-path=/sys/fs/bpf/xsks_map,map-start-index=14 \
>    -device virtio-net-pci,netdev=net0 [...]
> 
> This is useful for the case where an existing XDP program with XSK map
> is present on the AF_XDP supported phys device and the XSK map is not
> yet populated. For example, the former could have been pre-loaded onto
> the netdevice by a control plane, which later launches QEMU to populate
> it with XSK sockets.
> 
> Normally, the main idea behind 'inhibit=on' is that the QEMU instance
> doesn't need to have a lot of privileges to use the pre-loaded program
> and the pre-created sockets, but this mentioned use-case here is different
> where QEMU still needs privileges to create the sockets.
> 
> The 'map-start-index' parameter is optional and defaults to 0. It allows
> flexible placement of the XSK sockets, and is up to the user to specify
> when the XDP program with XSK map was already preloaded. In the simplest
> case the queue-to-map-slot mapping is just 1:1 based on ctx->rx_queue_index
> but the user might as well have a different scheme (or smaller map size,
> e.g. ctx->rx_queue_index % max_size) to push the inbound traffic to one
> of the XSK sockets.
> 
> Note that the bpf_xdp_query_id() is now only tested for 'inhibit=off'
> since only in the latter case the libxdp takes care of installing the
> XDP program which was installed based on the s->xdp_flags pointing to
> either driver or skb mode. For 'inhibit=on' we don't make any assumptions
> and neither go down the path of probing all possible options in which
> way the user installed the XDP program.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> ---
>  net/af-xdp.c    | 78 +++++++++++++++++++++++++++++++++++++++++++++----
>  qapi/net.json   | 29 +++++++++++-------
>  qemu-options.hx | 23 +++++++++++++--
>  3 files changed, 113 insertions(+), 17 deletions(-)

Thnaks, Daniel!  I have just a couple of small nits below that I missed in v3,
the rest looks good and is working fine.

> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 29c5ad16cd..005117c336 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -51,6 +51,10 @@ typedef struct AFXDPState {
>  
>      uint32_t             xdp_flags;
>      bool                 inhibit;
> +
> +    char                 *map_path;
> +    int                  map_fd;
> +    uint32_t             map_start_index;
>  } AFXDPState;
>  
>  #define AF_XDP_BATCH_SIZE 64
> @@ -260,6 +264,7 @@ static void af_xdp_send(void *opaque)
>  static void af_xdp_cleanup(NetClientState *nc)
>  {
>      AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
> +    int idx;
>  
>      qemu_purge_queued_packets(nc);
>  
> @@ -273,6 +278,18 @@ static void af_xdp_cleanup(NetClientState *nc)
>      s->umem = NULL;
>      qemu_vfree(s->buffer);
>      s->buffer = NULL;
> +
> +    if (s->map_fd >= 0) {
> +        idx = nc->queue_index + s->map_start_index;
> +        if (bpf_map_delete_elem(s->map_fd, &idx)) {
> +            fprintf(stderr, "af-xdp: unable to remove AF_XDP socket from "
> +                    "map %s\n", s->map_path);

nit :I'd suggest to keep the "map" on a previous line.  We have some space for it.

> +        }
> +        close(s->map_fd);
> +        s->map_fd = -1;
> +    }
> +    g_free(s->map_path);
> +    s->map_path = NULL;
>  }
>  
>  static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
> @@ -336,7 +353,6 @@ static int af_xdp_socket_create(AFXDPState *s,
>      };
>      int queue_id, error = 0;
>  
> -    s->inhibit = opts->has_inhibit && opts->inhibit;
>      if (s->inhibit) {
>          cfg.libxdp_flags |= XSK_LIBXDP_FLAGS__INHIBIT_PROG_LOAD;
>      }
> @@ -387,6 +403,35 @@ static int af_xdp_socket_create(AFXDPState *s,
>      return 0;
>  }
>  
> +static int af_xdp_update_xsk_map(AFXDPState *s, Error **errp)
> +{
> +    int xsk_fd, idx, error = 0;
> +
> +    if (!s->map_path) {
> +        return 0;
> +    }
> +
> +    s->map_fd = bpf_obj_get(s->map_path);
> +    if (s->map_fd < 0) {
> +        error = errno;
> +    } else {
> +        xsk_fd = xsk_socket__fd(s->xsk);
> +        idx = s->nc.queue_index + s->map_start_index;
> +        if (bpf_map_update_elem(s->map_fd, &idx, &xsk_fd, 0)) {
> +            error = errno;
> +        }
> +    }
> +
> +    if (error) {
> +        error_setg_errno(errp, error,
> +                         "failed to insert AF_XDP socket into map %s",
> +                         s->map_path);
> +        return -1;

nit: Maybe remove this line and return 'error' below?

> +    }
> +
> +    return 0;
> +}
> +
>  /* NetClientInfo methods. */
>  static NetClientInfo net_af_xdp_info = {
>      .type = NET_CLIENT_DRIVER_AF_XDP,
> @@ -441,6 +486,7 @@ int net_init_af_xdp(const Netdev *netdev,
>      int64_t i, queues;
>      Error *err = NULL;
>      AFXDPState *s;
> +    bool inhibit;
>  
>      ifindex = if_nametoindex(opts->ifname);
>      if (!ifindex) {
> @@ -456,8 +502,21 @@ int net_init_af_xdp(const Netdev *netdev,
>          return -1;
>      }
>  
> -    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
> -        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
> +    inhibit = opts->has_inhibit && opts->inhibit;
> +    if (inhibit && !opts->sock_fds && !opts->map_path) {
> +        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
> +        return -1;
> +    }
> +    if (!inhibit && (opts->sock_fds || opts->map_path)) {
> +        error_setg(errp, "'sock-fds' and 'map-path' require 'inhibit=on'");
> +        return -1;
> +    }
> +    if (opts->sock_fds && opts->map_path) {
> +        error_setg(errp, "'sock-fds' and 'map-path' are mutually exclusive");
> +        return -1;
> +    }
> +    if (!opts->map_path && opts->has_map_start_index) {
> +        error_setg(errp, "'map-start-index' requires 'map-path'");
>          return -1;
>      }
>  
> @@ -481,14 +540,23 @@ int net_init_af_xdp(const Netdev *netdev,
>  
>          pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>          s->ifindex = ifindex;
> +        s->inhibit = inhibit;
> +
> +        s->map_path = g_strdup(opts->map_path);
> +        s->map_fd = -1;
> +        s->map_start_index = 0;
> +        if (opts->has_map_start_index && opts->map_start_index > 0) {

We should error out if the user specified a negative value.  I'd suggest
to add the check to the list of user-input validation above instead of
silently ignoring the incorrect value.  And then we could skip the value
check here.

> +            s->map_start_index = opts->map_start_index;
> +        }
>  
>          if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
> -            af_xdp_socket_create(s, opts, &err)) {
> +            af_xdp_socket_create(s, opts, &err) ||
> +            af_xdp_update_xsk_map(s, &err)) {
>              goto err;
>          }
>      }
>  
> -    if (nc0) {
> +    if (nc0 && !inhibit) {
>          s = DO_UPCAST(AFXDPState, nc, nc0);
>          if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
>              error_setg_errno(errp, errno,
> diff --git a/qapi/net.json b/qapi/net.json
> index 97ea183981..3d80a9cacd 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -454,25 +454,34 @@
>  #     (default: 0).
>  #
>  # @inhibit: Don't load a default XDP program, use one already loaded
> -#     to the interface (default: false).  Requires @sock-fds.
> +#     to the interface (default: false).  Requires @sock-fds or @map-path.
>  #
>  # @sock-fds: A colon (:) separated list of file descriptors for
>  #     already open but not bound AF_XDP sockets in the queue order.
>  #     One fd per queue.  These descriptors should already be added
> -#     into XDP socket map for corresponding queues.  Requires
> -#     @inhibit.
> +#     into XDP socket map for corresponding queues.  @sock-fds and
> +#     @map-path are mutually exclusive.  Requires @inhibit.
> +#
> +# @map-path: The path to a pinned xsk map to push file descriptors
> +#     for bound AF_XDP sockets into.  @map-path and @sock-fds are
> +#     mutually exclusive.  Requires @inhibit.  (Since 10.1)
> +#
> +# @map-start-index: Use @map-path to insert xsk sockets starting from
> +#     this index number (default: 0).  Requires @map-path.  (Since 10.1)
>  #
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
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1f862b19a6..0fd4fd8d46 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2909,6 +2909,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>  #ifdef CONFIG_AF_XDP
>      "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
>      "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
> +    "         [,map-path=/path/to/socket/map][,map-start-index=i]\n"
>      "                attach to the existing network interface 'name' with AF_XDP socket\n"
>      "                use 'mode=MODE' to specify an XDP program attach mode\n"
>      "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
> @@ -2916,6 +2917,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "                with inhibit=on,\n"
>      "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
>      "                  added to a socket map in XDP program.  One socket per queue.\n"
> +    "                  use 'map-path' to provide the socket map location to populate AF_XDP sockets with\n"

nit: it feels like we need some punctuation sign after the 'with', otherwise
it reads as "populate AF_XDP sockets with beginning from the", which makes no
sense.

> +    "                  beginning from the 'map-start-index' specified index (default: 0) (Since 10.1)\n"
>      "                use 'queues=n' to specify how many queues of a multiqueue interface should be used\n"
>      "                use 'start-queue=m' to specify the first queue that should be used\n"
>  #endif
> @@ -3610,7 +3613,7 @@ SRST
>          # launch QEMU instance
>          |qemu_system| linux.img -nic vde,sock=/tmp/myswitch
>  
> -``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]``
> +``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z][,map-path=/path/to/socket/map][,map-start-index=i]``
>      Configure AF_XDP backend to connect to a network interface 'name'
>      using AF_XDP socket.  A specific program attach mode for a default
>      XDP program can be forced with 'mode', defaults to best-effort,
> @@ -3650,7 +3653,8 @@ SRST
>              -netdev af-xdp,id=n1,ifname=eth0,queues=1,start-queue=1
>  
>      XDP program can also be loaded externally.  In this case 'inhibit' option
> -    should be set to 'on' and 'sock-fds' provided with file descriptors for
> +    should be set to 'on'.  Either 'sock-fds' or 'map-path' can be used with
> +    'inhibit' enabled.  'sock-fds' can be provided with file descriptors for
>      already open but not bound XDP sockets already added to a socket map for
>      corresponding queues.  One socket per queue.
>  
> @@ -3659,6 +3663,21 @@ SRST
>          |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
>              -netdev af-xdp,id=n1,ifname=eth0,queues=3,inhibit=on,sock-fds=15:16:17
>  
> +    For the 'inhibit' option set to 'on' used together with 'map-path' it is
> +    expected that the XDP program with the socket map is already loaded on
> +    the networking device and the map pinned into BPF file system.  The path
> +    to the pinned map is then passed to QEMU which then creates the file
> +    descriptors and inserts them into the existing socket map.
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
> +            -netdev af-xdp,id=n1,ifname=eth0,queues=2,inhibit=on,map-path=/sys/fs/bpf/xsks_map
> +
> +    Additionally, 'map-start-index' can be used to specify the start offset
> +    for insertion into the socket map.  The combination of 'map-path' and
> +    'sock-fds' together is not supported.
> +
>  ``-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]``
>      Establish a vhost-user netdev, backed by a chardev id. The chardev
>      should be a unix domain socket backed one. The vhost-user uses a


