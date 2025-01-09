Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AADE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVprk-0000x3-Tl; Thu, 09 Jan 2025 05:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVpri-0000wP-74
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVprg-0004rQ-1X
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736418850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xZgfODsCMirhWMQREJcfner/V+vhcW4GY1m5PKjpeiw=;
 b=KakmnMo/SQ8RI1Yt0YS7YNosnrFYR5qvsRD0326MXOxdpGaGMt18IToa6aGL3BdBoJJoED
 ZDYPis0v7/jDQ+YosXcoxCH3bzqUuovGeZNd13S9mb7pjwDP2G+Y22CrzSKsy8zeGIiCmB
 w/LJFdPjkOCOXHefshekZKCei/EG8fc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-YtKL2IwGNHaY210z8tHcmA-1; Thu, 09 Jan 2025 05:34:08 -0500
X-MC-Unique: YtKL2IwGNHaY210z8tHcmA-1
X-Mimecast-MFC-AGG-ID: YtKL2IwGNHaY210z8tHcmA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e6cf6742so181971185a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736418848; x=1737023648;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZgfODsCMirhWMQREJcfner/V+vhcW4GY1m5PKjpeiw=;
 b=sy6HIq4ELPYU6ykHctfWdcHuYMohhL8p3PYqEKGsz+2r3utgU868x1DvuXkGrUis6q
 zp/cGxWnlOwx1JalbjsHOb7Ku+bOsMIBqRBlbBnVIbhnLXCgP/FwJR3PuhphNYSWUdt8
 fxSdOwUkyvbiit0BfNg+WR367HtjxPalheGuLUyt4xJtMWR1yX4tWmFTcvBAg7ZRGvZb
 YeYHs2QO2Sr1bgc189gny7lfERlQbdS6aOYiaIwg3L0iPUKaB6lR/N5H8ou4H3lS8xdA
 NkJkrAt0LI10vSpJtQtu6nnoogCct6Ifs1+IB9WtzzqIUM2MezdJt4DLNm2OLiuakaj7
 9ZGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFSFAPyb5JIW0Net4KQyFjDvYxBwJ80oFvjP5fUHYO37CFRBnbfpPs1MEFK35jFgiRrxj6wfDmEJZ@nongnu.org
X-Gm-Message-State: AOJu0Yxr+xXxowexkgt8fMq8X4qwm1OzQP5VIFkWa91MI1yW3boR0eMT
 Y2kuiZ0rbaHoCj3YUF+yrn9BADTqGCKKQqLO33nWYPiau6ZCrw2YOnEerLDHWZprrMtg1IybkPV
 kMkC/lHKkA10/Igki/QthN62CZTHi+HxdNsq1NRVs+sJej0xg+4A+
X-Gm-Gg: ASbGncs7Cw0RySi754QsYhKWnn6ToDPCfkJ9QSc8/O49f6M0yC5iXtsA7WddwoF6WOC
 eNkYT4j6aoCKPKXMWhjTzDyqp2hH7QNUBOuo1HqVbXYZKNrS6jNG0cp5F4AxOSYa2bCjyAdgVK7
 Lys37SPNTuIHfEGXMWKLomzghZ6z4BM9aHePEqw16LoDugKicC+mx7jzG1U6Kpw5jrMKvbJnE0O
 16KUC/O0PhUMeUBCWtHuTsGpxKl6ZcvWqldKBOMA1YOV3Z870RMqxwv9l6T40ZDCuBngOjj+yeo
 grD8YFtlj8lpR1heyfw=
X-Received: by 2002:a05:620a:4712:b0:7b6:d9df:d53 with SMTP id
 af79cd13be357-7bcd97a41f4mr1071196285a.37.1736418848340; 
 Thu, 09 Jan 2025 02:34:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZSWC3DHxWEswRBQ39cUg3SGjF4ss9krBFR8AAImOzbxV6rynTXkow3CXBzmQbSjZ+UDxrjA==
X-Received: by 2002:a05:620a:4712:b0:7b6:d9df:d53 with SMTP id
 af79cd13be357-7bcd97a41f4mr1071193185a.37.1736418848026; 
 Thu, 09 Jan 2025 02:34:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3503258sm52802385a.85.2025.01.09.02.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 02:34:07 -0800 (PST)
Message-ID: <bfc1b1b3-a127-4c16-aaf9-380168cebfc9@redhat.com>
Date: Thu, 9 Jan 2025 11:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Remove sd_set_cb()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250108100240.960593-1-clg@redhat.com>
 <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
 <B66657AC-BD7E-4F5B-ABC4-FF373279FEC3@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <B66657AC-BD7E-4F5B-ABC4-FF373279FEC3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/25 11:22, Bernhard Beschow wrote:
> 
> 
> Am 8. Januar 2025 10:43:07 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 8/1/25 11:02, Cédric Le Goater wrote:
>>> Last user of sd_set_cb() was removed in commit ce5dd27534b0 ("hw/sd:
>>> Remove omap2_mmc device").
>>
>> https://lore.kernel.org/qemu-devel/20240903200446.25921-2-philmd@linaro.org/
>> ;)
> 
> https://lore.kernel.org/qemu-devel/20250108092538.11474-8-shentey@gmail.com/ ;)

OK. I'll let you decide what should be done in SD.
It's a real maze for me.

Thanks,

C.


