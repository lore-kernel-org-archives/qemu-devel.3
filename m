Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F1BD6B6C0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 18:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Do7-0007Ii-UC; Wed, 30 Oct 2024 14:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Do6-0007IR-In
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:52:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Do5-00052p-5N
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:52:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso17252166b.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730314355; x=1730919155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jb5pTcZcxb6tN9DenFJaeS/1PURpitaqFPCnu9lbrEc=;
 b=sXpwCY9ncCeURyhPY7PQcPXlB0ZrO3PRVTGcv7t1X9ZpytlOGBSiFNpf8SdNYE9Y9w
 OT1j73MFZGF1omkW9odGAueo0kwxHr7LYm/FuZArFRRpaqus9jdqEls/u7OjacakdPHC
 rLftAE194kJAViOvt3yXgmlkZiZDD5X+vk7rC71l4bQWA1h9OKZSghc37w+cqLGq3Wj+
 T6E2sWQuQXzzAJLFPodkXkNT+vhY8kyvhTqR2KDjpJH6AYDcdvN1kOoqfScUe1o49O6h
 dAD3torNFVpZFzccBtu7VoDtUJ5tDM7hP3UPgRk+Yf1yOb5gEYwzGHdQJ+tWJVYChBZM
 LDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730314355; x=1730919155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jb5pTcZcxb6tN9DenFJaeS/1PURpitaqFPCnu9lbrEc=;
 b=iyG4ektteEuqX1v9CgxB/gcYpJahPEoAEkb4Ax7YHEqtXCeEpelmj+95S9QoeYSTzp
 G6a20lOZSPnNqnI4Xmj/Ey5uiTDqxpKAtGRER6+BMg+cIZpAliPUEOvESC3YuLW0d/8u
 Q1Nj1afRG6qK0oJOEAPIEqE0mY4i24Pi8p5nS1Gx6FV2tTSZdWoIRN6vTu9y/LFG/2OL
 Wiu6H49qS4xOuKFKFoSQwvGSpcSWgE7ZhnxxW9BRWfyOkXz9Y6Uao3/cMeVpm3jqfe4b
 mB4HYRJVoXizIIn0ElJw4A0qsjDCACrlUFhvo00tS9yUgVoEB583pyQtnZ0wmE3CASEf
 AfAg==
X-Gm-Message-State: AOJu0Ywo62J7C/f5vpF4HHU2HDbPSi3d2/uT528+44Aw08OTtOJPrrWt
 +eJWoVVUVrA67OoO/utBYS3u4J8CViXR1gkCZz/d2vH48rkctQkNXVCMIisXe/s=
X-Google-Smtp-Source: AGHT+IHVoceKDfQQmSJ/XoHlY9gmgmHhv+iO8MzJqqrtF3yBFm9DykWUVleyx/LQBe8TO72onHKXYg==
X-Received: by 2002:a17:906:c105:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-a9de615ad79mr1641841866b.52.1730314334305; 
 Wed, 30 Oct 2024 11:52:14 -0700 (PDT)
Received: from [192.168.243.226] ([91.209.212.192])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d70064sm592633666b.161.2024.10.30.11.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 11:52:13 -0700 (PDT)
Message-ID: <76857da2-1615-4410-9f1e-d026b7a2a4a4@linaro.org>
Date: Wed, 30 Oct 2024 15:52:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net: Changing log error to trace message
To: Roque Arcudia Hernandez <roqueh@google.com>, kfting@nuvoton.com,
 wuhaotsh@google.com, jasowang@redhat.com, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>
References: <20241014184847.1594056-1-roqueh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241014184847.1594056-1-roqueh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 14/10/24 15:48, Roque Arcudia Hernandez wrote:
> From: Nabih Estefan <nabihestefan@google.com>
> 
> Converting error to trace message to avoid spamming of message when
> there is nothing to transmit.
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>   hw/net/npcm_gmac.c  | 5 ++---
>   hw/net/trace-events | 1 +
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


