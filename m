Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8939C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWMz-00033C-BS; Tue, 20 Feb 2024 15:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcWMv-0002u6-J4
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:05:33 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcWMn-0005If-M9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:05:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d51cd89dbso1605866f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708459523; x=1709064323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ULJDfsRzrtmbDohS7LgTll9OWxBdR6KwLnwVAyRv0Y=;
 b=BK7lfZfgj45DvzKlUy9xg4K1SQiZrHaOj38p+chweezMurrft5vtrY/gxKgIRWXpQf
 BTNOCjXQBwQOhjo6tuCcWi9T9HS/gdHTN5njs9awnL2RHeg6oxLLtL1RknB2RmLxPQ/N
 U7x6IhH43n04IlmZx99gFXFw1qlZwEqelUO3dC9/1TLPjJawaUbi1QL3cOIBb5Pq8CrR
 hI2MJraxTO9COP3zixuIB79qAPjh01zLB21rkLDoDsdyaRJAs5P6fEcvUQAtxsvqO3+7
 8QEo7cgknxhmoIzeeGc0VlbdHcYzH00nh/Xw1cP96MZUT1Fyesh2SG6LP5XIIsJe9yf2
 tohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459523; x=1709064323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ULJDfsRzrtmbDohS7LgTll9OWxBdR6KwLnwVAyRv0Y=;
 b=eP7b2wzwpwCiyc6PPVyNUllMlZXLgqFsfAzBj/T7y1dKP19M0ZeBbuyI7qTMfzpvI3
 8/4L1O3fK7KB5qJWc3B7nR19m9Oqgs4wWT7VuXG3Wzef89EXulfL2Ex3rCdNVuh3P43S
 5gw6U6kVjZfdlNRWlmB5RvOXgtMTuBb8StU9ajy6bx2dO7Kn7g8DfKayGNbVvV3tykx6
 0zdMu1KDmjO4sGm51wH2vIuobgqgn99qnkAAItalCKemWlysWo7jcIElua3wOrVGWE+M
 KQNraXINY3PlaEG4czsW414F/XKzLKerOvIBPCsjelKaEFtvJzDkHfjiTOez8MuMGxxz
 i1TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPy+/T9sC5pJRH94gvQs+RCRgPxELDZpCuTM1UeUaZRPRlNL4W4ESCXJtLSFakf7ieukeZaiCmEfBC+fViZJc4z2/wBmQ=
X-Gm-Message-State: AOJu0YyM+iWA1yQNEYIlwDCHvOzDLgi/6ABTLV7kriXPDY9yBmpzCec6
 kzQNiQOmxOgXXt6/BJXKZDNc1b6KgTYwvzn87UU5Vv/UzUVH5bBB0H4k7ZOe9DY=
X-Google-Smtp-Source: AGHT+IEmvCPa1ZEDLtuDKUIBs3UoxSzebprmwsBWi/cZ6pFiERVvNEgk6WJ3eJegqd0gPsHUN3oo7w==
X-Received: by 2002:adf:e450:0:b0:33b:5725:e516 with SMTP id
 t16-20020adfe450000000b0033b5725e516mr11080578wrm.51.1708459523268; 
 Tue, 20 Feb 2024 12:05:23 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 n1-20020a5d51c1000000b0033b1c321070sm14427326wrv.31.2024.02.20.12.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:05:22 -0800 (PST)
Message-ID: <9d357d62-edd7-4de7-9ada-bd0f75d32112@linaro.org>
Date: Tue, 20 Feb 2024 21:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 20/2/24 16:19, Thomas Huth wrote:
> On 20/02/2024 16.08, Philippe Mathieu-Daudé wrote:
>> Have s390x always deliver NMI to the first CPU,
>> remove the @cpu_index argument from handler,
>> rename API as nmi_trigger() (not monitor specific).
> 
> Could you please add some rationale here why this is needed / desired?

Heterogeneous machines, a NMI have to reach all NMI-aware HW.

See also "Remove cpu_interrupt() from hw/":
https://lore.kernel.org/qemu-devel/20240220192625.17944-1-philmd@linaro.org/

