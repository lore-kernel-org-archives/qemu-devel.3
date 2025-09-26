Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B01CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24sm-0004J1-VV; Fri, 26 Sep 2025 05:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v24sk-0004IE-QV
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:36:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v24se-0000fZ-Se
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:36:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so13102065e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758879396; x=1759484196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oDCkZA3CxUlrhPQSkzdra4tpfiRwGAcRRDGRKyO1qr8=;
 b=FcJQ2NhrWd65WdQN/6Qcs3PfJkPSBU0XkGucz4GECyjYL881pxOi5GKB5yRdohCJLU
 aF9aSfZwOri0/GVovyMgl13qU8DA9JVv3iAHM4tdBy9c0CW6KlzVv0riQHOYhApglO5+
 0CRSm2nH2/5S4ifr3BSPd6bFozsUWuF92me9EBe3/B2Sjrv587kO+nk4OPbEPpRs/I7I
 qhMmSgHHtZXjfUzJCudG6U5QMgyZM0JFHiDXIyCOJNXk/DdyOe3IGF7tBuc3sYhPOZ2F
 Ow4C959r3qybnLVIbZdKdhz8UnLODy4pugp9a5Z0Xvu0genl8ARPgchWwVdIvxC6o2Wq
 F+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758879396; x=1759484196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oDCkZA3CxUlrhPQSkzdra4tpfiRwGAcRRDGRKyO1qr8=;
 b=kA/0yMS8V2prwD5oe+vWi9WwbrFf9IIXUgmGNJ5AC/2LVp+0LMrIKx3IMXbJo0HgfY
 NSe28oJsP8Acx4/rVPNcu4U1/edSN70zS78sVB8FUC+rWwFyJh0NpJGlpZXiwz/NBRPg
 ZMfSumF2mlNYPXrqVlqajCMXYntv2OEFae9BTOfcrHr5W5tPSr3YfY0Lg8hDHwjeJq5B
 GwEsK/XObT+BQ3R9V+aaKeCF27IspNxlpywpIinh8Ew2VLgdCPwJ+LUweU+L2XTuTOct
 HXurptVVUMLH/GfmP8vPt2TqaSJOJHc9uXFarqCCw7olb2sngyBQXYc/Cw3lO/NLstCO
 /i3g==
X-Gm-Message-State: AOJu0Yzg8mF0FJ7jZHC5ZB/xU4aImpV1o3j2XNImLuuW0pZtObqTUIce
 MPVIZF1HFcz6yeRTTBb9wJlD/kZ6vX/l5K4QiMTPpl7b2xHitqKqEKbEP5cCsrSqW54=
X-Gm-Gg: ASbGncuQc0pPWRwOKzXLFyu3vRwd6LNS1BchRLLRgrRYOl6WXw4CtUc5POatbcjJJ5R
 1Vsm1xWeF1idEtVXEH4U0nSfKGEo2TlQMLPGWDsf30nvmnZO0fVZMWZy1add+ZQv3/o+snxeaXX
 /qUTc5rn4UTxvcm1LPNCwQbefNEDsOsUtTG5P9IplMOyCOjRpvMbBpSBHhdHbm7/DoEzkgPBXdG
 SlFLqHp/yXSUx9UbWNXKOh76ejJ1CP8OFEA1xNr6vbIWxWt0Z92tKbt72MGwIhsdRMrKaxRvech
 cx2JC587wKAXBzh/n6vs7VLqYaOhJKIbcdSrqgefPJSTXKq1b1xuDwqYlCTNM92y7rIa95G6o9P
 F2veelMrg9Wk7DmyjNxNmzEslWBunqewAM9F+H+CpNGI9TJ4xUZrxIn1NSljmUDasvQ==
X-Google-Smtp-Source: AGHT+IFrXdOCI2ftbLqqam+UO/JYWqcD3owoWaL8WztAmV/sHJ0YTE/8c8qzooqlfTTV1fWJCsUoUg==
X-Received: by 2002:a05:600c:3551:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-46e32a10ef4mr70132235e9.30.1758879395896; 
 Fri, 26 Sep 2025 02:36:35 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33105e0bsm35439175e9.5.2025.09.26.02.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 02:36:35 -0700 (PDT)
Message-ID: <edb2826b-f513-44d3-a028-e1278a3dd524@linaro.org>
Date: Fri, 26 Sep 2025 11:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2.x] use fedora:37 for python container instead of
 :latest
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
References: <20250926073120.2212284-1-mjt@tls.msk.ru>
 <aNZN6bON0bckydql@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aNZN6bON0bckydql@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 26/9/25 10:25, Daniel P. Berrangé wrote:
> On Fri, Sep 26, 2025 at 10:31:19AM +0300, Michael Tokarev wrote:
>> More recent fedora does not have our minimum python versions
>> anymore.  Stick with the most common fedora version used in
>> 7.2.x in other places, which is 37.  This way, python tests
>> works again.

Valid change, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>>
>> This is a 7.2-specific change, not aimed for the master branch.

Why? We already learnt using 'latest' tag in docker image is a pain
to maintain, and hinder reproducibility. Personally I'd rather this
patch in our /master branch.

>>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   tests/docker/dockerfiles/python.docker | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> With regards,
> Daniel



