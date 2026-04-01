Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16372D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rv4-0002Cy-Sm; Wed, 01 Apr 2026 05:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rv2-0002Cb-TH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:31:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rv1-0006X9-AU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:31:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so61161685e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035882; x=1775640682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZC+6dvfmTCUMUyi8d0S0F3CmM5sjneA/rIOKX2zmHQ4=;
 b=gDJyKKXr4l0LVhROwLfAWRfkG1kBxepsosdpsTIcb7e7cRDMjx1OQhjBxxMRCGZDvO
 cT33qGwFODnIOYZwlcdNN0Y8oT9zrp9DbqpbLzTTo6ySqpU9jsl3LcuL14RNl5PCN1Ys
 pR4SpXE3v4tEmMVE8t5H+ya5CuGr+Zozjqq9v/LBXG7GVfqnrOf1kzLAUK2RTPRdgixh
 f1++cxD/O9vn4ry00OBQAje4ybVAQPq1LjIFpCHf3q57b3W7otYG26wR93D2dhlUuaIj
 peLHk+7Z8+ewjQd9mX2DrPx0NPrRF5ZaIMfX8MY0DjOe0eMcsZbRET0sE/DQrk/rhNAa
 Uaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035882; x=1775640682;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZC+6dvfmTCUMUyi8d0S0F3CmM5sjneA/rIOKX2zmHQ4=;
 b=b7SKpzyzYhQfmYT2EoxQQd+7oNlfA4jX611Jo+zuCHFA3OqEbDhp/pGgt0JdbSjYpO
 jRHLz6S+oTfb5+7u86t5lxOoz4SFbfMSTzMEqh94Jvi7+ZqLRtkW1zXCR5uYTxEj8Kbr
 Rh3LTYInpB+GKmK/AUAxlak4m7gejKtAsbHkp54KvfbSajqJwb/m/d9UWTRLkUAFO5DN
 0QU7szsObQs04Tpn6n8lLnJQacf0guDRvl8bbadejO+gZq7ex3iVEPrruQ6flAJ30Nyg
 tqRvdkdhCFXesT59/E/x10z6Fw2EgJA/BqZBzSDsWO+TNve7XUvsiOWnUyAxYb4DEvI6
 YbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW58eCyMkfFvsogJBcdknGd0ma+19yXMa8G6gpWqopquGFHiQPXzF87egVSPMaHwEtXTbSRr5G1W8Bw@nongnu.org
X-Gm-Message-State: AOJu0YzItBFhORwTDSnHieb91k+lPn+75S3OOz6FMoxthgELXOvjEpwZ
 9Ztd53y19CRA63DgW3vb45vMyqzxsCDkOKxdpQTky+xUn2ko7fEu4peXcLgSfG6osAU=
X-Gm-Gg: ATEYQzw9BQ5xEgk0IW3xCOb+OrbOOCpp18q1sAXi1vlWEiKV0enOw5qLSv6l0CU134X
 KoD3NjeKH8WT7LCBaSVmV9VLWE50TG4Nd5t7lBFSxyafEqt+13xw1b6zGocrPBmaqbClg9JcP2m
 PoScJFXjOECvoYgiot1/jUHQvjHFu72WZh3yiXTp2uX3QgQ+Lsu9jgO6I8f7VgT8e2qpscx0kBp
 /c3Ntu4I4FvIBTyFRTO+dXjKDXGcB5xsyU4kuxGqnyOty7dJGrcpcz3tXCRCqvX5T+Otr5o4j04
 9xr1EfueVOxc3B9OK4w7akbEwiZyLwv04KeDM72ABbODkV2XravGCj/DN6r7GzOXFxraR1wHi+B
 jGJENEXb8yXgKLpPxjX6B9XVYk5mHw1wBMFw+Uy3YUIAZ/RDNGE0rnRptJSazBodOHDMg3j+WzM
 Z4dYUWmwHgPIUZpGs6dC+ORQqmagg9Kx+b2YBV3uR7oYW1K+zcmeelujbpT122dsgO9w==
X-Received: by 2002:a05:600c:c87:b0:485:3c8f:e4d9 with SMTP id
 5b1f17b1804b1-488835b7813mr41264825e9.26.1775035881544; 
 Wed, 01 Apr 2026 02:31:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f173dsm37344591f8f.15.2026.04.01.02.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:31:20 -0700 (PDT)
Message-ID: <c532f836-b520-414b-9ebd-73f577871879@linaro.org>
Date: Wed, 1 Apr 2026 11:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/60] ui: move DisplaySurface functions to
 display-surface.c
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-37-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-37-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Extract DisplaySurface creation and destruction functions from console.c
> into their own file to reduce the size of console.c and improve code
> organization.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console.c         |  96 ---------------------------------------------
>   ui/display-surface.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   ui/meson.build       |   1 +
>   3 files changed, 108 insertions(+), 96 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

