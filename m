Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93EFC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Tkv-00042F-Ul; Fri, 10 May 2024 13:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tkr-00040h-Rf
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:09:59 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tkp-00004u-SC
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:09:57 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so35144941fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715360992; x=1715965792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxAIoiEp1JBYBCf24ZpeRww9dtSxxeBEZ0fmE5A8qTs=;
 b=XhjruGylWDd+U0yds57Q9hoaqbnBAAs/qzF8iwGSha5DlK07dH4pGt1dJZj8ECDU+a
 pvnTeZeICGPpddbBBqMhc61PlijJ2K/QoddVWvXLWrKMdc5i6+vreSevyatoJ7wKYmaI
 KUHOCoFtinzOWd6ux0n9YkOQEjAEjYZNApB6JtLgCBmzbZlFrjrBaFa3QUSJcSX0tA/m
 sgcNN2Yz5rRkf5LImT6ryfxApDUeehPZuFxbRenihKtSNQX6Gwra7k0LiK9V1xz7+DBq
 LsOnBqILspiUGusDmLI32qvoESMxwjaNaC/0jQf3aC0NDJCjYP/Hr3IMjFSkfcCe0en2
 LXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715360992; x=1715965792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxAIoiEp1JBYBCf24ZpeRww9dtSxxeBEZ0fmE5A8qTs=;
 b=l18fdz1h05FjoqHMEnn1SjqEb2z9qMpzg3xTIl8VGdnyb1yZtOfPs0igXV3aExZ+PL
 Q7rdLxCQbOIqIteBDlXHzHj/uHXtyldaC+H9//iCyQjcEAcAvpY+ORFgBRZwGVJzpMNc
 vOQlTC9dW1CfwD5iF1YY7UeMCqM/H/y25NXcOiwUMh4L04dP6JnStwA7hRK44lUhpNhp
 Y6c08rySu16i5WsFmblHpYLJ+NAsj/7iwJQWA6ULaTLkSameh3AkvHp43CyeLWJFZITG
 zm3n+Z0vXt8s/NBYy5zzzvtDaN2XOo81v/RK2B4tHg3b7B1e0t0MXKkTTsrv0s6Td7GV
 zWSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzXpIL6kuPepfrcVIM1BXYaYtriJtcU6ebqWxzr5CTtKBpXjML93TSBj41ZVUqSHj16Ksh7m+krpTKJ8qI8s8VRs3wJsw=
X-Gm-Message-State: AOJu0YzELbhp69eKQ3g7JBZsCyLxwf6GNA2BoM4D9+/e6N6SubDLPwGh
 4zInebAP/ehcKCHf3CNHSuZ1RPa5/LUfcuVYBxLSLLo3vDZZjWb2xCiTWnsd9pM=
X-Google-Smtp-Source: AGHT+IEXNnthsCqHIA48ZsYI2jQW/IkLWWUsqbTWxIVRgYPEFXkgMny9ZQw6MvAZwa1hMY9bqrwXpw==
X-Received: by 2002:a2e:984b:0:b0:2e0:3ad2:b371 with SMTP id
 38308e7fff4ca-2e51fe5875dmr25902231fa.25.1715360992054; 
 Fri, 10 May 2024 10:09:52 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cd9csm201051366b.37.2024.05.10.10.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:09:51 -0700 (PDT)
Message-ID: <fab78cf8-9717-4111-aaa0-6cf33f53012c@linaro.org>
Date: Fri, 10 May 2024 19:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/41] target/sparc: Implement IMA extension
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-33-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c           |  1 +
>   target/sparc/cpu.c             |  3 +++
>   target/sparc/translate.c       | 24 ++++++++++++++++++++++++
>   target/sparc/cpu-feature.h.inc |  1 +
>   target/sparc/insns.decode      |  3 +++
>   5 files changed, 32 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


