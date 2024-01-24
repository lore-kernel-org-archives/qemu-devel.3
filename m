Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71225C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSfqW-0005Fo-Ep; Wed, 24 Jan 2024 11:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rSfqO-00057j-QR
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rSfqM-0005sX-0P
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706112672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfzQ7oebj+jUN+rV7K4SWiwlqpMSqHWM2liXgWiviu8=;
 b=hAa8/f+yketgu8pq81qRBUh/+kDKFB9QLVgGfgJKVsBeFdsYzshYVoC7qpgtRUy3ZJUG+d
 kF4VDgELm8cGbrYUurmiOkxy0oPEYpEhYf7zlNxt4p7PU3UrkJkN1chosnc1owDUPhFOix
 gnDL+U27NVPrKqvUswAdz53OIK0ixH8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-M4zErIeIMVO1NFEdnfyjhA-1; Wed, 24 Jan 2024 11:11:10 -0500
X-MC-Unique: M4zErIeIMVO1NFEdnfyjhA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40eb06001c2so29597845e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 08:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706112669; x=1706717469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfzQ7oebj+jUN+rV7K4SWiwlqpMSqHWM2liXgWiviu8=;
 b=Bk7al3x9nTV4+XF2SqwTHJmKFOmi7/XDCdltY8aHtilCRVNh60bog+70HBgpV98beW
 OVZnKUiecma7BaoFUuAHrbTqXYRbuzt128P0KO7tggXYCEfBV45MTITI5i/Em26Jw3DN
 VDc3FODpX23Ln+9yRuHH3iNm93NRqS3JtWh6MIhgJaj/+Bdm82Uh4g8Bol7hC8l74HrL
 MfaKInXVMv5pvZBwgWxxsb6x8YhdYp66vOrHN+i+5ej7S/pMvDiM6VEMzmADMtRGggHl
 MTVIm6na5CfWqMpjCWDfvF9FU0eTXfaKB/QlkL0yuA1dhctL/8TsE1+h95G2nW9o8xMz
 mcSA==
X-Gm-Message-State: AOJu0YxhjAVA1IL4O13mCRqLgwULTeS92n7KfGi8GDIFefiHHkvCZEAx
 Ecf+gGJe0DJub+TBYtkHcNQ6rhFgFz01nw4Mk9OWcvS2TtABvHqrGo7tNQT4qFVEPg+mIqa1zWu
 N2F0W521xHnxnkw5mcwHAQM/9k8GRIfudN/8lpHMyl9JvPOWttUqA
X-Received: by 2002:a05:600c:6cf:b0:40e:ace1:ebf2 with SMTP id
 b15-20020a05600c06cf00b0040eace1ebf2mr1276915wmn.55.1706112669438; 
 Wed, 24 Jan 2024 08:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmf9W9LRxVqeuEpkVMPZ+m4DhIgjS0rLvHDxC5aW8c+pxoOEeoFrSnluA+OWUahc786ikmVQ==
X-Received: by 2002:a05:600c:6cf:b0:40e:ace1:ebf2 with SMTP id
 b15-20020a05600c06cf00b0040eace1ebf2mr1276905wmn.55.1706112669093; 
 Wed, 24 Jan 2024 08:11:09 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 bd20-20020a05600c1f1400b0040d4e1393dcsm111619wmb.20.2024.01.24.08.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 08:11:08 -0800 (PST)
Date: Wed, 24 Jan 2024 17:11:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Kai <kai.kang@windriver.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, mst@redhat.com
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
Message-ID: <20240124171107.76e15bd3@imammedo.users.ipa.redhat.com>
In-Reply-To: <d9f93bd0-7cf5-4d3b-82b5-349a10ed6862@windriver.com>
References: <20240109092015.4136865-1-kai.kang@windriver.com>
 <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
 <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
 <20240118130730.02ff9194@imammedo.users.ipa.redhat.com>
 <d9f93bd0-7cf5-4d3b-82b5-349a10ed6862@windriver.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 22 Jan 2024 09:59:06 +0800
Kai <kai.kang@windriver.com> wrote:

