Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFE2D462B8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBEeG-0004n1-GU; Wed, 13 Nov 2024 09:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBEeD-0004mq-BR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBEeB-0002xa-OD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731509224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wFOiQRwymZNVWLuulqah69rhCOdnus3rboWHHPb7W0I=;
 b=Bcw6O6fSg7OqZ3MEaLAK3kvCf5dcH2mnFFiryzOcaZq6rFZaL8/Z4cH45iPX85XftA6wj7
 zB0OKhP0TeT9amISeyTZTf8k5oNxKFMkcNFy6BZk19Myp7iFzTGM3u/0dDTJWqi+8pcx0t
 TFNMxtYiR1AsjbtzIz+EOzkBvxlKpaU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-9s17l7aOP3uHjSiCpdLXxA-1; Wed, 13 Nov 2024 09:47:00 -0500
X-MC-Unique: 9s17l7aOP3uHjSiCpdLXxA-1
X-Mimecast-MFC-AGG-ID: 9s17l7aOP3uHjSiCpdLXxA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-432d7a082b5so2745165e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 06:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731509219; x=1732114019;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wFOiQRwymZNVWLuulqah69rhCOdnus3rboWHHPb7W0I=;
 b=hB4onf2F8VnHrU1Oaghx9GhYFZOVuTfaQtDU6fS77meYh1aa3hVzYikONt4oIMO9PE
 1nN7g9L1kqRcFnNNwBO20PJDtAg+rLLT8GnrOpXyv+zbFNEIivOyzZeetJNzMDQdvXYy
 LjluStVcxlejPvjhprlfyzOY8s1MXWSPzVsFoA4co/7wqb+WJfjBmTjxZe83NNHNstID
 Zvv6/kaeS0dQH13cPIRnAH42SANLK0Zz0LP1mU8oKst2ENNqmTUUOov8Xb+mqTDlmJ9I
 7punMbDqe2FDzznS1d7EzSk7PGgv/jh44oy89uA7UkaUGfbbElsekJ4dOyPGSkhZHYq1
 RbIQ==
X-Gm-Message-State: AOJu0YwLE2iD6ZT82imdu861yzG8jJZTabzfFH7Z9lFqigZ7pIRciVXU
 EtmgRr6xf4amrqJMsJql2Ko4s7vT/hCP+4wxWFoAFnuHsLekws07io3izmlb2Iq1/HkR3oDcZm/
 uLfuH80j3UNQFvVjgOYZv3NI1Pvpi7MFM+/x9t/Lm1i9eWQcX2WyIhV/HNt5xTb53/kiHmrdhX1
 kR/7aJiQkCA1Ay+ocRAwH83sl9+vWUWyZz
X-Received: by 2002:a05:600c:138f:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-432b6872c8bmr178266935e9.15.1731509218757; 
 Wed, 13 Nov 2024 06:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe77LZAUO4qkJRz2PlYkKUUM9hCDAf/nnwug02eQDgZdqpNh2TPyULD9cV3lS+ZRY+AhIguQ==
X-Received: by 2002:a05:600c:138f:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-432b6872c8bmr178266595e9.15.1731509218318; 
 Wed, 13 Nov 2024 06:46:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539?
 (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de.
 [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9978c6sm18552657f8f.50.2024.11.13.06.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 06:46:57 -0800 (PST)
Message-ID: <07ca4492-1590-4cc6-94a1-0eea417da59e@redhat.com>
Date: Wed, 13 Nov 2024 15:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] s390x: virtio-mem support
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08.10.24 12:54, David Hildenbrand wrote:
> Based on current master.
> 
> There is really not much left to do on s390x, because virtio-mem already
> implements most things we need today (e.g., early-migration,
> unplugged-inaccessible). The biggest part of this series is just doing what
> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
> well, messing with the physical memory layout where we can now exceed
> initial RAM size and have sparsity (memory holes).
> 
> I tested a lot of things, including:
>   * Memory hotplug/unplug
>   * Device hotplug/unplug
>   * System resets / reboots
>   * Migrate to/from file (including storage attributes under KVM)
>   * Basic live migration
>   * Basic postcopy live migration
> 
> More details on how to use it on s390x -- which is pretty much how
> we use it on other architectures, except
> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
> 
> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
> be documented in the kernel and at [2] once this+kernel part go upstream.
> 
> There are not many s390x-specific virtio-mem future work items, except:
> * Storage attribute migration might be improved
> * We might want to reset storage attributes of unplugged memory
>    (might or might not be required for upcoming page table reclaim in
>     Linux; TBD)
> 
> The Linux driver is available at [3].
> 
> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
> [3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com

Gentle ping (and thanks to Thomas for the review!).

I assume the kernel portion will go upstream in the next merge window. 
I'd like get the QEMU parts merged soon after that.

9.2 is going to get released in roughly one month, so there is still time.

@Thomas, this is mostly s390x stuff, so I guess it should go through the 
s390x tree? But I could also take this through my "memory devices" tree.

-- 
Cheers,

David / dhildenb


