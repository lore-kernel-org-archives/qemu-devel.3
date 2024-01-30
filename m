Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8268DC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrdz-0003Cu-RW; Tue, 30 Jan 2024 12:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUrdj-0002wZ-EB
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUrdc-0003Uc-P3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706634664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDpf39m9/K8wpY2UV02GGHmrme+FZzgNAG9ovgKJupE=;
 b=HIrZcKKD3euqIFbGOzrgf4wZynZRIzywCxN5G+pLEb8VWjW3qc6+frv4490qmyrGdtYcCp
 0Vf+3H5dxErSLSOV33sI/ADjumICK2M3OOwFtoGipNJQh9MR61YRvgaJmUWTLEyz4MlJWi
 OyS3fNwqPs65w2yCyB0Vi/ejxTNDatM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-i91_Q_NlPZi13gTo6BxjLA-1; Tue, 30 Jan 2024 12:11:02 -0500
X-MC-Unique: i91_Q_NlPZi13gTo6BxjLA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cf35636346so2312382a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706634661; x=1707239461;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDpf39m9/K8wpY2UV02GGHmrme+FZzgNAG9ovgKJupE=;
 b=JjRhycDBHNJbPSRpYF5h7UEn3W3rIzGkRpTVgsovn30jLkgFMiSBu8mmN/WiKnZmZX
 69NgXXnIyetMTk0dE7w2lHdlWBx0nOlTS9Hr+i+RwldQwEAMxOGrwnlco3ryEoOXaYTU
 su+XPJplDSCj6f7gmyShGaIwtCUaxF4EWpTtEPZEURKfJWLseCxFJ0AvPKrp9LDGniP6
 3Ps9lLzMhXTFWY3g2SdUoXGII2oCH8PoHXIAHphgpqbSSDmeiN1Ipyrr+mtvdR/YvdF1
 YHN1qofzqqiXQKsGx25SoMP1CoBJGyrwBJzFaDo/Y3DOJnrCG2MLU+Zlce5ZcBgrAAk2
 JsXQ==
X-Gm-Message-State: AOJu0YwEWnVW/e9uzHZgR6iAWfo8mPSq9tWMxJqFN/uCsvWGv8UVGFlx
 BFlb3zysWUOxL9E9g1ZWigr7GnjszXqd2vDt18zUziCQ6POgb4xUMYfOjLO/jEwUonAISI8JhCH
 sy9XDGEZhvQ/N2O90V77JVPQwran5RBiYM2P/IyDdLPe0kr75p0UOyjzlKKKw
X-Received: by 2002:a05:6a21:61e:b0:19c:7c49:4e6 with SMTP id
 ll30-20020a056a21061e00b0019c7c4904e6mr4568341pzb.51.1706634661188; 
 Tue, 30 Jan 2024 09:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0e3Rk42JtixLJLTZ9zbSdmdWx+en0/sXAdE9BlCALwZ1qtT4CgPBYPMxmN3fie6hNZRJTuQ==
X-Received: by 2002:a05:6a21:61e:b0:19c:7c49:4e6 with SMTP id
 ll30-20020a056a21061e00b0019c7c4904e6mr4568322pzb.51.1706634660854; 
 Tue, 30 Jan 2024 09:11:00 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.50])
 by smtp.gmail.com with ESMTPSA id
 d2-20020aa78682000000b006ddc5d8ecd7sm8002030pfo.32.2024.01.30.09.10.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 09:11:00 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 3/3] hw/arm: Add `\n` to hint message
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240130163741.145925-4-groug@kaod.org>
Date: Tue, 30 Jan 2024 22:40:45 +0530
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
Message-Id: <93A9587D-E34E-4EB3-924D-6CDC64E1812F@redhat.com>
References: <20240130163741.145925-1-groug@kaod.org>
 <20240130163741.145925-4-groug@kaod.org>
To: Greg Kurz <groug@kaod.org>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
> hw/arm/virt-acpi-build.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 17aeec7a6f56..48febde1ccd1 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1008,7 +1008,7 @@ void virt_acpi_build(VirtMachineState *vms, =
AcpiBuildTables *tables)
>                     " migration may not work",
>                     tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
>         error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                     " or PCI bridges.");
> +                     " or PCI bridges.\n");
>     }
>     acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
>=20
> --=20
> 2.43.0
>=20


