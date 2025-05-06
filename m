Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98662C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKLv-00005U-HL; Tue, 06 May 2025 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uCKLq-0008Tz-UI
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uCKLm-0003DE-Dg
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nATGfPBc00hA6hE52Ziq/xoTNYj7zVigR5hNbi4ZnA8=;
 b=P1BABFVF9CdhkaV37Gb2M7nJ3DSFZr7MMLK0TnDSAW4m44xOeeK8FBNrMqS/6Teld1wAg6
 ySh9OKbKZC8R71NUh36ncTJAiV4i2Nnn0FjpS2fv1V6YZBtAUhuwnw4Ql/yq4iS5PeVClV
 bOWR8lFgYolDqVMAsBoxG+P4np7yG6c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-MTiga8fXMJm5mX2ADYmFJA-1; Tue, 06 May 2025 11:36:46 -0400
X-MC-Unique: MTiga8fXMJm5mX2ADYmFJA-1
X-Mimecast-MFC-AGG-ID: MTiga8fXMJm5mX2ADYmFJA_1746545805
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso34119585e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545805; x=1747150605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nATGfPBc00hA6hE52Ziq/xoTNYj7zVigR5hNbi4ZnA8=;
 b=CK6nT4lnAPp6ylPFIZZK3BN29k9uUKpZ7+ke552ya+6/zRMtPbfekHKPPILV/ej9QY
 7o4SR3uVS+CiZwRrmzv1ljpj4DmDY/Zbs4Tltr4aRkQGef6dbMsEW02/x6DchFh5AB6I
 LG3FFOB5dBCThDCXe7oUtYF3lUu8uAJg9LubwjbvwLBqMHBhlKVbOYFhV3u0I0Uxtzpc
 E3cyPpE5/CHd06qjNHTULFZDWF+QP53fb2g2Dfy3Jk7Hlr1VaiomPqHPUT271jgJ1bKy
 E0oj4koZI9uWzloUKMAYjfSiV0SVT3+vn0/OzW3YI2Pa49sZfmqbbXJQXHMifx3RX7vh
 O69g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaL9Mis3tskVsrrNTw+d2REUTOi+rFENYvStwCsxP8dAJwBfDGkeYg3VAzAtbLI8dQzbmr4pS9k8qI@nongnu.org
X-Gm-Message-State: AOJu0YzYf54ld3FxU/VPOl0fQL3Tif5Ym63F/1eSt0wTd5f9k8zkRIbY
 1s2nxMuoZpOdpLQTf7dJRnOULiYx9NVVjZWaHHCwBnA3ihfF0xycew8LTb1ROVEahZEn3yr+V/o
 3/d56A1AjKMkpY5mqm70273Qen/ohlkFx1RjrMgoP+04F455EARLE
X-Gm-Gg: ASbGncsF7T3MLrS9wL6D/IBsAh56T5NdS2RC3YwYr34mTVzWH9jsyhwoTtL90SURJIy
 ioRn/ojjpo0s3ICoHIA5bIB05AmsQmXwsSTAL85p6Mz9SXiU3wpnjTa07eG8IDOVRB+NdWMb9vo
 ZGcDAkpQUiK5JqvbhwGNEMoanfVU3iH6zKU2W4pa/9p6+b4cmvhCb/lpV9fY7ouzjV23MlZC/EW
 uE7bQGtOhSP+GOySkV840uSg963pCIStQHn6lGEJ31rP0uILk8DW/qe0wATiBYSIe97Tuv1T62p
 fRztbGHjsusazMR8Ju+PjRcuERv2XTC+
X-Received: by 2002:a05:600c:698e:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-441d357bc50mr9792325e9.31.1746545805250; 
 Tue, 06 May 2025 08:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsPPzwFBYJL4E5hYwM+e9IknMcgsDCJCavnzjvUdJCRuaPTdJNw7HeWbv31rjUrDGaWCqTBA==
X-Received: by 2002:a05:600c:698e:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-441d357bc50mr9792035e9.31.1746545804852; 
 Tue, 06 May 2025 08:36:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441c0dfc537sm127699125e9.16.2025.05.06.08.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:36:44 -0700 (PDT)
Date: Tue, 6 May 2025 17:36:40 +0200
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
Message-ID: <20250506173640.5ed03a16@imammedo.users.ipa.redhat.com>
In-Reply-To: <ec5cec94-4d02-442e-94e6-c0c2e79f3684@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
 <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
 <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
 <20250410085042.6aa5593d@imammedo.users.ipa.redhat.com>
 <ec5cec94-4d02-442e-94e6-c0c2e79f3684@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Thu, 10 Apr 2025 13:22:06 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Igor,
