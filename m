Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0253C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 06:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh0TM-0003Sa-MS; Wed, 30 Jul 2025 02:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh0TA-0003K0-Vg
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh0T8-0003Px-Gz
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753857555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FCR3Bx8OYyFfHkBT1v5cyuyyqt0TLXzwBEfzp2DrfzQ=;
 b=iWX3/HHSijo8Q0fdME7j9/TPOgazX4YzOnY7x2eAYPuzhsiLXUhMsez64GBVwD43xc28pG
 cPUS9aE9+iIIhHC5dh3PRyCJFJD0StHvIWyY1mJGM24ZbSbQPjdcb0LHO+OF8AAD8wfhTs
 qeLjur2FaYf+7lA54KhAHSdk/xqXnkc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-ymbV6iHrN-2TAPcO9CMIdA-1; Wed, 30 Jul 2025 02:39:13 -0400
X-MC-Unique: ymbV6iHrN-2TAPcO9CMIdA-1
X-Mimecast-MFC-AGG-ID: ymbV6iHrN-2TAPcO9CMIdA_1753857552
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45626532e27so2654575e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 23:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753857552; x=1754462352;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCR3Bx8OYyFfHkBT1v5cyuyyqt0TLXzwBEfzp2DrfzQ=;
 b=DfvFONYTvsmVhqPlERGKAuJrgB0UtJKCdoFW17LSe+aOGiTwa+jPo7V3E8vRpcecKo
 htzLNXfETuc6C8Z8zIWXxf64GGuplYNiSWdXx+HpyhkS7NIq+EZhV5Ln6RjWXhX5sofX
 dxywVg3zxGHNuDj3G6Og9jFRtpyWpt3tqehqZ7UvMWMXkn8WuRSqQuzo9yZIfJu48H0x
 zC/v/dyo1l8TjyBJH28IQBi90S5qfe/IZlht4qhHKDTs8sYTJJxhKUuO22pOHraVdKQj
 TbnmMZd16hAhWsoIWOFrfLk3ryMHUtHd9teUzc1JhwY5HbCQPsBNpsCduTH3z3x2B5LB
 JhaQ==
X-Gm-Message-State: AOJu0Yze/AzbzbmrWkFzbDgXadY4K17+6fagJhq29SlR85fmCr0DFucd
 xFbJFpjZ6zODE+uAvg2ALpgotX7i9JZOy+OgqrPs36ggb2yLGEatot+NnOvSY59jaJTDLet/z+I
 G7vPYkHtX+KIUEddt++GA/AyQ3kZnpt/gvjI8bQkSYI8pCoRPqoU2IyA/vYevM9f8WUFXme7JFy
 hllf/Itegk71dETPsaRi2jtWpmTWIoTKlQcw==
X-Gm-Gg: ASbGncsnNUQ4/0QUKml0keTcWuO3ZJXoxydbwonBAVNZSGNtuZMjMDuij4lRuooqOrU
 h9ssquWM7I378KOdL3sspRJJ6UySKLg2iI0rNZSwYib4VJ7pAYxYo6OGfioXB0kteCIGVz3MTLf
 9f3f2WXoVg+ptsj6HT8jCeW/TtivLW2Ha1JUXmWlqRPB89GTvfvRumRxcGLVmJHZwM3+CiTf8Zi
 d/dcSs4l3VP2vkR7MI6mfkFdtO7yk4H0kv93SW9EBXWs91osT7sqt7zrRpd233dlQFNeEzlpFwo
 nrMy89l05k/CqpMXPDKcuQCOmsG7BeN+mMA0TBD/MPZjshedf70WuM5LNpDrcR9LWVNyseRC/4d
 i9w==
X-Received: by 2002:a05:600c:3b95:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-45892bc66b0mr15466495e9.22.1753857551899; 
 Tue, 29 Jul 2025 23:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhQSGTGIpO2pl5sZ4BcmwAOzkP7BHoC5ZtszAzbbkGsZBjaRcQfwDEzFEJtBAkTRaRv2EQpg==
X-Received: by 2002:a05:600c:3b95:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-45892bc66b0mr15466195e9.22.1753857551364; 
 Tue, 29 Jul 2025 23:39:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7928dea59sm4010475f8f.67.2025.07.29.23.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 23:39:10 -0700 (PDT)
Message-ID: <676fc03e-df95-4287-b954-af1cc1f5737d@redhat.com>
Date: Wed, 30 Jul 2025 08:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] pc-bios: Update vbootrom images
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250730045813.822132-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250730045813.822132-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe,

On 7/30/25 06:58, Cédric Le Goater wrote:
> Hello !
> 
> Michael provided changes to fix the build of the vbootrom image of the
> AST2700 SoC machine in [1]. However, a workaound in roms/Makefile was
> still necessary to build ast27x0_bootrom.bin correctly. This was later
> fixed in [2].
> 
> This series is an update of [1] including a vbootrom image matching
> the new commits.
> 
> Thanks,
> C.
> 
> [1] https://lore.kernel.org/qemu-devel/2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru/
> [2] https://github.com/google/vbootrom/commit/7b1eb5f7fe6a85a03a1e40aa703a6ebbdb644e31
> 
> 
> Changes in v3:
> 
>   - Updated commit log in patch 3/3
> 
> Changes in v2:
> 
>   - Updated all vbootrom images
> 
> Cédric Le Goater (1):
>    pc-bios: Update vbootrom image to commit 183c9ff8056b
> 
> Michael Tokarev (2):
>    roms/vbootrom: update to 7b1eb5f7fe6a
>    roms/Makefile: build ast27x0_bootrom
> 
>   pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
>   pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 672 bytes
>   pc-bios/npcm8xx_bootrom.bin | Bin 608 -> 672 bytes
>   roms/Makefile               |   5 +++++
>   roms/vbootrom               |   2 +-
>   5 files changed, 6 insertions(+), 1 deletion(-)
> 

is pc-bios your juridiction ?

I think we should pull these changes in for QEMU 10.1.


Thanks,

C.


