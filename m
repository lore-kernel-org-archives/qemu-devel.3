Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB2AC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 14:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8ye-0005Gn-24; Thu, 22 Aug 2024 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh8ya-0005FH-QY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:39:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh8yZ-0000kC-DB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:39:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so6316925e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724337584; x=1724942384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ukufj80TaNtT2oOkSwasdrBCZNH2zbdV7sjzzAN8PE=;
 b=wUfWHZneYbR2rgb5h1fzXDm9LNYdYnPfQYhrVQvUokLRSguRG1xMJngFsQJK4q+ptu
 gl3XTF/ttew4dWFtjWytBYN8TK1RRqyUJkS572/cXPYs8qbeDPmsi+VSzRvYn901YZh/
 O6RjXdSSjwNOYx0DYi2FeahNlxTHjULmTMNNlBeyMebTiwEyO/xaCLzJl/FuIiltObTp
 oKgmnZRZnCzmMWtz76mwaIU1+ql3SqMzgFUWIlWNYBbq/tp9K/831FbsUCqVUY0zIuti
 3ds3j95v7T4GUVIYac4tAG6h4hRnFfDAitA+R4Axd3DB28skqAycMPK5mpyF3fCYlANh
 xjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724337584; x=1724942384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ukufj80TaNtT2oOkSwasdrBCZNH2zbdV7sjzzAN8PE=;
 b=K24uJD2HgXlEM1uRcTZ78G+JgirUYmXzNkAiyqZKbv3k0LAEiox13Ybwvfnlio4wDJ
 pew/FgqsbkEKOknm1mNGxS6Dog8ZxwSgLk49LyBkfBd7GA1/5VwPXtvEvOInMKpbWgSo
 jFDVaQAPJVc9D2KQ+L9FWdSQHsPa85xfXxVv5Euq8gJgMX6nRyCoy8tGiEJh8XO+nIkV
 TwGFzWC3edBPXZ/wvlxvwYJL7siQ+sW27opRi2RVc7aKIXKanBQfJ6B8ik9X9h21yTwh
 WlovCKH2uGwX89WmTmGwQO/2vayG543btbYKhhdq1hFfvvFvy4WLneKcfCpURbihduvg
 t17w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhDYInw/QFCIb8luVo+braMq/v1NUTY9+wNWBCV/KpNAGWH3F6xEz3X+tveJSzVqr4qCd07dLkcnQq@nongnu.org
X-Gm-Message-State: AOJu0Yzwn++vi4N/l1RX11yj/eahPVknrjhtrAUseqSHuayJ+y0K9VCB
 a7nv2Sq24+74lX2j5k9jqPpQ988Nym8NVrWoXftwECMMDZZkO8ah8z6SRguS4Wk=
X-Google-Smtp-Source: AGHT+IE4UCOIF0j3jG1FnlxBXRl4KkSjG9H9u4C4MG9wrDG4RR2mxFK1WWPCeXCOGzZda4c+HFvXdw==
X-Received: by 2002:a05:6000:1881:b0:362:8ec2:53d6 with SMTP id
 ffacd0b85a97d-3730905e28amr1791323f8f.61.1724337584189; 
 Thu, 22 Aug 2024 07:39:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730817a4bfsm1835886f8f.62.2024.08.22.07.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 07:39:43 -0700 (PDT)
Message-ID: <b3d054b9-4ede-489c-bca5-b61b046dea50@linaro.org>
Date: Thu, 22 Aug 2024 16:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240822114146.86838-1-philmd@linaro.org>
 <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/8/24 16:06, Marcin Juszkiewicz wrote:
> On 22.08.2024 13:41, Philippe Mathieu-Daudé wrote:
>>   # Timeouts for individual tests that can be slow e.g. with debugging 
>> enabled
>>   test_timeouts = {
>> +  'aarch64_sbsaref' : 180,
> 
> What kind of machine is able to run those tests in 180s? I bumped them 
> to 2400s and got timeout (Macbook with M1 Pro).
> 
> "make check-avocado" (with some AVOCADO_* vars to limit list of tests) 
> shown me which test is run and pass/fail for each.
> 
> "make check-functional-aarch64 V=1" shows me "1/4 
> qemu:func-thorough+func-aarch64-thorough+thorough / 
> func-aarch64-aarch64_sbsaref" and timeouts without information which 
> tests pass, which fail.
> 
> Maybe for QEMU project this is a progress. For me it is moving tests 
> from working ones to "sorry, timeout, find out why" ones.

Sorry for the annoyance of switching from one framework to another
one :/ Are you using Linux on your Macbook with M1 Pro? I'm using
macOS and these tests currently don't work, so for me this is a
huge win.

Most of the (long) time was spent in downloading the assets.

IIUC there is a way to pre-download without using the test timer
(apparently Richard and Daniel use it) but I haven't found the way
yet.

I'll check with Thomas how to tune these timeouts and return back
to you.

Regards,

Phil.

