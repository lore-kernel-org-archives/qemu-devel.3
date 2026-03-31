Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8103FF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dOa-0005p1-Up; Tue, 31 Mar 2026 14:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dOZ-0005mV-Az
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:00:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dOW-0002Wx-FZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:00:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so48420645e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774980050; x=1775584850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBOdQWR0X95ktdsG/ES3ZG+QZR6q8wrARFffa5ux6Bs=;
 b=QcUvd/Kvag+aUq0rJssy20+EJYlDUre+5d/9V7zhCitgdzIx/nAqUKn4sY8DDHWjNY
 WNTwx4JLCRwxt+HKaacyu3U1gYMRVCmVCH1Ks6KsnOU96Z97gdxH4QU67t+uxZFUF0KB
 xifhcM/qzp63JC1n/NWq9Qx/I7NZmCV9JqbocyFVwlbkhD8xkKsi50TId7MX6sTHOA8f
 o4BT3nfyAVZ93/FRJCysmJJt8YDnyPy1fRFCewaP+5yMNtFGAqMoCbn+BKQIePzmcV1M
 Rm91zFZsAJTsithjFcD147+g6VKFpSmS8k6+KZa+wLUZcoYRSDroevSSyY+F3B/4GNca
 AFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980050; x=1775584850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBOdQWR0X95ktdsG/ES3ZG+QZR6q8wrARFffa5ux6Bs=;
 b=bmgBMiyQ76TZ8KKU9mR/mEmxH6/4yfwbURKo7lz5TcUiLE022sslx+0PRsgC2dfb5z
 i4F7EFEqjwLVWHI4iWtX6IOalHCAu2bdulj2QPC/UwMRnDp10kdXmCgPsPDhVJAseRmg
 5QBVDUev2qaX/oUoJQp4+RDsKsDzR7yP5oNmFGfWcLydCKekebCyHYvaZy4da9g8UX+F
 N0fmzplH+4Wa+wRxfc9ayMnK+ooJpuoK7pUgcyBIwGBK5Gpxd2JeY6Sw6TyOLgRh++mz
 /W2pJpD86iYO4GmxS1d/2qPCUZY693MhvmRaFaTdhVqMVp8VVKRjf0P2GlclljFAIRHd
 vaYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ8ccNwNIc4IHYyUlh4oJ824l4P4fcNiYzzAl5jfm1VlZDYSLF0OwDu8jmDgobuMXdX+K8WhRvVmq+@nongnu.org
X-Gm-Message-State: AOJu0YzRAV7fxPbPFX6Y4W0hlL8zCI4x2Sx1x7r6KkmkADpn2Nn2kojc
 2OMJqBsSMSKrkhss3f4yKcgJMad8uep7u4e0FQA7XqSBzAAeDLrUxQHjnVCBgR9QlOxe4A+Kznp
 zmtJlSVg=
X-Gm-Gg: ATEYQzyFQJec8WW8XIAX9g04lEWYGGK3h3nrdpYmr0SgyNmLpTaYCAa4uvHbwN1SPiI
 /33dwg5FbPcnOWNzU0FBBnx0cdAMJOua1JWJfJcR/cnLYfvn9U3NTdqy+BcT285NpQHfbl0N8Uy
 P7a1+R13mcVNQ+4SeHdd6lJ+nKK8E8OYCwITN4RSkElP8EUhy0r6rPVoPxgbTBidOWKUsgZ0UIt
 EqSndWK2IVRVVpcCVzu+/m5vn0i2p2/ZSNNmndroVrqyPQZqN4Nh9f3hlhqJ4bQUmmr/iCvayHN
 5qlqpo/mpswjP2mCwoLPrDbgbYW/kvL7s19MuojsobKZR6/+rcSDyT2gpZDhd74AIhaN0syeWue
 2VWpIF57TY4IN+rt7Guk/6jQ95JP6Q9XgxTsuIjAxOA5PfMtlSV/MrEX3rN3Dk1fzICrmF9D8C/
 PiJBeuD8rYOBUiuclUgSgsV93n/bd2aVsDV1I+ElTbx22/UqlMLeqNGO0lUIEh7L4kkw==
X-Received: by 2002:a05:600c:4f95:b0:487:2439:6266 with SMTP id
 5b1f17b1804b1-4888359cfadmr5452255e9.30.1774980050272; 
 Tue, 31 Mar 2026 11:00:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e822078sm61982165e9.9.2026.03.31.11.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 11:00:49 -0700 (PDT)
Message-ID: <dde36325-c9d0-4ed4-a1dc-18124b97693a@linaro.org>
Date: Tue, 31 Mar 2026 20:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix crash after setting latency historygram with
 single bin
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, qemu-devel@nongnu.org
References: <20260331102608.60882-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260331102608.60882-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 31/3/26 12:26, Kevin Wolf wrote:
> Passing an empty list of boundaries to block-latency-histogram-set sets
> up a state that leads to a NULL pointer dereference when the next
> request should be accounted for. This is not a useful configuration, so
> just error out if the user tries to set it.
> 
> The crash can easily be reproduced with the following script:
> 
>      qmp() {
>      cat <<EOF
>      {'execute':'qmp_capabilities'}
>      {'execute':'block-latency-histogram-set',
>       'arguments': {'id':'ide0','boundaries':[]}}
>      {'execute':'cont'}
>      EOF
>      }
> 
>      qmp | ./qemu-system-x86_64 -S -qmp stdio \
>          -drive if=none,format=raw,file=null-co:// \
>          -device ide-hd,drive=none0,id=ide0
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/accounting.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

