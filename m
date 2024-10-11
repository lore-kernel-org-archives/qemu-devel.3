Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BC6D1A427
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 22:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szOUl-0002sQ-KR; Fri, 11 Oct 2024 18:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szOUj-0002ru-Ok
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:52:25 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szOUh-0007ms-P2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:52:25 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb18f14242so23316201fa.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728687142; x=1729291942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnzofjFPSUL3WKzP+FhJgxzB0pSOdKYfbeozcKbG5Lo=;
 b=YxpkaRnWUyoeIcIWQCLss9tY1sTQ05HMhmyYwUOwt+w4mH0i8GKz5a2ncJk9IlS4bb
 9qaRWh6lGyV6YqX/FSa+ouxJJedBp1dm2Jty5uzMbVU+J+Vfmz4c4i4V1Y8DHsjIHVFe
 NRQ9OXHAxvEbTAoR+zmW4rk6CFqu5TFkU1QJh6BIWQl8PaNBZjoPsBzp6HhEMEMxET8k
 zcarITCYttVCqqQw5ZR5IPpmdTDkPE/Fjqf4ksjNAf8ssDQmAOuFj7sNbQXb/vXiAAhj
 7ZfpuA4mpwGXaP54aWwZT9OA0SGJzv0fI/4JekYXxc0DSXZVMNtcNySLsLzu7YetumHt
 xj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728687142; x=1729291942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnzofjFPSUL3WKzP+FhJgxzB0pSOdKYfbeozcKbG5Lo=;
 b=JHtL732FDfL1fcagnGUJAc0A1Kfl3IgTdzFnvEQ8ilT8/qJPPUO6lewQ5c2fp+B0CN
 bve4oD7/maCSKh+C16igr8KwGbwwn7jxZ6zNXkPrkOy2iFRz6GRu8u5hdatfpsCp+J+N
 YdEnSgECbi4pntxaCXfzCA59Z0eCsB6XjbwI1YhKYUzWiWYDKKNLiSP0pdDUJUqxpEiF
 JH7RlhzuTGnpgDK+vXladX76qkNFidnVQhBgXqRKs9g9GwZOdE16iZXJT9R8DFNgdIIv
 RMWyPdAVN91Mh8FTPEqrPVaRC1vGJM9AVeQO67D16JniFtNj06lSOrsN3mgHFZuHj7px
 gCww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhRi9oCUnHJe7eFnb5uY+9qRm2eTy0yWp8jYL5AUOPIo8Cdfb4ojAbXUqz0jNoQqQt8J0gqcez2ZZR@nongnu.org
X-Gm-Message-State: AOJu0YxobgRQtso7Y/7vbQsd3eHOz82SUPYOsTsIqQGa7IXAS9KVE+09
 OeYz7zb4OodxASDKDJ3+bdwqeIAKeWun0u4EhewVoLudsLoh+MiR8+uktfFWMXs=
X-Google-Smtp-Source: AGHT+IGTg0S8j4FYojJFYVkX5vKBH9mqqx6AA/Eut0cgMrCG9vgLKGX6aYYOwZlWNCB4NeoGTdzDkA==
X-Received: by 2002:a05:651c:556:b0:2f3:f441:af24 with SMTP id
 38308e7fff4ca-2fb32779b16mr18140581fa.26.1728687141791; 
 Fri, 11 Oct 2024 15:52:21 -0700 (PDT)
Received: from [192.168.222.92] ([91.209.212.130])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fb245b19f0sm6058001fa.71.2024.10.11.15.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 15:52:20 -0700 (PDT)
Message-ID: <ee2dcb64-1a4c-4b13-b0d9-83e1a58dbbcb@linaro.org>
Date: Fri, 11 Oct 2024 19:52:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] Revert "hw/sh4/r2d: Realize IDE controller before
 accessing it"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org
References: <20241011131937.377223-1-thuth@redhat.com>
 <20241011131937.377223-17-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241011131937.377223-17-thuth@redhat.com>
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

On 11/10/24 10:19, Thomas Huth wrote:
> This reverts commit 3c5f86a22686ef475a8259c0d8ee714f61c770c9.
> 
> Changing the order here caused a regression with the "tuxrun"
> kernels (from https://storage.tuxboot.com/20230331/) - ATA commands
> fail with a "ata1: lost interrupt (Status 0x58)" message.
> Apparently we need to wire the interrupt here first before
> realizing the device, so revert the change to the original
> behavior.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/sh4/r2d.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>



