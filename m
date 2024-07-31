Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4u5-00033L-Ku; Wed, 31 Jul 2024 04:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ4u3-0002sQ-Oj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:41:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ4u1-0003NY-KQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:41:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428085a3ad1so35478375e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722415304; x=1723020104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tIkKMf/lsfKXSfy2ROnXb+CtIMB7vF/5tKQapNQzYFQ=;
 b=L7UosmiH5SFXUlLdYPrFoUYvSo4e3U0e0DLnlBUTfttu2z0C4np5npywiMZi9HxHAg
 bVJPP7KNmJI+we5zCncVlfbe0DFRZ4otlNsZAjZP5q1g20uRWfLlGJDyEtEbRimtxxgS
 fTkrVfc5Cie45MagRxVx9l1en7rbJaw/vnjyZ0D/7M/7zrF61JrK6oXxsV2HViJJxmI0
 2ykiHCYBe37M0uzNjUC4vavdGNQnEvNHAlpGAF5SyQYzIgxVn8n4J6RuTitDeej+Ex4D
 vJvqTWxIP3/p5X+/38YtAjP+og77qu0MhTHIp+vwpujv0Rf9HEjtwvbohX03gbC8udAo
 oJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415304; x=1723020104;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tIkKMf/lsfKXSfy2ROnXb+CtIMB7vF/5tKQapNQzYFQ=;
 b=UUivykJGmqYA+rpF4P3dv1ZkfYsk2VsJpNuFxrBo1lIR4MEFB+58HBkiRvbt99pxV0
 qS1HT1XwGedFGETtkPJPBKGkTKho06PQ6e44VmoT7vYG0xAP8ITXg0e6JiBCrxAqtwI2
 /zdzW0Pt42dUTZK7Ve9h3lTq87HRHKqLwJpGCre8PuCetO2GycVxUnYQYHXrxn5PpJ3h
 XaAvhnnv2K+E0wUOiJJYkKqP/cPmjG3alcQA656tVK9NaZwpwRd21fvXBRFDNz8RBjoB
 YiIjxcl0kgaQhiWucU+WAIiLOhaqwPy12eXmOEKiWXmj+RP0b+4vnPldzd1rIIU1BOlA
 JTPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbgpENeQsy0r+vbfrv9zu3VUzGkYhejRDbEbELpWklVbjDDQFGEC+LLOrvkfDiMQv5VzMoqKEiMnTY2YmLUFeeqC2cok8=
X-Gm-Message-State: AOJu0Yw/uTpKA86PpR0gwn6KY/bMI0Q10C29pSADygzGtZi8wf8OpYhY
 j5yT5AFn9tFFfNFrslD4ZkxaKWwkQNiSkKKeGAC1AEGWsOd8ickE8DqsdVODSt8=
X-Google-Smtp-Source: AGHT+IG/HulTaPYhZhijhZWonTA09SSqLIUklNwjbpZmYvVHTQwMuZRI6MIvMW07ZEMCMCVjz8YaqQ==
X-Received: by 2002:a05:6000:1868:b0:36b:3384:40e5 with SMTP id
 ffacd0b85a97d-36b5cefdc3cmr8650909f8f.24.1722415303724; 
 Wed, 31 Jul 2024 01:41:43 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm16427369f8f.93.2024.07.31.01.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 01:41:43 -0700 (PDT)
Message-ID: <0b008f97-2a4c-4a28-b354-5f2ec614a840@linaro.org>
Date: Wed, 31 Jul 2024 10:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: switch to dc set_props() list
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, sidneym@quicinc.com, quic_mliebel@quicinc.com, 
 ltaylorsimpson@gmail.com
References: <20240731011254.1961048-1-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731011254.1961048-1-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 31/7/24 03:12, Brian Cain wrote:
> Define a hexagon_cpu_properties list to match the idiom used
> by other targets.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/cpu.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


