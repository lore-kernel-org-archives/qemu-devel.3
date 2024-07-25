Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAC6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsYW-0004xj-PF; Thu, 25 Jul 2024 03:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsYP-0004eK-B4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:06:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsYM-0004zB-3o
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:06:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-368380828d6so392025f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721891176; x=1722495976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aw2QBVGemuhzqF4Oth8Tt/jtSySFymLnqdwPxDq00ds=;
 b=DiGCnZrHv/I7f7xxoXqr7MBbJvkE7ybFeMP5uQfv1sYKiCVJ7k5r9UNcSDraH/DiaT
 UDuyhQvkuJHx3/T4Sy4sTRKXG2ceL4la0JpGwyVX83KvG5TfWpwa/ZY16kj1UukKWnmF
 agoto+xuGAU+hvyOffz6fSB3RmRYiuy50pbTrIlNecuLr2L1/xc0hgJ40ERt0LvPLNEn
 2cRJ6QBwUtGpMtSB0qPToRU73m1rQcPJSWaLQNlYTXt+1tb2CwGCyxWkMHt8ICqefRa8
 iTmfob+asqzqzdiHy3fITh53yBigA0yevGo2U8MkqDHa1zhpgBWla8x+3BCX9nihuLo0
 QYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891176; x=1722495976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aw2QBVGemuhzqF4Oth8Tt/jtSySFymLnqdwPxDq00ds=;
 b=VrKac59xvXS+gWWmcqhyaULdPgiqLliRPA4AHXIVtY+FHHngl1rnvPxVC1oKo4ivI/
 GmalmzMh+wufum3CSopAz5lbuXftp8ABKRafKiHKR+sExiNYqo+jE4H/RuWx8U2bNPOx
 lasJmPjfpYXoUj55UHSkQNbmOH2jag9TlscGt6K8O7g7Tm+9Jru5ZuRstacnkwlRV9d2
 PpM9aTG8yB9MlHF2Lt1algUWqIBcrekBVTuZ1q7W3rK0U6z3MLodZOKWHimRaTMPBMwj
 l/+95PCih7g5TGo2D6IsHGb+oUqwOqhIpLL5HLLHynZ7+Jw3SuBvX8l1AFUkVkkW4AXv
 ZNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2lehBLlfFUT7uPuGwRqbzMSqnBetwI5BUkBmzHnteygMPGfVb67jaBcGN4viaO702e0QdbqIBIphuPit03ULiTHcSeNk=
X-Gm-Message-State: AOJu0Ywx34qToJNjOR3vctQgVepPBG39Nt8gSuh6usbZ3O17zrjp88KZ
 cfYyww9yPt/QS4SVE82ur3xCcYV6206XKPwMXgFieTXUffj6uOQKgCjsr1duBe/1X5iOkBJNg1F
 r
X-Google-Smtp-Source: AGHT+IG5yeTQ8iGVeAIQTzJZDyvvmB8nG0QdrjaqAHhyHD9N1+dppNOAI1o1KUUumyZ6xuu9RKEcjg==
X-Received: by 2002:a5d:4844:0:b0:368:584c:3341 with SMTP id
 ffacd0b85a97d-36b364465e9mr665773f8f.35.1721891176081; 
 Thu, 25 Jul 2024 00:06:16 -0700 (PDT)
Received: from [192.168.114.175] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057a6c81sm19529105e9.34.2024.07.25.00.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:06:15 -0700 (PDT)
Message-ID: <74b1b095-1958-4887-855c-7bad6c0415f9@linaro.org>
Date: Thu, 25 Jul 2024 09:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] gitlab: expose installed package info in build logs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240724095505.33544-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724095505.33544-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 24/7/24 11:55, Daniel P. Berrangé wrote:

> Daniel P. Berrangé (2):
>    gitlab: record installed packages in /packages.txt in containers
>    gitlab: display /packages.txt in build jobs

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



