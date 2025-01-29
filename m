Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B96C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8tA-0003hU-VG; Wed, 29 Jan 2025 09:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8t7-0003gX-MH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8t6-0005oi-1V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738160271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chtwMj/HRjPGTAqiDPO5QGx7lgksbBXgnF4FSlMcayg=;
 b=i1bklT8rq/BiNrtMNIUugKpalRA6Mq19IWJulkW6F9AQFvERs7eouBn0dJBoQhz9AyX7pu
 lIelXXqHgacyJx3LQojp+luG9abgr/CriwLdS2u0IQswiCyG34uCNgonE4upSujvCjfHWC
 uCluRKwci7xpDDOADIVlwweaoMwvkjo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-p_LMqFjQOwGlAT5nAOTRJw-1; Wed, 29 Jan 2025 09:17:50 -0500
X-MC-Unique: p_LMqFjQOwGlAT5nAOTRJw-1
X-Mimecast-MFC-AGG-ID: p_LMqFjQOwGlAT5nAOTRJw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38a684a096eso3085597f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 06:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738160268; x=1738765068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chtwMj/HRjPGTAqiDPO5QGx7lgksbBXgnF4FSlMcayg=;
 b=Pvvpk/fLCl5I0fNOA5uUS3rIBr++1ZFtr3TRCuwskYWoetahsshY6jZTpe11nHvhdh
 fEb5BmmU4G/eaezJs5uvNfJ0GgBcEYweGw+X0P3WUWIySrHHZi4r5hbJsUQr7kpeAGEA
 YhMWUk+o9GoXDEJ8Ze5Ke/TGGouMnvyYpmygSXvo3JGf/lUoCTqyQqbSVTZQSMM/rUly
 MucG1sVPzQpOZaWBh41VahBw/3pBSlWHbEPwKmNAmBFLqdlZdoaimuio3TdZqusU5EoZ
 5rCubwBempVLW1CplIArhTPRhCAa28LCfa4S6k4Y0unZXoiAiUjRajXlBM29PQUBzW6p
 VT1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI2UQOroAnDfym+fOrJxDpwWvPjsNVXhG2aTvI8BQeol5BKroQjqm4vP38Kp/NxOSUP5rAZYx8bcTp@nongnu.org
X-Gm-Message-State: AOJu0YxG2YG7Wi0ET4a6Irm+fvqn1khx7rdXaFt72vWTL8yjQHUEPBU8
 U0vq6W+FT/cgsmgeZUi+CpdOvUos7MzmnwiHx1T8zdqHMyutcKVrJ2EKv+VPoXj6WCza/jT7V6M
 E9OlDREV/7MFpz6zR1BhI9Ik0Bxa8VqRpZi3TUNJIO9UHCf6NLEM8
X-Gm-Gg: ASbGncu77YkyR3jKf7aVmCTOkegHxlB6N3mQ5Ob8Ly6FAsEnMXySK27jAg2XUywcjkG
 waAJJNy1s9v6+Vvi62yppu2QOTorQ+pROSGr0w8dtfGKhMC0Bgf9cxthg6uTorgk99C8mt6D7qE
 5NVa15btxmw6QoezLTdzitVzCm9akauavJXLyQWtveFj4WiiYpuzBP8cezxjqNyzFbL2uBJQiSP
 fL7mMYlq3X0h9FV2rG6/EqEl9fPb8cO7TiClrYmXuFHfDcs7AjTOt+A+MrTo38V7TVq9xPXd496
 7vF6OK7q1SEP2wpZobzdAKt0N+GZKIPgPfVy8V38e4UIsqwcqwph
X-Received: by 2002:a5d:64a6:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38c5195e09emr2697579f8f.14.1738160268640; 
 Wed, 29 Jan 2025 06:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfYUk8B3xnsApvqTwWboDKHAuSOBtbXaOx90nUBBz+aXVKkft7lp3CZyX1yptCva9ilbn9GQ==
X-Received: by 2002:a5d:64a6:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38c5195e09emr2697554f8f.14.1738160268299; 
 Wed, 29 Jan 2025 06:17:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11ae6sm25124565e9.6.2025.01.29.06.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 06:17:47 -0800 (PST)
Date: Wed, 29 Jan 2025 15:17:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20250129151747.4b8a7691@imammedo.users.ipa.redhat.com>
In-Reply-To: <e0a95da158091e77642eaad9cdbbd7377d257980.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <e0a95da158091e77642eaad9cdbbd7377d257980.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 29 Jan 2025 09:04:11 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
                           ^^
typo?? Should've it been 'as'?


> location too.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index c85d97ca3776..5346cae573b7 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -386,6 +386,34 @@ static const VMStateDescription vmstate_ghes_state = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_hest = {
> +    .name = "acpi-hest",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool hest_needed(void *opaque)
> +{
> +    AcpiGedState *s = opaque;
> +    return s->ghes_state.hest_addr_le;
> +}
> +
> +static const VMStateDescription vmstate_hest_state = {
> +    .name = "acpi-ged/hest",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = hest_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_hest, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
> @@ -398,6 +426,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>          &vmstate_memhp_state,
>          &vmstate_cpuhp_state,
>          &vmstate_ghes_state,
> +        &vmstate_hest_state,
>          NULL
>      }
>  };


