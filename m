Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E9C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYe0-0007ao-SK; Tue, 17 Jun 2025 11:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uRYM1-0004Bk-Nk
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:36:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uRUyC-0006ws-0C
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 07:59:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso11258712a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 04:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750161551; x=1750766351;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAnI7PyvFETj1ppQjxS0lmEjoQMMLw9l4r/Tz3MkT8U=;
 b=utf2simbYJFnOE8bR96HDtlSAL9I72+Wx3j6t9tpBwJnqhVLSW1u0WtqiDPpgs6puf
 vUjpjKdnm3gAvGUzzMllRkRQIZAf757iv670RMdOHBHVH+qCXaoQ5azSBzNoOAR7ZXDg
 BslpRZkiM7F4cLeUO5PiMrImf95q+uoB5clb/xD1AgiMumxIDrR2c021WLKU+RFq2cNM
 Sp7AOGThhcyTwEF55G2QPf4/2iBXm5BhgRjA6yGGovqwlZPks7dqiW2Un/ZNKuIVkJAu
 proPrVdGUD1ow4Bta/HBanPH4wQoGnN2VXAytluJZ6l3Psnx9oGZC4EHy/g0rxa6S4gi
 AENA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhawfO3yRA8cqy9lt2W9VIVMyHidnY8nG4OpZi9pV3Mu6kxnOxUk1Bajt8ndD5I2aWwvh7o0TZaWDD@nongnu.org
X-Gm-Message-State: AOJu0YwLbpP+OgmKTqDTqBWKVXRYtTCSUGHFaZSRw5tg/Bbys/Psf0Oy
 /AnaJ/WAIbu+BcZgnIE481Q5UozCKXRvpgXqmAWv66VCnY+lJhWNf9fx
X-Gm-Gg: ASbGncu5yHsPbMvuP8vQSOpD2unY61+PEalQMWXMHx0I2TCMsYapjXY4nWeeA5RUwrR
 MWYV0WDxyJ16JO0MVWgUPVMW3Cvl7B5H4FL6ib7LEDzyQivRY/+QITiiZIkuivO+DH+VpSpygfb
 /R0pGZI7vD3oJMvSUGhQTSeXY6gxphlWGj3Cy6luKrMBQRow+v4CxLzzxoKYSJV6YgxPwxRrHv7
 8YwH1pptxaP00aQMf007ZsESwq1pS/KlO9m1VHQl0KDziAYY3lX80R6RvKBcA/nw8e4+5gGsBsV
 a5HysrryMmOiVdomNedaxIMFVZQlezYghDW+QYsbTebq+RLp9p7NS4Tlhd0xSCf9h/bdroAG+vX
 6i8eQqH0cvM6mdOIsL+8A
X-Google-Smtp-Source: AGHT+IFp+Jvp0GomItpNyaX/wjGaMe70+jUOCTXODNL0dNM9yHTyv+Ll3n4r/TysYJXVd7tU+ctDhg==
X-Received: by 2002:a17:907:d86:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-adfad53b79bmr1347147966b.36.1750161551147; 
 Tue, 17 Jun 2025 04:59:11 -0700 (PDT)
Received: from [192.168.88.252] (78-80-97-102.customers.tmcz.cz.
 [78.80.97.102]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec897c739sm866673766b.171.2025.06.17.04.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 04:59:10 -0700 (PDT)
Message-ID: <36baa0a5-43ac-44c1-bf30-34f34ddfceba@ovn.org>
Date: Tue, 17 Jun 2025 13:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v3 1/2] net/af-xdp: Support pinned map path for AF_XDP
 sockets
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250604112916.1195368-1-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250604112916.1195368-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.67;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ed1-f67.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.068, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/4/25 1:29 PM, Daniel Borkmann wrote:
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
> the netdevice by a control plane, which later launches qemu to populate
> it with XSK sockets.
> 
> Normally, the main idea behind 'inhibit=on' is that the qemu instance
> doesn't need to have a lot of privileges to use the pre-loaded program
> and the pre-created sockets, but this mentioned use-case here is different
> where qemu still needs privileges to create the sockets.
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
>  net/af-xdp.c    | 80 +++++++++++++++++++++++++++++++++++++++++++++----
>  qapi/net.json   | 29 +++++++++++-------
>  qemu-options.hx | 23 ++++++++++++--
>  3 files changed, 114 insertions(+), 18 deletions(-)

Hi, Daniel.  Thanks for v3!

checkpatch complains about 2 issues in the patch - a missing braces and
onle too long line that can be wrapped.

There also seems to be some issue on a cleanup path that you attempt to
fix in the second patch, so I reply about it there.

Best regards, Ilya Maximets.

