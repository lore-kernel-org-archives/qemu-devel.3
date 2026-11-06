Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B8606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QSZ5h4s0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qXQC5th5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIqh-000085-Rp; Fri, 06 Nov 2026 07:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIqf-0008Vx-1M
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIqc-000700-RB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gj8hMmQ2qGvr894SxcRYilzXBAxKdqiiz7fhFvhquQg=;
 b=QSZ5h4s0YfIoEeF9CP6ZLQg6n8XT+rv7Zjx9nUCKGE5S/W7s8aO9CRW1Pr3pUk19a6HowK
 GFEZu41PD1tLwS4AHHxm6sEc7ebMMYs4RnoYQlajw6uDr8tLdH5HVVKNMHHpkZIvKXlf0C
 YOJRtkqhJmAm+l1inZXz19xKF0pyWNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-YdlxxQhDOf6pOBjahioAaA-1; Fri, 06 Nov 2026 07:15:08 -0500
X-MC-Unique: YdlxxQhDOf6pOBjahioAaA-1
X-Mimecast-MFC-AGG-ID: YdlxxQhDOf6pOBjahioAaA_1793967308
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a77c1cbd15so5944925e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793967307; x=1794572107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gj8hMmQ2qGvr894SxcRYilzXBAxKdqiiz7fhFvhquQg=;
 b=qXQC5th5axpSvnTnTRrFACHHFQ7x1gqkBVrEsE3fWVb0lWPLuFzJs5YO46FLYB8pRG
 wvuF9w3rUZLqGKkB7G8xY8My8IGKxiSmkxtUMKgV3L0txD3FaSUSSPZ1pIPRSxBjH8fT
 vO/yYBsxVbLvUhqhHk0cxIU/sT+dolPNhWM7ixYByiey6fhfC65Z93BX5MvKPRJEv8yz
 trTR3ps3DZaWa2dcTj6K/CJ3A5sqmt4GzU20EiEfvCdKdIwHb4KKFRZn6HpRkWFO0yhj
 wmFLPNfs7GLPQdJu2VSNOLAtxQjng/4kOQB9kQsm8FJLEcOcy78mgY2ltfdhBhAAbsDO
 OkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967307; x=1794572107;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gj8hMmQ2qGvr894SxcRYilzXBAxKdqiiz7fhFvhquQg=;
 b=yxoFJJ+RhxpkFv55c1x6EfBH1NUFUD36OMAdbbEp3bfWu9ks8Eyy4cWu+8LOUoDzKu
 N4FA/NGYoLOE6kl5O36A6J4mTwEY2oI66zaA+zhpT/RLtYYIe/kxUPMTPyV+jqMDu2tS
 HXfK16Lb8jEn9aK+fgJDwPZTBUNXh4mEU48kjCGTyuIszVGOeClHnAA46sUBpW6wlfjC
 ivU0hU4Vvkwj+LpaARz90a7sNyc+ygWUImR39n7bHW3QP9qAPFgg/brSZScdU77T15VI
 BblgX4xa1gyF4HwdQ4pedjwXW/49vMNCs7fIwHwuXJyBJnBhyYCT/vFaiIGzwAkvgmDq
 hxGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzz869Jc7TLK3gfpaS7JUo8vdqthQi7bSnf/4znR/j+Y1l2h5TmPkFV7x9/AmKhTu2IAVz5BkMief6B@nongnu.org
X-Gm-Message-State: APuU4Z/tOiOtRgGeAvhe3qDdp2qd6hZr3Au+Qn//Tzb0NEfuZrYXix8S
 DF4MPQfmCJzI+UbjjMQU9bH7PRSSLEUHx4apz4zbGQUd+p2uMpaW5qM3dpN+li1Vb/PxMQyXCY2
 jDvMixBI4PIeaKHgmRYWlfMhf7lehblg+rDCgf3vbhk5hi3lIDzN+1St9
X-Gm-Gg: AYBFou2dDygaeqnBesjt/MYE6UAwJ/zQ1EQJ6t8ZaoJqFBNpr+AYI7VJWyTFaiG89mT
 0/9E+jN8+PR4Hk1XcnA0vGsYDIjVw4j/Rht96ipQx4PNt7Y7MsSlsyM/y/H8s7AxRkbTbHS/TcV
 KSfZB8nC/pKIi15NTv28H7cT1ENz3d0M08KBwhVfJ+hXMqUKfy/fqsL16hItw1nL0hGqg36pKUE
 5BsMvMNrMS8dHjZADnqQoGBMtSkB+Kmj2MKzmOm6ZRKoHCsNR3qEvrtm4XXYFl4URmB5OsTDBSf
 0qz18+uQvOBH0EgMY5TZXTAXzTGQeoYo35E7PgmaxKoRX5nPukMlWmKjsx2Y2WaWkkx2vwjhuaY
 1ZrVGmwvRr7Lb+ShnK4daa3PSIHrxy04umP3Q0BB5B18huD3he7s9Csa2aVuUadzC3VIktqh6n9
 UjTs6MlxrJpA==
X-Received: by 2002:a05:600c:8b45:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4b6df11dd57mr37875345e9.12.1793967307708; 
 Fri, 06 Nov 2026 04:15:07 -0800 (PST)
X-Received: by 2002:a05:600c:8b45:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4b6df11dd57mr37874945e9.12.1793967307255; 
 Fri, 06 Nov 2026 04:15:07 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e168f73fsm57802835e9.5.2026.11.06.04.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:15:06 -0800 (PST)
Message-ID: <87375890-eb39-42b7-aa17-40a9416ea279@redhat.com>
Date: Fri, 6 Nov 2026 13:15:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/28] hw/scsi: mark spapr SCSI controller as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-11-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> The spapr vscsi controller is used by default with spapr machines
> in a virtualization use case.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/scsi/spapr_vscsi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 7ec780da79e..eedae00273e 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -1312,6 +1312,7 @@ static const TypeInfo spapr_vscsi_info = {
>       .parent        = TYPE_VIO_SPAPR_DEVICE,
>       .instance_size = sizeof(VSCSIState),
>       .class_init    = spapr_vscsi_class_init,
> +    .secure        = true,
>   };
>   
>   static void spapr_vscsi_register_types(void)

Reviewed-by: Thomas Huth <thuth@redhat.com>


