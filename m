Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC2C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf09u-00034y-ER; Tue, 27 Feb 2024 11:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf09s-00034k-Gn
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:18:20 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf09r-0005mX-2i
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:18:20 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d2533089f6so53430251fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 08:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709050696; x=1709655496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rLR+4xiap0SXA8dTIU/QMkGs6q5GTRIXeuLVK2bY1uc=;
 b=fOqQ6xKIsR3SYSWhdjGDSwPuzjom6DID+9vyQedHF/YveijbFq+Ga9Up0c7jl/xo3x
 qgYjgMnSzliGAGuUu+74un+C243/YuPx366Txp4Q4DGkKeTD04Bm3Zo7QkfJeKpx/KFh
 73gkBbP6LvxP9AK5Pb37/A6qGyRFvqM4audaNp0ee3FpimdH3NH+SCdGpRKgwHoEY8WP
 iY8GOm5d3s5VeRhdM88z8zZv/S7Up0BWMQWnR9JbPQI+eTV0bEU3J3ATSoGuq9m3s2sd
 ZL21HQRTd8+SIc4qAqOMxXnCP+P06GiESaTqVzhfRGLHehswEsdbrl4OBXQT/CNLEbmE
 1svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709050696; x=1709655496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLR+4xiap0SXA8dTIU/QMkGs6q5GTRIXeuLVK2bY1uc=;
 b=HcXgl6TPVE2Q8xpjWbYfyGVU8lnCd88SWmXJ98hD+9oLtEa7udfiR9o2tXtnEiYnQd
 bzAF3/bB9PM+RD2AXOG1+6lvo6CqSwMcR8n9VhGhvUq3c35Wr0t1QG5+fT00hQPF/dq0
 01STQyQfaa9/V2cNNV1Jj0UOVcjaTXDkdE0mL5c7ZRY48OwnUGQZF2bsR0NV7gVoGRO3
 WDsAvc058FBZdlmNtrA7CoxrWcO1mw/mbfpQrXSNAl3CHtgpeSIuEJLEjtZsKpkbxeNL
 ax+AIqoHI6cZTUs84STjaH5F+fm5JFSpBfHdfsRuY3IIN0Oo6uAFqFIQyvqF47OxpWY4
 vsXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCiwxzp7UzdIjtpX0+9uognEySEhKNdmLSIrxNsXBNMDpQtJGbcNOSYh9eff/Tsdy1uMi7RNoDRs1smcQ8F4ysPSQGIS8=
X-Gm-Message-State: AOJu0YwaY6mFk1EKaorgvdpsRDEAmU/GJBHieUS05pPEGJUhXMoF0xsj
 q5/uK9VRPXqCnjl5IJZDHzOj2hD1CtTdTApxJohLZ8sCSgVYYV5z6JZM32ceGdo=
X-Google-Smtp-Source: AGHT+IG6euliDMZXKynJ0Y00FSOkIqhhSQ66xoQIPXfP5qejAh5+NDHZ6rr16DgCaZT1FfcMmu/msQ==
X-Received: by 2002:a05:651c:786:b0:2d2:a38c:d706 with SMTP id
 g6-20020a05651c078600b002d2a38cd706mr1022595lje.17.1709050696247; 
 Tue, 27 Feb 2024 08:18:16 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.23])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c35c100b0041228b2e179sm11755481wmq.39.2024.02.27.08.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 08:18:15 -0800 (PST)
Message-ID: <460a80d2-cc6e-4633-a40a-f20519b87964@linaro.org>
Date: Tue, 27 Feb 2024 17:18:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] qapi: New strv_from_str_list()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: steven.sistare@oracle.com, dave@treblig.org, jasowang@redhat.com,
 michael.roth@amd.com, peterx@redhat.com, farosas@suse.de,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240227153321.467343-1-armbru@redhat.com>
 <20240227153321.467343-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240227153321.467343-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 27/2/24 16:33, Markus Armbruster wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qapi/type-helpers.h |  8 ++++++++
>   qapi/qapi-type-helpers.c    | 14 ++++++++++++++
>   2 files changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


