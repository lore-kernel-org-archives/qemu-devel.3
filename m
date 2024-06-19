Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrS7-0005Ou-Kf; Wed, 19 Jun 2024 05:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrRy-0005De-60
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrRw-0003yS-Fq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718788671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GC+hv8iinl3emo8lYof8BsSRuYtckLmPNXIswLbt2E=;
 b=QOE7HMCGCoiEsZwgOkn+Zco6IhnOH6d5jHJi5Wv0cDZ+R8JD5kOqrmt8N/0XLRiv2KPV3n
 jbLvnFCMg9jvLTR8+1ahsCwIjN4eAXV/waklkg+/8W5dejXud1pnMrwHphERq7esAGvSo3
 t/CHKlCmMLMP+JHokLBS2lKrfLmsGOA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-xgxB3COoOZaY46fSLhIPqQ-1; Wed, 19 Jun 2024 05:17:46 -0400
X-MC-Unique: xgxB3COoOZaY46fSLhIPqQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec01fa1a72so48800291fa.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 02:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718788665; x=1719393465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GC+hv8iinl3emo8lYof8BsSRuYtckLmPNXIswLbt2E=;
 b=YmtAbjyYK0tUOQcyhkm1aVSRx3aKor4ZIfc9n1DVopRjR/mEbisu57Mo4TDuaj1Qf3
 pjDHrm2gLwrM6iKjtYMm/K3TWpSwDpfur8bhZ3m2rXKzF8GSxvEjHuM04wVie8cA3w/r
 mTG2YdjFkc83HzTY8LImbGQGus34X8pE250GSl/Q7zusLQSIzTrYItWAtZYqu8bkrHPt
 XrV1mXpopv16wGLNDFrHRjgBvl3KWyVdU+/lgDK4L1R6T/iVU2IV+jwcSAVjYFgO1Twg
 v0K9xotdRJEqn56R3UGAqUGqS3sar4o5I3YHPzF0LxOdoAvDfOuIQjXm9tnvBLPhfXdQ
 UYVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMpD1SKS7VltQx6a+ceW6AoQyREQrPzbXTH80U9PZrA62axQmAy25y3YqGQklGgy4ulAdT2WkTgMJIyPDe1lU41MVX+aw=
X-Gm-Message-State: AOJu0YxpMhuNTpihmm478r+3o40u5hKIzgCqkObfpwBAv0dSkzyq+7ET
 gl2JG0JpZeowAfXsnlab7DjjovpZUODDfbuzi6Z+nmu+o3cKYpf9D3jaR64mU4oKdW0NTc3s+eS
 dI7zKSPWu4X2Sqmz3DyD18AOO8fQkdbTlLQukv3Nk6aVeBKHKd9X+
X-Received: by 2002:a2e:be93:0:b0:2ec:4096:4bc6 with SMTP id
 38308e7fff4ca-2ec40965033mr7105421fa.7.1718788665567; 
 Wed, 19 Jun 2024 02:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0B5WaLWPRj9oPygysfhHieKtXBUf5T/kk8ziat0RwgGhq3MrYjMUXLan7Cd+S60+vXFl6Cw==
X-Received: by 2002:a2e:be93:0:b0:2ec:4096:4bc6 with SMTP id
 38308e7fff4ca-2ec40965033mr7105201fa.7.1718788665183; 
 Wed, 19 Jun 2024 02:17:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42471584311sm31892615e9.0.2024.06.19.02.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 02:17:44 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:17:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis
 <alistair23@gmail.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1
 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>, Andrew
 Jones <ajones@ventanamicro.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 06/12] tests/data/acpi/virt: Move ACPI tables under
 aarch64
Message-ID: <20240619111743.58930119@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZlSjzfSj8MwDcJk6@sunil-laptop>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-7-sunilvl@ventanamicro.com>
 <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
 <ZlSjzfSj8MwDcJk6@sunil-laptop>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 27 May 2024 20:46:29 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> On Mon, May 27, 2024 at 12:12:10PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Sunil,
> >=20
> > On 24/5/24 08:14, Sunil V L wrote: =20
> > > Since virt is a common machine name across architectures like ARM64 a=
nd
> > > RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
> > > RISC-V tables can be added under riscv64 folder in future.
> > >=20
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >   tests/data/acpi/virt/{ =3D> aarch64}/APIC             | Bin =20
> >=20
> > The usual pattern is {target}/{machine}, so instead of:
> >=20
> >   microvm/
> >   pc/
> >   q35/
> >   virt/aarch64/
> >   virt/riscv64/
> >=20
> > (which is odd because q35 is the x86 'virt'), I'd rather see:
> >=20
> >   x86/microvm/
> >   x86/pc/
> >   x86/q35/
> >   aarch64/virt/
> >   riscv64/virt/
> >=20
> > Anyhow just my 2 cents, up to the ACPI maintainers :)
> >  =20
> Hi Phil,
>=20
> Your suggestion does make sense to me. Let me wait for feedback from
> ARM/ACPI maintainers.

I'd prefer  {target}/{machine} hierarchy like Philippe suggests

> Thanks,
> Sunil
>=20


