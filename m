Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D3CCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gwU-0003VQ-5Z; Tue, 30 Sep 2025 16:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gwQ-0003Sk-PU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:27:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gwB-0007Yt-5f
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:27:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-269af38418aso81252815ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759264015; x=1759868815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CzcgTbKqfj4HVP2VEs9dgXhcpRVMq2BVT0k7xh73Tk4=;
 b=R0KIN2eh9QPzs72NRbANy/n48+eVQnsHPth9QNMwAhL/4Idb07nJkP+IdVJNsqkVLF
 7IhF1fDxcioyyLTJ/o1Uiw2tmWihhIzKmdsBCqvTv3FDRHo/FdkC+3Z1Aa60QyedT455
 YFAcU8DqyUnz2e6QhdA1gTRhmIYKuAV8Ebgxtxm3PuSqnrIxWOGM5ucoABkin2ShFuXT
 bVmUuH+3e+d6tkyOGRehbO7cZaZE5B/FtRXcIsLQ7XmcQXlWUy8j/KZcO4gHdSwEJ6lf
 V0Rs9wNvIf8bJysQEN3bUzlLv7A2bRWZ+p1OoDEvS+cCDnCAW0vkAzDMDQIcFOy5uSBa
 4LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759264015; x=1759868815;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CzcgTbKqfj4HVP2VEs9dgXhcpRVMq2BVT0k7xh73Tk4=;
 b=pxZ+Ozi7OlsLVTBTw8jC+ylIHf8aPq273FdOuVx63LaprjrBrUO+t+Xw8u4QaqPgsU
 fKkamP5zyD+XaKJ5PNthjXrKQ/5z99mkXkZACKoV/j1RO4dGLbXPOuKKqoYkEBMf321d
 OvDbVgWbrty5ARznHn5IxoXL7JmN51EqcCmiBLAku9S0YSw9W4A4QeXIfjGW5Mzsmwll
 CS3w1Uq9g6r5Skg57jSbWRgsxmuC01XgXBguZE9nZ1H8vbtYahlHSC9NjU0gFo2yUtv4
 NryfqWInEIlAOrXxy1/nW3svel73CAkSAKsqxVRcY8uKrQ7Qao4vkn+0SEUYOmrNtk4Q
 clZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU18dhwdgf/ySx+jhL/moZNXzrTXVfXkydpd73YsVgCmYBKPx2HtYPnGhIQlE2X4U7qsBhwTp2njwfX@nongnu.org
X-Gm-Message-State: AOJu0YyTuzijNT4rY7yRIOKoEEod32iF5QaTtAOo/SNpoejd4bOReGrJ
 799o13CP7ZMtHXEzcgXFjE+VX6rEH4o5JdTwWUzM1y4GD7gZrWbGNCD45blWjww0jPI=
X-Gm-Gg: ASbGncsz3d8xH7vf/Ul3h3N16WxTjVJJFojOERgTdgA6REH7qGSt2MSw+C4aggVYyOA
 omeWrXLhGvEvv7XjaeNENuxmsv3cVqcVxuTB46/odal61tR3ybijCqU6N2WLPDxBtnzvzNdNq7i
 GoVgs3KAUFS0kbo0bVQzcHt8o/3rBksGkt+AB+pSsCpLlLwAUmrNJdoQMQyYROFYGrKxmo6/Olv
 gA30/W24PgEd+rfPIjckhMH5VWRV7IEZfJn/8UTb34E0MsGNHTnxD+zglbeC29S2HHsEIlFAP+4
 esHKdeLFDYnoNMC3o1zsNXsvtSVGVF82s0iFYyLQfOZY3bisJNjv3YAb88ME3LrDJzSsIZWMgTw
 SysvlrkmhqxFEZuYj7UVn5xG3w7EdU5krY/Dlv5lTCiq/Zus7WAIeuasfCd3l
X-Google-Smtp-Source: AGHT+IHUlFEjiJpT8nOPOkVWAo4rj6YK954ZBcVKWu8zBLHHrgCzOBAmW43DCJiDlncdgwnltE59Pg==
X-Received: by 2002:a17:903:2390:b0:25c:d4b6:f119 with SMTP id
 d9443c01a7336-28e7f167a3dmr11227825ad.12.1759264014796; 
 Tue, 30 Sep 2025 13:26:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e811213a6sm962005ad.90.2025.09.30.13.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:26:54 -0700 (PDT)
Message-ID: <4a2551bf-b1b3-43a6-9a0a-fc05814ac537@linaro.org>
Date: Tue, 30 Sep 2025 13:26:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/18] hw/xen/hvm: Inline cpu_physical_memory_rw() in
 rw_phys_req_item()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_rw() is legacy, replace by address_space_rw().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xen/xen-hvm-common.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


