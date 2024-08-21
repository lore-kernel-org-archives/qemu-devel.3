Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40890C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 18:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgq0T-0001Sq-Gz; Wed, 21 Aug 2024 14:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgq0Q-0001S9-8S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 14:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgq0N-0004gc-Hn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 14:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724264660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXSQkXMtbjixvJOf1WLHqI9f4S19WJ/SZeidf1RjkEQ=;
 b=BIXGVjkbsB9DnGQMc928IC5Qe/ZKcEu04dPW37lyNWjGNwhalEikDEwmizYTL0PZ+HRSaj
 pwLsee3F17CgGSKtIytz4kQdP4qX7BqReCH13+5Mz4mjDoIRdEPMhSB+1+nVo7hSBmeTsc
 4/8RFqJgexw1s96yDuYHJWRaQ76iouY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-MRCRNcZKPamF_rdcz-_ZGw-1; Wed, 21 Aug 2024 14:24:11 -0400
X-MC-Unique: MRCRNcZKPamF_rdcz-_ZGw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bf7ad66ab7so20929546d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 11:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724264651; x=1724869451;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXSQkXMtbjixvJOf1WLHqI9f4S19WJ/SZeidf1RjkEQ=;
 b=KxowieW9/Rle4Rz0h1u2xPAbSQbj9+4wlEv3t+c/2XrPaoWsGh8bCsh0hPuVOhOcDY
 tdTlBWtaPI8k5rbPFqmBrPBjkmZ89oTxxbBGwBJORwe9Fg56cQsohvqRIlfsul+Eshlt
 UXJelItzpR+GAKT3+LdSFXUr0S6IPm0Vb+xWf6PedgSPVAhJEzJHu+Ugwws5rQrrn59W
 PSejbqNxKCUT6uZ8rA3XUMV7h/SL1NABabhFHHBtGBBgRmJapI0/SuYcgpbpDF6o7XfJ
 6US3jPW8kZlWS8rBEUOZBUIWnEJng4qABf3AfJjFCQZsc9rSurxtcclXA5Ntin9E5pp/
 CIpA==
X-Gm-Message-State: AOJu0Yzy+D1fQOdlIK45d3+oGbmP5Nyw0DwWKBHWL2CvyAyhgxi63O2m
 K4bgG2Qv/C1lB1tbRjPjkJaM6gxmHBC9J//ERSgBrRsiKDzLEfVxWN2SIG+fKxDqfsRqW6jRvGL
 jfquypygfUVaHS1zv/Lke8B7840Rm+8hzq24vhwgNMHuGM9TF1SB7
X-Received: by 2002:a05:6214:3b81:b0:6bf:7d61:8b72 with SMTP id
 6a1803df08f44-6c160c588d9mr7154106d6.11.1724264651015; 
 Wed, 21 Aug 2024 11:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCXXkJ32NpfMo3d8xzfLGawKBJyVIThp+KDpxuAEPDj7wvoczwtz7NaEV4VN2E7mcTNP4tg==
X-Received: by 2002:a05:6214:3b81:b0:6bf:7d61:8b72 with SMTP id
 6a1803df08f44-6c160c588d9mr7153726d6.11.1724264650639; 
 Wed, 21 Aug 2024 11:24:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fdd9368sm64073366d6.6.2024.08.21.11.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 11:24:10 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:24:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 stefanha@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
Message-ID: <ZsYwxw6kYpcxYKg8@x1n>
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819135455.2957406-1-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
> This patch is split out from my "Support message-based DMA in vfio-user server"
> series. With the series having been partially applied, I'm splitting this one
> out as the only remaining patch to system emulation code in the hope to
> simplify getting it landed. The code has previously been reviewed by Stefan
> Hajnoczi and Peter Xu. This latest version includes changes to switch the
> bounce buffer size bookkeeping to `size_t` as requested and LGTM'd by Phil in
> v9.

+Peter Maydell.

I'll tentatively collect this in my next 9.2 pull, should be at least in
1-2 weeks.

Thanks,

-- 
Peter Xu


