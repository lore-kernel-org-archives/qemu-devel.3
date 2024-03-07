Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276F5C54E55
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAw0-0006Zq-Er; Thu, 07 Mar 2024 05:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAvy-0006Vn-CA
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:25:06 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAvw-0007qG-4B
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:25:06 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56657bcd555so782899a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709807102; x=1710411902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kDbUiIh6tTHcZWE0lxnwJsfF2SVVWYp1SYjdgK2SxP4=;
 b=Y4jhxxmVZepcDaOSMjjDbvMh5lZKkdu0jjWzmna62BUzkarm7bL3rT6L7Psw6DHX69
 nXGMZGgftdKwtfmjbw/u6LTDsTVgFkc0ty8b5w68+/L2rL4uqOsr8IEYV1ynKeghgwKi
 TlOlC7vaHJQxnKtzH3hngOxTtLfoIlFlEQHhZTydv1CDIsh2zaWQbJrR/j9J/vXc0iDr
 qpSLk8YUAVR/cUCulb19kC6Isoqhxs18YYfhfXBK6blIDJ7M7Vdh97yNrpGmnO6Mfl5D
 wyC8XaSzUnCGPLwL68u6qv3bvefea77mdIisyahYYQR1S2OEHqfhV5GZzHDRWN/RODc0
 bB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709807102; x=1710411902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kDbUiIh6tTHcZWE0lxnwJsfF2SVVWYp1SYjdgK2SxP4=;
 b=YBw8UFO/1pd3N8u88YgS3u2zB3H8q3p8/sKOSMnu/em60E5qRqn0PayNUSDIMIC+yf
 TxDo3MxAtOTvihM0GfXUbQCgNitM+VDMzmPbmesNP7AR/Dmpn+AdmkonEF8Obm3kSlmY
 RMNuHXNbj2GIz3hopq9ndNQkSEmrYZaoRzgL8uMgpNX20VIO2F1e9jSXesPVs1BcDvde
 0ceqGEiUxi1w769i4guvF9j/+hhLuX7dgTujdPjLXx9t7dmaDfl4UuyKiGAkI1anCCsT
 BOuVhxuhrlMS3LnSGcCYJZygW8gu/C3sGTesn2pTLx4vFRSo1CcAEVNx7mxIJHAwOFbb
 Cxew==
X-Gm-Message-State: AOJu0Yyv5cx1g+KECrubvWIe8zXioxEZZvjzpLgyfJOB8y8GSQmJ9wis
 Jt2CTUR+EWbcQjOjaOE2xNrgznYRda7OTbx//Q3Sk22Ns3goiPHn7/+wxND29Lrfvu29UnKGO77
 k
X-Google-Smtp-Source: AGHT+IFqYeym8J/jFhmWTWzEhJSZRsezdz0/acX/1LRZSzQkmyyID7q9RreuioGTf65yZJYFA40bBA==
X-Received: by 2002:a05:6402:222a:b0:565:faf5:225d with SMTP id
 cr10-20020a056402222a00b00565faf5225dmr12407236edb.29.1709807102319; 
 Thu, 07 Mar 2024 02:25:02 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 g16-20020a056402321000b00567e27c72c4sm1780776eda.62.2024.03.07.02.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:25:01 -0800 (PST)
Message-ID: <d91727f4-7071-4b6b-8b09-c66218f91179@linaro.org>
Date: Thu, 7 Mar 2024 11:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] contrib/elf2dmp: Change pa_space_create()
 signature
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-4-4f324ad4d99d@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-4-4f324ad4d99d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 7/3/24 11:20, Akihiko Odaki wrote:
> pa_space_create() used to return an integer to propagate error, but
> it never fails so let it return void.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   contrib/elf2dmp/addrspace.h | 2 +-
>   contrib/elf2dmp/addrspace.c | 4 +---
>   contrib/elf2dmp/main.c      | 5 +----
>   3 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


