Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04411C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUreV-0004BB-23; Tue, 30 Jan 2024 12:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUreT-00046I-S4
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUreR-0003f5-3j
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706634717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R06aqEIOEXWCLhaarYTxa85WehQ4KktiwtrZ5hjYt9I=;
 b=A1ZyEGweUkIYIkysVwMxChka6d3/lM8kgud2ubIQHcqD5dcwVwKiujWJixRTazo/E4S0lE
 Pb73XL3Q2ZCrkxM7/32bBMGs7uiOxPPkvy3yYAtctKx6EXPmL5mBUzWb5LSDcmOTKFstc5
 +76V2i5Q9D41XWsqPg5/mhfqa51qFeo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-C1cNPsooNwibN5va1uAkPg-1; Tue, 30 Jan 2024 12:11:55 -0500
X-MC-Unique: C1cNPsooNwibN5va1uAkPg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6ddb12934f9so2089728b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706634715; x=1707239515;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R06aqEIOEXWCLhaarYTxa85WehQ4KktiwtrZ5hjYt9I=;
 b=Z40ywZSuIBJZSIo1nPPTyoeeqAI7QsygL0QiwazddN0b4ckVLpRncWv2nMSg5OAQn+
 jfnAhqiypEYJHBOUdPBtj7dVzdiYaFERCKOcEQKcB+EzfaX3WnhHakTuwRCqAbnr3IMi
 3+FmmrV47Dbu77+ok/Z6cjQs1lONr9v16aGFrPZeptr8vfBMu2jg0t5Ag8sx4qe0L8F9
 Fwv61Vrp9EkB1Eal3z/cTREx3GA/FYnjVTkdh++WWd96sfnz0qx3TyN61NsQvUWwXLKi
 QkkPXSnb1stPV5GzTWNPWCRQa3djJW4pkaeqPpvgbLMktOlg0Idxc6Sf3trRomu3xMxf
 yyCA==
X-Gm-Message-State: AOJu0Ywjhz9xaPbyaB/vmCedKv7mY2KG0nbloBd7u653njrybA20sj3A
 Lxxt5RgeXgVe/JTnxigCDrWF1WIIeHEwwHKJ0JeLwPuA3ZSUmITozBHrw8P4G2blogOZp/YUD+v
 /X4LgZm3cN87GhG9ShJEW4pSN4THkaUl9ouLTsFXlY5JJPlXSLbhJ
X-Received: by 2002:a05:6a00:4503:b0:6db:605c:b9e4 with SMTP id
 cw3-20020a056a00450300b006db605cb9e4mr6316435pfb.31.1706634714940; 
 Tue, 30 Jan 2024 09:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd/cH+0BEPRj09ztEkWsYZ0Xc6/rc4GdQJcBQmZHGqZ7wJ9SPmeo6/59Ho7nARr5ddZ/vdVA==
X-Received: by 2002:a05:6a00:4503:b0:6db:605c:b9e4 with SMTP id
 cw3-20020a056a00450300b006db605cb9e4mr6316408pfb.31.1706634714604; 
 Tue, 30 Jan 2024 09:11:54 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.50])
 by smtp.gmail.com with ESMTPSA id
 d2-20020aa78682000000b006ddc5d8ecd7sm8002030pfo.32.2024.01.30.09.11.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 09:11:54 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 2/3] hw/loongarch: Add `\n` to hint message
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240130163741.145925-3-groug@kaod.org>
Date: Tue, 30 Jan 2024 22:41:39 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65A9DB8A-66E8-4F60-AE26-2CD73DDA440B@redhat.com>
References: <20240130163741.145925-1-groug@kaod.org>
 <20240130163741.145925-3-groug@kaod.org>
To: Greg Kurz <groug@kaod.org>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



> On 30-Jan-2024, at 22:07, Greg Kurz <groug@kaod.org> wrote:
>=20
> error_printf() doesn't add newlines.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/loongarch/acpi-build.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 730bc4a748c4..a1c419874123 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -509,7 +509,7 @@ static void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>                     " migration may not work",
>                     tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
>         error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                     " or PCI bridges.");
> +                     " or PCI bridges.\n");
>     }
>=20
>     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
> --=20
> 2.43.0
>=20


