Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D858C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIXA-0006Qw-Gy; Mon, 01 Jul 2024 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIWV-00062J-1M
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:00:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIWR-0001kw-PO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:00:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-425624255f3so18776465e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846050; x=1720450850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0i9XgB3FWcCofNOcUCQntbSdJHNFbhPZ+eaxWE0nNQ8=;
 b=iCSVShggcQRNQQMmmlBA6qHTD1mGH2+EYosVY80PLCiiy4TVmMszkEhgeFuQEsuyUX
 LfONZM1bRltGxYJ3s6rimfIkc9NiYhCxlfID1clCoZKRpzBUWyeoBBqBKbKnk5rO/HrI
 S1kxMNPT6qHp9a3Rgys5msnp9VT7V4ZWBvBXskMzkZ/pAMYLbgJoDKLPq19FyxviGkrD
 N9fqUGFN4FpL6GRPzbRX9yhkUhxPRGXArErTFFRZmVpUUydPYOxeztlqHMhIF69P3x0K
 xwzosm9rmbCpiv5hQ/CsV5OP9oF7u2LCu+MgyImvG3T31JCbCaDtfDfq9QZpAbLjtqRo
 0HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846050; x=1720450850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i9XgB3FWcCofNOcUCQntbSdJHNFbhPZ+eaxWE0nNQ8=;
 b=Gm5HL/JuVJLp4JMrI+/W1iXq62/Vk0hNxTEVJW2z2SqzhwYmT4Rc+wJUjdLoJKrEeh
 YoQ9EkZzoZuMJzMn9LYtCtHIONADyjizcg+12DFQvVTVb6TcXJftT4TlIdE8jPjXnlZz
 bgFrO0sbP59/TQ7XIwScUxvODPnhlcUJdmjwxSrRu62lFkKfK04YYZ2gXJ5teXAcC1Ii
 CdgXu2P/sI8DW89vASMl+fhIRGRIllNWOelgdhWQfXQH4AGoJPPriMaELGL0Wrzqtb/I
 zlN3h6HGusgIWIFZuJeqHqYAMmhlrFD7ictHdiUIdRbRtWD+QtmSnthHN3VyIp8BocDG
 06ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+otEYTzCzcELeXHu5Yp/ge4TAbuanTr+S8XBWl9g3JWrgbNGp7za/bVIE+1B96R+/MMb8gUbQj+cohKBBj0GrAmhrewQ=
X-Gm-Message-State: AOJu0YyUKbx3rEI9g52X4PrgzJsTLcWW7WPodxc68CTkEv9qCy4BKocM
 ZFN0ZSmBxHM90JU+rlsLEg5RwwX6wlM71mYSLxLIS/nZTuoxX2C1P3Zc+Rn4UF0=
X-Google-Smtp-Source: AGHT+IHFMquxgYW21IEoWEkpoGLeh85y4F6RwynFDEcc7yVdwjBqb87QK+jgfMagdnDyikQ4E2i5wA==
X-Received: by 2002:a05:600c:3552:b0:425:7c42:d24b with SMTP id
 5b1f17b1804b1-4257c42d3a0mr42783875e9.18.1719846050104; 
 Mon, 01 Jul 2024 08:00:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4258014f8b7sm62140435e9.41.2024.07.01.08.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:00:49 -0700 (PDT)
Message-ID: <89618c21-b1dc-4979-af97-35576d8eeabb@linaro.org>
Date: Mon, 1 Jul 2024 17:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove inclusion of hw/hw.h from files that don't need it
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jiri Slaby <jslaby@suse.cz>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20240701132649.58345-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240701132649.58345-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/7/24 15:26, Thomas Huth wrote:
> hw/hw.h only contains the prototype of hw_error() nowadays, so
> files that don't use this function don't need to include this
> header.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/misc/xlnx-cfi-if.h | 1 -
>   hw/misc/edu.c                 | 1 -
>   hw/vfio/container.c           | 1 -
>   3 files changed, 3 deletions(-)

Thanks, patch queued.

