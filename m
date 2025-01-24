Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E376C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGc9-0001Au-Nq; Fri, 24 Jan 2025 05:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbGc8-0001AC-2D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbGc5-0006vp-R5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737713312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBjlmnyL+/0MoaysJf/6GyTT+XbsU4a0p4ksOTJUm98=;
 b=QH4wvdbbxrdS7JDkJ7fjegEAkZtX+frm+yDD/dAguID0ZnQeoI6J8aau/0e5FL4OYgFgU9
 jE9QXqnPyIH/3+50C/nF0tFncML602OH/0PLm5Bs+tv5Yh+RzeEStgwcyl4E18pdkD+BHA
 1uVopChg0pW0guo7IeHX72tTZ9R/p3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Rn6ZqxSFNkOq4HzYWwnAeg-1; Fri, 24 Jan 2025 05:08:31 -0500
X-MC-Unique: Rn6ZqxSFNkOq4HzYWwnAeg-1
X-Mimecast-MFC-AGG-ID: Rn6ZqxSFNkOq4HzYWwnAeg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38a35a65575so1247340f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 02:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737713310; x=1738318110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBjlmnyL+/0MoaysJf/6GyTT+XbsU4a0p4ksOTJUm98=;
 b=qN1rF4dY9QxFyH7lzYxjkFPl/YeB6vMAP1dxBIHe1iTx2UStPJlw3XswpUu/DKN25o
 7+5+vDGe+4IZCW0Migjug0rQNDPQs3Vtnp+2F+zEnBQfgyhldjg3cSLEwjD00DwIYxiu
 7LgpTr+5LzYqoLTKUWHnAHAggZ6+5wgwnkQTTRLGuAOmnueiguJYZeOF48OmZ4/uW3nt
 Xp0VNDHKkE0duqZ9yxjUITNK8i/W/ZaJhK1+lLPhXt8M+my0XHhnpCUYF4OD17IV99I/
 ZpdOQ0SiyojAVLf1rN+OTCBXNowgIj5COAAdjKBlfPBMH5EvCxT4EAnQnnWVR/1wpj19
 7Pkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAOs1ZSvQEvUdbwm5Lf4sD87ZCpsp53Y3TxS9hT5KS37cE9Gzd2ME4MVB7ZCc6xVd8tkIpD28wbnsw@nongnu.org
X-Gm-Message-State: AOJu0YzIGjIuehRlV3MrvZojBWiz2W2TeqGcrOxc4FmTlyuv6KL0SMNX
 QK9gSNqXaTIJgKEmqOxnvnBUIkFBhz6yqIsmq2hKsF4wPE8DLi5pA6Q45kE1O4eLqna62+QD7NC
 sfiKvSjZ1TJ2E+dn45332g0sr5FxrLDXFDf/QI26trUjdi+GmGDIR
X-Gm-Gg: ASbGncsn6fWyHxfkiOg3vXRhOG3Ef77fljU97US4GXz1ZSaYgu52tpZHm3b5BKkReZv
 J8Mmt3Z4oF0jM4kE5BzkDqtfzDWTQkmIS/WuNZXqIQuF81pqqQyFWwRLfhs5gUZxpcetCY4FnU7
 zycaXIOoHFErlQ7N3O1oZXFoktyE/HBjIWUg64g6R+YxRXtx0npBsN/vGcHbGfJKGgN+H6+qmRV
 rEzT6NluL6umfpQA88fgilq0BETnMvPrfRHpYmPdyh2lLSt3h919aBIgGTOlk6muibMwZVZrNjk
 QzC3/6tDZTOTNC6/7O/GusS5DZro5Uv2CDr2Msg+kw==
X-Received: by 2002:a05:6000:18a7:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-38bf5663683mr28298498f8f.17.1737713309874; 
 Fri, 24 Jan 2025 02:08:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERNvOfS/alHeCZWgCxIxMk72mjHqfT9IuLIqCtRqqhMBdhIt9cqgbhjZb46dH7MEAr7LJgeQ==
X-Received: by 2002:a05:6000:18a7:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-38bf5663683mr28298453f8f.17.1737713309454; 
 Fri, 24 Jan 2025 02:08:29 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d5d4sm2183937f8f.21.2025.01.24.02.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 02:08:28 -0800 (PST)
Date: Fri, 24 Jan 2025 11:08:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] acpi/generic_event_device: Update GHES migration
 to cover hest addr
Message-ID: <20250124110828.3a2b92b9@imammedo.users.ipa.redhat.com>
In-Reply-To: <6b79da0dbd8d735e93c15c4673bf2af61e8c34a2.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <6b79da0dbd8d735e93c15c4673bf2af61e8c34a2.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 22 Jan 2025 16:46:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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


