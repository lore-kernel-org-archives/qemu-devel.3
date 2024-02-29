Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C68C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfeKo-00034c-Mb; Thu, 29 Feb 2024 06:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfeKk-00034G-9r
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:12:14 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfeKi-0001lJ-Em
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:12:13 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-564a53b8133so1060652a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709205130; x=1709809930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7VsnEYd7D+59t0kjgZG4Q+rKaIBPz+bLoUEduQM/d7k=;
 b=csjLa92MPUZSEfX3yM+mnOk/wTt3f+/S0xMu8G1rpwhJnyV8c5j7A0efJCM9klKnTm
 prpoTpyA2+QPCuKyN3fjKK7eoRoQLrfpPaEWQw+k6QiyzctbajPeQ93XK+xU3Cu3YR77
 HPqQfxQdppN2KXPbrhJ25g5c9RSjCwi3MjtgoezqEN19DdCjpXY/Ud2XpV+gM2emM/11
 27aCnrfO9uYtmRpLI2b1/EV18n8BSTt8CLEwWRn4+WciPvsKOurI9Tj2rr6Xyoo8tdy6
 08zqId9sSkLnzQy8UYWKUkbhxGzEvpbYmzb6t7btKlD6vKXesGSNi855JddJH/40fyDS
 wZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709205130; x=1709809930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VsnEYd7D+59t0kjgZG4Q+rKaIBPz+bLoUEduQM/d7k=;
 b=CzjAuuxVpz0lKc3QWRDiyS5OZCECcoIH4SjIwSodR0A4/Vif9We3UpPbiotjKom38z
 YpigsCciRD3RsXcYaJwH2MiyrrzlesbwEBanVCgx3fGTUI+hYa8E9NuW/dXU17pjQi0W
 QvQqnEyeSHn56i++ZvPy+SFJGgdBgj7P3mw9o9JYA91dyB5EF2gAgpjVLWjonL95qsjb
 G77eWEfJXbE+ypXn2SZSSd+0NdLSSFEunWvkxAtpcrN9XtI9NXCAaGzred3CwlkR7Pht
 nVXcoL7SEufe4zvivXNQHS5AVTvgRRl4CwVw9SdG8ihzo6r1dzIFaRkqOPCR7vGP90js
 j8wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQhpYzH0ZYah0/eZYvlKSotXIFa7DGZvNMut/8X+O+7nzLS1I680ZSZG8bks7wLIZF9zdcJh319p1iY2iHlg0KDGtraU=
X-Gm-Message-State: AOJu0YxL1esJDHor4EYGsK0/LdNZEO8TFrw6Aps6uI9U54X42PFI7yi9
 VDNvOoBSznmvQtwkNPWLSdATI6I/rJUX9Xnq1O8j/1y80F5fcfbcRALntJWFNBEv+5Q9AAU2nCq
 Lq24sScMtECYG+S/VwUPvUuW5MgCQ3ST0Z/ArEM+R/fQIkVkV
X-Google-Smtp-Source: AGHT+IHvLJd1bsvqRoJ0ceBBc8pkZHLdWpXgE8Io4cO8o3CuNKoBnknLb4+n4HxDtk6OOgyH8PcedS0Ln0PsxNG9Ymg=
X-Received: by 2002:a05:6402:1855:b0:565:ff64:33b0 with SMTP id
 v21-20020a056402185500b00565ff6433b0mr1241208edy.22.1709205129836; Thu, 29
 Feb 2024 03:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
In-Reply-To: <20240229105900.0000490e@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 11:11:58 +0000
Message-ID: <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 29 Feb 2024 at 10:59, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 29 Feb 2024 09:38:29 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Wed, 28 Feb 2024 at 19:07, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > On 28.02.24 19:39, Peter Maydell wrote:
> > > > The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> > > > which was the first implementation of this function. I don't think
> > > > there's a particular reason for that value beyond that it was
> > > > probably a convenient value that was assumed to be likely "big enough".
> > > >
> > > > I think the idea with this bounce-buffer has always been that this
> > > > isn't really a code path we expected to end up in very often --
> > > > it's supposed to be for when devices are doing DMA, which they
> > > > will typically be doing to memory (backed by host RAM), not
> > > > devices (backed by MMIO and needing a bounce buffer). So the
> > > > whole mechanism is a bit "last fallback to stop things breaking
> > > > entirely".
> > > >
> > > > The address_space_map() API says that it's allowed to return
> > > > a subset of the range you ask for, so if the virtio code doesn't
> > > > cope with the minimum being set to TARGET_PAGE_SIZE then either
> > > > we need to fix that virtio code or we need to change the API
> > > > of this function. (But I think you will also get a reduced
> > > > range if you try to use it across a boundary between normal
> > > > host-memory-backed RAM and a device MemoryRegion.)
> > >
> > > If we allow a bounce buffer only to be used once (via the in_use flag),
> > > why do we allow only a single bounce buffer?
> > >
> > > Could address_space_map() allocate a new bounce buffer on every call and
> > > address_space_unmap() deallocate it?
> > >
> > > Isn't the design with a single bounce buffer bound to fail with a
> > > multi-threaded client as collision can be expected?
> >
> > Yeah, I don't suppose multi-threaded was particularly expected.
> > Again, this is really a "handle the case where the guest does
> > something silly" setup, which is why only one bounce buffer.
> >
> > Why is your guest ending up in the bounce-buffer path?
>
> Happens for me with emulated CXL memory.

Can we put that in the "something silly" bucket? :-)
But yes, I'm not surprised that CXL runs into this. Heinrich,
are you doing CXL testing, or is this some other workload?

> I think the case I saw
> was split descriptors in virtio via address space caches
> https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L4043
>
> One bounce buffer is in use for the outer loop and another for the descriptors
> it is pointing to.

Mmm. The other assumption made in the design of the address_space_map()
API I think was that it was unlikely that a device would be trying
to do two DMA operations simultaneously. This is clearly not
true in practice. We definitely need to fix one end or other of
this API.

(I'm not sure why the bounce-buffer limit ought to be per-AddressSpace:
is that just done in Matthias' series so that we can attach an
x-thingy property to the individual PCI device?)

-- PMM

