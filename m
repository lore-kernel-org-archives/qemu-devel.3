Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9F5C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYfb-0003KW-K9; Tue, 17 Jun 2025 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uRYM1-0006F5-LM
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:36:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uRUyK-0006xW-3h
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 07:59:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso9937275a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 04:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750161562; x=1750766362;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EU0DCQb/zd9WyUxYMFIGRJc9j60ngOl4viJXnSpEIdM=;
 b=BUlgxlCbCn3+UGy5xTGnkHosVlnqfOwwR2CXXcanJX/qHdB9eOROi1iPnAWBLM48IC
 GYA4buqlCFOJGPrklvg1iOqOnH+CEP1q3rVaqB6PjC23t9Qv0852xQ3RpwOfKUFhzair
 WT2mhJmyoITUD1mI8CfZOjsPB3yigYDKDyGV9l7+PuTO9XbLwt/UMB9iVnoygSJv6ZWU
 2kvyAcn1CqRfN5CguThWuE0sxb8NaBsYNVfn8iO8PRfpPNgE5WWFWUDHgEKOkC728JRS
 4uEH7WSlWSg7/L6Y7rTM+dvbr9CI234sVghIkfwVG492nhXRgJmqe+kwuKaluiyiCekm
 VAGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbiolaPzXSvwDEOQqfcuRKQbnGx4rbLYoo2eSbeaOvIN0O0IOrzibR0V1zWom4pt3pmsnA812mh8qB@nongnu.org
X-Gm-Message-State: AOJu0Yw8B9gkkGLg9DHOmnnjq0GaiiPAfWIoHYZOcsAX8EGVsv2PfkiV
 E7J9IPjlfnNyZmW1ROwOJk+wqxhMIricohFxBT9JeYCBnFn5Yza0DrD3
X-Gm-Gg: ASbGncs3iKKwfzwg0Ljr9gyHwZ8PiyYMXr0Q7KM/A8OHPwuzgCGYyb5nCY3bZgwINqN
 Fy5dS1D3rW8ThKsdk1ip/TlJ6sEUHSxEz5n0LW9tHwvZpH0+O60/jOd+Myaxx4AAdhFnLM1UHGv
 soyP9VfF1QSVGXScIA74bt3zpq889cxK0PnUvElAf7dJwQJ6HTAFmdbZotjt5RPEDJG2mARfMAN
 BFIb9lt26fkv5BuGNh8Tc94qTCzbi2DErYd4bxu9NRGRcjUmD2Nym+xbx7Dun7UwGQws9b/yxYu
 01l3p8EMD+9FMZ+31rNLrLSc1jTfnCeVP9AEXQWx7bpUirfm7Y5s9rMVTjqr3c3Zdz6irI1Cq8y
 IaSrSVfHFY49+wwqvwUyK
X-Google-Smtp-Source: AGHT+IGD80YnBZ6Xyz3YA/r0wute/DqTa0eS6djh4+3Iyh/GyqY8a3Rw+jHNzsYYseRlduFjErwydQ==
X-Received: by 2002:a17:906:6a1b:b0:ad5:7234:e4a9 with SMTP id
 a640c23a62f3a-adfad54b256mr1282817066b.28.1750161561350; 
 Tue, 17 Jun 2025 04:59:21 -0700 (PDT)
Received: from [192.168.88.252] (78-80-97-102.customers.tmcz.cz.
 [78.80.97.102]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adfbfc777c9sm550579866b.118.2025.06.17.04.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 04:59:21 -0700 (PDT)
Message-ID: <945f230c-052b-43b5-b1c3-b8c450c21327@ovn.org>
Date: Tue, 17 Jun 2025 13:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v3 2/2] net/af-xdp: Fix up cleanup path upon failure in
 queue creation
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250604112916.1195368-1-daniel@iogearbox.net>
 <20250604112916.1195368-2-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250604112916.1195368-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ed1-f66.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.068, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 6/4/25 1:29 PM, Daniel Borkmann wrote:
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
> With a conversion into the above format, the af_xdp_cleanup() handler is
> called as expected.

How exactly this prevents calling the cleanup function?  I don't see the
errp being checked anywhere in the qemu_del_net_client() path.

Could you provide a more detailed call sequence description where the cleanup
is not called?

I agree thought that the local err variable is actually unused.  We should
be able to just remove it and remove the error_propagate() call as well.

> Also, making sure the XDP program will be removed does
> require to set s->n_queues to i + 1 since the test is nc->queue_index ==
> s->n_queues - 1, where nc->queue_index was set to i earlier.

The idea behind 'i' instead of 'i + 1' was that if either af_xdp_umem_create()
or af_xdp_socket_create() fails, we do not have xdp_flags initialized on the
last queue.  And without it we can't remove the program, so we remove it while
destroying the last actually configured queue.  And this is OK, because the
failed queue was not added to the program, and if the af_xdp_socket_create()
fails for the very first queue, then we don't have a program loaded at all.

With the new changes in this patch set, we have an extra function that can fail,
which is a new af_xdp_update_xsk_map(), and only if this one fails, we need to
remove the program while cleaning up the current failed queue, since it was
already created and xdp_flags are available.

If we get this patch as-is and the af_xdp_socket_create() fails, we will not
remove the program, AFAICT.

Or am I missing something?

Best regards, Ilya Maximets.

> With both
> fixed the cleanup triggers as expected. Note the error_propagate() handles
> a NULL err internally.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> ---
>  net/af-xdp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index b83d9bc47f..5d9857fdd8 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -559,12 +559,11 @@ int net_init_af_xdp(const Netdev *netdev,
>              s->map_start_index = opts->map_start_index;
>          }
>  
> -        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp) ||
> -            af_xdp_socket_create(s, opts, errp) ||
> -            af_xdp_update_xsk_map(s, errp)) {
> +        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
> +            af_xdp_socket_create(s, opts, &err) ||
> +            af_xdp_update_xsk_map(s, &err)) {
>              /* Make sure the XDP program will be removed. */
> -            s->n_queues = i;
> -            error_propagate(errp, err);
> +            s->n_queues = i + 1;
>              goto err;
>          }
>      }
> @@ -586,6 +585,7 @@ int net_init_af_xdp(const Netdev *netdev,
>  err:
>      if (nc0) {
>          qemu_del_net_client(nc0);
> +        error_propagate(errp, err);
>      }
>  
>      return -1;


