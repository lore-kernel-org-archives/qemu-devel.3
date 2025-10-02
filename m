Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBCFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DKu-0004VB-W7; Thu, 02 Oct 2025 03:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v4DKq-0004Ub-SU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v4DKS-0003hm-QW
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759388529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fh1w6jQj2yhIwFSGJIvoSaCCo940qfXGO1W2RbfS63s=;
 b=S5oxQAIqQbRqmjZ1Q2Jn7rQ8xFcYDc/S4wcRsfsX0I6JPtEdk7fyn3jz9COP5/j1cROgcm
 B3psQfyNPsTxF4Ud16e6j/GYZ6qMJQiN05MINsdguuWg7bllxgyy/VPeQ3unFhfXUJm9z9
 Lf5CAh3rH7g4tGWyd3cADAGVQuP2Fk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-aTIj4NevMyqC4cMQiLHZdg-1; Thu, 02 Oct 2025 03:02:07 -0400
X-MC-Unique: aTIj4NevMyqC4cMQiLHZdg-1
X-Mimecast-MFC-AGG-ID: aTIj4NevMyqC4cMQiLHZdg_1759388526
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e375dab7dso2179965e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 00:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759388526; x=1759993326;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fh1w6jQj2yhIwFSGJIvoSaCCo940qfXGO1W2RbfS63s=;
 b=XrO+N0i0zBy5wWfb3DrPokOv6eLOeTbE6ZnlKUxT8HokfriVxlXFQbLsYADGxRxuu+
 zhNbo6xBX8z/geRQPWp9Pc6t75nH+8lU+HW5RbbncSeq9Wl6ZgNyPtfYLJRRkExFFIhG
 u3TO8KGFeBGrL/KWfHjduUFMq/iWjw1ZYFW5+pNlH3VXAlPSDh7Dyx1zl6A/LSib+RUX
 QzjRXUEqQzcxRlIVoXg2Pds2Tz3UDrkvx487U9P+Aw+jjY+Rd7HjgTGReAuO9psGbEnA
 rNuwL/jxm+esXEemdudvTXAjHBUYYn+lSGWz9X9mZ1dq08VhpuGng8w9mbNPQ/Prgkto
 svUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXom9e2wY1LnEOjrmLfrEM8JJx/AY+/6Z+XD0eL1m33GCl3/WpmXVrPQkqob8pu7Gio+Z/imeRRVBzX@nongnu.org
X-Gm-Message-State: AOJu0YyZTdN6R4qJHXmt7ogNHjn4PZo6D41dc9gTE6zmBLtp1DECJs5y
 tjD531Ya3Lag7hfx1Uq1AAafOtFU7+KhxlTyeyz5UORm4Nbfd/z9exm5Kxrm87umYSQjugC/fJj
 B65sI+IFs3B3hnFu7mMMsmTQP60w8qLBo/1LAQ7hCMbPJRQDWUOWIW/L7
X-Gm-Gg: ASbGncuAYUjubT4rzbeqsTo24+KUhUspwkHKWWANY+0yAH9qyG2fdkaT/ZCkDL9ocux
 r8KLFIANi4ogxAHcLiL3KPlseSyljSkvvBpuUWhLHhe3pgureO4UqecsQj5bgyoBNdidmREFEzf
 TUQ7/7aUxf3lmd/zZYK3I+g12T7KGqAnnDP7NRj5S14oeRdnCLpxnoT8w1GjsA2ZDspdh5IYw5j
 ZyxCuoTDgWXTZ3UKZcGC/xUV6VMPBKoHAVUjF1THmL6rucHZZ3QZRygZtmOEN3H8rGat+Uyt3L3
 Y7KwSpmdxcu7nD7eI2Mm4GZH1C/VaG1migA62cqaAqmJ9UzxJcMovJJd7NWtSLMV1r+1Bd3TvSb
 2UO7D3zaKDg==
X-Received: by 2002:a05:600c:6306:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-46e6129524cmr51639615e9.36.1759388525730; 
 Thu, 02 Oct 2025 00:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJqk+ThviJLmKRwkCHp0ruttBDyiVTVz75mp0sbd2cQk3IKj8vzDBY4jsWggJ7uHmgu1UENQ==
X-Received: by 2002:a05:600c:6306:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-46e6129524cmr51638865e9.36.1759388524696; 
 Thu, 02 Oct 2025 00:02:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm67423245e9.7.2025.10.02.00.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 00:02:04 -0700 (PDT)
Message-ID: <08c481e1-bb2a-4313-951a-5bcb0f96a597@redhat.com>
Date: Thu, 2 Oct 2025 09:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 4/5] ui/sdl2: fix reset scaling binding to be consistent
 with gtk
To: Michael Tokarev <mjt@tls.msk.ru>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Nir Lichtman <nir@lichtman.org>
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
 <20250930075559.133650-5-marcandre.lureau@redhat.com>
 <24ae77e7-414b-4c19-8d7f-f21ca3fef2f4@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <24ae77e7-414b-4c19-8d7f-f21ca3fef2f4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/10/2025 22.11, Michael Tokarev wrote:
> On 9/30/25 10:55, marcandre.lureau@redhat.com wrote:
>> From: Nir Lichtman <nir@lichtman.org>
>>
>> Problem: Currently the reset scaling hotkey is inconsistent between SDL
>> and GTK graphics modes.
>>
>> Solution: Fix SDL to use MOD+0 instead of MOD+u which is in line with
>> GTK and generally more consistent with other apps.
>>
>> This is also related to my previously sent patch fixing the docs.
>>
>> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Nir Lichtman <nir@lichtman.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20250910114929.GA1783677@lichtman.org>
>> ---
>>   ui/sdl2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index b00e421f7f..032dc14bc3 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -421,7 +421,7 @@ static void handle_keydown(SDL_Event *ev)
>>                   sdl_grab_end(scon);
>>               }
>>               break;
>> -        case SDL_SCANCODE_U:
>> +        case SDL_SCANCODE_0:
> 
> Can't we keep the old behavior too, for a release or two maybe?

It's already merge, so please send a new patch for this.

  Thomas


