Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F243CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFadr-00061z-6L; Thu, 15 May 2025 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFadi-0005lw-VX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFadd-00058V-Lh
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747323407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xo90fpAIkimm/Nl4MRPrryRR+X2DxmGXk7jkcCIIlP8=;
 b=McnOMDGD9U7xCsC271AYjjNMWLtAz1kDEo7uKKX5lp0sc6334N21r091mIcvpGnnKJvADe
 iwWhtc/OWrKW0Jm41sYDEY9XNL4rsaEp4YgL5wwAMTL4OQAZ4BSXa4/P7dDCHl0TEjflJa
 kmvJEXLyTG3LOQh2vAen5nbxi7tQr20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-TMisMl7eN428dIMR6XWb-g-1; Thu, 15 May 2025 11:36:45 -0400
X-MC-Unique: TMisMl7eN428dIMR6XWb-g-1
X-Mimecast-MFC-AGG-ID: TMisMl7eN428dIMR6XWb-g_1747323404
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso8897025e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 08:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747323404; x=1747928204;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xo90fpAIkimm/Nl4MRPrryRR+X2DxmGXk7jkcCIIlP8=;
 b=SioBqux893hRpUMQO3WV+0EkNGviJItqJTWLuuSJFVNIiJmroQJfYf4qHmJ6uKyP1N
 Rf2imANeBrOmnafRzx1hCaVbO1W6otIAnoebwe+0z6WKhF1++C4SW1ziXKk6V8uH3vPi
 Vz5oWvs0akIWKrzYCLWsSBwxmh1EVtYMNUA/w540Q/BvVwpr4hW8hMdp3/I7523QDE8t
 n0nUWGxGvkGbT5jI+lyIAOToSYs4TCw3WgM1EBQpXMGico6xr0tiwyv9VhmsikbvFoah
 J7Go6cysyHtef9vOQwZ6+4CRcKq/ivFtmZFqyhE1y0JNqqPeovbP6EK8gI/L1RXhIGx2
 TGww==
X-Gm-Message-State: AOJu0Yz+3LS0PylwmdbHdDjAwPFX7ttxPrI5QVn+CW/btLef3cSxTW8p
 0GGmDnrZiG0g+Lqf1+XYxfR9wvn1AWl1FFULa5qvtrHQy9vbFCHh3C+DgI4IKqDGMD1oa/RcDlQ
 DjUJ5h8alIzRgJ1tJ3bjfbg1PczndhzIJ7YON6hazap9y8hRpc7+g
X-Gm-Gg: ASbGnctQa34h1alS3DNf1wAlPvh+VNHVZs2gFlDmkJ/yPUKUOfXVRUPIBP4KiVFXp20
 Jkl3w3YV9tk6aiS3lEfojlzeZvrCauQeSyiRGGAv0zPYOI4WNTUPQ4g9nNRKYjBrJzLbjrfKI7p
 mtNJrRsFSlUKwjrgkcDbvFHO0pqV4aI+xhvGLnicJ9zlsb8ZxfocQskhyPAwWYM/cJeJ2m5x2K+
 UKw3XX0zR7euHYNlpp4jBT6yNsgdnTNLSN37vPYc6btER0KwSw3mP7V/5CRKZozdXoY/OzxhyfQ
 TyROVayf18BFlmT7R3bbqfQgYDsg8o/OwbI1YXlO2f295ZEOWg==
X-Received: by 2002:a05:600c:c0f:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-442f2179271mr92908195e9.30.1747323404345; 
 Thu, 15 May 2025 08:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZwj4P1Pd2ylWQ9p5QSN36Dr9Sw+b+Jukb1l6M22uT09eoRmUmtRK6nK/uC32Jug3vY5qLtQ==
X-Received: by 2002:a05:600c:c0f:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-442f2179271mr92907845e9.30.1747323403913; 
 Thu, 15 May 2025 08:36:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e84d3sm78582555e9.32.2025.05.15.08.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 08:36:43 -0700 (PDT)
