Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BECC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLnb-0006Zc-0S; Mon, 14 Jul 2025 12:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1ubKrK-0008Ia-QN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:12:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1ubKrI-0001X4-OY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:12:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so8630619a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752505966; x=1753110766;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdKEmZdjzuIsI1cKzquHViMuUcviwY1cgigojX2/erM=;
 b=B3rVpJHniZ6icEQo00nS10YLkZot4PfU9H7uRiy8LjJIJY9XVdxiwhgrxIHArNiYqF
 psk30YMLN7Nr3Rio5Syfv4dbgArA0I/ii8mRfQsnhbFVCZ1IbZIrZ0V7xnpz6SRoNMVm
 vFWhIFv8SKRkJNasc6N1jXLiQ/eC84pPu0ozhgLKWultWP3JFSPjRtoLsRP2m9d8ryYT
 FbAK7zhY3kvTim6w8fwR6JlpXM0Uwfcg8khnPTbK6nSA7ORmPjHz3SlZh6awFMMtWkZr
 S1Z9oa9qp+NOwLX5YCBX6Q31WAGpNnU2nONp+PoknUACrbUgKR0JoBSNictcFXcq17AX
 0rUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7cPLJPlUgT3j4CezOJwRM/nrBuMWa1B5cKBPBKGDd9ldC022N+41SXpdGZmdwTTJ/ht6qU57fwbgl@nongnu.org
X-Gm-Message-State: AOJu0YxNqcK1ApPjI6PaxDsErPq7Xxl9mblyc7OB0SIeuM34lTNTtmUD
 U/+FFx9yYYOoa5y4wqrWoHyU8tCDrSnvmUykPsN9pGG9yQApAaQ6GKKQ
X-Gm-Gg: ASbGncvH3o3kf8Jy0bsO1xYKuV6kNLAAkoaNkMBwMrc/iM2g7fLe3Dz9g0jdAUZZX/u
 lXSCz3kpQotUFn4qMewWYK0RNCsNaPxEg56/mGTpW9Wiu96Jv/TS7S/b4fwQc0NjR9+oZpR8KfF
 qghPmgYCB6q9lQnFNz4hoHpsl9A2X6EjJ/w3zzh+qvCHF/jMsQj5cHsh0fRc7dm6wOVqItgjnOP
 1LjmkOV8M2TtRYpMOia2OPQYoNjuhLUVY5/omBUABgx3avC50iA+qCLR+HFe+hnwBUYbiara/z5
 Cc6ZaJen5Q77GYwtzuiR4EUcL2r595qE1HnVL+rIoulaYloU6rO/1hIJ/M7y8xFX6+XZnb71XGf
 AIgDkql0+i7Dy06bGH0hHYZWh4ajw4aOBFD3eHPqcfXQniACh0hubkQ==
X-Google-Smtp-Source: AGHT+IFL0dC/3LYMSE356mhsA4rYQ4f+oHk2rWEvdMmlJbs5iMZfRUPtLIJcwIKtEEjz13ahulr9LQ==
X-Received: by 2002:a50:d611:0:b0:604:5cae:4031 with SMTP id
 4fb4d7f45d1cf-611e84cd4cfmr9256493a12.28.1752505965593; 
 Mon, 14 Jul 2025 08:12:45 -0700 (PDT)
Received: from [192.168.88.252] (37-48-10-116.nat.epc.tmcz.cz. [37.48.10.116])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611d1062950sm5791768a12.65.2025.07.14.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 08:12:45 -0700 (PDT)
Message-ID: <b067d5e5-0113-4b22-8bc5-484c8e83ca1f@ovn.org>
Date: Mon, 14 Jul 2025 17:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v5 3/3] net/af-xdp: Support pinned map path for AF_XDP
 sockets
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250711094416.247125-1-daniel@iogearbox.net>
 <20250711094416.247125-3-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250711094416.247125-3-daniel@iogearbox.net>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 7/11/25 11:44 AM, Daniel Borkmann wrote:
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
>  net/af-xdp.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++---
>  qapi/net.json   | 29 +++++++++++------
>  qemu-options.hx | 23 ++++++++++++--
>  3 files changed, 118 insertions(+), 17 deletions(-)

Still works.  Thanks!

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

