Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB5BC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVp4V-0002da-85; Mon, 22 Jul 2024 05:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sVp4R-0002cx-Hc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sVp4P-0005oB-3T
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721639459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2qTnIuphcqW8wcarm4DSBMuGbzYUqje/6tfb5lT5d/Q=;
 b=U6Kanw66p9ewgP8ngaFsB/60DooMzuFAXpKzCgGZjn7nz75Rh3F1VZ6HeOFSYICm53Qzuo
 yuHqqSTamajrJ9+hn9/tDa+YTjl4lUqvQvxbTqE6VvTVWJLQtZLx7csXKcau1fiDXfpWhv
 Ts8vXkSiKdVaLF9RmbRjBNLzWB7mon4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-3vAXxBXTMESos5pwMGKHdw-1; Mon, 22 Jul 2024 05:10:57 -0400
X-MC-Unique: 3vAXxBXTMESos5pwMGKHdw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426703ac88dso28448305e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721639456; x=1722244256;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qTnIuphcqW8wcarm4DSBMuGbzYUqje/6tfb5lT5d/Q=;
 b=xB51Wkqo+S0OhHYB7Qet6hEQ9ycBrf/ybLpeXXTw1e6w5VL16ZyeCoad0MuM/b1LaZ
 VoLr5CJZ627wnNyOQ9eUxY4m2Acl5pPb0K8oggA3K8DFSyLUKSElKmL8HTN1hCP/qpq8
 o7qwDmy8gY7jbNO6i0r3kr6TXjr426ltuEu89zrsH35psVgx5VTjfcscqn7RBJI9n3QC
 OnEMQMQPaXfxS8iSKokcXt58UkdcjjxmDPjzn3WriyuvNYiYiAweWnFVnhiy/ym6RTt2
 a220a+bRR/0pZRH3cQcm8vzlMPl+yqizmcEduzB3QNzT7jk0m4bWAIBROtf9Y0GyaE/C
 UO1g==
X-Gm-Message-State: AOJu0YwcqDeGfwWxzwRLE1UkD8qImbwMlVjfZPvbqsd4BXHjihrWDPnN
 q0wSHcVDnq0Pxej+kgYBJo4vvw2ZEOMLYhCtob2w+oPv1CPMzrPMTe7lf70/ZjM1RpHl4Mf90Dp
 Y6VzdQreo4fEETdLWGEmJ0GVw/18PktusKqWmRxn/A+L/13DWfgg2
X-Received: by 2002:a05:600c:4751:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-427dc52e886mr45040485e9.20.1721639455965; 
 Mon, 22 Jul 2024 02:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqjzOyedfmUSESYgL0zpgNY3Df+4FQfqOiRFuSLYS2Ue5wmu8PpYmQA7+ZOc9EnCfUN589Nw==
X-Received: by 2002:a05:600c:4751:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-427dc52e886mr45040195e9.20.1721639455515; 
 Mon, 22 Jul 2024 02:10:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c727:7000:c050:e303:f8a7:6ed9?
 (p200300cbc7277000c050e303f8a76ed9.dip0.t-ipconnect.de.
 [2003:cb:c727:7000:c050:e303:f8a7:6ed9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d8fbacc8sm106413935e9.28.2024.07.22.02.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 02:10:55 -0700 (PDT)
Message-ID: <5ee0d30f-6e0e-4f1a-bfe6-951d7a00b034@redhat.com>
Date: Mon, 22 Jul 2024 11:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Steven Sistare <steven.sistare@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20.07.24 22:28, Steven Sistare wrote:
> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
>> On Sun, 30 Jun 2024 12:40:24 -0700
>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>> on the value of the anon-alloc machine property.  This affects
>>> memory-backend-ram objects, guest RAM created with the global -m option
>>> but without an associated memory-backend object and without the -mem-path
>>> option
>> nowadays, all machines were converted to use memory backend for VM RAM.
>> so -m option implicitly creates memory-backend object,
>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>> or MEMORY_BACKEND_RAM otherwise.
> 
> Yes.  I dropped an an important adjective, "implicit".
> 
>     "guest RAM created with the global -m option but without an explicit associated
>     memory-backend object and without the -mem-path option"
> 
>>> To access the same memory in the old and new QEMU processes, the memory
>>> must be mapped shared.  Therefore, the implementation always sets
>>
>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>> user must explicitly specify the share option.  In lieu of defining a new
>> so statement at the top that memory-backend-ram is affected is not
>> really valid?
> 
> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
> explicitly add the "share" option.  I don't implicitly set share in this case,
> because I would be overriding the user's specification of the memory object's property,
> which would be private if omitted.

Note that memory-backend-memfd uses "shared=on" as default, as using 
"shared=off" is something that shouldn't have ever been allowed. It can 
(and will) result in a double memory consumption.

One reason I also don't quite like this approach :/

-- 
Cheers,

David / dhildenb


