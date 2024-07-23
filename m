Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B76C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGU-0000tL-Ht; Tue, 23 Jul 2024 07:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWDGS-0000ks-NR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:04 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWDGP-000332-9p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:04 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39865a15900so15681125ab.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721732459; x=1722337259;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7oYekwrsm0s7AYsG1ymP5bGyHZZrBevBZt2zTacMEA=;
 b=H1hIR7D/6J8vAqKo+sSfFDL3xNAdCgce8KztfJLI5/J5bgez8C2kn+10/C4DrdHGK0
 5HusHDet9rK7pfge1zmUT3EoV6lM1xky+DeJM7kIzKdDs/VZyFSrD2tJTYz4flSVeRjg
 uGphxQbHlyPCrzuftwYXNk2i8UG9q3+EO+mhPR1sy1BgfYdTxxqAvE/zMraLnQG+y//J
 2jx6IGsYQvS/icc8K61IXGaRsWNz91LyqFmywjpM9MwuwOx82tyxNX7SyEj7TzA7EI6e
 qj6KpcOfUqdqn6jBOOR0Y3nBgAci0mpCDN0oDavgcNz4e5/VtWuKtLbNOW1d+tR5xKdg
 IAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732459; x=1722337259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7oYekwrsm0s7AYsG1ymP5bGyHZZrBevBZt2zTacMEA=;
 b=PmTg6GFGnz8uz9XrXgJG1TVrJSknNz4F3OiOfaFnkO/iyLbZyBNJg9TYwBVLEBw9YL
 VA5FLyoWOjec8K5L1iTtuiBVKb5LRc9r7E/W2qlO0jsxPxTiEUlVQZV4VowzjIXUm9d8
 CCNw0iLyScCTB2X6ySTfLxG5Bao/KCBJa7hQrdpPWffbYTVinKv+KnPWGpGxaSxh68HX
 +IYMpvtjloo8k3DY0tyPIHuacFpupgJnYJxixlygXkFvnSBETK5eCweG4dgSpVEAOE6q
 x69piQprUeVl7zpdhwY7s3Sh0EKqNHLevNQd3/Pw4IVURMtVbFewve5qG+CsoCCgcI1R
 ALMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ebg5E/aTapABgkfEppteyfwOafaXIi4dtJADo3eSyu8Zn3GQZsp9Q34hMiIlPho622Ta6hn7yRXi1FGkpnKnuIfTU/Q=
X-Gm-Message-State: AOJu0YyaFtytHXa9AEIh3/aK3AxKBur7X5Cu2gLMqBH2uSaSAs5F/OFK
 /0bdIJhuxEKSclMGXU4GcW4fA2/qXmJaeKVZoEYD0qG9FPVJ71vu34ijsd5B98o=
X-Google-Smtp-Source: AGHT+IGDqOITXCXMojAgHySWuu1lfiTIBIirKV9uz+IBypG7ZeXItQwycTsrvknJkg5UsVzz3EJUZw==
X-Received: by 2002:a92:ca48:0:b0:375:a282:c96b with SMTP id
 e9e14a558f8ab-39a0c94995cmr27625415ab.27.1721732459599; 
 Tue, 23 Jul 2024 04:00:59 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff59fcb3sm6960459b3a.176.2024.07.23.04.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 04:00:59 -0700 (PDT)
Message-ID: <a034545a-287e-4320-8bb3-57937f431cbe@daynix.com>
Date: Tue, 23 Jul 2024 20:00:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 34/61] virtio-net: Implement SR-IOV VF
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1721731723.git.mst@redhat.com>
 <c2d6db6a1f39780b24538440091893f9fbe060a7.1721731723.git.mst@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <c2d6db6a1f39780b24538440091893f9fbe060a7.1721731723.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/23 19:58, Michael S. Tsirkin wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> A virtio-net device can be added as a SR-IOV VF to another virtio-pci
> device that will be the PF.

This does not work without patch "hw/pci: Do not add ROM BAR for SR-IOV 
VF" because virtio-net-pci has a ROM file. Sorry, I should have noted that.

Regards,
Akihiko Odaki

