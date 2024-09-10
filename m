Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F0BEDE9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5sJ-0007ZA-FE; Tue, 10 Sep 2024 14:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so5sG-0007QS-7D
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so5sE-0003DB-IR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725993957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XazKTCHVCR0h0gWd5J/3zah2/8aKU1d3lDvkrDsdl74=;
 b=InArRkpRtcuTBSPTfxJT9cal573uQORZgJcFkmrDit+4cKxRZvA0Lt+594tYyFmL4uaGRu
 AMsfMGt+jzAijpTotRbZv08cK83sFtSz60Jf9MlmNQLHoMZNlfVGc3KIgYo6lHW9MHyRA9
 xnWWTzwyya2eerOzXjbIM8D4shOH/UI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-PtQPjWNkNamxEg4CqzH2fQ-1; Tue, 10 Sep 2024 14:45:56 -0400
X-MC-Unique: PtQPjWNkNamxEg4CqzH2fQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb08ed3a6so601485e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993955; x=1726598755;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XazKTCHVCR0h0gWd5J/3zah2/8aKU1d3lDvkrDsdl74=;
 b=asKhKllvS/mmltAmflLvDTlo9Elyrw4BnqQFNFLHMaWuKpQn8iqQCliNMsPeNJNDzd
 Mff+CHgLQNv3tBvD/vVpAZtB+bTflDa46eXE9MWyoq0fqoLx4LMwDVNrsE9KbKCvU5j/
 OLgG8UQM8VZmpQcsaz+7pE0bJcDtshICy048zjiAMsFmOfxZSzdRy2N9sn/Y0iKLsaDY
 U8k9VK99vVLsWA3ejTWUHawnNcJ5QQ4rx387GJY+ZVIl9gOvQh2sXvCLZWqV8fU81Q77
 barzyBMiNx36vZ5Km3rKEFYYVA94/gM/gjfFYKB05HY3+th1tyQbo7BNpmB7Tqz6jmpf
 xjHg==
X-Gm-Message-State: AOJu0YxBSs8pv4dT0Sye65lHeydmhFumBjyCF2M/Bm1A02KTZO8+BR0O
 aWHr+S3BLvBCtELU9Tt6VpTpOCF1EjZ7yvZY2tOS13KabA33DvW4UMeaFJK7UNlHPoeL6ueqITG
 Fn+nwet1lPUTPCNnVuwtnYTwSGsSz5KmjkVcIjRp/GQmB4nuUi9//
X-Received: by 2002:a05:6000:178e:b0:374:cde8:20d9 with SMTP id
 ffacd0b85a97d-378a8a7ab29mr3352226f8f.23.1725993955313; 
 Tue, 10 Sep 2024 11:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRh6i0F4fngQn1S+j879Aj0iS2aBrjlodlg9cx0n0+WZGKY64QhBG+2ZR4vjxhGvM7HZNfZA==
X-Received: by 2002:a05:6000:178e:b0:374:cde8:20d9 with SMTP id
 ffacd0b85a97d-378a8a7ab29mr3352209f8f.23.1725993954808; 
 Tue, 10 Sep 2024 11:45:54 -0700 (PDT)
Received: from [192.168.3.141] (p4ff237ad.dip0.t-ipconnect.de. [79.242.55.173])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb73ab096sm82813525e9.22.2024.09.10.11.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:45:54 -0700 (PDT)
Message-ID: <393855d4-10fb-446f-a391-ee7cc7cc5556@redhat.com>
Date: Tue, 10 Sep 2024 20:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910143224-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240910143224-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10.09.24 20:33, Michael S. Tsirkin wrote:
> On Tue, Sep 10, 2024 at 07:57:55PM +0200, David Hildenbrand wrote:
>> This series is based on:
>>      [PATCH v2] virtio: kconfig: memory devices are PCI only [1]
>>
>> I finally found the time (IOW forced myself) to finish virtio-mem
>> support on s390x. The last RFC was from 2020, so I won't talk about
>> what changed -- a lot changed in the meantime :)
>>
>> There is really not much left to do on s390x, because virtio-mem already
>> implements most things we need today (e.g., early-migration,
>> unplugged-inaccessible). The biggest part of this series is just doing what
>> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
>> well, messing with the physical memory layout where we can now exceed
>> initial RAM size and have sparsity (memory holes).
>>
>> I tested a lot of things, including:
>>   * Memory hotplug/unplug
>>   * Device hotplug/unplug
>>   * System resets / reboots
>>   * Migrate to/from file (including storage attributes under KVM)
>>   * Basic live migration
>>   * Basic postcopy live migration
>>
>> More details on how to use it on s390x -- which is pretty much how
>> we use it on other architectures, except
>> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
>>
>> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
>> be documented at [2] once this+kernel part go upstream.
>>
>> There are not many s390x-specific virtio-mem future work items, except:
>> * Storage attribute migration might be improved
>> * We might want to reset storage attributes of unplugged memory
>>    (might or might not be required for upcoming page table reclaim in
>>     Linux; TBD)
> 
> 
> I don't see anything needing virtio specific here, let me know if
> I missed anything.

No, it's really just wiring up virtio-mem.

> A quick look is fine so I guess you can add
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


