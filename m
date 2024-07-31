Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF3C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 04:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ0zd-00046N-Ng; Wed, 31 Jul 2024 00:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ0zZ-0003pC-47
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:31:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ0zX-0002pj-In
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:31:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so36230065ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 21:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722400270; x=1723005070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLkBJznP2ToKByyYvs/f1VQ/x9GtFOTVkiLrujKmQY8=;
 b=Q3nKEVoCHBiwkasFDVBxlIu+1vTXIshAlhsPfXfUjGL6zLHlr40w2C181KXcvM/7ye
 jOLsojcv/VMmW76BrVIWHAYgpib9kamIWHdGuYgR6ffMwaeTluF5TGI4OgWsuYLD6d01
 5RKCsL6qXJozVXEejWmiF/nr1aLuD9SRjEpLHdMY2t1OylLSbqa+vJb+FovcOLlMSFKp
 owRg46CkE1N+OVIeySb7JPUFjMNvV8edUaOjDVC8ntwHnB7RalfGU8g8/TVKZVuB0Te7
 qswLP0kN5Xg2GE0EXH1uZ453sVJj2q3ZPJBew1VIXthRXw12PcDM1N04F1V8uNB12XH0
 0bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722400270; x=1723005070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nLkBJznP2ToKByyYvs/f1VQ/x9GtFOTVkiLrujKmQY8=;
 b=iexZnpTl5kMR43RO8be0vD6oQ2SR2T806AQ1LIzTPqCjwtd5PCbZ4IDLkHKn6HNM84
 FA8Uz4OlT4Hv/ksD/pyZVJ6DeIvMTaJpBgTOf6QJ+2FNBpNLcuxbC0UWoa2NuelyKLWl
 L1KF76xoWbh8j+tmUlB3LqYEg/ZZ1KBbsuS2w5Kx0yKMnhi/xhbjMm9KTXiFEK29vwI8
 3ek/oJZqMtibTddq8GF0mzVWe9RLcmjvnAwwd/KGrrzGnbsjRQa9hz+oskmA/YNgYz1k
 h8C+N84xJ8XWsnSRiZdaYk2ickoubHp5RLftLpB4lOI0YOSIEpg8soQX82LLKNOMJof/
 Wn/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI0jJEGarEB1i3ZbkFVLPj610Lk9T6bclWIYDE2sQ2N5ig18DpJ0KKGeB2NVo3uYesdGqFuklLfrF8hN7kg5UPS4Nhdrg=
X-Gm-Message-State: AOJu0YyjFK3Dta3eDq3HM0QGPY1mF7h4PSIkHcA7bADa9VC4uoRGRZ4/
 rvcdNoChVeqqJ8G354B4ziuvoKL/CGY7AzMvPAegryPvb0q7OHKSEjuEPph64Zc=
X-Google-Smtp-Source: AGHT+IEcXkSB9TYhIZwg6GfN1nRANxMwoN7IpmClyr0kXIBXI18oIBdKSAPu1qODzDK0/Q9jVW3z8g==
X-Received: by 2002:a17:903:41d2:b0:1fc:2b3b:5cbe with SMTP id
 d9443c01a7336-1ff048089efmr116466075ad.9.1722400270240; 
 Tue, 30 Jul 2024 21:31:10 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7d378a7sm110481365ad.109.2024.07.30.21.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 21:31:09 -0700 (PDT)
Message-ID: <16389f62-a123-41f2-8d29-65911bb39691@linaro.org>
Date: Wed, 31 Jul 2024 14:31:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 3/5] hw/sd/sdhci: Reset @data_count index on
 invalid ADMA transfers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20240730092138.32443-1-philmd@linaro.org>
 <20240730092138.32443-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730092138.32443-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/30/24 19:21, Philippe Mathieu-Daudé wrote:
> We neglected to clear the @data_count index on ADMA error,
> allowing to trigger assertion in sdhci_read_dataport() or
> sdhci_write_dataport().
> 
> Cc:qemu-stable@nongnu.org
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Reported-by: Zheyu Ma<zheyuma97@gmail.com>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2455
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sd/sdhci.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

