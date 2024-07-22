Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BC1C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnMj-0000KZ-Ps; Mon, 22 Jul 2024 03:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnMY-00081v-4m
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:21:48 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnMU-0001nm-Dl
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:21:37 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ee9b098bd5so51192501fa.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721632892; x=1722237692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L959gQkKHzT2yFVD1TeungvelhYqH/H97IsYdwUNdf0=;
 b=mAqv5/n++UbCoEJ8p0dgq75LH0Jp1l0XCDhEPcW5gBBxA6mFsGdeTeBImyE+F/IoWP
 wc7KAOuWapyvgWaFd2TWyBSgbG5WYilrbw46nuFrAAhaPYluQ8ugpg80sylZ8b+N/F6y
 /bI6cxw9gpJQsw80JvZEF/z9PDGWEMSNPKQI4Mfsqhk8WjYk00i1LDaYoj865X5u23t9
 DF+3cKes/wHznHBC/5tfZ+TXQMrjP36VufVVaE2+OI+2SbUl9gz2wuvZHmUSkXO8HIFx
 xdEf9tieQpQv8yhUc+Qz7tA9CvPbXNZmONCN1JxZGc68v9zVNU/AfoAbp3p0gxM6KJhJ
 izXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721632892; x=1722237692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L959gQkKHzT2yFVD1TeungvelhYqH/H97IsYdwUNdf0=;
 b=dsAhXxNVVrf+Y3wSR4+2JU4RGltVXITxKMtUWc/HHuUbA5xjV7aD5A/nuc7JCu4Als
 Y9tm1J2cEkrw8EXozD+H5i/6FUEu6ci2IWrk194dtWGqmSGIHq/V5VEM7P9hNPk7//Te
 Mxay/Q6BeTxlYRPTIbI0dez6TUiturg6XmDoiaRC5X19F8B8tNLzov7swhjMrJNV5fYk
 BBMXOhd5oxye6bvgm6cwQrVIY136GiRiSF6kC/MLIvDsj1ba+WMZsTDRDgEcdVdP8Pg9
 va0zTQ4dPXkxgAVeXYlOShyFU4r5UVFnkNFDIwtOl0F7HKVp0I/C0QHaMOBhWg4omZeh
 V47Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMNWW8OvqK0MOsqYZ4406JpvJ38pqPpF2zEit+sdh1d8VLMx+AH1Bey6K+KiD2kwxboT7KFWoYY3jST/Lift4eXvnAjmY=
X-Gm-Message-State: AOJu0YxZZ+JJwCNGGba0HW/J9/VHn7LbBtg+xIgnMdRjyglgPpjhNG0d
 JJZdhfPyMNugQQCspGdg4iTGpl+XOxjeivhIOc99R6rQkqQrozZ5/WclC7K0gWY=
X-Google-Smtp-Source: AGHT+IEkuW80s85wYfwgwjXqNJhH7fYDWeBdkAn9Rlg0ahXuM48vA4wZC6A3XlTH+WR/hvPed/yjUQ==
X-Received: by 2002:a05:651c:4ca:b0:2ee:5ec1:1838 with SMTP id
 38308e7fff4ca-2ef16849b98mr46532601fa.30.1721632891709; 
 Mon, 22 Jul 2024 00:21:31 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6901781sm115247645e9.14.2024.07.22.00.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 00:21:31 -0700 (PDT)
Message-ID: <6a2662a3-aabb-4d06-b9ae-aa9e25627623@linaro.org>
Date: Mon, 22 Jul 2024 09:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] system/memory_mapping: make range overlap check
 more readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-10-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-10-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 22/7/24 06:07, Yao Xingtao wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   system/memory_mapping.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/system/memory_mapping.c b/system/memory_mapping.c
> index 6f884c5b90c9..ca2390eb8044 100644
> --- a/system/memory_mapping.c
> +++ b/system/memory_mapping.c
> @@ -12,6 +12,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/range.h"
>   #include "qapi/error.h"
>   
>   #include "sysemu/memory_mapping.h"
> @@ -353,8 +354,7 @@ void memory_mapping_filter(MemoryMappingList *list, int64_t begin,
>       MemoryMapping *cur, *next;
>   
>       QTAILQ_FOREACH_SAFE(cur, &list->head, next, next) {
> -        if (cur->phys_addr >= begin + length ||
> -            cur->phys_addr + cur->length <= begin) {
> +        if (!ranges_overlap(cur->phys_addr, cur->length, begin, length)) {

Maybe this one is easier to read the other way around:

      if (!ranges_overlap(begin, length, cur->phys_addr, cur->length)) {

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

