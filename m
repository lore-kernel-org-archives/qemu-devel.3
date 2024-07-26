Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A5BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 02:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXAeE-000414-UA; Thu, 25 Jul 2024 22:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sXAeC-0003zc-H4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sXAeB-0003mK-5s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721960730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrEQ3RdpGj/Clo/p7IGZmysthssp20ufaxRY7amPhK0=;
 b=NKib7SLo98oTSQ/wqcvBb6unOAxHYTPLJ5tRR4KM0YVFUnA233YjOTXgjqtMEPmPpAVpUk
 XicSv5zHRlMjNhFxLlmg8lrjK3jhUqC7swLnsZMfeXjp/fBbhI5C+VrpT2xWCQ/aCSFrdD
 M3sXxB7BetGPntE7Ox6UBzkbR3afRbA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-t5AxPe2SMQCpyvbZU0WH1A-1; Thu, 25 Jul 2024 22:25:22 -0400
X-MC-Unique: t5AxPe2SMQCpyvbZU0WH1A-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4928daa735aso850833137.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 19:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721960718; x=1722565518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrEQ3RdpGj/Clo/p7IGZmysthssp20ufaxRY7amPhK0=;
 b=M9yPLJ5z74Uu1d/wDToGT9xaeioWZtx0h1gnmGeZbkDtU32hs07s0CS0iUE+LanVCt
 hUvqL3GQ34ae48JbUQAqEC4ZE9M0pT80LtH35c7ERj3DGNimZ/+7DCK8oM2+ZQhYoUYk
 z1hD6kOUtSqZIImP4OndqWDm1CuaScEHUohxp4k5Q/CcnJUQE1UjYeGo2JOu5LtzVwUG
 HsCuX1efIDNw/sN6227oKCd/m9Xd+pY4a5iJ6PNV8X4pBp5enDdqY8vKwLKWqpCAH+eh
 49ujc2rUhhly+anHl4EtefI7vlBzak6Cr+80u5iA5Dm5M/TH5fnDjqFqUVuie0EBhYte
 a2+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW68xHYh96DPLTCW8dnwZpK6B8JPuA8rBgQ4FkcWb7oFWTI2hyXdzLJ0PkmzFynRHZGuGSWCWl8tyectBzVuk6f4OZjn6o=
X-Gm-Message-State: AOJu0Yw0eg6KNeydT3Fzngml46GnPSCVh/GWEpAwQaIhbHChKHTBVvK4
 aHkpct2XlaIW4Mjf+Oze9ATAkRmLejuiZMpQhSk1b6V1BGriQoLc/Tdf9+FChQj8USMMhlyvj7M
 IIk+fPgYtObO1qp7l0Uon05p3nnYujdjOT1ownSo2WJv0k41Y+7QYM9gmHyIs7+6v3x6gbu1V5X
 KlIGSWvtr60J8lt/RLX2BmVOu3tEUD+CIb5eXorg==
X-Received: by 2002:a05:6102:290d:b0:493:e713:c0ff with SMTP id
 ada2fe7eead31-493e713c32bmr1824914137.4.1721960718388; 
 Thu, 25 Jul 2024 19:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvlNBaTR610HmN5e5eeNxE1uyTQmox/8Zbmv1lJvQF6l+DYKhLz6HJ230uS4+XOtT98ZnPgBQ3MjupBAiMn+M=
X-Received: by 2002:a05:6102:290d:b0:493:e713:c0ff with SMTP id
 ada2fe7eead31-493e713c32bmr1824899137.4.1721960717997; Thu, 25 Jul 2024
 19:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240709123444.6933-1-dwmw2@infradead.org>
 <d149921b-8d44-4d0c-af56-b6b2d53797c0@tls.msk.ru>
 <5a32fc454f87e1af0adafc65a26ee55e76404c15.camel@infradead.org>
In-Reply-To: <5a32fc454f87e1af0adafc65a26ee55e76404c15.camel@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:25:03 +0800
Message-ID: <CACGkMEv-H=1pT1YArg3MWsfUoT8-Lt8taOo106f9aBG_ciQMnA@mail.gmail.com>
Subject: Re: [PATCH] net: Reinstate '-net nic, model=help' output as
 documented in man page
To: David Woodhouse <dwmw2@infradead.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 24, 2024 at 8:02=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Tue, 2024-07-09 at 15:46 +0300, Michael Tokarev wrote:
> > 09.07.2024 15:34, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > While refactoring the NIC initialization code, I broke '-net nic,mode=
l=3Dhelp'
> > > which no longer outputs a list of available NIC models.
> > >
> > > Fixes: 2cdeca04adab ("net: report list of available models according =
to platform")
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >
> > Cc: qemu-stable@nongnu.org
> > Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>
> Ping?

Queued.

Thanks


