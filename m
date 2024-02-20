Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8677BC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcW4f-0005fa-Fx; Tue, 20 Feb 2024 14:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcW4e-0005fE-75
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:46:40 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcW4c-0002D0-SK
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:46:39 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso35895145ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708458397; x=1709063197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Svy2+Y6ZTeY+jRmIJJ6lw+I/KoA4S1zb08w5yXDMej4=;
 b=IQn7L3ACalxZXwZ1fW8E9jJb4CS/0Q7hBSqNzh4RW+GiOykepQKXF/56Km6vx2wnFa
 2Z4fWNfWUIaTlEQoqoW27tJlLyzcDMVE8QcCWc0gjmwSVVjowZVammpRtUducH9zWchk
 LLgj1yyPI9lFvt5mTe35R3h7yMRZ41+/Uj6wEj6NtrqS2ymhNurHdvE6kiNyNu4nOUJZ
 gy1CST3A36AnZQg/lai+QC8mMqQXWKqmmye8AvsCd+V4ER6k9NEwDtw8fILvNa5LkPve
 VtTuVEz4C71/P6M2gc3boKIyXsdYOS1nTTuoIDMo3IAo/yBHfSirEGL8RWaKJNd3oGWC
 hsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708458397; x=1709063197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Svy2+Y6ZTeY+jRmIJJ6lw+I/KoA4S1zb08w5yXDMej4=;
 b=eNhNMIUKsQv7XHpw32vnXYuAb72ojD1eXqIL3Z4f4akw0vwj2LEaEr8Mi+MmshogGF
 taeSojuKJPxY6Vrxa1IRQSoL74Zei2vR76AqbQ1bFkZ9oJF/C2HDLX8EilX1E4Y+ZG58
 uBDs8Sfkn3VHmNLn3WxpKnnruEE7hRo8AXwT95tqtAPmjDpBHxkWvyYGlwySEGmC4oWD
 A/DjCh2XhLMqgLR+FUsHYLJYRa/qUnrsOcBRg1UHLihe3BEbzBZCdahUeA2V4xnCnodl
 01B0bqPUbRbPe4MIOIHxrcUc9B5gPjvgJWNYEtEqVmPw1Cx64bV9qCQFHuxQtdsepO9v
 p4AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFrTF4GF1UjhCZUwt9K8umqridNvOPbYZugei54kc5SqrroEWgKhb2m8+uXzO0n/qyrG6CzYmmYFzMZf4krXsAjBR1jiw=
X-Gm-Message-State: AOJu0Yxj/7u3PycCHjVT0QJp5m8zTNQv9EpcnjlEW/J0kvZiVHj9OgDW
 Ddypnrb26lYdIEGIn7xzaYU2/L9EXrGOIC8QIijFbY67mEMMZDfRm0KfHrg+k5M=
X-Google-Smtp-Source: AGHT+IHeobD7SwdxLLxHuYUqlI/a/gPd2gDtwS3EyTiqOZXOF8pbBMnMPE2Vo3mAUw6tfnxIyiMJOw==
X-Received: by 2002:a17:902:d4cc:b0:1dc:93b:8981 with SMTP id
 o12-20020a170902d4cc00b001dc093b8981mr6152121plg.14.1708458397298; 
 Tue, 20 Feb 2024 11:46:37 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 kv5-20020a17090328c500b001db5fc51d71sm6654986plb.160.2024.02.20.11.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:46:36 -0800 (PST)
Message-ID: <b428c48b-578c-46e2-a0b7-c648b012f3d3@linaro.org>
Date: Tue, 20 Feb 2024 09:46:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> +void resettable_container_add(ResettableContainer *rc, Object *obj)
> +{
> +    g_ptr_array_add(rc->children, obj);
> +}

Did you want to assert here that obj does in fact implement Resettable?


r~

