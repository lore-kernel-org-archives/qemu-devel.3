Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F529C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZYC-0006ZO-4k; Thu, 29 Feb 2024 01:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZY4-0006Yd-N3
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:05:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZY2-0002QL-Q7
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:05:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412b99eb5cfso3303855e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 22:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709186736; x=1709791536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJMjIISEWK7/3igvOYV4aFBNaNXSPI1c7u6l3wTJ3vo=;
 b=CSqw1soggrY/C8T5XTGpSdbT8XIKa7parC32Hi6UTrVGn4wGXQMBRHevyaJ8W3Yr1q
 RD33fLGmEJpKN0T4eDuoK0InklKiqrvfHahk4Z9HE4w1qMC3c9RwlsVE1IQlZtJlRhda
 OKtgjWPIm1KrlHLZ/kJ3CfGxqOo9b5tib8aU1VzFbYKF17VSBicJIzEkBw+3iaFHnagc
 taY+kIhGSNcsWZLACtxY6g9g8Pn596m7fpNpRAsh+0JaffODO8mDjo3dkYnJhqbQxAle
 N4xElUouTxeSwyOjOOTjxh9w7y8VEVjCBSeBjeZz6MN2W6rfhzZR5hcQ4LIQVTOeoNcP
 j51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709186736; x=1709791536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJMjIISEWK7/3igvOYV4aFBNaNXSPI1c7u6l3wTJ3vo=;
 b=qD+XMAHYJi3mI9E5AUTxtBHPzpSqJ/oLyRcu9gR+gI4Gd6JTr8YEfTD2jYPp0Lqy5c
 9LxNSb/NH//cUgjUvuCdtuNBHz2hS6JCE5bWgaAPUEs1vhlAtqEGQNg1wyI7bpkjIE1c
 ZfpMzrTMj060xpC8LqLHEO6/sLSyAxDjV2laYjggzHkmZGs6N/0m/vGyPxBb2EbFscFE
 NdqK0s4Zqj9EfeAUizSGZCiY0ge2ncnrtPIWclyviS0O0Wibn1ZlaK1gB5sd78i4J0lJ
 hKRvK8dP26Uf7h1xvw1asv2eE2TFKn30aoqgW4mLZc1BsPD2rHYZC852RhkXpDJqdBaX
 JC+A==
X-Gm-Message-State: AOJu0YxLSu1UT4JGqh4CX4HNi2askB8uHFR68JW9hyeVIVOvJOqIye1a
 yYopYjjFtFYVuMSR58Vz4fgLqYq9gbP6PoCbep3QZYHPpVmTlyCIBifJCxKsVGZAb8GZ0TiaCz2
 Zh3k=
X-Google-Smtp-Source: AGHT+IEZJMz17YIVy4xlwsKEjxfAPy34M9SZwgOB1bC+t0Fg9ORMlTIvB41293dui8EGCXIkbNqMOg==
X-Received: by 2002:a05:600c:1da2:b0:412:9868:97ed with SMTP id
 p34-20020a05600c1da200b00412986897edmr886580wms.9.1709186736232; 
 Wed, 28 Feb 2024 22:05:36 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 dn6-20020a05600c654600b004126ca2a1cbsm4042097wmb.48.2024.02.28.22.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 22:05:35 -0800 (PST)
Message-ID: <8b87d401-833f-42eb-b06d-839bcdbb50b4@linaro.org>
Date: Thu, 29 Feb 2024 10:05:32 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] plugins/execlog: add data address match and address
 range support
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20240228200211.1512816-1-svens@stackframe.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240228200211.1512816-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Sven, thanks for your series.

Yesterday, series for new API to access registers from plugins was 
merged. As part of it, execlog plugin was extended to support this [1].
This conflict with the changes presented here.

Could you please rebase this series on top of master?

Thanks,
Pierrick

[1] 
https://gitlab.com/qemu-project/qemu/-/commit/af6e4e0a22c18a7cc97650caec56ed99c9899dd7

On 2/29/24 12:02 AM, Sven Schnelle wrote:
> Hi List,
> 
> this patchset adds a new -dfilter option and address range matching. With this
> execlog can match only a certain range of address for both instruction and
> data adresses.
> 
> Example usage:
> 
> qemu-system-xxx <other options> -d plugin -plugin libexeclog.so,afilter=0x1000-0x2000,dfilter=0x388
> 
> This would only log instruction in the address range 0x1000 to 0x2000
> and accessing data at address 0x388.
> 
> Sven Schnelle (4):
>    plugins/execlog: add struct execlog_ctx
>    plugins/execlog: pass matches array to parse_vaddr_match
>    plugins/execlog: add data address match
>    plugins/execlog: add address range matching
> 
>   contrib/plugins/execlog.c | 102 ++++++++++++++++++++++++++++++--------
>   1 file changed, 82 insertions(+), 20 deletions(-)
> 

