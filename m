Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAF9C5475B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 00:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ril2s-0000Oq-Do; Fri, 08 Mar 2024 19:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ril2r-0000Og-ML
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:58:37 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ril2p-0002QD-GK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:58:37 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd01ea35b5so15790985ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 16:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709945913; x=1710550713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJlmnxBfN9cA2lyFLXeGfryENGzscnTyEmhaoG643do=;
 b=QonqO9Pt3XhFk6Vo2nnPh3ZPEurTjPDDJ0HZO2AYvZubmi5iVs+wifp3x5AJJ+ItqQ
 ZXyFLyYDpl5RDidgjFV+/F7ESb2dZ6TH2tQBv7oslSk9U55J+C1Np0j968Ejqexr/J9G
 v36jbmJEuj3VrivH/TYafUpkNSlirqiS0ixh7ru3WTOuUhSb65V2VL0ntYgxmRRZ47pk
 Tc6cwWQLv2IaKHxj/tOBGij79ELR8q3SZclLrvwb83AO742KRYlLwwgurfcjCQRrFBpY
 5BS9RQ9VjbsMFXPG11TJady79xge7BFjhiDX6vbM2s4ZdCt/bYyq8tYRp13qEMSdR0Vb
 c+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709945913; x=1710550713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJlmnxBfN9cA2lyFLXeGfryENGzscnTyEmhaoG643do=;
 b=TUs5oekxGDO4ukqSZ+96+ab88jPYyktYqkuDj/A3Wvc3MpJJBzHf2d1wOEVmyS5vlc
 N58xkXNE7mKPT07Sa5tWAewylySh3MArdevd4dJqBWDjQfW8meaXeUBNHiJNbJNBb4nh
 1Fc310XqJYgbolUAm3v7kKdvDU0ARDKrleWgg0mzNwo836bFEFFOaHTMsjWXg1qzLnhJ
 MiDDocz0NBxgCZvjXfx9MvoUP6KpYhqEA95wigJzBmcDeXoRaP8sE/H3kIIiQrBPUOEW
 6f3aUnnWvV+VwN2qfU7AD1L8jzpYx42+0Q+Jku0gtsY1tM4SL1lyhOrgMRCOxb8DRQ4X
 VK2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwTQTz5JI8uEPBW/q2He1NTjBFEduj6Nnb8BdjVFHpPOOruHX4vZ3qKnsLGDu4q8OG+48WQ9X6mI9cs62QdJ24gqRBhRI=
X-Gm-Message-State: AOJu0YyH5judwV8djt/mCauT9M1qHVe9zbcHxeQY0IeMm8sVkEtnB7fF
 jnlwelzupsZEUqoKtgCSVjKE/KQ8C6PAIe6MKl6mweCAA9X9MMD21zwBUnGhRnM=
X-Google-Smtp-Source: AGHT+IFE02BY0sXqrZw4I+tREdWMDJllOIxCqmnj7aoWsIB/2z3aiEa4UD4cWVjVLxQvy5CZNL2snA==
X-Received: by 2002:a17:902:c402:b0:1dc:696d:ec6e with SMTP id
 k2-20020a170902c40200b001dc696dec6emr361079plk.21.1709945913439; 
 Fri, 08 Mar 2024 16:58:33 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 m7-20020a170902db0700b001dd54c4320esm236498plx.256.2024.03.08.16.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 16:58:33 -0800 (PST)
Message-ID: <bb51b489-e22e-424a-b6be-40f91f6f8875@linaro.org>
Date: Fri, 8 Mar 2024 14:58:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] gdbstub: Add Xfer:siginfo:read stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-4-gustavo.romero@linaro.org>
 <68dc0d72-ae67-4e7e-8c1f-670aa59e92c9@linaro.org>
 <322b8643-d595-4ce0-1f11-5e6ee1138638@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <322b8643-d595-4ce0-1f11-5e6ee1138638@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/8/24 08:30, Gustavo Romero wrote:
> Hi Richard!
> 
> On 3/7/24 6:13 PM, Richard Henderson wrote:
>> On 3/7/24 08:26, Gustavo Romero wrote:
>>> +void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
>>> +{
>>> +    unsigned long offset, len;
>>> +    uint8_t *siginfo_offset;
>>> +
>>> +    offset = get_param(params, 0)->val_ul;
>>> +    len = get_param(params, 1)->val_ul;
>>> +
>>> +    if (offset + len > sizeof(target_siginfo_t)) {
>>
>> If you save the siginfo_len from gdb_handlesig, you can place this in user.c
> Shouldn't all user-only stubs be placed in user-target.c? Like
> gdb_handle_query_xfer_auxv and gdb_handle_query_xfer_exec_file, and since
> what controls the inclusion in the build of user-target.c is CONFIG_USER_ONLY?

user.c is also build for CONFIG_USER_ONLY, except that it is compiled only once, and has 
no target-specific code in it.

>> Is it really correct to reject (offset == 0) + (len == large), rather than truncate len?
> 
> I think this is correct. GDB mentions briefly that an invalid offset
> should be treated as an error. Thus, I think that a valid offset but
> a non-existing/invalid (large) length should be treated the same,
> cause in the end data on invalid offsets are being requested anyways.

Ok.


r~

