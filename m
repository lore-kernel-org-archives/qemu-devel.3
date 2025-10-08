Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B91CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wp6-0001zx-HT; Wed, 08 Oct 2025 12:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6Wp3-0001z5-H2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6Wot-0004nE-46
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759940100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exgIduDTPrRAOwFMANoxlhxBxS2XiK+uKbQ9vb67kBQ=;
 b=QzWCn5BDtwoqKXqEF83npsRdlCxH/GE2HbgMDn0wRvpDDQr64qjXgZ+82FN7OV/7UQIIK1
 n9VOlrF2J2KbXFRBaLaF+00sSHh4wRg/0gFm7rh9GBka34f9GZ3FMSR+9LemsYntL+KQMJ
 mlQozYz0iXJYzfRil9RczehyRkPIZvM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fz6Gy7zCNG6JHTKOjfHBKA-1; Wed, 08 Oct 2025 12:14:56 -0400
X-MC-Unique: fz6Gy7zCNG6JHTKOjfHBKA-1
X-Mimecast-MFC-AGG-ID: fz6Gy7zCNG6JHTKOjfHBKA_1759940096
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-639f0b76969so298688a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759940095; x=1760544895;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exgIduDTPrRAOwFMANoxlhxBxS2XiK+uKbQ9vb67kBQ=;
 b=LGeP8cszigiay0yVIUnVBQiCHb4v6bHiKrEEIt+87F+dgqRz3ElCStH5XWy50BS3kE
 3vR7UWe7CO9LO/VKEM5vrbi5AVy+sw1pRHIDkLdQu8tYkxOaTofP7splcaBBIuJOlKHN
 jq1LzzoIxT+8rkQeoW6AiiO3g10Xj/5M9QenO2zIusocz6BObOpxYfT6SpVXaxyxIW5a
 XMOrj9N+cXGYMS0xWVPdp3N8ETfhgNY1mHKHefnAT77BxT01SlLbuAxQvxY0U2NCiJlp
 A9u1du1xERM6IAbZSbb/NUA4anAppYie9B0AiOEg8GdvhDBL4FiyVJz0fqg+RrixS+NZ
 wmng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4CQkAoEErW+ABFm3EZHLTm3gcOMVJ6SmgMeL7K6CVJ08Gm30oDv4+BTpp0FRuYXV3c0zp6h7FNHLb@nongnu.org
X-Gm-Message-State: AOJu0YxWdFOnV9Drr/m0Htndju7XreS6+lNe9d9ti/c9dVUG/RxQKDTw
 hTud7ipihS8e4xwbv8RKlKeXnjLqU8VKsJokb1An3+RPK3NgpHWCJAe2NOcMg1h+EWgKRpIL3Nl
 5iclZM8tMfZ3HnEEzjE1uR8PDlBOaAx3n65QwAfdGzRjpGU3rBE5DZKT4
X-Gm-Gg: ASbGncsn2MzwCaIe9bN5x7WZ7rJ9dLMsZfJ+NIDm2byeKfetUL3/xB+1jtnXr+X1lik
 dvkubE0b/UALFKJW0171b7UmC2zrvU1GqDUkUrMXUAjwkQBVP1JyutTD5AA2cjn3C9089JARCeb
 YA8nTLaktHI55n2g6Cv57Gm+cK53HPMkrBGbY3/7FnX1KpNQTT4YxFclLFbiAkJ9xwh3Jx7vh06
 OBUGas/pEyCZkudMj5n6GNMQsMb3M8VVdHkuAxINwki7nS/ZqWvEFSCH5h+TdAu/NyIyWK9JmYR
 aHlGjwsSeJk8Au8tmsvRBy99H132zBRR6dyey1GKMY0WlyH8ULXvfFtVgDgMO3Zhmtajoypvza/
 vdM6XRSqMgZ+Jiy5x5WIg5+Fy+jg69bz+bsfRI+nOOQ+ZDfH4
X-Received: by 2002:a05:6402:210d:b0:639:e9a4:a5f1 with SMTP id
 4fb4d7f45d1cf-639e9a4c39amr1557919a12.27.1759940095571; 
 Wed, 08 Oct 2025 09:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjG66ETXj7V3lBFe5SpPahdUgDmb+KV/0G1JtxvV5hynjmHwH4Q+I2urR+a962RPEUGCuIWw==
X-Received: by 2002:a05:6402:210d:b0:639:e9a4:a5f1 with SMTP id
 4fb4d7f45d1cf-639e9a4c39amr1557885a12.27.1759940095134; 
 Wed, 08 Oct 2025 09:14:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-639f40ec50bsm319386a12.37.2025.10.08.09.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 09:14:54 -0700 (PDT)
Message-ID: <19ec9e38-8b34-420e-ade7-f82e9e7f5969@redhat.com>
Date: Wed, 8 Oct 2025 18:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qobject: make refcount atomic
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251008152701.411964-1-pbonzini@redhat.com>
 <50578062-8b7a-4286-a154-eebf05f3be3c@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <50578062-8b7a-4286-a154-eebf05f3be3c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/8/25 18:06, Richard Henderson wrote:
> On 10/8/25 08:27, Paolo Bonzini wrote:
>> @@ -95,7 +96,7 @@ void qobject_destroy(QObject *obj);
>>   static inline void qobject_unref_impl(QObject *obj)
>>   {
>>       assert(!obj || obj->base.refcnt);
>> -    if (obj && --obj->base.refcnt == 0) {
>> +    if (obj && qatomic_fetch_dec(&obj->base.refcnt) == 1) {
> 
> qatomic_dec_fetch lets you compare against 0, which makes all isa's 
> happier.

Happy to change all fetch_decs to dec_fetches, but wouldn't the compiler 
be able to change one to the other?

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

Paolo


