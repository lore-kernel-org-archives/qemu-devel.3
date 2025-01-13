Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C297E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 06:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXE4i-0007eY-Bv; Mon, 13 Jan 2025 01:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXE4g-0007eG-6C
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXE4e-000364-Hf
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736750239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tEg84/W5FlerU0AsumwaCotEajSz9vCijjzrPwkGdes=;
 b=A86Am1N59FMtO9oZ9K23xhtfIVbqm+Ela6tjxcEXmzcaUaNUMcLagJHWA9lHrwYOhdvQgW
 PM/fhwpR16wiaDUsfBpCSFIN4s+jRpYbXHYIVm+OypwNm3hOoNL/XNnExDoTA3oykksMsd
 mYtQIz7xT1AGl/eDoMXgqYoYTcFybrY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-bYPVLQ3oPo2P00vzDF7Ykg-1; Mon, 13 Jan 2025 01:37:17 -0500
X-MC-Unique: bYPVLQ3oPo2P00vzDF7Ykg-1
X-Mimecast-MFC-AGG-ID: bYPVLQ3oPo2P00vzDF7Ykg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa69c41994dso279978466b.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 22:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736750237; x=1737355037;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEg84/W5FlerU0AsumwaCotEajSz9vCijjzrPwkGdes=;
 b=mcAI4uJvSCIKV40an2oPP49EFPxzm/o0b0eyjSDkaN36HRH3WScE1V7NDtoo4143W3
 Syi6wWxyZEQIB8p3Lp4vTVZeu2lMpaFcuof7Uk8eD/4vyRDagi+YuOEXgloPI/O2em1u
 zSOh/wZZlvs64TtkZDMtnhl4LPfROYJRlrwWQy5Y6He4fGlJEsTpbPvLeb5c+rOIs45A
 U6U3pmAvHAVIVs/IR8hrKcaI81OXPZ5kzIpYOi6IAD02f5q/tYLIuNWOAfQzVhAr9wwc
 9DbC3ic6DBfTHoDQEMJxZqHwcN9Kk4lKo6zvw6reYzprY77tNzGJya/cwSxAr/smPWr2
 hkvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEVXcxz47qKVK/VivwBkQ+geqB4jiH30rOEEOm/iHViS2bHkv062PywNU87rDu9cmPiUa5gXXzkV0Q@nongnu.org
X-Gm-Message-State: AOJu0YyisrsWM0mVTkjG9SrgdqerzYlPSpIZlEH8ziAsqpJ0OYOQMWKc
 gw4INyJcvmZjAQGKMk6aM/QO8hBU8KFnWXQooO6XJ+hbFVNB4WTDf+ZTox050ZNqAT54plWK9pD
 sK1hOdbQ+w6hOvYDLXkrQX9hQaFmgY+XEGy+8YMowdIYqa7Ix0+1ep/h54Cn+
X-Gm-Gg: ASbGncsn0QPv3ANpP2657TikE2tn12e1tlnEvUW8IOaTSjc5X+cazfCvh3Oz9CBvloS
 9YFOxsSv+CQ4PgKu+XSamc2h+owi1B9PiPmlKsrJp2aHD7X5lB/5povkGLYuhZJCdtHiak8aOFc
 mxOBPUVGzGaTFcsESSEu35PkvTLVgr/o7DkQ5Qx5IWPpdYSN7VpueqLerviP6n6rxyoqqCUzpnP
 9hf2/4sU+eNVe4lbiPaDN3qkEFWPurkpTl5FSrMXSFC2HXAeB4Z7RO0ApeDoDA3tGwyXkkua0lL
 ltLAoVxf+g==
X-Received: by 2002:a05:6402:1eca:b0:5d6:688d:b683 with SMTP id
 4fb4d7f45d1cf-5d972e0b18bmr45180726a12.9.1736750235815; 
 Sun, 12 Jan 2025 22:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVjH8+in5YM/mnNsAUQxiBmawaw+MTia5QwAxB4281Y7y95d03nFALyELizycZ6F/b6YoIjw==
X-Received: by 2002:a05:6402:1eca:b0:5d6:688d:b683 with SMTP id
 4fb4d7f45d1cf-5d972e0b18bmr45180503a12.9.1736750234482; 
 Sun, 12 Jan 2025 22:37:14 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-16.web.vodafone.de. [109.42.48.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dc570sm464677766b.51.2025.01.12.22.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 22:37:13 -0800 (PST)
Message-ID: <ed6ea1e9-ade1-4c24-b151-803e141e4b26@redhat.com>
Date: Mon, 13 Jan 2025 07:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] s390x: Fix CSS migration
To: Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
References: <20250109185249.23952-1-farosas@suse.de>
 <20250109185249.23952-8-farosas@suse.de>
 <a23bf1a7-70fc-46d0-b465-6e9851feb669@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a23bf1a7-70fc-46d0-b465-6e9851feb669@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/01/2025 15.34, Michael Tokarev wrote:
> 09.01.2025 21:52, Fabiano Rosas wrote:
>> Commit a55ae46683 ("s390: move css_migration_enabled from machine to
>> css.c") disabled CSS migration globally instead of doing it
>> per-instance.
>>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: qemu-stable@nongnu.org #9.1
>> Fixes: a55ae46683 ("s390: move css_migration_enabled from machine to css.c")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2704
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Message-Id: <20241213160120.23880-3-farosas@suse.de>
> 
> And this one causes s390x-migration-test failure on 9.2 on s390x.
> While this test succeeds on x86_64.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8829799108
> 
> Help? :)

That looks like the script error that should be fixed by patch 3/7, I think? 
You likely need that patch, too...

  Thomas


