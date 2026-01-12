Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95E4C9EC93
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIRZ-0001Xk-Gv; Mon, 12 Jan 2026 08:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfIRX-0001Wl-BG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:58:51 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfIRV-0000mM-UU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:58:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-431048c4068so3220788f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768226328; x=1768831128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4byqosr0ep2RNQWBYROObG68Z+mNHbe5DInAQJ2EdLw=;
 b=pmGlJjMfTuyzXQbrI+eMsanzBBmtn0gj4p8lHrg4+DybxzdMy6nNMgSdJhCOM0DQWT
 bT9g6dCW+uxtOUcg9Htjxzoaz/C31KU8jBcGjlOT0X3u/gZwCfzK8t1mC9E6clKIDwvv
 HptgrXuxIrYjdgFexaucPO7fcP127MJ7+vD1X1bQL12Nj53icm30LejrLIe1MyCFF4og
 z6W14aORI+8O7s9weU5Xhba5TyAngKJmQpE9+nJxaxoO3NSetWCctynO7ZhxT0adiZMl
 z+KhTe8ZaWrZiSXNY3udQM9/KtbJC5bHdth7GX+5p8PRIax0nE8pT9zkUk+XMq6zWeXt
 eO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768226328; x=1768831128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4byqosr0ep2RNQWBYROObG68Z+mNHbe5DInAQJ2EdLw=;
 b=D188O+l30gpqFwkxsQ6njPMvUHapABijq/ZX+CdFxrES/EAT7k8IFb7cKO6igQ1MqP
 UY2StAxNNmkT0UH+QMhvic8Kokf+fsg3SQDdLXUpbSDcPby7iHSIuMRRaHmbjNOHl7b9
 kjRGU0NSY5Yy6vGvdKNWDMpze1UYfiE43c8+dP27/dDe28+LSE6mJzp1os5ZfxqgJPEM
 QBW+9pJLDYsA2duS0KoBP2RJeZBmn0EiUIMl9YgvKq5DjifTFlPFjIlcxJKsvcHiOLZh
 yJsl2J/8Fk2oyvaDrvJUFz8GT0ZuFgPnGZP1xdoZtMIcEOy9KMtodamSL45yqFsxoOOJ
 BnzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpKUliQ6xr/NM4jRY+qDKG7eLh5DceLqpUKtwq2ymlxWvoLptZgTWBYdM521Rll3D0oVsRl7LA0hbP@nongnu.org
X-Gm-Message-State: AOJu0YzwOQHjMctGMi8XgonUzIX946y/CbTqVfIs0SNHPk9hRfRV0Fo/
 1EN9VIeJ+y1hTw/r4Y+9NZMAo+LsZyGPIhNQZgxqwk5q13iiqaE/Idg+wzHXg2Of89w=
X-Gm-Gg: AY/fxX70FUZQSpx7LftPVZcFCZ/zgHA5GgYqXOWx6jRyZfs2zJ+hJgOQPZyP80zpTKL
 O1wXOa8KmD9gqaBlrxbGPI1rQgujd3tgpZ7RdZo6gSlx2dKNAKwhXX0o/bhAVhRfa1dp8+ZWQBa
 NG+h0ivQvlUy7us5e1iIbx2U39hb2kPMB//Y3RcwhMmHm6+oSdlf66VSNu2XtGDhAz1C7Zsb1xl
 rHygR7Om8LfNL+kF8IJkYdS5Ff/J0LYrfUocoMBQzDkzv7MaCSpyWDvc0tJk2wFktL7kcMQoNbV
 euZr31JRtxnmkFuZscfsc9G51K5RAdKfsfaRcVjFdHc52VnN0n3/vim5s256ly8hnE64uWi4WBS
 LGnDgtKQooBb+0CZ9A57qmvYAWxvBu6WnE+9e35Q5BF5U4/BSp6XPw913uP1hCDg9q3cNMuyqZ7
 vdtwl8eaCQPYWI1k2YJX0BafXUA2Xvw2M74NVNU1NnOX8wMc0pj9FoNQ==
X-Google-Smtp-Source: AGHT+IGa1PRV11Z4esWNdfi9evwfnp7Z/WfOkFwcS9947/hnHK9tkROuiwhu29es2MtHI+wl/MfOkA==
X-Received: by 2002:a05:6000:208a:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-432c376238amr19764899f8f.21.1768226328133; 
 Mon, 12 Jan 2026 05:58:48 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff319sm39463622f8f.43.2026.01.12.05.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:58:47 -0800 (PST)
Message-ID: <37fb8001-8451-4b80-937b-0b767ae7bdf7@linaro.org>
Date: Mon, 12 Jan 2026 14:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] target/sh4: drop cpu_reset from realizefn
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108143423.1378674-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/1/26 15:34, Alex Bennée wrote:

Missing the Why?

Queued taking from cover letter:

"Shuffle things around to ensure that gdb register creation was
done after dependant peripherals had created their cpu interfaces."

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/sh4/cpu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 21ccb86df48..1dd21ad9ed6 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -255,7 +255,6 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    cpu_reset(cs);
>       qemu_init_vcpu(cs);
>   
>       scc->parent_realize(dev, errp);


