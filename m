Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ED5FA3737
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 09:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2Y8-0000P7-CJ; Fri, 13 Sep 2024 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp2Y5-0000MT-NJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:25:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp2Y1-0004Bz-JO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:25:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c24c92f699so1701757a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726219499; x=1726824299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ci18e0ToEUJEx1JvuD2ii1z5vR72h4MufMPC7uSPvP0=;
 b=UMJF7c5porrk9MpxQmkge6RXVkiy/ftVUhpC2/R2LdP4X51HCiPCS5QdcECBOu4YAn
 w6ii+PC2fWEEJi2Vx5JMzCmGItgs/MEU2XiosgirypN1shde/WgX13nCYRPZWSNbijU/
 QyUPRPu+UMq2k6DjOVSGTGIcadgnm7NPWkSsw2NKtcfk1uW82XuGDuxRfaTUdysmMKoG
 lALqFP+ae99Q2kE5tnlYG3DYbFzw1M4fcZFXARehDHr2+nfSi4DDMIVOs1QTIMXOqKeW
 M6E+thgVCZgbZ3jT6/lEIroQ1ZTzaNRHZOiF5ycFIXaQfKIWkKImUVCjedFfrdi03/Dd
 fK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726219499; x=1726824299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ci18e0ToEUJEx1JvuD2ii1z5vR72h4MufMPC7uSPvP0=;
 b=vwnr3w59t48ZHBXLlWoLJAhDdVLGf14IE+nfIxfU2CqEMHs79sXuMjOYXz9xSdZo3u
 O6GUGf6irLkbjZODtdDp4XlkUgkVsNuSU0iwGDKdsFoH9bQL9dlQWeaecI+E8+5pGfNz
 HVQZw1SZN9jxPstQwcSZLPinxUxRoyJMtnnRWwnxgWt+Avso524PAacWzIlQ7Bewdy4W
 PZUlb8jFzv4stwJ0fsP0XdCPTm9hIiZ0Hjt/p7bORsvAeYYSrsc5DJf0aRS+39KfsNTf
 AToiLf34hMOuEQ4wp5tR0PKqVDQ9DvZIkCnyuqZX9QEy9xOzX1icvYPlfY7l7tVT0fOd
 XpfQ==
X-Gm-Message-State: AOJu0Yx/9xNzBKfyHG28qEBtf5pq7eZLsFS3FEgDDvAttfS6NQhE3mq2
 nTVkDaEaGMFQi8Q3thmt5QXRIDZXRp1/alrLEkiXm3Up+r4SheWgXAlqwzqObXl7sf/BBnrxUFf
 vimDgCCkeY4qS9nDu7T4q7sU8WtcN3JytE00HXw==
X-Google-Smtp-Source: AGHT+IFXqXzHT/40CxYhlVYBb6oK3De9pyqf//730Nl+k0mliYrik1gQJtZ8klgCQ1uZpqTsxfQESAFrlozq77CY0WM=
X-Received: by 2002:a05:6402:2295:b0:5c2:112f:aa77 with SMTP id
 4fb4d7f45d1cf-5c413e57ab9mr3388231a12.31.1726219498737; Fri, 13 Sep 2024
 02:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726062663.git.mst@redhat.com>
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 10:24:47 +0100
Message-ID: <CAFEAcA9GdiQ6pYXuaVX4ehvVhsbT9TKtXCQHR2abpJSRU4bSEw@mail.gmail.com>
Subject: Re: [PULL 00/18] virtio,pc,pci: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 11 Sept 2024 at 14:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit a66f28df650166ae8b50c992eea45e7b247f4143:
>
>   Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-09-10 11:19:22 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 6e3c2d58e967cde3dadae298e81c5e8eb9fb9080:
>
>   hw/acpi/ich9: Add periodic and swsmi timer (2024-09-11 09:46:14 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,pci: features, fixes, cleanups
>
> i286 acpi speedup by precomputing _PRT by Ricardo Ribalda
> vhost_net speedup by using MR transactions by Zuo Boqun
> ich9 gained support for periodic and swsmi timer by Dominic Prinz
>
> Fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

