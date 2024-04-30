Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD5C19F53
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jym-0004BM-LR; Tue, 30 Apr 2024 05:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jyl-0004AO-FJ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:40:51 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jyi-0005n4-G2
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:40:50 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so737397466b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714470045; x=1715074845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WCW36M2OPMJQEyyFgNdC/dGiDwonm3j21cpSR92e9XQ=;
 b=Fe7Dr6i3g5W0z0fornJOMxTr0GSlCQcEvfmpIlGMgQ03Vy5TaG7hn4ybHqyVS3Ywvr
 S09HGRosGRSrIY81NvACesJDU/kqIOrudthgPc3DrrhoL3g2z8uszheSRmYmOOBQXjbm
 p4DiIaMUYh9neqIXcAvsp5JAvrzYr7nHnUjgZ2ZaerhXLaZ51XTH0YDE30IWns++zeQu
 zzfErEcZlOzY+0+p9cDmcyfSVlspfebQNTWfXfslydUdBrdB9wZlJ1us+shxb/JW1URt
 1ogs79o0cxhKHf4n2GYwT3Orne1elooxM+jorHHJP25+vKVDxzSWdDRpdFgp36NG49R7
 efnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470045; x=1715074845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WCW36M2OPMJQEyyFgNdC/dGiDwonm3j21cpSR92e9XQ=;
 b=BCFC/8J4rZs+u2NiLZ7O6vUEKA1+hl3JQ5tdhBZWPciCZEvXoaLjK3yDsOW52w9kxp
 pSCxo5ctUKjp6VsnYP13snMhmm8mrWRYGWwJ8L4OwvoUtPSMSwSwyIaccmZgvQ5/VWN7
 jHenAv5SZolWml4ene1d0uZWinCj5OQ/9uwNRETEY5LgopnO6Mo7o9+VguTwyIZXtm2u
 0pwUBvWQwO3Ie5RWfdE+3LRH3AoScHn38TtVZLVG+oF32H8mjtkTpGQ2C2hKqGq3Kc8G
 yeVBL1YYSHMOE578uEtGDIFmnjYeG5uoz2ziUFM52AyrHrDzno03CoP4MgC47u5lu+tF
 jr4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8DOycVOn4jsS8AyMmVpw94cd3vM30EgNyN8QJ6RtG5IRwneQ9a6ZnyMWgmj+hsQWNhn2rZyLm5yC8gd/l3LcSvaI0GP0=
X-Gm-Message-State: AOJu0Yx1xGOgKZ7QTLygwvqHh3nZdD52Tm4tskHtiRT4FoEFMLTcdAX7
 q8N9Fwf7Wh9PoDJeKypsyw80LmuEglwxYhebKe6CkfR5E+MRRPh8zejDpbwe4VA=
X-Google-Smtp-Source: AGHT+IG7XLmwO7QxuzgXq2SVqqslj4FXwQzCThn2wfkH4A9JCUY6sNp/icquTpaem+8tzcmU+J8LRg==
X-Received: by 2002:a17:906:5851:b0:a58:7ce0:8e13 with SMTP id
 h17-20020a170906585100b00a587ce08e13mr1469299ejs.34.1714470044921; 
 Tue, 30 Apr 2024 02:40:44 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 x10-20020a170906298a00b00a58ed644d6dsm3526332eje.127.2024.04.30.02.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:40:44 -0700 (PDT)
Message-ID: <e0e836cf-f080-45f4-a71b-060dd2c90279@linaro.org>
Date: Tue, 30 Apr 2024 11:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Automatically deprecate versioned machine
 types older than 6 years
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240430064529.411699-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430064529.411699-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Thomas,

On 30/4/24 08:45, Thomas Huth wrote:
> Old machine types often have bugs or work-arounds that affect our
> possibilities to move forward with the QEMU code base (see for example
> https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
> cannot be fixed without breaking live migration with old machine types,
> or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
> commit ea985d235b86). So instead of going through the process of manually
> deprecating old machine types again and again, let's rather add an entry
> that can stay, which declares that machine types older than 6 years are
> considered as deprecated automatically. Six years should be sufficient to
> support the release cycles of most Linux distributions.

Thanks for taking that out of my plate :)

IIRC 6 years was because of some old RHEL version, otherwise could
5 years be enough? (maybe it could be good enough for this old RHEL
version as of QEMU v10.0).

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 6d595de3b6..fe69e2d44c 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -220,6 +220,17 @@ is a chance the code will bitrot without anyone noticing.
>   System emulator machines
>   ------------------------
>   
> +Versioned machine types older than 6 years
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Starting with the release of QEMU 10.0, versioned machine types older than

Why can't we start with QEMU 9.1?

> +6 years will automatically be considered as deprecated and might be due to
> +removal without furthor notice. For example, this affects machine types like
> +pc-i440fx-X.Y, pc-q35-X.Y, pseries-X.Y, s390-ccw-virtio-X.Y or virt-X.Y where
> +X is the major number and Y is the minor number of the old QEMU version.
> +If you are still using machine types from QEMU versions older than 6 years,
> +please update your setting to use a newer versioned machine type instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


