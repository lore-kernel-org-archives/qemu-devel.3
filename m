Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0n6-0003Bt-JN; Mon, 19 Aug 2024 07:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg0n2-0003Aa-Ba
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg0n0-0001Ev-6k
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724067789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17jyWeoONpjyGGI56CQoEQmnYqkX6odmOILY01oA+ic=;
 b=aCVHXI68R9nZTTVC/OIuMpmnrLS2TaS3o/wJdCpzfvhlfGuYlQO3V2FABFfqREG/pfp/MH
 vd+0sEHVFPDS/yfQTfiVqGIda/qFNgif7OmDvVbQHS1pmoTN6baQaA2gPEDlM1aOEMf8XS
 QYMLlMtk4m89Id+9ikU4G5y4SLlNuoA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hQfcra1ANdCidtrdbSn3Ng-1; Mon, 19 Aug 2024 07:43:07 -0400
X-MC-Unique: hQfcra1ANdCidtrdbSn3Ng-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3717cc80ce1so2602333f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 04:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724067786; x=1724672586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17jyWeoONpjyGGI56CQoEQmnYqkX6odmOILY01oA+ic=;
 b=Sh9OQbIOQt5DAZQlxGpPR8kkiIPrcZojiQaQi9kgb8FcmELMJLMMPeJb08LzNbRycp
 MqZ3Y6+L/+HipyRkcAwF+soNW8pAYrZyQ4aKEp33wKQBJOykLz+41u11cFgcxZOSwHNp
 sxvkp2FfJMfmTl3TzBSPMGH4JZ/nLwMJSI1EFoANWFXcEo4DRYyEL9hhsBYrt2Ko+YFu
 PAvlfnZhe5wE3ZwD3RX0KsHJ2V2a7yfLb3SWaZ1Qxj0gk0YxFRd44wWxVpCSXgQOUHh+
 lxn9PVDQmlXDvSiKHdVUyL2xE5etE+sj31oPEOShbv05xj1TgeynsQXrSnmaE+XZSfV9
 +kAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOmCV4csYsA9qemq8t40tQzSt6I6cTNdl8Q+Pt1H5ZbXiIzP7QQH5aYciWi4OmLgfTO9p9vDpY6m7BLZTIBeeJKrj9iYY=
X-Gm-Message-State: AOJu0YzucuUPkCXsnjQDWerWdSadvqBy66okcy9R09zqR4we+TbW5q84
 /mZupLi7dtS9ipW6c/CTxQAqknfnVRIV//8RAd2GtNT4LfUi4RpIB+HhOZyRCfk8lYNccCzDufV
 iKsXPty0ZyXQvVnccA2ddm94yD2+hR/DprvEfi8sew4akX88BEJUh
X-Received: by 2002:a5d:670d:0:b0:367:9903:a81 with SMTP id
 ffacd0b85a97d-3719469fac2mr6086913f8f.43.1724067786435; 
 Mon, 19 Aug 2024 04:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWyMzsfmGeIApO4W5+0bsHLh6op/eqv7THYktyM6hkYdNs7seHGgscXFYllJRCPq6znqduEw==
X-Received: by 2002:a5d:670d:0:b0:367:9903:a81 with SMTP id
 ffacd0b85a97d-3719469fac2mr6086901f8f.43.1724067785934; 
 Mon, 19 Aug 2024 04:43:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a2eesm10352516f8f.19.2024.08.19.04.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 04:43:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:43:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 03/13] acpi/ghes: Add support for GED error device
Message-ID: <20240819134304.68c54eae@imammedo.users.ipa.redhat.com>
In-Reply-To: <ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 16 Aug 2024 09:37:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As a GED error device is now defined, add another type
> of notification.
> 
> Add error notification to GHES v2 using
>a GED error device GED triggered via interrupt.
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is hard to parse, perhaps update so it would be
more clear what does what

> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
>  rename HEST event to better identify GED interrupt OSPM]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---

in addition to change log in cover letter,
I'd suggest to keep per patch change log as well (after ---),
it helps reviewer to notice intended changes.


[...]
> +    case ACPI_HEST_SRC_ID_GED:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
While GPIO works for arm, it's not the case for other machines.
I recall a suggestion to use ACPI_GHES_NOTIFY_EXTERNAL instead of GPIO one,
but that got lost somewhere...

> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GED, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index fb80897e7eac..419a97d5cbd9 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> +/* Those are used as table indexes when building GHES tables */
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> +    ACPI_HEST_SRC_ID_GED,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


