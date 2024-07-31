Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123D9C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyZr-0006L8-GQ; Tue, 30 Jul 2024 21:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyZq-0006KZ-4j
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:56:30 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyZo-00024r-OY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:56:29 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7a1843b4cdbso3050081a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722390987; x=1722995787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lSlebNU4KanfCX6qikijwrYtDLnvbsdJwi1jK7X5J0=;
 b=hlniNWX4Ttnw0wH9hF3EvUrUegcN/vFYideh1dnYhGlz4fzr+foGQtX4Mact1Dbgjj
 DEHsQ2IuaEVB1GDgTl8blTyO6/Sk2XaLEtK8SqJxIU9gUm5FhcKO20R7tYcVSD2sg0Qz
 urlb0BFz1Mtu+U0pcJ8uje2ILZ+tne0bEHGmwZxmHIsN5PSKerBpd4iic3z8BIVBPwrq
 CVk4FJCd8HL3EjV0/oahEsunr/NL3Sk/LD95d9Ug8WM25QDXUOBBtjNxDozky7B1f3bj
 oLb0vOatW/yTZVxMRl7aO95GOKdyYJ/80Oo7G1Gx0P2D05K/C6T3xJc7Xp2G+t9IrEvx
 yaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390987; x=1722995787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lSlebNU4KanfCX6qikijwrYtDLnvbsdJwi1jK7X5J0=;
 b=kSoHXM1nD/sLx+WFrhVcBB/o/7UYFh5fzB/qpxo33oqlTNgsdkvEuC5ZoJYWY4yw1/
 FMM+YwyFgSePzYNuFLapA8zMVN1fyzFQIMYU+fAWjeRBHSxDgDqgF9z9kmuwOb2C5Ah4
 ZRTlWYQflMpSJ4bqrSf240KiHp2Hzt8lcICWtcEWl6bAjFsqyV9Co14/ybg3Bjz1gkDD
 Iw/+eH4nuWFoCSGZXyP3N+1DVD5nJmL3vgwQOa4fDIbrY6Yq7iOOHdZwb50at7lcPvnB
 Mxu/PziUt+/ubSGUnSmLkt0iVigVybfWXBNK5JjTRpDfI8cE5TBm1xvMVxqCVb8lTqsM
 unQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsZ4CgRzZ+rab/nneB46dUIOP7SeedI7bx52AT2tszrovYov4vmUXJGEsgJhb+Ul7YhkGaCW6jc53NHSRZSBoZEKoaJlk=
X-Gm-Message-State: AOJu0YwCF0CF0Es+lVc7B36ftEDpwVhlSRXiULkq/6kD2VdI4oz+2RBg
 lYtQOMq3i9KBxiTRxBFoMERS9KkObTQM5mDOB+G2+44D6sfVKYmxVcDzecsiQkY=
X-Google-Smtp-Source: AGHT+IHwIgliSsgNDprc0jiA2hvs811hPhu6ndBmtYIujKKH6U+s4qv0/RpuHML+sH2yz1oR5nF3Mg==
X-Received: by 2002:a05:6a21:32aa:b0:1c4:9f31:ac8f with SMTP id
 adf61e73a8af0-1c4a14d92e1mr11394940637.37.1722390987055; 
 Tue, 30 Jul 2024 18:56:27 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee8494sm108978665ad.159.2024.07.30.18.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:56:26 -0700 (PDT)
Message-ID: <5ddbf421-7dbe-42cc-96d3-53622a8557ad@linaro.org>
Date: Wed, 31 Jul 2024 11:56:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-3-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730122437.1749603-3-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 7/30/24 22:24, Clément Léger wrote:
> +/*
> + * Close all open file descriptors.
> + */
> +void qemu_close_all_open_fd(void)
> +{
> +    int open_max = sysconf(_SC_OPEN_MAX);
> +    int i;
> +
> +    if (qemu_close_all_open_fd_close_range()) {
> +        return;
> +    }
> +
> +    if (qemu_close_all_open_fd_proc()) {
> +        return;
> +    }
> +
> +    /* Fallback */
> +    for (i = 0; i < open_max; i++) {
> +        close(i);
> +    }
>   }

Split out fallback too, because (so far) open_max is only required within the fallback.
Then

     if (!qemu_close_all_open_fd_close_range() &&
         !qemu_close_all_open_fd_proc()) {
         qemu_close_all_open_fd_fallback();
     }


r~

