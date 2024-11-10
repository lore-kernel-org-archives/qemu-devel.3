Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6BAD12D44
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 15:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA9zH-0002uM-CW; Sun, 10 Nov 2024 10:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tA9zF-0002u4-63
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:36:25 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tA9zD-0004rB-L4
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:36:24 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5ceb75f9631so4608138a12.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731252982; x=1731857782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmW6ZkvgSMNNTtw/YzDhJX5tLRLxjI6tTQQNSzGmjPg=;
 b=UkzmVjtQwjRuU/mnKk7xa8KWCPwDFsoiY6DguJPni/iwaKOUuCm/Uqs3+0WiCkd3RV
 CZD/Q9vvG4zcRMSsKROGBRHARX4FdMcsOpQvov7lMqMFzwrmWqnO5sQIAXqCTI4SdU+2
 hm0s4MFXrMfLliM4FwV5i1ugzJuHyatGh3ucDEsEdPGgsNNkTXWxiVA6xA6scB/zV4jM
 ncDaS4X/k2rckp6K1yesZGbAwIlPfo1hEp43QpjlV3iwo5BQTsssdyKmHewIazP7pWiR
 IuvIOpAX/N8+md5XrOnaZ7JmAJhCQC1ipAnOlxUjl3JVfMqs+CNGp18hJWbL1+JzYwYZ
 oQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731252982; x=1731857782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmW6ZkvgSMNNTtw/YzDhJX5tLRLxjI6tTQQNSzGmjPg=;
 b=TFfTL2W2wPC/QNUf1r5MqqCspzc1TXBcbFJkYiuSjKiBM3l/7RSNBaYdYie1EB+JOH
 IB94Zb/HQEEg2zaw480Eo1tiewlQvXN8l9gVbhB+g4jOJ32gqy5EjjRmLilFXJj/hRVa
 V6v/w6k+bbKYkVRUN/gbOfqG6WInxgyAH9WQUGqOaraJDTfRc1UQ/g//yvA8WNS0y0dA
 IOfR13wz/+h2c+X64XLeVI9d/ExR6GHb4RfMX9OqtZCAabIrgTD+69/kmJqcoWALksWc
 0ke37iPy0SUnrzdgft5w9fPt2GRlLMO6JSgyfg8nidW27xC9Sy/sRiy6hWtj6UaNrCkx
 ijMg==
X-Gm-Message-State: AOJu0YwkpxT0BNpsNB6mIo0/6m3GhVfQd7XChVkhmvKzshQzLNl56FRc
 4QRfV1fZZhOD/t/4otLHq7dOlnoYspvCQTDJN6AK9tYcgd4tre8BYoCSn5x+RIU=
X-Google-Smtp-Source: AGHT+IGVIf/JZpDXqbUOdvMAjgEXDM0KcRugchMQaX5rx43DqzUQT1egkt7ivPlFKT4DD802tYc4vg==
X-Received: by 2002:a17:907:8693:b0:a9a:26a1:1963 with SMTP id
 a640c23a62f3a-a9eefebd0dcmr978432166b.7.1731252981582; 
 Sun, 10 Nov 2024 07:36:21 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-70.dsl.sta.abo.bbox.fr.
 [176.184.27.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4c0e7sm487794366b.75.2024.11.10.07.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 07:36:20 -0800 (PST)
Message-ID: <3e3075c0-7555-4732-9f2b-4c0ad9b064fc@linaro.org>
Date: Sun, 10 Nov 2024 16:36:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: CC rust/ patches to qemu-rust list
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
 <aa360d5f-b4f2-4a61-a5b8-decc87a97a7b@linaro.org>
 <CAAjaMXayR_Ugkz76OuYe97tEKvHuuJA79f71GJA=zt8L=ESb2Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXayR_Ugkz76OuYe97tEKvHuuJA79f71GJA=zt8L=ESb2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 10/11/24 15:19, Manos Pitsidianakis wrote:
> On Sun, Nov 10, 2024 at 3:59 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 9/11/24 19:29, Manos Pitsidianakis wrote:
>>> As of CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com
>>
>> "As of [*] ..." but I'm not sure about the usefulness of "like
>> qemu-block, qemu-arm, qemu-ppc etc but", maybe scratch it?
> 
> I definitely find it useful, for what it's worth. It's an all
> all-encompassing topic, like block or arm, and some people are
> interested in keeping an eye on those topics if they are not CCed on
> the main list.

What I meant is to reword as:

   "As of Nov 2024 [*], we have a new topical mailing list for Rust
    related patches. Add a new MAINTAINERS entry [...]"


