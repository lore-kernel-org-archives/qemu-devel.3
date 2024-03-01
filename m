Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021BAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9aA-0005iH-AS; Fri, 01 Mar 2024 15:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9a7-0005hi-PV
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:34:11 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9a6-00056L-5u
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:34:11 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e55b33ad14so1752404b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325248; x=1709930048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yuo77yp9Q0iPSquUWth3OUNwMsklDChrk49kCCDlmGY=;
 b=KrZg0J6eCE/QOF8F/xciRK1DpsN06yZLWztcnaSquk/RgCz5cy7QcGN7tWBCby43V5
 kdvTGgOxpNPvKy7JU3D1cl0tGlm2m5MantJxKmRvgNU02qqGIAAWZjbktDtwjjTz0jmn
 qr55Vlqwnvi1/SSR+5STPLAc6nbtGYnxIRke8xcrOKOs7kwa9jjo5Vjslr3qAFB2Xlws
 9c1LeQqaXVsEspC+2SAJ194O4TvnM7eRW9mun3jgpgzqxOMhFavqxl7QtwK+WTVqkVch
 7GB3RFLwBiJlC5k6IXHn4o85mXhmTTFxnsQ4yL3N++yymi2jNaM6mWUXa/q4+MwgvZkg
 KSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325248; x=1709930048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yuo77yp9Q0iPSquUWth3OUNwMsklDChrk49kCCDlmGY=;
 b=nNrK4OGSWGhOgPF56j9Twe1sw6GHJzUDtBBbFLgApM2iobUBMbpw5MrYbEbs8R3TJx
 rjNEfgjJ1sJhqRcs/CdZoxgmJ+XINyv94IFuV0aTkeX/qAwaS+dwio0UHP3zxPXJva3d
 7s8/VFN7p0R29WW04v+Y2CuH68GNRduKPM6L/g9lTcJFx1ae8az80L1eMKgjjKrSbaat
 Jy23qok0jycsMBNs1A+RhuXv2Yr7WdHik9caFGfhtlUDx3QbimsY+yODLC4y75fb2AVb
 T37NsqJPSU5Vp8ZmklqJsSvQNXSLsEAOYpQUmYl6R0hm7sTJfxsDy2GW2EzvW7Y8uIUZ
 z5mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmIs/vnZPaIoZO5UOfeKuWS2SkL1Ri1FSI+xpmXs7XzMa/P4artDYIl2B3vk3K3T6aTOQ03657vDvOlcBayY8trEZs+2o=
X-Gm-Message-State: AOJu0Ywp507MKojk0HHgXtffdOKhXDNgQp29NvzYoH+MkcKdXCnJvP4t
 GwrnsYXp9aqSOBgN0EbXMpAWPV7SqA2B2q55UK5R/K2wjGC8b8UNJX1sg1fnaKQ=
X-Google-Smtp-Source: AGHT+IEynDfid25gutssuIdUV/69FKHbWSCQDKWwZTpoHSp05TFI4vij3wOYdOXbkON93tiSTKS8Dg==
X-Received: by 2002:a05:6a20:7d90:b0:1a1:30a6:2b4b with SMTP id
 v16-20020a056a207d9000b001a130a62b4bmr2876917pzj.15.1709325248388; 
 Fri, 01 Mar 2024 12:34:08 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q1-20020aa79821000000b006e4d336c420sm3348143pfl.69.2024.03.01.12.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 12:34:08 -0800 (PST)
Message-ID: <f2deec4d-b76c-4d9b-a42a-c31d432a4b53@linaro.org>
Date: Fri, 1 Mar 2024 10:34:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/i386/pc: Remove 'host_type' argument from
 pc_init1()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240301185936.95175-1-philmd@linaro.org>
 <20240301185936.95175-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301185936.95175-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 3/1/24 08:59, Philippe Mathieu-Daudé wrote:
> All callers use host_type=TYPE_I440FX_PCI_HOST_BRIDGE.
> Directly use this definition within pc_init1().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

