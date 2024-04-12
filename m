Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7581DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDZK-00050T-0J; Fri, 12 Apr 2024 05:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDZG-0004zq-HV
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:51:34 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDZE-0007fk-1C
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:51:33 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2da01cb187cso9958371fa.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915490; x=1713520290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XDier/PQlGVyNeReFRn3wefMWX91b1CUN/VjbmUf1yM=;
 b=rt+odv6Rtbvssm5B0QBLzCMHgTAugyLyQ3G34H9a+OCRh7BeIHlzY2pE1YNrtjiE9B
 HdVzr2kLCheHkJ2ajNaKo5BKWy1ruuRlpps9l6AH4qjDXDYqsFdzc08dNOpYlsPP55GD
 JHtwf8QJBKr2/YFRLTXE9318yqWefQrHBiHJ4ShNGXy/jYlBx+u4DweNlsvW/PPb710e
 SYtrBq/bx0vAxibf+5MvwZxXghS80yODAPqAAcEJz9JZHXZ4A3//88vc01t7C5IyvPWx
 LkU3tG64xdV9T75EaXxS8/VgtM7y7Vw2LDsND+J2NmnJ0Oqte1qYBwFoSC6e6kFb0Y3P
 Ey7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915490; x=1713520290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XDier/PQlGVyNeReFRn3wefMWX91b1CUN/VjbmUf1yM=;
 b=Cjinli48GtDgnTl4uW9MarNCBqDqN13DryMb/w5Hagvvhse9XBPNtD/wKT8nZoDtue
 UGDykfYUYPN8eDxsfXAAJ0V05pQeXbw1xgTIeCmtkiejFdhvnBf2Er4abJBQnwETwXh6
 oTSbPTRY0pleg34ngGMMtosyqQLSh/805Kac6Lk2BtGcLuxEBDcUQCOwHw/j2SW6IfVW
 Pnxsr5bxCg39JrrQQHGy14XENNdOXzPOFB2Swx8fwgGwxVuNPbujfK1heRxdXb0F2Q6a
 JrqVuW1tIefvbhOv5VNUquDRTgm71T9C3KGCsCIANMaemuBMWyLXjR+5l3MVsLQakc4N
 q+2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTLsDpuh5qIGrgixr9Fi4n1s1ga1AXSzFyuA1ak2xXpPcxSdYGaVTFCrt8CKMp20n+3ILDL5cwfBIunoGCYjuNgMCSIHQ=
X-Gm-Message-State: AOJu0Yyz8rPHaMWmhtDOpg78FgjPOyK8DlEaOZWDlaSsyKmhRvtFzXNI
 BuAR+euIhVuyL56Ezgl65ffXsMeKGwCaqYfq4FxX7DheqT5pJkHGZJhq6s7KjD4=
X-Google-Smtp-Source: AGHT+IHgy4JIfLNm3k+qrnVuti7wjciKjzq8+ByLnCj7qZYzSVtjc9XiXkKwyOSP+JXbDddTVo3eRg==
X-Received: by 2002:a05:651c:623:b0:2da:16fd:5c9b with SMTP id
 k35-20020a05651c062300b002da16fd5c9bmr648317lje.9.1712915489646; 
 Fri, 12 Apr 2024 02:51:29 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c468a00b00416ba2db6b4sm5089040wmo.18.2024.04.12.02.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 02:51:29 -0700 (PDT)
Message-ID: <5569cc14-992e-40de-81a8-88cad244e163@linaro.org>
Date: Fri, 12 Apr 2024 11:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-helpers: Fix iovec alignment
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
References: <20240412080617.1299883-1-sf@sfritsch.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412080617.1299883-1-sf@sfritsch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 12/4/24 10:06, Stefan Fritsch wrote:
> Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to a
> dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
> is now passed the wanted iov length instead of the actually required
> amount that should be removed from the end of the iov.
> 
> The bug can likely only be hit in uncommon configurations, e.g. with
> icount enabled or when reading from disk directly to device memory.
> 
> Fixes: 99868af3d0a75cf6 ("dma-helpers: explicitly pass alignment into DMA helpers")

Cc'ing developers mentioned in this commit.

> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> ---
>   system/dma-helpers.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 9b221cf94e..c9677fd39b 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -174,8 +174,7 @@ static void dma_blk_cb(void *opaque, int ret)
>       }
>   
>       if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
> -        qemu_iovec_discard_back(&dbs->iov,
> -                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
> +        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size % dbs->align);
>       }
>   
>       dbs->acb = dbs->io_func(dbs->offset, &dbs->iov,


