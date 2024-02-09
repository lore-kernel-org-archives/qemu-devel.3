Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5344BC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYNu0-0006OP-Hp; Fri, 09 Feb 2024 05:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rYNty-0006Ns-HE
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:14:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rYNtx-0007aa-2M
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707473671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXXyWHJnCEt3eienWjnghp8Tvjz+vFk1plNIiAw007E=;
 b=iqAToZmvhoUgZpiaxACNxZDzI6qqFLuVLVHmg5/VDtY0DNR9vNyXcNjYdRjcLJ3dWuB0hT
 v+qwd4E5RHn2Tc4TFVGnJPIwnQnJ444LubuiwSkIo7KgDk1lrinT95QrwemrNN6S6dOYky
 RiYRN/4p5kot6s+TKtM4zK34otB+RGs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-HOLvD1YePYqvhySc3YcEZg-1; Fri, 09 Feb 2024 05:14:30 -0500
X-MC-Unique: HOLvD1YePYqvhySc3YcEZg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42c43f4a601so14586991cf.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707473669; x=1708078469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DXXyWHJnCEt3eienWjnghp8Tvjz+vFk1plNIiAw007E=;
 b=f4hJo5Wl8ZcvGfilVAYK3PUsHKEs4acbix8ApqUKBgW4oAlFTy+jw46NTCn8sAo1Tp
 gSZlUVbEx2tGLahZsxd9JLaT+lFSFLg7jfAmQcnWXCdDffaxq3iwa0/hS8g/0IqPqvxu
 jKH3niqb6shN19dewpx22nVoicJ1al4qhH2ZhQwxyL48aMtUdr7OH4Ycdrcq5vVwalb2
 S9O9BufQDGQ7aYIT3BKq9PO9PmG9J4mqWYNvmydt+uwzPC6LhJeINc9B+8DfhEIcfKHr
 pCUkDawcyxYtk9TLPsa9Z/q952NAeYO0jy4McfsLGjtyu30fMIVfBtxlrjRW6MCWVipr
 2Hcw==
X-Gm-Message-State: AOJu0YwyPkeJmjlVNMItHRpY4uyMY7yM+2fN9oOnAsIp0biKYrytM596
 z+UFDwYr1/D9D26vibB7jR40el6T1/XwdLkhYXIbl6ci9WqF4oLTEuWGRyHpNeiGNGpfUXnYd6T
 Rv7FRLy6dTJj7Cv5/V8W6VvJxUkrnbR3B1N53liz4dt+SfqpnacNA
X-Received: by 2002:ac8:5acb:0:b0:42c:5856:4b94 with SMTP id
 d11-20020ac85acb000000b0042c58564b94mr655621qtd.4.1707473669555; 
 Fri, 09 Feb 2024 02:14:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgevmzfLZw9nAxPtQN+a+h1kf5cM6EQIpNG/iPtsvoITqApZLFPkSIAWcOX3M5fm3B0e8JiA==
X-Received: by 2002:ac8:5acb:0:b0:42c:5856:4b94 with SMTP id
 d11-20020ac85acb000000b0042c58564b94mr655598qtd.4.1707473669221; 
 Fri, 09 Feb 2024 02:14:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV9zzh1Wjx3se0KD25dPOU4QP8xqn5OpVT8Yn03SMZvyhM3FS5GCZ/Q6h4AMduU5SHQxb0RldcWD6L/oYFnxjeF34KHdoCb3ttqMoq4PE8WY26+YYIOcO1Gn5QDLAUxU27QWnW8kcV9SAE5jaE4opGt8jWdJxbHJHi5BXGe/PhDVwj54zphByQOK95epSKn56aODXhxi1sfMdou8/l7J+bHlNh9G/0btHXaAkhXSlWyribacxlHdL1Va1AHkpbL3tvDn8SPs5/n5yINf/eDt6XUFGE2f2UkUV0RkF7tBioJ4ZFR8zdKhg==
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 j18-20020ac84412000000b0042c3b08cc6csm566920qtn.71.2024.02.09.02.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 02:14:28 -0800 (PST)
Message-ID: <c9c45081-4874-4c89-b283-1b19d21ee670@redhat.com>
Date: Fri, 9 Feb 2024 11:14:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] memory: Add Error** argument to .log_global*()
 handlers
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-4-clg@redhat.com> <ZcRrJIrInupeanqB@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZcRrJIrInupeanqB@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
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

On 2/8/24 06:48, Peter Xu wrote:
> On Wed, Feb 07, 2024 at 02:33:36PM +0100, Cédric Le Goater wrote:
>> @@ -2936,14 +2940,14 @@ void memory_global_dirty_log_start(unsigned int flags)
>>       trace_global_dirty_changed(global_dirty_tracking);
>>   
>>       if (!old_flags) {
>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward, errp);
>>           memory_region_transaction_begin();
>>           memory_region_update_pending = true;
>>           memory_region_transaction_commit();
>>       }
>>   }
>>   
>> -static void memory_global_dirty_log_do_stop(unsigned int flags)
>> +static void memory_global_dirty_log_do_stop(unsigned int flags, Error **errp)
>>   {
>>       assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>>       assert((global_dirty_tracking & flags) == flags);
>> @@ -2955,7 +2959,7 @@ static void memory_global_dirty_log_do_stop(unsigned int flags)
>>           memory_region_transaction_begin();
>>           memory_region_update_pending = true;
>>           memory_region_transaction_commit();
>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
>> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse, errp);
>>       }
>>   }
> 
> I'm a little bit surprised to see that MEMORY_LISTENER_CALL_GLOBAL()
> already allows >2 args, with the ability to conditionally pass over errp
> with such oneliner change; even if all callers were only using 2 args
> before this patch..
yes. The proposal takes the easy path.

Should we change all memory listener global handlers :

   begin
   commit
   log_global_after_sync
   log_global_start
   log_global_stop

to take an extra Error **errp argument ?

I think we should distinguish begin + commit handlers from the log_global_*
with a new macro. In which case, we could also change the handler to return
a bool and fail at the first error in MEMORY_LISTENER_CALL_GLOBAL(...).

Thanks,

C.




