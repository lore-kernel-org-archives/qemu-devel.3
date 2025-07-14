Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C17C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLMP-0000Wf-PG; Mon, 14 Jul 2025 11:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1ubK7c-0005gF-6d
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:25:36 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1ubK7X-000268-9F
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:25:35 -0400
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-ae3ec622d2fso775749766b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 07:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752503128; x=1753107928;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5sN2uZjG6FVFfgzCryVMWA4mziYx6iuxuISYW33v/E=;
 b=ensN4fsC73/0jmjcwzam8HYVg0MxOblM1vieRBF/tQl1aneDRG/CDGMI6bMUzCZKna
 P2ZIwLkiEt3b/yblUDCyO+9vfjmQI/fwpFHMM7UxYYSo2xyb0t6dVU3ZGjdUyivjTQXs
 R7DsjCycVRCwOxV00mL73VxLkG/hRB5/GtReh0RU1s16CV+5fJLB/UNwVYkm+No3yjR2
 3D4UAcL4iRd4uAxVnQXMVYVCMmh2vQYYnksobPu9HSAX6RdpO9WNL85FOGYLa9hYnLB8
 xlj4slSV7Zuaav+nF4GcqHwqYSY9vZdO5l69o1LrUC86EilrIPk9OjbFTpttx2xxAvu7
 jn9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPrAoa8R0/TxoRwnGN5VBDYMtQE/y/hHJpNQ6zS9THjb+TbrLFqx8E/EBcgakWO02RPbXejmuUqJxr@nongnu.org
X-Gm-Message-State: AOJu0YwRBTlrEcDkw7xABFcCzOi+ow6w2th5ZdqWPLId088uPuTldud1
 3xrtbwccoNYFy3eUW3XKncDUzvAoCnDzTNf7BoibJMft6rFZA2S+Kz0P
X-Gm-Gg: ASbGncsdQZjTYEE78EtHZdVriQPA6yvWAEfFOp9LY+s3ySgmQ2J8vqXPIhmaq4G1ytG
 Z0eyd0afVkRbrUPkS+/4F5W2XOTKcWbq0oYTBP44R7NIGWyT8N/0g/rF2vjL5K1tChBXEoXXdfP
 F7X8NZyRIRmkkIa0xHSKv6d9AvHDc+pmf4qo4vyeJT720QLxVBLTz2hJtVUwfoB7IJcZ8rlZh4S
 oafYQZqzwdA+Buhnnr0mTLF7ezujBJT2VNeorF6R8sR44lkmms+5qlaW351/VxV8IaOzrH/N0MB
 eHbgM0A+dCBiGeR3lCGVHoO12VRgZ9cENBJpd9cT7b4lbuqjIQxns3tPZE8dVk1hhxPOvhP+cgG
 CzxpNFlj5EnBx746f3X6nfXe9h06ahdM2Rk0IVCi0C8gVB2L3kRcJ+w==
X-Google-Smtp-Source: AGHT+IHOZhDxrWT0I3gkjbs2EIzA2uGMdui+2qfSds3t2rZg6Q5Eq4pvn2hdSNSt9bYz05yP8A017g==
X-Received: by 2002:a17:907:2d13:b0:ad8:8cd8:a3b7 with SMTP id
 a640c23a62f3a-ae6fc0ad9eamr1304461166b.23.1752503128147; 
 Mon, 14 Jul 2025 07:25:28 -0700 (PDT)
Received: from [192.168.88.252] (37-48-10-116.nat.epc.tmcz.cz. [37.48.10.116])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c94f2bcdsm6036965a12.4.2025.07.14.07.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 07:25:27 -0700 (PDT)
Message-ID: <42b1f6eb-c070-42dc-8546-693e9e7a1923@ovn.org>
Date: Mon, 14 Jul 2025 16:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v5 2/3] net/af-xdp: Fix up cleanup path upon failure in
 queue creation
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250711094416.247125-1-daniel@iogearbox.net>
 <20250711094416.247125-2-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250711094416.247125-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ej1-f65.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/11/25 11:44 AM, Daniel Borkmann wrote:
> While testing, it turned out that upon error in the queue creation loop,
> we never trigger the af_xdp_cleanup() handler. This is because we pass
> errp instead of a local err pointer into the various AF_XDP setup functions
> instead of a scheme like:
> 
>     bool fn(..., Error **errp)
>     {
>         Error *err = NULL;
> 
>         foo(arg, &err);
>         if (err) {
>             handle the error...
>             error_propagate(errp, err);
>             return false;
>         }
>         ...
>     }
> 
> The same is true for the attachment probing with bpf_xdp_query_id(). With a
> conversion into the above format, the af_xdp_cleanup() handler is called as
> expected. Note the error_propagate() handles a NULL err internally.
> 
> Fixes: cb039ef3d9e3 ("net: add initial support for AF_XDP network backend")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> ---
>  net/af-xdp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index c5d3b6a953..1692efe9f2 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -482,9 +482,8 @@ int net_init_af_xdp(const Netdev *netdev,
>          pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>          s->ifindex = ifindex;
>  
> -        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
> -            || af_xdp_socket_create(s, opts, errp)) {
> -            error_propagate(errp, err);
> +        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
> +            af_xdp_socket_create(s, opts, &err)) {
>              goto err;
>          }
>      }
> @@ -492,7 +491,7 @@ int net_init_af_xdp(const Netdev *netdev,
>      if (nc0) {
>          s = DO_UPCAST(AFXDPState, nc, nc0);
>          if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
> -            error_setg_errno(errp, errno,
> +            error_setg_errno(&err, errno,
>                               "no XDP program loaded on '%s', ifindex: %d",
>                               s->ifname, s->ifindex);
>              goto err;
> @@ -506,6 +505,7 @@ int net_init_af_xdp(const Netdev *netdev,
>  err:
>      if (nc0) {
>          qemu_del_net_client(nc0);
> +        error_propagate(errp, err);
>      }
>  
>      return -1;

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

