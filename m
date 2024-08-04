Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVdh-0002ou-Ly; Sun, 04 Aug 2024 03:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVdf-0002oM-Lf
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:26:48 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVdc-0005KM-7D
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:26:46 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-709428a9469so5537484a34.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756402; x=1723361202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20VWO78GY6kQ+fCLjYjsQUtlRZPlu6El2/jARPb+C+c=;
 b=dOzxHgqJpB6+VK7jH5gegH/eScLKVHidI7lDfOwisfIOeAUnVRsMkWWD9mM1lDN3Qz
 frrlZWmWyNS3EiPdHjLivZIfz2ru70DO3PmDebU6+iCRHujipduVxqcssZ7DL7FI8X8E
 hhksqolSxfFf0lewTbYjIZ7op+xKuSfKdGqhopdIIJOFYkbjWU6hjjOegHV79YPkUseP
 jj2D2Se25i0Z3feKNo4QJCUYj68ZWb8LGDKfJKwS3VyuWAk50h0eLnGCLZ+SWP6K/02U
 XhE8GXWO64YdFAgciDgqJBvn5BQB6HjGJbLyjIJLXlpYVIFluRKL0bDzN57kBF00ycef
 XEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756402; x=1723361202;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20VWO78GY6kQ+fCLjYjsQUtlRZPlu6El2/jARPb+C+c=;
 b=k6sopiMaSWJYEjE/YUamGjS3A1arYc1P9nHT6xE+2r5UVWsig4fQpV95qVYT4OhlFd
 QQTg7ZbDkijFtr5unc7/ssWez1JKLW6Sy9q6XpYQMdMl4+6SOjbVyGcRqahnZf1u6lvD
 3wGyDguawP0xOYeB5N1tmCQQxBcZb7tl5jbvywlHvViHtZagqQoOJYasJ5RiGZ3k0ag3
 13b4oAdVrj8M6E9EY2h809fYIGTPe/9j2V6upswyb+1N8dY9rJtKNW/rNFM/o77gUpg5
 S3skjGoY1aS6JWGNV6jSgq/j2+bPs6QXFJvXn3HgbjDf0S1dwRj29eSrMlEacU0DTqKT
 nMCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWslXllAyHDG1AVnFdb9bOANec0AlVohWwtA5l+e95jbNJCI2wVEdEkKsVVViRTDB+mft+9UnMuVPi1/vgOZ+YTlmvOCe0=
X-Gm-Message-State: AOJu0YwFnfOs8zsnSTyr03fSGDMhDIi0jzqeH3BZQnp65WCBJIveJF7Y
 TgURvyM6MQPFWYDzTMMnzLgj6v5xrFDFe1CzBa9TOXDb0LEYgPsY2EH4LYO8K8o=
X-Google-Smtp-Source: AGHT+IGEZ1PRQlT7LUrQ9rl2Xi1ynXhHHebtfyzbsL8wLUrTAv9LQI9yXICFLaTnvCcw6O34NfS9ZQ==
X-Received: by 2002:a05:6830:6a8e:b0:703:5c2b:9024 with SMTP id
 46e09a7af769-709b323d790mr12574633a34.16.1722756402487; 
 Sun, 04 Aug 2024 00:26:42 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b763a3d36bsm3647618a12.52.2024.08.04.00.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:26:42 -0700 (PDT)
Message-ID: <0523ba58-4417-410a-9090-178303e92095@linaro.org>
Date: Sun, 4 Aug 2024 17:26:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] bsd-user: Remove load_flt_binary prototype
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-7-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-7-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> bsd-user doesn't have support for loading FLT binaries.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/qemu.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

