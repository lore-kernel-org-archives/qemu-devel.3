Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287EBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 09:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzCIY-0003mg-T2; Tue, 23 Apr 2024 05:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzCIT-0003mJ-8q
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzCIQ-0006el-Km
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713863916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ughj38E8UToDMogbjiGsui0eSWa3f0Tq87pVHTREbAQ=;
 b=alZkHVlKF0cD3yQMY/Oc+qMGylE0U5kPq/1P8uMGHglZjHkjrf/JAX8hPWf79wi2nUY35n
 oHoy6joioGx2AbFUzPC3j8TBfRYy6v4E5KMOGRmVJm170gy+x3nFIKnygjahGZEjBdoogC
 2TzVRCgWb7SOjVFbHSqft7ZOVsKLRQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-3XR8GVCJOwuUCXUvGtFkQw-1; Tue, 23 Apr 2024 05:18:35 -0400
X-MC-Unique: 3XR8GVCJOwuUCXUvGtFkQw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41a370b6acdso7526415e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 02:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713863914; x=1714468714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ughj38E8UToDMogbjiGsui0eSWa3f0Tq87pVHTREbAQ=;
 b=nqHb8OD/BemhibBR987uQv00bU3r4jbFHU/R+TMBrLodwRnL6KzQocoHS2BwZuP694
 ErFnpB8aKX7J7REVsraW+3fcuBN69tbN0ZJGSirQfAPl2tYYgVPLapo61oau1tk6HXAm
 7gmcxHJHUUyl99mGa5vVLPx8NM+wMxzPC3ujoeQ3cv5F9UG0BDEU03GCp15HQ9uil+7C
 +DuEZW83SlqKzIJHErW/s7Txd/i6I+v38oiqt0pyzIq6VClYCy3dwKxvgRkNZ5M4EriQ
 nFbh/fOzSnWmAm2nN34OqVyf+Sicoupiu1pBfIlUDOCY6yE633YRgwkm5fI3B0PsSV5o
 8Sug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0wYkg8YVvpPjbJ21O4K3/M/iJBQY4GfKYPqjFQy39RZ/C/4L/b0sSCzhLfgONUdOQLqvjY5ZbcFUG0gvEnr/930eINp0=
X-Gm-Message-State: AOJu0YzCeZUFjzGRTr32ft/agPJAPa5Gjr01QDmsZgjC7mwOsRICIFf8
 CNq9WoVEWgim1ekmCkYduIL1tGT87ryFzRCWUowyQzSDTxXH4jh14t4qQJbYO2CwdSmK/PGcbMV
 Pztqu7q84l2lUhuKI77oRBBDA51f/xjbo1TtkjN9hUpVSDTjPxDHBmiNZhYbCagVzMy88rzj0KS
 blsjJMMRCDYhNaiR2ZoVevkHVrZ08=
X-Received: by 2002:a5d:498d:0:b0:343:39ef:53b0 with SMTP id
 r13-20020a5d498d000000b0034339ef53b0mr7673873wrq.24.1713863914088; 
 Tue, 23 Apr 2024 02:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn7iipzIqc7ATj5GM65H9AJi/cq1Rd2zpcAAX/M9PN/w7yU2g1vilCyBGxAbMTxqpaHrOxjNXz6nYPCMY+5lI=
X-Received: by 2002:a5d:498d:0:b0:343:39ef:53b0 with SMTP id
 r13-20020a5d498d000000b0034339ef53b0mr7673860wrq.24.1713863913779; Tue, 23
 Apr 2024 02:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
 <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
 <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
In-Reply-To: <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Apr 2024 11:18:20 +0200
Message-ID: <CABgObfYsCO-fH1MZQ1=mRUJQHn9h2QBcCfytBnDhhM91iEd4sA@mail.gmail.com>
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>, eduardo@habkost.net,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Mon, Apr 22, 2024 at 9:10=E2=80=AFPM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> Am 20.04.24 um 07:40 schrieb Mark Cave-Ayland:
> >> Current documentation agrees that all 32 bits are written, so I don't
> >> think you need this comment:
> >
> > Ah that's good to know the docs are now correct. I added the comment
> > as there was a lot of conflicting information around for older CPUs so
> > I thought it was worth an explicit mention.
>
> Quote from the Intel=C2=AE 64 and IA-32 Architectures Software Developer=
=E2=80=99s
> Manual Volume 2B: Instruction Set Reference, M-U March 2024:
>
> IA-32 Architecture Compatibility
> The 16-bit form of SGDT is compatible with the Intel 286 processor if
> the upper 8 bits are not referenced. The Intel 286 processor fills these
> bits with 1s; processor generations later than the Intel 286 processor
> fill these bits with 0s.
>
> Intel still claims the upper 8 bits are filled with 0s, but the
> Operation pseudo code below is correct. The same is true for SIDT.

I think the claim is that it fills with 0s when the software is
compatible with the 286, i.e. never uses a 32-bit LIDT or LGDT
instruction. Software written to target specifically older processors
typically used the undocumented LOADALL instruction to exit protected
mode or to set 4GB segment limits, so it won't run on QEMU. You can
read about the usage here:

https://www.os2museum.com/wp/more-on-loadall-and-os2/ (286)
https://www.os2museum.com/wp/386-loadall/ (386)

and about how it worked here:

https://www.pcjs.org/documents/manuals/intel/80286/loadall/
https://www.pcjs.org/documents/manuals/intel/80386/loadall/

Interestingly, byte 3 of the GDTR or IDTR on the 286 are documented as
"should be zeroes" for LOADALL, not all ones.

Let's change "Despite claims to the contrary" with "Despite a
confusing description".

Paolo


