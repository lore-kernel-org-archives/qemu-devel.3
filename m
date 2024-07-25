Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149D8C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsXj-0002d2-Qj; Thu, 25 Jul 2024 03:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsXX-000297-AX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:05:28 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsXU-0004pq-7v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:05:25 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f0407330a3so700411fa.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721891122; x=1722495922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=geHfL8qXxwEt7ri9JkM1Lltv0Y2JjrwEQxLLPW6vnug=;
 b=PTdMeaXUgwK7HtdBJ6fIoNsSvLMxR9tituU9RumIQiR3icpjudi8v/96Y4k5w+0nk/
 ZSArpBwFyC1LunQ5xomNu5jtupjQBh+6MB+YARs6r9IKvX5XlR4nUCSkum3LB/NFgoKt
 E9l0V70fy7wcVivgrRLwzyQXnlVlMndOxKFs2Y0XnvY6BtlQH3dbShWfhdikoA09wQvw
 MWddIcy9yUOE5KeuIeDvxQED+WlvwGncUAwPs3NsqXZPPIKv91hOyjEksm9ZLQsUtdjS
 eqtktGM7IBOdHFvSuiMQyOHwDAVacHKETQTfp4AjfpTC6k4DGLJrj0InAUgyn1DHY8w8
 dgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891122; x=1722495922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=geHfL8qXxwEt7ri9JkM1Lltv0Y2JjrwEQxLLPW6vnug=;
 b=RgxMIt/Zd5GO9q/i1zrzKQ3DgrXd2dchmYEw2CEb/zQgWI3sIyg1zRHcDhsi1jPCD6
 De/RArLaz3yrLBEbzY19gMh4B8lhbt2FrNFpWVnm3/yWleZDRnI6vBXCc7dQcggQGG7W
 Nm4ZcKknEpO9FZprs/RBnOHb/wey5yyBXtOEKsyq0ZzzRPD8q/xolD2GpI8YENvXv2LG
 GPxSGEfIir7PM77C2dir/LLDSWYb2IPFXdGeo6F3+5YvzmZZ8WLu7/ITiQdhTr03n3hI
 7AVEAtpcD7jUf/eZsCEHrbEvEfHhjBao3LYxGs7zBrZShyienUuqI4bydXNB8PM3Pkg0
 w8Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhm93EyzjrERKkkTt106ZNUfORdfG7wNJrGilAG66SF487lsR5030he0CyNrkPSaYw1JtNMuDU+UE6Ggkk1/8jUGDURrA=
X-Gm-Message-State: AOJu0YwlH9jRst/QheWFKYFw758yVljAsSq1RWrgYzAI9O6sA/6VEyp5
 vnR9lMKFT6jkvFwNqDtcW/gCCDACenrK0QxUzafzFx+HmmfDkCAoNflJv2OnFq8=
X-Google-Smtp-Source: AGHT+IHCa4pl04VI6/dflLXcmRbZZn47wUlwQAJH0arnhn3+pEY0jYUJXjYuz7A7h3x+JB8xMqDZdA==
X-Received: by 2002:a2e:958d:0:b0:2ef:208f:9ec5 with SMTP id
 38308e7fff4ca-2f039d921a2mr13427371fa.31.1721891122380; 
 Thu, 25 Jul 2024 00:05:22 -0700 (PDT)
Received: from [192.168.114.175] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280574a8a2sm19481215e9.23.2024.07.25.00.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:05:21 -0700 (PDT)
Message-ID: <334e5ecc-212e-475f-a2c1-c9a005f0018b@linaro.org>
Date: Thu, 25 Jul 2024 09:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-rng: block max-bytes=0
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
References: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 24/7/24 12:51, Michael S. Tsirkin wrote:
> with max-bytes set to 0, quota is 0 and so device does not work.
> block this to avoid user confusion
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/virtio/virtio-rng.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


