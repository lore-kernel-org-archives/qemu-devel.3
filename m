Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63456C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRDfN-0007rD-9W; Tue, 09 Jul 2024 12:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRDfM-0007qk-Hv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:26:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRDfK-00012t-Kh
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:26:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso36263795e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720542365; x=1721147165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2ZwhaJnOUNixwmkovs5xhn8U3b7+TjhRihZJ+jqGjk=;
 b=I+qp6oWTqF8CwkNGR7Ex1wCLDAIMOXO5XxLpMoFtlnjwuJOh7g0Kx8HhOnyqUCfPKL
 WwLiF81QWXEkaRHz4eGEeaJo7IdP5r9x8DtvxZJN03wsWiiEgJEiyWgfCfj1SzGK8j2V
 NiBDCdju8y0KPJooS61EF+pYkTZeeRfS1JuaVA8fQREuxMc9CuYOowysB5BDTO4NCIFp
 AtELR7suJF4+/iq28jkozdx26qAqbkFqVKfRxIUxRXWBCibfuqJH7SHSw7oDFB1J9obx
 0oplTvGI9q4b4UfoUX/DTHfBNRRZmYdLSPfU97TWMTJWI5+uctMraE9xxV3uC0TupzhJ
 eAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720542365; x=1721147165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i2ZwhaJnOUNixwmkovs5xhn8U3b7+TjhRihZJ+jqGjk=;
 b=IYfZk9KJoy0o8/PjfFgvZNy227bQlXYZS5VDFpqSqITxSq0TBXefAQvJsps/4BjUIY
 bJB814Jsu4N6CldhrreXPZW7rBBWu6mhdY3AORHphi42bMlTVUo6ZFUcDt13QjNKrNuW
 lznsClIJkV55hgDzsZQuha5aAv6eqIEyUxmL0hK6hMVwapz/0GIHTwNrxPE9veFKFopk
 JK8/Ko0MXVeuMUqeBoDQiEvBvDxQvMbEJZ5H3xJvQMbFttUIZ5BxATyv8MNAa94TotxJ
 L3NFFboeaEpNBQM3yGJlacoTXqFav3rDgzN4aIiVkviBfhqMrdZ38fIGUmG5XZbhawGx
 MaRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM+EIBKmCRWvosyQmSPiqDa8CYGW2beR/zokrL2aXHfvc+w8FtlNvtc//7zQrI1mxuC3a8P9ZmdVewmOevlDMow020AjI=
X-Gm-Message-State: AOJu0YxD9NwzA/GmvdgP8VdUVlxdNQzA0cDv/LHPbRNxbFM0WitichZd
 IOSfXqgA6CMaJ98q504D+w6kwf18NUJVOtgGB4jjhuvvPG1aV3paJ+RkfKp94TU=
X-Google-Smtp-Source: AGHT+IGMwK8CFBs/wF+z8cj+46NHrHpdHlDi5B9EDNqE7UfQpOnIpu+f5AzIC7gJkP6O51gGcuqmrA==
X-Received: by 2002:adf:a78a:0:b0:364:3ba5:c5af with SMTP id
 ffacd0b85a97d-367ceadc875mr2442013f8f.61.1720542365033; 
 Tue, 09 Jul 2024 09:26:05 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7dedfsm3027183f8f.24.2024.07.09.09.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 09:26:04 -0700 (PDT)
Message-ID: <56ef21cc-f2e3-42df-a114-b7368c77253b@linaro.org>
Date: Tue, 9 Jul 2024 18:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Avocado 88.1 vs Python 3.12
To: Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <6d22c5c5-cab0-49d3-88a8-3dd34c8c4938@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6d22c5c5-cab0-49d3-88a8-3dd34c8c4938@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 9/7/24 17:41, Richard Henderson wrote:
> Hi guys,
> 
> I have reinstalled my development box to ubuntu 24 (because the Rust 
> support is better than my previous install; ho hum).  I thought I had 
> tested everything in a VM before committing, but I missed out on Avocado:
> 
>>   AVOCADO Downloading avocado tests VM image for aarch64
>> Failed to load plugin from module "avocado.plugins.list": 
>> ModuleNotFoundError("No module named 'imp'") :


> If I understand things correctly, the python "imp" package was 
> deprecated, and has been removed before v3.12.  This is fixed in 
> upstream avocado as of v93.  But we have a hard stop in pythondeps.toml 
> at v92.
> 
> Remind me what the blocker is to upgrading?

IIRC we're waiting for v2 of:
https://lore.kernel.org/qemu-devel/20231208190911.102879-1-crosa@redhat.com/



