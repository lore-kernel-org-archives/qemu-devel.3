Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44629C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSut-0008Se-Ik; Wed, 09 Jul 2025 07:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uZSun-0006iB-2q
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:24:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uZSue-0003M9-F5
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:24:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-60c5b7cae8bso8810866a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752060267; x=1752665067;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7DEEw7PLg0TyJTfYNFBJxw2bjY4U88qHl1SOH36jIA=;
 b=DsSYRtMFioj4fVM+LSRPcjr4EKLV5HiwwnoSxp0BOIoNOZq3VI/7psehyfomywMWRv
 /1mmdZYNpj5LQskLNq4g6GBB3ELFNFaOOft15cTGTRRwkJQB5Jvi9hg3NvPcOYrv4CVe
 bQmrAZB7AcJbIm5Mf5/MADyc98UFPalXSyG6M5IArX2RMb25Zgi6IvD/KIf4ca5geV0A
 5nkquJKAf6eoIAXoGRa2p3TawVTJ2a34OMNyj/Uwzl1yoqcqjJbPrIxTV+NCjQH0Cdhn
 uB1rXlzcxzI49494iVHgZT5gcHBCYZaCz15RDxzC+jGfHoz4mY1iFhG9icCvEtfSGdhb
 6TGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDMJ7dKQMgDUaRwRlaCKZzR/7Sn/R0k3j5YODkkfOCdWjGUaHoEXChuPPctYaC2WB8Ib2IB1uUO/E@nongnu.org
X-Gm-Message-State: AOJu0Yw9pUZBTKztRKsZenYL5F+Xv39y6SrGteOxHf2bibup48FJKc4h
 /82cgrFXQgf/+4I2EbMh9mOOFEmiBvvqcp5nVVcqMntKzKCEcz+3YJ+4
X-Gm-Gg: ASbGncv6ACg261XTPdMnKV35bUFQgqbbQbMBQBNbyUnty93pIaY8BW1azN7EWbhOPHo
 e0bSnTKNDPNVdFMWjZKQRa4VdhLNc88T9RoSYyhWQybK7v3tgX9NvFLtfe8rrY0Zf3NayLRN45N
 5ox0592X67PU8jlMd4AgKGSiigAVsFKRgZ3WrP+fdajSQYucWjuPQ2777PnST/kLqKLfd1HrTJ1
 m9EC7qUeaXluJCZwkZaC9gPYjqwThMm3XNpXGumt4U0V+eRQv/M2SNNua9J+f7Xcw3n+tlLaZIB
 YtEgukPKeinkOH2G2tESp7UaaeqYo6nMshjpG71KUG8/dX2/ob49UuB0CM5ph+jfdVT+cCly473
 IDyLcRclhMT0R2SHzng==
X-Google-Smtp-Source: AGHT+IFmbJB7ZbjlAm6UD4nuKWfGsse/WE1IfG2Ftdk++OEAFaTDGhyS/hanx2ohAFOYFCt0PIOL6g==
X-Received: by 2002:a05:6402:35c9:b0:607:eeb1:b18b with SMTP id
 4fb4d7f45d1cf-611a65b78b7mr1751182a12.8.1752060266925; 
 Wed, 09 Jul 2025 04:24:26 -0700 (PDT)
Received: from [192.168.88.252] (37-48-10-116.nat.epc.tmcz.cz. [37.48.10.116])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fca667676sm8723928a12.7.2025.07.09.04.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:24:26 -0700 (PDT)
Message-ID: <30112881-1b5f-45d2-88af-3bfd2259fca0@ovn.org>
Date: Wed, 9 Jul 2025 13:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v4 1/3] net/af-xdp: Remove XDP program cleanup logic
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250704130531.144325-1-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250704130531.144325-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ed1-f66.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.039, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 7/4/25 3:05 PM, Daniel Borkmann wrote:
> There are two issues with the XDP program removal in af_xdp_cleanup():
> 
> 1) Starting from libxdp 1.3.0 [0] the XDP program gets automatically
>    detached when we call xsk_socket__delete() for the last successfully
>    configured queue. libxdp internally keeps track of that. For QEMU
>    we require libxdp >= 1.4.0. Given QEMU is not loading the program,
>    lets also not attempt to remove it and delegate this instead.
> 
> 2) The removal logic is incorrect anyway because we are setting n_queues
>    into the last queue that never has xdp_flags on failure, so the logic
>    is always skipped since the non-zero test for s->xdp_flags in
>    af_xdp_cleanup() fails.
> 
> Fixes: cb039ef3d9e3 ("net: add initial support for AF_XDP network backend")
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> Link: https://github.com/xdp-project/xdp-tools/commit/38c2914988fd5c1ef65f2381fc8af9f3e8404e2b [0]
> ---

Thanks!

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

