Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8B6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jHk-0002nv-Gm; Tue, 30 Apr 2024 04:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jHh-0002l2-VU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:56:23 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jHg-0000YX-Cp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:56:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a55b3d57277so648252366b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714467378; x=1715072178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xTjNiw54Whqg7+24/6DY77OPhypcTEUpIbebJIJUSes=;
 b=gU1o0wwbR4DiOGNuGEy6kkTmTU3eqVd6ZLJ2c1FXc449Wgf5gyk89gD6msB274IW7e
 lk0QwhG0ubbJUEk0tAAdmwrGtSmXGxydAI7X5CrAiv7IFw9TkXyVHQVaXsXXbJ8CFRHV
 3vTbsH7vd4qtGnlcmnF/N6OsvSSp2JRr20iFFnBezCnFu6tDCbpDlP9u7sNdtnC3H0Jp
 SJFvE5vcGPpXaRRgWGX29CfYge5z5rmYVO5OMq9Foo+p/h2LIo/6rOigcMepJZCkocW6
 J9f0twglO+FPxhu61+Qmr4ts3atBwh1jtSmi8PWrtXbkJ34Fijjndx/vS00ZFyFV71uW
 7E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714467378; x=1715072178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTjNiw54Whqg7+24/6DY77OPhypcTEUpIbebJIJUSes=;
 b=xD8Hy/ebcU6w0yqa5sBbC7dFVLltxjhCbuq7hm0TcFagAmfTaVvRdTjkbzlDIdqenI
 iKSrZKoC62gz7tEtlKHgAWpylUfGwBLAKODqpiBEE5WqkbIytKLoy/q1pLbEtLXcmDlJ
 57tPTpRMKT5STMdPFgda0bxI/DtHpjk7zfdUPbLX4qG/1vhBvwwOOG+xNXTIurHqRi5Q
 eqmb7Y62aG4hcqrvq02KMpLAxXDMpt4Es5kU1dqYnAwGvBIdy+R5euXpvXK/Jr2FyQdd
 MLfbC2sG0N6MKIm3zMopZ8YaT+P0BTp/y6HYFPDjKPNX+OeK14zJW1MLAcDnxzzruMzP
 57Pg==
X-Gm-Message-State: AOJu0YxaDnZ1LDK28l9kONu2sq+Z9t30ZAPcogQL76F1JauI4PfZEOEU
 0qG84FAWgT6wUpBTF3bTX21Exs85kHcX0JDKgb7+UVUpzEqOjF9tRofGeiAp4Nc=
X-Google-Smtp-Source: AGHT+IEvv61BSOe0wm9/FDEhSLq/zuGhF2OWjNzTlkNfnbmQ2fGP98BoMLOs+j7761Qrf1hZFhCg1A==
X-Received: by 2002:a17:906:914:b0:a54:4f06:4d00 with SMTP id
 i20-20020a170906091400b00a544f064d00mr8504641ejd.65.1714467377795; 
 Tue, 30 Apr 2024 01:56:17 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 t4-20020a1709064f0400b00a58a4e08893sm6505964eju.104.2024.04.30.01.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 01:56:15 -0700 (PDT)
Message-ID: <e9a82607-eb2f-44bb-b43e-bda2d8c42157@linaro.org>
Date: Tue, 30 Apr 2024 10:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Attach the sclpconsole to the /machine/sclp node
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
References: <20240430080408.415890-1-thuth@redhat.com>
 <ac8c665b-a7a0-45ee-9b3e-baef521812cc@redhat.com>
 <5535d6a6-4f6c-44d1-b1c7-b48672efa785@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5535d6a6-4f6c-44d1-b1c7-b48672efa785@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/4/24 10:22, Thomas Huth wrote:
> On 30/04/2024 10.19, David Hildenbrand wrote:
>> On 30.04.24 10:04, Thomas Huth wrote:
>>> The sclpconsole currently does not have a proper parent in the QOM
>>> tree, so it shows up under /machine/unattached - which is somewhat
>>> ugly. Let's attach it to /machine/sclp instead.
>>
>> IIRC, this should not affect migration
> 
> 
> Yes, that's my understanding, too. I also did a quick check from one 
> QEMU without this patch to a QEMU that includes this patch, and 
> migration just succeeded fine.

Indeed, QOM path isn't used in migration streams.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
>   Thomas
> 
> 


