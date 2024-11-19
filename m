Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD55D591A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRj6-0003U0-OL; Tue, 19 Nov 2024 12:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDRj4-0003SY-SH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:09:18 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDRj3-0000cQ-8x
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:09:18 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so962048666b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732036155; x=1732640955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p19r39ektixfFALqTjGI1mHhoTWX/SA7jrPAMjGfnfM=;
 b=iYPy8xKmgdVlooS73LdqXQcnlAbfpnilqiWkmWoaJjEIOdMQW+CsPXwlYUTZ2DIvqi
 bfiiZlm15e/Wm/FsrI9xuUwEwdD59jePVsOZQu1EchpVJ8r8OBA1JH2KjVc6xNyvO3Or
 3jHmm4fELGm5ecy7FHpNwzt9Ap6a7gNa45qAEf/06ZuOXlxny925kgkQxsQj5RRd4LBD
 3peQ0DzsIbmxIxMdEyb0rnCRCZWbw63tKH53M+HKAnq2l7TsUJBeu+aBt9es/Lx1RZuV
 W02ng62EathBa8y4y/LNf019nlFphPrIQmj3UdSMr1zGu01dl8ucrkkaEhsVSjOhDQ+d
 LeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036155; x=1732640955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p19r39ektixfFALqTjGI1mHhoTWX/SA7jrPAMjGfnfM=;
 b=haUH9yn36FuA7GB/sNnIIrpkBizVymOpYc2KdHEdcBc2oIoRnPFhuMTOMcWFXYMmOA
 KRDQos/EIzmdGucBvup4VLFn8Pl9nBm+ODh04hY6kAbN5qvqBlXHExzb2JxfxKDHZjiS
 WQPL/QH9jOhfDFqSxGSItpt7Da/Wg/1ms4P8TL8Y5PaUGAOuHEDWAW7npoAkkrBHjsYk
 n0wo5o52xCVNRPE1baXE6Rr5/wd+MwukhZLvu2X81+jb2UyCAa8/qbU6DLUwSt9pU+uS
 sXCDJ9tcUJFEyK+AHLYo6/ABQe8O1HDu/Pc8pbWCHzn19QYmfdm1KZ8cTkPMIJAM2OqF
 KwIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2stmPAbmTw7YYTHs13hPCC2jrbS+U01KXF3KWTSNh9thKN4eFXS+mdgSeoNs7GG02TTvLE7fuy6AN@nongnu.org
X-Gm-Message-State: AOJu0Yw7HmmRwpP2JjOe9vZtKBbBh/7vh/Hf6Gda0FvHaMeDPo62ukTs
 6dDproHgo07BnywsoaMFU1WbgO8V9PX5iK23sg2wDT1p7oRGvBJgBcPRqx/px5E=
X-Google-Smtp-Source: AGHT+IGoVunaSshlDkTL/NxwIjKU09OjYIoH+0L6TGHHvxhpp5i8kCguxxGF48b4dLftTOl82u+//Q==
X-Received: by 2002:a17:907:9303:b0:a9e:d417:c725 with SMTP id
 a640c23a62f3a-aa4833e8fe9mr1770624066b.3.1732036155255; 
 Tue, 19 Nov 2024 09:09:15 -0800 (PST)
Received: from [192.168.69.197] (sto95-h01-176-184-18-155.dsl.sta.abo.bbox.fr.
 [176.184.18.155]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dfffcf6sm676794966b.108.2024.11.19.09.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 09:09:14 -0800 (PST)
Message-ID: <17eba843-bee9-4555-b56c-b4e6baf2073e@linaro.org>
Date: Tue, 19 Nov 2024 18:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] tests/functional: remove "AVOCADO" from env
 variable name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241119150519.1123365-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 19/11/24 16:05, Daniel P. Berrangé wrote:
> This env variable is a debugging flag to save screendumps in the
> mips64el malta tests.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_mips64el_malta.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



