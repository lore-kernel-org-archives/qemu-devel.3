Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FB3EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1yA-0001d0-0s; Tue, 10 Sep 2024 10:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1y9-0001aq-FZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:35:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1y7-0001l1-PR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:35:49 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so36867466b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725978946; x=1726583746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ThHsnqzo118WatRvbc8JkNGEO1aD0jGfu2wbQopy0k=;
 b=T7KLIEyxEhSlLv/sPD50dgi+g+87dr4/iENdkPe41VWRDw/Bc5KUHNz+JMig2MiVzD
 bgkC2E6xqDzGASGfIFo/el7dj8za4blIRJeVBnyCrbxSwJ+Lhce6nlmo1APZA/rLp1pQ
 dnm4P3eW6UYwcys+BnBdGwdAv6RPQHDCsBaFjKOyLa11CRTgqp15i29lqdMHQwTijVa9
 S7KCbLGMCf42RedBpRVdbK7fOtSdyHPOHeq9qfTZM/YIMn6pkqSXFq2VfyxtRDNpa3yV
 vW+lGkyUQEbFtijVM2ZSx/q1izSMuYTFX4cjwvNL1C6CH8Dd33YKKbAPEiDTbXE6QMeh
 3n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725978946; x=1726583746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ThHsnqzo118WatRvbc8JkNGEO1aD0jGfu2wbQopy0k=;
 b=dMATyb2hMbTerjpfYvsxaW7yAYnw7qjeJQL+N2gT8QwaDXitD3gCD0yg4c24fdoMnY
 8wpRF2zKNO4gAZuduLwP4QuC7mJtAu1sg3ePdAFcqt78tDeAYJFN6rR3nGFEnRGlQZU3
 Dm4gJyyGwipTD8Uj/hvEhbdKMwpBwdh8jMiwykDjjD6+/y3vW3xPHJcoNRTjNzZphac7
 UFLPPfgGpF54U7lhUTEwInSYkjLrb5rkmZv6bMBWk9RdH9uqAs1jsfBxdRZx4bh0VBUE
 SmZf6ZbG2/xlqnKwnkkA8d+2zl7Bvyf8C2IonjepsbsioEXRCS4dnBhZI9DwjvBMLYkt
 cFBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMuTYOAqDHY4EVIo/Gv3i1+HWxp3MQLECzed1pG9QnYUy1IGh8EMEIRhcY/NJ4rd5HEtOFtNM0RSy/@nongnu.org
X-Gm-Message-State: AOJu0YwYUbdTwtZkWQdg7n2EcOP9+FrR07muk0Rme88JunJXjX89iMH6
 NVhZphCwC8YASlvAgZmiWRIEQSF34gjnVTSECw5lwMJrOpvLBOoYV+ZdNP5u0To=
X-Google-Smtp-Source: AGHT+IHuIQ6p+LijDzjGXue+BWtdpzUYD+GY+gBu4vQn4JVUuv+9UuTMqZN6isCpS9ZmLtjrKxu0bw==
X-Received: by 2002:a17:906:bc24:b0:a8d:43c5:9a16 with SMTP id
 a640c23a62f3a-a8ffb1c213dmr129569166b.6.1725978946015; 
 Tue, 10 Sep 2024 07:35:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d40064sm491419566b.190.2024.09.10.07.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:35:45 -0700 (PDT)
Message-ID: <bdeaa715-84bb-42ea-a3ea-eec330150e87@linaro.org>
Date: Tue, 10 Sep 2024 16:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/29] target/arm: Convert FMOVI (scalar, immediate) to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-13-richard.henderson@linaro.org>
 <678932dd-02e3-488d-8cb1-6f3d37c112ab@linaro.org>
 <CAFEAcA9s1FDB_rFoo6VrcCh_bdL4-sSnzGALSv_+MKCTR9WNgA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9s1FDB_rFoo6VrcCh_bdL4-sSnzGALSv_+MKCTR9WNgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/9/24 14:27, Peter Maydell wrote:
> On Mon, 9 Sept 2024 at 23:24, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 9/9/24 18:22, Richard Henderson wrote:
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> I wonder, maybe you mispasted my previous R-b tags
>> with Peter's?
>> https://lore.kernel.org/qemu-devel/37096dc8-7827-4a4c-a27b-4f8343aa9c6c@linaro.org/
> 
> I gave the whole of the v1 series an r-by at the
> cover-letter level:
> https://lore.kernel.org/qemu-devel/CAFEAcA8vJxUUHWA_nUF-810fDhYyPggtc=HGFdp0QUa5segB=A@mail.gmail.com/

Oh indeed. I'll check the rest of the series for missing tags then.

Thanks,

Phil.

