Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E975C54E68
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmENy-0003Cl-G8; Mon, 18 Mar 2024 10:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmENu-0003Bf-LA
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmENq-0006tV-6C
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710773674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kd/kGOJTpPvIMBzzU3SR6sOxd1gq+FPvPOVzWXj0+n0=;
 b=X4CNuJX1o96j1V7lUm/SmNbJy7BbYx8FXQcE61gl6Ngpc6dQOjlQYrCtpbk4yxB1FlV+IM
 Oe8R8shdmTsdUbV6NlDAy5wuNFuYECa6b9nUkgT6Rl6DXeikdw6ElLLsxEIOgVRkiJJnpZ
 SWoAqMv4HmO1wjIHvx1jWI/YqTyXcCI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-0qkykdN4P4Sh9f3WsFxv-g-1; Mon, 18 Mar 2024 10:54:32 -0400
X-MC-Unique: 0qkykdN4P4Sh9f3WsFxv-g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-513d3f026d4so3405304e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710773671; x=1711378471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kd/kGOJTpPvIMBzzU3SR6sOxd1gq+FPvPOVzWXj0+n0=;
 b=Z00f6L/2xWtiNfcmE01p4dwAgDb/MBMQsRSDuQP4UgWQ3jxqb6lpO52E4mawTyU0xX
 xNOSXt+q2I6WE9U9gHngBVy8sKBH2zGye1aFvgGH+sklQ1880jILWnWYqnDiLtAMEmOD
 hf24dsPRVpy9DZu9plOWC1qqWy3qBzy7zgFylgnHjtPzf1p7kgg928rvsyjxBh0nJpoA
 R6zF9s3W6hvTB+jAVG+3hbglObzmlEftAUeIFl8cqvPnUdUdfxdflDIJ4WCkuck5SYF+
 38weDnDYsC44SWuJIu16rc60rvgY/0xJ6MO2l0dkmZbZKc1AGz0xEUulxAn9KiFtW02j
 piFw==
X-Gm-Message-State: AOJu0YypLmJomGAFiznEDXePVzPJnbSUK2jYDCz8mvsGABjQ44Zv72bD
 MFF+iWW/96syflk+oq+XD1UHR0u8PFgOHkTHr+L3fuTXTXZK3htxOGF8Qq04fdo6X+yPruPtAra
 a/9kLd9P3Gmj9AU3GXILNFQeWz2YGv2607EJfS6Lh+OslPTWvbvmO
X-Received: by 2002:ac2:4651:0:b0:513:9f30:e33f with SMTP id
 s17-20020ac24651000000b005139f30e33fmr8166540lfo.23.1710773671444; 
 Mon, 18 Mar 2024 07:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc5qM/iYGgNroKS7LqnIicERJlDdtAFZAFpePqHippvOvJiEmkKcwVuj9TfS5phwAFiFTOGw==
X-Received: by 2002:ac2:4651:0:b0:513:9f30:e33f with SMTP id
 s17-20020ac24651000000b005139f30e33fmr8166519lfo.23.1710773671107; 
 Mon, 18 Mar 2024 07:54:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ck19-20020a5d5e93000000b0033ec81ec4aesm3695916wrb.78.2024.03.18.07.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:54:30 -0700 (PDT)
Message-ID: <40d6777a-7d58-4fe1-a441-67df73ca5efd@redhat.com>
Date: Mon, 18 Mar 2024 15:54:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/25] memory: Add Error** argument to
 .log_global_start() handler
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-14-clg@redhat.com> <ZfQukLXQsgFEap4f@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfQukLXQsgFEap4f@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/15/24 12:18, Peter Xu wrote:
>> @@ -3009,13 +3045,16 @@ static void listener_add_address_space(MemoryListener *listener,
>>   {
>>       FlatView *view;
>>       FlatRange *fr;
>> +    Error *local_err = NULL;
>>   
>>       if (listener->begin) {
>>           listener->begin(listener);
>>       }
>>       if (global_dirty_tracking) {
>>           if (listener->log_global_start) {
>> -            listener->log_global_start(listener);
>> +            if (!listener->log_global_start(listener, &local_err)) {
>> +                error_report_err(local_err);
>> +            }
> IMHO we should assert here instead of error report.  We have this to guard
> hot-plug during migration so I think the assert is justified:
> 
> qdev_device_add_from_qdict():
> 
>      if (!migration_is_idle()) {
>          error_setg(errp, "device_add not allowed while migrating");
>          return NULL;
>      }
> 
> If it really happens it's a bug, as listener_add_address_space() will still
> keep the rest things around even if the hook failed.  It'll start to be a
> total mess..

It seems that adding a region listener while logging is active has been
supported from the beginning, commit 7664e80c8470 ("memory: add API for
observing  updates to the physical memory map"). Can it happen ? if not
we could simply remove the  log_global_start() call.

Thanks,

C.



