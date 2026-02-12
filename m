Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E36EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZXR-0000YQ-5R; Thu, 12 Feb 2026 11:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqZXN-0000RZ-AA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:27:30 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqZXH-0007cS-9e
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:27:24 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a929245b6aso50105ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913642; x=1771518442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o3UpvFRHqEmCvf7IEU7X5EEaHjSIdZF2Yv/42bZ0QGA=;
 b=VRSu5nzJOR9t75kDauQmvioCi5xbhayavxHu0tdZ0cSi/bNH7GmFQ/fmbSRu2Npekj
 x4O2wXwAsmsELmxrCptQTIkSBn2DmYuyByyFahSNK3qKPloUSCkvHS58HZVqsQQNFvaB
 1+na4mNXAkK5i8lHOpfi4UGnHugkuRp05aNCZbX6L25CPpenkit5ZdMamH0L2ni6CuVg
 vT1S3wYaf94Cdyb3Vsh2+D3bqEl7Grob0txIt7LJ+xAq8jBESeBDKkjzKaYVAtxKRqGK
 +5I1KGEJR64r/Q1CLv3D+lBRMuGEIMWZh1tnan/oA/fHQzOgu+kYvw4yTiQBlrdxgRbm
 6Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913642; x=1771518442;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3UpvFRHqEmCvf7IEU7X5EEaHjSIdZF2Yv/42bZ0QGA=;
 b=YCv6/YYdw3Ql1vCrFcJArsMwyjAUY1pzQW/GPwUO0NCahJFcdxc6QrHYukJLIUomix
 r4asfECpOxbnhsQzpGUhF5gCLO43m0tfeHCS2yU/Ypqazvpxez8x2GG/qzVjPB3y1y+t
 WR+twJUNkJVJsWJhdZFC6PTFNoN5vF9vS5i9WFSmA+hVZNAlUNC8oFPCLaFSZktxuJdL
 5ygR64ZdzWvpgprgpaPH6DPhK5RbqRXIE0+CcQfVSA68ougFgVXsWNu+MRXK1gbR0My1
 MadMm5b8FLd0bi/8N+zEUHgMiy+E0eViCWY6SHTMxdEKXsKSlCD4BAXbq9Y0lfHpP8fu
 oQ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxS1vVXX2lOVmTd6ZHqMAVKfaRHHvad7mV9hfJhZ9DO+rMr24Am41FgxkYzx8Lkfhjc99Q+TmmC1HR@nongnu.org
X-Gm-Message-State: AOJu0YwFtXin7cW05tamhoPVJep65zkX2RPIxTO1bYUCjuAvQd2L4t7e
 gN0x1vXbps4pWTADTS318MlGdkWlU/v1ViWVteScXBJhYMRmEYHDjWmdVGoL52hB/BE=
X-Gm-Gg: AZuq6aIBWMDeT0Wqr7Rk0vLPvGIZeHSaUE6FitLsMT5LL0B5O7HnsRSYCOWSzhoNHcs
 o6S1SmR67LFZodYvmQGxGTCHCv5X4IsCDHBi/L3P8NrLrWupiJQODtiP/8nGDfO4JCLqw8Imbq/
 783I95WJytHW03xXlkjbGGEc3dQ1NpDxu+mhuF0LYTg9KPDpiyl7Knq1khAYbnv3rn03Qcnepk8
 fCZDq/rsgSQXfGazpy+qyw8r8zjRGSsYUi0gyoZia0l5OkrV4G/CgbhoX39SYqVQzMU2lERap7a
 XCJpgUUq/E06s6qjo+GxeeyhlUAb/f637Z6fOZB7xE28fLINnffratY8sdNB8vcZ4h1gkE08afR
 eUc+Df3FSYwuodaFz641DNWB7bHVVzZVKJdanxYJrujdTdTsApN6mfAH3VU+l+jura2/MkUzqjU
 nxj33X///Eso/nXvFGjywnbds1dFmsgSvqVp8I0hCnPQSuN8Cp/9SMjY9NbZI2AEls0UOi
X-Received: by 2002:a17:902:fc8f:b0:2a0:e5cd:80a1 with SMTP id
 d9443c01a7336-2ab39c566fdmr31815705ad.41.1770913641671; 
 Thu, 12 Feb 2026 08:27:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e4236e1sm5911198b3a.28.2026.02.12.08.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:27:21 -0800 (PST)
Message-ID: <c29878f4-3b19-478d-8830-fd892faa8eba@linaro.org>
Date: Thu, 12 Feb 2026 08:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: s/most/most recent/ ``probe_target_compiler``
 call
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260114102522.4044591-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260114102522.4044591-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/14/26 2:25 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/build-system.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

This was merged into master (216264cb519a6b8d8dc6962110c0035192e90d3e).
Thank you for your contribution!

Regards,
Pierrick

