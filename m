Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D141088E6F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3W6B-00057E-Oi; Fri, 20 Mar 2026 05:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3W67-00056L-Gj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:24:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3W65-0006CL-Lu
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:24:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so15994945e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773998678; x=1774603478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5kgzX4ieFGXRYcPXVpN3E8TddwbVg1TdWrdVqW1hFXI=;
 b=ACke5UZEKOM7eZoJbu65nZAkGQgmdz9ScWFzrX+3mcQ5KR2DZ4LL+XnKEwQLPplnrf
 m16g9y9RfIRmbxdCoNc1h32dJxc6JmANswP9Ry3mCP7h2Hc/hdK74KmixeN7ciSkMdjb
 Mycqjps/60NNmrKbXcOd96H5a8udWGiKIQ+Y1rhqo9HV0kv6Ri4gl2LZbf1Jgf45wv2K
 S8VTXvGuyUGTOSBobWqMkltgNeLPAJnfMJYQ1QHZSY02l6jUi848f79X0C1CZQZy9C5z
 sg4urDIXtpy9+JPGgKfeZRLx+U0JK7ijOzaxSG+Pqg9wjlAwaHpFtz1jo0hyoWEbHzf/
 1yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773998678; x=1774603478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5kgzX4ieFGXRYcPXVpN3E8TddwbVg1TdWrdVqW1hFXI=;
 b=OnqMpqZ22QI51XoAggMRBRtctb1TZCN6uqu/drH41ae4tTzn2PvKuY63vpDYKXj2EN
 psDu0gRrDmX+DQ0ZbMwbEBrL1/f98E2NF54CnyAqMeU/KV1w4giA/geZfbzwr7R7vpnI
 HZ6zWw0yLq6p2KIkhRkp34F/C2K+wgoG3UbcDr61CcElL9hm+0HW+ZQaUTQ5S3prdazO
 QHCaFz9T63V5ke3cWPVyzstJ1yUQWdkBYU2CVV/o/F8/6wGVZTZGK4usYkyTT09zOG+w
 DosswmbVXezK5JOp/pXC0petgTIyR97Q0DuoIfvJpHwo0l6qj2gqwqUtWbdmJx9Vc9xR
 ZgLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8eWTiY6LsZ4XH5U6ntl1Scwo/1S2rG/PVe7qKkPzzK/tkXcSM3LIfSNK7MZjRvX9NeNN6JnGhAKXi@nongnu.org
X-Gm-Message-State: AOJu0Yx8e5+eFMBIjKThvWLLniGH9qEFr/pRlZEU6ycdM44B3bDj0sZ4
 L/XZLg7DNuBpDnU4TzbcnynEGav52KGiLP3G1TJb5d8tfMZRrqQNMQjYBrWXl+a11pc=
X-Gm-Gg: ATEYQzzJy4u52I1YP1gr1gn3FIsIra1ag3EbjXwdkGm4z0ba6QhIhReCcUUP/NTMNt/
 ZnNyOaZUwkB0ATgn5qsjoMIIvG5Y2yP1060P0oT277C6Yzw87n0QglF5aMH69GWh1Do9EwhnF+Q
 wpJNNZZ9ZhHE09JRpDFdt4urKAMdSJSowRaVKY5MjD/P7FW3zs8/mhnuhC/PMCAvUg1FNcpU6b8
 RuJkYuoF8gqkpsBpBx0WLdI62G8l4Ed3zQsvxA2dV3Og5gxeJrtcNkWMGYR+HHxY3UlgqYGKhKs
 3meDP/gSwgHEtiiL09IdKu927hz6bGaQJFEdSKnH9RPdaROuIsGoX49yT5xiD3RYXbSge9mtGWr
 iiS/0bWbh1/W0mw9E0ynDF2tp+qglm5sEAimqOkB8JXSeuruMEwhfffZ9Os2VR9fXtVTKqsjBcz
 wlq7AwrphjBt35X7x1GJuD8+Kg1NWTWGKDAJP+gck2tjFuwKSACj0AB0C+M0C3QbK0rA==
X-Received: by 2002:a05:600c:8b31:b0:485:40a4:364 with SMTP id
 5b1f17b1804b1-486fee1af50mr32457745e9.26.1773998678468; 
 Fri, 20 Mar 2026 02:24:38 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe836784sm44201095e9.13.2026.03.20.02.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 02:24:37 -0700 (PDT)
Message-ID: <05d1b4b2-5b05-44bb-a6c7-fc7f6afd512c@linaro.org>
Date: Fri, 20 Mar 2026 10:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/curl: free s->password in cleanup paths
Content-Language: en-US
To: zhaoguohan_salmon@163.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20260320063016.262954-1-zhaoguohan_salmon@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260320063016.262954-1-zhaoguohan_salmon@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 20/3/26 07:30, zhaoguohan_salmon@163.com wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> When password-secret is used, curl_open() resolves it with
> qcrypto_secret_lookup_as_utf8() and stores the returned buffer in
> s->password.
> 
> Unlike s->proxypassword, s->password is not freed either in the open
> failure path or in curl_close(), so the resolved secret leaks once it
> has been allocated.
> 
> Free s->password in both cleanup paths.
> 
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   block/curl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 66aecfb20ec6..419df78258bc 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -903,6 +903,7 @@ out_noclean:
>       g_free(s->cookie);
>       g_free(s->url);
>       g_free(s->username);
> +    g_free(s->password);
>       g_free(s->proxyusername);
>       g_free(s->proxypassword);
>       if (s->sockets) {

Should we directly call curl_close() here instead? Otherwise
factor a common curl_cleanup() out and reuse?

> @@ -1014,6 +1015,7 @@ static void curl_close(BlockDriverState *bs)
>       g_free(s->cookie);
>       g_free(s->url);
>       g_free(s->username);
> +    g_free(s->password);
>       g_free(s->proxyusername);
>       g_free(s->proxypassword);
>   }


