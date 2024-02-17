Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C8DC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 09:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbHKg-0008Dl-Ab; Sat, 17 Feb 2024 04:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rbHKf-0008DY-99
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rbHKZ-0003pd-To
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708163398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaTLp+79cnXu5TnAOtSPNC/MV3MHXBmWLdDvVyWtCh8=;
 b=Jog6rXWSh1DnYNP2ZGRBWeIe0CoeFn6cPXHQZENnWAXXerLt+1+YkQqm9Er1tD68u5GlKG
 6Ug33Ng/HDb8ZZou+/N/t0gpDb0pYezBriH2/pf4X4w/UHjXmsS+EEbFF7ABXSlZPOMNiy
 oUg9oVBlbWFZ9rgi3ZWT3BvzLMRDTyU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Iww7rmQPOUaGZ70M6lnskg-1; Sat, 17 Feb 2024 04:49:56 -0500
X-MC-Unique: Iww7rmQPOUaGZ70M6lnskg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b51ae1c9dso1242593f8f.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 01:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708163395; x=1708768195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaTLp+79cnXu5TnAOtSPNC/MV3MHXBmWLdDvVyWtCh8=;
 b=nyLle50gXOPYTefpSeTRPOcgAPaI8V+r/8+nJT2DVEuj/QiJoXuMGBS2EDacsohpF/
 7SzgbKf4f1CHfGXPPujGZX8EsGLT2YtiHK6gNAlosjBsvUFJdSReV9a84e8Q5zvUyHil
 vbQ+B2Bxvm3aRpYD/Ay+VWOzSAUKHB8ddk08oIddfSa7X3duWGNoETuscb1VvcdOPBqU
 F/18GtG4piEx/B0L4SFsaBRXCqNIEf4ricF+NBz5jIA7QIsc5nY4ERo4GGDeTp/kEStK
 yUnpdj4goESaoYulE34F0N0F4BaPH3wp5iwJlx4wV6QWybq/2UHVEwaDDfOVocm7XBBW
 j5jA==
X-Gm-Message-State: AOJu0YygjSsI0IVd33R7ragPhOVYDhsLNAQDDxp5mLmMND8ZzwHGZEZw
 n/drOy92pd3MBdhsWhcOwu5aJMA0Wa7ylteT8CYbTd6+hbMmdJmr+d4qMa5xDpHhlk59CYADJyy
 RcruGhTwJvaHpTufd7FQVx9vFOHHkPXOcae5DkuwUB71Tql+/b412wJAPB0g1+k/pWa06vn6aBA
 feFndgodAjOAvoN+wjL38fxqR1c34=
X-Received: by 2002:a05:6000:1250:b0:33d:1469:d254 with SMTP id
 j16-20020a056000125000b0033d1469d254mr3345606wrx.70.1708163395167; 
 Sat, 17 Feb 2024 01:49:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF66GFce5WDI4ilwYvLj73ChUDKWOreGDxzvWnqVUR5xzfd01pgvDdH2Z/nZjs5ElatRxrV2euPzsfrAGM8pWw=
X-Received: by 2002:a05:6000:1250:b0:33d:1469:d254 with SMTP id
 j16-20020a056000125000b0033d1469d254mr3345596wrx.70.1708163394854; Sat, 17
 Feb 2024 01:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-2-pbonzini@redhat.com>
 <55614135-f142-4c37-b280-0550207f2229@linaro.org>
In-Reply-To: <55614135-f142-4c37-b280-0550207f2229@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 17 Feb 2024 10:49:42 +0100
Message-ID: <CABgObfb-PHukiZ2D_g7mkTHtLBYzqvxNVkp2_6LX3OC5fniwMA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] usb: inline device creation functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, shentey@gmail.com, balaton@eik.bme.hu, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 12:14=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 13/2/24 16:49, Paolo Bonzini wrote:
> > Allow boards to use the device creation functions even if USB itself
> > is not available; of course the functions will fail inexorably, but
> > this can be okay if the calls are conditional on the existence of
> > some USB host controller device.  This is for example the case for
> > hw/mips/loongson3_virt.c.
> >
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   include/hw/usb.h | 27 ++++++++++++++++++++++++---
> >   hw/usb/bus.c     | 23 -----------------------
> >   2 files changed, 24 insertions(+), 26 deletions(-)
>
> See alternatives:
> https://lore.kernel.org/qemu-devel/20240216110313.17039-10-philmd@linaro.=
org/
> https://lore.kernel.org/qemu-devel/20240216110313.17039-11-philmd@linaro.=
org/

That doesn't include usb_create_simple(), which is the one that
matters the most here.

Paolo


