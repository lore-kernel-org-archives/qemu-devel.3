Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C184C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1RhT-0005Nn-GY; Mon, 29 Apr 2024 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1RhP-0005Mw-Ls
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:09:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1RhM-0006vc-Nm
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:09:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34c1fff534fso3266011f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714399778; x=1715004578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mjLi53kyXIblqDDIL6qibUqb1NEe4x+MV7wh8A6phWk=;
 b=w4K9SwwUWleKaIOLVWDtIWi4XUsaPVJl0w5XlqXF0/0+4TFXY79PkbVZj6Y4pnhM7F
 5/wz10jSYiKGqUjfWtCM1M0yeiIqRutBGvvEtOs0OqBALvw2ceouNAcMmNIQLnJxVJO/
 tlwTYm8w/y/EgrSSp3EhwR/dFBwXiA2xEDq305M4RcOL+rDSPc+OQXiLr/rm2xB4Rvs9
 yZ7Q3SydNy5n/g8VfKlhVHKWzPdtnv/ukq3BL0eWXs2019DskA2+lntfxj1MHDX6F481
 S4it8QlhIA+Y9AkZjQAPj8NdEv6GqqXWk66gunGI45hfpS1wd6rYNZcEyF4yLBv5TU/F
 LKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714399778; x=1715004578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjLi53kyXIblqDDIL6qibUqb1NEe4x+MV7wh8A6phWk=;
 b=bKd+44NWRs0AFq04Ziq3KL0KRqXDObZIDQa9Sm/rIKteyvhwEUPPMUkiBwpwjf4xso
 0a2XX1CVm9p5W8kIjlnVXb3hJlZiAnk/tpXmqdVvP1WBJNua7EI0gJkRorUwx//Te1KB
 OOYjnIz4ow2XYqgsM2G6jY0l11PP3cMwtuasbm3DE05oOUrEpJ6ePOE4BdoMgFHOayfG
 t/GkjuOdPbBVv3l+sUVhJKpAtYBUQHg7AqXOkW8XezNaj1T1BGk1YdXcbxOsKAlghy8Y
 M3r6jlAnQXB76dQnmqhXUXH/61+v9+oTPvzR8GECBcm9p2c2i/NvvVXl+1+dgWgCHtTB
 dn4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaTvd4Mt3TiRSnrmEi96MmGQQlBrgfw43d2zwQ4/YfRLTfnfWZ5UeAZMsOYPxxCkwoRcoNVys3E/awpXAO70MniSZXUEc=
X-Gm-Message-State: AOJu0YzOv1UTYqj3DBkM2MVi2fK5B/o6ymSUALqQ0F26+zsQRvqpa3gV
 EL0AsWIdlu/LfQXJXjCKVRui/JOSSSx9O28OwRN6rRRmU+sEERGEW5yjus3RTMU=
X-Google-Smtp-Source: AGHT+IFNdB9eY8T/2mAGJBxHeqiCllTLXalyWSVwWLgwgU7cllW9/OrGwfWGfVOnn4kKXp4Zon0XTw==
X-Received: by 2002:a5d:4112:0:b0:347:d437:b7cf with SMTP id
 l18-20020a5d4112000000b00347d437b7cfmr6663409wrp.17.1714399778429; 
 Mon, 29 Apr 2024 07:09:38 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 z18-20020a5d6412000000b00347ec0469b2sm29485320wru.46.2024.04.29.07.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:09:38 -0700 (PDT)
Message-ID: <b422846a-edd1-4511-a5a2-4c2b028b06f0@linaro.org>
Date: Mon, 29 Apr 2024 16:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/alpha: Use cpu_env in preference to ALPHA_CPU
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424234436.995410-1-richard.henderson@linaro.org>
 <20240424234436.995410-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424234436.995410-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 25/4/24 01:44, Richard Henderson wrote:
> ALPHA_CPU has a dynamic object type assert, which is
> unnecessary considering that these are all class hooks.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/cpu.c    | 15 ++++++---------
>   target/alpha/helper.c |  8 ++++----
>   2 files changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


