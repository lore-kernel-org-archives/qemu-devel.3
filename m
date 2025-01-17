Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CC8C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYifP-0008Ld-V6; Fri, 17 Jan 2025 04:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tYifA-00082B-5l; Fri, 17 Jan 2025 04:29:12 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tYif8-0003oc-0g; Fri, 17 Jan 2025 04:29:11 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab34a170526so259765566b.0; 
 Fri, 17 Jan 2025 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737106147; x=1737710947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3OXCptAB3T1Y5AIABafbO97M/zyNcnw8SxPu1ye6Nc=;
 b=hTAnEo+KjWSJNdJ6mU2KpJTtt7rkfmG5Crwr4AdlFvSHOimEc83tE897eGwNdUrV6E
 GpSOwcJ/cm+dGhH2Bb5EAJYt16s1Az4Bx0JQPeR5+wl/ZcF7MjghxfFrs4YxGXtbtUBr
 R7IfBuF/nRkkLWFBWaTpUs30cIfo5PnbPj3wkMkVMUbIRXWXbfrSbpHVF0MtwzX0Mctj
 gv0XDzivpHlPEqKt7o94wmJCdQNUihESJRjWJI4wEVrgj6ODDqj4ZF8ymRv89tqKiZGA
 1EXCUujDrlsdZnI2DRpwKx+BoMDI9aiTJzK7MAeN0iPHXsRL31pOckk5cAEo2a3BlguR
 +6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106147; x=1737710947;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3OXCptAB3T1Y5AIABafbO97M/zyNcnw8SxPu1ye6Nc=;
 b=HFcrat+EMbtHXp7qD3Ymaa+qlIImQn+vHWQEMpafJm3+JCrUADz8xJMgnZGvTz7pLv
 SP4LgBMQncJHYY+TPZeagqcAfSCVIawvsOlwawH2DVEgQGA3isCiuVj5IT3Iz1UzXier
 undYa4eXl6qnWanoetoQTn5QGeOmc6VjoZfHwp5tveWSh1gJUJeRTk9i1ivjrKZ4qFmG
 J7SXqhwAsYTcIvDO6eTRnVdsvgNpTWtoHj9puaYaNPM83C1PNqol0iglqCLHJTw3jHsI
 rM1q15EaDUxYg26zbyAq4U7DpQB4Rno95JNAjGOiNghxtALzrRW7+5n4hPKv+2liD7am
 glzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQfQ0ymqjCCTPrCxmReQc9QJKldnD5oWlYUyuIBlHqNzIIjebMJsfLd9bmVD/ID1baKoThDsmvOw==@nongnu.org,
 AJvYcCWbYnko6rNMaMFj7GWr+YNqINaJFa6imkNNz+xtKY6TG9e3HnEOJgHxe3N9Nmc6Z6d0LcOKsnAWbWHPcQ==@nongnu.org,
 AJvYcCXTyTTDkxSz9A7PaBi69taT3mrOeeOGTNYS5hbjypccB/B9SJUFCBdEGc/hrGOMMLBBArSSJfBqdu3paQ==@nongnu.org
X-Gm-Message-State: AOJu0YzUU2Qq5BwqXhT75v2AD3VY7ZE6ftbA9imBPlHZ1CLmua7HztJO
 ej7kdfzgzU3MsG7rXDW3Pjkt4Xsd+faayAHNPTWVSubBZFqNFA0W
X-Gm-Gg: ASbGncuqcRxcUWoKIbXP4sovhCo+fRa7mXAFU4uF0Hq0UeLmA4tOZ4B4Kc4nDxltQLu
 7rvMFRjg/IrMJH+TclVG/mHLXoqBG49bdAlQTbz9rBLSnU4lss+b5brGzJ83FGXc4Vi0/L02qvV
 y4CULckJIsk9/5uYIfM/grE/lbl4GU+MjpS4RlE6FaE3ehtheoJXswxmAINlIK/LFkUsGZ6Lscg
 gj47BfvSax9wLo7TEVIyT8qFnAdf/5N5g46JOU13bTQ2zXFKpCwhClUDhocDE9e+5PSJtX5TNWe
 BSPM2sD4LorKGz1FZn7ynRDxX8hR
X-Google-Smtp-Source: AGHT+IFwj8FfS2YUPofAJpydk6wLFSDxXKtRFbNLv3+R7NEgvBETlZtMTkuKXUrbKRDJaj0Sfy78mg==
X-Received: by 2002:a17:907:724d:b0:aa6:b1b3:2b82 with SMTP id
 a640c23a62f3a-ab38b0b7f70mr74454066b.3.1737106147366; 
 Fri, 17 Jan 2025 01:29:07 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-021-087.89.12.pool.telefonica.de.
 [89.12.21.87]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1687sm138288366b.49.2025.01.17.01.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:29:07 -0800 (PST)
Date: Fri, 17 Jan 2025 09:29:04 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Peter Maydell <peter.maydell@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_07/13=5D_hw/sd/sd=3A_Allow_for_inverti?=
 =?US-ASCII?Q?ng_polarities_of_presence_and_write-protect_GPIOs?=
In-Reply-To: <8e61492c-e293-4bea-a0e0-e41d815d8b47@linaro.org>
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-8-shentey@gmail.com>
 <8e61492c-e293-4bea-a0e0-e41d815d8b47@linaro.org>
Message-ID: <1B33AD33-9D74-4F18-B9E9-EF6973962601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 15=2E Januar 2025 17:32:13 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 11/1/25 19:37, Bernhard Beschow wrote:
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/sd/sd=2Ec | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>
>See question on v1:
>https://lore=2Ekernel=2Eorg/qemu-devel/e202623e-eac7-4ed3-87fb-002491ddf7=
45@linaro=2Eorg/

Oh, I missed that=2E I answered there to keep the context=2E

