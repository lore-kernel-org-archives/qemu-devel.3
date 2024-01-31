Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD18C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVC1d-0002oK-FX; Wed, 31 Jan 2024 09:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rVC1c-0002o6-E9
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rVC1a-0001mB-TH
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706713034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ETGcb5D5wCkdTjFS4wUq3RZooG7XYtSHFFh/E7tLRKE=;
 b=TEXinp6N7nEr8irn7ellOeWW3lx4mmeko2WrreVZKvgpfEh/ge6mL6pfjWJCZUBZGJ7ZeP
 VnEn1miOjyjeHxtrK/b1kPXfyICaUb/HcBHAEd2bsFnLIzbW1Fc4LRLrrrtJsvvMPhze9Z
 z74bO5+86j2j3KduJ7vCc77lxrpuwk4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-QdxFuyKxNfu-2ky8bCe9_A-1; Wed, 31 Jan 2024 09:57:12 -0500
X-MC-Unique: QdxFuyKxNfu-2ky8bCe9_A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5111abb53aeso1841693e87.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 06:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706713030; x=1707317830;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETGcb5D5wCkdTjFS4wUq3RZooG7XYtSHFFh/E7tLRKE=;
 b=UkzrFQxYfRKGLYy/1efAvM7udeY/dN3E9lltWLqiF3n9MKiuCEjk5gxmsBAsk2RpEx
 mgl5OaGZWRNt63LAocNiiGw49JLPl7i0Dw1n1e1XVUOeIfvut0QXYf4Dr9SKbbWi1fyP
 2Tn6lvStHuedsaXL4DmvniVrrHvlhrvpkRnz+QILnT36YZXdDuRN1SogSwf6jlTEqgXC
 42PF2DdjRtEjhnHjFtecMpwGxwpQcyXWx+d2f5/e0jg3Hg5oEpWS2g95qgeRjHUkzPih
 TEbP0RKc3kFNKQCCuGQL5SVkifkSqhgiW6yIT+yNxgfWnkOG4INoOHr57r/XlGhFdr36
 2MYg==
X-Gm-Message-State: AOJu0Yyj3bqnFP9udXLbZ1QgFsfljhcjyAU6IFOXmrMwzwA3qHkq9g7F
 hGG4UAk/8BGF8UKsB6U9iUT0GrS6CROtg6JR/BSYwCJqjw9hJvtJKY7ReheUYfsl0CCSL/AlAxC
 GSCHGU89r8YQo2tximH6NyWZlm3Kaxi+jUw/zda06w7xu82reEyV/
X-Received: by 2002:ac2:4e6e:0:b0:511:ecf:e5d5 with SMTP id
 y14-20020ac24e6e000000b005110ecfe5d5mr1224352lfs.6.1706713030648; 
 Wed, 31 Jan 2024 06:57:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQUJLMV0Tp7KXIxnK+nwruVdWMNVxIF4GUzjHTiuz7T/7QKGBfEgDDmGZq6bJJYKhqE5/0pA==
X-Received: by 2002:ac2:4e6e:0:b0:511:ecf:e5d5 with SMTP id
 y14-20020ac24e6e000000b005110ecfe5d5mr1224339lfs.6.1706713030207; 
 Wed, 31 Jan 2024 06:57:10 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a05600c354300b0040ef79b2fa6sm1836428wmq.33.2024.01.31.06.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 06:57:09 -0800 (PST)
Message-ID: <00584dd7-f89f-4595-903b-54fbff260983@redhat.com>
Date: Wed, 31 Jan 2024 15:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] oslib-posix: initialize backend memory objects in
 parallel
Content-Language: en-US
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131134843.3074922-1-mark.kanda@oracle.com>
 <20240131134843.3074922-2-mark.kanda@oracle.com>
 <46fc0732-8735-4440-b14a-13e2389d7d6c@redhat.com>
 <578395fd-9538-4d3d-85ea-f5e9b95b8bd7@oracle.com>
 <7686daa5-c175-4b2c-a6ad-72d3c78b2249@redhat.com>
 <6a5773e2-6887-4cd6-995a-209affd71b74@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6a5773e2-6887-4cd6-995a-209affd71b74@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 31.01.24 15:48, Mark Kanda wrote:
> On 1/31/24 8:30 AM, David Hildenbrand wrote:
>>>
>>> OK. I'll call it 'PHASE_LATE_BACKENDS_CREATED' (to make it consistent
>>> with code comments/function name).
>>
>> But then, you should set it at the very end of the function (not sure
>> if that would be a problem with the other devices that are getting
>> created in between -- if they would be using one of these memory
>> backends; likely not).
>>
> 
> I think I misunderstood your suggestion. I was planning to add it a
> 'phase_advance(PHASE_LATE_BACKENDS_CREATED)' to qemu_init():
> 
>      @@ -3703,6 +3703,7 @@ void qemu_init(int argc, char **argv)
>             * over memory-backend-file objects).
>             */
>            qemu_create_late_backends();
>      +    phase_advance(PHASE_LATE_BACKENDS_CREATED);
> 
> And use PHASE_LATE_BACKENDS_CREATED (instead of
> PHASE_MACHINE_INITIALIZED) for the async bool in
> host_memory_backend_memory_complete().
> 
> I was planning to leave this call where it is:
> 
>      @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
> 
>            object_option_foreach_add(object_create_late);
> 
>      +    /*
>      +     * Wait for any outstanding memory prealloc from created memory
>      +     * backends to complete.
>      +     */
>      +    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
>      +        exit(1);
>      +    }
>      +
>            if (tpm_init() < 0) {
>                exit(1);
>            }
> 

Yes. The only "suboptimal" things is that if someone where to create a 
memory backend between qemu_finish_async_mem_prealloc() and 
phase_advance(PHASE_LATE_BACKENDS_CREATED), it would never get preallocated.

That likely won't ever happen by any of the remaining stuff in 
qemu_create_late_backends(), especially not with "prealloc=on" and 
thread-contexts set.

-- 
Cheers,

David / dhildenb


