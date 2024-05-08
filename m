Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0776C25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eSu-0003Qe-Lz; Wed, 08 May 2024 06:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eSs-0003M6-0p
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:23:58 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eSq-00017t-Cm
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:23:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so1157489a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163835; x=1715768635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iSoMj/QENrdvbGE/2j0uDqYs24OnJN3Dolk07t3af88=;
 b=iDA7yC4IUMd5Fki9DNAI8vsbzLwBK8XB+mpE854gk6PNgTW1FGoOupYoqyEJuRcrCd
 8wJxrEMpABa4BoadtiF3sKdg32Mcpps3hBeg1+Esi8/uWp0sdz5pFl8eYzlJSV/5CCZe
 3F6iosXtal+jLXxLiRyWR+QN/YPg7d8K4/1gxGG1+BCmPzAp6230txIh3EZVfm7c8Sj0
 5evfd0vor/mifZZRM/A4k8s3Cad+sBm8X5U4ZZFOxZvjZ7Wl2/ZPgZ5j0luccB1rttzc
 +EZ8xRS2sZSiaN0dWPUMzbeB+HkYhpoADjv0zmbgsIAqZojZp2rhcPTjhaVWED6l1gg6
 ke3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163835; x=1715768635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSoMj/QENrdvbGE/2j0uDqYs24OnJN3Dolk07t3af88=;
 b=PzFgArgrWkzqvoT2wtxvkswCCoKMIhFoAgmmJJ6qgBRLmUaPjBrlBivE003GDQ8x7D
 V4A+JZR7ZSBu4xFRQjspnZFzeJKA+l0UYxm9/Ndfbq6b1L5XsBE3OkH8grQClAAwrcGC
 xmrIZi5i5R+B7dMt+72wm+MZqDLw1Y+ah7v6XpTOCPJdqM7EQjsdMTNgGK3G9OW4EvrQ
 aQJcgor9S0+QDfDTU3AQlRtBfszf82c8DAxgSEz/SSftgG1+EfPGerK4+5g15cG3kWCv
 5I5Y5S4sqU8IRAm4DJj+hAtvfhyq2Thx8151Vdq/HMwd9aV1o4IM/2SYOt8Q5P69qKsX
 a1RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+yOUWvRWgI8EpHmR2Olv2aeDBEKZnhjDyhfX9OV0Xr2uHorYqRt5aMJRUVU35UzePuZnlWjlJ409bQdS5gB3Rnl17kJU=
X-Gm-Message-State: AOJu0Yxb1KGuwU42FAAhBh5gukgkbYSPkvMswIodLMlgtZlO9zCZ1++m
 upY9lrD3A8D4v2DfpZlInC5AM1I8V79O2V7tu2tzq0OcEfnzsjvTnDDEmxGMbtc=
X-Google-Smtp-Source: AGHT+IHhPYNtUtzMtIqiucGegwGEjvJoN3Yh1D1UHZ+TuzqGUHY4WaNls9RECuXBUbY6pB4O6QF28w==
X-Received: by 2002:a50:9fa2:0:b0:572:3eaa:a637 with SMTP id
 4fb4d7f45d1cf-5731d826f71mr1960167a12.2.1715163834703; 
 Wed, 08 May 2024 03:23:54 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 p8-20020aa7c888000000b00572aba0d8a0sm7396683eds.88.2024.05.08.03.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:23:54 -0700 (PDT)
Message-ID: <10ac492b-f848-4ae2-84a9-435f40d22fe7@linaro.org>
Date: Wed, 8 May 2024 12:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] libvhost-user: set msg.msg_control to NULL when
 it is empty
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-2-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 8/5/24 09:44, Stefano Garzarella wrote:
> On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
> the `struct msghdr` has the field `msg_controllen` set to 0, but
> `msg_control` is not NULL.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   subprojects/libvhost-user/libvhost-user.c | 1 +
>   1 file changed, 1 insertion(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



