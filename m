Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78CEC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfKmJ-0001ND-S8; Wed, 28 Feb 2024 09:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfKmI-0001MP-G9
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 09:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfKm5-0002rs-LM
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 09:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709129947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9gsHcaIXWgebE1TFLUlGT0eDuaJ1smlcNOq4J3sI5w=;
 b=Pz5zKwZPo5EHse2nbPQ9j4wbm6+xZaDdx7m1trHb3LP2minga51LK2Vy0TkpVflx+0crGz
 yU6JRF5TeZ3J+jG4ktz7z7XQHqmRw8l8o09wvI+pTz5Xabn9v5Jq/YR3kKxq6Lfv6aHmOy
 1W+R/IhOTpdXJX9daXAR+jRHTN37qoo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-B1Pk6NNcPw6obibdKgUGQA-1; Wed, 28 Feb 2024 09:19:05 -0500
X-MC-Unique: B1Pk6NNcPw6obibdKgUGQA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7c7ee7fa1caso131084739f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 06:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709129945; x=1709734745;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9gsHcaIXWgebE1TFLUlGT0eDuaJ1smlcNOq4J3sI5w=;
 b=vZ8bp5kQHvwlFkosQKNXURowEPJFAqZkVx8ChnUQyXt11vRly1P4ZpECq5VQqFqTaf
 n4C+fXMKT1wYQcsTbU6OUV5V7a3XlYyiitFs/1/juWrUlr7KEmOC218petMrQsUGWeRR
 6guvfqsXgT6R2pZn7UrS6fmur+vusIgQiB3U1l2s6fWYJuwnBgFaUI9d39EyEfxn1ayi
 bi56Ajmohk8f5fM80XTZzRVelu3U3uWkTWLqrEW/6gT6AhdFdM9RDNU2Qb3P9vjUfvFY
 TamDO8tiAeUpBJkFoMwKi+QYa4PlDCF3pO+lLcy34r30YSMKks9JrPULT7+/kay36gwb
 0AcA==
X-Gm-Message-State: AOJu0Yx2rw78ptYaZ5QQg5tdj/KQWR1eztUnBB+iuxmDO0YAcw/mclO/
 RHWzlmsdkTZUeMLTjlY7xIBKxngEcwWiTX1uqeb6GzaEp1fxXb6RyVdxw6Ahd5QDNyUitolDjlW
 L9+igGn/PUOS+d0f7pA0f+Es51mAVEf8qwYQdctXUazTbJ20NhaGH
X-Received: by 2002:a92:d64d:0:b0:363:c4b9:d931 with SMTP id
 x13-20020a92d64d000000b00363c4b9d931mr12990313ilp.20.1709129945123; 
 Wed, 28 Feb 2024 06:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRTfUno1/9G5BXSAr8hQfPguffcPGArfDBiIYVkj2Lw+6vYb2wduwuOQakdtaINs+W5X/K8w==
X-Received: by 2002:a92:d64d:0:b0:363:c4b9:d931 with SMTP id
 x13-20020a92d64d000000b00363c4b9d931mr12990285ilp.20.1709129944853; 
 Wed, 28 Feb 2024 06:19:04 -0800 (PST)
Received: from smtpclient.apple ([115.96.143.215])
 by smtp.gmail.com with ESMTPSA id
 z20-20020aa785d4000000b006e45dce37basm7844002pfn.220.2024.02.28.06.18.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Feb 2024 06:19:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 03/19] tests: smbios: add test for legacy mode CLI options
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-4-imammedo@redhat.com>
Date: Wed, 28 Feb 2024 19:48:47 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A54DF112-5A08-43E2-A30E-BA32FE330320@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-4-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



> On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> Unfortunately having 2.0 machine type deprecated is not enough
> to get rid of legacy SMBIOS handling since 'isapc' also uses
> that and it's staying around.
>=20
> Hence add test for CLI options handling to be sure that it
> ain't broken during SMBIOS code refactoring.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
> tests/qtest/bios-tables-test.c       |  17 +++++++++++++++++
> 2 files changed, 17 insertions(+)
> create mode 100644 tests/data/smbios/type11_blob.legacy
>=20
> diff --git a/tests/data/smbios/type11_blob.legacy =
b/tests/data/smbios/type11_blob.legacy
> new file mode 100644
> index =
0000000000000000000000000000000000000000..aef463aab903405958b0a85f85c59806=
71c08bee
> GIT binary patch
> literal 10
> Rcmd;PW!S(N;u;*n000Tp0s;U4
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
> index a116f88e1d..d1ff4db7a2 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2106,6 +2106,21 @@ static void test_acpi_pc_smbios_blob(void)
>     free_test_data(&data);
> }
>=20
> +static void test_acpi_isapc_smbios_legacy(void)
> +{
> +    uint8_t req_type11[] =3D { 1, 11 };
> +    test_data data =3D {
> +        .machine =3D "isapc",
> +        .variant =3D ".pc_smbios_legacy",
> +        .required_struct_types =3D req_type11,
> +        .required_struct_types_len =3D ARRAY_SIZE(req_type11),
> +    };
> +
> +    test_smbios("-smbios file=3Dtests/data/smbios/type11_blob.legacy =
"
> +                "-smbios type=3D1,family=3DTEST", &data);
> +    free_test_data(&data);
> +}
> +
> static void test_oem_fields(test_data *data)
> {
>     int i;
> @@ -2261,6 +2276,8 @@ int main(int argc, char *argv[])
>                            test_acpi_pc_smbios_options);
>             qtest_add_func("acpi/piix4/smbios-blob",
>                            test_acpi_pc_smbios_blob);
> +            qtest_add_func("acpi/piix4/smbios-legacy",
> +                           test_acpi_isapc_smbios_legacy);
>         }
>         if (qtest_has_machine(MACHINE_Q35)) {
>             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> --=20
> 2.39.3
>=20


