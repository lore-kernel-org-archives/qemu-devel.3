Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2E6C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJxN-00080b-9u; Mon, 01 Jul 2024 12:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOJwa-0007Ze-GR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOJw1-0007Lo-QA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719851480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JoTX0YFLhYh6hfb7Dc+Ht4qoRgX0ii8ofNn5/jBG2PA=;
 b=HEh7+qDLfJFMv7ih2kW9DuslNFrq9AV1/yeFhy28QU9yWQj/624+zRC6/Q2R80K8piT+i3
 nsZJXPfZqDr7I6SV/fchjk8y3UHN3M0dyEvC5bR5GUQ3KHmRXqqtFxKFAbeU8PwUHU87BK
 ZiRG1/lu5FX2Rl22f8T8R4E0rlB5xxs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-BJjkwHxPMsaxDTcfDh0Dpw-1; Mon, 01 Jul 2024 12:31:17 -0400
X-MC-Unique: BJjkwHxPMsaxDTcfDh0Dpw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42567dbbd20so24167315e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719851476; x=1720456276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoTX0YFLhYh6hfb7Dc+Ht4qoRgX0ii8ofNn5/jBG2PA=;
 b=ZZf2gE5e5G0IvAgMV44azMsiHcaM5dZ/LpUuSyAfUDVBcYE4Ww5amthV1e3HPyQ++5
 pBkDId3czgMyeq1wKMCtk3eGXH4EUuEqXdYcRMhoCC4P8RJmXetUIrV3qaingolCjgko
 zJMmG41g/ffAqGhBJu2Bn/AK4gGUAdOVAapaxt5hx7WgtVIbM6drlJv0XmKch7ojSgyo
 NOdVz26wsKBB7NlyjsUrod45/5sx6j6Holgk9uoSZuHWsNs6YUBn34NGWlRNENZ2Q8fz
 3KXRxOqqJC/x0TrY571wWO4wVSpTKTesQRo4o7AcGl1GGOSvoJaHih+o1O6JtAvZ0Aqw
 zSTA==
X-Gm-Message-State: AOJu0Yy/W56BhWqo/g1Idw9XwCz52mok6dnwNdM0OK5munAbboEq8cp/
 wPZO5ubHO9zn6osvMhRFexG9RFLy1z2/XrmW7e9WXwF3PwED0jUXqoGdpqgYave9SgNvG8XbRPo
 WgT2LxrCnXKrPrVjr5MVqFCUOMqEKb3FZphFmNwsJxQLgzCf+PsywPV2mcuUHIenbswud0MoMdI
 nAXUnG1ccbJJqRLRO6+ognyiEjEOk=
X-Received: by 2002:a05:600c:4aa9:b0:425:656b:76ae with SMTP id
 5b1f17b1804b1-4257a00ce69mr40299245e9.23.1719851476747; 
 Mon, 01 Jul 2024 09:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZjM6mL8GHvHz5zvsnJINkhwfbhgXp8/I5C2XI9h0pUAfLIcKLWIHgYZHfTpK6+zPluyszVnn8W9g8OAfTAs=
X-Received: by 2002:a05:600c:4aa9:b0:425:656b:76ae with SMTP id
 5b1f17b1804b1-4257a00ce69mr40299095e9.23.1719851476464; Mon, 01 Jul 2024
 09:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 18:31:05 +0200
Message-ID: <CABgObfbVJkCdpHV2uA7LGTbYEaoaizrbeG0vNo_T1ua5b=jq7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] system/vl.c: parse all '-accel' opts
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, ajones@ventanamicro.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 1, 2024 at 3:30=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> My initial intention was to fix a problem we're having with libvirt and
> RISC-V where we can't set 'riscv-aia' by appending '-accel kvm,riscv-aia=
=3Dval'
> via <qemu:cmdline> in the domain XML. libvirt will add a leading
> '-accel kvm' in the regular command line and ignore the second. But to
> fix that (patch 2) we must first guarantee that we're not mixing differen=
t
> accelerators.

I think you can use -global, if you tweak qdev_prop_check_globals() to
also allow descendents of TYPE_ACCEL.

For example:

   ./qemu-system-x86_64 -accel kvm -global kvm-accel.kernel-irqchip=3Doff

Paolo


