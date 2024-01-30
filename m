Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB0EC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 16:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUqkI-00007p-AV; Tue, 30 Jan 2024 11:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUqkE-0008PW-IO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUqkC-0008PO-MV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706631231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2TXQY7oLkByMa20k4kM2kuAi6geHCpwaT9GmhgYfg4=;
 b=PygFM8+uWXfUS3dLbl/4Aau13v897D4lvj6AcASW6kHNuxUmKZtPlIo9LWZoo62hYx3Vz/
 HKFpIzR9FU2zDr3N0fSEW7W8S8eB5q1ADbkTc5z4bV+IEwsme0fIDHHihsUSV3ZAY27t0d
 7haKtp+dbgXcSY1pl1kLeO1eFNooD/0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-XVKja-zrO06BoASw-Yhf3Q-1; Tue, 30 Jan 2024 11:13:48 -0500
X-MC-Unique: XVKja-zrO06BoASw-Yhf3Q-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d8cd8315fbso29440035ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 08:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706631224; x=1707236024;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2TXQY7oLkByMa20k4kM2kuAi6geHCpwaT9GmhgYfg4=;
 b=YE4ot+p0qJQfi9mNFCqLir0as52xC8qdQcY9znAWE8tA3fxP3VIwaHtoe5RFgDGZ2B
 zfayaJ6xu2HNdwIgaLOUQlkO4qbs9rYo5vO8aYqswDgZog0//3yJ66pn0MeGuRXns79t
 KoiYm6GurMo6ctC4HtphyyBw21MnKbhcj+zgZgJ3oldTcIx2ZVd+NXFExBTjNhccJdCU
 BbYjsXnHFFoAlYDzsmcEerfeVMjcy2wte9VCX7ihjeVx34Mt276k+f3vQEHl+diTjpNC
 W2CYNZSG6Bm8rS2IcWOK6SZB3YnMqTAUG2Fo9OPQXezf+4zablWzcvz0s3+9dvJd+uA9
 9OWQ==
X-Gm-Message-State: AOJu0YyFAX3hIJC5ttp/PVe5zSz6H2q1NIuN+NhSA+AcSmj1pvc1l8PQ
 0H7cTCElfxcsyzT/q0l+KnbBNVoYpr3ag/J6cjfy4jVLu9BX1yIOy/nd+M5bEfyJrfBTX37x2Sv
 pzdNSRVU0l+BUmPqJv3X7m22BcdpE7HVjaeh9NyWk6BTjjgOkno0p
X-Received: by 2002:a17:902:7482:b0:1d7:690f:a961 with SMTP id
 h2-20020a170902748200b001d7690fa961mr8057428pll.44.1706631224686; 
 Tue, 30 Jan 2024 08:13:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoUC5dZkqOrk3Ruu5iIsAE9bfnf1tDPMjgnvxw87bssrw4+DoBsKbykAyTUED4BCFgz9ejUw==
X-Received: by 2002:a17:902:7482:b0:1d7:690f:a961 with SMTP id
 h2-20020a170902748200b001d7690fa961mr8057407pll.44.1706631224363; 
 Tue, 30 Jan 2024 08:13:44 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.50])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a170903411200b001d73adf350asm7394811pld.56.2024.01.30.08.13.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 08:13:43 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 1/3] hw/i386: Add `\n` to hint message
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240130155653.142283-2-groug@kaod.org>
Date: Tue, 30 Jan 2024 21:43:27 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E771066-49E8-448D-B90A-21766B108874@redhat.com>
References: <20240130155653.142283-1-groug@kaod.org>
 <20240130155653.142283-2-groug@kaod.org>
To: Greg Kurz <groug@kaod.org>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 30-Jan-2024, at 21:26, Greg Kurz <groug@kaod.org> wrote:
>=20
> error_fprintf() doesn't add newlines.

^^^^^^^^^^^^^^^^^

Should be error_printf(). Ditto for other patches.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> hw/i386/acpi-build.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index edc979379c03..e990b0ae927f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2697,7 +2697,7 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>                         " migration may not work",
>                         tables_blob->len, legacy_table_size);
>             error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                         " or PCI bridges.");
> +                         " or PCI bridges.\n");
>         }
>         g_array_set_size(tables_blob, legacy_table_size);
>     } else {
> @@ -2709,7 +2709,7 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>                         " migration may not work",
>                         tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
>             error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                         " or PCI bridges.");
> +                         " or PCI bridges.\n");
>         }
>         acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
>     }
> --=20
> 2.43.0
>=20


