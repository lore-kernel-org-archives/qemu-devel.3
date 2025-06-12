Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFACC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 12:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPhNu-0002wh-LS; Thu, 12 Jun 2025 08:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPhNs-0002wH-TF
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPhNq-0001qo-Op
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749732616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lFhxRtUAdJGBztxdsbcyW9odsc9OfWhuK0xDjPtH3o=;
 b=GluziHWRrRTYYpfgPFY5cS9t8MBypylC5HWoSIxQwLY1PvnWqaPDq73pyvfYckVdN9qbiy
 /OKVkzZuhJ3+fCWCWW3eoR4t6AD+6YyAXLb3/HCwnYLVWxdgqqNBgEwkiT1fpNxP7J8g4X
 78ZVENl+i7JAjAQlNvWH//TO/0cP7W0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-5MR4po14NzSHiwFsO0Lz1w-1; Thu, 12 Jun 2025 08:50:14 -0400
X-MC-Unique: 5MR4po14NzSHiwFsO0Lz1w-1
X-Mimecast-MFC-AGG-ID: 5MR4po14NzSHiwFsO0Lz1w_1749732612
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4e6d426b1so1073509f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 05:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749732612; x=1750337412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lFhxRtUAdJGBztxdsbcyW9odsc9OfWhuK0xDjPtH3o=;
 b=VLLv5b0YXkIHBGctDiOKj0l2ByoyHODvmI1nItwO2gzpXZYicT1Jsx22I4YK8UbtoL
 oEXqW2T433i4cvIxOQqj31RlgLJqzCH1obIBYFp1Av25gsLsvOLdbPP1ysOrQmBzQB3M
 S5diQ8BzgvK+8ffqEEic5ahViC8niKohrcOiukFYxOAEBuHwyKsyZb3b/3nbtlS0CGBE
 AfR3SaF3EESv+tqg6h6hU2XREgK/Nf0PrGdNauPMeMOCHxfK0NFX056DYirUex64PCmD
 n80CCwxzkBEt2zMNruJGN9aFs/rr6Qmq0NWMtiHpgD0PC32gZdY05iDdA7MjI2J5BfqD
 VDYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5lodV7fytTtFDlM5ONpIfkhJuEcPoAlT030Pddw6r23dyyrcX+/uBkGxZ2E/Qy8/haX/f8im7yfiz@nongnu.org
X-Gm-Message-State: AOJu0YzpdWK0NP5zJ58ikQO585885crDcQdZZIcPQTW7QkQBYt5VWsD6
 vE4UIjntwUnrL4n1OumPo/NAXaiLFuUaNwPAjUgzhlrIDZNdkElqhNOGre10q1hp1Fap38eo8u4
 pFZiQYG6PVCutIULQkqOlkfW5BMnlOxdj2VKH31d8O/+fi+LRRy6Wf77b
X-Gm-Gg: ASbGncs7IZbOl0IAGyJpnUldIZDa+UaELfmqu38D9Cq37tUMcag/YfVIvTtE3FTcnBh
 QGw7c7poMmvGrnRCwqGXLuzUNMhJlVG3iQsPavAuKP4G5lUM78JDQXwGYhpdcuYNPGp45w59IDa
 uI5IB/Gobzw6f3aJCM+Ep4opZLhL5RZ7ScMNqQ6fUdf+NlhGqa8c/kHzwzo6d6Lh/I5BXHe+l4l
 TheJY4VkLtzS4c+uI0RgK1lB/fTj0mqIa7BzAd4JA76EJwJEh/VzVmUtK46dHHYsqhCSjqoihnD
 sSv9Fm7pJwLM7Tm5mBTd0QYvYSn1EkNt9hajsX34A8I=
X-Received: by 2002:a05:6000:40e1:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a5607fa69emr3046021f8f.18.1749732611907; 
 Thu, 12 Jun 2025 05:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6o/t6QxOgeJ0B48RL0PPBg4I1OpsgEFatHOkGg49x9CNWeUKVdB78pNeJgIP9WNjtor9fQ==
X-Received: by 2002:a05:6000:40e1:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a5607fa69emr3045980f8f.18.1749732611447; 
 Thu, 12 Jun 2025 05:50:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e2522b1sm19433325e9.25.2025.06.12.05.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 05:50:11 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:50:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
Message-ID: <20250612145009.28d69876@imammedo.users.ipa.redhat.com>
In-Reply-To: <848ad5cf-7e83-49bd-8547-ac757c918fdf@linaro.org>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
 <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
 <6a5776b4-73ef-427b-b4e4-b25031b0ce53@linaro.org>
 <20250530135103.09030cf0@imammedo.users.ipa.redhat.com>
 <bcc200fb-fa45-44ac-9e36-4c829becbf1c@linaro.org>
 <e3bc87d8-5016-455e-933d-6cefae993c25@linaro.org>
 <20250611105437.5ecda7c9@imammedo.users.ipa.redhat.com>
 <848ad5cf-7e83-49bd-8547-ac757c918fdf@linaro.org>
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