>=20
> On 4/10/25 03:50, Igor Mammedov wrote:
> > On Wed, 9 Apr 2025 12:49:36 -0300
> > Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >  =20
> >> Hi Igor,
> >>
> >> On 4/9/25 11:05, Igor Mammedov wrote: =20
> >>> On Fri, 4 Apr 2025 00:01:22 -0300
> >>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >>>     =20
> >>>> Hi Phil,
> >>>>
> >>>> On 4/3/25 17:40, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>>>> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
> >>>>> test. In preparation, copy the ACPI tables which will be
> >>>>> altered as 'its_off' variants, and whitelist them.
> >>>>>
> >>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> >>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>> ---
> >>>>>     tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
> >>>>>     tests/qtest/bios-tables-test.c              |   1 +
> >>>>>     tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
> >>>>>     tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
> >>>>>     tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
> >>>>>     5 files changed, 4 insertions(+)
> >>>>>     create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
> >>>>>     create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
> >>>>>     create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> >>>>>
> >>>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qt=
est/bios-tables-test-allowed-diff.h
> >>>>> index dfb8523c8bf..3421dd5adf3 100644
> >>>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> >>>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> >>>>> @@ -1 +1,4 @@
> >>>>>     /* List of comma-separated changed AML files to ignore */
> >>>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> >>>>> +"tests/data/acpi/aarch64/virt/FACP.its_off",
> >>>>> +"tests/data/acpi/aarch64/virt/IORT.its_off", =20
> >>>>
> >>>> I think your first approach is the correct one: you add the blobs
> >>>> when adding the new test, so they would go into patch 5/9 in this se=
ries,
> >>>> making the test pass without adding anything to bios-tables-test-all=
owed-diff.h.
> >>>> Then in this patch only add the APIC.its_off table to the bios-table=
s-test-allowed-diff.h
> >>>> since that's the table that changes when the fix is in place, as you=
 did in: =20
> >>>
> >>> if APIC.its_off is the only one that's changing, but FACP/IORT blobs =
are the same
> >>> as suffix-less blobs, one can omit copying FACP/IORT as test harness =
will fallback
> >>> to suffix-less blob if the one with suffix isn't found. =20
> >>
> >> OK. Just clarifying and for the records, this is not the case for this=
 series
> >>
> >> =20
> >>> if blobs are different from defaults then create empty blobs and whit=
elist them in the same patch
> >>> then do your changes and then update blobs & wipeout withe list. =20
> >>
> >> Thanks for confirming it. That's what I suggested to Phil in my first =
review and what
> >> I understood from the prescription in bios-tables-test.c.
> >>
> >> However, on second thoughts, for this particular series, isn't it bett=
er to have the following commit sequence instead:
> >>
> >> 1) Add the new test and the new blobs that make the test pass, i.e. AP=
IC.suffix, FACP.suffix, and IORT.suffix (they are different than the defaul=
t suffix-less blobs) =20
> >=20
> > blobs should be a separate commit (that way it's easier for maintainer =
to rebase them,
> > if they clash during merge with some other change. =20
>=20
> I see. What is a bit confusing here is that the series consists in
> one blob addition act (for the new test) and one blob update/removal act =
(after the fix).
>=20
>=20
> >> 2) Whitelist only the APIC.suffix since that's the table that will cha=
nge with the fix
> >> 3) Add the fix (which changes the APIC table so a new APIC.suffix blob=
 is needed and also stops generating the IORT table, so no more IORT.suffix=
 blob is necessary)
> >> 4) Finally, update only the APIC.suffix blob and remove the IORT.suffi=
x blob and wipe out the whitelist
> >>
> >> This way:
> >>
> >> A) It's clear that only ACPI blob changed with the fix, because there =
is no addition of a FACP.suffix blob in 4) (it remains the same)
> >> B) It's clear that the IORT table is removed with the fix and is not r=
elevant anymore for the test =20
> >=20
> > I'd just mention it in commit log so  that later no one would wonder wh=
y we are adding and then removing tables
> >=20
> > As for the rest of suggestions, it looks fine to me. =20
>=20
> Well, 2) won't make sense anymore since APIC.suffix would be already in t=
he
> whitelist in the previous patch that added the empty blobs. Since there w=
on't
> be a commit that adds _only_ the APIC.suffix to the whitelist, in prepara=
tion
> for the fix, this info is "lost" in the series, even tho it's possible to
> mention in the commit message.
>=20
> Hence, what I think is not ideal from a maintainer's/reviewer's perspecti=
ve,
> is that in one commit all the blobs are updated/removed at once, which is
> confusing because the fix did not touch the FACP table (for instance) and
> this table is updated with APIC and with the removal of IORT, altogether,
> in the last commit.
>=20
> So, for this series, which adds new blobs and _also_ updates and removes =
some
> of them, how about the following organization:
>=20
> - Patch 1     : Add the new test, add the empty blobs *.suffix files, whi=
telist such a blobs
> - Patch 2     : Update the blobs in Patch 1 with the ones that make the n=
ew test pass and remove them from the whitelist
>=20
> - Patch 3     : Add the APIC.suffix blob to the whitelist (the table that=
 changes due to the fix)
> - Patch 4 - n : Fix(es)

3 is not bynanry so it can be folded into 4 or be a separate patch (either =
way works for me)

> - Patch (n+1) : Update the APIC.suffix blob, remove IORT.suffix blob, and=
 remove the APIC.suffix blob from the whitelist
>                * Add the APIC diff to the commit log
>                * Mention in the commit log that IORT.suffix is removed be=
cause IORT table is no long generated after the fix
>=20
> This way: a) no commit fails the test and b) blobs are added/updated/remo=
ved in separate commits
>=20
> What do you think?

LGTM

>=20
> Cheers,
> Gustavo
>=20