> On 1/18/24 20:07, Igor Mammedov wrote:
> > On Thu, 18 Jan 2024 14:48:50 +0800
> > Kai <kai.kang@windriver.com> wrote:
> > =20
> >> On 1/18/24 01:31, Peter Maydell wrote: =20
> >>> (cc'd the people listed for this file in MAINTAINERS)
> >>>
> >>> On Tue, 9 Jan 2024 at 13:53, Kai Kang <kai.kang@windriver.com> wrote:=
 =20
> >>>> When this section of source codes were added via commit:
> >>>>
> >>>> * 02e2da45c4 Add common BusState
> >>>>
> >>>> it added devices to bus with LIST_INSERT_HEAD() which operated on the
> >>>> single direction list. It didn't have something like LIST_INSERT_TAI=
L()
> >>>> at that time and kept that way when turned to QTAILQ.
> >>>>
> >>>> Then it causes the fist device in qemu command line inserted at the =
end
> >>>> of the bus child link list. And when realize them, the first device =
will
> >>>> be the last one to be realized.
> >>>>
> >>>> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to ma=
ke
> >>>> sure that devices are added to bus with the sequence in the command
> >>>> line. =20
> >>> What are the problems being caused by the the list items being added
> >>> in reverse order? Your commit message doesn't say what specific
> >>> bug or problem it's trying to fix. =20
> >> The problem I met was just as I asked for for help in the maillist on
> >> Dec 18, 2023.
> >>
> >> The indexes of serial isa devices changes with the commit dcdbfaafe90a
> >> since qemu 6.2.0.
> >> Before the commit, it creates devices literally with "1" & "2":
> >>
> >> @@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(scope, b=
uild_fdc_device_aml(fdc));
> >>   =C2=A0=C2=A0=C2=A0=C2=A0 }
> >>   =C2=A0=C2=A0=C2=A0=C2=A0 aml_append(scope, build_lpt_device_aml());
> >> -=C2=A0=C2=A0=C2=A0 build_com_device_aml(scope, 1);
> >> -=C2=A0=C2=A0=C2=A0 build_com_device_aml(scope, 2);
> >>
> >> After apply the commit, it uses the 'aml builder' way and the devices
> >> are handled in reverse way.
> >> Then the indexes are reversed. It affects guest os such as freebsd. Wh=
en
> >> run `pstat -t` on freebsd
> >> with qemu, the sequence of the output is not right.
> >>
> >> root@freebsd:~ # pstat -t
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LINE=C2=A0=C2=A0 INQ=C2=A0 CAN=C2=A0 =
LIN=C2=A0 LOW=C2=A0 OUTQ=C2=A0 USE=C2=A0 LOW=C2=A0=C2=A0 COL=C2=A0 SESS=C2=
=A0 PGID STATE
> >>   =C2=A0=C2=A0=C2=A0=C2=A0 ttyu2=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 IC
> >>   =C2=A0=C2=A0=C2=A0=C2=A0 ttyu3=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 IC
> >>   =C2=A0=C2=A0=C2=A0=C2=A0 ttyu1=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 IC
> >>   =C2=A0=C2=A0=C2=A0=C2=A0 ttyu0=C2=A0 1920=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0 0=C2=A0 192=C2=A0 1984=C2=A0=C2=A0=C2=A0 0=C2=A0 199=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 664=C2=A0=C2=A0 668 ICOi
> >>
> >> It is expected with ascend order which keeps the same behavior with
> >> older version qemu. =20
>=20
> Hi Peter & Igor,
>=20
> Thanks for your reply.
>=20
> > this problem description should be in commit message. =20
>=20
> Will do next time.
>=20
>=20
> > As for fixing it I'd wouldn't touch bus order as Peter already noted
> > it has high chances to break behavior elsewhere.
> >
> > current state of COM naming:
> >     1: QEMU 6.1  all machine types: COM1 { uid: 1, irq: 4}, COM2 { uid:=
 2, irq: 3}
> >     2: QEMU 6.2+ all machine types: COM1 { uid: 2, irq: 4}, COM1 { uid:=
 1, irq: 3}
> > all of above in default case where user doesn't supply 'index' explicit=
ly.
> >
> > With 'index' provided explicitly old case #1 might break due to
> > hardcoded resource values in former build_com_device_aml().
> > #2 (current code) doesn't have issues with resource values
> > when explicit 'index' is used (which can be a possible workaround) =20
>=20
> How to assign explicit 'index' in the command line? I don't figure it=20
> out the option for it.

-chardev sometype,id=3Dfoo[,...] -device isa-serial,chardev=3Dfoo,index=3D0=
[,...]

> > So we essentially have changed enumeration for 6.1 and older
> > machine types in incompatible way with QEMU-6.2+ builds.
> > (and that in it's turn breaks exiting VM config when it
> > is started on QEMU-6.2+)
> >
> > Kai,
> > Does above sum-up the issue you are encountering? =20
>=20
> Yes, it does.

I don't observe index [nor IRQ/IO] swapping in ACPI tables.
test CLI:
  $ qemu -M pc -serial file:/tmp/test1 -serial file:/tmp/test2
