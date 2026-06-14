Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBFECD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 16:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYnWe-0006uY-07; Sun, 14 Jun 2026 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYnWS-0006tu-WB
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYnWR-0003OD-4c
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781453837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QSMSvAqbR9wwm5YoQ0XfcdzQLhb63Va6CvOS08FE+gk=;
 b=dK4lbtdnceAIO5V5b4WwB/EReTZIq35yG0OEpkQtJL1s85JdwHxo0gf90FnA399jEtge8B
 eJHv9Z7cGq2oe+7Fxud56TqY/6FkEVQaCXVu48vfSMv8KHkGBrytFyCe0pXe8XRgYwy9Ux
 EwhYo4ptS33PUvcCeYs0mdiPD0B7L7k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-V8tD95W_OQCO5AmwaLdEzg-1; Sun, 14 Jun 2026 12:17:16 -0400
X-MC-Unique: V8tD95W_OQCO5AmwaLdEzg-1
X-Mimecast-MFC-AGG-ID: V8tD95W_OQCO5AmwaLdEzg_1781453835
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efb6e60e4so2230852f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781453835; x=1782058635; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QSMSvAqbR9wwm5YoQ0XfcdzQLhb63Va6CvOS08FE+gk=;
 b=Z451lULCO61dESIHPdFeLXGwvBDlHHw5o4Kj08BmQCbNq6hSCwD3xnA+o4AR+6wp9X
 mt6wXTptSHgIOaE+swumJvai4sPJJxk8hkNgNy6ueCdmU56Fytk0v6Go1QOZzgEoJ+IK
 4Zwo5YuPpUzXLbgp43svNYttlQXoKzzMyOty4yRgmDHyc9ryqUHzRl2/f9Y55+gcxYf7
 Z8Nkh024c1xlAGOYwgWgPanPqdQXfipNzZnlbVS/0DO1rG8IXh1KgPgbEM89arHiUmh7
 dGT07x/TyiKNjHHSl7rzKZAPCybcbO8f4iee9DH1tSNylGR0lqjTvzkCeJXM9X3f3U0O
 hISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453835; x=1782058635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSMSvAqbR9wwm5YoQ0XfcdzQLhb63Va6CvOS08FE+gk=;
 b=Exvm/PEG4jLqeTyBv/YbHdRcdRG1VDmciWDWog6MvLsQ1XGyYXK0OqXZV6ZdqcvH9T
 W08WsjkW0V8f6bCfLcLkEzbyy9BOTn3SV0Vdq5AlNGou1/1GDeZxboRl5VAt7siJT0kK
 hQg2mdzlUeFyD64XRxZKPiTvXs6LeQXi5/U7F8KuV4bPajVpXghwPHkMBhIaUAUaO/JS
 wwZHcWJQnn2CBTt6boIqqj/IXATCI78c8IwnbBGxOljYrDHQz1u97V1aLCTXV/2eXsda
 WZGTRuetch3jmB6GYkAbdQHnbPdY+ZdNHaiKDU3WJOm2OnFnYr4BaYV5r1z7zCuVx6HZ
 lQdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PyMaXt3skAg9MsJNpSP/iRGpqrkmlBi8cJNB//QyL7m3pT5gghZKhN/D65q2PanTyKgPOYhs/C/Bv@nongnu.org
X-Gm-Message-State: AOJu0Yzp6qvLbxSW643DTuJpGb3VB/3pg9fO7v+fKfd72maQfD3YqiXL
 qGanOkoBQrAUtnEgSgvYfwtbN8AYtx3PW6V++cywqIbIcf7qsOOIDLJ7drcinRFyO9FXHG2UdPl
 skxx80O7cIlf50ZB1nZBagj/v2o5GY+CfW3bELk2q3azYlQh5KdeR2Gp4
X-Gm-Gg: Acq92OEW3HUGSLcLNqh2PqBrDQtmTztMKQkEdYzwfXFILQ+oZ5z4YMLytWrRQxgcNQo
 eS7VSsM3QG8QrJKcL6msVv6o13UqRiDGRrd7OYGb1sHvu+lRmGzU+/ai5XS9Hu+GxbcOeefcIbj
 9xnC30CaGHbuLc3wWSK7b3pACDCc7+p9o/S8Dv8Q4R8mHRjp0nZzLppZd9PE/1wqLjCWspxa/fU
 YLtjzRJIOupzbE9SGbOAGAwHhOblWyGvS5HaL/oPGdT0yg+lk+0Z16j1AjK4gxYquUA+tE8yNEW
 c5MUiaJtdK6vShmGcn7q3rlV+mi8dLaAjoFanCAViA732GzGys/+/IkfHhXZISwRr9lJq6wkPgc
 DOfc0jvVL0RqrsS7FNHGXGgh9CzpdnVU3N3OvAmUjNag=
X-Received: by 2002:a05:600c:528c:b0:490:bbc1:d508 with SMTP id
 5b1f17b1804b1-4922005e290mr89637625e9.1.1781453834804; 
 Sun, 14 Jun 2026 09:17:14 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:490:bbc1:d508 with SMTP id
 5b1f17b1804b1-4922005e290mr89637225e9.1.1781453834285; 
 Sun, 14 Jun 2026 09:17:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220310a58sm198415945e9.4.2026.06.14.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 09:17:13 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:17:10 -0400
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
Message-ID: <20260614121515-mutt-send-email-mst@kernel.org>
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


I checked arm32 and while it does that, so does memcpy.
We'd have to explicitly code up aligned/unaligned usecases.

But do we really care about device assignment on those
hosts?

Maybe, the thing to do is just to ignore the issue.



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


