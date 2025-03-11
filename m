Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE55C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvwp-0000mc-3V; Tue, 11 Mar 2025 05:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1trvwf-0000ZF-PO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1trvwc-0007U3-1Q
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741685433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MAVp8a9y3DuXsAYK0qLekS9Gzq5UifH7XXrS+ItGbq0=;
 b=VCwb/QT0sLhxJZ0IuNMZguzY2csmnr8kyCeJRTjrmuh4/gqM0BF3uDvwxolypGcMVhgmoo
 PGztGe1KVfYw07K1R3g8PZn3qrtzimt5eF2Pql9SgAR4VSqo9uwNeWJ5XTtHF9cfhJUgzz
 rFJ4dsJVUMlsofzD0Eq8rBBOKQyXzA4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-GxQ-U2iqMa-unzYEowU84A-1; Tue, 11 Mar 2025 05:30:32 -0400
X-MC-Unique: GxQ-U2iqMa-unzYEowU84A-1
X-Mimecast-MFC-AGG-ID: GxQ-U2iqMa-unzYEowU84A_1741685431
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39137e17c50so1377116f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 02:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741685431; x=1742290231;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MAVp8a9y3DuXsAYK0qLekS9Gzq5UifH7XXrS+ItGbq0=;
 b=jsd2dmxL0Ro06KCw4vlXQnHWsJM9wGCQSzbGuuogTA/cqdtLgK/aUPomvzHC2hV/IR
 ndlKxZ9eZUSrQ1Qr0Of2RaNEpQuZc8a65SxxXYKlfS0xpE00qTP9nc+3SIEgzX4kOHgD
 JPzwP2fJ7kGYED79KdXJD/giBkEwHAKxPIIWHIepec9JgmB2WkN9fMDC/3FgW8cPGuu5
 O1hdD7bLs5xLi3ywA8DqDLHfQeAg5tN/pai83nQBms0pLJzA4m+kPsHyf9FsmxNELz94
 1HFTJRi7wFNlmf3E83zUA9FF37VCKTF8HCLEEFNc99KvHiyazGMCCZ29LErVMxedjC0s
 i0ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUSpqM+waATZakOD/CM0DM0e2vg66FCWmceyl3oCP0nYuaTxcKKYD1mEBCrNI8VpG5Z+eABJrn/w3l@nongnu.org
X-Gm-Message-State: AOJu0YxYd4nP4/ZBoYxcvzs/hrQR3ZFkDzf0asyxVozVrYGQuQXPQLpC
 WzgfugAfMUghdSsT7cPdVGc36DLGJeqArfQU2w7kxCXv/Vk992rufrp7lS0o/MmMczgbAW26lVe
 0gwHzoiM09MZANrK7mIOCARFKeFg6aAp7I39yYPcE0/4NBcbH2eL4
X-Gm-Gg: ASbGncuzDWyx0U8sxufv4zhrBuj/sqXB04mPisCbBHGBL0MjvvyZOxC6Cl/cVlJMaud
 1BTFDQ12zDvYh7xj+JEcIHlCfwZrXejcwY7J50KVMtazQOSxg7Ge7m3GjoD4l81VE9U0U8YASdY
 QfxiSkwow3RWuST3JFwhnsqlbeNO3d5t21e+INx6gUc9aY97n8HB/ydlHg7i71COs4DaX3NOGFI
 dS9HFVD850IvMWHJEBZUOl/c0FMKdWf2CmeXxiPa7s2Z8EjZFwaQEIyb1e0mVGj78rzsUVBLwRa
 1JOoTcGJIiQpaJsvQVCfjqUGic4d1+6BRhPU/UtQxAHLzSagpSwc/MWYTuTixooXvGxb96GalIZ
 /YHqPrnAACoajTfs2lah1c8lDEgYmf8Zq8+uKerZ26N8=
X-Received: by 2002:a5d:6d0c:0:b0:391:9b2:f48d with SMTP id
 ffacd0b85a97d-39132d89abdmr15281617f8f.33.1741685430992; 
 Tue, 11 Mar 2025 02:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ3it8al/MI1zHEHkSXmzIM/QkgENidmLLKp4coZxLrAjsoS4uLcvCZHcMnIdGM3mMCr9aDg==
X-Received: by 2002:a5d:6d0c:0:b0:391:9b2:f48d with SMTP id
 ffacd0b85a97d-39132d89abdmr15281573f8f.33.1741685430604; 
 Tue, 11 Mar 2025 02:30:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427?
 (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de.
 [2003:cb:c720:ed00:a9b3:5954:823e:3427])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfa52sm17136657f8f.21.2025.03.11.02.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 02:30:30 -0700 (PDT)
Message-ID: <e0dc1d84-6447-40dd-8ed1-e787a93ff64a@redhat.com>
Date: Tue, 11 Mar 2025 10:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v3 1/8] system: Declare
 qemu_[min/max]rampagesize() in 'system/hostmem.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Eric Auger <eric.auger@redhat.com>
References: <20250311085743.21724-1-philmd@linaro.org>
 <20250311085743.21724-2-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250311085743.21724-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11.03.25 09:57, Philippe Mathieu-Daudé wrote:
> Both qemu_minrampagesize() and qemu_maxrampagesize() are
> related to host memory backends, having the following call
> stack:
> 
>    qemu_minrampagesize()
>       -> find_min_backend_pagesize()
>           -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)
> 
>    qemu_maxrampagesize()
>       -> find_max_backend_pagesize()
>          -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)
> 
> Having TYPE_MEMORY_BACKEND defined in "system/hostmem.h":
> 
>    include/system/hostmem.h:23:#define TYPE_MEMORY_BACKEND "memory-backend"
> 
> Move their prototype declaration to "system/hostmem.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Message-Id: <20250308230917.18907-7-philmd@linaro.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


