Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F9C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B26-0000qK-5f; Wed, 15 May 2024 05:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7B24-0000pF-Kc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7B23-0000KY-25
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715765682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYY7qL7yQKDA5KCd/NwffBnFX9jI2y1qlbUghWjH9ZQ=;
 b=IPEvMbuKaSWPHp9rQRr4Yyy2sULwzqtMwmEUOIgjVP8Oq5E94KWj0ZwgQ7wDJ8buwwo588
 wFwcqYfcyWKUFvELgYrXRhrBkqtjZMV431xYIU+zJWyO3p/SKUXULRu+TGFLXE/9f6sTRk
 UYgnMT/qZx1sbjONelQKGTRsakKXMEE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-G1yV68_6NKiY-ltjxEk7fQ-1; Wed, 15 May 2024 05:34:40 -0400
X-MC-Unique: G1yV68_6NKiY-ltjxEk7fQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792c1773bf6so903363185a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715765680; x=1716370480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYY7qL7yQKDA5KCd/NwffBnFX9jI2y1qlbUghWjH9ZQ=;
 b=U0zvAgw6xBI6byADk4Sw1COEuhXQzyJfBpUUuspLfvNkl9CMjxCEXVYGKWmBPyD4TM
 uidjgv1l0Sut87mX2JVATULXMnBlhk0FD5xhgvUL4eE7dWkvVfSrBVbBQurfZ9JEa5A7
 aHfd0Xk5icONHIbRA+eauCEJ3DxVi8jBJw90NBwHPd+UUlG8Jc+Ou/elM5+S0aVfgrGO
 6llTNJ8TRsIyoFpbvDGdBkhlv1qPH4P+TMb52Qij2RZ4yqYu9qtrFZLpSUvuIhbgfOJb
 s8uGgrGC3bo1D1WPveC0klUcDFHnnheVTGpGgcU/VHFa3wQMhTmk2cfeR4JG/ASLzXUu
 Go9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjKxlpc2n+++0L1vbvO9c0ag4jWuPbm8uiy6XL+1qklcT3T5HYURK0lsUP/iZ7XTA+1hxs+yzpycpTyXhYN+BzbRZp6jo=
X-Gm-Message-State: AOJu0YzVXBDZVfwJMkH6yqT+jsvARwnutbu5CpnkOh4xU5m/rSbhPybk
 XWRGcnuSNPVgqb8lerRQidO6pX64W81ydANXkKgy29rzXSID3kz9RtmbPBuqromT44hnwQEzjmb
 6gHIxEQlUjIiBPefYiygl9jA0P7VpmsF+Tisp5znPMGkE6rwZhdWT
X-Received: by 2002:a05:620a:1466:b0:790:7780:73ac with SMTP id
 af79cd13be357-792c75f4b29mr1503336585a.52.1715765680158; 
 Wed, 15 May 2024 02:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLvz+x+Aq7byzloyJfFpmYGUBBMFHM+7pbOLEzWfPGdnKmwh52rj4n3eU52/QB9OpfEDzIhA==
X-Received: by 2002:a05:620a:1466:b0:790:7780:73ac with SMTP id
 af79cd13be357-792c75f4b29mr1503334985a.52.1715765679798; 
 Wed, 15 May 2024 02:34:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fca1dsm661770585a.92.2024.05.15.02.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:34:39 -0700 (PDT)
Message-ID: <6fa99439-2f89-4074-ae8f-83fe626ec2b6@redhat.com>
Date: Wed, 15 May 2024 11:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio: Also trace event failures in
 vfio_save_complete_precopy()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-10-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-10-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/14/24 17:31, Cédric Le Goater wrote:
> vfio_save_complete_precopy() currently returns before doing the trace
> event. Change that.
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/migration.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index d089fa9b937e725307c1a56755495d5b8fae2065..b06d887df53155e676bf13fa03adaf0627841994 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -585,9 +585,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>      ret = qemu_file_get_error(f);
> -    if (ret) {
> -        return ret;
> -    }
>  
>      trace_vfio_save_complete_precopy(vbasedev->name, ret);
>  

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


