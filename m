Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC54CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 12:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwKNY-0000Vr-Et; Wed, 10 Sep 2025 08:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uwKNV-0000VQ-U5
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uwKNR-0000p6-5d
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757508996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNDCvgfAQlgG1E32XNh2vpJNKDollwPjsG4YgO0aDjI=;
 b=fFwk0SxxiO5pOONgq9ER4fHQaKItgtQcOkpebVt+OlT39HymTJfYtha01W5RHSckjcy+yl
 TbwRQr8T7y3H7OB1SBS5i91scCfr5LDaQ4uNQFjZDsC1+RaTlh8zsdaO04yiabZ9AekiaL
 BdR6rD3wk72/d+nvZmYmcIbQ+r5+qW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-LKig3mUMMY2s6txN3XY1sQ-1; Wed, 10 Sep 2025 08:56:35 -0400
X-MC-Unique: LKig3mUMMY2s6txN3XY1sQ-1
X-Mimecast-MFC-AGG-ID: LKig3mUMMY2s6txN3XY1sQ_1757508994
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de13167aaso37193815e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 05:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757508994; x=1758113794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNDCvgfAQlgG1E32XNh2vpJNKDollwPjsG4YgO0aDjI=;
 b=gQbtQFKibWOgZr9b11YhvCqEfZKC32427BsaoAp2vxoYFyFkO5gqwIcUJ8gG/r0pf4
 I7EzczTgVXt208uzB+fagkbajgnV6DgIoC7jS9vFOUWmC6SqaXwUu6NdJ0TxhsolVo8j
 Hg8XwTP0TGeYDaip85GWYTeLGt0o+AX8u6VgPE/OkfZw0BHhLH+c75A5nH2eODK8wnid
 0Art7ZJGfb7sbWwO1k/kOSummVY3Ae7qFR9Ch5IkMm2w2xJEpixsVrpHXSY1dnwdhYnM
 BccmYs71OjLigDDIuKd0V7Id3hvLfDJV2QajYrpfOt4xwyW7O3CpTRWGuxzmo+e9vAws
 4hJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxo0LzJ/qVELu3YzxOxq2PsElzhO0n0VWXfUiVZqzoc6370Hk3hAp8EXer5sQ7e3KfasGHtXBt9KmR@nongnu.org
X-Gm-Message-State: AOJu0YxaKpODU1v9iy1YTLPM16JNh17pPK0S7lRjc1E3UYJRe8sUcAot
 yvS2+ZBVQjj9wHZc4WV3REqVhikkqRoR7CSdTBzg/vs4Eo4lAeZoz2rnC5aNCFWZHWZ+wGFVBje
 E0EPGGHMms7jCfDmp+NbPctNrmYbUHl5AqXIcSgrLQR2Z2BMT54vWk9L+
X-Gm-Gg: ASbGncta3494Chssk3w/LllVvWIn0p1w9cCGTiQdMSoiopDh0drCmRNpsyQuj0D9JBv
 4CqlBe5yIpquRCyQYdS6crFywR0tvXfyYjJ3Tu/yUTJ2LlWW/2tBw83JUlR5LCfY45R7TcTjiIx
 FeQ3427waCHW0gIRdGsKc6nERZmPIJOxNh4WF0uVLIo7ZPEv7EJm7QXMo1ASQWff52QjJ6BhobX
 Gjdp6lQ+dyIq7wiawczdMLXud+4tMRzpFkmdHA2HDEuNU1EwiswzFG37n56ECmiRGzxxUVRuTIT
 LSUBnHr6KcDydTl0ZmKSPRyGiVjXDg==
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id
 ffacd0b85a97d-3e641e3ac00mr12430710f8f.12.1757508994019; 
 Wed, 10 Sep 2025 05:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjnb4CMe4r5ik9LMHFTY757849g5MC68aWPd86fkYPBLO8uRwpavVV2/bSHINtt/xGYpB6lg==
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id
 ffacd0b85a97d-3e641e3ac00mr12430683f8f.12.1757508993605; 
 Wed, 10 Sep 2025 05:56:33 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223f5d7sm6676930f8f.53.2025.09.10.05.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 05:56:33 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:56:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=
 " <berrange@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PULL 24/28] hpet: switch to fine-grained device locking
Message-ID: <20250910145631.32a805dd@fedora>
In-Reply-To: <CABgObfZz8pYRSDMw0Hq+wpcWPL1Oaq_TPtcbSAnLZW0Gr3XSng@mail.gmail.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-25-pbonzini@redhat.com>
 <aL7oe3sis3bKJhLW@redhat.com> <20250910131633.4b66856d@fedora>
 <CABgObfZz8pYRSDMw0Hq+wpcWPL1Oaq_TPtcbSAnLZW0Gr3XSng@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Sep 2025 13:23:10 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Sep 10, 2025 at 1:16=E2=80=AFPM Igor Mammedov <imammedo@redhat.co=
m> wrote:
> >
> > On Mon, 8 Sep 2025 15:30:19 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > =20
> > > Hi,
> > >
> > > This patches causes a regression making QEMU  abort in the KVM Xen
> > > functional test.
> > >
> > > To reproduce please run 'make check-functional-x86_64', or more
> > > specifically run this single test:
> > >
> > >  QEMU_TEST_QEMU_BINARY=3D./build/qemu-system-x86_64 PYTHONPATH=3D./py=
thon:./tests/functional ./tests/functional/x86_64/test_kvm_xen.py
> > >
> > > though I recommend you first add this series:
> > >
> > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01540.h=
tml
> > >
> > > as that fixes an infinite loop in the functional test console
> > > code on QEMU abnormal premature exit. =20
> >
> > I'll try to reproduce and see where it goes wrong =20
>=20
> I've only looked at it briefly, but it fails on the bql_locked()
> assertion of xen_evtchn_set_gsi().
>=20
> I think the assertion can be moved inside "if (gsi && gsi =3D=3D s->callb=
ack_gsi)".

given it's manipulating interrupts,
shouldn't we take BQL when doing so?

I see 2 options here
  1: guard qemu_irq_foo calls inside of hpet.c with BQL_LOCK_GUARD
  2: drop new hpet:lock and use BQL instead of it.

>=20
> Paolo
>=20


