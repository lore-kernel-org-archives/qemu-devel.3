Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37B2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOOVx-0002ig-TM; Mon, 01 Jul 2024 17:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sOOVr-0002hN-Ni
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sOOVp-0002T5-VI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719869075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQW9Ia7RjGtdMeiWJ76GopRkoefFrjplnElxFmbP0dE=;
 b=eae25G0GiuQkfBnHvT6ZjLMUTlc/5jlykLV0Oc3Q2+a/CbnTLuI+tCco7a+btKv4LqSdS3
 7u8GhxaIKXfO8EidjhK4N+xAhkAcdA0F5dqdNg6L1xrf97s/JdHrzW7kPpxx28hcCrSJcR
 +JELjOU2yuUuAhPcJDWSGZub+Fxp4Dg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-AyVV01j7N1K31V9Jdjg24Q-1; Mon, 01 Jul 2024 17:24:34 -0400
X-MC-Unique: AyVV01j7N1K31V9Jdjg24Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-62f8a1b2969so63090597b3.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 14:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719869074; x=1720473874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQW9Ia7RjGtdMeiWJ76GopRkoefFrjplnElxFmbP0dE=;
 b=glU+AVx1yKGz3CLk3+KELbfAAU2phN5c1DsH0497342IhzvgqlrxyTbV+Dh46gWFS+
 BidqCss+4PdHKYFKq5FG9O283bISoQi6req7DVs2hIXTWvpha8Bf3povAX1Rh1wjtbcL
 3coJQ7wMbcJPDuCMp3aGxv1ZUYYlR9R0pwWyy4dTr8hWK1R4vHrm0xggwUAfRg0JIEDW
 DKqeRXP9v+ITr/Bdyw8fyiSJNxpDfcRbL2omK7t5H274GHQPOFOkyxTeaiwi6O5SLff8
 6+blof32HXACUdyybOIG5YKaJWeCqKUNKyDjDy719pmZTdO+mJ57HAjMiyA86bHildyl
 w+dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxjutV4joKRHX4BR143oQaY7eZ6Jd098Rl6seodK0FnXbB3PxTdOC9wA5zbRgFOm7a1Fd6EGHQCvufoNf5uODLLM2arNg=
X-Gm-Message-State: AOJu0YxEtofJgJqM0Zv+uwxpiBhLLF8qned0wtTxgBZ00e7Ly7KWmT6Z
 ipr8jAoXnHgsUZJkrzzDhVTDOlbca5YYzo87XajyYlH8MMsSTHai1tm1CZA9D2KzTBMdinv+Bw/
 ueqn2763MnwKzcrSnSHt10AL5XmNbZxoRPdVQY7F+vY/K3zqk1ppy
X-Received: by 2002:a25:a2c5:0:b0:e03:55a6:e867 with SMTP id
 3f1490d57ef6-e036ec4ae6dmr8525714276.42.1719869074210; 
 Mon, 01 Jul 2024 14:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFly7wmO22ThWMYrDLz1+GzEUmqY4wHf1V27GIhMP0yFNtGGywRzkPk7sNxx0v9ZVAcoI7faA==
X-Received: by 2002:a25:a2c5:0:b0:e03:55a6:e867 with SMTP id
 3f1490d57ef6-e036ec4ae6dmr8525620276.42.1719869071939; 
 Mon, 01 Jul 2024 14:24:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4465149bad4sm34565181cf.65.2024.07.01.14.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 14:24:31 -0700 (PDT)
Message-ID: <41d6d6ca-e434-488b-81a8-5db158ecf81d@redhat.com>
Date: Mon, 1 Jul 2024 23:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Attach default virtio-net devices to the
 /machine/virtual-css-bridge
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240701200108.154271-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240701200108.154271-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/1/24 10:01 PM, Thomas Huth wrote:
> The initial virtio-net-ccw devices currently do not have a proper parent
> in the QOM tree, so they show up under /machine/unattached - which is
> somewhat ugly. Let's attach them to /machine/virtual-css-bridge/virtual-css
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/s390x/s390-virtio-ccw.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index cd063f8b64..0d58e5ab75 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -216,8 +216,11 @@ static void s390_init_ipl_dev(const char *kernel_filename,
>   static void s390_create_virtio_net(BusState *bus, const char *name)
>   {
>       DeviceState *dev;
> +    int cnt = 0;
>   
>       while ((dev = qemu_create_nic_device(name, true, "virtio"))) {
> +        g_autofree char *childname = g_strdup_printf("%s[%d]", name, cnt++);
> +        object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
>           qdev_realize_and_unref(dev, bus, &error_fatal);
>       }
>   }


