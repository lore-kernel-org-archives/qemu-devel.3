Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4ADC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYql-0001F8-Pr; Tue, 02 Jul 2024 04:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOYqj-0001Eq-IA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOYqh-0005BS-8b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719908809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JouCl5LVTjGL+RgiZGdtfwswkj49GBs2KclvIvisut4=;
 b=g5kuHBlOMw+RG0YVkZbGrzjqQq+dZf/SqO9WCRlhn75ukebQM86wn1Jsn3o5KSp0WyIn5l
 m2ZEvGLa2yHIUdII3z2oKEv/tik2eiy0ZS+vImBw+D9stgYPgUjNVkWONBHZcOPEu6cQFH
 j4+q8rGsaxvWGZSq/Bd/5j/UgRbRP3c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-CCCrsxXpPR6ixeJw8-EIpA-1; Tue, 02 Jul 2024 04:26:47 -0400
X-MC-Unique: CCCrsxXpPR6ixeJw8-EIpA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e6e454663so4352046e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 01:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719908806; x=1720513606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JouCl5LVTjGL+RgiZGdtfwswkj49GBs2KclvIvisut4=;
 b=HG49zqQBjzl2onQzlxg6oaAzF83DmhlDhvCFoQWN8BoDKHVuMI9FffiV5+qyBpQPmc
 wsw2MnHQxeft3PKkiI3ry1dGYr+Vv1+4DQS/r6UqgHLZsXBXC6HJco0Emh4jy8yPwmxt
 cKuBnFHd91SSpPMPz0ABfo2xr1GY3JUIAtOZlFnSbEUwuYY+Pf7JSNkKHOwnBeBtnOf8
 tY2w7PEIRmdRUEhj0rtTY40caxDW9Q0q37zw6yLxBW47yeOe6U9VvvEKJPLLGBIR2Kxf
 KPnAQqiybocVlKvIcwo63zapmnRy3rWRqFNcVQH4/JFVhugKNNOIp2N+HGUqXvcmHVes
 0Kig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQlSSE/rY7LbyNKy576HkZg+Q+lGOeYIiW3MiAARZ8f/N8l+smOaiZv245cV2snumeaMmnMyHnHaRkEY0+FS+mHOWrlIU=
X-Gm-Message-State: AOJu0Yx5iBYx3x7P2mG/uJaFjwrdhiOcN3mSLJZVDGg52XKsyh6VX/lY
 lxi0ahG2ZzTD/xdJgbhxBjQRJVZ1/KtdaYzUXCdTEPIWz2OAzc06NwerQPCg8gzKiMfh6VLesfo
 QwTPYP24IjEDQbbVDMIaFWynge94AayRtSX00AP6IAdne0nZWyDAS
X-Received: by 2002:a05:6512:3988:b0:52c:df5f:7b4e with SMTP id
 2adb3069b0e04-52e82686102mr5742124e87.38.1719908805950; 
 Tue, 02 Jul 2024 01:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgvO34RLLyIr+D37ZB7xV/ko8ODkn0t1GPdVs5qkz9YTq39Qqkp+Znc2LluhPgIn4Rf48Hsg==
X-Received: by 2002:a05:6512:3988:b0:52c:df5f:7b4e with SMTP id
 2adb3069b0e04-52e82686102mr5742086e87.38.1719908804524; 
 Tue, 02 Jul 2024 01:26:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cff9sm186196315e9.3.2024.07.02.01.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 01:26:44 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:26:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <20240702102642.22f89d81@imammedo.users.ipa.redhat.com>
In-Reply-To: <bdf1a67fa18249cb9947adba8732323f@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>
 <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
 <02403c2f69574128a1700d8b3db37381@baidu.com>
 <b7fmdp5joww5plrwr3hfedv4zfoicxrzbtynaoui452y4zrtq2@hi236cyermam>
 <bdf1a67fa18249cb9947adba8732323f@baidu.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 1 Jul 2024 14:27:50 +0000
"Gao,Shiyuan" <gaoshiyuan@baidu.com> wrote:

> > > > > If I want to use ACPI PCI hotplug in the pxb bridge, what else ne=
ed to be done? =20
> > > >
> > > > does it have to be hotplug directly into pxb or
> > > > would be it be sufficient to have hotplug support
> > > > on pci-bridge attached to a pxb? =20
> > >
> > > It's sufficient to hotplug support on pci-bridge attached to a pxb. =
=20
> >
> > ... but I guess using this instead would be better anyway? =20
>=20
> https://lore.kernel.org/all/20220422135101.65796823@redhat.com/t/#r831d58=
9f243c24334a09995620b74408847a87a0
>=20
> According this message, It seems that the current QEMU does not support i=
t yet.=20
> I tried to hotplug on pci-bridge attached to a pxb, no device found in th=
e guest.

SHPC works for q35, which provides _OSC.

It is broken for pc machine though, since machine lacks either _OSC or OSHP.
Theoretically SHPC should still work for hotplugged bridges
(i.e. with ACPI hotplug enabled, when one hotplugs a bridge into
pci.0, but I haven't tried that lately)

I'm still not sure if we should make OSHP global, or put it only
under bridges that have shcp=3Don && don't have ACPI hotplug.
The later seems cleaner though.

> >
> > take care,
> > =C2=A0 Gerd =20
>=20


