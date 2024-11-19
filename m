Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C58D6206A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLed-0005w3-96; Tue, 19 Nov 2024 05:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tDLeZ-0005ub-Dr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:40:15 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tDLeX-0004Aq-HA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:40:15 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9e71401844so520582666b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732012811; x=1732617611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=THtpbfJdln95maIr7ixA/yr0koffmRe+qHEjDjkjA8c=;
 b=VNViNZBviop+5BkiJRAV3hMWG6bMv1PFHDOqdoJihmrW7gmA2BmmagCxoI4yFl2tKh
 G+nFiNKgdLgalBTb63NXsAirA4jB3KuxfzMGFkLFU3Ctwq7XSqsXpI2rdkwPyd2SfHuQ
 9A7eZBhhYdIZ2+TP37GDzaaeFjXjFXPLetw+pBpifrfcER3GGjOsqmnZ1jrGAMGdM7ia
 0yT8InT+vku/ZVBa3jUxlG6+O4wV4owl4hSGip0CivmnJSQg6AcuURITPOiEPvQzucGb
 KyAPnKR6F2rp1UOa3ZbhkaJNf/seKYyM0K4k6y+udbrrxXWqCUh4LJxBPKKf/4tng0Bp
 z28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012811; x=1732617611;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=THtpbfJdln95maIr7ixA/yr0koffmRe+qHEjDjkjA8c=;
 b=COQ2bo2Rf5CxNKYB/FxlaO+g3VavaKw8/ry5bJxBdlfKklroVV4/P+UluFL2HwZJW3
 Ilm+wUEB0G4IbmGsf3IV+9e/1IT1F0WEWdIrlx9HSEQrrXhOI9lBcXjQvc429VAGfkov
 Jm00Q9/A5m0DUFK7t4mF2uBBOIcifIHcky660rd9kKvA3JBIYUg9CpXolQarAHdkLgIQ
 VaOXKz1OVc5PgEyC5+1BL6vIzUtV5+6mdhmKO1syd4zNcES0hlhNcmOpnpzbO2imdBHA
 +3LfgTAUDeeLXftSJ76HFOIf6RsUk0uEU7Ry/tfloYDxD4777rvGNrxfaIxweB4hIC//
 sntg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTeYtZuZ9oZ9w7E0kq2U51KUEVUoqOxj/Uxo3+Z8CPwUee/8ErDBRUsZyNla5Ts+oFBLM5/gcUaKwG@nongnu.org
X-Gm-Message-State: AOJu0YyTvsniFWZgb4wX8tD61XflF7vkBXjlIptyVSsJzcdYf6WptBiy
 UVoZxUnWOtkBconea1viTb0faSQKKFkV0Uyv+pCUXn2n7apH77X9Os6+fz6STtE=
X-Google-Smtp-Source: AGHT+IG0lQcj0gAaodVVWuBBo0NDzm1D1vtzciBlmBFGIGoFGj580jCq0HIZquTD3Mr1ulBx9UIiVw==
X-Received: by 2002:a17:906:c081:b0:a9a:c03:ebc8 with SMTP id
 a640c23a62f3a-aa4a2d0a3d1mr710289766b.37.1732012811506; 
 Tue, 19 Nov 2024 02:40:11 -0800 (PST)
Received: from [192.168.210.26] (83.11.2.232.ipv4.supernova.orange.pl.
 [83.11.2.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0016a7sm636826466b.116.2024.11.19.02.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 02:40:11 -0800 (PST)
Message-ID: <58dbb4ef-62d3-445e-b891-04a9027d63d8@linaro.org>
Date: Tue, 19 Nov 2024 11:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] docs/devel: add b4 for patch retrieval
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-4-pierrick.bouvier@linaro.org>
 <ZzxXAtuRowg8hp9u@redhat.com>
 <47831adc-26f7-4633-a371-975c97e8dae7@linaro.org>
 <ZzxjciUGNIVoUuVC@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <ZzxjciUGNIVoUuVC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x631.google.com
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

W dniu 19.11.2024 o 11:07, Daniel P. Berrangé pisze:
> On Tue, Nov 19, 2024 at 10:56:36AM +0100, Marcin Juszkiewicz wrote:
>> W dniu 19.11.2024 o 10:14, Daniel P. Berrangé pisze:
>>
>>>> +    b4 shazam $msg-id
>>>
>>> I'm wondering how b4 knows where to find the mails for $msg-id  for QEMU ?
>>
>> It goes for https://lore.kernel.org/qemu-devel/$msg-id by default or checks
>> b4.midmask in git config.
> 
> How does it figure out to look at  '/qemu-devel/' by default  ?

Sorry, was wrong. It goes to https://lore.kernel.org/$msg-id as this is 
enough to get mail.

