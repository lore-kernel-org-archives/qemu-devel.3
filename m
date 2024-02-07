Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC3C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXnCs-0007AG-Bd; Wed, 07 Feb 2024 14:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXnCp-00078T-Nr
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:03:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXnCn-00084t-TB
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:03:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4102a186cfbso2036595e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707332612; x=1707937412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ad2X9jzS20shlsnS31QS4wwNroAAiHsJDT07fx/lEUA=;
 b=NoW0hK8M4HEhzm96iXLFJJTbkheZbpFt/hQyuxjpfG0mDtvATMLMs0IwTQvL3507ia
 OZG+UVnN2zEhJlTKIzP355GIaYMdzR/zuNhs+cJ+QZPL2/LDh/J4r9yu7m5HzrtpFRkU
 8bOlCRITj7BZLIFoYqVsL8/i/izu+D/5yhE7B83SYO8/2GRllYY+BheMquLBMmxUnZgs
 UwqbqAi+6ssZvygKKuuJ4tyoPCjI1rUqwZZOpguJdGzMLRlIGI8qMHhBK6hx24nxHSr9
 DoCA17Uspfx4YzbXjg5Wm/agd9kLX2hHCnDBmlrPr9p1mK3UyR8ih4C8NIcb13FwTbpL
 /peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707332612; x=1707937412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ad2X9jzS20shlsnS31QS4wwNroAAiHsJDT07fx/lEUA=;
 b=j8A/tzsrpEd5XLTux7k9LPrKaQaC+xTeY1AZJ2Bui1rWVyoOezKqtoszDMk1I6SRqq
 hyKzwf498YYq/29QFggtDwqDvBv2FVruN1+0oVASJEMBCnV52fR4d3wfzRRyxaMmDXrp
 CK+qyCdBT2Y0O4O8HkRBW9YJFRYiWFfVU6ZFiDuPk+fQn/mbPCQMEDT798343kKZb3h1
 GtureWKEUfdI+fP34+bhQIyZDSrMzUUqhRi83gAyfqTMdqQ0JS8W2j+MXrCOQNtMV/2h
 ObCQEBz15jT975QVQ4vnNlER6OHQeA8mrCCawXlGovX73rfkGxli2pyXj7vhVpGZ3IZf
 RCuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEx2fivFCqvKftl6riK0er4sDMZpAmFMkGR2Jtctis5VeWSK6JZ9LXXqWaLDlvwQpKYSYfKdnetbprqASqzPqA/BLu2VA=
X-Gm-Message-State: AOJu0Yx5EfeDQCRKQsRCQhwMVxf0o1bzXVDedWLjqJ+CqA65BKSZ3oz0
 nAF/BmPUjXbyk49SrW2PGOmbaKbGl798iAp7ie2AgWExPbrAzos6spMyX3JCVoI=
X-Google-Smtp-Source: AGHT+IFAAvDU6UScNLN+IaIuKl3kjkPpSFJ2MIa3xeq1fEneY6GCamnCPfsVcSxj5KoyNbcQkEC76g==
X-Received: by 2002:a05:600c:474a:b0:410:27e7:4c5 with SMTP id
 w10-20020a05600c474a00b0041027e704c5mr622220wmo.29.1707332612317; 
 Wed, 07 Feb 2024 11:03:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUCCZFKlhZF4cr5w+ZqeJLWxgBvBWk2G9IH+CXkE5SY6SPfn0rD/bxDI3EPykOFUfwsNYTNXom0quU8hiP2cK4Eto6s33M=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 bi20-20020a05600c3d9400b004101e0960e7sm1395232wmb.44.2024.02.07.11.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 11:03:31 -0800 (PST)
Message-ID: <f53b1dc9-779a-4166-878e-42fd7889cc6f@linaro.org>
Date: Wed, 7 Feb 2024 20:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] isa: specify instance_size in isa_superio_type_info
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207111411.115040-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/2/24 12:14, Paolo Bonzini wrote:
> Right now all subclasses of TYPE_ISA_SUPERIO have to specify an instance_size,
> because the ISASuperIODevice struct adds fields to ISADevice but the type does
> not include the increased instance size.  Failure to do so results in an access
> past the bounds of struct ISADevice as soon as isa_superio_realize is called.
> Fix this by specifying the instance_size already in the superclass.
> 
> Cc: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/isa/isa-superio.c       | 2 +-
>   hw/isa/smc37c669-superio.c | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)

Oops, thanks!

Fixes: 4c3119a6e3 ("hw/isa/superio: Factor out the parallel code from 
pc87312.c")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


