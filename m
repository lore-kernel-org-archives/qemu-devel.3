Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BC6C25B77
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MiK-0002OC-Vu; Fri, 10 May 2024 05:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MiJ-0002Nf-QI
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:38:51 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MiH-0006os-HA
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:38:51 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e3e1ad0b19so23029711fa.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715333927; x=1715938727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g3WMqZesMaZs7nhNmHYUjyGHChDsch5qF5LmkjI43j4=;
 b=an+jfmHwJB1G/keCutiY+0Btqdd8WL/UkNTST4YleTscfxsvc2brdy4dVju3FuhDjk
 0/pATkHq2q82kxaL38g8gR/pgy3nQ5dVIMumxQkjIJesVu0tvb5OYPQQv+56rwkERBdY
 O/oLDIgfZbj3KFiWXnz9ZfCJDwULbJUIG45Io7PpJWMEuGC6waS/vv3UQ212lajTuJVX
 1fd+v4iXR17Mkfn3W6U6CFtwV6SIyhukdMseZqJlTbZXHOmC2YjUQdgn9/WasDKSVMt/
 rkx1/qnITuKudpmpZ8y418VWKe2QfWYrvO6hBxy+NQPxX7bzIaK+OSaMp30jP5i8+1Ff
 8kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715333927; x=1715938727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3WMqZesMaZs7nhNmHYUjyGHChDsch5qF5LmkjI43j4=;
 b=IlTsh2ZCDYA0IWxe/lWj2VPG/GQQXlwyKfGRxCID7x6ZD/leRqnfWqraqRByzSNAIA
 TpCvsz3bVvJ1tI7Un3qmaxHBz6IJV4vQQmZuy9OgxBL5CtHctLX944EaBhMhWjE6OhSp
 G5rbOA9nA3NXJVTYxG2JjX39403A+oPMVhP8ppI90g6xwWa8eAqcpF8tKIiM4QJtfmw5
 QzacEeiMtSe1HZLtWJ17w9SuwrVS9ljs0fP4SI8mq2mqDZGrUnOVJlKKY9S3dQdLWkRn
 tyT+kuIL7QTVq7iimWDnWJKjNGAR5S07mAt7XZRVItUZmFOheCJqHjn0slY6w/uRr+km
 2q9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxI5BqUhMvlKfhB8GCwwceYa6IAKdD0UpPC0SBixQTOb2D5geupShXx8rwHr/f2+Ek1ip9l+bo5xs5zGmUuhXAGczwIJE=
X-Gm-Message-State: AOJu0YwAt28pn+1giMq2addzloB3fgmz/F3i2bDLukWFtK+JcozKoF3c
 nQVFG9Um9SJNhlue/2mltSy11eOk9pwQsAyDwy4AagyGb/IdXhmBxTnfF5qSh1wXKntGyMssxLG
 VjTM=
X-Google-Smtp-Source: AGHT+IGNO46b2SiG+PCRZ/YbvBBySWtPyNRrbSGHXW6p76oRwTes0LFZvckC4ZZXDH56N4K97iGBCA==
X-Received: by 2002:a2e:4c12:0:b0:2da:49cc:ef3f with SMTP id
 38308e7fff4ca-2e52039c482mr11650421fa.42.1715333927198; 
 Fri, 10 May 2024 02:38:47 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fa90e93absm77298785e9.9.2024.05.10.02.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:38:46 -0700 (PDT)
Message-ID: <d7dffb6c-9f59-463d-960a-9e8fd863a118@linaro.org>
Date: Fri, 10 May 2024 11:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: move prefetch and multi-byte UD/NOP to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509153755.143456-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240509153755.143456-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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

On 5/9/24 17:37, Paolo Bonzini wrote:
> +    [0x18] = X86_OP_ENTRY1(NOP,  nop,v),  /* prefetch/reserved NOP */
> +    [0x19] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
> +    [0x1c] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
> +    [0x1d] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
> +    [0x1e] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
> +    [0x1f] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */

Maybe clearer as "NOP/reserved NOP" for 0x1f.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


