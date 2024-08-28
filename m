Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12930C54FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIPh-0002xW-9W; Wed, 28 Aug 2024 09:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sjIPf-0002u5-MT
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sjIPc-0006yM-Da
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724850514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPPljR9agu+yzXnNrEBFNEjUxD1C2WRQaoHjp0Uh91w=;
 b=LyiRS4lC0nDQM5IF1qzFHUTnOmbBRPZP+kFrPUYbDnEAvZTNy3wvKOlQ0YkOsL8/IiuwNk
 lkvFNPM/6pixeHEHDE8sXPlDCVYI8fhSNjke2xPsC1cXHMlFHWmBRXDL+ajo9obpM7SM4i
 Vd8EtRc36qJv0yJvqMom2VYlEafO/U8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-X2TN0ICePmGD6SuJaNAUwA-1; Wed, 28 Aug 2024 09:08:32 -0400
X-MC-Unique: X2TN0ICePmGD6SuJaNAUwA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42808efc688so59072355e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850511; x=1725455311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPPljR9agu+yzXnNrEBFNEjUxD1C2WRQaoHjp0Uh91w=;
 b=weeg0FSvLjqupWLEAX4SRKJDDi/QVwig9zF9bPBt6ysTAWna03Xr0KuQ+BnmVclMEj
 MC4UI1gw+3KhBJmGzy7WDTTsl3LClV2hytA2SJ0F1yPh1+RZpI3V4G65QrrDKqtJY1Vh
 1Bu+zTm5x8ghpa9+wWAmqnWBF3xg2tNT29n1iQRU1Vy37r0Re1cGslDuFF//32ni5d/7
 Ac2ULLdt5f9K71HMHQTJ8T5bYogS0YmzrFYdKxFAt+mHOIAEdTdqxZZCIUq8KySjvFum
 DDCGZz2wPqMHXROVxKPRa15F+W7fzSc+OAkAO3TXlCtfksym0RywXl7SkGXQGCvuV0Gk
 eVbQ==
X-Gm-Message-State: AOJu0YzR7c+YqK/R7AsD7LfqbigJE683PCddy1IJ+lbixEyo3kbMWUWS
 t6/sxEM0tKsdO4LVvteK0s2/y6jgvxrGmwsGNxbVIUdHABm6FIl7r8OnwcFrYSnQ5Tz911pKaj8
 +T4zbfYp1VdzIZx77ijjy/bUwb0j1O0p3aV4UDhXkb/r0D/QFDjaA
X-Received: by 2002:a05:600c:19cc:b0:426:5546:71a with SMTP id
 5b1f17b1804b1-42acc8d492fmr110494445e9.2.1724850511497; 
 Wed, 28 Aug 2024 06:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc2L+wHJ/oJ+/hhTToYzzk7pE3x4PJyzVinNRoBGLiRc2QZsKpDcWh6RIhnlPsHpKdCAUaPQ==
X-Received: by 2002:a05:600c:19cc:b0:426:5546:71a with SMTP id
 5b1f17b1804b1-42acc8d492fmr110494205e9.2.1724850510965; 
 Wed, 28 Aug 2024 06:08:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm20867935e9.8.2024.08.28.06.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 06:08:30 -0700 (PDT)
Message-ID: <6a8066d3-caa5-4846-9e3c-34b24b466df1@redhat.com>
Date: Wed, 28 Aug 2024 15:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] vfio/igd: add new bar0 quirk to emulate BDSM mirror
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
 <20240822111819.34306-5-c.koehne@beckhoff.com>
 <20240826103513.082360bd.alex.williamson@redhat.com>
 <216d3028301937887bc684ac905c7088272930ab.camel@gmail.com>
 <d9a3044bf7d9c059fd7cbdb4e12400c11003ae28.camel@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d9a3044bf7d9c059fd7cbdb4e12400c11003ae28.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/28/24 14:50, Corvin Köhne wrote:
> On Wed, 2024-08-28 at 12:40 +0200, Corvin Köhne wrote:
>> On Mon, 2024-08-26 at 10:35 -0600, Alex Williamson wrote:
>>>
>>> PS - please drop the confidential email warning signature when
>>> posting
>>> to public lists.
>>>
>>
>> Sry for the noise. I can't drop it, so I'm going to use another mail
>> address to post my patches.
>>
>>>
> 
> Argh, forgot updating my send-email config when resending the patch
> series. Should I resend it again?

Please do because the result is not compatible with the tools we use
to extract patches (b4).

Thanks,

C.


