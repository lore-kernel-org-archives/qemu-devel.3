Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724B5C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVLz-0002In-ML; Fri, 08 Mar 2024 03:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVLi-0002E0-HA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:13:03 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVLg-00061h-Ut
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:13:02 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a458eb7db13so260586666b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709885578; x=1710490378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3hjr+hXi96y9rsK4LI2sGzcszVc/xuvXEWVv+y3/7f0=;
 b=CvQNaCAfpY+fjjo9HTimyCza+QxOZ0LZyfZ9vZqUUkX1dlJEzzJ9sMM62cf6BaeKBJ
 3AhuEbJfydMzxKcN0mraPfkJi6N7GZjmT7V+Jwho7ZryfpcbHjpWk6n7RpVRbRs3ChA+
 RHruoTDiOr1sPVQvCdZTSfk+OV6towZjR0ic2FM5QLtGQTsbLWGCmnd/0KMn1b/v+gws
 EoQsXW9I1MFkM6+LLzeUEI5MU19ftQB2ogOBgK/pafpJfP4JL5KNnMGv7afMDrmC9xIq
 9ZJGeZsJhOORtM5np2cRVKdtZgZlrwOGc5/zH6CmuSZZslz1/0IvKSg2JiSc1UiMOYjC
 e8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885578; x=1710490378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hjr+hXi96y9rsK4LI2sGzcszVc/xuvXEWVv+y3/7f0=;
 b=qte5Q3uSI7+nd0gbBO3W0eaZQDno9hjfUPLFqUPhonnhleb+jCg4Ku3TfJZ7+TyAqF
 KPQzmjhGthyz11yZ3yBCJFI2qvqu35gNHViiFYVOhtL1GCZuvRU4A/mRfv8PN3/k8C/L
 HAYqmpupsfa6vDgbWWU0u09ZxnIHG0b77PpYyoUh0Bh4Y/V8oykM8zXcE3cIu772oCoj
 AwHGZAhruvo1cyqFcJFsHxzD8KVZSSeruaFvBwimriTslMv2fPkSBfLNUyhL135ska/L
 tCxEv2msTsBvZ53Y8lc1CJ/K/ps6UfYxPoM7r0EDxT4eYI3/JVovlxo+/rm3B95Y8vIn
 pC5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpTaG1uQbb+ucbbX1Z5n2G8a3Bjk7C1s6xRUZCE8xmUrdyxk82Y0feWcE/YRcR3+1L+MXu14HhG16bE6Tp8MGduDYtgpc=
X-Gm-Message-State: AOJu0YyazYlEJ+ncDO63F6wubfabwOosFIIc0iTwqwFCIOjnXV02gZE/
 p0TayLcrkjnH9fITGpcN1AtE9EUZSCvouNIcsBltBIpIk3QpTK74wWO0bQTd0qE=
X-Google-Smtp-Source: AGHT+IGW8vQzXPMXhNRDB9cqXkxwFEJO3I6JyONCsSyIMVH9IKVxvzU/vWff8R6P7LitdnR02xsbzA==
X-Received: by 2002:a17:906:eb4d:b0:a45:b36c:55c8 with SMTP id
 mc13-20020a170906eb4d00b00a45b36c55c8mr5392711ejb.38.1709885577659; 
 Fri, 08 Mar 2024 00:12:57 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 jl1-20020a05600c6a8100b00412896298afsm1327135wmb.1.2024.03.08.00.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:12:57 -0800 (PST)
Message-ID: <7cced4b0-0c95-4544-9599-a2ad994cdc98@linaro.org>
Date: Fri, 8 Mar 2024 09:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/i386/pc: Trivial cleanups
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Bernhard Beschow <shentey@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240301185936.95175-1-philmd@linaro.org>
 <2062822B-3D5E-4D17-A913-0036249CFB50@gmail.com>
 <33636782-de00-4a9a-87e1-59beac29087f@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <33636782-de00-4a9a-87e1-59beac29087f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 8/3/24 07:05, Michael Tokarev wrote:
> 07.03.2024 21:57, Bernhard Beschow :
>> Am 1. März 2024 18:59:32 UTC schrieb "Philippe Mathieu-Daudé" 
>> <philmd@linaro.org>:
>>> Trivial cleanups, mostly around the 'isapc' machine.
>>>
>>> Philippe Mathieu-Daudé (4):
>>>   hw/i386/pc: Remove pc_compat_1_4..1.7[] left over declarations
>>>   hw/i386/pc: Use generated NotifyVmexitOption_str()
>>>   hw/i386/pc: Remove 'host_type' argument from pc_init1()
>>>   hw/i386/pc: Have pc_init_isa() pass a NULL pci_type argument
>>
>> Ping. Will this series make it into 9.0? AFAICS all patches are reviewed.
> 
> Philippe, are you submitting this through you misc tree, or should I
> pick it for trivial-patches?  I'm often a bit in doubt about patches
> you Cc to qemu-trivial@, - a few times we both tried to submit them.

Yes, series queued, thanks!


