Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC6BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGF3-0005Nd-Ma; Tue, 23 Apr 2024 09:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGF1-0005K6-9S
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:31:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGEz-0004PC-Kz
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:31:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41aa15ae26dso9249455e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879080; x=1714483880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uMF+kvMQ6p+3afTcRStYxFhacPt6oFWx7cRYjJ3GT+s=;
 b=yAxZkmHMzD0AuJzaoX8BtKBgNqLPVlZy4VvDm4FhxQsFZzH9H4UUlLeJEfGgu1LHZV
 ICfiQG4u6cJatMh2IuIp42yKS2/VlAhPKR1FnqRgCbdK83xA8ABbYtGDZP2rono/uKzZ
 pqYp0Efr1/pGU76mCigNX3pm8KyjqGp5UJoKfRoHsb49ESfPmQNggnZy5dNgVH4oA1lM
 DZwCZ02n+5+r3Jglm6IP6SKVFcpYLALnKYtuXNCTAs/IPd3dShj9/CVcF0aQpV255LGf
 jQ12RlEZbofj8wveQjqgd1tg/f95C5gDLm3WrNYCvM3av4K27dwtw07KvYl+Nwb07Ani
 n5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879080; x=1714483880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uMF+kvMQ6p+3afTcRStYxFhacPt6oFWx7cRYjJ3GT+s=;
 b=sLiMa1DTlYg5gfYQcCC5Q1b2RXccRPl0D31m0dpLulYqe8uc0awZiO0NdQ3Upkfshf
 OpvAagtWu4xytK/QXwWHQsuQnbuZwbK2s3SKTdn063ysLX6wK2NolicQE5R2OsCIexU7
 6+B6ydJqEnU4j0Mo+dpvej9Ejqs/PdsfA45KgBoqZf6pcNDgKqqRVGoW6CHsoMsEqdF9
 TB5THsRvERs0fm2uwZ27mg34IM63RwOz/LBH25+Oso3t3VQ0Rg0ZLX6EoYsOwRiRW5rS
 dcrKlfcXbS/OhMvil5J3elIj7Ul8lbpArLdLRfGwHEpGsLAT54H4e98LHyR1JLWYJVXq
 ggMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2+tuCxGnBQi8RBYfCK1PxXzJIV8BdHiI8B5O1o+JUfBkoQ5zw1uWktokV+7Mcdo6o6zYZXZsvVLX9bFiNqmIS+A8QQSY=
X-Gm-Message-State: AOJu0YwoaU3qRVy0kh+DvG6Q05COxZu4qQ6tIac8yM1YcxKRTGxbQwEM
 rFQQhaVkxxzOuxt4QpLMrl2Ep8rYFeK+a2WE6DIouUNxEPO9VQK2lJhK5k4JIv8=
X-Google-Smtp-Source: AGHT+IHOeVaQx7PTubP1eagW3uJ/VZeGuL34fPAt2TQzuoMOIZgR5WVzwL7ocvXNQpvdGTUI3Es8bw==
X-Received: by 2002:a05:600c:5020:b0:41a:66ef:e543 with SMTP id
 n32-20020a05600c502000b0041a66efe543mr3206838wmr.19.1713879079978; 
 Tue, 23 Apr 2024 06:31:19 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a1c4b09000000b00418176845ddsm1037946wma.0.2024.04.23.06.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:31:19 -0700 (PDT)
Message-ID: <ac3ca3f9-84d7-4be6-a05d-0ec86e3bd3b5@linaro.org>
Date: Tue, 23 Apr 2024 15:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] sh4: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-20-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/4/24 15:16, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with SH.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/sh4-softmmu/default.mak | 7 +++----
>   hw/sh4/Kconfig                          | 4 ++++
>   2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


