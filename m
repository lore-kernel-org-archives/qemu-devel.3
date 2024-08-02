Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B14EC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZv0e-000129-4K; Fri, 02 Aug 2024 12:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZv0Z-0000yd-43
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:19:59 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZv0X-0004Rp-79
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:19:58 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef32fea28dso96506651fa.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722615595; x=1723220395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y9aLKGxvaZywZ14KRKqEPHmp4A6G/s99Ktew/Gy6f0c=;
 b=X9bZPJi5jLatF2/TdJH43uwgGZ60Ap071zLRBaxSaxM/QYSnajnWNBAAVsZN+FQTMS
 wKFRlN5amprfFwMrz91V8aJ6PrwzvhUhRtLWPv76QuBLXnv35G8+r4Wo++lweM4zvS9w
 nBpbT+Z2YQQ3rz+TSygQ7GGMWAWAY79MKAdQxkPZgZKJwd2WWEwLjM6FZIhAXVKKc7yp
 gHuB8G6pce/AQkoFcBVK59zwfUyWR7W8NLDjehTNFq8LhZmgIAdehvx4hmFQ8XGTOJzf
 2T/kKOH7LxEBx/MZfCnfwHPB25VnyGeFhmM2SyH9UTF/sTtJmnZebv3m1bSmXIvgZx9V
 x/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722615595; x=1723220395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9aLKGxvaZywZ14KRKqEPHmp4A6G/s99Ktew/Gy6f0c=;
 b=mCTPhku+igO3nkaohs9zsnwUT0zux3TsJKWDbARTHbezl4rPMp3kSbAWB5h/A+m8TG
 TG7OOnh3Dv9BGqGk5FGfNwd+iF8wyP2NPR3fpv0anUfb1mpru2kaOmJwyT4d5NXtnHNd
 ypSILKNFzG+YzjDisqz+hVAjDbhnxDvD0uixGrfIkunO9vZx+wFywFFuK683gaGS56H3
 +GjVLvJBPKzdglYlT0UkYE+lQUmbafT4j6RuB52UW0CJkuekH4APTMLQGFXQqpkdR1OX
 NUXI7fPTkgp+XYZRr8QNyXF4oqjMgf+R3Rez+5IKucUmsJ+hSSdPwyfFol9Sc+rbLoFN
 /49w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+jHzvlMtWsRV4VNYvxETKb0j7AAOjbJznxz4gsYa5bB8zo3ZwALWuEaAjeVvlF9BqRUmFNNPp4lR5EJzDPUCbqNMDLsQ=
X-Gm-Message-State: AOJu0YzlCLSRi1Sktgm0TcMCgISS1PGKjipL5wu0sgoH1dVaxOrdnd2S
 4tCW/fnMIlWX4pJd1yYftUbYRifVWdgsbkQxXP+ifGekcve4v987S49xP2gZWLkiDmzJ7BlotTn
 i
X-Google-Smtp-Source: AGHT+IGcT/RCeByx5XxRybF/Aq+zp9uVRj6WJVpgxitSMUxI/xCYgVP6WVqf5jyUKqol3molZWLlbA==
X-Received: by 2002:a2e:240b:0:b0:2ec:3d74:88ca with SMTP id
 38308e7fff4ca-2f15aaaa85fmr27760421fa.25.1722615594799; 
 Fri, 02 Aug 2024 09:19:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8addd6sm98811745e9.20.2024.08.02.09.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:19:54 -0700 (PDT)
Message-ID: <e5fe2361-fb78-47b0-8d13-b5a323ddc973@linaro.org>
Date: Fri, 2 Aug 2024 18:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/24] tests/functional: Convert the ppc_amiga avocado
 test into a standalone test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-20-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-20-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Use the Python standard zipfile module instead of avocado.utils for
> extracting the ZIP file that we download here, and use the standard
> subprocess module for running the "tail" command.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/ppc_amiga.py         | 38 ---------------------------
>   tests/functional/meson.build       |  1 +
>   tests/functional/test_ppc_amiga.py | 42 ++++++++++++++++++++++++++++++
>   3 files changed, 43 insertions(+), 38 deletions(-)
>   delete mode 100644 tests/avocado/ppc_amiga.py
>   create mode 100755 tests/functional/test_ppc_amiga.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


