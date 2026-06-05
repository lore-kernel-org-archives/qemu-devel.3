Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B16CD6E7E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 19:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVZv6-0001CC-4l; Fri, 05 Jun 2026 15:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1wVZv3-0001Bo-Fk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 15:09:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1wVZv1-0003xP-Hh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 15:09:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-490b4e1ade7so25057015e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 12:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780686560; x=1781291360;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2U4MoH19+47n0M8gVxREeWPASe9mIFY1o6i8auX+c0=;
 b=WuDymaZNzfB1jToQqcZbJz+1xertX/jSnWOlgDbzvPhwNaQKWuSRO7x2cMUYld/ea2
 SMzuGXBO+Fy/IXziuEb4b1YlDT/C4L8rs0+WmsgkrBP0puHx2CU9PFGMX7UTdtFGECze
 z3fbTuzg94xAC/0+n+UtT0bBdhcPoIQavl6Kd3LeEum5XmKl+Ozr2BM5o6Bbevf6gQMe
 N8mzplpV4Cj0Ntccv7pqxHb8pAtsje5dMbS3fvRHQHQFMyTtFr51+Kt4+1zG25xEVpAU
 t35FNRWkPm0ap+KIWIl33BnDDFHuklCTD+e7/D8pnWJUC+QDRZG5dY979k3BAfg9u73i
 WAqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nsp+ZJAXITCDv4QHMmrGTR0bZccd/yyacc3cVMUNDuc42rPRLMzA6wja4LJ40r84Q9joQ84Vkfl9b@nongnu.org
X-Gm-Message-State: AOJu0YzXCHu1mHe7sqNqMRCdhbqFYlhBb97uvln0VoE/ob8XvMFxgc0Z
 rJ/Mxk/MNsIUhOSPNjmPRetuC4XkoVsSknZvOY7fdFlQ32ZG/+vy2LrS
X-Gm-Gg: Acq92OGW1+JNzlpFZ7skh/ZS3XrMqttZvGpR3kmWKGEnGbXMh3tPB+U+jhsrIHvVIe2
 vdvYUa9EmXV+W9HieKrIbjemAO6ruLmRqSeCb6GKWCCxbOfML5XfgPqw9v+4/zXKzoX9K17rVSN
 xphIIpuDWK+u0zUDxG9h2gLz78uqlJwmQ6/ty1ruZRHKbo8J8tWOgxVSdr1s2jz7TRIRM5Cz+Gs
 vdtXoPTSuZ1KxVNsjYkfIBUnOeCDJI7xjt6ijZ/j5QhzVst/daArnYCsoqeqnwemYv9wNsGFYPF
 tFkruSIzE8b2ueHk1uecR7YNw9xuKFdMufLpcMI6Raloa/miwBQI1Lbb5Wts7bOptk/roC+F0tt
 eX0+cHBE/SQ/uERjpECzk9QybLB7baWzr1pytraBGCu/PrlKkIn7fa/rCNQxRHVOE82JE79rvje
 8XIY7Srdc4XKjP97wkQHsfgC2JsqOiD3oGsnJA2LoemK9NRAIEakSigSYKw9MH2lFG5Q==
X-Received: by 2002:a05:600c:608e:b0:490:b202:4772 with SMTP id
 5b1f17b1804b1-490c25af61dmr80971055e9.2.1780686559752; 
 Fri, 05 Jun 2026 12:09:19 -0700 (PDT)
Received: from [192.168.88.241] (89-24-36-255.nat.epc.tmcz.cz. [89.24.36.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d37edbsm76923155e9.2.2026.06.05.12.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 12:09:19 -0700 (PDT)
Message-ID: <8cd17fc3-7f75-4da0-a46d-fcd9fb8fba39@ovn.org>
Date: Fri, 5 Jun 2026 21:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] net/af-xdp.c: maybe-uninitialized warning with gcov
 build on ubuntu2404
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
 <20260604215148.3769627-2-pierrick.bouvier@oss.qualcomm.com>
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
In-Reply-To: <20260604215148.3769627-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.67;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-wm1-f67.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/4/26 11:51 PM, Pierrick Bouvier wrote:
> Seems like a false positive, easily fix by explicitly initializing
> variable to NULL.
> 
> In function ‘af_xdp_read_poll’,
>     inlined from ‘net_init_af_xdp’ at ../net/af-xdp.c:546:5:
> ../net/af-xdp.c:78:10: error: ‘s’ may be used uninitialized [-Werror=maybe-uninitialized]
>    78 |     if (s->read_poll != enable) {
>       |         ~^~~~~~~~~~~
> ../net/af-xdp.c: In function ‘net_init_af_xdp’:
> ../net/af-xdp.c:461:17: note: ‘s’ was declared here
>   461 |     AFXDPState *s;
>       |
> 

I guess the 'nc0 && !inhibit' check is what making things confusing.
I'd suggest to remove the nc0 check and move the upcast out of the
if statement.  Then maybe collapse the two if statements into one.

It seems cleaner than just silencing the warning.

Will that solve the problem?

Best regards, Ilya Maximets.

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  net/af-xdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 1ffd6363a8c..72d75748c6d 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -458,7 +458,7 @@ int net_init_af_xdp(const Netdev *netdev,
>      g_autofree int *sock_fds = NULL;
>      int i, queues;
>      Error *err = NULL;
> -    AFXDPState *s;
> +    AFXDPState *s = NULL;
>      bool inhibit;
>  
>      ifindex = if_nametoindex(opts->ifname);


