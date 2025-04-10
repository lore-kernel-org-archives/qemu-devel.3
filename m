Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E91BC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 06:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2lkr-0000PC-FU; Thu, 10 Apr 2025 02:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u2lkV-0000I1-LC
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u2lkS-0006dj-RE
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744267850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTm3jxIp5j55tgccKANvtb9WBAkFtdMn3VAIesopr4Q=;
 b=DhKa4BW7qixGybnOQ2xocLNKJ9oElnHtHQgUWJ+mf0bkFuAoq/+ShcLB4v69ZBduhAgO9D
 pPdVGIFQ0Oln49TVTN3oOX5Zhs/9oe+L/ANdBibLhReStf/XJAcMYqIkoyj0WEt4ng9lnQ
 BHKJk7/C/SPLcez43zkdWFNujW1G7Fo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-j29WBpWJOHmdd22oXqZFGA-1; Thu, 10 Apr 2025 02:50:45 -0400
X-MC-Unique: j29WBpWJOHmdd22oXqZFGA-1
X-Mimecast-MFC-AGG-ID: j29WBpWJOHmdd22oXqZFGA_1744267844
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so157321f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 23:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744267844; x=1744872644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTm3jxIp5j55tgccKANvtb9WBAkFtdMn3VAIesopr4Q=;
 b=IJZZweuBCE9NjMucrHxODlfEq03RNKAdlQaIri/aIpR1Z2ZyVXWly3ZmnOZnsIQI2A
 Pf0b0fOSpaWzSoXbLDR6pQGFhBs8YDmhvAdPZA94WfxWqPGSya1fcXz1WdHYE/IjOPbs
 6txNUzrFyp0D0T3L5cDoJVv4gAcIv0Mx63kpD9uDum7BOmNxeoEbNFF7pKL0/wVvNlMl
 m/UQ1n+nyHr6fRSm+B0WNtZY1Qh2dk43AM5MePXX6Eq3QFs19dqKAZkCogiGXp6+fsGw
 Jmsd1diuyvT7CAtE7wb2koimArRMsG75xV/orsKBYQwc5g7himjqpMKFtrEdxCXWsXlY
 1elg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF/i94VDGVqxJAOZx//TQVeInkNDgDvb+fI4JlfGYVkTinTaGntGtFKBZkDhLh/A1tSr4vrLNFtECt@nongnu.org
X-Gm-Message-State: AOJu0YyHxas9URGtRs0n4sjRm/72+fjZpUw9sfnYEfrxdZ+DWPR49xKk
 NhloUVWyfX3lvAhisp7jNQZRRhxDLm17K1DFjl8s65z0k987+G9IJ3CgZqsiXJlgrCBw6KnHyaU
 9O3St0WQ3UAfKxQ2elm8hHQw9nIXMgq9IHxc93XuG3BkdLtLNf7l3
X-Gm-Gg: ASbGncuBrC7A9kN9sn88PUMUIeTitg/imN/x1Eywa4/HUMOhv365tXJA6iOupE1pD6j
 qz3OxDkf7FQ24zaANo18FCRrqoq96agsyKMP1FDkVBae8LXMi41eCpk5pwpaYJtBHArFoYdpAoI
 X10u85mbR/cg2QlsGMmHyFX+XdHM4zVnpLmZRqv/W/1IvDp8tHY+CZQULIbx0YAHCuYbMgrNhWu
 LfM6sJs/VjFQekf7Kvcn+0stcMZr7ZOXuG4usY98L6ou4tKWg+TDuebPBAO635pdDnGT74YgE3Z
 PAA3OhghICSP8E/+q7UC0/8Vx9pCP3aA
X-Received: by 2002:a5d:64e3:0:b0:39a:cc34:2f9b with SMTP id
 ffacd0b85a97d-39d8f469224mr1259019f8f.16.1744267844408; 
 Wed, 09 Apr 2025 23:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+sGnmHAP9/Ng0YNJ3tJ7n+9MoCU2TDkRBgyrXjtCdQfXB1OVokNzefdw/+JEgo5NO6Tc2nQ==
X-Received: by 2002:a5d:64e3:0:b0:39a:cc34:2f9b with SMTP id
 ffacd0b85a97d-39d8f469224mr1258991f8f.16.1744267844033; 
 Wed, 09 Apr 2025 23:50:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893631b5sm3740705f8f.3.2025.04.09.23.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 23:50:43 -0700 (PDT)
Date: Thu, 10 Apr 2025 08:50:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org, Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
Message-ID: <20250410085042.6aa5593d@imammedo.users.ipa.redhat.com>
In-Reply-To: <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
 <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
 <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 9 Apr 2025 12:49:36 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Igor,
