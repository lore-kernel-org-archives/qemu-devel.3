Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13837C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3v4A-00040A-Lr; Mon, 06 May 2024 05:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v48-0003zU-JE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:55:24 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v46-0007Pd-Ug
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:55:24 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51f74fa2a82so1867414e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989321; x=1715594121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGt1PH+8XRnS4VKauyPJDcQu8WqGev12CrWRiGOjLZk=;
 b=iEV8nINSD2uIVvFBexdKFxLyqqohEb/Nvl8g18Q4dcww0plgBBeWfRzLbwa9pLKul/
 iDiwY22PhjIomGVp4u7Cvk+b7ywwXB1/vNEOISzwsidQxQTOSuIsePXqncjZBJ3xs2VI
 +4pHLS7YUKU1cF6W6xqg4I7e8fFywZKBZBH30Q8MznK3t3lk3zNSdkT/6OyZLNf9aNxM
 5qDgp3dn5x0X530LG5ZX7jktopHYss3xFHqpd+p2YaUIBnm4e/9l2PoNB7DvdysZjUIl
 XuQGda2ITy/ci/qvtcyqguY+aKTDCCoPzyS+H76Kvm86gyisudrZHQrmpIGcCJyuwYfJ
 Wyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989321; x=1715594121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGt1PH+8XRnS4VKauyPJDcQu8WqGev12CrWRiGOjLZk=;
 b=ioCfbdFE3Y+OBFBeOydIfMfOV2mCB95UltiY7MFXgXCYYuNTGVdpcgqUV2y0f2/0y3
 0QtVUSitGbcMbNpvyTxlvhrTLEKc+iO3Mst4KjcuSiR+By0oV3c3kP4wSaXrOgQlf1+X
 wMNnOuT34WDtkFq5qg5hZnB7/HpF7UVJWqly8B8Cjy6aNsI06fuSDK6f2a3EC8xuKjY7
 xj0wHkOoZSMKTurTD0PVTIZofrllY4wd2F8K5DCMKoalbeu6hKNZtHejVh1qrqxyQTPV
 jLDy9/1QTizK9K1I41RZNoRy+0FshbA6vUFxzi19Edjv64++cWCUgyhhkOOX8WOvAmKT
 BbMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrM1vtC0xlwXCTcUb651ZZmrO6/0IGNXlv6ucW0clsl3X1+o34VKluOWKucx/3n/4tBNC1JPzXksrqDrs01X7FdRJnJb0=
X-Gm-Message-State: AOJu0YxFExsCm1sstVRlHLb+3PmQgR167xUCneo8NQGw0jWUrHUnPsZt
 ov38o6X2g/49xLkfqbvaDPW16nDfxDDYtvqqz4lUpGuM3f44uf+dTdvschs4Mi9n73csm19yZv9
 C
X-Google-Smtp-Source: AGHT+IHTsGsHu6hSDWz3r2Lzee35mbjMEuzTmmAqHLkTQ0LClXys4F43/xSUizKz37UX1rL2+ksRSg==
X-Received: by 2002:ac2:488d:0:b0:517:870b:a13d with SMTP id
 x13-20020ac2488d000000b00517870ba13dmr7623294lfc.37.1714989320691; 
 Mon, 06 May 2024 02:55:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a05600c4fc300b0041aa570bcd3sm19284538wmq.35.2024.05.06.02.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:55:20 -0700 (PDT)
Message-ID: <560f1ca7-02b2-4305-a7fe-5d1ed59b1d6c@linaro.org>
Date: Mon, 6 May 2024 11:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] xen: mapcache: Refactor
 xen_invalidate_map_cache_entry_unlocked
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-9-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-9-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add MapCache argument to xen_invalidate_map_cache_entry_unlocked.
> This is in preparation for supporting multiple map caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


