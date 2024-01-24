Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DD0C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSRgh-0003BJ-NX; Tue, 23 Jan 2024 20:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRgc-0003B6-Cs
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:04:14 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRgY-0008J6-El
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:04:13 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso3744781a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706058248; x=1706663048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pXU5zfG9oFElGNN/vgvAY5T57tvMOjfHDZ/pVtC0gAc=;
 b=KTBROpTyiRuD9lYWHiUMclZDWgXN2Ma+BLFeB3aSmx+PRHbBa8SbTefSKMUMwV5Cg8
 3WnXpEdkNMlOvrTAqQyvzJC5oPyLVAtQ4KxgKKzdSQ/rMeIKdBH6JyH6NTUX8fYK/NNg
 xFJHvvxTw/y9CUEmWfPfoDCOG8mIKIrgm8zuYggCWaKjI5j6NywAryEC+zl+eO9RfGRx
 zd2SuLnYAfyeaEQUmtEPjdsJNzUokeD3ZRgvGVGNUc+/0x8ST2L9pbHgA03qMx/SBOlt
 kXBh3q6uU9Ax+wncgmxJYFCSHpBS4IBuvCjLschqvifxbtTt+nYOQHOOd0m5BKBwRiyi
 SJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706058248; x=1706663048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXU5zfG9oFElGNN/vgvAY5T57tvMOjfHDZ/pVtC0gAc=;
 b=w1b1lAt9M90k0DmrpWm4Y4Tcr4tdx5DNk0/Lmp52OaB5+jOu9OyFWCGlmlJTWaBUZ9
 UEyt4J2lHpTG/eMCI94jZ+bZ4rhfKnqijcQC3JU51KalQ9r3MwOkjgjJjT90mOIDOgvr
 OJu9NCi62mj4XEAIv9ovpkZbhONn3WQ1D/yDerh1qrplVtT8i7aorQJoYzNiDMsNTCCD
 si5rwe6nN4msqkWVqutgg4wt/DH8xJeMLj05aiZ0uEWxfZap+R3Z7M3E6g/bMct50rVm
 KS6TXf7+STXFfuVGTaBf+E949GLiXgqH7c/fM2OAZdOvatiyz22zpBEFQAsGiMeOQXqG
 urcg==
X-Gm-Message-State: AOJu0Yyd6mOpIZ4R2MnYVtxPdwaQWAZFla1JxJ02LT1jPtCdxBRyEchP
 MhiMBa+3xN0OsMqDM4x4K9jHywyTYta7KxBnh7hsftfz1ONWV/CuTKo1gJVICLDcoEoI4viiZgo
 8
X-Google-Smtp-Source: AGHT+IHKyZhq+XgPA64eJG/sDPDs6izdWWrBWg55Cl6aE7riY5DFV5+jSfN/BOTAK8gtcOyf7Nm9+w==
X-Received: by 2002:a17:903:1107:b0:1d7:6060:c1fd with SMTP id
 n7-20020a170903110700b001d76060c1fdmr91120plh.83.1706058247977; 
 Tue, 23 Jan 2024 17:04:07 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902c9cd00b001d71eedae33sm7638276pld.45.2024.01.23.17.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 17:04:07 -0800 (PST)
Message-ID: <57b731c1-1093-49ae-8c8f-d2c166cd4d49@linaro.org>
Date: Wed, 24 Jan 2024 11:04:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/34] accel/stubs: [CPUTLB] Move xen.h stubs to
 xen-stub.c
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-19-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-19-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> --- a/accel/stubs/xen-stub.c
> +++ b/accel/stubs/xen-stub.c
> @@ -14,3 +14,15 @@ bool xen_allowed;
>   void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>   {
>   }
> +
> +#ifndef CONFIG_USER_ONLY
> +void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)

No need for ifdef here, since this file is in system_stubs_ss.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

