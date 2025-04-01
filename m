Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BC8C3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbzs-0007OH-Oi; Tue, 01 Apr 2025 09:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzbz2-0006aU-IW
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzbz0-0007Ee-HX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743515329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8W7D8fC9cpDW8I+kTWOevlK5SmojoV0WRC1tF3MyF4=;
 b=Qr6CS8loNoYHqyPe14isTbDp//FCQ+OaUxrV916Tkf9Zs+0f09XUAIe6/0TrzQ4aOihFlp
 kkXOLZMrBPJ9ujsuHDzUvVVWF2gg7At/1jTUo5VVWJhc+7187D7FE53r8yU1T2WG1gBq0C
 LmkkjRln5YSjfvMk3MbAfv9r/BEhrIw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-R8QjXXuoNPWdA8TusaSgxg-1; Tue, 01 Apr 2025 09:48:44 -0400
X-MC-Unique: R8QjXXuoNPWdA8TusaSgxg-1
X-Mimecast-MFC-AGG-ID: R8QjXXuoNPWdA8TusaSgxg_1743515323
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5eb80d465b7so5135760a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743515323; x=1744120123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8W7D8fC9cpDW8I+kTWOevlK5SmojoV0WRC1tF3MyF4=;
 b=B6gHKWbEciIc1IYTACocwE4ENZAWZnVAdwcCoX6J6DVN5b8sX/JEH0ntFZsiHt3UDy
 sO2lV5A1SJL/mq5qSJ6xlyTq6B+jw/G12C2DzkCViuyqHD0SNMHcp7zqQxFZP/Z+s0jk
 E4bbzlG8POmv6TKejqGEkmXFugSx7s19uIREtV63Ulk5m+tJi2G64vO/5unC8Wy319oi
 Pq60SkbKqyXu5mUFwkbxv6GCwwg/VZzNQj9u6tz6IPlrrzO1l22vdn3X+x3tArftE4El
 CWzkQaWqRLFCx+EWbxqbiY9TKw53jlb/xj4CVBGTm2EFzpGPLC+5DK6VGsAhS4CYn36n
 GSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAAsLX4jL5QFdXikNIOen+ofZZoOqKYNGkwoJ0YjSPdPQpMkpWSdZXAD9x+uuO742HpBMSNPmQbndT@nongnu.org
X-Gm-Message-State: AOJu0Yzi/s10DkEnthWBcpH7BVXESrzFXt80DlEjK+OGvghMWXJXSHCx
 S0nRK+HexWSmtrGrlJS0Wd/Nq9j3FGQaTmZw3JwONT3KyneV0m78hduGJ+k/ymiFaJ//+D6G9Cj
 Zd4t/LjuHA6Q1rbqIIxUD9HfSpnxbhLDBzKgTmy5y/+JRFGKlEC2W
X-Gm-Gg: ASbGncvEV0ihlnYA8azLM2XNAyg9ezpzrK2tFevXECghzY/vwiKDhmS+UJepL53jPzY
 WDL+01rAfYXAztRWsxWvRThFoGTEcpDYl8N0EYb4QqvWAcCdsWKTtkyhRXpCDYwvI6o/Qmg1mGu
 t8fAcP9N3vvenoBz/15fkwWPXVltSswKVi2cFJGjGdfR5vRCRcf4kQLJM7CAvdqaFLcCrtwRvF4
 JGtGzXP7bOUXh61K4pgeN/YRFzd3IiLTyawNdA0SSOQpgXbiQvxj6IxXw46RUFpUPAfaj3tO+5X
 yFMiVSFydjWWeiPpIeCAn/x+hmSy7OGTPMN9
X-Received: by 2002:a17:907:2d87:b0:ac3:cff:80e1 with SMTP id
 a640c23a62f3a-ac738baeab8mr1014745866b.56.1743515323193; 
 Tue, 01 Apr 2025 06:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtkMSwraE2O/OdOUOVHDdzpW4kU5LuyLoVq1Theq6NBP2/UTCupswwvABWxCHmESJdGJPWHQ==
X-Received: by 2002:a17:907:2d87:b0:ac3:cff:80e1 with SMTP id
 a640c23a62f3a-ac738baeab8mr1014743466b.56.1743515322844; 
 Tue, 01 Apr 2025 06:48:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac774e83a1csm210465666b.88.2025.04.01.06.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:48:42 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:48:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/6] tests/acpi: Add empty ACPI data files for LoongArch64
Message-ID: <20250401154840.1d591aa8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228092729.543097-5-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250228092729.543097-5-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 28 Feb 2025 17:27:27 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> Add empty acpi table for LoongArch64 virt machine, it is only empty
> file and there is no data in these files.

this patch after 3/6 doesn't make sense,
either drop.

Adding empty blobs, can be useful (as then you can get ACPI diff during test)
but only if you follow update acpi blos process as described in
bios-tables-test.c


as is, the next patch (5/6) should precede 3/6


> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  tests/data/acpi/loongarch64/virt/APIC | 0
>  tests/data/acpi/loongarch64/virt/DSDT | 0
>  tests/data/acpi/loongarch64/virt/FACP | 0
>  tests/data/acpi/loongarch64/virt/MCFG | 0
>  tests/data/acpi/loongarch64/virt/PPTT | 0
>  tests/data/acpi/loongarch64/virt/SLIT | 0
>  tests/data/acpi/loongarch64/virt/SPCR | 0
>  tests/data/acpi/loongarch64/virt/SRAT | 0
>  8 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
> 
> diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/SLIT b/tests/data/acpi/loongarch64/virt/SLIT
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
> new file mode 100644
> index 0000000000..e69de29bb2


