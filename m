Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0630CCD184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62xT-0003Dw-Ux; Tue, 07 Oct 2025 04:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62xN-00036l-J6
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62xK-0002lW-Uo
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so30357845e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825317; x=1760430117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQ72sjEK9el+o2QCUPTsHRsZdQLgb1dSEftUD8DYDy0=;
 b=FWQTvstbbLb/vNilvs6JB/H01bLEV43srpVFaUosN/LMTh1hfDCy1laDb/hyZsYZpe
 7SDLQb5yvO3JjTAGqjD7Qt6jwrGU/o7jtXqR0FHrBmZ7Nd1bNjTiaajDJRzwZXV1UQQ7
 Aj/1FD+uT6K5YS8e3SwoQD0IhZQSOpc7v6yH8l0Hj8Fg3icFpXjqCz/7gNWIiujwpQx2
 jVWp6C0pRiKXhlrFsvNZZkXsLMVMfJYKfcrsre6WX1BNRW21pkg7UcGCXmJtlhTvZdze
 o/QJDn2ztGOLoJ2ct3NLeRWBG1a/yHMDU5umMYYkKPWNoowekX22rk3Mx06/Sc3vT5zS
 1LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825317; x=1760430117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ72sjEK9el+o2QCUPTsHRsZdQLgb1dSEftUD8DYDy0=;
 b=DE5gVPsdrV9Q1aoefUbP6Rdm7p1Q7Py5rE0QPskPmuVlEzerOMFIF28apMFXIKL3Lr
 myZjTtuI0kC0rdlvVcpdDKUmRLtCiMX43oYIaIztpHQ7ik/p/vuOfG6gVRDigyDPUPvp
 dUuWt9OsI7sKMu9ftfGTsy3m/4KSM63yr8D7DUW/inhXamYvPn97JQILGyb5U26SpAGL
 D+g7Jj89aRVXjREesb9a0w0VkuOpx/kncirYEcT4BjbtbpRMBgwChSXQBSXg+9/t8miH
 9dgv+PJRgp5Xw2W3c5BmwJoOu2S5Ab0LA0hwb0aJhYifPPxISGuPuCaiiXrVSwWbu/cF
 gdLw==
X-Gm-Message-State: AOJu0Yyzov3jXC6/6m4KPzy4oiP93tsry0EGq84/YVkomLHYozNT9C9X
 gsq7AkHCYtwSd6HlKROIYwMcJ6BTHta0SW2Vqtzj4L/j6XRznXJiELcMBQ+gCctYF3+aAKmht6S
 g6f+YMqD38g==
X-Gm-Gg: ASbGnctDRfwDmgYVmT79yInUuFBGV0184WAUKC35ZgWG2bFQNDsX3ISq1QifJwyo80d
 m5xTryeNnACmFaRJcysFzEtAiMWlXoVfMgrkvaRSGmcFLdPO/c6oU7jrSzcQz39GKCK1fBGgk+D
 AVS8Jafo6P/ixcVSE4x8jTiMmdcSuEJDSp44rJrj7sjOBGbdA9fUSOwUDisqWiJ6LR0ZT7nkR7F
 ahvX3pFwnRdkXv0cxz9WthtVqtCinbvkXyZOKIjvmfpjAe83fW+WxUkUcks2fvpMqFghXiwFu7Z
 72GffSHIReARpqOBP833cVGjgxjDQUagOvXmypDx7ZB2j04m+g8eWAqO8HxlMBfyGWx0NjiE8di
 pUmkmXuYfyYoiLHvbCYtnjgdWmZ0P0twB3oBIjByHPJfouYJM/khAThhKXax5m0WMYp7gWk7Noe
 zdlcY/EBdhbWnBhCancVTFlE34+IFU
X-Google-Smtp-Source: AGHT+IHqYzJNBzqibW4VKQRTw5e/vJjuFlAw0zlzCwO76iruce+bUMz/bXJHjrhuBzked+FnOynGYw==
X-Received: by 2002:a7b:ca44:0:b0:46d:e5bd:2ba4 with SMTP id
 5b1f17b1804b1-46fa29ffedemr10581335e9.18.1759825316969; 
 Tue, 07 Oct 2025 01:21:56 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa455cea0sm9583655e9.8.2025.10.07.01.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:21:56 -0700 (PDT)
Message-ID: <f4d818df-0fb2-40e8-b77b-5035486d1ea5@linaro.org>
Date: Tue, 7 Oct 2025 10:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/alpha: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250925005137.59378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925005137.59378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 25/9/25 02:51, Philippe Mathieu-Daudé wrote:
> All these CPUAlphaState fields are of uint64_t type (except
> the @fir[] array which uses float64, expanded to the same
> type definition). Use the appropriate VMSTATE_UINT64() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the Alpha targets are only built as 64-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/alpha*
>    configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
>    configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: "target is" -> "targets are"
> ---
>   target/alpha/machine.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)

Patch queued, thanks.

