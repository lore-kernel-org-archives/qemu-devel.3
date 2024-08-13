Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9365C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0im-0007UN-7V; Tue, 13 Aug 2024 19:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ik-0007SX-DU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:14:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ii-0004ja-Qt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:14:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so2696825ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590864; x=1724195664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbJjOJ6vu6l+v7xIeh9JWf3+4IhI1Le96u7YqHamqNY=;
 b=OCg0W121dR65gduL4B80pJnjJX4pHQCtnEiKPkkLj2VRVd1jxdRCRMQKls2Y1LUUW5
 UeDvOy7YfkBpeH7NpeIVbP5R2eNo+N4fl6AIRK7/oZvNQOPP7v7Wkx/8QqpJgVtpw04o
 3NUCx0FIx48SO4otfSIoamagXBo7bvHhMz5o8eVq5I204KdhgjNxvc52Dzb3xgRgmGt+
 lLhBpMaWpbMCE7eJRoKEMDLrt/NTQx7eVnN5ZgCDygwwiRJ9W9OwKd47BfMQefUS8hED
 rk8Se+BCAO0FIauheEzi9k8rp4esUfmzHZcxtOgZeeFz0POH1MY0Wrv/aKdc+D+Iylgf
 3KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590864; x=1724195664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbJjOJ6vu6l+v7xIeh9JWf3+4IhI1Le96u7YqHamqNY=;
 b=dgW2kWbOhcey06tZzH0DUiUNwk9H2F94CvcfZZTAWqOrPRzqSH++5n8tmzk2Zqp58j
 1TJSnBTqFsdLHYYgr/BtsvkWrgIIJ9f8ewiY0Crg9B5OtqMd/4zmGAyT5CQ5d2LJSt9A
 23pOAAajDIrV5YpBhEPrlV7ixxV+H/NPEdtXKpEhv73wSp5FiMi/sS9jaxQVW7Q6zoV4
 dZo04+ccKnCw0teSPuxtfmUJOaqJj2HNJBNQ1y8Kc6n50c3ZUbESXLc+D8+/cH9bZYA/
 mejhLDYa6FyxJwGLkjZvyizk/V4IxpAz1l4sZem2AbcNW/38KmseOwT98/30XzXFqyOH
 18xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCzl6UPHZ5pDDLkUEU1kdjxTj4xRgEHKH3vxIWkbTArJydD3xiHC+pC19HVDP2r427pZzfE2B53jK2WkMhXv/e54RNzhU=
X-Gm-Message-State: AOJu0YyLvihmrbIo8ed6MSSk3peh5byS/gmfcE/u0CIA3FX+Lr39X4TS
 RQ8fS381HtdIU3J9whgOYbG/OAzB5gXJSqxl42rgT5A6jq06n5NxJavIEp04SVo=
X-Google-Smtp-Source: AGHT+IFxnLruQasPEy6HPzXMbFnxoNy5dyEax8mQsqhMwIJCuYopI+8lPyO9Ce6LAC2C9miDQ0poKA==
X-Received: by 2002:a17:902:ea0d:b0:1ff:5135:131f with SMTP id
 d9443c01a7336-201d9a1ba82mr4217995ad.25.1723590863923; 
 Tue, 13 Aug 2024 16:14:23 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd14c9besm18582435ad.106.2024.08.13.16.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:14:23 -0700 (PDT)
Message-ID: <40056dd8-6ea1-46bd-9817-672fa02dcdbe@linaro.org>
Date: Wed, 14 Aug 2024 09:14:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 08/10] hw: Use device_class_set_legacy_reset()
 instead of opencoding
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/14/24 02:52, Peter Maydell wrote:
> Use device_class_set_legacy_reset() instead of opencoding an
> assignment toDeviceClass::reset. This change was produced
> with:
>   spatch --macro-file scripts/cocci-macro-file.h \
>      --sp-file scripts/coccinelle/device-reset.cocci \
>      --keep-comments --smpl-spacing --in-place --dir hw
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---

Spot-checked.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