Message-ID: <b192697a-f936-450d-8e19-6cb364b7e747@redhat.com>
Date: Thu, 15 May 2025 17:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/50] ppc/xive: updates for PowerVM
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/25 05:10, Nicholas Piggin wrote:
> These changes gets the powernv xive2 to the point it is able to run
> PowerVM with good stability.
> 
> * Various bug fixes around lost interrupts particularly.
> * Major group interrupt work, in particular around redistributing
>    interrupts. Upstream group support is not in a complete or usable
>    state as it is.
> * Significant context push/pull improvements, particularly pool and
>    phys context handling was quite incomplete beyond trivial OPAL
>    case that pushes at boot.
> * Improved tracing and checking for unimp and guest error situations.
> * Various other missing feature support.
> 
> The ordering and grouping of patches in the series is not perfect,
> because it had been an ongoing development, and PowerVM only started
> to become stable toward the end. I did try to rearrange and improve
> things, but some were not worth rebasing cost (e.g., some of the
> pool/phys pull redistribution patches should have ideally been squashed
> or moved together), so please bear that in mind.  Suggestions for
> further rearranging the series are fine, but I might just find they are
> too much effort to be worthwhile.
> 
> Thanks,
> Nick
> 
> Glenn Miles (12):
>    ppc/xive2: Fix calculation of END queue sizes
>    ppc/xive2: Use fair irq target search algorithm
>    ppc/xive2: Fix irq preempted by lower priority group irq
>    ppc/xive2: Fix treatment of PIPR in CPPR update
>    pnv/xive2: Support ESB Escalation
>    ppc/xive2: add interrupt priority configuration flags
>    ppc/xive2: Support redistribution of group interrupts
>    ppc/xive: Add more interrupt notification tracing
>    ppc/xive2: Improve pool regs variable name
>    ppc/xive2: Implement "Ack OS IRQ to even report line" TIMA op
>    ppc/xive2: Redistribute group interrupt precluded by CPPR update
>    ppc/xive2: redistribute irqs for pool and phys ctx pull
> 
> Michael Kowal (4):
>    ppc/xive2: Remote VSDs need to match on forwarding address
>    ppc/xive2: Reset Generation Flipped bit on END Cache Watch
>    pnv/xive2: Print value in invalid register write logging
>    pnv/xive2: Permit valid writes to VC/PC Flush Control registers
> 
> Nicholas Piggin (34):
>    ppc/xive: Fix xive trace event output
>    ppc/xive: Report access size in XIVE TM operation error logs
>    ppc/xive2: fix context push calculation of IPB priority
>    ppc/xive: Fix PHYS NSR ring matching
>    ppc/xive2: Do not present group interrupt on OS-push if precluded by
>      CPPR
>    ppc/xive2: Set CPPR delivery should account for group priority
>    ppc/xive: tctx_notify should clear the precluded interrupt
>    ppc/xive: Explicitly zero NSR after accepting
>    ppc/xive: Move NSR decoding into helper functions
>    ppc/xive: Fix pulling pool and phys contexts
>    pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back WATCH_FULL
>    ppc/xive: Change presenter .match_nvt to match not present
>    ppc/xive2: Redistribute group interrupt preempted by higher priority
>      interrupt
>    ppc/xive: Add xive_tctx_pipr_present() to present new interrupt
>    ppc/xive: Fix high prio group interrupt being preempted by low prio VP
>    ppc/xive: Split xive recompute from IPB function
>    ppc/xive: tctx signaling registers rework
>    ppc/xive: tctx_accept only lower irq line if an interrupt was
>      presented
>    ppc/xive: Add xive_tctx_pipr_set() helper function
>    ppc/xive2: split tctx presentation processing from set CPPR
>    ppc/xive2: Consolidate presentation processing in context push
>    ppc/xive2: Avoid needless interrupt re-check on CPPR set
>    ppc/xive: Assert group interrupts were redistributed
>    ppc/xive2: implement NVP context save restore for POOL ring
>    ppc/xive2: Prevent pulling of pool context losing phys interrupt
>    ppc/xive: Redistribute phys after pulling of pool context
>    ppc/xive: Check TIMA operations validity
>    ppc/xive2: Implement pool context push TIMA op
>    ppc/xive2: redistribute group interrupts on context push
>    ppc/xive2: Implement set_os_pending TIMA op
>    ppc/xive2: Implement POOL LGS push TIMA op
>    ppc/xive2: Implement PHYS ring VP push TIMA op
>    ppc/xive: Split need_resend into restore_nvp
>    ppc/xive2: Enable lower level contexts on VP push
> 
>   hw/intc/pnv_xive.c          |  16 +-
>   hw/intc/pnv_xive2.c         | 139 +++++--
>   hw/intc/pnv_xive2_regs.h    |   1 +
>   hw/intc/spapr_xive.c        |  18 +-
>   hw/intc/trace-events        |  12 +-
>   hw/intc/xive.c              | 555 ++++++++++++++++++----------
>   hw/intc/xive2.c             | 717 +++++++++++++++++++++++++++---------
>   hw/ppc/pnv.c                |  48 +--
>   hw/ppc/spapr.c              |  21 +-
>   include/hw/ppc/xive.h       |  66 +++-
>   include/hw/ppc/xive2.h      |  22 +-
>   include/hw/ppc/xive2_regs.h |  22 +-
>   12 files changed, 1145 insertions(+), 492 deletions(-)
> 

I am impressed :) and glad that you are still taking care of XIVE.

I suggest adding new names under the XIVE entry in the MAINTAINERS file.

Thanks,

C.





