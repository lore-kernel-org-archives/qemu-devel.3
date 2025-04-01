Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4F3C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 10:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzZKl-0006Pj-5V; Tue, 01 Apr 2025 06:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZKX-0006IU-6T
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:58:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZKU-0008JH-H2
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:58:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso47006035e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743505128; x=1744109928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7kxli4tgFHp0Cs3y1KNEmWTsT52dCDoUETSH4GjUe8=;
 b=Fk/oRtloplncDfPSctyyrXKXWcI1swwE1+HpoNFkUWUeOYF3mNLP2KHYvQ4RbgvfZC
 u1Bkntg8WarjQTfIwoLShjujWINqgDBxzqj8RJ7X+O61+CSDPS7iTCruFXD3KvJNDYSl
 em3Sx/fb8c9MqWiSe8ZfgidpvhXYTHBIKyyF/Fq7UiVLe/i+/4Y5iH3WHUAGXpcJ3ndf
 R2PLkIKec7G8qFhLr2yJBa3xCve8wh+Eop1xaJH+EEDOuvAo+5JgLA3cuJP4AuQaCeHI
 B1eob/97JQ7GwK+oYdNwRunpSU/ru/uCfwSD8MUp1f2g97T0lIRD7mN+jRKM7BwynXnZ
 vjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743505128; x=1744109928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B7kxli4tgFHp0Cs3y1KNEmWTsT52dCDoUETSH4GjUe8=;
 b=Emt4EtPeHc/dZDmAFjPKEy04aXkmCpdIfa8Muhydf3MWss00YTCuPVg9hRXE7i5ROR
 m1dCEF+da3/3CnIizYooYZFWUA+DYZ3owFDMq+JjwlI+AW4iSuXQ7UxNtS48p/WI02Js
 B1ftNPXTPW3aXhGhyRITfRim0vZkr1FgFVtENJvX2T0YXoWAP71kmYJAxUsnRv8ep7SZ
 GeAYumlq45/sm4n6OJPt0uFqAoglNDia7U6uU0W5cYMM9RqW5SFsyQYwLPdi9FUmcVbq
 7oE3suwIFDnOGeb2GcsuqFer4tMft3Pt22V/TLH9zhLJQYdzTBc9r8lT12W9Ik7Di/ok
 sa7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCieeQV/Mw8rcO5cZMagPGHAjqgCmcfR8EUHyO8QuGkSmp/Ckx+XACZVumm/7HIt630JHeNfCZKXbe@nongnu.org
X-Gm-Message-State: AOJu0Yx8ikGWHYVaBhweHQXzKsM8l9D6I1+QfPRUiU50c7rAlokowlsY
 ocRExhYYVtt1JQWu0lwga6x6es2rF7ZI+cBADGLDwnCFTCGafZeR1Ji71Fs5Z64=
X-Gm-Gg: ASbGncsn/wqztD8h+kEZ9ycDg6qDRMNucqYvvQrJdMmXROn87qV9zWbXrxQe12QspI1
 hhsiE1ux8G2ptfzePhsPYcw3bYNt2WNDOZ8YZSj2D/sxuRFpUIFUag5GmEfTCEhyZWMYxRqo5n2
 oA0s5fLIDmd9HtBuW8i1iIU/j+Fuq3HJEbjxzyuXzmIveFgSAXgxTyrdhrbc/fRcv6Lz9xnpsZw
 noRRd2Eta494BSrvyQy9KVl+EdNvB2qugpTRK+ulFmEUCDQ1Z+jmMIKQluEZ63blOEnRyekIfzu
 xP19XwaeBFxN4el5dj59yIw+0UHGLQcmQbhuaVUYTaZs9JnDv9Ow4OoRroCFAjl4m0C2X3ENJOe
 DGgi0a325UkmU
X-Google-Smtp-Source: AGHT+IHVUBiBPLs1yReZGAeHgSa7vquc86IUvneq7dC6TMb5ITdogd/h8+J6mIq9SszMNdra6aEzLA==
X-Received: by 2002:a05:6000:2913:b0:39a:ca59:a626 with SMTP id
 ffacd0b85a97d-39c120e3e5cmr10394801f8f.28.1743505128038; 
 Tue, 01 Apr 2025 03:58:48 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314b5e7sm197209115e9.35.2025.04.01.03.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 03:58:47 -0700 (PDT)
Message-ID: <f9a3fc79-220e-41a3-b626-91d2de958690@linaro.org>
Date: Tue, 1 Apr 2025 12:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250330211012.2932258-1-adityag@linux.ibm.com>
 <805a75a4-07c9-41f2-9456-d74b414ddf89@linaro.org>
 <k3ick2ilcc3h4nkq46uavibuw5zg7otanutr7syhyynpakcteh@uu4ia2nmm633>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <k3ick2ilcc3h4nkq46uavibuw5zg7otanutr7syhyynpakcteh@uu4ia2nmm633>
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

On 1/4/25 11:54, Aditya Gupta wrote:
> On 25/03/31 01:37PM, Philippe Mathieu-Daudé wrote:
>> On 30/3/25 23:10, Aditya Gupta wrote:
>>> <...snip...>
>>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks for the tag, Philippe !
> 
> I will be posting a v5 with this patch split into 2 as suggested by
> Cedric (one introducing the POWERPC_DEF_SVR_DEPR, and another marking
> power8e/8nvl as deprecated).
> 
> Should I keep your Reviewed-by in both patches ?

Fine by me!

