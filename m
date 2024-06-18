Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE70BC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQdF-0006zl-Mx; Tue, 18 Jun 2024 00:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQdE-0006zX-D6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:39:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQdC-0008P9-PE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:39:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so4432469b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718685581; x=1719290381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3IIuZGyl/pBHAvozraK395biepbYK2UxoyGZ6Cd0u1I=;
 b=Qg5os1RA4ncb2G9j/LBZ7Hwus+XUHRG0+UP+UInObP9bztJC7MczOgdwQTZ2lz23D4
 BOn2Ec3TXKfEdo9Lduk+9iSuBfLYXvazPMtqDpJY0QLK61QwLVLCOr5ChM8ScNoOuEm/
 dDdS5TF6Z8XcaDlybk7SWNWNlShsPlebt55Y+BaKbsGCuhUQNyayDBj0XPCdJZTj1mhO
 X6WAu+RpbAw+qsr6GtIR5h/IF0P10c/hp5kaLrhZinztkwMvHsMEefWo4f01uF89Dge7
 FF5r8tm6EKqcotJIye4h06l7x7nixjAnrg3iBShTOyXWkYbZAYtUNZyNbu7d3cVIQSiS
 CK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718685581; x=1719290381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3IIuZGyl/pBHAvozraK395biepbYK2UxoyGZ6Cd0u1I=;
 b=PZy6y4pmUfmX8PfrjxKbx0i2HE8W7i1EbMALR6NUIYUTH1NWGYCBUQBV/1obwXTwub
 m/Uh2KbSrFTBNOr0/oFeOgYVm+q38PHX0XGEIIQ/vigoXmoE9ixiHexK7fPrUQy4D2AW
 oFCZAqQCP+OKX4WTNgjZlN6scadwaNYI6KhiG3F9TzZDRBxk6/0gS6pcOJVaoIDEs49H
 5h/guQnhoySbuCZw+C44fMNd0Mx9LLHQGp6mpwHYWvSKuBn1gU7qrW9GJmb+cRudNG9z
 gpOnK0AykC59FgveATLs+TiLPnwuFVmBhC8EC6pkT5ye5GqmREn7vd/oSwyjXXiYAWsQ
 /SUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNtTajVvxTZGxSthmvnYneeydR2czd5PhKc+Rj/k0QsnTZMSr4+EsZyVDuNEPsOhGczmGc5tNP9kfJ7wA4DTfTtANDnYk=
X-Gm-Message-State: AOJu0YxRozMDYKq4r4iBABBzs+1ZBXzdlrx5lEct/6fZadfz4MX5Ug2j
 id/y08d9hkOHe9ToHJOBq0BvbrmAtwUeovzcWne9IUGhwGtyID8PPtJozppZ/lQ=
X-Google-Smtp-Source: AGHT+IEf91QpMIGxgbE7p6S8IkuMTDWn2vQROa8IQdP44xbLjj+1GEiYv2w+aFdo0YV77JklLgaDfw==
X-Received: by 2002:aa7:9e87:0:b0:705:983e:fc15 with SMTP id
 d2e1a72fcca58-705d71470d0mr11769676b3a.10.1718685580990; 
 Mon, 17 Jun 2024 21:39:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc96752fsm8125512b3a.50.2024.06.17.21.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:39:40 -0700 (PDT)
Message-ID: <ad951cab-9c11-499c-bf9f-3db3ee201e30@linaro.org>
Date: Mon, 17 Jun 2024 21:39:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/23] Add Aarch64 sysarch() system call emulation for
 BSD-USER
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-9-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-9-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Initial implementation of sysarch() syscall and a printing function
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_sysarch.h | 42 ++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_sysarch.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

