Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCB6C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7qH-0000oT-SN; Thu, 22 Feb 2024 07:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd7q9-0000mh-1Y
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:06:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd7q6-00034t-TK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:06:12 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso5089234f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708603567; x=1709208367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wh1n0IlApG9nfGWmUY0P2DXl/J+TkQv1FOPChcfQcDg=;
 b=fyomQt7Bpt0CAYrOHcLOprKFuh5pp930k7HLg3eh9MGLfqEMLooiK28KKqkoVifB+w
 iYPvvGDIzzAOAMnjvk+0mSnGMi62HOGzLtZWgAMriLo4XImlajF5Yssa5luL+c1JEI4p
 /xXHjhl29cCgwFKe7rpoKiltPvLE79DYe79ZitqgaRltuu8x/4LNxKOU1MqpkN9zYJHm
 e6/Fy7/m8E1jqwGzwQRRTYk3HYBnLPMNj9Er6lUrqX6k68AscYgSGbxHmgFtDTTbYyBP
 0q6rOnVbwhqUDC5hq8A+JcnqCOVdnZIHN1kriTi4m7xJMiSaXqSjbUqtwZaWQGuLx8q2
 0ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708603567; x=1709208367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wh1n0IlApG9nfGWmUY0P2DXl/J+TkQv1FOPChcfQcDg=;
 b=KQSrbO4Kh9vLxVubM5a2JOT2PK3kidwmGmTJ3/1tDuwU+xdj//eTpBTsjFrPNjtGDi
 QSy6t+WnEoEn2TA9Gy+UA8/w1k8UeCZgAMRnl/iT6H02xcgmyXQXmEEScY/8BJchtpzU
 DwLjwE5K5JwNUd1gfCJW6hG0z9ebyrAXpd6Sj6i3oCvze9U/Gpi/XBVxUOhQVB5z5c0m
 YX6xHe497Vulk8al+kyj1Gn6x10ZpUaxBdjngbvWggYycT45rzY2xEmIpHN3E40NlqFY
 BjwJ6Q3eawyQR3PiPuJWaVulPYVqARA9qblNpY4ocY702yUXErMECq2nf8ABLJrsTH19
 iFfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKr8/FSoIfHoS3WLGAz2bhtr6R/9shUzDL3164vBmaHPuhdrRtT33rkkboqDXewcv4Rim87vsEvCqv36PWzKZA4p6CGK0=
X-Gm-Message-State: AOJu0YzeZGgPGXJLFRGrILJDwzK8+HB6RY05T4QsWLt4KZn0kQRSHYL3
 DEQxAS6hScE//12Hb0doPPbufeyUtYjVSZi8K7bv6NNwBlpB//D8PLNnkrvl3kE=
X-Google-Smtp-Source: AGHT+IHb3egbgSAYiHL7X0ZLlFWdWAOxCUYepx0ieyFDrrDEkzyaAi37I2E42s7dJXeqP8s9RUkreg==
X-Received: by 2002:a5d:4688:0:b0:33d:86a4:d167 with SMTP id
 u8-20020a5d4688000000b0033d86a4d167mr2390625wrq.51.1708603567181; 
 Thu, 22 Feb 2024 04:06:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 b7-20020adfe647000000b0033b406bc689sm20354338wrn.75.2024.02.22.04.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 04:06:06 -0800 (PST)
Message-ID: <199e4f18-61d1-4fed-9e40-1ffdd3b5731f@linaro.org>
Date: Thu, 22 Feb 2024 13:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] target/ppc: Use env_cpu for cpu_abort in
 excp_helper
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1708601065.git.balaton@eik.bme.hu>
 <54466229ad8572ff0906c381712234ba0750e4fa.1708601065.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <54466229ad8572ff0906c381712234ba0750e4fa.1708601065.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/2/24 12:33, BALATON Zoltan wrote:
> Use the env_cpu function to get the CPUState for cpu_abort. These are
> only needed in case of fatal errors so this allows to avoid casting
> and storing CPUState in a local variable wnen not needed.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
>   1 file changed, 63 insertions(+), 55 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