On Wed, 11 Jun 2025 10:14:55 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Igor,
>=20
> On 6/11/25 05:54, Igor Mammedov wrote:
> > On Tue, 10 Jun 2025 11:29:02 -0300
> > Gustavo Romero <gustavo.romero@linaro.org> wrote:
[...]
>=20
>=20
> BTW, why did we ultimately choose to commit blobs instead of the actual A=
CPI
> code (as generated by iasl)? I'm just wondering if we could avoid committ=
ing
> the blobs to 1) avoid committing binaries and 2) have the changes in the
> ACPI code in the same commit that changes the ACPI itself.
>=20
> If that's only for historical reasons maybe I can improve the bios-tables=
-test.c
> to handle the ACPI code/struct in text format, avoiding the blobs, so I a=
sk.


We've had this for binary blobs at the beginning, however iasl output was
a moving target (whether it's ASL or AML) hence it proved to be unsuitable
for testing infrastructure (and not only testing, I don't remember concrete=
 bugs though).

As result, we've switched to custom AML generator (aml_foo() API) with
blobs it has generated. ASL output by IASL in tests is used by maintaners
for diagnostic (/documenting) purposes only.

> Thanks!
>=20
>=20
> Cheers,
> Gustavo
>=20
> >>
> >>
> >> Thanks,
> >> Gustavo
> >>     =20
> >>>
> >>> Cheers,
> >>> Gustavo
> >>>     =20
> >>>>    =20
> >>>>> Cheers,
> >>>>> Gustavo
> >>>>>    =20
> >>>>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.htm=
l 4/5
> >>>>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.htm=
l 5/5
> >>>>>>>
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>> Gustavo =20
> >>>>>>>>>
> >>>>>>>>> ---
> >>>>>>>>>
> >>>>>>>>> [Eric] also added acpi-pcihp=3Doff to test_acpi_aarch64_virt_tc=
g_numamem
> >>>>>>>>> ---
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 tests/qtest/bios-tables-test.c | 13 +++++++=
++----
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 1 file changed, 9 insertions(+), 4 deletion=
s(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-=
tables-test.c
> >>>>>>>>> index 0a333ec435..6379dba714 100644
> >>>>>>>>> --- a/tests/qtest/bios-tables-test.c
> >>>>>>>>> +++ b/tests/qtest/bios-tables-test.c
> >>>>>>>>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_me=
mhp(void)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.variant =3D ".=
memhp";
> >>>>>>>>> -=C2=A0=C2=A0=C2=A0 test_acpi_one(" -machine nvdimm=3Don"
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0 test_acpi_one(" -machine nvdimm=3Don,acpi-p=
cihp=3Doff"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -cpu c=
ortex-a57"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -m 256=
M,slots=3D3,maxmem=3D1G"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -objec=
t memory-backend-ram,id=3Dram0,size=3D128M"
> >>>>>>>>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_nu=
mamem(void)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.variant =3D ".=
numamem";
> >>>>>>>>> -=C2=A0=C2=A0=C2=A0 test_acpi_one(" -cpu cortex-a57"
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0 test_acpi_one(" -machine acpi-pcihp=3Doff"
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -cpu cortex-a57"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -objec=
t memory-backend-ram,id=3Dram0,size=3D128M"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -numa =
node,memdev=3Dram0",
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data);
> >>>>>>>>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_px=
b(void)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to solve th=
e conflicts.
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.variant =3D ".=
pxb";
> >>>>>>>>> -=C2=A0=C2=A0=C2=A0 test_acpi_one(" -device pcie-root-port,chas=
sis=3D1,id=3Dpci.1"
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0 test_acpi_one(" -machine acpi-pcihp=3Doff"
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -device pcie-root-port,chassis=
=3D1,id=3Dpci.1"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -devic=
e virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.1"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -drive=
 file=3D"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tests/d=
ata/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> >>>>>>>>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_ac=
pi_hmat(void)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.variant =3D ".=
acpihmatvirt";
> >>>>>>>>> -=C2=A0=C2=A0=C2=A0 test_acpi_one(" -machine hmat=3Don"
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0 test_acpi_one(" -machine hmat=3Don,acpi-pci=
hp=3Doff"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -cpu c=
ortex-a57"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -smp 4=
,sockets=3D2"
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -m 384=
M"
> >>>>>>>>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(vo=
id)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.smbios_cpu_max=
_speed =3D 2900;
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.smbios_cpu_cur=
r_speed =3D 2700;
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_acpi_one("-cpu=
 cortex-a57 "
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-machine acpi-pcihp=3Doff "
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-smbios=
 type=3D4,max-speed=3D2900,current-speed=3D2700", &data);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_test_data(&dat=
a);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 }
> >>>>>>>>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_to=
pology(void)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_acpi_one("-cpu=
 cortex-a57 "
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-machine acpi-pcihp=3Doff "
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-smp so=
ckets=3D1,clusters=3D2,cores=3D2,threads=3D2", &data);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_test_data(&dat=
a);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 }
> >>>>>>>>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(v=
oid)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_acpi_one("-cpu=
 cortex-a57 "
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-machine acpi-pcihp=3Doff "
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-device=
 virtio-iommu-pci", &data);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_test_data(&dat=
a);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 } =20
> >>>>>    =20
> >>>>    =20
> >>>     =20
> >> =20
> >  =20
>=20


