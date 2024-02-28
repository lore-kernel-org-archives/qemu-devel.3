Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2AEC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfKSq-0006PG-27; Wed, 28 Feb 2024 08:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfKSn-0006Nw-Lv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:59:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfKSl-0002Ax-Mg
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709128750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63Y438QjEUyEXnLfBMLdE8BUfRbVj8qdIQItUvIGdl4=;
 b=LYdnjvG8NzLk7rnfMTVUx1TeoZrataqSw3zS1I8iphtklvoXGh27wpxSPkrGJAGkOtskqx
 jyFT2mRxu8tmdjLWu0TUzSRW/OoZvyULxJXa7oBq7FC89sgFOwJeDtD7WgUHp2rPX7gNXW
 AitH2kDKMcfjW1kVMP9+kPnWhjIrS+U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-RAsBDdgdOXeCBR0rHBOyVg-1; Wed, 28 Feb 2024 08:59:08 -0500
X-MC-Unique: RAsBDdgdOXeCBR0rHBOyVg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412b49e13e4so2543705e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 05:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709128748; x=1709733548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63Y438QjEUyEXnLfBMLdE8BUfRbVj8qdIQItUvIGdl4=;
 b=AWCYDpVmB95ygQySUAfybAvYHsKr2asZgp5D/DKeNg0H6WAQKWjR52qKAxmeiVYlrw
 zy8ZJedGO0fWx7qRVBjDyTFiP8IR6leQZo7Rqad+V/4KpL0OluwwsCwzklFHFlamYvFR
 quTT+McNfFs/4ujj1kGjp9dF9rV4dUX1beAOmhGQ9CU7w+qPOS4hm5FC1fbJRefKiiPe
 8x5iFbXR7ooHTRO7qGhK9ObC2pWwuCzH6ZcjCGNM0E6l8FzSe/9hVVrJpYVKyHV9dCCG
 5KVKvaCREqXYOydtatd2IE/Te6iOfUR35QGJM/JIlAA+ItrJ1vzFnb8EUH+AJm0s3yhU
 vo3Q==
X-Gm-Message-State: AOJu0YyhVmmBmEbyPHqea1UGYRRjZItCCJDp/GEGhOP+RAP9910J8wf4
 Do8VhtNCq1LfrRsMOBXqK+tNh10TBnE1+E4KiCrrWmLfUh4gv0vtTaHpnUXoKEWMnVOSthC/2qS
 ThwiQ5KYXmsV4/lPwuWbA9iCsOS9qx8fkmPRoMaeTInzBtSwdQPrs
X-Received: by 2002:a05:600c:350c:b0:412:9760:c39f with SMTP id
 h12-20020a05600c350c00b004129760c39fmr8339830wmq.10.1709128747772; 
 Wed, 28 Feb 2024 05:59:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCWqR8QaJUjCN1ta1125xwP4HyuQ1ZkdVhzTuHKiti9vdVmvIn5Mil7Fh2z86lETP6iZgsUQ==
X-Received: by 2002:a05:600c:350c:b0:412:9760:c39f with SMTP id
 h12-20020a05600c350c00b004129760c39fmr8339815wmq.10.1709128747396; 
 Wed, 28 Feb 2024 05:59:07 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h8-20020a05600016c800b0033dfa7ecd33sm2728865wrf.61.2024.02.28.05.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 05:59:06 -0800 (PST)
Date: Wed, 28 Feb 2024 14:59:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Alistair
 Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 03/19] tests: smbios: add test for legacy mode CLI options
Message-ID: <20240228145905.25fa8cd4@imammedo.users.ipa.redhat.com>
In-Reply-To: <4AD7C30D-F989-4228-91FD-672D79592302@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-4-imammedo@redhat.com>
 <4AD7C30D-F989-4228-91FD-672D79592302@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Wed, 28 Feb 2024 16:41:22 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
> >=20
> > Unfortunately having 2.0 machine type deprecated is not enough
> > to get rid of legacy SMBIOS handling since 'isapc' also uses
> > that and it's staying around.
> >=20
> > Hence add test for CLI options handling to be sure that it
> > ain't broken during SMBIOS code refactoring.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
> > tests/qtest/bios-tables-test.c       |  17 +++++++++++++++++
> > 2 files changed, 17 insertions(+)
> > create mode 100644 tests/data/smbios/type11_blob.legacy
> >=20
> > diff --git a/tests/data/smbios/type11_blob.legacy b/tests/data/smbios/t=
ype11_blob.legacy
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..aef463aab903405958b0a85=
f85c5980671c08bee
> > GIT binary patch
> > literal 10
> > Rcmd;PW!S(N;u;*n000Tp0s;U4
> >=20
> > literal 0
> > HcmV?d00001
> >=20
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-t=
est.c
> > index a116f88e1d..d1ff4db7a2 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -2106,6 +2106,21 @@ static void test_acpi_pc_smbios_blob(void)
> >     free_test_data(&data);
> > }
> >=20
> > +static void test_acpi_isapc_smbios_legacy(void)
> > +{
> > +    uint8_t req_type11[] =3D { 1, 11 }; =20
>=20
> Ok so looking at the code, it won=E2=80=99t let you specify smbios type o=
ther than 1 =E2=80=A6
>=20
> See the following in smbios_set_defaults()
>=20
>   if (smbios_legacy) {
>         g_free(smbios_tables);
> 	/* in legacy mode, also complain if fields were given for types >1 */
>         if (find_next_bit(have_fields_bitmap,
> 	                  SMBIOS_MAX_TYPE+1, 2) < SMBIOS_MAX_TYPE+1) {
>             error_report("can't process fields for smbios "
>                          "types > 1 on machine versions < 2.1!");
>             exit(1);
>         }
>     } else {
>=20
> BUT you lets you load a blob of type 11? Is that a bug in QEMU? Should we=
 also add a similar check for have_binfile_bitmap?=20

I'd say bug (oversight) in QEMU, actually some of patches later in series
mention this issue in commit messages.
And I'm adding check only for type4 which I have to touch
as for other types it might work (type11) or not.
But I have not tested every possible type (only type 11 and 4)
the former lets test bloated SMBIOS blob and the later
needs refactoring to make this series work..

Everything else was ignored for this series and
can be done later on top.
As mentioned later in series I'd rather deprecate and
drop all legacy code instead of fixing it.

These tests are mostly for me to be sure that existing
CLI handling and blob building aren't broken during
refactoring.

> > +    test_data data =3D {
> > +        .machine =3D "isapc",
> > +        .variant =3D ".pc_smbios_legacy",
> > +        .required_struct_types =3D req_type11,
> > +        .required_struct_types_len =3D ARRAY_SIZE(req_type11),
> > +    };
> > +
> > +    test_smbios("-smbios file=3Dtests/data/smbios/type11_blob.legacy "
> > +                "-smbios type=3D1,family=3DTEST", &data);
> > +    free_test_data(&data);
> > +}
> > +
> > static void test_oem_fields(test_data *data)
> > {
> >     int i;
> > @@ -2261,6 +2276,8 @@ int main(int argc, char *argv[])
> >                            test_acpi_pc_smbios_options);
> >             qtest_add_func("acpi/piix4/smbios-blob",
> >                            test_acpi_pc_smbios_blob);
> > +            qtest_add_func("acpi/piix4/smbios-legacy",
> > +                           test_acpi_isapc_smbios_legacy);
> >         }
> >         if (qtest_has_machine(MACHINE_Q35)) {
> >             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> > --=20
> > 2.39.3
> >  =20
>=20


