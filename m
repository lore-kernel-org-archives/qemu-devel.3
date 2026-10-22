Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA1606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCrDT/jq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pNhK0y+u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqxs-0003Wz-Eh; Thu, 22 Oct 2026 07:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xJqxq-0003Wa-4z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xJqxn-00053g-LB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792668481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00UmlI5+nUvlwAPn8mrJYN/bBw2ge8d39LI9PjitAwY=;
 b=OCrDT/jqv9pPdbbBypXEDJFFhbZO3T7xFkJsaHCEU2ZEqIE8kO4t0b9m5nxwrGWk8PNY8K
 knwaSHtQbtshBeFhNlWZ7Lo37lA8zbsVymsVtIA+OEemCA0pij7c8cDRo2mVF7FUIbBkIV
 vBerC3qTYKOojJ/2Peb7taohXPrEN9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5BjFlKhsP724G8PgJbx36A-1; Thu, 22 Oct 2026 11:28:00 +0000
X-MC-Unique: 5BjFlKhsP724G8PgJbx36A-1
X-Mimecast-MFC-AGG-ID: 5BjFlKhsP724G8PgJbx36A_1792668479
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48dfa054f26so1309492f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792668479; x=1793273279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=00UmlI5+nUvlwAPn8mrJYN/bBw2ge8d39LI9PjitAwY=;
 b=pNhK0y+uKDaQR3UCMH4O/1KdjBFno0QSGIE46VLW8UzThSiNRj8LmPdrG9oTb7FJTz
 MBqWcAYdlAY0744xntP/UxUwEJC6tLDQBWeHYJ3PzHhSPxnjjglAwfUKTsSvuPpWNe05
 MA6WXChZ0U5O3qNs608APQ/UviRiYLoXMCEwwTKAB4FOcWthdjV+54LYLeIWl9TgYWwI
 QhJgJTsO6dLcVl5spS3JiOUZ2jOuEbpUGOyhyUccjWZ39jUtHBkNJJQvL0RkccZ2RFFa
 rtIWXXC8fEIAb9njt5qS+xdNCESOS7avFpK+3pxVImSU+9CQ0zIpgVIV7aytAvhYyPXe
 blLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792668479; x=1793273279;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=00UmlI5+nUvlwAPn8mrJYN/bBw2ge8d39LI9PjitAwY=;
 b=czvXseE+3DgxR5GWky/wW912UQ3HKWUw8yegB2GmdyIOiAAdtWa216rjOgY9+0nmS6
 GN9jdzDOwGzQevFNRzfgD8rjv1+GRFo7lqfh+CvTKBnCKvgVEyVdHlHgkFlGMJKMvTOA
 C8AitSFfXBcKLLIV1c3VeUj3PIM8r/e3bMtK8VlTf9iEJZ9eDc1Sd9n1mCZIVEb0e0Em
 utdQjbYp/PH4PfkJnPPVggYb82hahqcZSb8kGs9Rf+cTZM2A6Qpq2szfTXuIyREihtfb
 JJMxSPB6KUeI1OpxGZTwHK1tgH620Daeg4IkeOh6sOk+XygoT7YeBOV5mf8hEs068wgM
 z4Lg==
X-Gm-Message-State: AFq9FYLX+W2PM4RBZp9wpugImYjrC9VjkqxPA4IOlnwzUkP0aiC1LOJu
 F6csH4Pg2zwK+gIzz5fWWH4Q9Rx9yFO3TqR397MFhs+Jrnl0mbr5i51ZapMT6DmY/ootvRX1FiG
 eis7fSbFBncWy08Oiln/OM4EDF+qQayMMKphRmZx4ud4N7kyWLkOMA71G
