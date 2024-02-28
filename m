Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4087C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOpu-0002iK-0m; Wed, 28 Feb 2024 13:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfOpt-0002i9-6N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:39:21 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfOpr-0002w9-Aw
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:39:20 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so98886a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709145557; x=1709750357; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lT9hn+57uOhXenoDpKTmFM2J3VdE58lV77AMQTr9jjk=;
 b=CDY015nJbtmyVMbeTpSb53VevgLISqzbe2YsO7BZgnMOer4jLfu9uKhLace+J8ptzy
 6IxEs1xpIn/7ETtvGa1j6tqlxdVxfLiCDnXhftFr5TYujwcHrkXy/IV4a/wf05lpMKI8
 2k2p8gqmQ5a2yy2HM0bk05NW4eQev+OkxyHeH5K0WvNwgIK6JVuT2K1vw7m8PhUN85PR
 GkuWQCWlg3yoO0SdNzzE6yZ9+HxcxqktW4trleFGSRGXknyZxFZTXuPPh1YtkSup6p67
 87n5GxlPt5Fa4SQagXEB+irxvkJf3kuadx+UqyJDRw4f+w50TLpcdIQDOKbkG2AtVWC3
 PbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709145557; x=1709750357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lT9hn+57uOhXenoDpKTmFM2J3VdE58lV77AMQTr9jjk=;
 b=FkAZgJgKWzEgIP2+LuPB5muwUcUYtlON2JqiFBIopDlEqfTPaU0LT635kfJVijGaTm
 r/hhLByN0TbcM+GEksC1AHz7eXW54Zgs37uJfU1YRzlMUxdL+l8fFphbVrTJ0MTx/w/z
 EgmF22tkWnGJ03y5fv0OLAdi9oXsBraaz5bkQce7nJnNsjXIsYcdqgyk8XqqaMF6VNSv
 9vXOSINtsJ/vOQEWCdqB7ouoAZmBqNWKndLKJx/Eg5hVB3Fmel25e1RSsFeb5HdPpaLB
 Qi0jc3MqTMO776CAXX9zVOcivltb8Y4UZk8TREutqy/xYfA1hNAD/PkazZRrmhXXgNGn
 ediw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0UiBqLstepYKb0KX8Os1+pN4Z+FYBhIHUsL2Nak89Y8K0ogpSdBwwhbf0dnTIC5ZheHIzMfS2JlPF2zE/+pVzxXPddww=
X-Gm-Message-State: AOJu0Yxe5iJk7gNd4E8HX/0o83Ju68Jfow9OoTjVKXcSxtHyIzzxR7mc
 blPQLeBHF10/KdwTTZtVej2MG1ybr/zPGfF6ObKJI+MBEFcNiyii6zcTN40pl4ZgHAN456oSU7f
 xdCyyjvDNm6IuKnBogCokExa3ybGTceTgb3kC8g==
X-Google-Smtp-Source: AGHT+IF6940PIyG47+HlGfNAU69tMz9J66v3a7t7CQ0jzwNz4N4uXNMlP95bFft7ovedMt7nsp9VSeQxiVBJYiq8yYs=
X-Received: by 2002:a05:6402:2156:b0:565:a5aa:22e7 with SMTP id
 bq22-20020a056402215600b00565a5aa22e7mr80554edb.2.1709145557651; Wed, 28 Feb
 2024 10:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
In-Reply-To: <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2024 18:39:06 +0000
Message-ID: <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 28 Feb 2024 at 18:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 28.02.24 16:06, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Heinrich,
> >
> > On 28/2/24 13:59, Heinrich Schuchardt wrote:
> >> virtqueue_map_desc() is called with values of sz exceeding that may
> >> exceed
> >> TARGET_PAGE_SIZE. sz =3D 0x2800 has been observed.
> >>
> >> We only support a single bounce buffer. We have to avoid
> >> virtqueue_map_desc() calling address_space_map() multiple times.
> >> Otherwise
> >> we see an error
> >>
> >>      qemu: virtio: bogus descriptor or out of resources
> >>
> >> Increase the minimum size of the bounce buffer to 0x10000 which matche=
s
> >> the largest value of TARGET_PAGE_SIZE for all architectures.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v2:
> >>     remove unrelated change
> >> ---
> >>   system/physmem.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/system/physmem.c b/system/physmem.c
> >> index e3ebc19eef..3c82da1c86 100644
> >> --- a/system/physmem.c
> >> +++ b/system/physmem.c
> >> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
> >>               *plen =3D 0;
> >>               return NULL;
> >>           }
> >> -        /* Avoid unbounded allocations */
> >> -        l =3D MIN(l, TARGET_PAGE_SIZE);
> >> +        /*
> >> +         * There is only one bounce buffer. The largest occuring
> >> value of
> >> +         * parameter sz of virtqueue_map_desc() must fit into the bou=
nce
> >> +         * buffer.
> >> +         */
> >> +        l =3D MIN(l, 0x10000);
> >
> > Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
> > TARGETS_BIGGEST_PAGE_SIZE?
> >
> > Then along:
> >    QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <=3D TARGETS_BIGGEST_PAGE_SIZE);
>
> Thank you Philippe for reviewing.
>
> TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by the
> page size.
> How about MIN_BOUNCE_BUFFER_SIZE?
> Is include/exec/memory.h the right include for the constant?
>
> I don't think that TARGET_PAGE_SIZE has any relevance for setting the
> bounce buffer size. I only mentioned it to say that we are not
> decreasing the value on any existing architecture.
>
> I don't know why TARGET_PAGE_SIZE ever got into this piece of code.
> e3127ae0cdcd ("exec: reorganize address_space_map") does not provide a
> reason for this choice. Maybe Paolo remembers.

The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
which was the first implementation of this function. I don't think
there's a particular reason for that value beyond that it was
probably a convenient value that was assumed to be likely "big enough".

I think the idea with this bounce-buffer has always been that this
isn't really a code path we expected to end up in very often --
it's supposed to be for when devices are doing DMA, which they
will typically be doing to memory (backed by host RAM), not
devices (backed by MMIO and needing a bounce buffer). So the
whole mechanism is a bit "last fallback to stop things breaking
entirely".

The address_space_map() API says that it's allowed to return
a subset of the range you ask for, so if the virtio code doesn't
cope with the minimum being set to TARGET_PAGE_SIZE then either
we need to fix that virtio code or we need to change the API
of this function. (But I think you will also get a reduced
range if you try to use it across a boundary between normal
host-memory-backed RAM and a device MemoryRegion.)

thanks
-- PMM

