Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485D4D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 23:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlbEq-0008Qb-6a; Thu, 29 Jan 2026 18:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1vlbEh-0008Mf-Kf
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 18:15:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1vlbEf-0006Iz-79
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 18:15:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1309308f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 15:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769728535; x=1770333335;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ga29pGtW0g69PcOEe+rqY7Q6ZVSWV71Fiea6pHEfK8=;
 b=RZdG/7JqPDL05qu8sahHBnKAvoR8Bd9RJpSJedomajKyU6e5JzDq8/t7qSvISy+xVR
 x0zR6EeVoKj5V7TTAZPTA3yMAlHOzqhDe5clI41MBZHj5O0cHUz1ysmmB9iuepCr49zR
 LJpD9qt6IEfkRpV04aRuUL1565rUd3NfbJkjxmvOZ/tWDd88qo6DRIqpF88Ey9jLX3aN
 zNw+bu1wnldrPUMpIdLosBfONY/K0QNzV7eIC4QA+aUYdiGpK7Vzip8XS7n6BQpqn5ze
 Oob8o6G7kEPo4k3vwTr8nOGt0Bp7az430NhJhJS58SbN5hUaPXohwpemOL+tXCdOSAzk
 P8Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUnzI3DKpHML9thG1CE8HOrNjRHS0pzdEfnKSgsUDYnjtN2mL/NQCxvixsAWdk0U7MwpPyysdxnaS5@nongnu.org
X-Gm-Message-State: AOJu0YyY2xq55kmqJyhCnmiEgmolh5s4QxhLE3CZNLt+bZ18rnxUyDKo
 Y0Ti544c8CM1jBuzrbNbpxS/V9oCEQOyIsXgGTeZ5anFw4Mr7C6naRtP
X-Gm-Gg: AZuq6aKasmIiNrPQJl1h35Sv8Ha+GUpnjPGiSxomLKGm6ovEnRhw4tBz9uzus/0rF9A
 93+idO6PkmRdN67rmO3MDXU/8YUOVB6D0o5s4E6JVNiqIt9M4VxoePUx83tQNK3iupSqEMM/OkD
 YJOmABfiWvoxuLqNcjNpBoMUafm1PLARRDvNzeGXPMYaBwDTbv5igsnYepCUrNVXf7EVxJEec5a
 sK1x2jgCZ85tLDFYwa3u8h/ZUfSQn/iKQnW0IhpSCgdclG1F/1oXXRDpUw3yhdtyIyE/k/yT09i
 JWf+lz5cZFG6vHmHWC16KNRW8NopbakqlXrlIwMbECIvz0ZJtZ8AN8Mn2Sbv4KVAbwJXzO/WnWG
 L24BLTdFcXUOevQQR/KaMcIme+dPEsdTcdAzunMtcfpuXKg+27yPwD56kddPImphZGjFb9lTMBg
 7WFExfGGMFv9rBRAC1E0OwwMlO7S3cGW6fNzoU3HpQET5CGC4=
X-Received: by 2002:a05:6000:2384:b0:42f:b581:c69a with SMTP id
 ffacd0b85a97d-435f3a63467mr1768124f8f.5.1769728534773; 
 Thu, 29 Jan 2026 15:15:34 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10f82aesm19318860f8f.19.2026.01.29.15.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 15:15:34 -0800 (PST)
Message-ID: <c3bfb469-330f-4f61-9062-c877f29e2f5a@ovn.org>
Date: Fri, 30 Jan 2026 00:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, qemu-devel@nongnu.org, bchaney@akamai.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260129213215.1405459-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.68;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-wr1-f68.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/29/26 10:32 PM, Vladimir Sementsov-Ogievskiy wrote:
> In for-loop in net_init_af_xdp, we do nc->queue_index = i,
> where is is int64_t for 0 to queues-1, and nc->queue_index is
> unsigned int.
> 
> Also in parse_socket_fds, g_strv_length() returns guint which
> is equivalent to unsigned int.
> 
> Let's simply use unsigned int type for queues, and update
> the check appropriately.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/af-xdp.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 14f302ea21..bb7a7d8e33 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -442,14 +442,14 @@ static NetClientInfo net_af_xdp_info = {
>  };
>  
>  static int *parse_socket_fds(const char *sock_fds_str,
> -                             int64_t n_expected, Error **errp)
> +                             unsigned n_expected, Error **errp)
>  {
>      gchar **substrings = g_strsplit(sock_fds_str, ":", -1);
> -    int64_t i, n_sock_fds = g_strv_length(substrings);
> +    unsigned i, n_sock_fds = g_strv_length(substrings);
>      int *sock_fds = NULL;
>  
>      if (n_sock_fds != n_expected) {
> -        error_setg(errp, "expected %"PRIi64" socket fds, got %"PRIi64,
> +        error_setg(errp, "expected %u socket fds, got %u",
>                     n_expected, n_sock_fds);
>          goto exit;
>      }
> @@ -484,7 +484,7 @@ int net_init_af_xdp(const Netdev *netdev,
>      unsigned int ifindex;
>      uint32_t prog_id = 0;
>      g_autofree int *sock_fds = NULL;
> -    int64_t i, queues;
> +    unsigned i, queues;
>      Error *err = NULL;
>      AFXDPState *s;
>      bool inhibit;
> @@ -496,13 +496,14 @@ int net_init_af_xdp(const Netdev *netdev,
>          return -1;
>      }
>  
> -    queues = opts->has_queues ? opts->queues : 1;
> -    if (queues < 1) {
> +    if (opts->has_queues && (opts->queues < 0 || opts->queues > UINT_MAX)) {

Not a full review, but this changes the logic.  Zero is not a valid number
of queues.

>          error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
> -                   queues, opts->ifname);
> +                   opts->queues, opts->ifname);
>          return -1;
>      }
>  
> +    queues = opts->has_queues ? opts->queues : 1;
> +
>      inhibit = opts->has_inhibit && opts->inhibit;
>      if (inhibit && !opts->sock_fds && !opts->map_path) {
>          error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
> @@ -537,7 +538,7 @@ int net_init_af_xdp(const Netdev *netdev,
>  
>      for (i = 0; i < queues; i++) {
>          nc = qemu_new_net_client(&net_af_xdp_info, peer, "af-xdp", name);
> -        qemu_set_info_str(nc, "af-xdp%"PRIi64" to %s", i, opts->ifname);
> +        qemu_set_info_str(nc, "af-xdp%u to %s", i, opts->ifname);
>          nc->queue_index = i;
>  
>          if (!nc0) {