QEMU v5.0 (before dcdbfaafe90a) has following serial descriptors:


        Device (COM1)                                                      =
     =20
        {                                                                  =
     =20
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial =
Port */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID                           =
     =20
            Method (_STA, 0, NotSerialized)  // _STA: Status               =
     =20
            {                                                              =
     =20
...                                                            =20
            }                                                              =
     =20
                                                                           =
     =20
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Sett=
ings =20
            {                                                              =
     =20
                IO (Decode16,                                              =
     =20
                    0x03F8,             // Range Minimum                   =
     =20
                    0x03F8,             // Range Maximum                   =
     =20
                    0x00,               // Alignment                       =
     =20
                    0x08,               // Length                          =
     =20
                    )                                                      =
     =20
                IRQNoFlags ()                                              =
     =20
                    {4}                                                    =
     =20
            })                                                             =
     =20
        }

        Device (COM2)                                                      =
     =20
        {                                                                  =
     =20
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial =
Port */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID                          =
     =20
            Method (_STA, 0, NotSerialized)  // _STA: Status               =
     =20
            {                                                              =
     =20
...                                                =20
            }                                                              =
     =20
                                                                           =
     =20
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Sett=
ings =20
            {                                                              =
     =20
                IO (Decode16,                                              =
     =20
                    0x02F8,             // Range Minimum                   =
     =20
                    0x02F8,             // Range Maximum                   =
     =20
                    0x00,               // Alignment                       =
     =20
                    0x08,               // Length                          =
     =20
                    )                                                      =
     =20
                IRQNoFlags ()                                              =
     =20
                    {3}                                                    =
     =20
            })                                                             =
     =20
        }=20

current master branch (v 9.0+):
                Device (COM2)                                              =
     =20
                {                                                          =
     =20
                    Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM=
 Serial Port */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID                  =
     =20
                    Name (_STA, 0x0F)  // _STA: Status                     =
     =20
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resou=
rce Settings
                    {                                                      =
     =20
                        IO (Decode16,                                      =
     =20
                            0x02F8,             // Range Minimum           =
     =20
                            0x02F8,             // Range Maximum           =
     =20
                            0x00,               // Alignment               =
     =20
                            0x08,               // Length                  =
     =20
                            )                                              =
     =20
                        IRQNoFlags ()                                      =
     =20
                            {3}                                            =
     =20
                    })                                                     =
     =20
                }                                                          =
     =20
                                                                           =
     =20
                Device (COM1)                                              =
     =20
                {                                                          =
     =20
                    Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM=
 Serial Port */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID                   =
     =20
                    Name (_STA, 0x0F)  // _STA: Status                     =
     =20
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resou=
rce Settings
                    {                                                      =
     =20
                        IO (Decode16,                                      =
     =20
                            0x03F8,             // Range Minimum           =
     =20
                            0x03F8,             // Range Maximum           =
     =20
                            0x00,               // Alignment               =
     =20
                            0x08,               // Length                  =
     =20
                            )                                              =
     =20
                        IRQNoFlags ()                                      =
     =20
                            {4}                                            =
     =20
                    })                                                     =
     =20
                }                                                          =
     =20
                 =20
The only difference I see is the order in which ports are described in DSDT
but otherwise I'd say descriptors are identical and within ACPI spec.

testing with RHEL9 guest image, serial ports are persistent and
the same between v5.0 and current master QEMU branch
(1st is ttyS0 and 2nd is ttyS1).

All of above hints it's unlikely to be a QEMU issue.
I'd suggest to look into freebsd code and check how it enumerates serial po=
rts.

> Thanks,
> Kai
>=20
> > =20
> >> Regards,
> >> Kai
> >> =20
> >>> In general this kind of patch is something I'm very cautious about,
> >>> because it seems very likely that various bits of the code where
> >>> order does matter will currently be expecting (and working around)
> >>> the reverse-order behaviour, because that's what has been done by
> >>> bus_add_child() for the last 20-plus years. (As one concrete example,
> >>> see the big comment at the top of create_virtio_devices() in
> >>> hw/arm/virt.c. There are probably others where we didn't comment
> >>> on the ordering but just assume it.)
> >>>    =20
> >>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >>>> index 43d863b0c5..5e2ff43715 100644
> >>>> --- a/hw/core/qdev.c
> >>>> +++ b/hw/core/qdev.c
> >>>> @@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceSta=
te *child)
> >>>>        kid->child =3D child;
> >>>>        object_ref(OBJECT(kid->child));
> >>>>
> >>>> -    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
> >>>> +    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
> >>>>
> >>>>        /* This transfers ownership of kid->child to the property.  */
> >>>>        snprintf(name, sizeof(name), "child[%d]", kid->index); =20
> >>> thanks
> >>> -- PMM =20
> >> =20
>=20


