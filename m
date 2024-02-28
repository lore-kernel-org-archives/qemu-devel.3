Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C897CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGfd-0006gj-1e; Wed, 28 Feb 2024 04:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfGfb-0006dz-Dr
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfGfV-0003KC-9N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709114164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jX9Dnd84RuEhgEq2ijfHFBv4LiC0xGGXw+n8jfHh304=;
 b=LAaNhPxN6OFn4NdVZ1w1kyritgV3ZqqVXxV6RMJQ7AeuqnX/hq8YzjbWZp/nt3GB9JNRT6
 NNGTF+9gyCqzHfGfTypmUrFnGcnJ97jv0r0DhsAw4TJrYqpwWawIKp58k5MjN2dD+vqW6V
 QrgUcNXENeaSmQr46nLSSoFir75FwE8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-wumuYiYUO2G2nhdJ4bX9FQ-1; Wed, 28 Feb 2024 04:56:02 -0500
X-MC-Unique: wumuYiYUO2G2nhdJ4bX9FQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc7e0261aeso32624555ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 01:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709114162; x=1709718962;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jX9Dnd84RuEhgEq2ijfHFBv4LiC0xGGXw+n8jfHh304=;
 b=XD+Ipf7RDs7agx+ygENkNtR40T+/gY0tWlJU5wbIxizLRnoaQNtaPDlOiqshtqWRJh
 MufMjPVgtke79ncyeidXJNlV4cjXAdY/A54jPibLaKyQrAiVi3e3lrM1wlv6QMFqzs7G
 odZxpjhDqQ/SgVsxocK8bG+gs5d8CO5YNZc4iNpSkKKUyYubm4L2xFrhd4oB+BC/vpQm
 HIGeKUkRBNJsYT/vdMh4k6fKX36lWhwGa2TEScl11YxRWHgzEmuCWdsBjWVougcAlgj7
 ERu3Ajp5c1ddXrM9rDdcws6ADler3siIW39Ju+AbnVbTO0oBUbVBBz6HPso1k4j4u4gA
 PyCQ==
X-Gm-Message-State: AOJu0YwnBF4nrcL/zm7khsFIOqBxHFQmi8Mb4O75xW7KNHJhVnY/1QW/
 SoVkwTX4cQVWrCqgRpNLGXhmHU00BjkhAA3CF6niQ6I2mz4WE6LGCzZhwSj0/H0nzOfX+fwsbGd
 +FTWQSTbTTq/fcpCfrFFeYWAUXo8RgHJgeX6hHmBm+Fb4DjBsSFdU
X-Received: by 2002:a17:902:bd88:b0:1d9:fc3f:5081 with SMTP id
 q8-20020a170902bd8800b001d9fc3f5081mr11262599pls.33.1709114161937; 
 Wed, 28 Feb 2024 01:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAu772p7pbvz+17GkO3vAt/jQT/4biImObW7j22ThjHbFZRW0sPTLNuHPkYwuDnJPh7Al54Q==
X-Received: by 2002:a17:902:bd88:b0:1d9:fc3f:5081 with SMTP id
 q8-20020a170902bd8800b001d9fc3f5081mr11262578pls.33.1709114161572; 
 Wed, 28 Feb 2024 01:56:01 -0800 (PST)
Received: from smtpclient.apple ([203.163.242.235])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a170902e28a00b001dc3916853csm2958204plc.73.2024.02.28.01.55.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Feb 2024 01:56:01 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 02/19] tests: smbios: add test for -smbios type=11 option
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-3-imammedo@redhat.com>
Date: Wed, 28 Feb 2024 15:25:43 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>, alistair.francis@wdc.com,
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F617BB4B-F5D0-438A-B650-C38B967B1260@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-3-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Empty description is not nice. Other than that,

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/data/smbios/type11_blob  | Bin 0 -> 11 bytes
> tests/qtest/bios-tables-test.c |  17 +++++++++++++++++
> 2 files changed, 17 insertions(+)
> create mode 100644 tests/data/smbios/type11_blob
>=20
> diff --git a/tests/data/smbios/type11_blob =
b/tests/data/smbios/type11_blob
> new file mode 100644
> index =
0000000000000000000000000000000000000000..1d8fea4b0c6f040a13ba99c3fad76253=
8b795614
> GIT binary patch
> literal 11
> Scmd;PW!S(N;u;*nzyJUX)&c?m
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
> index b2992bafa8..a116f88e1d 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2091,6 +2091,21 @@ static void test_acpi_pc_smbios_options(void)
>     free_test_data(&data);
> }
>=20
> +static void test_acpi_pc_smbios_blob(void)
> +{
> +    uint8_t req_type11[] =3D { 11 };
> +    test_data data =3D {
> +        .machine =3D MACHINE_PC,
> +        .variant =3D ".pc_smbios_blob",
> +        .required_struct_types =3D req_type11,
> +        .required_struct_types_len =3D ARRAY_SIZE(req_type11),
> +    };
> +
> +    test_smbios("-machine smbios-entry-point-type=3D32 "
> +                "-smbios file=3Dtests/data/smbios/type11_blob", =
&data);
> +    free_test_data(&data);
> +}
> +
> static void test_oem_fields(test_data *data)
> {
>     int i;
> @@ -2244,6 +2259,8 @@ int main(int argc, char *argv[])
> #endif
>             qtest_add_func("acpi/piix4/smbios-options",
>                            test_acpi_pc_smbios_options);
> +            qtest_add_func("acpi/piix4/smbios-blob",
> +                           test_acpi_pc_smbios_blob);
>         }
>         if (qtest_has_machine(MACHINE_Q35)) {
>             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> --=20
> 2.39.3
>=20


