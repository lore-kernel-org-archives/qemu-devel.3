Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC6CC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdYS-00006D-4Y; Mon, 10 Mar 2025 09:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trdY2-0008T7-Q9
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trdXy-0002N1-Pa
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741614715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XXPykD1PpJG6hNH8QRnzKyM/h9qCy9GNid6QUj8zA8k=;
 b=Ka1JmQyNnEvMm0Pncef+z0BSsJEn6PbsSop0dYud2RtTPUb9LkyG8MpLTYtLeLl492szsw
 gyVdCtftxjobyvTcTI8QFRN+PNn3TaXtguM9P8Gk2gJj7oOYWqWM3lqRNHTQAZhMDKvs4v
 hKPG5VWK0fLu0mV18lcQ4B45WPCFlro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-uVK86C-XOh6JsuaVBatpnQ-1; Mon, 10 Mar 2025 09:51:52 -0400
X-MC-Unique: uVK86C-XOh6JsuaVBatpnQ-1
X-Mimecast-MFC-AGG-ID: uVK86C-XOh6JsuaVBatpnQ_1741614711
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ceed237efso10816935e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614711; x=1742219511;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXPykD1PpJG6hNH8QRnzKyM/h9qCy9GNid6QUj8zA8k=;
 b=ruFHy873WHJOqZt1G3ijDQmK1R2QpGNS5b3QjioEovq1bb6pfz7P9xnoVxQHXFhj4N
 63XnESJTdKuk+GK/Q8JfMce3UOR5eYv52H19L2Z78AFwiAirz5FCokP/p8MJwBUvHMr/
 p9Puc2bMgGzUdool8CXs/dEs5cXhNKhVIeJ7odpBNF5uBy7ldWVSwEMiTyYG7WLFq+6C
 Dd/zQU8CHjkeZsgSZIy4OlhhKijYNlfAf9O5M1oCH6Tm7lrrAN+Drfc+z1dCMP2IXvOW
 FUjxYG2wtVgi+Tx0s2CWK8As8P9sQ1SGWlUEgBfI1ptqgqb5YnMxB70uRTuSvhPSqldb
 EQeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxrWs1CJZfLSzA4QTaNJRnecE3K+V8iMkwcs3zNgM3OMTdPwTPZK3GE3drMYhSDvtP6sw4N1CwJgb6@nongnu.org
X-Gm-Message-State: AOJu0YxK1akU0EidVE1+YEH9v9JDM/MecSge5QucoaWL5T3vQgSGR03L
 7SttwufhMvz6mcOKhBu+TlABxsNmdcWuTUe876qW+WiIehdx7pcki0gyoPW1Fs3LDKL/BvaoQpp
 79U/9XBT5EUlvqm7FucYPiEiM3jEiWC3TI7c7Z4tYzf3FGQ9f1M0k
X-Gm-Gg: ASbGnctGzAIKu5PB6vGFHPiJl4lBkncEtNmcPkCSRRoR/P3j40WVrcLD1TEYn7pqjSo
 tBn72bFJ3N8MReXO1SKhskYIkmsrQqZoXbDWjCXJB0SzYOPC+hLZcslwLwNbD0/xbLoEZJ4by7I
 ktRMZdLy7yz+BEJjNXImMw8AYPAeEGXfhscurFwy7yCujnoyPspZ9NKPtRRw96ug8XhVNgGOmrd
 IQYK03EkaKlQKegP8MrEnQ63ESpPx7Ii/P6QKAj9LDarfKPfaqlhTpQ4/3YBW7D1iTfSQs45Wpm
 pHL1YKuR3RtT5TlcBCZC9p4Z5BPRCNsBsGOQN/qM1CnsBKxPMk99yg==
X-Received: by 2002:a05:6000:1564:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-39132d1f9b9mr9831041f8f.16.1741614710926; 
 Mon, 10 Mar 2025 06:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBrou+68AFLDaC70LmJA0jrrA+pkTeLERuHibyL9LeNbE6o7n/aWrLAd7ywC6I0b1XBFfEag==
X-Received: by 2002:a05:6000:1564:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-39132d1f9b9mr9830993f8f.16.1741614710588; 
 Mon, 10 Mar 2025 06:51:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm15153302f8f.59.2025.03.10.06.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:51:50 -0700 (PDT)
Message-ID: <8f62d7ac-7109-4975-84a2-4a7fa345dd74@redhat.com>
Date: Mon, 10 Mar 2025 14:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime
 using vfio_igd_builtin()
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
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-13-philmd@linaro.org>
 <415339c1-8f83-4059-949e-63ef0c28b4b9@redhat.com>
 <7fc9e684-d677-4ae6-addb-9983f74166b3@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7fc9e684-d677-4ae6-addb-9983f74166b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/10/25 14:43, Philippe Mathieu-Daudé wrote:
> On 10/3/25 08:37, Cédric Le Goater wrote:
>> On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
>>> Convert the compile time check on the CONFIG_VFIO_IGD definition
>>> by a runtime one by calling vfio_igd_builtin(), which check
>>> whether VFIO_IGD is built in a qemu-system binary.
>>>
>>> Add stubs to avoid when VFIO_IGD is not built in:
>>
>> I thought we were trying to avoid stubs in QEMU build. Did that change ?
> 
> Hmm so you want remove the VFIO_IGD Kconfig symbol and have it always
> builtin with VFIO. It might make sense for quirks, since vfio_realize()
> already checks for the VFIO_FEATURE_ENABLE_IGD_OPREGION feature.

I have explored this option in the past and it's much more work.
Stubs are fine IMO, if we can have them, but I remember someone
telling me (you ?) that we were trying to remove them.


Thanks,

C.



> I'll see if there aren't other implications I missed.
> 
> Thanks,
> 
> Phil.
> 


