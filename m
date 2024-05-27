Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEEBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZIL-0000Q1-2B; Mon, 27 May 2024 08:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sBZIA-0000NP-LD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sBZI8-000262-Ho
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716812247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1bsF/No3dpd3mbLnFjx0yZoQXn+rzOJDzaT771MnkE=;
 b=NFH5jM1FpL8r6xCJW8gpxZzDWdb2Y3K4syWjnVyI9FOooL6o3BbiwsZNCrde9sp5F5xOmP
 S/Qt9y5GIjszuu6W2dREinVIXdbIjNCMrwpneL1acKe/vwgt6GS67g1+PSb9ytYK9BtU2I
 Jp/wNrbzoO6IpvnYyyJ42/KhbVO9vqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-VHP4KcDNMi2dmvb0STbKFg-1; Mon, 27 May 2024 08:17:25 -0400
X-MC-Unique: VHP4KcDNMi2dmvb0STbKFg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35858762c31so360150f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 05:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716812244; x=1717417044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W1bsF/No3dpd3mbLnFjx0yZoQXn+rzOJDzaT771MnkE=;
 b=KNGztvhgDOlz/jjFh9JqDX2x4xT5Y2yK9I4lukNIFPY16iYh+ErDSC1UxrqiBvXgR4
 vOQ8CatEVPqZCjPme9CJCAvV+vtyWy1sn+8qWMKasUHjlIhmCX2dRerMbtk2WSPSuOx8
 6waHbiSKjmBciNWXbvbhN5IfIcg5qSgNuofbibhK8dzamqnhWKBezVzit73frzU6HCuF
 gjU13XL7Z1r41TU+Hb5mtoWY8TTk0vePLOgpayiiIE4+OJqJRUK3EvaR0EX1EJyMp33G
 cg3Q9uYl3Q0qANQdi3la0JqPz/9ba6ujbkP2Fa/sUlkxnQKOMKhh8PK0OjceSklLIqdY
 E1yw==
X-Gm-Message-State: AOJu0Yx4lqxmMps8aRs9b0AgBALHHeaGMRCUUYWAeguiW+cvsjAtX/BZ
 aupbU6UIPPOJX9Z4aS1mx5m1FVi5/Kdo39abuVd7Zp8/1vEalNkIZDeGbrhXc+ny3P1x3ha4R0l
 DPPnPOFjPKbUs+FE0w4DQe15PjuQqM1c/XpFZsbVvRlzqXmXbcIas
X-Received: by 2002:a05:6000:178a:b0:357:16f6:71dc with SMTP id
 ffacd0b85a97d-35716f67664mr5533017f8f.13.1716812244452; 
 Mon, 27 May 2024 05:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtp/G0vWE+vjQ0PPt18gD5q/MSKpLWswXyx/S+XX7fIIXXT04ku9sig2tB6z02vYk+XICGKw==
X-Received: by 2002:a05:6000:178a:b0:357:16f6:71dc with SMTP id
 ffacd0b85a97d-35716f67664mr5532993f8f.13.1716812244104; 
 Mon, 27 May 2024 05:17:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:151b:2482:8f7e:1f56?
 ([2a01:e0a:280:24f0:151b:2482:8f7e:1f56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7d963sm9002065f8f.21.2024.05.27.05.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:17:23 -0700 (PDT)
Message-ID: <8d121c09-6831-4289-bf36-c17dd28b4cfd@redhat.com>
Date: Mon, 27 May 2024 14:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Remove unused macro VMSTATE_ADAPTER_ROUTES
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org
References: <20240527121351.211266-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240527121351.211266-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On 5/27/24 14:13, Thomas Huth wrote:
> It's not used anywhere, so let's simply remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/s390x/s390_flic.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index bcb081def5..382d9833f1 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -35,9 +35,6 @@ typedef struct AdapterRoutes {
>   
>   extern const VMStateDescription vmstate_adapter_routes;
>   
> -#define VMSTATE_ADAPTER_ROUTES(_f, _s) \
> -    VMSTATE_STRUCT(_f, _s, 1, vmstate_adapter_routes, AdapterRoutes)
> -
>   #define TYPE_S390_FLIC_COMMON "s390-flic"
>   OBJECT_DECLARE_TYPE(S390FLICState, S390FLICStateClass,
>                       S390_FLIC_COMMON)


