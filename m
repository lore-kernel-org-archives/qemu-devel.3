Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66324C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSwg-0004Ds-VH; Wed, 09 Jul 2025 07:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uZSwa-0001Qs-S5
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:26:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uZSwY-0003pC-B0
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:26:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso10467127a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752060388; x=1752665188;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/S7AYaLubowLTfUYbcjt0sHgZ0B1vU1xSKBXZ5SoiKM=;
 b=evi9DbX/BVrjrgbCAm9oOy13PUDvL22nOlAp8t+BnfBPzy54VoiQymdi+dDPYAzhJc
 mA6ZJ038vf3QYYhMysZn7Pgb2V3trY8qKu/kKFkJnsD6kulpALVBDVZLdXtc1YOq88ou
 lata0ERZ9ZYshAZqSfu9NZNBkdBcGPYAMSf3nMcbiwIjnm+7KX1bF9MkxpB87NgG1I4S
 RG8xwoF66O1FG3wPPsRIFiBoYkXXmTX9WPsnpJXK1zOEQpTztAGcj8gdmCuQklFSA9nU
 KXkhRB7k1JahTCa6HKESFh0+aE8EH4xh8i66TL58fdFGvUhFgdPHXiReLLlXjJaKGSFT
 cufA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjJ9xOlGVt9LVWnHfc6ZKjItoYZXiHi4BigWitVRtZwMEiiC/VyCArIpo0+Bk/z9rjKFiVf9SdiwxU@nongnu.org
X-Gm-Message-State: AOJu0YwPVu0ZXQMFE02myYOMQ6Qd9UWuqEXqk4dXXq3TTcdKFTwMmShT
 dKTAd91fHCeRvpth3mJIzzh5mzZgBWbmIvzo2lDrxZNU1bWBw9IVq3ooaGFytpIF
X-Gm-Gg: ASbGncsXQF7v/9LzKV9nS1mR2E/KOvCLNr2KV89qxkQvsn2J7Mseno6GyIcXrkOVCN3
 JW3JLupUF9zU3wuQTEiOiUpsIMYkKZy1davQiP8C+PGAPNTb3mbiknrTdT/9FpgJopyv1GJQzsm
 EZKmCaBH6sTxvFJSDAfRmZTjOBayXTVtUdjTTJYL/8oK1ZkKrlwmgML8nJF/rEYj+Tb3IcI/jas
 a2eArrqPUP/9Q5yZHQkcNgAnoh1VFXzKPKyNEXwb+HunMQC18380attlIyBH2HQyu9aufWXcCut
 e0EO+NxO7RleSOR0oVH5I88HcN4ha9mdJieaQHKMcC8/JdLd6I5UbkL9ufQpmebQyN+6W3tmbQg
 ibkmDSZVEu1fFAzZlXA==
X-Google-Smtp-Source: AGHT+IG+Un85qWqgQ1djyS2GqeveuLX/Mj0tPn6nKRKsC5nof0hTQDZiTJx2VQHXLnmWaUSGScCtNQ==
X-Received: by 2002:a05:6402:3489:b0:607:94d:9bb0 with SMTP id
 4fb4d7f45d1cf-611a6e43bdamr1771519a12.22.1752060388180; 
 Wed, 09 Jul 2025 04:26:28 -0700 (PDT)
Received: from [192.168.88.252] (37-48-10-116.nat.epc.tmcz.cz. [37.48.10.116])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb2f3122sm8617982a12.57.2025.07.09.04.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:26:27 -0700 (PDT)
Message-ID: <92069a98-f3cb-4d51-ac4f-e2676c5ff0ab@ovn.org>
Date: Wed, 9 Jul 2025 13:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v4 2/3] net/af-xdp: Fix up cleanup path upon failure in
 queue creation
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250704130531.144325-1-daniel@iogearbox.net>
 <20250704130531.144325-2-daniel@iogearbox.net>
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
In-Reply-To: <20250704130531.144325-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.68;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ed1-f68.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.039, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 7/4/25 3:05 PM, Daniel Borkmann wrote:
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
> called as expected. Note the error_propagate() handles a NULL err internally.
> 
> Fixes: cb039ef3d9e3 ("net: add initial support for AF_XDP network backend")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> ---
>  net/af-xdp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index c5d3b6a953..29c5ad16cd 100644
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

We should also convert the "no XDP program loaded", I suppose.

> @@ -506,6 +505,7 @@ int net_init_af_xdp(const Netdev *netdev,
>  err:
>      if (nc0) {
>          qemu_del_net_client(nc0);
> +        error_propagate(errp, err);
>      }
>  
>      return -1;


