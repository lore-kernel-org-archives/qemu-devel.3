Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AE7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJaUr-00030X-IZ; Tue, 18 Jun 2024 11:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJaUp-000300-M8
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJaUo-0006lG-4N
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718723501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=35h/OSBREAg3JXTpXF+5UNCnP6wFFcJeXvbynvah7a8=;
 b=cYFqEICgSkeLnWaYEpz8a3d+NPjDIMj07OqbOF6oZGZEFaqfPuBAmO9UOik4hnwAT3/xXJ
 svZTs0HYX3UNtZtHHUbCs37NZhuvMVdSvFpZhbeOS13tdgtJUrpACMmBdIJLpIxvZ7FhgZ
 n2jPN5k1H5SuzlqgewZBO3NQtTeJPc0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-KxxKrDq6PS6g03tqO8k7Qw-1; Tue, 18 Jun 2024 11:11:38 -0400
X-MC-Unique: KxxKrDq6PS6g03tqO8k7Qw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f2662d050so279878666b.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718723497; x=1719328297;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35h/OSBREAg3JXTpXF+5UNCnP6wFFcJeXvbynvah7a8=;
 b=HClynpK6Zytu+pHD5NeICk6lZB7BbV9NlTW963V6hW/alc9fZkO/xyhz3P1DegQL9+
 6NeYFvi+vpJiOJ510U8/HUWN4Mzz9C+QeLLRoRtfBOCBbb1qArjJvYdAibxp5//3lMPU
 xxVgTis5W/559feC8fmHyFj4bR0fOrQrpKXlNFgh1HezV3IXg1Ht+CLfDgY68ScTfrjY
 N7bLYcurVE3KJjGqasQWPWyV8l++zzoeuMM8CjwH2S7QjsjaDZx5tg301R6sIs+AemrH
 v/lGH31De+pu8rnkb+7XhnfMmOMLpF2ofAWtcr6xMK+o7hcLul1/nGJstZt2IzqpZtq7
 5Fsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKpioLaJwjH1yzfhu8ySviUPuTezpCJFlgqB93WucT12hOP0FaX+akLlHCf65VVhg8ToKxfC7syqbFGpGb3NuLB8oYlQY=
X-Gm-Message-State: AOJu0YwuhH3LFTc2Sv5i5TlOzsDQgKvITfnBlpq3qyzLWDA+WpfFYOGQ
 65P/JOpIUyEE6qm2zJyRsR8GLSCcS2l2lOPZqWK0xEGXR/HiZqmScZI4OxD6ZqkoUO9WIxBm9B+
 CQ4T+bPg5pT+fD0M4JIi6kX3BuYWknldyTboNWL1q10yIpg0PfJfv
X-Received: by 2002:a17:906:c291:b0:a6d:ee51:793b with SMTP id
 a640c23a62f3a-a6f60de1cc1mr682516466b.73.1718723497478; 
 Tue, 18 Jun 2024 08:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqXhLomSTjPlAccWoHQUv+iHLTki61Rpm/BvxVnXuM6Vy1zqiAmWFNp8xLTS2+HtPy6Rssvw==
X-Received: by 2002:a17:906:c291:b0:a6d:ee51:793b with SMTP id
 a640c23a62f3a-a6f60de1cc1mr682514466b.73.1718723497025; 
 Tue, 18 Jun 2024 08:11:37 -0700 (PDT)
Received: from [192.168.1.174] ([151.64.122.141])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da069sm7807558a12.21.2024.06.18.08.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:11:36 -0700 (PDT)
Message-ID: <f6acedfe-b117-4bf7-a89a-45ad1a12c52a@redhat.com>
Date: Tue, 18 Jun 2024 17:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/s390x: Fix tracing header path in TCG
 mem_helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240613104415.9643-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240613104415.9643-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On 6/13/24 12:44, Philippe Mathieu-Daudé wrote:
> In order to keep trace event headers local to their
> directory, introduce s390_skeys_get/s390_skeys_set
> helpers, fixing:
> 
>    In file included from ../../target/s390x/tcg/mem_helper.c:33:
>    ../../target/s390x/tcg/trace.h:1:10: fatal error: 'trace/trace-target_s390x_tcg.h' file not found
>    #include "trace/trace-target_s390x_tcg.h"
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.
>    ninja: build stopped: subcommand failed.
> 
> Philippe Mathieu-Daudé (2):
>    hw/s390x: Introduce s390_skeys_get|set() helpers
>    target/s390x: Use s390_skeys_get|set() helper

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

>   include/hw/s390x/storage-keys.h | 10 ++++++++++
>   hw/s390x/s390-skeys.c           | 27 +++++++++++++++++++++++++++
>   target/s390x/mmu_helper.c       | 11 ++---------
>   target/s390x/tcg/mem_helper.c   | 16 ++++------------
>   hw/s390x/trace-events           |  4 ++++
>   target/s390x/trace-events       |  4 ----
>   6 files changed, 47 insertions(+), 25 deletions(-)
> 


