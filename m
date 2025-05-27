Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A6EC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJw0X-0005nc-Uj; Tue, 27 May 2025 11:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJw0V-0005nO-U9
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJw0Q-0007eQ-2D
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748358855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8apzc3hKBADlByrGAcTgFkrtIBoYZ8sDMVLHX0c8uCA=;
 b=aUIhlsO1tyR7Z2mDtPsxElqeZ9LqBT24L+pPk6Ica2X2YHiuicus6b4sxCPy8Oj794cFZ8
 sxt3moukZ8JZ1wPLu9gyiUlHFuxTNd4FX2MyTy3Rx9RQCZ0OVpjDp525cAyv4h7ui2e9dX
 DhxN2uuDmCm1K3djiY508MqnyY7KGws=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Zkki0u7_O8CTkhnLBVRLVQ-1; Tue, 27 May 2025 11:14:12 -0400
X-MC-Unique: Zkki0u7_O8CTkhnLBVRLVQ-1
X-Mimecast-MFC-AGG-ID: Zkki0u7_O8CTkhnLBVRLVQ_1748358851
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4e6d426b1so16505f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358851; x=1748963651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8apzc3hKBADlByrGAcTgFkrtIBoYZ8sDMVLHX0c8uCA=;
 b=uH4NstqaVjuSusSuAeM4R1zNM4SfVh/jDl39PcHF+NIFpO/YekIf1XHnbo1X5AFsEz
 V5Dv9QHnn0V5UiQL4BbvewbkHmUgZQDBLd0KCwWWAEglF+t1jWQ4Zo/+/1EOQYsb86y3
 rEpHCSuvmLHUrturZ+X5VXe4pGkQ3uKVhBBcieZAA6CRvasz7vNrL2U7pLOnXlW83M+K
 /38qYkwTYTTYulBE0FZrzCtf8OD7BRdW7nbGQ1/o3mGS8f/CCDXW3l4KeX6aB6gilKEE
 CEHtg5GE1v9hsgthfc4AFFnpWougBZc79WD1kWt4ina03Ntw9HJ2L5XWP4enHMSqbHCz
 HWDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjiLHYoxjsJIaZKwECHy1VK1q0g4nrA9BRQ4I90Ih8p3DhFn16Mh4MtKj6eGCr3r/6/qpFNZ4KEmA1@nongnu.org
X-Gm-Message-State: AOJu0YwQ99ShZFnq+SIlR17fguI7dpuEhELKAySkZBhujK5ITiNKd59R
 UQsqlAF9w1v2T5cvuqLhQ52mIQIPJudyJXFemQbKDVFZOecidXiRkxnNP4UFaMfwcERPz0nr2Nn
 e1IaYdV1SRXfwlAO9BUKHOrzoqS8CUBriBIIldSsro4L44Cjeg4Uu0v/5Xq6o/CPY5TE=
X-Gm-Gg: ASbGnct1hhmapypbQE1JyVO6oAhgfs0WC5spOcfXf1gU8o7u0dWK94yEMEFn9z0zTME
 9taXxe+d6YxpluFcrMgiF8Bw1/ec3dR2ClCdmKoFA7P19rVfwm8QtEjZwIocLJ+cCJIfthjQgHW
 muOjds2hQpQiV4+SJj016VxcxEsEkG5KWM/gQ1397J+deGtrRx+tAcTQYijESCNzyHEZacmX7ar
 exkCXTqrrPR+fp2+enf45jlOIIp+nM/bozxZ5YOzP61eusiSyVefpClj/oF98ft7Pv4ZUv8bshe
 UNcv1FWHISUKWjT6ccm1J2ULniX+9hA1
X-Received: by 2002:a05:6000:4006:b0:3a3:7816:3e17 with SMTP id
 ffacd0b85a97d-3a4e5e8f81emr995574f8f.8.1748358850688; 
 Tue, 27 May 2025 08:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqGZWvY5PDzZ3XuOSmdcVPw9TShlR3sH9ZrMNaws4CU0lehkUsOKulHdomABBaynjBkfrAjQ==
X-Received: by 2002:a05:6000:4006:b0:3a3:7816:3e17 with SMTP id
 ffacd0b85a97d-3a4e5e8f81emr995545f8f.8.1748358850337; 
 Tue, 27 May 2025 08:14:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d5deae4dsm7410998f8f.2.2025.05.27.08.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:14:09 -0700 (PDT)
Date: Tue, 27 May 2025 17:14:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 20/25] hw/acpi/ged: Support migration of AcpiPciHpState
Message-ID: <20250527171407.364f68ff@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-21-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-21-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Tue, 27 May 2025 09:40:22 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Add a subsection to migrate the AcpiPciHpState state.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index c0dbf9b358..9334249cf5 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -415,6 +415,25 @@ static const VMStateDescription vmstate_ghes_state = {
>      }
>  };
>  
> +static bool pcihp_needed(void *opaque)
> +{
> +    AcpiGedState *s = opaque;
> +    return s->pcihp_state.use_acpi_hotplug_bridge;
> +}
> +
> +static const VMStateDescription vmstate_pcihp_state = {
> +    .name = "acpi-ged/pcihp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pcihp_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PCI_HOTPLUG(pcihp_state,
> +                            AcpiGedState,
> +                            NULL, NULL),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
> @@ -427,6 +446,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>          &vmstate_memhp_state,
>          &vmstate_cpuhp_state,
>          &vmstate_ghes_state,
> +        &vmstate_pcihp_state,
>          NULL
>      }
>  };


