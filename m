Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E27FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCo37-0000BP-DH; Wed, 07 May 2025 19:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCo30-0000Ao-4v
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:19:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCo2x-0007rA-W0
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:19:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso5036875ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659964; x=1747264764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjGaa7vZKUp/sZ11x041WwgpRJmJrf2IZh9bZEY6P4U=;
 b=pu0U6hVxn94Rj5uOQo8pO6bMcrOESObZ/LnkinGXkbA+0591YqeIyih2OBP6+BRYIJ
 F3zF1m1CBZixCBolVRuXsttwj0fijTh0m5rvijXJG79YcMJudz4b767AHoPYzs7Feyfg
 LEW2U7vReX5poW9fb9GZpalR7TsAqnEskvJS0afFgHbXEdZ2kyCT0yCNHgebPd2HmRd0
 qgj06MFkwj2S4/KLc1Ieehcr6PRnGJkADeKN53do0vAv07YTbIs4EpQqVH08ZALybGee
 ibG/of1DsUJ8aSjBJPuDsraerYmcyulYanru4xpQb9J0zCN/+A37rcMaHNFp0mjZE5Dx
 0R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659964; x=1747264764;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjGaa7vZKUp/sZ11x041WwgpRJmJrf2IZh9bZEY6P4U=;
 b=AJd2M0q/u4kT/KzKrJO0IeYWdLIQxvriZP0Ho1YQqdN5R7VjJssw37Iy+2JODR4Bic
 t27bHn9ZtpmA3gaZwiKNdPJCWNg7ik6EixHeiBkVPCqCIUCLi1eQ7/XtP/zE2GUltI2n
 h1j/Az6ML2QByCUJCM/sS6R8+arV3JgGfDQB+AUsefNrwV2B0U6Y3jmm87vu1gH5byyl
 R7usS8R+zVqAVUafqeoSEKz6iTpqgJlZyPlYZstu1PlRdnmgUsDhvYVr0hV6W52qfSo4
 H/cPcp+cpCMH0sNPkvrL4SQodZ+fXs9nSc6kX3wRRTw4Eq3gV0SUlE3NNQ/GFDdSUPaW
 dhXg==
X-Gm-Message-State: AOJu0YxxlTtrBhxV9HODkxits/KqW9R7V0kyOORkOmMUBO1EHoVdeHWp
 1t08Q6Sc2Ve7l6LCEYcHxXqePJVmajCkXFX1KF83hKXXMTtiEGZyu1g4WARyJmaI4/qVTMFDsx2
 XeiIjoQ==
X-Gm-Gg: ASbGncvJRG0/4U2RkHJXIUDUvT7Vf73fHI8EMBFftZrSY7Ysq4nrIpGq6OCIcMPQ/BT
 fxLlms9J9vMUyBCMfNQyJ1T3OTrzpY3r8ecZscTjzBU2rjjYkgxeINEJeeFMkT628Ea7rC+SwX7
 RJbOdkWXaWeEMrwm+myVZ+ER9oyoIC6h939c/RTsmoE2ceXKDD7Fw/dwQ9xsOPAZsGfg2pG8cvl
 45I64oI5s3UDxZOanHjgTCq9fQJTBL2kYdraQIsjWXQZKc69n0N7EQwL24dcPLszzIZ0M/0Ovip
 EspIzSX/m/YnxYjfZmkAoadYP8N+y3zaJ66HkuAZSE2WD0oo51vpRA==
X-Google-Smtp-Source: AGHT+IFeQgDOvz/waYvqQx8c2exGkoDKwjcEv5FRbCqrSZFlTVRm4b13AZQoYSpGxyZgfnzQ/8Vw8g==
X-Received: by 2002:a17:903:2b07:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-22e853705a3mr18456755ad.0.1746659964600; 
 Wed, 07 May 2025 16:19:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e7985bc40sm12099755ad.174.2025.05.07.16.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 16:19:24 -0700 (PDT)
Message-ID: <5cda3006-282d-4637-aa34-d3d0762c656f@linaro.org>
Date: Wed, 7 May 2025 16:19:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

v1 was posted:
https://lore.kernel.org/qemu-devel/20250507231442.879619-1-pierrick.bouvier@linaro.org/

Regards,
Pierrick

