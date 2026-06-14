Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE51CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 16:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYnMd-00042Q-IK; Sun, 14 Jun 2026 12:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYnMX-0003v1-S1
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYnMV-0001YO-Ii
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781453222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tV6J5gJ9j8+nnh1mDJlr7zCMjsCgwieqrsU10x5lqA=;
 b=d3dxylBrg5x4nFzGW5ov7FJnLF/eAE6KExZUx9mVt1EbVIZ5oTWotQJx9ohqwL8NN78IkL
 B9OSnAC1Xo+olXVmWJZOyMLZqy5M0OZZvY2ULM4N/df5z227Yd32HNM4iSfsZzkUpWi7sU
 mhaSk1BQ0dp1EYS+6+ck3QrasoCy4aE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-LSzA18ggPTSruSHsKAu08g-1; Sun, 14 Jun 2026 12:07:00 -0400
X-MC-Unique: LSzA18ggPTSruSHsKAu08g-1
X-Mimecast-MFC-AGG-ID: LSzA18ggPTSruSHsKAu08g_1781453220
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b9cd54f3so14431365e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781453220; x=1782058020; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2tV6J5gJ9j8+nnh1mDJlr7zCMjsCgwieqrsU10x5lqA=;
 b=i0fgb9vw1H/KQl8S+NV63AFU7cCX5PmsUy1ClurEvoNRW84Hx4nph8Bi0N5SZ+zjD/
 KgL52oniOLETXg7BG2RAkeug0eP1ek3SvNPtayZJD8e4ko5JqDiUKZPWDMm9gSMQ6fO5
 EmNBtZxYNhAS6VqhcEivWpdAwFVtL0djJRorx+sDXys2DK7sM+SWc33tejGscZ2iLHp6
 OZDv836i+ch61/pjDARe3AbJ6OLEt9tkwdPlVkiJ3ipwcphPE/Ni+BqXDtATull+kjFc
 tuFgL4ls9CJnkJAvltXwhwg3CDKK3P/F9zuVFQYp1MRHsRI0ukHGvT08FD3tTvc+KhVE
 SJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453220; x=1782058020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tV6J5gJ9j8+nnh1mDJlr7zCMjsCgwieqrsU10x5lqA=;
 b=LnJz2YhgOKP1KOujqFk7YU6UTtp0vTYXoivIXHeh1eLXIfpWyU+7HGS4FLsUjnmW4P
 UCRshyjh6gqdgweR0Br2q9+wUvTYveke5WTCduobNRjCaupDlAsu0A7lMsyxPtdnBRyY
 G7oQvef3wcTJQWk8xF4tk8WpXW2EDNowirBiFyMrWBE2i1dhzoGWzF+DGr74QEJLaA3k
 nr5Kqcu9sZgutMsxGPS7bdBFrjHqWC2EjmQigfTV/tgQWFvsXlw/3UHnWaW+w4H6iAj9
 brz8J0ELtJ7/IHUPuCVUop6X32TebUaQGTCKKMTyWKfDhNC92y9ljIWcsQAtkTzG6r41
 MZ/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ukJ8ItPu6zBXEMNwZ+6bxXfFhESFgGf+mu8PYLvaUnxO4Fwb5IF6lVGY4lHwgtEPUHI7hgklgHtzT@nongnu.org
X-Gm-Message-State: AOJu0YwEG2vK3G1kx/NNfzycDvOyeJpXYCu4pVxTOEERB8hM+dZGYUjY
 i7sHjmZb37g19CkrFpr7JOwte+AFwIUUvGz/lSCOJBvV4pwBs1WtAxwjGKTqmWfF44n5Vi4Xae/
 bSklV/falatpoKRGhHC6e7FFJrAD+m7SOxF9O6yE9hhc67feHLtEyZwnS
X-Gm-Gg: Acq92OGykrfhFVH44TzujiYC76o8odLGRD4OdrGSX8KUsgEI3T6S4kSkWH1xnBMP+Gf
 ZvmzuoYy/U/tT+g6c/J1QgtroHTNwdTHoMlUxb76NVHmSkP40ox3cK27rraxh/jhlqA9FuxJTnY
 GJl4CG19Gk8HsRcTWwakiUedWKk6sGycc7e9chD9uqe48xSjuDvKq/GLTTyiEIhJa5sCq4sgRUg
 Rs+d4aQC+L45aMYrxTRhwrcCOSi71ALgsCy+hSW40dCu46VD+PVAUHlA3COstlx38HsFEiOz0LP
 2VPLhgQa0yhCfYrD+6TsnU3iAZDmyn5uX6o7Wt4AU6gym9BLHRJ8PueSqfvQxMyCYEQin2cNx3m
 7e7qEpQpYDE54O7CLKnpShiuy6YqgMERMmmxfL06sCek=
