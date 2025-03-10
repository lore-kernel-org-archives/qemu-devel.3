Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95E3C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYbl-0003Yw-A2; Mon, 10 Mar 2025 04:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYbi-0003XG-6Q
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYbf-0006zR-3l
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741595723;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daC4BU5S0mC+i0VzydxElRDB4WtBtTcNIF2KtY/I+mA=;
 b=axTn5mJyTWc13zd74FX4RzasFHDXZ0nk31eRghvnQosI+KEFKPJfi0d3q06n8mvZ203JJg
 EwKN+d3DST1foK7qVsVs1m3m8R7/63vryitR5K3eeDDaxPwUolmkKE+06Z68drqL77Maqh
 pN22g+Rqeu1EdM+urYQq4Haeg7hLkp8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-6wmxGimKOB61qCNVXkqGeA-1; Mon, 10 Mar 2025 04:35:20 -0400
X-MC-Unique: 6wmxGimKOB61qCNVXkqGeA-1
X-Mimecast-MFC-AGG-ID: 6wmxGimKOB61qCNVXkqGeA_1741595720
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so702955f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741595719; x=1742200519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daC4BU5S0mC+i0VzydxElRDB4WtBtTcNIF2KtY/I+mA=;
 b=M+NQh5ucVVt/eWmxT7XxuU6lsGG8JONOjXWwgTirSOQvfmdOUi4dekofyfjHqhZv0a
 Czuojt/mFDzr7i0JIiyjvoq86YmXFs6IRHmesASFCQpdlDbMLZwjSr8B/vayBn4K8q3u
 Wxg3+CrvJQo6VCvlnyn1UxjWZMq41RLo2wEAuLMX4tJcH6e6uzE0Ywh/E9rycMTGQBzc
 uVHk7joiXIIzyII4s7s7yPs3lq/H1jYhNqWAMgwllfCQNd/ttn8So+CuVJo+s9raWUVl
 zAg3RENJLzXFWIx0Sh2qdwmdo95Rirt2RxuA933Ix0REW1UnijHKS5hCsH8+sZbM8a09
 zy8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXixjh49cXIJXjGxAD53WBvsp1+QFM91kKza64VC4V6SngVMT1rrg6sdIdWfMxe2qUQCsZuL7rkk3w+@nongnu.org
X-Gm-Message-State: AOJu0YyaqN8kkRKoQbh6nkwhYk8a/zrD+DupX/fRsIzIiShYkVBWvzZ5
 vz8LTAL2HtftIPtsBtuxROQcrNPS89wLWzBdAyr5R/+s2n0f7d+NZ+eAzYqYqHZIK5IrzijBvGc
 9Nmhdp4LB1zIVuYTbpVn8yMyWCeldyqbKgXyBeQ4jowGGsU8Kxjgl
X-Gm-Gg: ASbGncsgONUcP3RasqbEeiZ+fE8HXVhZwRcjgxlvTfUCUvxauZUJ0v6GnTokb8JebZu
 T7JprzuIdj/A6ux5SqFk5f2XFKhYvp38Yn844TAPSrPCixujnFH4aCXjvw59L82YPXTKf+eUDah
 gTgRex0DG1da1CWkCs625x4YE4lCfrJfjVtp6364bwcfNx8ye0b/kONOvK5oRO/6wQsGsIJU+R7
 Q2/k7Q4257KuiCrLTdzOaruLnB4hGfyo8kPSrsBAZ9dhYMG9mwJnXKgseE4hO+fzFRvvFG6XZxG
 LvzFBmGm7gZqAAZQ48W9wzQqlpDMAa6jAoWPLXEqP1OGBnwBhyakinOOXp5lxnY=
X-Received: by 2002:adf:8b1d:0:b0:391:1652:f0bf with SMTP id
 ffacd0b85a97d-39132d8dc66mr6182058f8f.33.1741595719555; 
 Mon, 10 Mar 2025 01:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZyunp2JiW/VAYGxEAGq3xNyc98fyx68X0URgkyxZeEIJwmAoKmRZHq0cEsAUn2egUeBreWQ==
X-Received: by 2002:adf:8b1d:0:b0:391:1652:f0bf with SMTP id
 ffacd0b85a97d-39132d8dc66mr6182028f8f.33.1741595719133; 
 Mon, 10 Mar 2025 01:35:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c019557sm14552470f8f.50.2025.03.10.01.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:35:18 -0700 (PDT)
Message-ID: <b2e6da22-28a5-4430-8e97-851320b38f0e@redhat.com>
Date: Mon, 10 Mar 2025 09:35:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/21] system/kvm: Expose
 kvm_irqchip_[add,remove]_change_notifier()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-9-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> Currently kvm_irqchip_add_irqfd_notifier() and
> kvm_irqchip_remove_irqfd_notifier() are only declared on
> target specific code. There is not particular reason to,
> as their prototypes don't use anything target related.
>
> Move their declaration with common prototypes, otherwise
> the next commit would trigger:
>
>   hw/vfio/pci.c: In function ‘vfio_realize’:
>   hw/vfio/pci.c:3178:9: error: implicit declaration of function ‘kvm_irqchip_add_change_notifier’
>    3178 |         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |         kvm_irqchip_add_irqfd_notifier
>   hw/vfio/pci.c:3236:9: error: implicit declaration of function ‘kvm_irqchip_remove_change_notifier’
>    3236 |         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |         kvm_irqchip_remove_irqfd_notifier
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/system/kvm.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index ab17c09a551..75673fb794e 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -412,10 +412,6 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg);
>  
>  void kvm_irqchip_add_irq_route(KVMState *s, int gsi, int irqchip, int pin);
>  
> -void kvm_irqchip_add_change_notifier(Notifier *n);
> -void kvm_irqchip_remove_change_notifier(Notifier *n);
> -void kvm_irqchip_change_notify(void);
> -
>  struct kvm_guest_debug;
>  struct kvm_debug_exit_arch;
>  
> @@ -517,6 +513,10 @@ void kvm_irqchip_release_virq(KVMState *s, int virq);
>  void kvm_add_routing_entry(KVMState *s,
>                             struct kvm_irq_routing_entry *entry);
>  
> +void kvm_irqchip_add_change_notifier(Notifier *n);
> +void kvm_irqchip_remove_change_notifier(Notifier *n);
> +void kvm_irqchip_change_notify(void);
> +
>  int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>                                         EventNotifier *rn, int virq);
>  int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,


