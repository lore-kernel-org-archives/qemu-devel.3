Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27E2C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZrJ-0004dH-O7; Wed, 24 Jan 2024 04:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rSZrG-0004d1-1K
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rSZrC-0006bB-V6
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706089661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3hkq0elGjqfuoF6LgD/tVxs8fm3zRg9zRY4LpliZ0c=;
 b=NFl8hvaIUmZ3Q/d8AUPFk66UzF15Q1oVWRDK/THkvrEvjejoGfGIQKibMzBz3BgfHw4wkQ
 luC+6yhOXr1XPajxFde29Ib/WUd69htLra/CTdMlQNDVfa1d69M0qKB/5ERO5lAS76QNYE
 zs8tIWDBRjuzDNQxMQeOPphb3s3BVes=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-MgWczwGsPz2iicHAxUVx3g-1; Wed, 24 Jan 2024 04:47:38 -0500
X-MC-Unique: MgWczwGsPz2iicHAxUVx3g-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-598e30e7e8cso5199386eaf.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 01:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706089657; x=1706694457;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3hkq0elGjqfuoF6LgD/tVxs8fm3zRg9zRY4LpliZ0c=;
 b=nSHwwrvryEzwNcqNNKLmB65dLD7oBorrumh9ugCGQM/kCzEggFvXroR+wkWx/tSMsR
 2G/GGFj3wOuIb9HgCPhCtYSgjqpMlKam63+a+UH6nqTee61Wy/ylV6gTNGBwF6k7iRD0
 3ns7N1HUUYcxRzm1KS5MxyJOgB9K/iG0TnipAO1ORpWGsx/yEdsBKH0GHOSMvzo63PS3
 lJ/jn8JvrSZBBBnan7KJfJYU2Q2yPMM2JitsZZXMnwswESRpu9pEaJdHRrRpPzL65Y/U
 vvyb4XOv/C7xFC+SDxDaUkIyMJ5mRuR9vI4ZdhzVhyB3pzVtd+8/X0WGBYCjvz8ph5GN
 3Ysg==
X-Gm-Message-State: AOJu0Yxh82001O46Rq1iKI8jedxl8j7YG1BghNyNBs+CbHdxxPRMFFSL
 Ag9fIS+IJh88EF0L16XbTYCQf2OzdyYaZUjBzVfBV4TedQqlb1jQPUYE9JvUkqmnPcPEINkYYEh
 sZe9Jqjuwa0qa8xLlNs/O1ce2zqHxG+vJ0x4DZBcg9XlBv5tlx+pW
X-Received: by 2002:a05:6358:591f:b0:176:9957:c33e with SMTP id
 g31-20020a056358591f00b001769957c33emr117646rwf.39.1706089657659; 
 Wed, 24 Jan 2024 01:47:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyUIXl2uLVrmgImCTy6sju+HbXg136Nwf8381eTHm1viH5rGT6YPJJzysFATp/NdJdf4QuWw==
X-Received: by 2002:a05:6358:591f:b0:176:9957:c33e with SMTP id
 g31-20020a056358591f00b001769957c33emr117643rwf.39.1706089657344; 
 Wed, 24 Jan 2024 01:47:37 -0800 (PST)
Received: from smtpclient.apple ([203.163.245.23])
 by smtp.gmail.com with ESMTPSA id
 k4-20020aa78204000000b006d0a29ad0aasm13280066pfi.5.2024.01.24.01.47.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jan 2024 01:47:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PULL 03/15] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240124095815.3392a6a4@imammedo.users.ipa.redhat.com>
Date: Wed, 24 Jan 2024 15:17:22 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6BCAAF1-7745-4C9E-A3F3-574A9887E322@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
 <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
 <20240124095815.3392a6a4@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 24-Jan-2024, at 14:28, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Fri, 1 Dec 2023 12:15:16 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>> From: Ani Sinha <anisinha@redhat.com>
