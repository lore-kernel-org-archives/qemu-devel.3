Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C6DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCZt-0002jI-4C; Tue, 09 Apr 2024 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCZm-0002Mx-B1
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:35:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCZk-0002hM-A9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:35:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41634598125so24067115e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712673349; x=1713278149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWrGQrIez2G8cNwaMl7BuIbr3mf7BOWT85ITfYOF0eU=;
 b=Zf+KZqwDelwzQToNqJI0uznOUF1sGYYPyH73uviXAig7rXG/Utlk3e0Zp6M8j6ufFP
 eYeFkkLW13zLzdYMYb4ywTzYA59cNYw9qsswgiLMtD7/vGziAzn7dKQUufUO0KD4qxaP
 YINeZu0DFr3KQT6SL7JLfNZ0zWAuwh818TrqM/NQfmxyCcsuxwbxThvqe8xcjjk4PGKx
 TwWEdZvHSZ1/V+jgwuvNdMstofUCX5TK7N6Xv4cmMvEvJCJNocykWlKOkCv+IIcYiZLG
 9QMifZ+D6pCiI9xxCA/cR7eN9ItY97U/w1s3OL9cWNfpax2usQVuXUqjVS7YAuk15wlo
 6lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712673349; x=1713278149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWrGQrIez2G8cNwaMl7BuIbr3mf7BOWT85ITfYOF0eU=;
 b=g9AUvVfrIIxzvflt6kH0LImTX8At/28H/YAeqlB3BhszFCtDthp0OLf9aGVg758B7D
 s+ooYPBnxZZIpXuAvgGYuAiEAAtUXlUBg61S2IDGG0Ok0fCkAjLqrvxyDTJG0rIfBhKV
 J1Eg4EB0buWlh4rOOiLi1sH1tj0zckkyFoJT/lwnlUBjCR6zR8vvqL06/fBAvoVkQPYE
 vZ7wVFyiJRoXVQvqpD/S2sJReyalEWc5FN9jo1FNXELRTlceJJEPFyxGn0OdrqSTJjXN
 1kBcVIpW30OY4CN1E7mpuoMfrdrBfEWSFnJQxesoefbtJQH3kT2nU03nQyNHqmXyAW1+
 8cGA==
X-Gm-Message-State: AOJu0YxkaXbd81Bn+Bu+CT4RqoOsGh7ZAhaqxlLWzEP1gl1XHz0SdHLG
 AQUv1l7QY9A5dfJEhmDzpe/WtpR/41YgoPHkjIuy2Ppr5LO15+FPgVIT8qIrnm9oDKfV7xL7t2h
 k
X-Google-Smtp-Source: AGHT+IGPUhdF2GG2aLC/nRR7XuCnhZZNZT5KjQFvOLzaO4yS4PEtyHmY6ysz4PrO6CHvtDZP1EM6IQ==
X-Received: by 2002:a05:600c:5489:b0:415:46ef:8b6f with SMTP id
 iv9-20020a05600c548900b0041546ef8b6fmr8901654wmb.30.1712673349464; 
 Tue, 09 Apr 2024 07:35:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05600c0a4900b0041638a085d3sm13117566wmq.15.2024.04.09.07.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 07:35:49 -0700 (PDT)
Message-ID: <250524f6-14bf-4fb1-8efc-e562c1d1c857@linaro.org>
Date: Tue, 9 Apr 2024 16:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 0/4] hw/virtio: Protect from more DMA
 re-entrancy bugs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240409105537.18308-1-philmd@linaro.org>
 <20240409073320-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409073320-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 9/4/24 13:33, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2024 at 12:55:33PM +0200, Philippe Mathieu-Daudé wrote:
>> Fixes for CVE-2024-3446.
>>
>> Gerd suggested to use the transport guard to protect the
>> device from DMA re-entrancy abuses.
>>
>> Since v1:
>> - Take a DeviceState argument, not VirtIODevice, so it
>>    works seamlessly with CCW devices (actually the original
>>    code from Gerd).
>> - Build and test :>
>>
>> I'll send a PR with these patches later today.
> 
> I reviewed these too now
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, series queued.

