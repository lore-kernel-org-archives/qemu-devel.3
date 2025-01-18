Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE280C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 09:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ5bK-0001wP-0Y; Sat, 18 Jan 2025 04:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5bI-0001w7-JT
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 04:58:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5bG-000744-Dh
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 04:58:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2167141dfa1so52933425ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737194321; x=1737799121;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HHmMhSLg3PnUO+1M56Qwm+8Zddrq6Jx57c1V+UQh3Do=;
 b=Hkl46OQcQfAhvn/aobWgsdjh/VZFv+S5mcTYH3mS66vZXEtfptkOTSlVUfN9LqYhEB
 +6ScXrQrAAHYXfqE2+9lEqJPsq2gc9jLn4fQooEiqD/fKrt21BcWEcZQzjT1X0IFLgfN
 aQn3n8e8NbqZxvprN3FqERd/uNym1LUJM6igtuJsldrKbXKAtjKUuovLPzvHBmzFyTDl
 4jqAEWXwmRF+pbySaGdhYyHIuZqMI3qn0jsyUAld1NWnkhmrl04lDOWCGns9528mvSZx
 zcWaSWfj+EL9qX23yCZmfReaw16dVryL3WlY9HLVCSEshj41M1LMsFzEZnEf5oU75dV0
 Q3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737194321; x=1737799121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHmMhSLg3PnUO+1M56Qwm+8Zddrq6Jx57c1V+UQh3Do=;
 b=Jmx3Pm33O0crI6wNANl6hoTf2DsNDGMfVKJUhssh4HK/qpGzJ5bJGNJqWgwhkgavx7
 ifdF/qOWr+ROY207ZjG/c4eRWsL/7bqKPA2aF+HelCWRestos7s88ZKXrXGylQlSh8LG
 C28BOYQT/tWCwt1SSGdgxqZtAWfWcZ6EPTlA9ShdtJk75fP767scxSKPAuF9Rn0lX/ud
 PbDyjXZyjAdee10vnT16D7Oro94nl/7Nw9rf/uzRt3qYaoMwKJmRSF7os6CkgMmIeVjD
 w4QxxE10KOoOgt8aj0QJFCmr4J8FwAJDyZUyzwyx2C/IhdGfewF+u8fvmx1uUkeY1lEQ
 1Mpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuuT9oVDQ0V12Bz3fRsdTbcDJ7MHtD4fP7w+mEu5/176hnBlRfPG79V4l/CTCOLE1mI95mTmBbqn/a@nongnu.org
X-Gm-Message-State: AOJu0YzPsIZ3i3eGuRj3yqU0pIuhEUdiQ3pB6SAnknYHPspmqXWeXqh9
 gy/T0/1bdKi3kNGv1+ZSJUScWGnpt7bvkHTjQDezpnud5z/BsnEbrRXe9DRmMV8=
X-Gm-Gg: ASbGncu/xOA1prW2+WqTrbA0uBuNoz+JWhU44ewI/5e0+Zo25JA7MfU0MyCB6+2ooWZ
 DXMdLiyt9Fxw2aFw9Mnd2R9JjJAc3VcJ4cqZciJX1K7CEJYEOPPI9t2mQAutV0z5KOk0CvXB4f/
 gjthOlMdHWNYnEgEK3iddshWUGw9JUI42hanSuBVN9aPaYkOGqjKchvovOw9SI4FrZQaeOpJlkD
 3oX2NTbJab66ocTquGCdQmxnK2ZlF+r0stUOxfWaWo/shs8T0acBeAqpC79zAHbvuJrDj8Wngbc
 CYQ=
X-Google-Smtp-Source: AGHT+IFekeI4l72SGbY9C/xuxiQuE6B/4DOh1mZXUrEGh6Z8JdJ3uaYKCyRzSHLYMaAmZFBTUlDz8A==
X-Received: by 2002:a17:902:ce11:b0:216:11cf:790 with SMTP id
 d9443c01a7336-21bf0cbe70amr233209025ad.16.1737194320783; 
 Sat, 18 Jan 2025 01:58:40 -0800 (PST)
Received: from [10.4.77.176] ([118.103.63.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceb9e7dsm28706935ad.77.2025.01.18.01.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 01:58:40 -0800 (PST)
Message-ID: <2fe1d8ef-dbd0-442e-8657-387b5aa00712@daynix.com>
Date: Sat, 18 Jan 2025 18:58:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] qtest/libqos/pci: pci and msix fixes
To: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>
Cc: John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20250117172244.406206-1-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117172244.406206-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/18 2:22, Nicholas Piggin wrote:
> Since v2:
> 
> The e1000e|igb series got decoupled from this one and split into
> its own series.

Thank you for working on e1000e/igb. I appreciate fixes for interrupt 
throttling you added with the new version.

> 
> Patch 4 was added.

For this series,
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    qtest/libqos/pci: Do not write to PBA memory
>    qtest/libqos/pci: Enforce balanced iomap/unmap
>    qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
>    qtest/libqos/pci: Factor msix entry helpers into pci common code
> 
>   tests/qtest/libqos/ahci.h       |   1 +
>   tests/qtest/libqos/pci.h        |   6 ++
>   tests/qtest/libqos/virtio-pci.h |   1 +
>   tests/qtest/ahci-test.c         |   2 +
>   tests/qtest/libqos/ahci.c       |   6 ++
>   tests/qtest/libqos/pci.c        | 127 +++++++++++++++++++++++++++++---
>   tests/qtest/libqos/virtio-pci.c |  54 +++-----------
>   7 files changed, 144 insertions(+), 53 deletions(-)
> 