>=20
> On 4/9/25 11:05, Igor Mammedov wrote:
> > On Fri, 4 Apr 2025 00:01:22 -0300
> > Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >  =20
> >> Hi Phil,
> >>
> >> On 4/3/25 17:40, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
> >>> test. In preparation, copy the ACPI tables which will be
> >>> altered as 'its_off' variants, and whitelist them.
> >>>
> >>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>>    tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
> >>>    tests/qtest/bios-tables-test.c              |   1 +
> >>>    tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
> >>>    tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
> >>>    tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
> >>>    5 files changed, 4 insertions(+)
> >>>    create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
> >>>    create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
> >>>    create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> >>>
> >>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtes=
t/bios-tables-test-allowed-diff.h
> >>> index dfb8523c8bf..3421dd5adf3 100644
> >>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> >>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> >>> @@ -1 +1,4 @@
> >>>    /* List of comma-separated changed AML files to ignore */
> >>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> >>> +"tests/data/acpi/aarch64/virt/FACP.its_off",
> >>> +"tests/data/acpi/aarch64/virt/IORT.its_off", =20
> >>
> >> I think your first approach is the correct one: you add the blobs
> >> when adding the new test, so they would go into patch 5/9 in this seri=
es,
> >> making the test pass without adding anything to bios-tables-test-allow=
ed-diff.h.
> >> Then in this patch only add the APIC.its_off table to the bios-tables-=
test-allowed-diff.h
> >> since that's the table that changes when the fix is in place, as you d=
id in: =20
> >=20
> > if APIC.its_off is the only one that's changing, but FACP/IORT blobs ar=
e the same
> > as suffix-less blobs, one can omit copying FACP/IORT as test harness wi=
ll fallback
> > to suffix-less blob if the one with suffix isn't found. =20
>=20
> OK. Just clarifying and for the records, this is not the case for this se=
ries
>=20
>=20
> > if blobs are different from defaults then create empty blobs and whitel=
ist them in the same patch
> > then do your changes and then update blobs & wipeout withe list. =20
>=20
> Thanks for confirming it. That's what I suggested to Phil in my first rev=
iew and what
> I understood from the prescription in bios-tables-test.c.
>=20
> However, on second thoughts, for this particular series, isn't it better =
to have the following commit sequence instead:
>=20
> 1) Add the new test and the new blobs that make the test pass, i.e. APIC.=
suffix, FACP.suffix, and IORT.suffix (they are different than the default s=
uffix-less blobs)

blobs should be a separate commit (that way it's easier for maintainer to r=
ebase them,
if they clash during merge with some other change.

> 2) Whitelist only the APIC.suffix since that's the table that will change=
 with the fix
> 3) Add the fix (which changes the APIC table so a new APIC.suffix blob is=
 needed and also stops generating the IORT table, so no more IORT.suffix bl=
ob is necessary)
> 4) Finally, update only the APIC.suffix blob and remove the IORT.suffix b=
lob and wipe out the whitelist
>=20
> This way:
>=20
> A) It's clear that only ACPI blob changed with the fix, because there is =
no addition of a FACP.suffix blob in 4) (it remains the same)
> B) It's clear that the IORT table is removed with the fix and is not rele=
vant anymore for the test

I'd just mention it in commit log so  that later no one would wonder why we=
 are adding and then removing tables

As for the rest of suggestions, it looks fine to me.

>=20
> What do you think?
>=20
>=20
> Cheers,
> Gustavo
>=20
> > Phil,
> > the process is described in doc comment at the top of tests/qtest/bios-=
tables-test.c
> >  =20
> >> https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg07082.html
> >>
> >> Plus, adding the blobs, which are actually related to the test in the =
other
> >> patch, and ignoring them at the same time looks confusing to me. I und=
erstand
> >> that only the blob that changes (APIC.its_off) with the fix should be =
temporarily
> >> ignored and, later, updated, as in your first series.
> >>
> >>
> >> Cheers,
> >> Gustavo
> >> =20
> >>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables=
-test.c
> >>> index baaf199e01c..55366bf4956 100644
> >>> --- a/tests/qtest/bios-tables-test.c
> >>> +++ b/tests/qtest/bios-tables-test.c
> >>> @@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(=
void)
> >>>        test_data data =3D {
> >>>            .machine =3D "virt",
> >>>            .arch =3D "aarch64",
> >>> +        .variant =3D ".its_off",
> >>>            .tcg_only =3D true,
> >>>            .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> >>>            .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> >>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/a=
cpi/aarch64/virt/APIC.its_off
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..c37d05d6e05805304f10a=
fe73eb7cb9100fcccfa
> >>> GIT binary patch
> >>> literal 184
> >>> zcmZ<^@O0k6z`($=3D+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
> >>> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
> >>>
> >>> literal 0
> >>> HcmV?d00001
> >>>
> >>> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/a=
cpi/aarch64/virt/FACP.its_off
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b=
25d3a4127eeef227434
> >>> GIT binary patch
> >>> literal 276 =20
> >>> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ =20
> >>> CVg~^L
> >>>
> >>> literal 0
> >>> HcmV?d00001
> >>>
> >>> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/a=
cpi/aarch64/virt/IORT.its_off
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..0fceb820d509e852ca084=
9baf568a8e93e426738
> >>> GIT binary patch
> >>> literal 236
> >>> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=3DRgMkDCNC*yK9F_<M77!bR =
=20
> >>> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@ =20
> >>> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
> >>>
> >>> literal 0
> >>> HcmV?d00001
> >>>     =20
> >> =20
> >  =20
>=20


