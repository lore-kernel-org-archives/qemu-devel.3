Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93CBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eJA-0005FO-Vj; Wed, 08 May 2024 06:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eJ0-0005Dw-RS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:13:51 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eIx-0005ZV-3R
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:13:45 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so54403081fa.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163221; x=1715768021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RapXxqNPK4nzEyPe0A1pG4r6EOpJJ6RcJSFPJ5dlVGE=;
 b=w4liyd53xjX4OhRXo+Mf3G0FZkQg365TrEBGV4RlcX8vQ25pdtn8YYLXUndd5D2dst
 tPed0ybnm/Nmhf+4s+NuAv5UxLqpxwqKGA2k9FRSeispbmct4k4aXk/PdFDbEMTcU8Os
 R7dfa9JMNBqTem2Br2Q8RNcTDcWElK9EnSflQHQE1E6+26I/F9PY9E1ngC8IJjRXRW1E
 kvswfIJzimkNMO1qjZW/IwPMtB7jW/YjzN3TTJ5GIt5kmL4SCgTJJJjFI6TDEqdtCRMu
 uFlfna9nT2RHIiEDmGyFLbzUc3YQXN+YWaS1NHQnoaDjHerSncVTmXdgomM1fWcljK4K
 bOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163221; x=1715768021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RapXxqNPK4nzEyPe0A1pG4r6EOpJJ6RcJSFPJ5dlVGE=;
 b=MCZl/RMg0kJNjen0UrRVlLC5k2lx6tr5/u5XSDlUo6dXp5gJkjFjoqbcIvwz5EHD3j
 qXQdS+K8nH8VKyWv3URKYk1s33/Ck+YrpMjPnH6krv616nuy6X0oWv6TaGnJjODbMaKz
 zT8o3dsoF1cYwyuwHdW/w9cxRPNbw5th6I06l2sWOi4rEUQ1FqlGO+pO8rCf9GscDWMz
 hAuvgawNq0Iro+m+0u8JyBeRtYkZv57mIhbF3A04ElEq+YgZ8Kodo3hTjOtmPiLWMDC8
 WhFYx52KT+zHGM3FhqGJ1xiJG+5JYlGUo9l2SsTGmKOzPvBRNdMnO+Esyf0f9Q/u4xep
 XKEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlEPUSrJDN3ZCBKi9UoI7DAfEJ2tGxnG7cr+q1osaC1VgHrjughHaGVvuoZDXZgBd9tYy25SqRBCo8yIB8je/GzXHPO3I=
X-Gm-Message-State: AOJu0YxuJf6WRPQsadZfRcVrFQVleWiOyhouLqBFkU3wILN3oYRQtvIG
 Yzdqm4InVRwTr+KrKly+HOXphX5azy4BrYMYPsfiXHnDuMjVhnUxMvu3Gjmnogw=
X-Google-Smtp-Source: AGHT+IGHNllDqS5hi5TGA4McjU1rp0e67egaUE9JYmj1cI7LEcaYt4IvuieQcmobF7Imoxns/Hnxxg==
X-Received: by 2002:ac2:4288:0:b0:51f:40f4:c6aa with SMTP id
 2adb3069b0e04-5217cf3b177mr1268596e87.68.1715163220587; 
 Wed, 08 May 2024 03:13:40 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 g13-20020a056402114d00b00572aadbf4absm7382974edw.28.2024.05.08.03.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:13:40 -0700 (PDT)
Message-ID: <d69b52ef-d801-47b2-9095-4c830cc58386@linaro.org>
Date: Wed, 8 May 2024 12:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] contrib/vhost-user-*: use QEMU bswap helper
 functions
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
 <20240508074457.12367-7-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-7-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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
> Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
> helpers to make the code more portable.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   contrib/vhost-user-blk/vhost-user-blk.c |  9 +++++----
>   contrib/vhost-user-input/main.c         | 16 ++++++++--------
>   2 files changed, 13 insertions(+), 12 deletions(-)

Thanks,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


