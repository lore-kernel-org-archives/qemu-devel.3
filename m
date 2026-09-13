Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229BAC88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 03:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5bJI-0002At-64; Sat, 12 Sep 2026 23:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5bJC-00028m-8x
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:55:14 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5bJ9-0002go-Hn
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:55:14 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso476704a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789271710; x=1789876510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8OKaegf2S5BKtFSNoGGPTbptNQTUx/6Ai3WAJO1X0E=;
 b=xq2sw934uQ1J5mhJ5MAQg3Kyg+L+yXGXetYtZ6Wm6/jmXfzYrmeqgb3b3pI7Ag/84O
 EMNpwtQ6FUO5aa6l7WuNGe9tVO0KdDtP/6JUinwzGOKarojc4HpfkvFoiCrpQ7UNXzNo
 0xAYX2kOMbYd4vvO+0T+8jUiLy6m0JnGMiXCiXDWyJaZ+16sUeYYFzJUZsMrvdq+1i0R
 BPZfIFdzUINGRE+y2L3GX2gWaQ2gj8KbBBgrhSLa16X9UsoN698GKb5NaU6FobFs1hnh
 Jb9lPp7+CsvkrCpzb1D69b6HS2WvEZ+nkeCupRGHO1BMkmqoHyksVQWSAL6yvd2ddyDE
 CmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789271710; x=1789876510;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8OKaegf2S5BKtFSNoGGPTbptNQTUx/6Ai3WAJO1X0E=;
 b=F/gAYsUz4lZa0c50vJHIbQ7wzFpkBcupo1KqW5j2ss4bUQdoRnepd94i2bWntNPg7I
 Pr1hY8DTOYuS88FIIWUdQlahGDy+wwfog0i5blnmTGb2/7F2IgUb6CXH+Tx+XcO6ARv6
 YrGwNm2cvCauCjvFatF29yrEda10yEuSZXHeEqJkv1EWGA1Ts0xtJQce4h0X66IG2Atl
 3SDP/gp4eh/X2mcKFXs3zjPXzdiAdr5XhXzLYxyUSE5lM6/fDtu80JC0ewya2+kBClGS
 bOnZf60i+cgSb/lBQSxG2N/yns2m2qxLhvepEwMsOJc4+xlul5JFzbnULsAou6y0gPxW
 MmQw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJWC7PoMFd2n3rLEusFe+tjK/7QQooUNKXBBUa9X9F02PrAVDHVnAPtfZdDFawxv2oR+6p1BLL/f5D@nongnu.org
X-Gm-Message-State: AFuF++k1uB06XbrfqzjLq8yroKkD1E9Fybq58OCfxZiaFdeff3x/hglZ
 uvVrSDiZ4DrJPHPM88Il7NPRJSFWMJtiJ502H933AgMuXeZzFYXrU2Sq44jgxMER8mddnusLvdg
 UtuWaIwg=
X-Gm-Gg: AYBFou0OZlun2LKeJiMyjYJRG5rDSizyLCX2iysoUiuKdxzHzweHlX5z2rEQ94gz+3M
 s3obRSDxxTAbOMvk2n/muA+OYrUT5j3eUse7WZyPektKrt085s24+0nZ0cVHhkHv4g8CXasu6x3
 I5yz+RHtsQ5M3hGFnEk1fXM1geIl3aYP9h2u5CFCbp71KdI3CZZo7ZTh7gxZqzvw84z4h/jWm/3
 LNkEqMQlmgA5ehXK1xm79Mld//WT4mhkXYTfQesHjvSnvb7e7Wb6/kcqK/ClC7fEC3NycYT0FCc
 4tncHnRcd5owl7+Cstr8oD/flgPwfNP5iCUvfJErFfeFZndMMrm46LyPeH1aaPqogbibvgyDWHV
 ghnPGwyYZpF4hFyX3FO2QNOM5l9hub3UaldIqVeqBwskqzmHDyFCSXjbbrxU/CHjGhKll9ViJKK
 6w8LbMVCQgS7IvdZsR4wSrk/hWpV53xK59B2pWbYsHB/svuM9yNudb84/s+HlH01aJQ60Tp18tV
 Xy5E8kozPIOsxSH7XBMv/0Qr+j0SzuSNAj7RFWeULzFs3m+zxEODZAd9tdBng==
X-Received: by 2002:a17:90b:39a8:b0:398:9beb:5c17 with SMTP id
 98e67ed59e1d1-39dbc6c6a25mr8666911a91.18.1789271709791; 
 Sat, 12 Sep 2026 20:55:09 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba729dsm25656638c88.14.2026.09.12.20.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 20:55:09 -0700 (PDT)
Message-ID: <ee1807fd-eb2d-4fcb-b7e5-e44e64829b5a@linaro.org>
Date: Sat, 12 Sep 2026 17:55:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] target/hexagon: Move to do_interrupt() (BQL
 acquired internally)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
> hexagon_cpu_do_interrupt() already acquires the BQL internally,
> so register it as do_interrupt() instead of do_interrupt_locked().
> This reflects the actual locking model used by the target.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index b5dcbfc99db..7067e5b70f7 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -769,7 +769,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
>       .tlb_fill = hexagon_tlb_fill,
>       .do_unaligned_access = hexagon_cpu_do_unaligned_access,
>       .cpu_exec_halt = hexagon_cpu_has_work,
> -    .do_interrupt_locked = hexagon_cpu_do_interrupt,
> +    .do_interrupt = hexagon_cpu_do_interrupt,
>   #endif /* !CONFIG_USER_ONLY */
>   };
>   

Eh.  Except all that hexagon does is acquire the lock at the beginning 
of the function and keep it for the entire duration.  I think hexagon 
should stay using _locked and *not* do internal locking.


r~

