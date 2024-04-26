Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CCEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 05:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0E1c-0007ht-2Q; Fri, 26 Apr 2024 01:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s0E1b-0007hc-0W
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s0E1Z-00059C-7n
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714108887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub0FL29cRayvmpCdJtgFYBQGKNkblbLSEBCkq7qiILo=;
 b=fv6RJ09g3CgLUIOYfhC5jKvIywK0p3PXzvWZzxjnpcIABvvOjjEKp3Zs5x1ZvdTNaxYuy7
 Nct1RxYBPuHDwh2ojk5SkwRn+iJwpr/gNl70IFgXi3KHaOIFkZTctjCjOyu51IqoRZGK5P
 QINfY1teImwR6WoPRADDmk48OPhRmYA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-J6NcisjeOfGPjdlQ8Fwf4g-1; Fri, 26 Apr 2024 01:21:25 -0400
X-MC-Unique: J6NcisjeOfGPjdlQ8Fwf4g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343c7fa0dd5so1126369f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 22:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714108884; x=1714713684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ub0FL29cRayvmpCdJtgFYBQGKNkblbLSEBCkq7qiILo=;
 b=sSHAjfUJc7+9djhTn8qhRfSfg/shhjMficX2bXhnZhPzVbjmvRsNSONbcSpu4ZFpQN
 FTVLXPqSR+C3WcxWDBmn+FT4FSZUtRRNhPPRa2Bc5S6E5FI+klj71PinQ9YTZcNZZqmt
 BjiI34Ju0DcBBjEpZ6spevHJccUDbFqrSAiPvqG8eRSKsXe1KpfW3PJuXjKFfuhdi1fH
 kiEDT0JRSECbwqKXor/YsBx0h857oPckEOTxkjeySLCIKcR1AUUQxgo4SWk4xtE5kXMq
 hKw0XvUzdWGIDyv8N4zjmcW2EftmOW0/fWsMgdptw++ErVncW/6xxlKghWuaJddXXrZo
 O1lQ==
X-Gm-Message-State: AOJu0YzKOBWLEY7ZvyA0qoGSocBS+CCqCb8fhrzr3rQQbBV6Nwd6DOfI
 43OGpWpi+38S+OqcHXHUuHbh/R+eTQ7gxlMVki/7XlOArPQibV10LfxySgQ6pSiF5MkN6MK1pp5
 ArrE+Y30BArfCmbP3CPofTCECzkZ88FJ4xJ9x/KMyJDc4WwyQbSRWcfflwQXS9w4z4rqszXx3C2
 anowh6QMeXo6rkjliuxe0h8jYB3M0=
X-Received: by 2002:adf:f906:0:b0:34c:4b26:cf7f with SMTP id
 b6-20020adff906000000b0034c4b26cf7fmr732961wrr.67.1714108884717; 
 Thu, 25 Apr 2024 22:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5m9140TZPb74k7nS047lw9eJk7T1+b0c0qcxPAiCOEiVIdBnxvqvdp75hI6G4L4GrRE9kMknaP0pHDRKdnjE=
X-Received: by 2002:adf:f906:0:b0:34c:4b26:cf7f with SMTP id
 b6-20020adff906000000b0034c4b26cf7fmr732948wrr.67.1714108884370; Thu, 25 Apr
 2024 22:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240424081443.75869-1-pbonzini@redhat.com>
 <7217032f-2d44-4c9b-aa73-1b97787de03e@linaro.org>
In-Reply-To: <7217032f-2d44-4c9b-aa73-1b97787de03e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2024 07:21:12 +0200
Message-ID: <CABgObfYAJQS-x6NRnjF5T-i0FmKwJR5eK0XQ8t1HBBTbP2QDkw@mail.gmail.com>
Subject: Re: [PULL v2 00/63] First batch of i386 and build system patch for
 QEMU 9.1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 24, 2024 at 8:49=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/24/24 01:14, Paolo Bonzini wrote:
> > The following changes since commit 62dbe54c24dbf77051bafe1039c31ddc8f37=
602d:
> >
> >    Update version for v9.0.0-rc4 release (2024-04-16 18:06:15 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 7653b44534d3267fa63ebc9d7221eaa7b48bf5ae=
:
> >
> >    target/i386/translate.c: always write 32-bits for SGDT and SIDT (202=
4-04-23 17:35:26 +0200)
>
> Sorry, I've already merged v1.  You'll need to adjust the fix on top.

It's the same tag, so you actually merged v2.

Paolo


