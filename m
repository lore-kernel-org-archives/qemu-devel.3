Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96475C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 22:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siibY-0004fW-06; Mon, 26 Aug 2024 18:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siibW-0004eC-8g
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:54:30 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siibT-0004m5-QB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:54:29 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70941cb73e9so3074582a34.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724712866; x=1725317666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZ+UPthX4rP3cF8jdMDC2pgiddv2d2zUseAD97wxdnw=;
 b=cD79mE1W5RpPebWR/Ncb5Uw2LaUCCWrSDqB50Fp+PcNgU9X6U3KwEH9Zuk7lJ9r7YI
 Klx7YUrnwMUlk5YneTRqfTGJA6Ka8+2cbbC8nfKlWF2WWbdGG0QdoO5xr3hu44DAyK0J
 6CwxqEiFfUkUBEUI7WIJrEBC9nW/m+d4cdzHe3hMLjgq9babnKE2SCrARQGRvAivck0q
 +6bM1bRqOK9xhtgA6JsK8ev5GpRTbx/oyOcs9pai3/5Fc0+61RNjc4byUTVPnRBu6mDy
 kale0+Ql4w/+d29snYfE1Q40BW6rI1tPEqFhAuOIeHp4cl7HAqgwBzDmNRoTZgPqkLyi
 WVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724712866; x=1725317666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZ+UPthX4rP3cF8jdMDC2pgiddv2d2zUseAD97wxdnw=;
 b=pk5dts5vI4Xfxr5bj4VuVDt8WRqhhWJ7RI6GEPSLt0DhqUAbMW//2BcRfPURnyKJvT
 gfD0C7ZeiD746IFwhpu7Nx168FEFshs2DP6Q1+e73XEwEM2k3d2q18Gs3L9Q9glt7Lh3
 gu0GBCwXTXiAHfpO6YZTCM8UG/8qLhUt0eaoi+Lp3C6t4taoqDsl8DiOhFBjKARqwrbN
 8QoGf/Ugjbk4sM+viwBbFOq2CPzBdN9Ope9vFfOZ1rQe6tOYiNc1xGcLSBpgQjnsRePM
 zpeWpqAROFJWoJojs6PH7tfiwFk/Dovilp5PelA/ggUKFVLX7v0uPlqEDZlVhGm2B/SP
 TBzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhnn63gAkRNzE7Gls8DRkKgksYqDE+Qw0/ZxULd0eS7UCduu14Lf2aVn4LbQElfkx/5PdpxcgCI2lf@nongnu.org
X-Gm-Message-State: AOJu0YzthebJHDK6FTZQndD2VxVDwmsyJc5fJ6IYIj5y/2IKsxfC7Xci
 ppn3QlBXWAT82qMYUvax+l67cUQiQ2LsLDewLFZn27ArDoqXVoDz2nQiYJjK37Q=
X-Google-Smtp-Source: AGHT+IFPmHbwsQoEZpnj3yAQa+nc/3+sJEgQuty8Ki47hETLRCqvOeVRZPNYlly0KlIGtmobIEP7PQ==
X-Received: by 2002:a05:6808:1143:b0:3da:ae19:ef0 with SMTP id
 5614622812f47-3de2a911286mr14045453b6e.49.1724712866219; 
 Mon, 26 Aug 2024 15:54:26 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:2082:f68a:6871:1edc:69fe?
 ([2001:8004:5110:2082:f68a:6871:1edc:69fe])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad6e563sm8177198a12.81.2024.08.26.15.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 15:54:25 -0700 (PDT)
Message-ID: <26e49a3e-76f1-4705-9322-a7825238bc60@linaro.org>
Date: Tue, 27 Aug 2024 08:54:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] bsd-user: Add RISC-V thread setup and
 initialization support
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
 <20240824045635.8978-10-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240824045635.8978-10-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/24/24 14:56, Ajeet Singh wrote:
> From: Mark Corbin<mark@dibsco.co.uk>
> 
> Implemented functions for setting up and initializing threads in the
> RISC-V architecture.
> The 'target_thread_set_upcall' function sets up the stack pointer,
> program counter, and function argument for new threads.
> The 'target_thread_init' function initializes thread registers based on
> the provided image information.
> 
> Signed-off-by: Mark Corbin<mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke<jrtc27@jrtc27.com>
> Co-authored-by: Kyle Evans<kevans@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_thread.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

