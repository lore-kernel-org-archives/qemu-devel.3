Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182FDC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 05:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEjeo-0004f3-Co; Wed, 05 Jun 2024 01:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sEjem-0004eY-HX
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 01:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sEjek-0005fw-A6
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 01:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717567072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhhdfjavvldzmPaMXqTd97MZEvKqmNWdAncYI0hI324=;
 b=GS6y4ktko7wZJ5AGei62ss6E8EW/xBKDIE9oliFesNAOo2DjxrxLPB2cLCIhasBwW3kKLP
 ldZmB7So2FEfAxSzimHUgEsrdAT3kEfHlzpO8q+bTk0HtPZNolbLs/r32tg3KbXMUtr4wt
 oAAGv/BobzYf+muii6wwnCilIvGhAUs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-W1uCfEP5NaiEbX1v_YnA8g-1; Wed, 05 Jun 2024 01:57:44 -0400
X-MC-Unique: W1uCfEP5NaiEbX1v_YnA8g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dca0dc826so1388806f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 22:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717567063; x=1718171863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhhdfjavvldzmPaMXqTd97MZEvKqmNWdAncYI0hI324=;
 b=UVlgZGXpL4apjGO5xgWpdiZxNFMf75N6jOz8PhTJ6KNujViBw80JvFS1y0jX0QXQZ2
 KowZFzA1weq+fzHHAOaN75T9aPmMqICHfALdUTYApbVJtsZJbiWgaEzw6h11o5/JL91O
 T2zKIcy2evgXpfBZqLV6sv3QvfgCIQwS4IGqz5UIqIjTCg0FHOORp/4+wcaz4bsqQaf0
 zA1SHLEEYc5BjxbBvz/4vQ0IPslAlPIQ+sGP3/Po6/J16CJDh1uXi+boe97oZf1VQ4w8
 Qd+neCLwyg/4sAlLOy4f350sj6IzJRde1enPNu4HmH3GL94QfBMDjnXOrjOU5R6pcJ4F
 aZSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmE8jgVGItl/OQBdtxDE6HMCvMJXsF1Y+64qhw3OZEJLWPW0K5I6sQ7BJxgh9M9Ory5pV5gurRkwfQ6AcAbvcpPRJpUfc=
X-Gm-Message-State: AOJu0Yx6MSLpLsk+JFvRg224GHB2mtHn4w3HRU9x5hoM+VU8F3u3Qseb
 jgCNoQupDSR1+Ns+rEZY+Gs/dq1tA4RSygBe7nugwg3WcUjq6n9QzFGE/My6PkImWEPSnS8pDug
 TXEv7gOsBns/Nwk1iKWFJcVrjG051tuXTjiFp6jUiSC2wbdYVIhMS
X-Received: by 2002:adf:f747:0:b0:354:f38f:6e68 with SMTP id
 ffacd0b85a97d-35e84062d21mr1050994f8f.13.1717567063756; 
 Tue, 04 Jun 2024 22:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiVnqqDRmumxcQAI6/3XsZ8mlHlWblmpviv3ybtoQX9I0/Z3dS1ShJuwd0dqrA76lMlQxolg==
X-Received: by 2002:adf:f747:0:b0:354:f38f:6e68 with SMTP id
 ffacd0b85a97d-35e84062d21mr1050985f8f.13.1717567063394; 
 Tue, 04 Jun 2024 22:57:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35eec1745a3sm327721f8f.4.2024.06.04.22.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 22:57:42 -0700 (PDT)
Message-ID: <f766e1a8-38d5-4e99-a148-235bf00fce69@redhat.com>
Date: Wed, 5 Jun 2024 07:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add maintainers for ASPEED BMCs
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: steven_lee@aspeedtech.com, troy_lee@aspeedtech.com
References: <20240605034413.1064845-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240605034413.1064845-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/5/24 05:44, Jamin Lin wrote:
> Add ASPEED members "Steven Lee", "Troy Lee" and "Jamin Lin"
> to be maintainers of ASPEED BMCs.

Let's start with Reviewers. please resend.

https://qemu.readthedocs.io/en/v9.0.0/devel/maintainers.html

Thanks,

C.


> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 951556224a..39651be467 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1158,6 +1158,9 @@ F: docs/system/arm/emcraft-sf2.rst
>   ASPEED BMCs
>   M: Cédric Le Goater <clg@kaod.org>
>   M: Peter Maydell <peter.maydell@linaro.org>
> +M: Steven Lee <steven_lee@aspeedtech.com>
> +M: Troy Lee <leetroy@gmail.com>
> +M: Jamin Lin <jamin_lin@aspeedtech.com>
>   R: Andrew Jeffery <andrew@codeconstruct.com.au>
>   R: Joel Stanley <joel@jms.id.au>
>   L: qemu-arm@nongnu.org


