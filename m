Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F274C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWgO-0004vP-Pc; Mon, 26 Feb 2024 03:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1reWgN-0004up-9y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:49:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1reWgL-0000pW-NQ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708937392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLt8nYlw72qiXLIC97P4AvR3hZj+be8iVJre4HmKatQ=;
 b=EyABKjDoRc92KA1jOPF8moyBAFlU3ice0jcE3KKDru3SLrwM/ZGwG5d/oQdzKaT18ibIKw
 a25N0AYrKSVmm+CCYinfoInaiGX/N0l/q5Urrf9x7dtCBSf1Pka9pWuXqoc++ZQZSLnDaa
 p2P4mIYuAOA9Aio2AP/cP2cA379vvEM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-rn9aCNIaPvaVvKCu0REC5w-1; Mon, 26 Feb 2024 03:49:51 -0500
X-MC-Unique: rn9aCNIaPvaVvKCu0REC5w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6900ad85a4dso10755546d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937390; x=1709542190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nLt8nYlw72qiXLIC97P4AvR3hZj+be8iVJre4HmKatQ=;
 b=SK0elad9WeQC3CQbkheHkzOyaSOPQxSWEPFrUI/hJI/z7H7lxeZzUFkVyYeuE7tGvu
 h7IgsqfkRPhxJXMAHrfZfrbR0TZ7dBJ8Jb1SNb4RazrFByDUfYNQK+fAS+QJkUc8i98W
 dUVbok8b9CLAejt136HCA6GusxrBnKE6QHFrU3GUz489SLEjsFy4XFOlX/1PziGJ7YAk
 JjAyrb7Cii+CXSQlH7IySGKby3ftiivqkRMywVxpN3MKlH+Nl39EOrk+a2XNEE6C/Bus
 Crgv4QPN8B7EhQ0wmt7ly7A+08uO3slV8l5aVfLbxZAw7m7R/tlJ8v5zcD9bBpfIyL+H
 LUfg==
X-Gm-Message-State: AOJu0Ywa3o+5uwGCjhWjLr2KMWy2WmZRFO1MU30oAxur1LPXvQCNV0mQ
 FmydSsqH74oJGRC6uC5ERH9UaeuVqe+5Om9DljGwA8LFp5MBBAT4dtUsxeGV+tsmXQvYsz1/y03
 +6FN6bphWDK3w/JAlKkCnaO1bR6Jkiv6Il3FkoeuLnMzb3Rjx5v5Q
X-Received: by 2002:a05:6214:519e:b0:68f:706e:4939 with SMTP id
 kl30-20020a056214519e00b0068f706e4939mr12929004qvb.15.1708937390612; 
 Mon, 26 Feb 2024 00:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYrLAXcZzppfxuHYkjez6nIjSI/YNjruLEIaTxr6cZMR70T6uebqHKYMG3h87Y9yE5CdGP8w==
X-Received: by 2002:a05:6214:519e:b0:68f:706e:4939 with SMTP id
 kl30-20020a056214519e00b0068f706e4939mr12928992qvb.15.1708937390377; 
 Mon, 26 Feb 2024 00:49:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 v1-20020ad45341000000b0068f2ea5c678sm2666383qvs.118.2024.02.26.00.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:49:50 -0800 (PST)
Message-ID: <02bf2132-ed34-4ecd-841b-5f93eded7ea4@redhat.com>
Date: Mon, 26 Feb 2024 09:49:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com> <Zdv0BNtJxkd8413g@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Zdv0BNtJxkd8413g@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/26/24 03:14, Peter Xu wrote:
> On Thu, Feb 22, 2024 at 12:33:42PM -0500, Steven Sistare wrote:
>> Peter (and David if interested): these patches still need RB:
>>    migration: notifier error checking
>>    migration: stop vm for cpr
>>    migration: update cpr-reboot description
>>    migration: options incompatible with cpr
> 
> These all look fine to me.
> 
>>
>> Alex, these patches still need RB:
>>    vfio: register container for cpr
>>    vfio: allow cpr-reboot migration if suspended
> 
> I'll need to wait for comment from either Alex/Cedric on these.

Yes. It's on my list.

> As I asked in the other thread, afaict crp-reboot keeps changing behavior,
> maybe I can merge migration patches first, 

Go ahead. It will help me for the changes I am doing on error reporting
for VFIO migration. I will rebase on top.

> then keep vfio patches separately merged / discussed?  

Sure.

> I always see cpr-reboot mode experimental from this regard.  

This makes sense to me also.

Thanks,

C.



> Please consider adding a patch to declare cpr-reboot
> mode experimental if that matches your expectation, until all relevant
> patches are merged, to make sure the ABI becomes stable.
> 
> Thanks,
> 