X-Gm-Gg: AYBFou0WKpQpLaoeiFY5oR2SRnBngV3RTgY3nKJTcb3dKJEbfmgnkhxY/YV+D24pW3H
 rke/HkKCyoBq6dDFZcVAUWvjYWLkSvR90hQTBElOzEq4MiKktluKuWVir8FecG52ldUJ2c8xOwQ
 APqpMnbEJAaJx0UhgV+KXZ+Jzycaf0D0Dgk75B2GGaKoJK1T1cwtWu4OR1xn4rD7vKIal7nsniE
 sUlZxXJh2z+NRGdk7Bq2f+JEYkDnrYnimWmtSh50L3cb/8jvXgIZvX1imMedMhx1jam9rJJaPdp
 4V3vhHZPLIUAM9CV/Pov1CLOlkGocj8AhFUC3wryLqk4MHmq3hoXX+mB1Kc=
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e2642ce22mr11855202f8f.2.1792668478964; 
 Thu, 22 Oct 2026 04:27:58 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e2642ce22mr11855153f8f.2.1792668478524; 
 Thu, 22 Oct 2026 04:27:58 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583ffa8sm12050264f8f.51.2026.10.22.04.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:27:58 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:27:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: way sorry <waysorrypub@gmail.com>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, jiaxun.yang@flygoat.com, mst@redhat.com,
 anisinha@redhat.com
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt-acpi-build: Drop UART _DSD
 clock and add _STA
Message-ID: <20261022132757.0f197972@imammedo>
In-Reply-To: <CAECqSzWt5gP91iOnoGcKymSYp_O6vt8=7s6-Mg616S_VVREYbg@mail.gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
 <20261022072238.319308-3-waysorrypub@gmail.com>
 <20261022101845.381dd1a6@imammedo>
 <CAECqSzXF6a2P9-tz_xRP8+t_RQUYRjgsRhQtMygnRLJJtvHPTg@mail.gmail.com>
 <CAECqSzWt5gP91iOnoGcKymSYp_O6vt8=7s6-Mg616S_VVREYbg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 17:25:00 +0800
way sorry <waysorrypub@gmail.com> wrote:

> Hi Igor,
>=20
> One additional observation: QEMU's x86 ISA serial implementation explicit=
ly
> defines _STA =3D
> 0x0f in serial_isa_build_aml(), rather than relying on the ACPI default:
>=20
> https://github.com/qemu/qemu/blob/8967b2fe1b2aaae3c29e207d85fab901d580a2d=
c/hw/char/serial-isa.c#L101
>=20
> I think following the same approach for LoongArch UART would be reasonable
> for consistency.

preexisting code in this case is not a good example to follow.

if it works without adding unnecessary stuff, do not add it.


DSD and CCA changes are also unrelated =3D> separate patches

>=20
> Thanks,
> pillow
>=20
> On Thu, Oct 22, 2026 at 5:01=E2=80=AFPM way sorry <waysorrypub@gmail.com>=
 wrote:
>=20
> > Hi Igor,
> >
> > The _STA method was added in response to Bibo's review comment on the
> > original patch, where
> > he explicitly suggested adding _STA.
> >
> > I understand your concern that omitting _STA already implies 0x0f.
> > However, the two review
> > comments seem to suggest different approaches.
> >
> > I'm happy to split the changes into separate patches as required. For
> > _STA, though, I'd
> > appreciate it if we could first agree on whether it should be added or
> > omitted, so I have a clear
> > direction for the next version.
> >
> > Thanks,
> > pillow
> >
> > On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM Igor Mammedov <imammedo@redhat.=
com> wrote:
> > =20
> >> On Thu, 22 Oct 2026 15:22:36 +0800
> >> pillow <waysorrypub@gmail.com> wrote:
> >>
> >> ... =20
> >> > @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, in=
t =20
> >> index)
> >> ... =20
> >> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f))); =20
> >>
> >> also is it really necessary? Doesn't missing _STA imply 0xF already?
> >> =20
> >> >      crs =3D aml_resource_template();
> >> >      aml_append(crs,
> >> >          aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIX=
ED, =20
> >>
> >> =20


