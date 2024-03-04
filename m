Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580DBC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 23:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhICQ-00041z-6E; Mon, 04 Mar 2024 18:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhICO-00041Y-IL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 18:58:24 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhICN-0003cB-1T
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 18:58:24 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so4764049a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 15:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709596701; x=1710201501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fc51mHFxl/TieGZN3nUfMtKa3awAm0/2dYVAAD+hVzk=;
 b=Y0gTpOtygW399iftirRtZtiL/WPNuTV0M8D3o4PeJJnl3Yc0+VA9i3nZawE+9w0Y5d
 0VH6NzYu7zC/GhWE61/B9tYmM8vHX80/mK91KboOItk8MXdnnXamgQPt4H8ZPm6cbn2U
 BngKFn8q8ND3DamnUzhLPJcs8+coL6ss8I25xGeztDCIm45lNNJwUwTqAA2S7j7I99ZS
 uq+zCVN7BCHn+my9Nz0OPOcYgaMuiZLnKAuqR3j1zNWGakEH+WmOsg9+Nl7zGONVUgfb
 aEfjD3jmjrsD2BSDcxE1dxetL9IKNgfM2mRw3uTz3WWIPgMNYRshNjrvGZVwBp+rRblR
 I0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709596701; x=1710201501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fc51mHFxl/TieGZN3nUfMtKa3awAm0/2dYVAAD+hVzk=;
 b=Z5dAtJcFKHTS3FfR/Pzv0JlTJ/9o8W0lxlo5TrqfeLn0x31oBjd89od/OyLx6GDvjy
 ncmAwwFDcFow3lr3bYaThsQFv53Z6EJzM3G1bjdxGdmSakk00Tvs9DWtYcQ1b4USRqpx
 SXPU0dndfb1+izeN6kpKUB3wDBBPkoc50p2dmCqxCgeghZfos7uEKz2DwmaR73BkZKuj
 mVnF08+4otbvX8pxxT4oxQRIHnBgU0lcsWuKO5EIvzUzEmAIjQM3rdp4byd9+HdSoZwi
 k9DqB5X8+JC3lmbXqENPJ/gxUy9cuI7442esZLiHOXIASXiQdCTSBmYcU1LRQqj1NzA5
 SesA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX26W3R6L0JzQisE3tbwJ5VyWyBmtGYToRlb/X/KSgWYgd4vkzCgQwrsMDieKb3L4MYTgVZsmgY1A2U6VuXD4uHy0B4o48=
X-Gm-Message-State: AOJu0Yxk4ukjN1sqnDcSuhJbeXxiQoy5L4udGdNPjTTRndY4bUcPxNI2
 lk2PIR1M9pbfY7q1j+ZQWDG4JWvIbZLdu/DrccfeYlwDXtE9bpv8zVV85CShGfo=
X-Google-Smtp-Source: AGHT+IGJdAs+fQNFPsYp6zsJuLWUGRstp50XiDp/Wl2NCeYiBaqeVX1DZYPDqqZRZzYbKQJ6EfNy8Q==
X-Received: by 2002:a05:6a21:3405:b0:1a0:f3d0:15af with SMTP id
 yn5-20020a056a21340500b001a0f3d015afmr213152pzb.34.1709596701411; 
 Mon, 04 Mar 2024 15:58:21 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 m7-20020aa78a07000000b006e319d8c752sm7776286pfa.150.2024.03.04.15.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 15:58:20 -0800 (PST)
Message-ID: <15047e82-6669-4200-9ddb-5118853a001d@linaro.org>
Date: Mon, 4 Mar 2024 13:58:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hppa: Fix assemble_16 insns for wide mode
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240303021925.116609-1-richard.henderson@linaro.org>
 <20240303021925.116609-2-richard.henderson@linaro.org>
 <6f44d208-5ba1-43e4-b6de-8e48f3cc497f@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6f44d208-5ba1-43e4-b6de-8e48f3cc497f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 3/2/24 20:43, Helge Deller wrote:
>> +/* Expander for assemble_16(s,im14). */
>> +static int expand_16(DisasContext *ctx, int val)
>> +{
>> +    /*
>> +     * @val is bits [0:15], containing both im14 and s.
>> +     * Swizzle thing around depending on PSW.W.
>> +     */
>> +    int i = (-(val & 1) << 13) | extract32(val, 1, 13);
>> +
>> +    if (ctx->tb_flags & PSW_W) {
>> +        i ^= val & (3 << 13);
> 
> Patch boots when I change to:
> +        i ^= ((val >> 14) & 3) << 13;
> 

Whoops, yes.


r~

