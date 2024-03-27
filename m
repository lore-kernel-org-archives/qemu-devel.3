Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D3BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpO2u-0003w4-QV; Wed, 27 Mar 2024 03:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpO2p-0003vP-47
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:50:00 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpO2n-0007EB-D4
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:49:58 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5159f9de7fbso4929988e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711525788; x=1712130588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrGF31tzvXVgaalAMxJGyScTlNrN3QLj9ehfjtcu3Ow=;
 b=j3lPKv7j7Ul2G/eO5KJDjyloDj4gBk/ft7W/3BgHUt7jv83IFQ4i9VlgoPwF+lXhiY
 BoZGuJUqMRcBMxcB8V3E5BJvONEeePDw2+riw7DxsTaKvWf66Pj2+1S2QYhLqEax2a7n
 B9CTjkgfgG4whpTLc7foSL+XPQtSpXvyMKUeaPTuUdto8O/2/TPC0ubWun68FB4SPnv2
 phPzlBKmGrynH25XzMKjwNGBNARl2o9kfRJ6bsB6MPZ7tfiTaNRC5RioI1S/oXqUsLED
 KcJ4jI33m4jwzcrtDhSI1cnqbB+ZeKgD3eZLETOnfEhwz4aPXupLhYZ30lqAIQdaFgtU
 pa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711525788; x=1712130588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrGF31tzvXVgaalAMxJGyScTlNrN3QLj9ehfjtcu3Ow=;
 b=wac/oGaqY42XXGU3FBhSTiOhd0ymK/P9RBdrQmULubeoDfx5WTvzaYViNF8W4Ki2Vg
 KwrIK8XAEkQmp/PzvYuT7JXrFreW78/hJv/yuc4iB3aa3aEAOMSyrxnhwRNKLL/PK5ST
 adMgylvWLYHmaLwNIQF8Q6lPg9QWSV0EpSdAxk5cQDlCDqNJT1EPgfc6e+sLmejAdWM5
 qdBRAtX/TCjxPMPXFt5TWLmhXUwHF43r7HeI8xIbZdv6Yed5APnYtnoV9MgFLxjxyixs
 uNF88whOyRGYRWKthVTkMXj/uZiReItIvlXvDTmL4iR1y7W1qfymsN+R8naQ86ZNWQDH
 pRJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUomNe5A7esR9Fa62AS9MLQe07nzYpGkw4UT00S7Ya7ZG0JXGaHqhOvX6PWFlyG49mguj6CDc99w8YvJaQA62Et1fPaIdQ=
X-Gm-Message-State: AOJu0YwiWNFuwEDcq8brCFsAreQKPiiwVge+ASgBwC2mV7k+bO52TGMS
 79+QumjIW25/H+pcqH19XpKj1ohGkt6hKIAARiswUMrEJjEAp9siil6rcsJssRw=
X-Google-Smtp-Source: AGHT+IEagGLFq0C+XcV1WV9gLtKnTnNRsBHgZP53oIWzE7asbjZhNLHOm1KIBH5y0qAXTP3y8yQ7KQ==
X-Received: by 2002:a19:5e10:0:b0:512:bf99:7d80 with SMTP id
 s16-20020a195e10000000b00512bf997d80mr1112403lfb.1.1711525787895; 
 Wed, 27 Mar 2024 00:49:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b0041413aefeb9sm1270936wmo.48.2024.03.27.00.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 00:49:47 -0700 (PDT)
Message-ID: <57693478-ed3f-4372-a987-d3f0b7e79302@linaro.org>
Date: Wed, 27 Mar 2024 08:49:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2 4/4] meson: Enable -Wstatic-in-inline
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240326171009.26696-1-philmd@linaro.org>
 <20240326171009.26696-5-philmd@linaro.org>
 <1a51295a-f27d-455c-a615-3f53bde1d11a@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1a51295a-f27d-455c-a615-3f53bde1d11a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 26/3/24 18:28, Thomas Huth wrote:
> On 26/03/2024 18.10, Philippe Mathieu-Daudé wrote:
>> Compilers are clever enough to inline code when necessary.
>>
>> The only case we accept an inline function is static in
>> header (we use C, not C++).
>>
>> Add the -Wstatic-in-inline CPPFLAG to prevent public and
> 
> I think this is rather a compiler than a pre-processor flag, so 
> s/CPPFLAG/CFLAGS/ ?

Oops indeed you are right, thanks!

> 
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
>> inline function to be added in the code base.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20240313184954.42513-5-philmd@linaro.org>
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)