>>=20
>> When dumping table blobs using rebuild-expected-aml.sh, table blobs =
from all
>> test variants are dumped regardless of whether there are any actual =
changes to
>> the tables or not. This creates lot of new files for various test =
variants that
>> are not part of the git repository. This is because we do not check =
in all table
>> blobs for all test variants into the repository. Only those blobs for =
those
>> variants that are different from the generic test-variant agnostic =
blob are
>> checked in.
>>=20
>> This change makes the test smarter by checking if at all there are =
any changes
>> in the tables from the checked-in gold master blobs and take actions
>> accordingly.
>>=20
>> When there are no changes:
>> - No new table blobs would be written.
>> - Existing table blobs will be refreshed (git diff will show no =
changes).
>> When there are changes:
>> - New table blob files will be dumped.
>> - Existing table blobs will be refreshed (git diff will show that the =
files
>>   changed, asl diff will show the actual changes).
>=20
>> When new tables are introduced:
>> - Zero byte empty file blobs for new tables as instructed in the =
header of
>>   bios-tables-test.c will be regenerated to actual table blobs.
>=20
> Ani,
>=20
> what previously worked is the is there weren't _any_ expected blobs
> (exact match/fallback) found a new table would be dumped.
> So then later 'git status' would show a list of new files.

Yes this was the original complaint from Peter. Lots of new files were =
generated when basically they were identical but differed in naming.

> With this commit it's however not dumping new files files,
> and explodes at
> #5  0x000055555556808e in load_expected_aml (data=3D0x7fffffffd7b0) at =
tests/qtest/bios-tables-test.c:414
> #6  0x00005555555676b0 in dump_aml_files (data=3D0x7fffffffd7b0, =
rebuild=3Dtrue) at tests/qtest/bios-tables-test.c:256
>=20
> sure it can be worked around by manually creating empty files
> for expected files

Yes this has already been documented in the commit log.

> but if it's a new machine type, one has to create
> a bunch of them basically running multiple iterations of rebuild in =
V=3D2
> mode to see what's missing.
> (IMHO cure turned out to be worse than illness)

I don=E2=80=99t know how common it is to create new machines.=20

>=20
> for reproducing create a test for other than default machine type, ex:
>=20
>    test_data data =3D {                                                =
          =20
>        .machine =3D "pc-i440fx-2.0",                                   =
          =20
>        .variant =3D ".pc_legacy",                                      =
                       =20
>    };=20
>=20
>=20
> is it possible to fix it so that one doesn't have to create empty =
files manually?
>=20
>>=20
>> This would make analyzing changes to tables less confusing and there =
would
>> be no need to clean useless untracked files when there are no table =
changes.
>>=20
>> CC: peter.maydell@linaro.org
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Message-Id: <20231107044952.5461-1-anisinha@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
>> index 71af5cf69f..fe6a9a8563 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -112,6 +112,7 @@ static const char *iasl;
>> #endif
>>=20
>> static int verbosity_level;
>> +static GArray *load_expected_aml(test_data *data);
>>=20
>> static bool compare_signature(const AcpiSdtTable *sdt, const char =
*signature)
>> {
>> @@ -244,21 +245,32 @@ static void test_acpi_fadt_table(test_data =
*data)
>>=20
>> static void dump_aml_files(test_data *data, bool rebuild)
>> {
>> -    AcpiSdtTable *sdt;
>> +    AcpiSdtTable *sdt, *exp_sdt;
>>     GError *error =3D NULL;
>>     gchar *aml_file =3D NULL;
>> +    test_data exp_data =3D {};
>>     gint fd;
>>     ssize_t ret;
>>     int i;
>>=20
>> +    exp_data.tables =3D load_expected_aml(data);
>>     for (i =3D 0; i < data->tables->len; ++i) {
>>         const char *ext =3D data->variant ? data->variant : "";
>>         sdt =3D &g_array_index(data->tables, AcpiSdtTable, i);
>> +        exp_sdt =3D &g_array_index(exp_data.tables, AcpiSdtTable, =
i);
>>         g_assert(sdt->aml);
>> +        g_assert(exp_sdt->aml);
>>=20
>>         if (rebuild) {
>>             aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, =
data->machine,
>>                                        sdt->aml, ext);
>> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>> +                sdt->aml_len =3D=3D exp_sdt->aml_len &&
>> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
>> +                /* identical tables, no need to write new files */
>> +                g_free(aml_file);
>> +                continue;
>> +            }
>>             fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>>                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>>             if (fd < 0) {
>=20


