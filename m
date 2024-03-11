Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6108C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjb8u-0006oY-Jz; Mon, 11 Mar 2024 04:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb8r-0006oK-Ui
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:36:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb8m-0002aU-S8
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:36:17 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso2264204f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710146170; x=1710750970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SL4K/y8S341K0WiNYRoYrKTVOwuc2eeSNNBA0HrxFko=;
 b=fJWdnfBJX4m+mn2yT7EyU+sn5e19g0aX10CDrAeWU1EeFJfYCAtRmfkEV/bS6f8TUp
 V0Cxr5x48x5s2z7aAfxTe8EyGph436moNwalIPAZL75UJSImY9b2aCYaIvciS7rRjrUs
 IonhsyPsqNq0TIqVyYIf12rj8H6YbxhzQGOZo4b+7TAmZx1PN1xtH7OuY3wum2a2T+OU
 cUCRYNCDVI55GbJHyfP2nAZ3GINLIJYmMuwFhYeoI23N9CkNKP77sYwt7HljS1lqslso
 nJ6lWKJNacGbDEW0BYlx6+cGr5z0jweEL0vpee3ZCG5L1unxjHDNtJHEjWOP0XsNpdi1
 TNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710146170; x=1710750970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SL4K/y8S341K0WiNYRoYrKTVOwuc2eeSNNBA0HrxFko=;
 b=AO4SPomSWhRUils5BJGp0ljxpBlZ7KJwGdenZmZsOsazbBpQSqWnoJyl/DUhFeM5m0
 ukL6y4dfihyMhMmHpdc4/JGvT0O5kPpKbP45ATZ4ETvCPg2inEtfEHmcOnRCX26Vfs80
 /SrpK7e8j9NXrpCGuE0Z658WsHcE84QgMUz3YCgHwD0QNbLIa85SqT65QKvdzcNgGZxU
 E0JozSgis3L/JijZlWONqGXENXyCgqJbN4HGhYFAoSEzVzWeDzRB8FdzsMmJ8UmFxB3p
 ODs7dmQN/h7l6MII2poVLi+sxijoMTEqbjV1fyZ1SSE3JITNs+yqXCEbGi6NW+qzOAgF
 T0Wg==
X-Gm-Message-State: AOJu0Yypvx4wLkxK7M76EtUtF9Rnb6utj0RZ/CQAA4M1PikpbWKvpqS6
 IzhnR/9F5Uq6isWXx/3QFwjfesWTpPr6FJqTjM/b6/CawC1seP6Xp3Ctb1L04LwJww20wZlyyXr
 +
X-Google-Smtp-Source: AGHT+IGQ8HGrCKbGDbE7DR1n0fol5hz+7c5egZ3NPIbBSMxMNli5hNElkGqwbsf1sUA3wmcmj2PJrg==
X-Received: by 2002:adf:9792:0:b0:33d:3c0c:ad53 with SMTP id
 s18-20020adf9792000000b0033d3c0cad53mr5707728wrb.30.1710146170425; 
 Mon, 11 Mar 2024 01:36:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a5d6402000000b0033dedd63382sm5793316wru.101.2024.03.11.01.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:36:10 -0700 (PDT)
Message-ID: <e40b0c9e-3d68-49cf-b7cc-280aa7c3fc3d@linaro.org>
Date: Mon, 11 Mar 2024 09:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/m68k/mcf5208: add support for reset
Content-Language: en-US
To: Angelo Dureghello <angelo@kernel-space.org>, huth@tuxfamily.org
Cc: qemu-devel@nongnu.org
References: <20240309093459.984565-1-angelo@kernel-space.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240309093459.984565-1-angelo@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/3/24 10:34, Angelo Dureghello wrote:
> Add reset support for mcf5208.
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>   hw/m68k/mcf5208.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)

Thanks, merged as commit d3c79c3974.

