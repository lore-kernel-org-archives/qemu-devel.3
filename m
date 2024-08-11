Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28B2C52D7F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 22:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdGgy-0003fO-8i; Sun, 11 Aug 2024 18:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGgv-0003dq-CT
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 18:05:34 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGgp-0007HO-Ep
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 18:05:31 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7a1be7b5d70so2688693a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723413925; x=1724018725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBNAOgp/eiW/KsKsuaw+2rbNEK1SYBptqNArt3/ohrw=;
 b=T2x72RYaLD5owYieFttfbIo0Qqdr/AsOgR8f9SBx2xDGrC/E+GKUMpRdwlTuRSG4wC
 +5yj/ltJxS0ZChFCDb8i7+aHF4YkxMu86rdCtN21lJaXT20UHeb43BlX1wEGaN0lHwKa
 ODHaFui0a536bpfa8CHl5WtnH4lObB8ZvaekHPiI0IGnQYsy9/gwJRYfgGlSUmJp3YmZ
 7Opvm95D+ykM0D4jwy1A+sFFqgXi/tZbQqba+1j8XNS3IJlZ7N8T/HoxpBqn6ZudQMc4
 7ntOpV/IfICOO1VGtGgyhgK0EhV1PccskLS8FYaJFFmiCAKQXU2BfbyC/TLaeb6B1q2Q
 Zfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723413925; x=1724018725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBNAOgp/eiW/KsKsuaw+2rbNEK1SYBptqNArt3/ohrw=;
 b=t+ayBzvS2tl83QTbSDVon/6sQTsGLIlmRnswNNrVfeyoBE21i8LSBXvuEtWEq3sagM
 HLQKy4Xq1Wo9/ICxevKg9r/ejgrChpuzRW4AbcZzCn/9gr5CNxm/WIv7v8kWBJrAYyr+
 GVYM50Yemq8HUdo6gAJj+mxJ2HwSlG3D0zrKYwS9KBwA/rAsgsWO+caGuF4u16+eXvRg
 LtyZTp5yq0x7QBzMSp1dBAgFQZRh1NxyR8bu6k6zKgtQojHNTSEvuQEkT92/Z1KTkJHz
 Exw1MDkv9u1czmy1L0IpHrf4+OPGV0UVlJrP+IASomLEqdoM3F4y6Y2l4Sy3lWjbi/9R
 1M7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5OVVnnzvsr5pqkvbHTtfPfikN0nw4f04tmKbJsRRo46ipWNV/AnXYSCJdTD2GxhbnrS+yL3zCMYtEiB2kCDuINeUUPFw=
X-Gm-Message-State: AOJu0YxmN4A3ZhGQH4mc65IsknvcHurw+wU7Z44yh31s9de3o6uHBzgr
 vRUQJ5uvAgeVzymRk2ayjMZX+Ipca9nPmvjbbjlt9HuEXyEiP6GJiVtWkFKUwto=
X-Google-Smtp-Source: AGHT+IEfrvuCdokOcx2YviE4g9ZyN0AbErhDkE5iifdzPlmLG7EUn2zQ4mm5J/krveRs/VexwMTe6w==
X-Received: by 2002:a17:902:e749:b0:1fd:6581:93c5 with SMTP id
 d9443c01a7336-20096ba9cafmr184411805ad.27.1723413924840; 
 Sun, 11 Aug 2024 15:05:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c3dbe90325sm2543530a12.75.2024.08.11.15.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 15:05:24 -0700 (PDT)
Message-ID: <903e6896-47e1-450b-9164-314c8924304f@linaro.org>
Date: Mon, 12 Aug 2024 08:05:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] module: Prevent crash by resetting local_err in
 module_load_qom_all()
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
References: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
 <20240809121340.992049-2-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240809121340.992049-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/9/24 22:13, Alexander Ivanov wrote:
> Set local_err to NULL after it has been freed in error_report_err(). This
> avoids triggering assert(*errp == NULL) failure in error_setv() when
> local_err is reused in the loop.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   util/module.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/util/module.c b/util/module.c
> index 32e263163c..3ff4aee2ca 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -369,6 +369,7 @@ void module_load_qom_all(void)
>           }
>           if (module_load("", modinfo->name, &local_err) < 0) {
>               error_report_err(local_err);
> +            local_err = NULL;
>           }
>       }
>       module_loaded_qom_all = true;

Better, IMO, to move local_err and its initialization into the loop.


r~

