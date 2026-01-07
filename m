Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3839DCF6BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 02:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdJVA-0006Al-41; Tue, 06 Jan 2026 21:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdJV5-000641-R7
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 21:42:20 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdJV4-00077z-BJ
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 21:42:19 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so11932595ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 18:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767753736; x=1768358536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hk7M9lYgbCKSP9dQLKo0oE2QpQAfFBJ1OScqrNlWQE=;
 b=gj13nw2n4ZD0zbf2RGRzJlb7iukOJedxMSJb/4U88Gsb6oXprzFARRrhBv8rXtz5TB
 uuvdmtoID2dsVzvi/kBBUpGA4PKEbJzXOarWoKZNObffaa4kgQdjhCoHuHUrIzkuAWpa
 kw+mLOo1YVEH+ovRkGH//DGxuUwAvdllOdmiz/YMEd7qef+dkVFMvyZvAqXn74h9291u
 TCoZTR+KBk3yA46lN5wdJZC//UxZQ1Z5Rsbkuk8z1AX2CbvC74avgWP46lkk16I+UrMW
 Dxm5dxDscFkD2qU79RleahYu+qvNuZHpKicDGzxN9iNJ7r0XmGGlLjs61oga/W09Udl/
 9ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767753736; x=1768358536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hk7M9lYgbCKSP9dQLKo0oE2QpQAfFBJ1OScqrNlWQE=;
 b=qrbIWJnr1A99l+JRdh+2906Bs314Yqhu+N4hh5Nqh+l90kDZAupAo/OjaXali+wT8h
 Cz7k0knJRZpFkC0H+gSy2tIDc2KoVazjY88zl1C2C7fkGXHe0gfopdxTG1E6uIa9aoFY
 BpoSmtgm4kzgVqHWpKwfKtvgccQGXYb+9TXrBH8OmY9wfpBolWWhLoPluiTJjjisXT3n
 DiCYcIwbiAK+ihuqdp3RHm4Dhk+ayK3AOGVMFYqmEraH7WRT0ocH4zszS5umd1aMkqmq
 zVfQaIHSShvC4dHgDCtH2t59mggaWRDYNtW/oqw2mMFqA2uGPl62Ux7c4g+K6t2txSyw
 2HpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/rqoVoit2Rt9wLGY/YEytpMM7AkCIYM0dDCFYdzHQVzAJpGiIwPpeJVRxcVt+Z55UlPxtYkTazy4p@nongnu.org
X-Gm-Message-State: AOJu0YyEhFq2NyseT9fP39hosq2cjdoyXVPOgYNFr1AimJAfPVFWBEne
 QeO6jjaLZ5M2Fbg+muATDsVN786S7HbBtCgI8jq1IwgQN6jbGE06IGepEK6lrd+HIxT3gVS1Wb8
 wLoFJ
X-Gm-Gg: AY/fxX5ZFGVpMpegXhcb38Tkno5Ku8pHWEiM0nlrDKLobQ3PDwIrejQh4swk08Sekoo
 cg/gwhSfWQbh2S2O+/O9fL7gCLENY2cgY5J9su5OqPKSQOsE7xQPAZ5RYj1BpeXNjD1gYlpsao3
 tfJGLIZ9f2Qb2D92wFuIWNauybnxE/DwLesSq+Z6AoflDhVxIOur6OhBeGkAN0GJj61q/JemAgC
 MMEzlohVYUoZMV4JjDufV2EThhZQLRZNNclP0oAD1nysFhto6+f+rDWiyQeQufWYBwLosbTFVwU
 JA0SSv3QyG5dUGnzwAArjDypVpydMKpFlvkjcKtIxkNoHqzf/lxvzdjbnG/ip/hDahXBUzrTcKa
 r5vjmpGSloTwzXggpeXWueGfdxOte5hildr+w7zbszj7KRvEeL4SgC08mffbrS/TYvkN3N2XmXx
 u8pUGmMMcqSaMq4Ol1YfXNr7SnzOdRTzDZLfIhPl8O5n304VxjRqnK2oCu
X-Google-Smtp-Source: AGHT+IFU+dX//TiYRc70SfGQ2PZ5WQ1VLheXQpzqAYm1Iv97dah0iNzS8RHX25sh7n7w7MFC1Daeeg==
X-Received: by 2002:a17:903:b48:b0:2a0:98a2:3ccf with SMTP id
 d9443c01a7336-2a3ee4b237cmr10742775ad.40.1767753736073; 
 Tue, 06 Jan 2026 18:42:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c50sm34126855ad.55.2026.01.06.18.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 18:42:15 -0800 (PST)
Message-ID: <7894f434-1c5b-4198-add9-5948b5c2df26@linaro.org>
Date: Tue, 6 Jan 2026 18:42:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/microblaze: Directly check endianness via
 CPUConfig::endi flag
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260106235333.22752-1-philmd@linaro.org>
 <20260106235333.22752-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106235333.22752-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/6/26 3:53 PM, Philippe Mathieu-Daudé wrote:
> The MicroBlazeCPUConfig::endi flag reports whether the CPU is
> configure in little endianness. Directly use this knowledge
> instead of evaluating MemOp from mo_endian().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

