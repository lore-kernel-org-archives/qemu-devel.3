Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC108C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmA1D-0006WC-0c; Mon, 18 Mar 2024 06:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmA1B-0006U0-Dw
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:14:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmA19-0007O0-HU
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:14:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4140870914fso12630165e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756894; x=1711361694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=00wJxC1sW157NhfgpK7sbTQ1K0b+O6UwpIYPdw1hMIU=;
 b=gVo16KULuP6kr5+vYZtBGjBKK5ImkdtI2IgUHIcj4nPng7r6Yhxl5MyeOR7QFQ+w5W
 whlWawRawwcrWFD2jbfl9pnEbGRIZ2OT2eHWLbhD6Yt3RiGHzzKPL38JJsPSa1qSwe8R
 47MqEy6DKlacelrfnuRzrHd/an/MFt/B7A+3/xg3xAavJoCMQyc6+wQdyGzjv4oKZX4z
 u/xQoT2NunYH2ZO0iEJRi4orBCUJFhhJZKf9Bu0MT1M4h2cDGLg52vlcw1tM6QhT6HNw
 qcxNpQisdoog4jj6j9y/AE6e9X2c1Pgeotq0XNCbhtWqlUWbdem+VigkKACxY9MB+oKq
 gcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756894; x=1711361694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00wJxC1sW157NhfgpK7sbTQ1K0b+O6UwpIYPdw1hMIU=;
 b=ITTbo2Zkiw9lrJrjjZualpyDMwhNZQ/T6Q8+OUKwyDRkvNhmg4yzJeLd0e1eZEEz1D
 Loj/6VeXosjEVNQc94Dov97LyTWQPOx/2YiAjI9G6xrZB/tpsk+NGt+CWwQa7xow6bvb
 rZsLqMv/lmBkCt1kzur3PgTaUS2j0sHIu1dE1yNegmfuby4pVxVD5nuI8/p7nbdVujMl
 VISLZXH6N1Y0mizwARxRju/KPd+tpzSavJPWQIjOESk2pMiXVUyh5aiSy28oZwzqLL4d
 kexAMiYiQF08cQ6JrZWrqN/eTrURrwviaJ9f6RgecESjohCwkcWcJxzXBSyXZmtaULTD
 6KeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNB1XCP3D588O9gVNV8J7MI4HZZ2p4pLIpxbw97PnQ4+AQ+ZkRIerBB93J8kZeRUeSC7GwCP8vJMqTDRyZCaYaP6hgquo=
X-Gm-Message-State: AOJu0YxmOfWzOZZ7vr/nt2EtYYug7ZHJ5i03SKMGqMyLocv9m8RCLBHx
 o16tTRzECRcAwyBQ6dje6a+QOFlM27lqWR7iIx9iuoWqGJ4JnMArIOdoN+pZNXk=
X-Google-Smtp-Source: AGHT+IELZVOGTwEzoMsGNtyvhTG9jcNQDIR6WXeEMz4jUJP15dpjAHA7dnGFwh/0zMRLqVeGSy3RqQ==
X-Received: by 2002:a05:600c:1d09:b0:414:48f:a79f with SMTP id
 l9-20020a05600c1d0900b00414048fa79fmr4975224wms.35.1710756894037; 
 Mon, 18 Mar 2024 03:14:54 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 ay18-20020a05600c1e1200b0041412fa398bsm1566364wmb.5.2024.03.18.03.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:14:53 -0700 (PDT)
Message-ID: <635ba27b-48f5-4508-80b4-05e6158035e6@linaro.org>
Date: Mon, 18 Mar 2024 11:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
 parameter
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-9-armbru@redhat.com> <ZfB0Oq7SSQgiqbz5@intel.com>
 <4b17e2fa-3b6c-4c7e-a888-661d1bf1324b@linaro.org>
 <87cyrr9ars.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cyrr9ars.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 18/3/24 09:58, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 12/3/24 16:26, Zhao Liu wrote:
>>> On Tue, Mar 12, 2024 at 03:13:41PM +0100, Markus Armbruster wrote:
>>>> Date: Tue, 12 Mar 2024 15:13:41 +0100
>>>> From: Markus Armbruster <armbru@redhat.com>
>>>> Subject: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
>>>>    parameter
>>>>
>>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>> QERR_INVALID_PARAMETER_VALUE is defined as:
>>>>
>>>>     #define QERR_INVALID_PARAMETER_VALUE \
>>>>         "Parameter '%s' expects %s"
>>>>
>>>> The current error is formatted as:
>>>>
>>>>     "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then 1 MB/s"
>>>>
>>>> Replace by:
>>>>
>>>>     "Parameter 'vcpu_dirty_limit' is invalid, it must greater than 1 MB/s"
>>>
>>> Is there a grammar error here? Maybe
>>> s/it must greater/it must be greater/
>>
>> Oops indeed!
> 
> What about dropping "is invalid, "?  I.e. go with
> 
>      "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s"

Yes.

> 
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    migration/options.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)