X-Received: by 2002:a05:600c:1d99:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-49220061e5bmr86887485e9.13.1781453219663; 
 Sun, 14 Jun 2026 09:06:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1d99:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-49220061e5bmr86887015e9.13.1781453219140; 
 Sun, 14 Jun 2026 09:06:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edc23sm177037195e9.2.2026.06.14.09.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 09:06:58 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:06:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com,
 david@kernel.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, philmd@mailo.com, phrdina@redhat.com,
 jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
Message-ID: <20260614120334-mutt-send-email-mst@kernel.org>
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
 <20260614084004-mutt-send-email-mst@kernel.org>
 <CAFEAcA9ng79Z7ALpqqTZQijCyYSoqMNK1Q5CYR_kcYBW9+wD2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ng79Z7ALpqqTZQijCyYSoqMNK1Q5CYR_kcYBW9+wD2g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jun 14, 2026 at 05:01:34PM +0100, Peter Maydell wrote:
> On Sun, 14 Jun 2026 at 16:13, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 12, 2026 at 10:25:35AM -0700, Richard Henderson wrote:
> > > On 6/12/26 09:36, Peter Maydell wrote:
> > > > On Fri, 12 Jun 2026 at 16:29, Richard Henderson
> > > > <richard.henderson@linaro.org> wrote:
> > > > >
> > > > > On 6/12/26 04:03, Gavin Shan wrote:
> > > > > > This replaces mem{cpy, move} with __builtin_mem{cpy, move} in the memory
> > > > > > accessors to ram device memory region, preparatory work to make ram device
> > > > > > region directly accessible and bypass the bounce buffer in the DMA path
> > > > > > in next patch.
> > > > >
> > > > > memcpy/memmove *always* compile to __builtin_memcpy/memmove, and the compiler later
> > > > > decides whether or not to expand inline.
> > > >
> > > > Yes, but if you pass it a fixed small integer, then it is likely
> > > > to expand it inline, whereas if you pass it a variable then it
> > > > is likely not to... The patch is attempting to persuade the
> > > > compiler to definitely do an inline access for 1, 2, 4, 8
> > > > byte access.
> > >
> > > Sure, for hosts with unaligned accesses.  We still have sparc64 and (some?)
> > > riscv64 that don't automatically have such and will compile to more than one
> > > host instruction.
> > >
> > > > > My real question is: what are you attempting to achieve?
> > > > >
> > > > > (1) is the problem unaligned access to a mapped physical device?
> > > > > (2) is the problem vector access to a mapped physical device?
> > > > > (3) something else?
> > > >
> > > > I think there are two problems we're trying to fix here:
> > > >
> > > > (1) If a device does e.g. a pci_dma_write() with size 1, we want
> > > > this to turn into exactly 1 byte write into guest memory, for the
> > > > normal case where the guest memory is real host RAM.
> > > > This deals with the e1000 bug where the pci_dma_write() turns into
> > > > a call to glibc memmove() with size 1 and glibc's implementation
> > > > turns that into 3 writes of the byte to the same address...
> > >
> > > Gotcha.  Easily handled by not using memcpy/memmove at all.
> > >
> > >       *(char *)ptr = val;
> > >
> > > is sufficient for all hosts.
> >
> > Yes, I think it does work because we use -fno-strict-aliasing.
> > For bigger sizes we'll need packed because the addresses
> > could be unaligned.
> 
> IIRC "packed" will cause architectures that can't do
> unaligned word accesses to emit code to do byte accesses,
> so you don't want that.

I mean, what's left to do if guest wants an unaligned access? Crash?
On classical PCI, unaligned accesses are split up by the bus, so
there's a decent chance most devices will be ok if qemu does it.


> You need to explicitly check alignment,
> I think.
> 
> > But again, qemu simply already relies on this in bswap.h
> >
> > I kind of dislike muddying the waters by making several
> > unrelated changes here. If we do we should change bwap too.
> 
> The ldl_p etc functions in bswap.h provide different semantics:
> ldl_p() is "do a load of a 32-bit quantity, even if the
> address is not 4-aligned". We don't care if the compiler
> or the memcpy ends up doing that as 4 byte accesses, which
> on some hosts it must do.
> 
> thanks
> -- PMM


I mean the ram device ops trick is using bounce buffers precisely
because it happens to give you a single load.
And yes on hosts where it does not work, these devices
won't work, and qemu can't fix that.

-- 
MST


