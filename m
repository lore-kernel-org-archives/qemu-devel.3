Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B53C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40SY-0004Vc-V4; Mon, 06 May 2024 11:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s40SX-0004VP-0m
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:40:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s40SV-0005cN-8T
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:40:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41dc9f98e8dso24714535e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715010053; x=1715614853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Cla4TPz2MHR0CsffK4PpfqmkXc2HE0MHscUbXAdx4c=;
 b=C+YTV9PVZYXhZX5h0Y5UbN9T2PY0VRpaCCQf8I74CfzVn4Lnr+XsEPi4ulsMx0lHhZ
 0pJ/Hs6C/mz5tfubYVscGPOwn1+1h3/wvCrPOA079ANAA6u9wq16SKOBvmcsMsQ8QAGW
 LTMrN+UT5G+PJptTrF1zdUKF6RpS6bmW4XPTUlHOG+SUawixCJw+PFlDOGKfaAXpRyQ2
 Qv+m3m90lcuDeP0Wo2BDRDtMXA2zE9fsAGehIVKFvY5bCfX/fL7raBH7x2i3kJwifty9
 S06D6+jssBsu6lMt9W8FQTXqpS8Gcjr3o0SseujgBs7+ggTqVFoBUiGnNtLPX6SY+QbH
 yBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715010053; x=1715614853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Cla4TPz2MHR0CsffK4PpfqmkXc2HE0MHscUbXAdx4c=;
 b=wuLDu/MU6UPoqFcVDQ1y/9ppHtG13z3FLmOfYHST4Ns2YCj9GUOx+gJaynsBfVX5v+
 auUZbsldBt29gok9QQU16t7XtQb3UTTdSBJMQ4kk0sURODkp/xT882WHYPs1hyrWpDLG
 dJjgbkVs1WaltMj+Kazgj8Z/bCX/nl+rtmimF87VyQzygy6BkWztiqnuQPSHfNgZN6XM
 qg1Ao/vHRtvUzrnf3jwmMFV6+mE07oeivTx0VHJYHxekvQn0TFx/twpYBbKokLPkD9kq
 HgC9es89Vxm7oGgMLgBWUFkTvP2/CAOyT5Y+7gRSVvvNtFZM5nVJ71wrNqVcnwNrU9dh
 llzw==
X-Gm-Message-State: AOJu0Yx3NZHnvFRH3hSvJD8zvTxN5Iet3djklRpiUIWKUlT+kdtKgqne
 zXbkuo2XaXqOaD+QrfjX1QMSAkoh5pTl8k2tRqyUgW/pZYmxWjsVWCgm5f8ltaf4ggIOaB4qdYA
 Q
X-Google-Smtp-Source: AGHT+IGWHpx6HAvlRU4A+XG+ZbiyV+D3oMRBf84BFV1nsuuqAnEf1vcL23yAKSMLnFr2pzdlvEQUSQ==
X-Received: by 2002:a05:600c:458f:b0:418:2ab6:7123 with SMTP id
 r15-20020a05600c458f00b004182ab67123mr44384wmo.10.1715010053200; 
 Mon, 06 May 2024 08:40:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 c14-20020adfe70e000000b0034de40673easm11027151wrm.74.2024.05.06.08.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 08:40:52 -0700 (PDT)
Message-ID: <de27bf37-2487-4c3e-b2fb-6623a744d9f7@linaro.org>
Date: Mon, 6 May 2024 17:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] accel/tcg: Move SoftMMU specific units to
 softmmu_specific_ss[]
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
References: <20240503123456.28866-1-philmd@linaro.org>
 <20240503123456.28866-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503123456.28866-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/5/24 14:34, Philippe Mathieu-Daudé wrote:
> Currently these files are only used in system emulation,
> but could eventually be used by user emulation. Use the
> "softmmu_specific_ss" to express they are related to
> SoftMMU.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index aef80de967..84826f043a 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -16,12 +16,13 @@ tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.
>   if get_option('plugins')
>     tcg_specific_ss.add(files('plugin-gen.c'))
>   endif
> -specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   
> -specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
> +softmmu_specific_ss = ss.source_set()
> +softmmu_specific_ss.add(files(
>     'cputlb.c',
>     'watchpoint.c',
>   ))
> +tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: softmmu_specific_ss)

Should be .add_all() here.

>   system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'icount-common.c',
> @@ -34,3 +35,5 @@ tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'tcg-accel-ops-icount.c',
>     'tcg-accel-ops-rr.c',
>   ))
> +
> +specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)


