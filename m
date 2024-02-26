Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F358C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWGl-00068m-Bz; Mon, 26 Feb 2024 03:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWGi-00067M-FU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:23:25 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWGh-0004eA-0Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:23:24 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a36126ee41eso312179966b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708935800; x=1709540600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IHkkhH3shB94Aa6njH/RF4O9pI/05EhqdX+P2NTRny8=;
 b=B+aFsomzD0eAGwbumIYL4oG7zdSK5r7n9kNv3hhd3JAkGNcETZo4/UuVFVkd1XI9J0
 dkrQdm7MvQN8j9psbpeQhn4Yk9a+VXUcTfs5aNkQ7Ge0v691xOsK5HCHbnxu7pXW1Svb
 dJ4gOXNejAixASLgp3r+6eIpHGcZAG75zUt8q0y1fLb5vmvlITxP6Slc1CVbFOcjm3Yo
 sfKzp4XThUqjYxzTLQTKJSdeVs1IrUmxfCnY/z/AAjhByvmMflor7krRjQW00wQKhHQz
 eHaT3RFXOOaimUbuC7elAMryaUPYox1YSAXN0QP4TcWDhKrpqk8i6vbFkDLTHmjbYZYJ
 wDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708935800; x=1709540600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IHkkhH3shB94Aa6njH/RF4O9pI/05EhqdX+P2NTRny8=;
 b=hbAmhMueKuA34004DcuaICM66IpPkOSESrFs9T5wDFI/aiVj4yWikHXcFyy0/UxOJP
 IyTV5S7jZFP/6ksWizfc8ig7j2IiyrhmEX3MNtJEFQ7vxgPqht+Q6UFWid94Se0Plgh+
 GTLKdtw9IQmmfMM9defczx+hNGA3CAGuOyNZV8aetG3bvcShdCWWyLNGvWwqhCmJRx6q
 EQJVNIkXYPhYXZmy6dNbojQtw+Auy243tnbvwZ9kB2fNFCILljAhK25l0/I1Mp41Ow2V
 tktSCXjJoa58TktPiLfGvXGSuxa6rpf49Ttipb4l89Olo1QFxQDPX4s2Syx0jnbifkLw
 fUlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwffVT7tg0hWCcOYmat3h3OeEL5Wk/oW4Y+nz/D/DeXLNjXwndLRW0jwm5ugnpHLjuqbySqaGPutTfs9cE0tAWrMDVBdE=
X-Gm-Message-State: AOJu0YwqmG2PRzZftNTsLmxDObKkbQBKNENqLFbikTWMGf7zv+aGuNuf
 xsGklAK0LumUQnMQwmXeP0LPYrhEL5Gwccw7L7GxQ/fDuz/n5+mhFdNbbzc6/kE=
X-Google-Smtp-Source: AGHT+IHOnMGtNqT1/asAZtr5MYy0RSUUVEKYMToG1GqpcICWSSVYwVWbEB7USOctPs4WSxY3+ruo5g==
X-Received: by 2002:a17:906:40d1:b0:a3e:93d0:3443 with SMTP id
 a17-20020a17090640d100b00a3e93d03443mr3955053ejk.34.1708935800385; 
 Mon, 26 Feb 2024 00:23:20 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 fj8-20020a1709069c8800b00a42ec98b9afsm2127370ejc.158.2024.02.26.00.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:23:20 -0800 (PST)
Message-ID: <601bae2e-4e42-4e88-aa97-e94bb4696ab8@linaro.org>
Date: Mon, 26 Feb 2024 09:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/xen: detect when running inside stubdomain
Content-Language: en-US
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 19/2/24 19:16, Marek Marczykowski-Górecki wrote:
> Introduce global xen_is_stubdomain variable when qemu is running inside
> a stubdomain instead of dom0. This will be relevant for subsequent
> patches, as few things like accessing PCI config space need to be done
> differently.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>   hw/xen/xen-legacy-backend.c | 15 +++++++++++++++
>   include/hw/xen/xen.h        |  1 +
>   system/globals.c            |  1 +
>   3 files changed, 17 insertions(+)


> +static bool xen_check_stubdomain(void)
> +{
> +    char *dm_path = g_strdup_printf("/local/domain/%d/image", xen_domid);
> +    uint32_t dm_domid;
> +    bool is_stubdom = false;
> +
> +    if (!xenstore_read_int(dm_path, "device-model-domid", &dm_domid))

BTW missing braces for QEMU coding style: {

> +        is_stubdom = dm_domid != 0;

}

> +
> +    g_free(dm_path);
> +    return is_stubdom;
> +}


