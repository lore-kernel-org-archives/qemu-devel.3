Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1234C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNOy-0005OU-0t; Wed, 12 Jun 2024 08:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNOv-0005OB-O7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:48:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNOu-0005oo-3v
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:48:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4210aa012e5so21800505e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718196506; x=1718801306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/3y/8JIIGuT9LIu6BrhKkuGg4jsQO4e/xe3DbBKrik=;
 b=ZEO/n1t5J984atQc80DZEaXwB666qRG88XoWXiOno0alYP2buIca1u9GI6CzDNJFmV
 Te5zc6L9aCWNuJFZydy0FCoNd3Jt+UPGG2FGR+yjLa2WRLLKUUywhO8Rh/SorJWksdi5
 R0BbuXTkBphq1XSG+jxhuGeoltRk1EewCYOUYKEyQyJY4DY2rRAKuW+34aq7EDcPjRWV
 +Gk6ObzhAdMsBZHDi5LMIqVJ+mleLd7+oy1EH4dHM4t6GTc2M9QxeKkx22k9LB5jwmlP
 MXHvQV4RM089rETAKcSIr59ttGVULvJHVty7VY2j5fYkscR0CGyUYfpKAv/b91Dj0UuR
 UVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196506; x=1718801306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/3y/8JIIGuT9LIu6BrhKkuGg4jsQO4e/xe3DbBKrik=;
 b=uCOaz8dvjVE6xhcmE335jus7g50UjWelN5cXfCAniW9jHwX0x0kQSZOXUvR7g1MR9Y
 OeSou65WHICH/rXOw/pQxr7nCWpoYTJoi7dpK/N6+96mzgMSgTeTdOAO+J8dGnOTxNUx
 EpgZK4nlCNdA/5+oo/XeBSzrNdf2Gpomw56DsOxvcimSB2lytBG657Dhk+mBQqExESwq
 JCABFqtSIoEQNiBuEBSLVgpwEQk7kzT/qlkW9Avvwoqo7vO/Yi3IIqXpGNewPTSKT3Ln
 bDW6+toypnxvqUz157WnVVVSExNhL0JcGS/hajM3MdxW1n5nkIlMCRFNkOCnK5ksLESY
 JPkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0U8V1DGtYEJHrKIhfkOmf510lCOwYjwIRvqcJ8Nt05LWPbtTv82/p944Aa+AGRclVpUce67dJo0C/pSPwEHocDQJRfxU=
X-Gm-Message-State: AOJu0YwmnI55ASIZqAGLheaTerGUV2YEkuZF1Z1i70JkziRMSC1Vi1go
 Msn10AQe5fSVMVwUufeK8TyVv/4u9Cfy8MC06mK2YbMkUCXbJarCsE2ux4bxhlmiOcCkZkH2SUo
 9
X-Google-Smtp-Source: AGHT+IELaLfMxIlQ3ua+N50C57vHt/QvgvPJpfE4/pEIP/z6b73HIY4+01TA3F/TWWmoagIeb4zHJA==
X-Received: by 2002:adf:dd91:0:b0:35f:1dcd:131d with SMTP id
 ffacd0b85a97d-35fdf7acb54mr1172234f8f.30.1718196506592; 
 Wed, 12 Jun 2024 05:48:26 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e73e8sm26542105e9.43.2024.06.12.05.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:48:26 -0700 (PDT)
Message-ID: <6e00233e-63ab-4513-aa0f-c55ab4ef0747@linaro.org>
Date: Wed, 12 Jun 2024 14:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] qga/linux: Add new api 'guest-network-get-route'
To: Dehan Meng <demeng@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com
References: <20240612103105.301456-1-demeng@redhat.com>
 <20240612103105.301456-2-demeng@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240612103105.301456-2-demeng@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Dehan,

On 12/6/24 12:31, Dehan Meng wrote:
> The Route information of the Linux VM needs to be used
> by administrators and users when debugging network problems
> and troubleshooting.
> 
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>   qga/commands-posix.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
>   qga/commands-win32.c |  6 ++++
>   qga/qapi-schema.json | 56 ++++++++++++++++++++++++++++++
>   3 files changed, 143 insertions(+)


> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b3de1fb6b3..58f51aecbb 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1800,3 +1800,59 @@
>   { 'command': 'guest-get-cpustats',
>     'returns': ['GuestCpuStats']
>   }
> +
> +##
> +# @GuestNetworkRoute:
> +#
> +# Route information, currently, only linux supported.
> +#
> +# @iface: The destination network or host's egress network interface in the routing table
> +#
> +# @destination: The IP address of the target network or host, The final destination of the packet

Maybe clearer to start naming this @ipv4 in case you plan @ipv6
support later (see @NetdevUserOptions structure in qapi/net.json).

> +#
> +# @gateway: The IP address of the next hop router
> +#
> +# @mask: Subnet Mask
> +#
> +# @metric: Route metric
> +#
> +# @flags: Route flags (not for windows)
> +#
> +# @irtt: Initial round-trip delay (not for windows)
> +#
> +# @refcnt: The route's reference count (not for windows)
> +#
> +# @use: Route usage count (not for windows)
> +#
> +# @window: TCP window size, used for flow control (not for windows)
> +#
> +# @mtu: Data link layer maximum packet size (not for windows)
> +#
> +# Since: 9.1
> +
> +##
> +{ 'struct': 'GuestNetworkRoute',
> +  'data': {'iface': 'str',
> +           'destination': 'str',
> +           'gateway': 'str',
> +           'metric': 'int',
> +           'mask': 'str',
> +           '*irtt': 'int',
> +           '*flags': 'uint64',
> +           '*refcnt': 'int',
> +           '*use': 'int',
> +           '*window': 'int',
> +           '*mtu': 'int'
> +           }}
> +
> +##
> +# @guest-network-get-route:
> +#
> +# Retrieve information about route of network.
> +# Returns: List of route info of guest.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'guest-network-get-route',
> +  'returns': ['GuestNetworkRoute']
> +}


