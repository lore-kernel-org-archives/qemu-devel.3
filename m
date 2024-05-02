Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C0DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2T30-0003Lj-1Y; Thu, 02 May 2024 05:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2T2i-0003HC-JF
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2T2d-000810-Uj
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714643269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R/r2GpihB/6k5xxAAg8XbIHAhF2MO3HzzKnxOnu47Lw=;
 b=XnMx8om+bAI1IR95peadEAD3Pttv/sX57CIAeiGxTi1a37SqDimfuuXyAf4oVVFI4oZQCy
 pfJ9/j6XWeoZ8g/tpvOaS7reIfDkap6RmwIrHAoXUhjpd5an1WlH2+0ruiFwXCAcOZjw26
 NvdiRYtBHfZYhwSIHSAF3Y5vYMwu5Vg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Jj8YdEowPo2uj7MvHbRI3A-1; Thu, 02 May 2024 05:47:48 -0400
X-MC-Unique: Jj8YdEowPo2uj7MvHbRI3A-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43689e8045dso94807551cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714643267; x=1715248067;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R/r2GpihB/6k5xxAAg8XbIHAhF2MO3HzzKnxOnu47Lw=;
 b=evMR/z3CpdzIWwwpIMkR8zaVso6hxaGMUMwgeBV4/qp/ej0q3qDLns19X6oS4c2vJX
 m7b1a5VLxFrJNfIEqQLN2xySmXJvqnKsXqf/2Xd1CZOY9mZ/kXdKFeI+ielACdrO+SVa
 oQhoVXHK3cLFyFj7MdhB5R77zmIhIjCPSO7GPOehomkCA8DJzIKqNBl3yrRjkRBd25v6
 sJPqcbbu5unOI5yLo+qQGohjk+OcoOgOuYf7j2SB0N5Su+xs9zHd2jhmSLxv+sl7HSOu
 LcKEhCAn0Vu58VgpERpjxxdzh2lV8hhl9cfMfzKcr2/zXzqJeehIW9iDVqctDHrDJ1mz
 VkIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7+vyjQt34ndAix6nCM2naJEV2VPr+AODJqDbElJCizmzaey6x72P5yCwOzXSqKosvnCaczPCn+FD6dJkmkkQRp/xRpBw=
X-Gm-Message-State: AOJu0Yxk7QCj/LX9KbuLwDRP2gvCH+A3L1M5ABUVnFzULyvJ0IeW0Y1w
 18+473AiLV+JmpwlCaS6ekXRkTrlDmxy9MScfbOLl1kSvI8sJUHT11044H8IHie/TD4VCZz7q14
 dGLqwRX4kAYkXTGgCNpTUoZEIDxxJLyy09bBcFx26KlJvztNom9Il
X-Received: by 2002:a05:622a:648:b0:43a:bd5b:3e0b with SMTP id
 a8-20020a05622a064800b0043abd5b3e0bmr1758293qtb.57.1714643267437; 
 Thu, 02 May 2024 02:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Y5oxy8v4AXs4AHK4DZd4hk6S3iapXH+YsReKizYU4DtwtH1bwMPVMys/VtsxFKOYbRT74g==
X-Received: by 2002:a05:622a:648:b0:43a:bd5b:3e0b with SMTP id
 a8-20020a05622a064800b0043abd5b3e0bmr1758252qtb.57.1714643266888; 
 Thu, 02 May 2024 02:47:46 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 b10-20020ac8678a000000b0043718726f76sm307208qtp.90.2024.05.02.02.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:47:46 -0700 (PDT)
Message-ID: <8f301d1a-06ec-4c78-9924-a4379f56d0fc@redhat.com>
Date: Thu, 2 May 2024 11:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] docs: document special exception for machine type
 deprecation & removal
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
References: <20240501182759.2934195-1-berrange@redhat.com>
 <20240501182759.2934195-15-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240501182759.2934195-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 01/05/2024 20.27, Daniel P. Berrangé wrote:
> This extends the deprecation policy to indicate that versioned machine
> types will be marked deprecated after 3 years, and then subject to
> removal after a further 3 years has passed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/about/deprecated.rst | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b8aafa15b..55120e774c 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -11,6 +11,18 @@ releases, the feature is liable to be removed. Deprecated features may also
>   generate warnings on the console when QEMU starts up, or if activated via a
>   monitor command, however, this is not a mandatory requirement.
>   
> +As a special exception to this general timeframe, rather than have an
> +indefinite lifetime, versioned machine types are only intended to be
> +supported for a period of 6 years, equivalent to 18 QEMU releases. All
> +versioned machine types will be automatically marked deprecated after an
> +initial 3 years (9 QEMU releases) has passed, and will then be deleted after

Should there be the word "period" after "3 years" ? Otherwise it sounds a 
little bit weird to me - but I'm also not a native speaker, so I might be wrong.

> +a further 3 year period has passed. It is recommended that a deprecated
> +machine type is only used for incoming migrations and restore of saved state,
> +for pre-existing VM deployments.

Should we maybe add a sentence that they should ideally be updated to a 
newer machine type during a service window with downtime? (well, it might be 
also obvious, so maybe not worth to mention it)

>  Newly deployed VMs should exclusively use a
> +non-deprecated machine type, with use of the most recent version highly
> +recommended. Non-versioned machine types follow the general feature
> +deprecation policy.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


