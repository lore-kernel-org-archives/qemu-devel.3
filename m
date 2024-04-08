Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529B4C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrKl-0002MO-3C; Mon, 08 Apr 2024 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrKj-0002L3-HL
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:57 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrKg-0001u1-Uz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:57 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51a80b190bso222074666b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712591692; x=1713196492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MozwskhIRuvTdoliWvz2Vl3+dmvsyC6Bfz7av78LLPg=;
 b=HPUrCKJGrX2p0no9lmBSQN6mwfyaah+QHHwOFBpmoUyU0o6fml7flg7ItMh4HM0C9I
 sgplOXsw87njerNwV9ZwUDqkD3wAzU42K+NN9ayRLwoo6EmWYw/6rxXm5wumV2/DB6Sg
 jEBjo0+mKSbylvCbkzQ1txKoZsGcTttb/buJl/FnytFVd6JXPUmnuUnOVVkm7pKDgNI5
 bThoDCGASbjEJ1cyshV+ssBPbPUkQ5h9ypYjASD3o+yBJKu/TFEKcgMy/cVrU8/SpbGx
 7wYYHX+DSscT0+6nzsHX583Rt17PhKEJY9B+luKFOC2LW6sLPWoEJhJHccf7GozV+Z7x
 GwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591692; x=1713196492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MozwskhIRuvTdoliWvz2Vl3+dmvsyC6Bfz7av78LLPg=;
 b=cup94YYHEVpUD6W2n6+Kk3oN1GnCUroxZ9reNVKF07gCLmF4i9BA5oafwJI1cCspFm
 6/RpXOrNbeNqGORA3/kumr0d2qOk1yMJEgZ6JRkb5UnT6yFyvRI6EtQ7CpJuv7kQnvAW
 q4uVaqxACOnwVI+hEXoOiSOhF9lGOOS5OY280rstJqyFONiyKfpFA4IZ3aYKJc26rMeh
 rQYaKtkfiDHe2Te+PIZI+HZrtEk2B1dwGuW1MHEy1NjiQcod+0V749Drqyd8Zr3nOV1M
 yZn74Cldtawgj72h1Kv3acPqU+aYgkbdMRTOfydGJRLojDcSHh8UfnBS3mXrEV2VHlAD
 Nt5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1l2G+Lp2CNJEn7y0buV3I+I/g029usD0xzOedPY40U0ZMA/3gKolzORvIlt+gj1X1MBf0lHVAhsr+JuwduroIf6rINwc=
X-Gm-Message-State: AOJu0YxzPF4HQIMZ1AduTWA+b0nEH2GokxXEd/RDb+0A80vYbm3/5J28
 IeAf3daCM7+Y7LaHspB8gfhNDk3jpnysr6t7uHm6tY1kcHRg6S/9vogkWZEpLSl22HLxhg6azxz
 7
X-Google-Smtp-Source: AGHT+IFRMHpchFluY03ZTJhNvUlkxn9E4odT7gny37sTu+wGzZUAF5U9bJzFU1hp7uWRPRXSlBB8cw==
X-Received: by 2002:a50:8709:0:b0:56e:2a05:a0e3 with SMTP id
 i9-20020a508709000000b0056e2a05a0e3mr7718475edb.21.1712591692214; 
 Mon, 08 Apr 2024 08:54:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 cn10-20020a0564020caa00b0056e68b14986sm672935edb.29.2024.04.08.08.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 08:54:51 -0700 (PDT)
Message-ID: <27454ed8-e32d-4717-bda8-e0576b307494@linaro.org>
Date: Mon, 8 Apr 2024 17:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] tests: only build plugins if TCG is enabled
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408155330.522792-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 8/4/24 17:53, Paolo Bonzini wrote:
> There is no way to use them for testing, if all the available
> accelerators use hardware virtualization.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



